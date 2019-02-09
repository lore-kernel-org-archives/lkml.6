Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C7FC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7912214DA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCxx4ni/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBISag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:30:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53035 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfBISag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:30:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so9478901wml.2;
        Sat, 09 Feb 2019 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
        b=GCxx4ni/0v0jcXvzeInqwPsGbcOUWXDaWdmlMH4Xy1BGkP5Y2wTRsm9/ZxykA8z+UH
         ulCcXyvAvcp/pyfkiBo4PF5C+ZQPTOk4A8+cgO2KoYDgZlHM6ITdg0FvK35Ei0nzh4f8
         qwhcW7qt0IVC/KIosW7XluABSDGkdZqRl3uRUXqi3fU6CIfqt39c/t1y5krhtQ7QXlXv
         QheBwVrOF8mUnwG3f0A6mUX3W4zHtGVZwQTEF8uk/M4piGCjuh4OyJ3IgdmmvV8giMKe
         gYkkOG+UZS/ARz/n3MZhs+KgXNoaOvSBBEzSJjJXSyKzJjdvc+4Mx0EADOQwyUmuVtfq
         6zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
        b=Ogkjny6b7mIOxUJ2r0igPnqMSW7PMlVZz/+7AmsQILYu/SyrrVWzWM1agGMdwS9V0r
         5ORoFdzaD6B2A1P/PSrfdSSF2SStseijnLp5giZ4ChX/MBP0kDj5yoKQ26tv1KNy7kGu
         ktKPE3eBgMj1AJHYtGdEJpCiJRZO3tMpJS+q1sfqipXsJ6T0wP8oTw3gSbRiyGPRZnZH
         1GXlVM98gmhGD1UNUxvf0554rnszcwtXSC2kyvQJU532KoZaNEYn05xiXnzfgyP8PHzr
         deHSK7ZPIBByMXIhDI+wCn+VGEutDLf9zVXJJEDcLxtBHFcBp5sVyaPV5MU7YD9vr3U9
         +aBg==
X-Gm-Message-State: AHQUAubzqZqvz05NkbbbWcsbHYRJ0Ni1G7VH1v6aRBXqc0c3EkF/0oSB
        dODWfACRO+rdb0d/wGE41cpgNDLRnCw=
X-Google-Smtp-Source: AHgI3IYAx/IEh5wQ3rwUXcEi18pGlhjvtWs7A3M6FRBBBhcwaYV0P7uyDUXsYZ1vNB43DXk3cME3Lw==
X-Received: by 2002:adf:a14d:: with SMTP id r13mr5867588wrr.169.1549737034313;
        Sat, 09 Feb 2019 10:30:34 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
        by smtp.gmail.com with ESMTPSA id m21sm10985171wmi.43.2019.02.09.10.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:30:33 -0800 (PST)
Message-ID: <02256c76ab48570778f12366e86ca5a84f94f105.camel@gmail.com>
Subject: [PATCH] arm64/io: Don't use WZR in writel
From:   AngeloGioacchino Del Regno <kholk11@gmail.com>
To:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Date:   Sat, 09 Feb 2019 19:30:32 +0100
Content-Type: text/plain
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo=


