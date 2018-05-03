Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeECQmV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:42:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37440 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:42:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
        <87h8nqglpx.fsf@xmission.com>
        <1525275904.5669.308.camel@linux.vnet.ibm.com>
        <87h8nospo5.fsf@xmission.com>
        <6203b1e4-70c3-6d0e-60e0-56c6e8f72ec9@schaufler-ca.com>
Date: Thu, 03 May 2018 11:42:09 -0500
In-Reply-To: <6203b1e4-70c3-6d0e-60e0-56c6e8f72ec9@schaufler-ca.com> (Casey
        Schaufler's message of "Thu, 3 May 2018 09:05:22 -0700")
Message-ID: <87y3h0pu72.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fEHJA-0007o3-04;;;mid=<87y3h0pu72.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18xNg2qnTXbQO+lHlIxWwW/u+bWyczQLhU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 255 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (1.0%), b_tie_ro: 1.72 (0.7%), parse: 1.05 (0.4%),
        extract_message_metadata: 13 (5.1%), get_uri_detail_list: 2.6 (1.0%),
        tests_pri_-1000: 4.7 (1.8%), tests_pri_-950: 1.24 (0.5%), tests_pri_-900:
        0.99 (0.4%), tests_pri_-400: 24 (9.5%), check_bayes: 23 (9.0%), b_tokenize: 8
        (2.9%), b_tok_get_all: 8 (3.0%), b_comp_prob: 2.7 (1.0%), b_tok_touch_all:
        3.1 (1.2%), b_finish: 0.64 (0.3%), tests_pri_0: 200 (78.4%),
        check_dkim_signature: 0.88 (0.3%), check_dkim_adsp: 2.7 (1.0%),
        tests_pri_500: 4.4 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 5/3/2018 8:51 AM, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>
>>> On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
>>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>>>>
>>>>> Allow LSMs and IMA to differentiate between the kexec_load and
>>>>> kexec_file_load syscalls by adding an "unnecessary" call to
>>>>> security_kernel_read_file() in kexec_load.  This would be similar to the
>>>>> existing init_module syscall calling security_kernel_read_file().
>>>> Given the reasonable desire to load a policy that ensures everything
>>>> has a signature I don't have fundamental objections.
>>>>
>>>> security_kernel_read_file as a hook seems an odd choice.  At the very
>>>> least it has a bad name because there is no file reading going on here.
>>>>
>>>> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
>>>> anywhere.  Which means I could have a kernel compiled without that and I
>>>> would be allowed to use kexec_file_load without signature checking.
>>>> While kexec_load would be denied.
>>>>
>>>> Am I missing something here?
>>> The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
>>> calls security_kernel_read_file().  So kexec_file_load and kexec_load
>>> syscall would be using the same method for enforcing signature
>>> verification.
>> Having looked at your patches and the kernel a little more I think
>> this should be a separate security hook that does not take a file
>> parameter.
>>
>> Right now every other security module assumes !file is init_module.
>> So I think this change has the potential to confuse other security
>> modules, with the result of unintended policy being applied.
>>
>> So just for good security module hygeine I think this needs a dedicated
>> kexec_load security hook.
>
> I would rather see the existing modules updated than a new
> hook added. Too many hooks spoil the broth. Two hooks with
> trivial differences just add to the clutter and make it harder
> for non-lsm developers to figure out what to use in their
> code.

These are not non-trivial differences.  There is absolutely nothing
file related about kexec_load.  Nor for init_module for that matter.

If something is called security_kernel_read_file I think it is wholly
appropriate for code that processes such a hook to assume file is
non-NULL.

When you have to dance a jig (which is what I see the security modules
doing) to figure out who is calling a lsm hook for what purpose I think
it is a maintenance problem waiting to happen and that the hook is badly
designed.

At this point I don't care what the lsm's do with the hooks but the
hooks need to make sense for people outside of the lsm's and something
about reading a file in a syscall that doesn't read files is complete
and utter nonsense.

Eric
