Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE430C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A190B213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCp61+6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A190B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJDQau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:30:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42255 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJDQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id y71-v6so7742406lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1B0Y30vIKl43mNFFoM4zS/CVKUi3q7w/0ajlJ3RvMA=;
        b=UCp61+6gYvqeEqHJpBjQ+XBApH+6Nz/QrLN20048Utst/wn8aZJFdGzI6EQcFRklKV
         QdiAiXBg1nxHXJHtw6Z26RdI2yFG/faXExh5d5Z09muileLtBWyBTax61dXe+/t9/kIH
         OjMGGDFAJ6hN6h80/mmL9i2zTjyc/vF2Vmiw+bNxFHxoSnWJhoo/tFDf2XaDHF+lkrPX
         SZ8sIyED/JlL2It/IM+h0mSiYEh+nRqfPw8XcJIP5gkkU54zS5GJit495vwtqLGFk14g
         jdfvjB5FAM6DZPIxK54P47GODN7vw0u51lkHyxO4kCDUfWXdDe8nEMDfOm7vVyZg86C5
         GN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=x1B0Y30vIKl43mNFFoM4zS/CVKUi3q7w/0ajlJ3RvMA=;
        b=K/iiOmaMq1D6VtApslQX5ZXSheopVT1UzOSCUKtLHldqYSiPwg9TQS/DePwXyracLy
         3Gl1RcXOx3N2DigyybeYtKTg/hFz+iTOiLR+OCrWmUz2pxGXKxVTIlgZaVl1Zwfd0fY2
         zUiYXQUMsiZ0QY1BFX3I7V0Vljrsk2+s5NP9N3SPhhlGs/AVHi8CcN+HDHOhN+DMfWfa
         Oe7js8QIoItlGOR8BtzyixPztHkDkWPAJJ0DGYLyumMftaQp3WhvzYhL0yXewaYzqZ0+
         +z7WP+mqNgXGqXqxzL+ntYGBVUgF99g0pYIZDW2n/rGZ4pmyKHAWuE3Z0jU0yWqPKNDn
         5gTg==
X-Gm-Message-State: ABuFfoi8wDRvzYT+kJJLNvNjvwRXhrKzeCBLmw6vJXTW99/zXNAhV7UO
        5mLHpMUeTyC6NIQewGKEuZo=
X-Google-Smtp-Source: ACcGV60cwPJORnlKplWvQ82GQ/8c6yqSWOvqmSNX7uiKNgtpQgVv4XX4pCsYBbw+WshAba2iO/qcUw==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr3535666ljh.59.1538645902989;
        Thu, 04 Oct 2018 02:38:22 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:22 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 3/7] staging: vc04_services: Drop trivially unused fields from SERVICE_CREATION_T
Date:   Thu,  4 Oct 2018 12:37:43 +0300
Message-Id: <20181004093747.21750-4-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fields are only initialized with constants and never read. Drop
them.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c       |  5 -----
 .../staging/vc04_services/bcm2835-camera/mmal-vchiq.c |  5 -----
 drivers/staging/vc04_services/interface/vchi/vchi.h   | 11 -----------
 3 files changed, 21 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 6ec15e44d7e2..bc48a74a6be6 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -130,13 +130,8 @@ vc_vchi_audio_init(VCHI_INSTANCE_T vchi_instance,
 	SERVICE_CREATION_T params = {
 		.version		= VCHI_VERSION_EX(VC_AUDIOSERV_VER, VC_AUDIOSERV_MIN_VER),
 		.service_id		= VC_AUDIO_SERVER_NAME,
-		.rx_fifo_size		= 0,
-		.tx_fifo_size		= 0,
 		.callback		= audio_vchi_callback,
 		.callback_param		= instance,
-		.want_unaligned_bulk_rx = 1, //TODO: remove VCOS_FALSE
-		.want_unaligned_bulk_tx = 1, //TODO: remove VCOS_FALSE
-		.want_crc		= 0
 	};
 	int status;
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index e234b95b61c0..074a4acc196d 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -1806,13 +1806,8 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	SERVICE_CREATION_T params = {
 		.version		= VCHI_VERSION_EX(VC_MMAL_VER, VC_MMAL_MIN_VER),
 		.service_id		= VC_MMAL_SERVER_NAME,
-		.rx_fifo_size		= 0,
-		.tx_fifo_size		= 0,
 		.callback		= service_callback,
 		.callback_param		= NULL,
-		.want_unaligned_bulk_rx = 1,
-		.want_unaligned_bulk_tx = 1,
-		.want_crc		= 0
 	};
 
 	/* compile time checks to ensure structure size as they are
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 1ea997c658f9..347825329ea4 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -77,19 +77,8 @@ typedef struct {
 typedef struct {
 	struct vchi_version version;
 	int32_t service_id;
-	uint32_t rx_fifo_size;
-	uint32_t tx_fifo_size;
 	VCHI_CALLBACK_T callback;
 	void *callback_param;
-	/* client intends to receive bulk transfers of
-		odd lengths or into unaligned buffers */
-	int32_t want_unaligned_bulk_rx;
-	/* client intends to transmit bulk transfers of
-		odd lengths or out of unaligned buffers */
-	int32_t want_unaligned_bulk_tx;
-	/* client wants to check CRCs on (bulk) xfers.
-		Only needs to be set at 1 end - will do both directions. */
-	int32_t want_crc;
 } SERVICE_CREATION_T;
 
 // Opaque handle for a VCHI instance
-- 
2.18.0

