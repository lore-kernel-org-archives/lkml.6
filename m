Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeCWGck (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 02:32:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36019 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWGci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 02:32:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Aleksa Sarai <asarai@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org
References: <20180323060457.sxgsd3j2obi33fyw@gordon>
Date: Fri, 23 Mar 2018 01:31:41 -0500
In-Reply-To: <20180323060457.sxgsd3j2obi33fyw@gordon> (Aleksa Sarai's message
        of "Fri, 23 Mar 2018 17:04:57 +1100")
Message-ID: <87k1u3ti9e.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezGFh-0005xE-03;;;mid=<87k1u3ti9e.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wer6u0iKlhL7AcH1jsFc1GI/WurnL4Ys=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Aleksa Sarai <asarai@suse.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 221 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (2.0%), b_tie_ro: 3.3 (1.5%), parse: 1.07 (0.5%),
        extract_message_metadata: 15 (7.0%), get_uri_detail_list: 2.1 (1.0%),
        tests_pri_-1000: 6 (2.9%), tests_pri_-950: 1.07 (0.5%), tests_pri_-900: 0.88
        (0.4%), tests_pri_-400: 23 (10.2%), check_bayes: 22 (9.8%), b_tokenize: 6
        (2.5%), b_tok_get_all: 8 (3.7%), b_comp_prob: 1.73 (0.8%), b_tok_touch_all:
        3.6 (1.6%), b_finish: 0.79 (0.4%), tests_pri_0: 161 (73.2%),
        check_dkim_signature: 0.40 (0.2%), check_dkim_adsp: 3.2 (1.4%),
        tests_pri_500: 4.0 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REGRESSION v4.16-rc6] [PATCH] mqueue: forbid unprivileged user access to internal mount
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksa Sarai <asarai@suse.de> writes:

> Hi all,
>
> Felix reported weird behaviour on 4.16.0-rc6 with regards to mqueue[1],
> which was introduced by 36735a6a2b5e ("mqueue: switch to on-demand
> creation of internal mount").
>
> Basically, the reproducer boils down to being able to mount mqueue if
> you create a new user namespace, even if you don't unshare the IPC
> namespace.
>
> Previously this was not possible, and you would get an -EPERM. The mount
> is the *host* mqueue mount, which is being cached and just returned from
> mqueue_mount(). To be honest, I'm not sure if this is safe or not (or if
> it was intentional -- since I'm not familiar with mqueue).
>
> To me it looks like there is a missing permission check. I've included a
> patch below that I've compile-tested, and should block the above case.
> Can someone please tell me if I'm missing something? Is this actually
> safe?

I think it may be safe by luck.  If mqueuefs had any mount options this
would allow them to be changed.  

Looking at the code there is another issue. sb->s_user_ns is getting
set to &init_user_ns instead of ns->user_ns.  That will cause other
operations to fail like mount -o remount to fail that should not.

So I think the fix needs a little more work.

Eric




>
> [1]: https://github.com/docker/docker/issues/36674
>
> --8<--------------------------------------------------------------------
>
> Fix a regression caused by 36735a6a2b5e ("mqueue: switch to on-demand
> creation of internal mount"), where an unprivileged user is permitted to
> mount mqueue even if they don't have CAP_SYS_ADMIN in the ipcns's
> associated userns. This can be reproduced as in the following.
>
>   % unshare -Urm                       # ipc isn't unshare'd
>   # mount -t mqueue mqueue /dev/mqueue # should have failed
>   # echo $?
>   0
>
> Previously the above would error out with an -EPERM, as the mount was
> protected by mount_ns(), but the patch in question switched to
> kern_mount_data() which doesn't do this necessary permission check. So
> add it explicitly to mq_internal_mount().
>
> Fixes: 36735a6a2b5e ("mqueue: switch to on-demand creation of internal mount")
> Reported-by: Felix Abecassis <fabecassis@nvidia.com>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>
> ---
>  ipc/mqueue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index d7f309f74dec..ddb85091398d 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -353,6 +353,12 @@ static struct vfsmount *mq_internal_mount(void)
>  {
>  	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
>  	struct vfsmount *m = ns->mq_mnt;
> +	/*
> +	 * Match the semantics of mount_ns, to avoid unprivileged users from being
> +	 * able to mount mqueue from an IPC namespace they don't have ownership of.
> +	 */
> +	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
> +		return ERR_PTR(-EPERM);
>  	if (m)
>  		return m;
>  	m = kern_mount_data(&mqueue_fs_type, ns);
> -- 
> 2.16.2
