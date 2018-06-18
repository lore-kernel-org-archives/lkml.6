Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA984C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723FF20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7LoynVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723FF20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935677AbeFRRpx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:45:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39507 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935127AbeFRRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:45:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so8536117pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ah43YigJLYdK+A3nTEOceqnA/3FgZWTeWEFBv8nmy1A=;
        b=A7LoynVOaHCfxLO9D7ZhUX8JJL83wsKH5TI9NFiA+73sdzIPz4c9BlOdT+ms+SNLc9
         Vts0rFp11Nz+Se/VJzUDJlLkjE/gnWxIb7JodZinlpZGsUCzYv+Mn162a8vESLsWwsmS
         QDyilWHaReH6b8pAsrJXJ2FaUbLVy6yKwWPvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ah43YigJLYdK+A3nTEOceqnA/3FgZWTeWEFBv8nmy1A=;
        b=Z0hRcM3Tf1TyECC+pI9t83qaV0A2JXqgg4uFmgENyx6yqNxrtnn6RF5lu8asx4CjWt
         dEZ5sYv6efYSAHzc5KIS+SpFTcsTHPHw9zo1HGvJBQIIRRL3sxYAIbbbXjpHc7Y54uww
         oSgV2ObmHqh9s4PCxdSCbSn9AJxJzLaLyXaCh2QzkHe5N8JIM1K3YVmV8q7YrCUnX99R
         Va8TyYVT6WiJDPzOTVN+fFiETl2QwPoOVSh1zN9Q7nEL3WX8YBGMUPQeiQo+KXA4A53G
         6dq5EtKnDR1+Z6fjid3Grs97TK+K84EzKO0oDI7i0q+EXGZ3rWM4Ha2D6/ak2Vv4jo8j
         6D/Q==
X-Gm-Message-State: APt69E32HbwbNsG8H6d2mRrr/tpCNPiOvQmY0ahxdFo2d+cdijKOU09Q
        bugSUqhOGvWDNdAvVSkqvfBJNA==
X-Google-Smtp-Source: ADUXVKJTTLMXe974Z8heajST8TD51ZNZBTa6dJI4VRen2tMpLjP+S+W6vOn06ChWa+RoMndTKMzvnw==
X-Received: by 2002:a62:c4dd:: with SMTP id h90-v6mr14712582pfk.86.1529343952159;
        Mon, 18 Jun 2018 10:45:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 63-v6sm22155522pfo.1.2018.06.18.10.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 10:45:50 -0700 (PDT)
Date:   Mon, 18 Jun 2018 10:45:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] bus: ti-sysc: Use 2-factor allocator arguments
Message-ID: <20180618174549.GA1893@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adjusts the allocator calls to use 2-factor argument call style, as
done treewide already for improved defense against allocation overflows.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/bus/ti-sysc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 1cc29629d238..80d60f43db56 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -169,9 +169,9 @@ static int sysc_get_clocks(struct sysc *ddata)
 	const char *name;
 	int nr_fck = 0, nr_ick = 0, i, error = 0;
 
-	ddata->clock_roles = devm_kzalloc(ddata->dev,
-					  sizeof(*ddata->clock_roles) *
+	ddata->clock_roles = devm_kcalloc(ddata->dev,
 					  SYSC_MAX_CLOCKS,
+					  sizeof(*ddata->clock_roles),
 					  GFP_KERNEL);
 	if (!ddata->clock_roles)
 		return -ENOMEM;
@@ -200,8 +200,8 @@ static int sysc_get_clocks(struct sysc *ddata)
 		return -EINVAL;
 	}
 
-	ddata->clocks = devm_kzalloc(ddata->dev,
-				     sizeof(*ddata->clocks) * ddata->nr_clocks,
+	ddata->clocks = devm_kcalloc(ddata->dev,
+				     ddata->nr_clocks, sizeof(*ddata->clocks),
 				     GFP_KERNEL);
 	if (!ddata->clocks)
 		return -ENOMEM;
-- 
2.17.0


-- 
Kees Cook
Pixel Security
