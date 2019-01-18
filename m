Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F1AC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AEE20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jROV8S3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfARTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:32:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33232 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbfARTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:32:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so16495955wrr.0;
        Fri, 18 Jan 2019 11:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRCpHPmcL3Q/FzBd+YxD26DaTN93F71uPKvFToy/fks=;
        b=jROV8S3opgJsKR63YBxopDwZNZ3fgWttzQ6VXqkozRy3aEGlZkYWJifT79J3FTj676
         nJoh0sGh6KpKDjgGlXVe50zXCaX0QU2bLkkyT8CVB4Cq380dAFamvqPisllfhA07sgu1
         ZlOTo+aub4oGhz8hB0gYUgulFdGTs+7RNw7Xxqsdpu22iYwRMB5xNJLJX7qrkl5LXfSF
         b1Q/kwchf61WfWGgYKGJ/w9MZCanpsVWg1hBzxvD67NTOw0I6T5p3HHUm37nABEjOICS
         KbVsAML4ydfd1AZYMA2YkV7qOTxD2nmQFcOTXQH/KRwhYMdpPpb30iickRXGqxmIgF3A
         PJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TRCpHPmcL3Q/FzBd+YxD26DaTN93F71uPKvFToy/fks=;
        b=MZezzf7MVyPfGzGMMSr1+jg5E+YcjayhhQuRP1JPOZ9ZETzZiKYeNMjsSFOxBc+oH5
         o6P4gT4M7j38+jQlVkVku2Lo6eK+UYo3a+PqzcZF8jXTOTIstpMh49ZFrnTAOmPMomC5
         UVu9W+IPMsta3FjxXLWIYIfo49QjSZDs+pnKUDNIIsiP2ouYSammv3IzS2/wK8BhrMZO
         Ki5ZzZA9Q/Oa3/9bKpwv39J/9PxELywMDy5CWrVlX1Xx/DojJjaZTURWndYkBYPStsR9
         wWTQgCof9GJBcmpyJvxRd9qt058tNoq6bo+1NZrnmjIzIvok6HzyOwUa+Bmx+Zs6CkRn
         IaHA==
X-Gm-Message-State: AJcUukdJBGgCMK1OR8iGZkLF06TvjRVVofr/a+z9ErTct/pa0O+7/Jmq
        kQprsaJP8NGx0xx6UWEKBc5LCV++
X-Google-Smtp-Source: ALg8bN6xmkbtSOiTgxh9IcXWhl2ic7vVCmcefobuYAAHnNI/alulfiLgB2n9GKnV4iUDBAXLxP0FHQ==
X-Received: by 2002:adf:f308:: with SMTP id i8mr17181847wro.219.1547839977102;
        Fri, 18 Jan 2019 11:32:57 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id f15sm84035525wrt.10.2019.01.18.11.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:32:56 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 658851142393; Fri, 18 Jan 2019 20:32:55 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video/hdmi: Change strncpy() into memcpy() in hdmi_spd_infoframe_init
Date:   Fri, 18 Jan 2019 20:32:48 +0100
Message-Id: <20190118193248.535-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using strncpy() is less than perfect since the destination buffers do not
need to be NUL terminated. Replace strncpy() with memcpy() to address a
warning triggered by gcc using W=1 and optimize the code a bit.

This commit removes the following warnings:

  drivers/video/hdmi.c:234:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
  drivers/video/hdmi.c:235:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/video/hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 799ae49774f5..553c39ac8f9e 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -231,8 +231,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
-	strncpy(frame->product, product, sizeof(frame->product));
+	memcpy(frame->vendor, vendor, sizeof(frame->vendor));
+	memcpy(frame->product, product, sizeof(frame->product));
 
 	return 0;
 }
-- 
2.19.2

