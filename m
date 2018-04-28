Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbeD1OHe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 10:07:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37146 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933421AbeD1OHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 10:07:30 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 28 Apr 2018 09:06:59 -0500
Message-Id: <20180428140702.3925-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87zi1nctut.fsf_-_@xmission.com>
References: <87zi1nctut.fsf_-_@xmission.com>
X-XM-SPF: eid=1fCQVd-0002Sz-Ci;;;mid=<20180428140702.3925-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PMOjTeFgdyvhdIJ6JUGBi75jl1yKzx0E=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4969]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linux-Arch <linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 247 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.1%), b_tie_ro: 1.89 (0.8%), parse: 0.83 (0.3%),
        extract_message_metadata: 9 (3.8%), get_uri_detail_list: 1.14 (0.5%),
        tests_pri_-1000: 6 (2.2%), tests_pri_-950: 1.13 (0.5%), tests_pri_-900: 0.97
        (0.4%), tests_pri_-400: 33 (13.3%), check_bayes: 32 (12.9%), b_tokenize: 6
        (2.4%), b_tok_get_all: 16 (6.5%), b_comp_prob: 1.71 (0.7%), b_tok_touch_all:
        2.5 (1.0%), b_finish: 0.51 (0.2%), tests_pri_0: 188 (76.1%),
        check_dkim_signature: 0.44 (0.2%), check_dkim_adsp: 2.8 (1.2%),
        tests_pri_500: 3.5 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 2/5] signal/signalfd: Add support for SIGSYS
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why signalfd has never grown support for SIGSYS but grow it now.

This corrects an oversight and removes a need for a default in the
switch statement.  Allowing gcc to warn when future members are added
to the enum siginfo_layout, and signalfd does not handle them.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/signalfd.c                 | 6 +++++-
 include/uapi/linux/signalfd.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 31e960209a08..f652249f59f9 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -134,7 +134,6 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		new.ssi_stime  = kinfo->si_stime;
 		break;
 	case SIL_RT:
-	default:
 		/*
 		 * This case catches also the signals queued by sigqueue().
 		 */
@@ -143,6 +142,11 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		new.ssi_ptr = (long) kinfo->si_ptr;
 		new.ssi_int = kinfo->si_int;
 		break;
+	case SIL_SYS:
+		new.ssi_call_addr = (long) kinfo->si_call_addr;
+		new.ssi_syscall   = kinfo->si_syscall;
+		new.ssi_arch      = kinfo->si_arch;
+		break;
 	}
 
 	if (copy_to_user(uinfo, &new, sizeof(struct signalfd_siginfo)))
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index 6f0da42fc5ef..83429a05b698 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -35,6 +35,10 @@ struct signalfd_siginfo {
 	__u64 ssi_stime;
 	__u64 ssi_addr;
 	__u16 ssi_addr_lsb;
+	__u16 __pad2;
+	__s32 ssi_syscall;
+	__u64 ssi_call_addr;
+	__u32 ssi_arch;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
@@ -45,7 +49,7 @@ struct signalfd_siginfo {
 	 * comes out of a read(2) and we really don't want to have
 	 * a compat on read(2).
 	 */
-	__u8 __pad[46];
+	__u8 __pad[28];
 };
 
 
-- 
2.14.1
