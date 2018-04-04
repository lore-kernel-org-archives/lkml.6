Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeDDQEH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:04:07 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39321 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeDDQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:04:04 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Angel Shtilianov <kernel@kyup.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <1522408620-10578-1-git-send-email-kernel@kyup.com>
Date: Wed, 04 Apr 2018 11:02:40 -0500
In-Reply-To: <1522408620-10578-1-git-send-email-kernel@kyup.com> (Angel
        Shtilianov's message of "Fri, 30 Mar 2018 14:17:00 +0300")
Message-ID: <87vad7hsdb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3kt2-0005Og-03;;;mid=<87vad7hsdb.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18eXVSa/iqf+M6TASb5csBe0wroVoQ4+1E=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4080]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Angel Shtilianov <kernel@kyup.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15023 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 2.7 (0.0%), b_tie_ro: 1.76 (0.0%), parse: 0.83 (0.0%),
        extract_message_metadata: 12 (0.1%), get_uri_detail_list: 1.80 (0.0%),
        tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.45 (0.0%), tests_pri_-900:
        1.03 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.2%), b_tokenize: 7
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.4 (0.0%), b_tok_touch_all:
        2.7 (0.0%), b_finish: 0.63 (0.0%), tests_pri_0: 245 (1.6%),
        check_dkim_signature: 0.80 (0.0%), check_dkim_adsp: 4.6 (0.0%),
        tests_pri_500: 14730 (98.1%), poll_dns_idle: 14721 (98.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] uts_namespace: Move boot_id in uts namespace
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Angel Shtilianov <kernel@kyup.com> writes:

> Currently the same boot_id is reported for all containers running
> on a host node, including the host node itself. Even after restarting
> a container it will still have the same persistent boot_id.
>
> This can cause troubles in cases where you have multiple containers
> from the same cluster on one host node. The software inside each
> container will get the same boot_id and thus fail to join the cluster,
> after the first container from the node has already joined.
>
> UTS namespace on other hand keeps the machine specific data, so it
> seems to be the correct place to move the boot_id and instantiate it,
> so each container will have unique id for its own boot lifetime, if
> it has its own uts namespace.

Technically this really needs to use the sysctl infrastructure that
allows you to register different files in different namespaces.  That
way the value you read from proc_do_uuid will be based on who opens the
file not on who is reading the file.

Practically why does a bind mount on top of boot_id work?  What makes
this a general problem worth solving in the kernel?  Why is hiding the
fact that you are running the same instance of the same kernel a useful
thing? That is the reality.

Eric




> Signed-off-by: Angel Shtilianov <kernel@kyup.com>
> ---
>  drivers/char/random.c   | 4 ++++
>  include/linux/utsname.h | 1 +
>  kernel/utsname.c        | 4 +++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index ec42c8bb9b0d..e05daf7f38f4 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1960,6 +1960,10 @@ static int proc_do_uuid(struct ctl_table *table, int write,
>  	unsigned char buf[64], tmp_uuid[16], *uuid;
>  
>  	uuid = table->data;
> +#ifdef CONFIG_UTS_NS
> +	if (!!uuid && (uuid == (unsigned char *)sysctl_bootid))
> +		uuid = current->nsproxy->uts_ns->sysctl_bootid;
> +#endif
>  	if (!uuid) {
>  		uuid = tmp_uuid;
>  		generate_random_uuid(uuid);
> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index c8060c2ecd04..f704aca3e95a 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -27,6 +27,7 @@ struct uts_namespace {
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;
>  	struct ns_common ns;
> +	char sysctl_bootid[16];
>  } __randomize_layout;
>  extern struct uts_namespace init_uts_ns;
>  
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index 913fe4336d2b..f1749cdcd341 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -34,8 +34,10 @@ static struct uts_namespace *create_uts_ns(void)
>  	struct uts_namespace *uts_ns;
>  
>  	uts_ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
> -	if (uts_ns)
> +	if (uts_ns) {
>  		kref_init(&uts_ns->kref);
> +		memset(uts_ns->sysctl_bootid, 0, 16);
> +	}
>  	return uts_ns;
>  }
