Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeCMSSN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:18:13 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54219 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCMSSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:18:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
        <1520885744-1546-5-git-send-email-longman@redhat.com>
Date: Tue, 13 Mar 2018 13:17:24 -0500
In-Reply-To: <1520885744-1546-5-git-send-email-longman@redhat.com> (Waiman
        Long's message of "Mon, 12 Mar 2018 16:15:42 -0400")
Message-ID: <87woyfyh57.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evoV0-000744-AL;;;mid=<87woyfyh57.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Z3h07KzWNo676YgUpyelNMkFe4GKA+xc=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Waiman Long <longman@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 184 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.7 (1.5%), b_tie_ro: 1.96 (1.1%), parse: 0.74 (0.4%),
        extract_message_metadata: 2.8 (1.5%), get_uri_detail_list: 1.24 (0.7%),
        tests_pri_-1000: 3.3 (1.8%), tests_pri_-950: 1.02 (0.6%), tests_pri_-900:
        0.82 (0.4%), tests_pri_-400: 19 (10.5%), check_bayes: 18 (10.0%), b_tokenize:
        6 (3.0%), b_tok_get_all: 6 (3.1%), b_comp_prob: 1.87 (1.0%), b_tok_touch_all:
        2.7 (1.5%), b_finish: 0.66 (0.4%), tests_pri_0: 144 (78.0%),
        check_dkim_signature: 0.50 (0.3%), check_dkim_adsp: 2.8 (1.5%),
        tests_pri_500: 3.2 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 4/6] ipc: Clamp msgmni and shmmni to the real IPCMNI limit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> A user can write arbitrary integer values to msgmni and shmmni sysctl
> parameters without getting error, but the actual limit is really
> IPCMNI (32k). This can mislead users as they think they can get a
> value that is not real.
>
> Enforcing the limit by failing the sysctl parameter write, however,
> can break existing user applications.

Which applications examples please.

I am seeing this patchset late but it looks like a whole lot of changes
to avoid a theoretical possibility.

Changes that have an impact on more than just the ipc code you are
patching.

That makes me feel very uncomfortable with these changes.

Eric


> Instead, the range clamping flag
> is set to enforce the limit without failing existing user code. Users
> can easily figure out if the sysctl parameter value is out of range
> by either reading back the parameter value or checking the kernel
> ring buffer for warning.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  ipc/ipc_sysctl.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 8ad93c2..1955dd4 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  static int zero;
>  static int one = 1;
>  static int int_max = INT_MAX;
> +static int ipc_mni = IPCMNI;
>  
>  static struct ctl_table ipc_kern_table[] = {
>  	{
> @@ -120,7 +121,10 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  		.data		= &init_ipc_ns.shm_ctlmni,
>  		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
>  		.mode		= 0644,
> -		.proc_handler	= proc_ipc_dointvec,
> +		.proc_handler	= proc_ipc_dointvec_minmax,
> +		.extra1		= &zero,
> +		.extra2		= &ipc_mni,
> +		.flags		= CTL_FLAGS_CLAMP_RANGE,
>  	},
>  	{
>  		.procname	= "shm_rmid_forced",
> @@ -147,7 +151,8 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  		.mode		= 0644,
>  		.proc_handler	= proc_ipc_dointvec_minmax,
>  		.extra1		= &zero,
> -		.extra2		= &int_max,
> +		.extra2		= &ipc_mni,
> +		.flags		= CTL_FLAGS_CLAMP_RANGE,
>  	},
>  	{
>  		.procname	= "auto_msgmni",
