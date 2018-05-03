Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeECPvu convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:51:50 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53265 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeECPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:51:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
        <87h8nqglpx.fsf@xmission.com>
        <1525275904.5669.308.camel@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 10:51:38 -0500
In-Reply-To: <1525275904.5669.308.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Wed, 02 May 2018 11:45:04 -0400")
Message-ID: <87h8nospo5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fEGWG-0002zB-FU;;;mid=<87h8nospo5.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18slK0lIRJP4iUCxF6d4W1L9p1f/MWd4wU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 587 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.5%), b_tie_ro: 2.2 (0.4%), parse: 1.27 (0.2%),
        extract_message_metadata: 6 (1.0%), get_uri_detail_list: 2.8 (0.5%),
        tests_pri_-1000: 6 (1.1%), tests_pri_-950: 2.3 (0.4%), tests_pri_-900: 1.84
        (0.3%), tests_pri_-400: 32 (5.5%), check_bayes: 30 (5.1%), b_tokenize: 11
        (1.9%), b_tok_get_all: 7 (1.3%), b_comp_prob: 4.6 (0.8%), b_tok_touch_all:
        3.0 (0.5%), b_finish: 0.94 (0.2%), tests_pri_0: 504 (85.9%),
        check_dkim_signature: 0.96 (0.2%), check_dkim_adsp: 4.8 (0.8%),
        tests_pri_500: 10 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > Allow LSMs and IMA to differentiate between the kexec_load and
>> > kexec_file_load syscalls by adding an "unnecessary" call to
>> > security_kernel_read_file() in kexec_load.  This would be similar to the
>> > existing init_module syscall calling security_kernel_read_file().
>> 
>> Given the reasonable desire to load a policy that ensures everything
>> has a signature I don't have fundamental objections.
>> 
>> security_kernel_read_file as a hook seems an odd choice.  At the very
>> least it has a bad name because there is no file reading going on here.
>> 
>> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
>> anywhere.  Which means I could have a kernel compiled without that and I
>> would be allowed to use kexec_file_load without signature checking.
>> While kexec_load would be denied.
>> 
>> Am I missing something here?
>
> The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
> calls security_kernel_read_file().  So kexec_file_load and kexec_load
> syscall would be using the same method for enforcing signature
> verification.

Having looked at your patches and the kernel a little more I think
this should be a separate security hook that does not take a file
parameter.

Right now every other security module assumes !file is init_module.
So I think this change has the potential to confuse other security
modules, with the result of unintended policy being applied.

So just for good security module hygeine I think this needs a dedicated
kexec_load security hook.


> This is independent of the architecture specific method for verifying
> signatures.  The coordination between these two methods was included
> in the lockdown patch set, but is being removed, as well the gating of
> kexec_load syscall.  Instead of being based on the lockdown flag, I
> assume the coordination between the two methods will reappear based on
> a secure boot flag of some sort.

I was blind there for a moment.  Yes this is all about the ima xattrs
allowing a file to be loaded.

Eric
