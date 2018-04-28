Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeD1OHi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 10:07:38 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33236 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933579AbeD1OHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 10:07:34 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 28 Apr 2018 09:07:00 -0500
Message-Id: <20180428140702.3925-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87zi1nctut.fsf_-_@xmission.com>
References: <87zi1nctut.fsf_-_@xmission.com>
X-XM-SPF: eid=1fCQVg-0002Sz-4G;;;mid=<20180428140702.3925-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18aRnoy9IoTIYC0/hPLrqSsou+TuxAPR7U=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux-Arch <linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1438 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.2%), b_tie_ro: 2.0 (0.1%), parse: 1.24 (0.1%),
        extract_message_metadata: 76 (5.3%), get_uri_detail_list: 10 (0.7%),
        tests_pri_-1000: 59 (4.1%), tests_pri_-950: 15 (1.0%), tests_pri_-900: 1.81
        (0.1%), tests_pri_-400: 99 (6.9%), check_bayes: 85 (5.9%), b_tokenize: 30
        (2.1%), b_tok_get_all: 17 (1.2%), b_comp_prob: 3.0 (0.2%), b_tok_touch_all:
        25 (1.7%), b_finish: 0.90 (0.1%), tests_pri_0: 1125 (78.2%),
        check_dkim_signature: 0.90 (0.1%), check_dkim_adsp: 15 (1.0%), tests_pri_500:
        32 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 3/5] signal: Remove unncessary #ifdef SEGV_PKUERR in 32bit compat code
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only architecture that does not support SEGV_PKUERR is ia64 and
ia64 has not had 32bit support since some time in 2008.  Therefore
copy_siginfo_to_user32 and copy_siginfo_from_user32 do not need to
include support for a missing SEGV_PKUERR.

Compile test on ia64.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b87a9c21f698..376b42f26e6d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2888,12 +2888,9 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 			new.si_lower = ptr_to_compat(from->si_lower);
 			new.si_upper = ptr_to_compat(from->si_upper);
 		}
-#ifdef SEGV_PKUERR
 		if ((from->si_signo == SIGSEGV) &&
 		    (from->si_code == SEGV_PKUERR))
 			new.si_pkey = from->si_pkey;
-#endif
-
 		break;
 	case SIL_CHLD:
 		new.si_pid    = from->si_pid;
@@ -2968,10 +2965,8 @@ int copy_siginfo_from_user32(struct siginfo *to,
 			to->si_lower = compat_ptr(from.si_lower);
 			to->si_upper = compat_ptr(from.si_upper);
 		}
-#ifdef SEGV_PKUERR
 		if ((from.si_signo == SIGSEGV) && (from.si_code == SEGV_PKUERR))
 			to->si_pkey = from.si_pkey;
-#endif
 		break;
 	case SIL_CHLD:
 		to->si_pid    = from.si_pid;
-- 
2.14.1
