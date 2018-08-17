Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB32BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9212187B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHKmy1jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9212187B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeHQVjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34013 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so2060085wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MxR/oap3hr1YTfrN86Bb0tJFJV7eSpVVF7GTZjtbgrU=;
        b=WHKmy1jwQNQkn9TiV+IIs7S7Pizie1zSBeosp/F7GBHADxdOoUH9yicNYnCpj57JRM
         fthNHDv7hT1eW03vI8duC+KfArmOOQcSeaZgBqbOunwoj2p7b3YJWTl7wdFHvinlNJU0
         Y/L5zLbuahq3AtE/iHvKde1JzjOYM78wWdB58EIdn9HDYII05KzrjUxgyXM8VWYtGsd5
         4yJgRfNPZyBtFLv3nalC4K64m0cP06vew0IiVZqF7ZRzuxHihE2aYRKSacbq0bavPMzK
         m+45vfk+6cyrrWyPNx5i2+g5Nnlu1CYPcxEczMWzahq3hciNq7KNlmkZgUdHy+EJsZLy
         ks7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MxR/oap3hr1YTfrN86Bb0tJFJV7eSpVVF7GTZjtbgrU=;
        b=ppzuQ1u1HWZtiyhui4w8g7NamuEYzdFuiYEEcv8kYZI8ieAGvckN2hV9llwST2RvSf
         T0NJ2K6RRvy4K/HyrnmZIHzw9rjSSMad7RNlC10EiUOhDftILHGkDXQca87h4CgAMnEQ
         O97YLs2PzROpLGwb4mz6/etr994vmeYKk8hAfI4RGF92JygPdVYj+ovwPhqBI2jD2X5P
         mkRFgQmIzY833MnDUTE35ArGtZP0J4VUZ1RHpi65fapqHrSnFN9z6buLPXXKctaQNuNy
         JcLvzF7FUcMIzNMhj3UAfq2UsRJzLwsrPXyXqWAeO+yQyhMm58KDYlaC8OWWhvX+KMai
         kSgw==
X-Gm-Message-State: AOUpUlFsLQy9Zf29DXBeT81OiFprLjWxJx6eCzvbuDwKnsOMA+hwBikT
        lZErVBbSzmklp19KzjWMD6SyvixWNaU=
X-Google-Smtp-Source: AA+uWPxUwtgxJQk48MbrLnZHMtEm9aLp7kZ+wQ+TOn4n1JHC9ZeMm0z9/Z3SRv2vhVRKrJkz+4rHkg==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr19675283wma.143.1534530896070;
        Fri, 17 Aug 2018 11:34:56 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:34:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/10] staging:rtl8192u: Replace magic number with defined constant - Style
Date:   Fri, 17 Aug 2018 19:34:38 +0100
Message-Id: <20180817183447.15993-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defined constant MIMO_PS_STATIC is used for this test for zero
elsewhere in code so the magic number '0' has been replaced with that
comment, which was actually explicitly mentioned in the comment.

This is a simple coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index e218b5c20642..13926a83f430 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1997,7 +1997,7 @@ static void rtl8192_update_ratr_table(struct net_device *dev)
 		break;
 	case IEEE_N_24G:
 	case IEEE_N_5G:
-		if (ieee->pHTInfo->PeerMimoPs == 0) { /* MIMO_PS_STATIC */
+		if (ieee->pHTInfo->PeerMimoPs == MIMO_PS_STATIC) {
 			ratr_value &= 0x0007F007;
 		} else {
 			if (priv->rf_type == RF_1T2R)
-- 
2.18.0

