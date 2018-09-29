Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB86C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB58206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB58206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeI3ESZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51607 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbeI3ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N62-0000Gt-T1; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006zN-WD; Sat, 29 Sep 2018 22:48:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Vincent Pelletier" <plr.vincent@gmail.com>,
        "Mike Christie" <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.360224726@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 130/131] scsi: target: iscsi: Use hex2bin instead of
 a re-implementation
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Pelletier <plr.vincent@gmail.com>

commit 1816494330a83f2a064499d8ed2797045641f92c upstream.

This change has the following effects, in order of descreasing importance:

1) Prevent a stack buffer overflow

2) Do not append an unnecessary NULL to an anyway binary buffer, which
   is writing one byte past client_digest when caller is:
   chap_string_to_hex(client_digest, chap_r, strlen(chap_r));

The latter was found by KASAN (see below) when input value hes expected size
(32 hex chars), and further analysis revealed a stack buffer overflow can
happen when network-received value is longer, allowing an unauthenticated
remote attacker to smash up to 17 bytes after destination buffer (16 bytes
attacker-controlled and one null).  As switching to hex2bin requires
specifying destination buffer length, and does not internally append any null,
it solves both issues.

This addresses CVE-2018-14633.

Beyond this:

- Validate received value length and check hex2bin accepted the input, to log
  this rejection reason instead of just failing authentication.

- Only log received CHAP_R and CHAP_C values once they passed sanity checks.

==================================================================
BUG: KASAN: stack-out-of-bounds in chap_string_to_hex+0x32/0x60 [iscsi_target_mod]
Write of size 1 at addr ffff8801090ef7c8 by task kworker/0:0/1021

CPU: 0 PID: 1021 Comm: kworker/0:0 Tainted: G           O      4.17.8kasan.sess.connops+ #2
Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 05/19/2014
Workqueue: events iscsi_target_do_login_rx [iscsi_target_mod]
Call Trace:
 dump_stack+0x71/0xac
 print_address_description+0x65/0x22e
 ? chap_string_to_hex+0x32/0x60 [iscsi_target_mod]
 kasan_report.cold.6+0x241/0x2fd
 chap_string_to_hex+0x32/0x60 [iscsi_target_mod]
 chap_server_compute_md5.isra.2+0x2cb/0x860 [iscsi_target_mod]
 ? chap_binaryhex_to_asciihex.constprop.5+0x50/0x50 [iscsi_target_mod]
 ? ftrace_caller_op_ptr+0xe/0xe
 ? __orc_find+0x6f/0xc0
 ? unwind_next_frame+0x231/0x850
 ? kthread+0x1a0/0x1c0
 ? ret_from_fork+0x35/0x40
 ? ret_from_fork+0x35/0x40
 ? iscsi_target_do_login_rx+0x3bc/0x4c0 [iscsi_target_mod]
 ? deref_stack_reg+0xd0/0xd0
 ? iscsi_target_do_login_rx+0x3bc/0x4c0 [iscsi_target_mod]
 ? is_module_text_address+0xa/0x11
 ? kernel_text_address+0x4c/0x110
 ? __save_stack_trace+0x82/0x100
 ? ret_from_fork+0x35/0x40
 ? save_stack+0x8c/0xb0
 ? 0xffffffffc1660000
 ? iscsi_target_do_login+0x155/0x8d0 [iscsi_target_mod]
 ? iscsi_target_do_login_rx+0x3bc/0x4c0 [iscsi_target_mod]
 ? process_one_work+0x35c/0x640
 ? worker_thread+0x66/0x5d0
 ? kthread+0x1a0/0x1c0
 ? ret_from_fork+0x35/0x40
 ? iscsi_update_param_value+0x80/0x80 [iscsi_target_mod]
 ? iscsit_release_cmd+0x170/0x170 [iscsi_target_mod]
 chap_main_loop+0x172/0x570 [iscsi_target_mod]
 ? chap_server_compute_md5.isra.2+0x860/0x860 [iscsi_target_mod]
 ? rx_data+0xd6/0x120 [iscsi_target_mod]
 ? iscsit_print_session_params+0xd0/0xd0 [iscsi_target_mod]
 ? cyc2ns_read_begin.part.2+0x90/0x90
 ? _raw_spin_lock_irqsave+0x25/0x50
 ? memcmp+0x45/0x70
 iscsi_target_do_login+0x875/0x8d0 [iscsi_target_mod]
 ? iscsi_target_check_first_request.isra.5+0x1a0/0x1a0 [iscsi_target_mod]
 ? del_timer+0xe0/0xe0
 ? memset+0x1f/0x40
 ? flush_sigqueue+0x29/0xd0
 iscsi_target_do_login_rx+0x3bc/0x4c0 [iscsi_target_mod]
 ? iscsi_target_nego_release+0x80/0x80 [iscsi_target_mod]
 ? iscsi_target_restore_sock_callbacks+0x130/0x130 [iscsi_target_mod]
 process_one_work+0x35c/0x640
 worker_thread+0x66/0x5d0
 ? flush_rcu_work+0x40/0x40
 kthread+0x1a0/0x1c0
 ? kthread_bind+0x30/0x30
 ret_from_fork+0x35/0x40

The buggy address belongs to the page:
page:ffffea0004243bc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x17fffc000000000()
raw: 017fffc000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: ffffea0004243c20 ffffea0004243ba0 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8801090ef680: f2 f2 f2 f2 f2 f2 f2 01 f2 f2 f2 f2 f2 f2 f2 00
 ffff8801090ef700: f2 f2 f2 f2 f2 f2 f2 00 02 f2 f2 f2 f2 f2 f2 00
>ffff8801090ef780: 00 f2 f2 f2 f2 f2 f2 00 00 f2 f2 f2 f2 f2 f2 00
                                              ^
 ffff8801090ef800: 00 f2 f2 f2 f2 f2 f2 00 00 00 00 02 f2 f2 f2 f2
 ffff8801090ef880: f2 f2 f2 00 00 00 00 00 00 00 00 f2 f2 f2 f2 00
==================================================================

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/target/iscsi/iscsi_target_auth.c | 30 +++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -26,18 +26,6 @@
 #include "iscsi_target_nego.h"
 #include "iscsi_target_auth.h"
 
-static int chap_string_to_hex(unsigned char *dst, unsigned char *src, int len)
-{
-	int j = DIV_ROUND_UP(len, 2), rc;
-
-	rc = hex2bin(dst, src, j);
-	if (rc < 0)
-		pr_debug("CHAP string contains non hex digit symbols\n");
-
-	dst[j] = '\0';
-	return j;
-}
-
 static void chap_binaryhex_to_asciihex(char *dst, char *src, int src_len)
 {
 	int i;
@@ -241,9 +229,16 @@ static int chap_server_compute_md5(
 		pr_err("Could not find CHAP_R.\n");
 		goto out;
 	}
+	if (strlen(chap_r) != MD5_SIGNATURE_SIZE * 2) {
+		pr_err("Malformed CHAP_R\n");
+		goto out;
+	}
+	if (hex2bin(client_digest, chap_r, MD5_SIGNATURE_SIZE) < 0) {
+		pr_err("Malformed CHAP_R\n");
+		goto out;
+	}
 
 	pr_debug("[server] Got CHAP_R=%s\n", chap_r);
-	chap_string_to_hex(client_digest, chap_r, strlen(chap_r));
 
 	tfm = crypto_alloc_hash("md5", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(tfm)) {
@@ -348,9 +343,7 @@ static int chap_server_compute_md5(
 		pr_err("Could not find CHAP_C.\n");
 		goto out;
 	}
-	pr_debug("[server] Got CHAP_C=%s\n", challenge);
-	challenge_len = chap_string_to_hex(challenge_binhex, challenge,
-				strlen(challenge));
+	challenge_len = DIV_ROUND_UP(strlen(challenge), 2);
 	if (!challenge_len) {
 		pr_err("Unable to convert incoming challenge\n");
 		goto out;
@@ -359,6 +352,11 @@ static int chap_server_compute_md5(
 		pr_err("CHAP_C exceeds maximum binary size of 1024 bytes\n");
 		goto out;
 	}
+	if (hex2bin(challenge_binhex, challenge, challenge_len) < 0) {
+		pr_err("Malformed CHAP_C\n");
+		goto out;
+	}
+	pr_debug("[server] Got CHAP_C=%s\n", challenge);
 	/*
 	 * During mutual authentication, the CHAP_C generated by the
 	 * initiator must not match the original CHAP_C generated by

