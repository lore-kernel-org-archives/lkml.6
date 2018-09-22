Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E48ECE567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48066215E4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48066215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392189AbeIVGK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44371 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392140AbeIVGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:55 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Ve1-0008BR-2L; Sat, 22 Sep 2018 01:19:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000rN-Ol; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Kees Cook" <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, kernel-team@android.com,
        security@kernel.org, "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Mark Salyzyn" <salyzyn@android.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.858007707@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 21/63] Bluetooth: hidp: buffer overflow in
 hidp_process_report
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

From: Mark Salyzyn <salyzyn@android.com>

commit 7992c18810e568b95c869b227137a2215702a805 upstream.

CVE-2018-9363

The buffer length is unsigned at all layers, but gets cast to int and
checked in hidp_process_report and can lead to a buffer overflow.
Switch len parameter to unsigned int to resolve issue.

This affects 3.18 and newer kernels.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: security@kernel.org
Cc: kernel-team@android.com
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bluetooth/hidp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -429,8 +429,8 @@ static void hidp_del_timer(struct hidp_s
 		del_timer(&session->timer);
 }
 
-static void hidp_process_report(struct hidp_session *session,
-				int type, const u8 *data, int len, int intr)
+static void hidp_process_report(struct hidp_session *session, int type,
+				const u8 *data, unsigned int len, int intr)
 {
 	if (len > HID_MAX_BUFFER_SIZE)
 		len = HID_MAX_BUFFER_SIZE;

