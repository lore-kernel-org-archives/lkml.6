Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeECUNa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:13:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33106 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeECUN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:13:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 15:13:18 -0500
In-Reply-To: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        (Mimi Zohar's message of "Thu, 12 Apr 2018 18:41:48 -0400")
Message-ID: <87r2mso5up.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEKbU-0007wU-Td;;;mid=<87r2mso5up.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/6Ryln6R8w/xBngIvdzzD8+5XJ13cTIa8=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4903]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 213 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.5 (1.2%), b_tie_ro: 1.68 (0.8%), parse: 0.71 (0.3%),
        extract_message_metadata: 2.5 (1.2%), get_uri_detail_list: 0.93 (0.4%),
        tests_pri_-1000: 3.5 (1.7%), tests_pri_-950: 1.20 (0.6%), tests_pri_-900:
        0.96 (0.5%), tests_pri_-400: 19 (8.8%), check_bayes: 18 (8.4%), b_tokenize:
        4.9 (2.3%), b_tok_get_all: 7 (3.2%), b_comp_prob: 1.71 (0.8%),
        b_tok_touch_all: 2.2 (1.0%), b_finish: 0.50 (0.2%), tests_pri_0: 170 (79.9%),
        check_dkim_signature: 0.75 (0.4%), check_dkim_adsp: 3.6 (1.7%),
        tests_pri_500: 5 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> In environments that require the kexec kernel image to be signed, prevent
> using the kexec_load syscall.  In order for LSMs and IMA to differentiate
> between kexec_load and kexec_file_load syscalls, this patch set adds a
> call to security_kernel_read_file() in kexec_load_check().

Having thought about it some more this justification for these changes
does not work.  The functionality of kexec_load is already root-only.
So in environments that require the kernel image to be signed just don't
use kexec_load.  Possibly even compile kexec_load out to save space
because you will never need it.  You don't need a new security hook to
do any of that.  Userspace is a very fine mechanism for being the
instrument of policy.

If you don't trust userspace that needs to be spelled out very clearly.
You need to talk about what your threat models are.

If the only justification is so that that we can't boot windows if
someone hacks into userspace it has my nack because that is another kind
of complete non-sense.

Given that you are not trusting userspace this changeset also probably
needs to have the kernel-hardening list cc'd.  Because the only possible
justification I can imagine for something like this is kernel-hardening.

Eric
