Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeEBOtb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:49:31 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53450 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeEBOt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:49:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
Date: Wed, 02 May 2018 09:45:30 -0500
In-Reply-To: <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
        (Mimi Zohar's message of "Thu, 12 Apr 2018 18:41:50 -0400")
Message-ID: <87h8nqglpx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDt2P-0001V2-IZ;;;mid=<87h8nqglpx.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19HUl1dxhN65w7xXBUwMNRlsYBVIPVmL6E=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2220 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.8 (0.2%), b_tie_ro: 2.5 (0.1%), parse: 1.51 (0.1%),
        extract_message_metadata: 6 (0.2%), get_uri_detail_list: 2.5 (0.1%),
        tests_pri_-1000: 6 (0.3%), tests_pri_-950: 1.95 (0.1%), tests_pri_-900: 1.59
        (0.1%), tests_pri_-400: 23 (1.0%), check_bayes: 21 (1.0%), b_tokenize: 6
        (0.3%), b_tok_get_all: 7 (0.3%), b_comp_prob: 2.1 (0.1%), b_tok_touch_all:
        3.3 (0.1%), b_finish: 0.59 (0.0%), tests_pri_0: 2160 (97.3%),
        check_dkim_signature: 0.50 (0.0%), check_dkim_adsp: 2006 (90.3%),
        tests_pri_500: 4.0 (0.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> Allow LSMs and IMA to differentiate between the kexec_load and
> kexec_file_load syscalls by adding an "unnecessary" call to
> security_kernel_read_file() in kexec_load.  This would be similar to the
> existing init_module syscall calling security_kernel_read_file().

Given the reasonable desire to load a policy that ensures everything
has a signature I don't have fundamental objections.

security_kernel_read_file as a hook seems an odd choice.  At the very
least it has a bad name because there is no file reading going on here.

I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
anywhere.  Which means I could have a kernel compiled without that and I
would be allowed to use kexec_file_load without signature checking.
While kexec_load would be denied.

Am I missing something here?

Eric



> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  kernel/kexec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..d1386cfc6796 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -11,6 +11,7 @@
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> +#include <linux/security.h>
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -195,11 +196,21 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
> +	int result;
> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
>  	/*
> +	 * Allow LSMs and IMA to differentiate between kexec_load and
> +	 * kexec_file_load syscalls.
> +	 */
> +	result = security_kernel_read_file(NULL, READING_KEXEC_IMAGE);
> +	if (result < 0)
> +		return result;
> +
> +	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
>  	 */
