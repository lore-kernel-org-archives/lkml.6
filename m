Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBVVNU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:13:20 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55580 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBVVNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:13:18 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2018 15:12:49 -0600
Message-ID: <87371s684u.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eoyB2-0006jO-9C;;;mid=<87371s684u.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/6ko6ZmPD2OAU6wqZmsLRQ181W58PlVk0=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 254 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (1.0%), b_tie_ro: 1.69 (0.7%), parse: 1.06 (0.4%),
        extract_message_metadata: 28 (10.8%), get_uri_detail_list: 2.9 (1.1%),
        tests_pri_-1000: 14 (5.7%), tests_pri_-950: 1.58 (0.6%), tests_pri_-900: 1.36
        (0.5%), tests_pri_-400: 25 (10.0%), check_bayes: 24 (9.5%), b_tokenize: 10
        (4.0%), b_tok_get_all: 6 (2.4%), b_comp_prob: 2.8 (1.1%), b_tok_touch_all:
        3.0 (1.2%), b_finish: 0.61 (0.2%), tests_pri_0: 167 (65.9%),
        check_dkim_signature: 0.42 (0.2%), check_dkim_adsp: 2.5 (1.0%),
        tests_pri_500: 9 (3.5%), poll_dns_idle: 0.69 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] siginfo fix for v4.16-rc3
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 9026e820cbd2ea39a06a129ecdddf2739bd3602b fs/signalfd: fix build error for BUS_MCEERR_AR

This change fixes a build error that should only shows up on blackfin.

From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 12 Feb 2018 13:18:38 -0800
Subject: [PATCH] fs/signalfd: fix build error for BUS_MCEERR_AR

Fix build error in fs/signalfd.c by using same method that is used in
kernel/signal.c: separate blocks for different signal si_code values.

./fs/signalfd.c: error: 'BUS_MCEERR_AR' undeclared (first use in this function)

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/signalfd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 9990957264e3..76bf9cc62074 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -118,13 +118,22 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		err |= __put_user(kinfo->si_trapno, &uinfo->ssi_trapno);
 #endif
 #ifdef BUS_MCEERR_AO
-		/* 
+		/*
+		 * Other callers might not initialize the si_lsb field,
+		 * so check explicitly for the right codes here.
+		 */
+		if (kinfo->si_signo == SIGBUS &&
+		     kinfo->si_code == BUS_MCEERR_AO)
+			err |= __put_user((short) kinfo->si_addr_lsb,
+					  &uinfo->ssi_addr_lsb);
+#endif
+#ifdef BUS_MCEERR_AR
+		/*
 		 * Other callers might not initialize the si_lsb field,
 		 * so check explicitly for the right codes here.
 		 */
 		if (kinfo->si_signo == SIGBUS &&
-		    (kinfo->si_code == BUS_MCEERR_AR ||
-		     kinfo->si_code == BUS_MCEERR_AO))
+		    kinfo->si_code == BUS_MCEERR_AR)
 			err |= __put_user((short) kinfo->si_addr_lsb,
 					  &uinfo->ssi_addr_lsb);
 #endif
-- 
2.14.1
