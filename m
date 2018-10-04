Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6229C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0B4213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV7BA2Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0B4213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeJDQax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:30:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35621 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJDQav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so7774164ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tcYspiJYtZfcqgqjK4lio0qLobpPosb81mJf/GBdgdM=;
        b=gV7BA2Z/iGffwfFhLpvF65F1uLZldBwuJdWUSDtiOjCCtJccSq7IyodhP0D0kRi4Xw
         sj7E3dridHeM/Ggq66PDzwOWtaYNSIo5YBOtGSoQTOCXiIWplGg1u1yLLI/hiwENylPe
         q8xfdLRv3nSOLqRt52yRlbjv1iMUulnXz7gM7KZ45cG0NHdMLMMRhoDdjhRzktIvA0bv
         BClTMuCA6bfoa2N5KTYA82uknjQNvAIc3cFmo/7p8UH+jGVbzT4Q3fuHJRw12RNRWw+C
         VvXfcjKCz4fhf/8QNTgDN3+5bwgTLvK32hDhlthiUTQ5FLC9rlUQGcogva58pmUezYJs
         WKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=tcYspiJYtZfcqgqjK4lio0qLobpPosb81mJf/GBdgdM=;
        b=poWAKp+5WPSiuLOCWNpFI1IE6SdEO/jnTTFgKPkoPocPLSULtzfAM4EQYSWnqs8NEG
         zImrWA5AQMMqZ3wum82T++E3T8QuAau0UDezmQho1T+lM7JPpTKB6nOhuFQ/FO3t/wlS
         QkH3/JxaO0gJk+2EJmxt0PTk9PJKLGtH2o51hGqyZ7eyDqV/DKoWM80JbzFjIySXPbNz
         kNkKnk6oepbctApfDl8NZv3Yowv9c61TbYAPyFJ/xlQdUTLesT90zuopr3QyH4aX6gi4
         6oJMfIlsR0C/Y4fltkKBG/Bm40p6P9wSrfkqsF7RP9JM6MXXQZNzEg7wNMpWxHkUE978
         M1Hw==
X-Gm-Message-State: ABuFfoiGM/CmfnmPrlFNlo6FMLChSwiSPGoUgbObpjjwYVwphWXZ9EyQ
        mlxiTJXhTE7kVQR09vfOjcs=
X-Google-Smtp-Source: ACcGV60euBcJ98POYcOEXGfhk+EosaJOBPp274WHCG4vWX9Y6lF9lYWXiSyHYDLPA4xm6mRI70Y6ZQ==
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr3122233lji.149.1538645904089;
        Thu, 04 Oct 2018 02:38:24 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:23 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 4/7] staging: vc04_services: Drop declaration of vchi_crc_control()
Date:   Thu,  4 Oct 2018 12:37:44 +0300
Message-Id: <20181004093747.21750-5-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no definition for this unused function, so drop its prototype.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 347825329ea4..103d67024335 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -117,10 +117,6 @@ extern int32_t vchi_connect(VCHI_CONNECTION_T **connections,
 //Bulk transfers can remain 'queued'
 extern int32_t vchi_disconnect(VCHI_INSTANCE_T instance_handle);
 
-// Global control over bulk CRC checking
-extern int32_t vchi_crc_control(VCHI_CONNECTION_T *connection,
-				VCHI_CRC_CONTROL_T control);
-
 // helper functions
 extern void *vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
 extern void vchi_free_buffer(VCHI_SERVICE_HANDLE_T handle, void *address);
-- 
2.18.0

