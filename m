Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB70C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F379213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU5L0hKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F379213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeJDQbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:31:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36270 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id p89-v6so7768862ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rutUAwB9gRgCOZTQolGkK8XKcRctVlt4v5VErdSUW9M=;
        b=bU5L0hKenozgm9Hs3jArUopMXX7PgoClMStcA1kakWZiceWO7th1RTeKHxXZlrwV5W
         JVbyMoHtJ8BIV8qZBkRSgd7DbSUup8LtaxCDbudJj6/Wpk+/XmGNqo6j0KWbqw877P4l
         b2v6rjqKsjwJzZmN3xhqDjH23SCLMSL6fdmHWBTJeUq2ZjEgKqazAhKTEEgnZ+gHwCMq
         AlxVqzVqNUjDnYXua3X3MscX1EiBwgCHxZ2Bv5CQZYTFvtEGVrmIitv/Q/NZM+RFpdiU
         NADIA+CSIQJRJ22OIJ8OdlloybcKOTB8fuixtMwIrkxMRKPD/5p2EBLL2pi5NIIwN1iX
         BV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rutUAwB9gRgCOZTQolGkK8XKcRctVlt4v5VErdSUW9M=;
        b=GTiSOoGQtXu3s+s1kxOvwzTCBsCuVtZWIZWrUTMyenDm3br4wt6Vw/LTM1q6rd/NpV
         5/+4d07p8lyqoQRKGPN/dou4ydErvlDPZhHozc1HbeOKbEsoWpZkKzggUjlLwyUo9pns
         KobysY1v0LQu90V2qKj6w22w1LN9F9jqF9TTHUBlLiTK7uVX6VjDbZ1hCoVy92F+9pCP
         kkvftFdMxJvmsotfPC7rc+ltY+v8+7EgIU/LS1l11oZ3nEEetB5NKe7LSU/fMQUpDiy1
         VKGdunF7jAXA4QAJ339PjxyCVGVYNOq2iax8mGvKUTYCL+2Makrv0JU+4C6X6urW27CX
         arrA==
X-Gm-Message-State: ABuFfogQRY4gvtNC2SvX6JiozJH3SNZwrT/OjJOGZ+uOZ/8spTB+yT2E
        m5qfWLPfV5DfPzb69rHO8Yw=
X-Google-Smtp-Source: ACcGV62pY3m6pCKxOwZUj1yNJRQRZxMD4+06A2QyrDAod17EqWIiK0NjuksNPWi7pAcAL8/0takr6g==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr3643890ljk.116.1538645901703;
        Thu, 04 Oct 2018 02:38:21 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:21 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 2/7] staging: vc04_services: Drop 'connection' field from SERVICE_CREATION_T
Date:   Thu,  4 Oct 2018 12:37:42 +0300
Message-Id: <20181004093747.21750-3-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The connection field of SERVICE_CREATION_T is assigned to but its value
is never read. Drop the field and the resulting no longer needed code
from bcm2835-audio and bcm2835-camera.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 3 ---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h       | 1 -
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c   | 2 --
 drivers/staging/vc04_services/interface/vchi/vchi.h         | 1 -
 4 files changed, 7 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 0bdaea1fdd77..6ec15e44d7e2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -125,13 +125,11 @@ static void audio_vchi_callback(void *param,
 
 static int
 vc_vchi_audio_init(VCHI_INSTANCE_T vchi_instance,
-		   VCHI_CONNECTION_T *vchi_connection,
 		   struct bcm2835_audio_instance *instance)
 {
 	SERVICE_CREATION_T params = {
 		.version		= VCHI_VERSION_EX(VC_AUDIOSERV_VER, VC_AUDIOSERV_MIN_VER),
 		.service_id		= VC_AUDIO_SERVER_NAME,
-		.connection		= vchi_connection,
 		.rx_fifo_size		= 0,
 		.tx_fifo_size		= 0,
 		.callback		= audio_vchi_callback,
@@ -228,7 +226,6 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 	alsa_stream->instance = instance;
 
 	err = vc_vchi_audio_init(vchi_ctx->vchi_instance,
-				 vchi_ctx->vchi_connection,
 				 instance);
 	if (err < 0)
 		goto free_instance;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index e13435d1c205..34a0125ce646 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -45,7 +45,6 @@ enum snd_bcm2835_ctrl {
 
 struct bcm2835_vchi_ctx {
 	VCHI_INSTANCE_T vchi_instance;
-	VCHI_CONNECTION_T *vchi_connection;
 };
 
 /* definition of the chip-specific record */
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 6e5c1d4ee122..e234b95b61c0 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -1802,12 +1802,10 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 {
 	int status;
 	struct vchiq_mmal_instance *instance;
-	static VCHI_CONNECTION_T *vchi_connection;
 	static VCHI_INSTANCE_T vchi_instance;
 	SERVICE_CREATION_T params = {
 		.version		= VCHI_VERSION_EX(VC_MMAL_VER, VC_MMAL_MIN_VER),
 		.service_id		= VC_MMAL_SERVER_NAME,
-		.connection		= vchi_connection,
 		.rx_fifo_size		= 0,
 		.tx_fifo_size		= 0,
 		.callback		= service_callback,
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 392c78200e9d..1ea997c658f9 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -77,7 +77,6 @@ typedef struct {
 typedef struct {
 	struct vchi_version version;
 	int32_t service_id;
-	VCHI_CONNECTION_T *connection;
 	uint32_t rx_fifo_size;
 	uint32_t tx_fifo_size;
 	VCHI_CALLBACK_T callback;
-- 
2.18.0

