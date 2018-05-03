Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeECVjI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:39:08 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46412 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeECVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:39:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <87r2mso5up.fsf@xmission.com>
        <1525383075.3539.67.camel@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 16:38:57 -0500
In-Reply-To: <1525383075.3539.67.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Thu, 03 May 2018 17:31:15 -0400")
Message-ID: <87d0yco1vy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fELwO-0004TR-Co;;;mid=<87d0yco1vy.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++UOxjXLvcp8fRHH8jwfJ5jZXTJVAA6Co=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4978]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 237 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (1.0%), b_tie_ro: 1.70 (0.7%), parse: 0.84 (0.4%),
        extract_message_metadata: 3.3 (1.4%), get_uri_detail_list: 1.59 (0.7%),
        tests_pri_-1000: 3.6 (1.5%), tests_pri_-950: 1.19 (0.5%), tests_pri_-900:
        0.99 (0.4%), tests_pri_-400: 23 (9.8%), check_bayes: 22 (9.4%), b_tokenize: 7
        (2.9%), b_tok_get_all: 7 (3.1%), b_comp_prob: 2.6 (1.1%), b_tok_touch_all:
        3.2 (1.3%), b_finish: 0.66 (0.3%), tests_pri_0: 190 (80.0%),
        check_dkim_signature: 0.71 (0.3%), check_dkim_adsp: 2.4 (1.0%),
        tests_pri_500: 4.6 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> [Cc'ing Kees and kernel-hardening]
>
> On Thu, 2018-05-03 at 15:13 -0500, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > In environments that require the kexec kernel image to be signed, prevent
>> > using the kexec_load syscall.  In order for LSMs and IMA to differentiate
>> > between kexec_load and kexec_file_load syscalls, this patch set adds a
>> > call to security_kernel_read_file() in kexec_load_check().
>> 
>> Having thought about it some more this justification for these changes
>> does not work.  The functionality of kexec_load is already root-only.
>> So in environments that require the kernel image to be signed just don't
>> use kexec_load.  Possibly even compile kexec_load out to save space
>> because you will never need it.  You don't need a new security hook to
>> do any of that.  Userspace is a very fine mechanism for being the
>> instrument of policy.
>
> True, for those building their own kernel, they can disable the old
> syscalls.  The concern is not for those building their own kernels,
> but for those using stock kernels.  
>
> By adding an LSM hook here in the kexec_load syscall, as opposed to an
> IMA specific hook, other LSMs can piggy back on top of it.  Currently,
> both load_pin and SELinux are gating the kernel module syscalls based
> on security_kernel_read_file.
>
> If there was a similar option for the kernel image, I'm pretty sure
> other LSMs would use it.
>
> From an IMA perspective, there needs to be some method for only
> allowing signed code to be loaded, executed, etc. - kernel modules,
> kernel image/initramfs, firmware, policies.

What is the IMA perspective.  Why can't IMA trust appropriately
authorized userspace?

>> If you don't trust userspace that needs to be spelled out very clearly.
>> You need to talk about what your threat models are.
>> 
>> If the only justification is so that that we can't boot windows if
>> someone hacks into userspace it has my nack because that is another kind
>> of complete non-sense.
>
> The usecase is the ability to gate the kexec_load usage in stock
> kernels.

But kexec_load is already gated.  It requires CAP_SYS_BOOT.

>> Given that you are not trusting userspace this changeset also probably
>> needs to have the kernel-hardening list cc'd.  Because the only possible
>> justification I can imagine for something like this is kernel-hardening.
>
> Sure, Cc'ing linux-hardening and Kees.
>
> Mimi
