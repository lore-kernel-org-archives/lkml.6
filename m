Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA0ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78B320870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78B320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbeIVGQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:16:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44130 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391925AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BT-5o; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdp-0000u2-0p; Sat, 22 Sep 2018 01:19:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Oleg Nesterov" <oleg@redhat.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Andy Lutomirski" <luto@amacapital.net>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.855222532@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 54/63] seccomp: create internal mode-setting function
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit d78ab02c2c194257a03355fbb79eb721b381d105 upstream.

In preparation for having other callers of the seccomp mode setting
logic, split the prctl entry point away from the core logic that performs
seccomp mode setting.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/seccomp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -473,7 +473,7 @@ long prctl_get_seccomp(void)
 }
 
 /**
- * prctl_set_seccomp: configures current->seccomp.mode
+ * seccomp_set_mode: internal function for setting seccomp mode
  * @seccomp_mode: requested mode to use
  * @filter: optional struct sock_fprog for use with SECCOMP_MODE_FILTER
  *
@@ -486,7 +486,7 @@ long prctl_get_seccomp(void)
  *
  * Returns 0 on success or -EINVAL on failure.
  */
-long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
+static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
 {
 	long ret = -EINVAL;
 
@@ -517,3 +517,15 @@ long prctl_set_seccomp(unsigned long sec
 out:
 	return ret;
 }
+
+/**
+ * prctl_set_seccomp: configures current->seccomp.mode
+ * @seccomp_mode: requested mode to use
+ * @filter: optional struct sock_fprog for use with SECCOMP_MODE_FILTER
+ *
+ * Returns 0 on success or -EINVAL on failure.
+ */
+long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
+{
+	return seccomp_set_mode(seccomp_mode, filter);
+}

