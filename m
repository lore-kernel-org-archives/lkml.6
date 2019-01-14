Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E12C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9797320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjFyBcUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfANUhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:37:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35788 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:37:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so470982wrb.2;
        Mon, 14 Jan 2019 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNsUCW3IX5YhvZ4wutoYkRwo7UB+mjQVCtnUyjE5oVw=;
        b=mjFyBcUfgGtxROVMFfVLlkeZbF38nROKq8P4UVZ+kDAX30+37/qLihGi+lq969DQR+
         SMRXJVlD3DRv5/IVITKlFUwZLev60SN+JtLqCRtzv+lPO3D0qAlO3PuWRCvoTsceqW70
         qkSd+epzkSvJVz6IA8rC5SMpWQqilvXAaG58ld7/OdzCPxORR/vuJ1PgdpaszEw7H4jH
         8WHcSXoaZqu9vDJEfl6wGlxM5PP0Mpq3sFh1tjyJxJ7VKTK04pH15r90w7E7BBpb7Zcx
         Yki8X9gfb9BsabOaeRQ8oNqxueXbzqEalPvm0Z12fd+Qr2VJPpcNH8qtcU1mzm1YMS+W
         cGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qNsUCW3IX5YhvZ4wutoYkRwo7UB+mjQVCtnUyjE5oVw=;
        b=gkSswtNBXCNNBXFPcYz5ypHDbbFG8PmbEM6e3MaREwj19/xpu1mPF/S781dst5sdV7
         TSeHCyZ4JKlPogEPlKZYQ8ugiKtKHWJHvf8CBY1fXUlzS2wjP8X4BP3/EVuZ9wjTbM4W
         v2lTUV9S8ntswuSsQ185hr43G3S0fnYznjFwS8W7vyRFTgRBtPp+BFkGDBW97LOP+Ric
         7r+3oIHqBmfB7TIgC+bRCHtn2xLSrgodL1g/XLmcmH2+T47SNvdsu4RNrn5TRPy6hhMo
         Li1Zc0wrl86jeUXlgPa3Vu+qb8AGDFARspueAXmCFDNBxCS+FLnR1oPw2CfOMVmtHNMN
         f8EQ==
X-Gm-Message-State: AJcUukf4lGW99JdDA++qJOTIqlUYCUnw6DOCRa5ERY8YrqqbjEata8dr
        jD76uqlh6/hAK+m07/Y41sEAGKc1
X-Google-Smtp-Source: ALg8bN6+OWF+tVwpI5vAbJ7ax91jQQdel8+qLuxfP8y/6zj+BDeO6JPXx5X2TI8CxZPxAPF2trv1kg==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr229944wrf.206.1547498264049;
        Mon, 14 Jan 2019 12:37:44 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id b18sm70803460wrw.83.2019.01.14.12.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:37:43 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 468EA11422AD; Mon, 14 Jan 2019 21:37:37 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/signalfd: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:37:34 +0100
Message-Id: <20190114203734.19294-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  fs/signalfd.c:178:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/signalfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 757afc7c5895..44b6845b071c 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -176,6 +176,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 		if (!nonblock)
 			break;
 		ret = -EAGAIN;
+		/* fall through */
 	default:
 		spin_unlock_irq(&current->sighand->siglock);
 		return ret;
-- 
2.19.2

