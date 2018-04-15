Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDOQAq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 12:00:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48649 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDOQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 12:00:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        <linux-arch@vger.kernel.org>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
        <20180412172051.GK16141@n2100.armlinux.org.uk>
        <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
        <20180413094211.GN16141@n2100.armlinux.org.uk>
        <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
        <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
        <87604sa2fu.fsf_-_@xmission.com>
Date: Sun, 15 Apr 2018 10:59:09 -0500
In-Reply-To: <87604sa2fu.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Sun, 15 Apr 2018 10:56:21 -0500")
Message-ID: <87muy48nqq.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f7k4q-0006e6-2i;;;mid=<87muy48nqq.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/1TXbHRQ/NgjXC1GqqK3+craTezWqgpgc=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15022 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (0.0%), b_tie_ro: 1.90 (0.0%), parse: 0.77 (0.0%),
        extract_message_metadata: 9 (0.1%), get_uri_detail_list: 1.08 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.17 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 19 (0.1%), check_bayes: 18 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.69 (0.0%), b_tok_touch_all:
        2.3 (0.0%), b_finish: 0.56 (0.0%), tests_pri_0: 147 (1.0%),
        check_dkim_signature: 0.46 (0.0%), check_dkim_adsp: 3.2 (0.0%),
        tests_pri_500: 14836 (98.8%), poll_dns_idle: 14827 (98.7%), rewrite_mail:
        0.00 (0.0%)
Subject: [RFC PATCH 3/3] signal: Stop special casing TRAP_FIXME and FPE_FIXME in siginfo_layout
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


After more experience with the cases where no one the si_code of 0 is
used both as a signal specific si_code, and as SI_USER it appears that
no one cares about the signal specific si_code case and the good
solution is to just fix the architectures by using a different si_code.

In none of the conversations has anyone even suggested that anything
depends on the signal specific redefinition of SI_USER.

There are at least test cases that care when si_code as 0 does not work
as si_user.

So make things simple and keep the generic code from introducing
problems by removing the special casing of TRAP_FIXME and FPE_FIXME.
This will ensure the generic case of sending a signal with kill will
always set SI_USER and work.

The architecture specific, and signal specific overloads that set
si_code to 0 will now have problems with signalfd and the 32bit compat
versions of siginfo copying.  At least until they are fixed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d56f4d496c89..fc82d2c0918f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2835,15 +2835,6 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 			layout = SIL_POLL;
 		else if (si_code < 0)
 			layout = SIL_RT;
-		/* Tests to support buggy kernel ABIs */
-#ifdef TRAP_FIXME
-		if ((sig == SIGTRAP) && (si_code == TRAP_FIXME))
-			layout = SIL_FAULT;
-#endif
-#ifdef FPE_FIXME
-		if ((sig == SIGFPE) && (si_code == FPE_FIXME))
-			layout = SIL_FAULT;
-#endif
 	}
 	return layout;
 }
-- 
2.14.1
