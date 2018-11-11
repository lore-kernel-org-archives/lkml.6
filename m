Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F847C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6A520869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp0xSlYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6A520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbeKLJJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389572AbeKLIVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE344208A3;
        Sun, 11 Nov 2018 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975488;
        bh=Mg10tTlw1PAOqUmD76qOCTkZg1fHLZ4QtoNeDDxIqtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cp0xSlYQsofHfoFXHPetqj3WxCI7cQw0DiGbF5AfSc6pyMLTxhW+TYxV1x5eVhp7I
         THr6vnyKayPjoH+xrJywUostNQe0Cnwof3U3LF4PgcGmj9gAwKsYB305be5YCK0fSF
         uSMsGRIV4GDvqxUTgBd+QbL28I0//DAVORG8h+cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.18 286/350] Revert "media: dvbsky: use just one mutex for serializing device R/W ops"
Date:   Sun, 11 Nov 2018 14:22:30 -0800
Message-Id: <20181111221720.025336957@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit 9afc82194de9a1ce298f0d77d7d779d585bf962c upstream.

As pointed at:
	https://bugzilla.kernel.org/show_bug.cgi?id=199323

This patch causes a bad effect on RPi. I suspect that the root
cause is at the USB out of tree RPi driver, with uses high priority
interrupts instead of normal ones. Anyway, as this patch
is mostly a cleanup, better to revert it.

This reverts commit 7d95fb746c4eece67308f1642a666ea1ebdbd2cc.

Cc: stable@vger.kernel.org # For Kernel 4.18
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb-v2/dvbsky.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/dvbsky.c
+++ b/drivers/media/usb/dvb-usb-v2/dvbsky.c
@@ -31,6 +31,7 @@ MODULE_PARM_DESC(disable_rc, "Disable in
 DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nr);
 
 struct dvbsky_state {
+	struct mutex stream_mutex;
 	u8 ibuf[DVBSKY_BUF_LEN];
 	u8 obuf[DVBSKY_BUF_LEN];
 	u8 last_lock;
@@ -67,17 +68,18 @@ static int dvbsky_usb_generic_rw(struct
 
 static int dvbsky_stream_ctrl(struct dvb_usb_device *d, u8 onoff)
 {
+	struct dvbsky_state *state = d_to_priv(d);
 	int ret;
-	static u8 obuf_pre[3] = { 0x37, 0, 0 };
-	static u8 obuf_post[3] = { 0x36, 3, 0 };
+	u8 obuf_pre[3] = { 0x37, 0, 0 };
+	u8 obuf_post[3] = { 0x36, 3, 0 };
 
-	mutex_lock(&d->usb_mutex);
-	ret = dvb_usbv2_generic_rw_locked(d, obuf_pre, 3, NULL, 0);
+	mutex_lock(&state->stream_mutex);
+	ret = dvbsky_usb_generic_rw(d, obuf_pre, 3, NULL, 0);
 	if (!ret && onoff) {
 		msleep(20);
-		ret = dvb_usbv2_generic_rw_locked(d, obuf_post, 3, NULL, 0);
+		ret = dvbsky_usb_generic_rw(d, obuf_post, 3, NULL, 0);
 	}
-	mutex_unlock(&d->usb_mutex);
+	mutex_unlock(&state->stream_mutex);
 	return ret;
 }
 
@@ -606,6 +608,8 @@ static int dvbsky_init(struct dvb_usb_de
 	if (ret)
 		return ret;
 	*/
+	mutex_init(&state->stream_mutex);
+
 	state->last_lock = 0;
 
 	return 0;


