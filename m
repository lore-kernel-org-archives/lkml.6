Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA0AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF9521479
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J24Sdp/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF9521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeJFBlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:41:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43971 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeJFBlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:41:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id 80-v6so5090256pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBFAJVedcraxDMXVn/3gw/J45rh9ivZ5tlGTOiBAaas=;
        b=J24Sdp/8HLW6DZQ1te231tY9waFa4Vni0utnDO7Rf+ZalmiGGe7gOqSARfeO0Fc1qT
         c6sYOUsiKGpUqJxUJjSWHiHzelixt7Sm/3koywEf55A4TRvmnL+S61FI7ceFjebjGbti
         l6j2ju01DWfjEQDvdtGFkgdJxmVDYy6CN9yb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBFAJVedcraxDMXVn/3gw/J45rh9ivZ5tlGTOiBAaas=;
        b=DJBVUNFgOCWk2kDWv5L2slakz7Oy/wABe4FQAbz1qtVTFhFEsYMalV0pfWbwVIid7u
         qR3u9sYxMh1SL169oX0Z34xZwX97YWQGfgEN1Y4wBGzCOAnZvobHI3gGNSn6pwmLcMLT
         wV523fbOImTvDATPw458O6omh3rxKD1lz3xa2+O7FiGk3yexKt1UbnJDjVVe2jQJMEVi
         mTscdZqk/5FDZrvEMBnnugi3w+eiwQNi9uv1hAkLtanv3NwXJr1L0hzitZ0BPyA9CVmH
         hJ+3iHYx8UpD4up53X7S1Z81GIKvwNwnVCw6B+q2W1zSAQPc7IGYbCR4s84svd47PgGh
         jQ7g==
X-Gm-Message-State: ABuFfoinbRZij4pSQBbEScUKyW7k2C+X9moFTXX615kDGfdTHOFFNco7
        66CeNb6+iI6no7wRfpgXC3N1pQ==
X-Google-Smtp-Source: ACcGV61Q1xT3v874i+rYLgSompScJduwDiqEkVDu+h0B2mksz9CtYyQO/ZCkdUIpxAGwt0myObVnmQ==
X-Received: by 2002:a62:ac15:: with SMTP id v21-v6mr13252355pfe.126.1538764878568;
        Fri, 05 Oct 2018 11:41:18 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t64-v6sm12151303pfb.44.2018.10.05.11.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:41:17 -0700 (PDT)
From:   Dmitry Torokhov <dtor@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 1/2] mfd: cros: add "base attached" MKBP switch definition
Date:   Fri,  5 Oct 2018 11:41:13 -0700
Message-Id: <20181005184114.207503-1-dtor@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a "base attached" switch definition to the MKBP protocol that
is used by Whiskers driver to properly determine device state (clamshell
vs tablet mode).

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

v2 changes: None

Lee, I was wondering if it would be OK for cros_ec_commands.h to be
merged through HID tree.


 include/linux/mfd/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 20ee71f10865..5fd0e429f472 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2132,6 +2132,7 @@ struct ec_response_get_next_event_v1 {
 /* Switches */
 #define EC_MKBP_LID_OPEN	0
 #define EC_MKBP_TABLET_MODE	1
+#define EC_MKBP_BASE_ATTACHED	2
 
 /*****************************************************************************/
 /* Temperature sensor commands */
-- 
2.19.0.605.g01d371f741-goog

