Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018352070B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999743;
	bh=FQifLs/y9Rfmm4XxEh8U8VirgW4E4OZFMhaKzw7NKeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MC+qDPpjRp2+zI7xWlVrayCg5jGhW6VF6dcrRQ0xf5u8arDaT5NsQyCo3A0S/35Td
	 NhA1tGT0KW5PzWe2peFKh42Xz2S6IiTgrBZtzN4EtDHMi/R0CpLsODV36heGqvrM3G
	 x8tenbSBfwcZawIHRAcq3mCwLMDUNHIM0m7711qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeL1MWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbeL1MPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 218832148E;
        Fri, 28 Dec 2018 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999323;
        bh=FQifLs/y9Rfmm4XxEh8U8VirgW4E4OZFMhaKzw7NKeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bH+UuLyqh7NXR2S/fOII8yHxS/vv2yWzQ+LBRnAVEEOTg8HCHMa9Izqn91Bgy3/bn
         Z/6AzEWrBle6lX1shxCTdwr+o6/3H4vDxga8UBVRo5ZiFh8fSgQ5lW/5aZqQiX1mad
         jeUpPzFMQSunAQLDOP9kMvmhVJ3WvnvH+kSBDnGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 44/46] Input: elantech - disable elan-i2c for P52 and P72
Date:   Fri, 28 Dec 2018 12:52:38 +0100
Message-Id: <20181228113127.550916114@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit d21ff5d7f8c397261e095393a1a8e199934720bc upstream.

The current implementation of elan_i2c is known to not support those
2 laptops.

A proper fix is to tweak both elantech and elan_i2c to transmit the
correct information from PS/2, which would make a bad candidate for
stable.

So to give us some time for fixing the root of the problem, disable
elan_i2c for the devices we know are not behaving properly.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803600
Link: https://bugs.archlinux.org/task/59714
Fixes: df077237cf55 Input: elantech - detect new ICs and setup Host Notify for them

Cc: stable@vger.kernel.org  # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elantech.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1767,6 +1767,18 @@ static int elantech_smbus = IS_ENABLED(C
 module_param_named(elantech_smbus, elantech_smbus, int, 0644);
 MODULE_PARM_DESC(elantech_smbus, "Use a secondary bus for the Elantech device.");
 
+static const char * const i2c_blacklist_pnp_ids[] = {
+	/*
+	 * These are known to not be working properly as bits are missing
+	 * in elan_i2c.
+	 */
+	"LEN2131", /* ThinkPad P52 w/ NFC */
+	"LEN2132", /* ThinkPad P52 */
+	"LEN2133", /* ThinkPad P72 w/ NFC */
+	"LEN2134", /* ThinkPad P72 */
+	NULL
+};
+
 static int elantech_create_smbus(struct psmouse *psmouse,
 				 struct elantech_device_info *info,
 				 bool leave_breadcrumbs)
@@ -1802,10 +1814,12 @@ static int elantech_setup_smbus(struct p
 
 	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
 		/*
-		 * New ICs are enabled by default.
+		 * New ICs are enabled by default, unless mentioned in
+		 * i2c_blacklist_pnp_ids.
 		 * Old ICs are up to the user to decide.
 		 */
-		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
+		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
 			return -ENXIO;
 	}
 


