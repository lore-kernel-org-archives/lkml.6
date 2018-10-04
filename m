Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73666213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiRPWaDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73666213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJDQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:30:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40673 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJDQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id r83-v6so7749207ljr.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8r8LoaOZWeDbtwFqOllvDVX+B3ckIINyhYY9egIyLU=;
        b=NiRPWaDgdj9P0Y5ftCTwkUg1AhumcHNy2rcofQKQHHRyfMnQlbptjZapkI1BdG2/qX
         zKmfcVDjRIbrGBzm74IsoFeVBdnuvLOYCT1nMRYDGLWm73ygxPWjJg20ePmdKVhUHUbx
         imTlrdCOTTZCbDY8AuNEFw5uGTwDNNEP5eICIuedlLEMPvBsw2rtxDeLRusA9ozCS3rH
         8qPPmmr9VLjumUimkrTKGdWgf/WgDXtVJT421E6pjqGq7YDaXgjbPe61RJ38NOOSMCV1
         fGoRp4Oklf07LV3pR+y0eWdnXR3ydOvs9x0jnFRj6sbbJh8V/JRzdNkQLT/bN4veQprF
         75fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=z8r8LoaOZWeDbtwFqOllvDVX+B3ckIINyhYY9egIyLU=;
        b=LLrAylhu9sRO6jxzv3TZnEUznS7yCZg/TqI5H75C31Wlmb04BekueIdXKwIFzXbYsU
         4FnYmEVIcC4Kf2bjxGKU6NI0ln0QE3zb4DViVcV6zDeGuI4KeBea10JyjcoafZ1t/c5K
         fqcdY/dKxsjnHRhdJ7POQUTS2OQQUBNnYI+jU3rxiyYeVNcKiEM8CKuYXCakRSClOL3B
         V9higA6ATXeFGmJBNj33fHajcxopQ7ZdZx8LVE2HSMyjtLZaR/YratqrDePlXBVwBkz+
         PyAu3NGCbUEq5jvPKul3G2+LtA7KVqX8UBP57Ba3fPch+KNqyXBslv15sb9hCTd5vUVq
         Wj4g==
X-Gm-Message-State: ABuFfoib8wce89cXuOOxu6oYEcFYra1EiMQ0ZQjb/+NtiWva0CMaRWOq
        D1F65NZPP+bodlA1fDwRTLs=
X-Google-Smtp-Source: ACcGV63Db3nPSIPPSloNDblNVrI5TgtAaDB9IrY6JHleGWXsIyPceEdpuZTeBWKOLAN5nFOQfesi8A==
X-Received: by 2002:a2e:9cd3:: with SMTP id g19-v6mr3850034ljj.161.1538645900398;
        Thu, 04 Oct 2018 02:38:20 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:19 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 1/7] staging: vc04_services: Drop pointless stub functions
Date:   Thu,  4 Oct 2018 12:37:41 +0300
Message-Id: <20181004093747.21750-2-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions do nothing besides returning NULL and are unused.
Just drop them.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 .../vc04_services/interface/vchi/vchi.h       | 11 --------
 .../interface/vchiq_arm/vchiq_shim.c          | 27 -------------------
 2 files changed, 38 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 3fe19d72b3ab..392c78200e9d 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -116,9 +116,6 @@ typedef struct service_info_tag {
 extern "C" {
 #endif
 
-extern /*@observer@*/ VCHI_CONNECTION_T *vchi_create_connection(const VCHI_CONNECTION_API_T *function_table,
-								 const VCHI_MESSAGE_DRIVER_T *low_level);
-
 // Routine used to initialise the vchi on both local + remote connections
 extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
 
@@ -292,14 +289,6 @@ extern int32_t vchi_bulk_queue_transmit(VCHI_SERVICE_HANDLE_T handle,
  Configuration plumbing
  *****************************************************************************/
 
-// function prototypes for the different mid layers (the state info gives the different physical connections)
-extern const VCHI_CONNECTION_API_T *single_get_func_table(void);
-//extern const VCHI_CONNECTION_API_T *local_server_get_func_table(void);
-//extern const VCHI_CONNECTION_API_T *local_client_get_func_table(void);
-
-// declare all message drivers here
-const VCHI_MESSAGE_DRIVER_T *vchi_mphi_message_driver_func_table(void);
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index dddc828390d0..9235a974dae4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -50,33 +50,6 @@ struct shim_service {
 	void *callback_param;
 };
 
-/* ----------------------------------------------------------------------
- * return pointer to the mphi message driver function table
- * -------------------------------------------------------------------- */
-const VCHI_MESSAGE_DRIVER_T *
-vchi_mphi_message_driver_func_table(void)
-{
-	return NULL;
-}
-
-/* ----------------------------------------------------------------------
- * return a pointer to the 'single' connection driver fops
- * -------------------------------------------------------------------- */
-const VCHI_CONNECTION_API_T *
-single_get_func_table(void)
-{
-	return NULL;
-}
-
-VCHI_CONNECTION_T *vchi_create_connection(
-	const VCHI_CONNECTION_API_T *function_table,
-	const VCHI_MESSAGE_DRIVER_T *low_level)
-{
-	(void)function_table;
-	(void)low_level;
-	return NULL;
-}
-
 /***********************************************************
  * Name: vchi_msg_peek
  *
-- 
2.18.0

