Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D37F20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D37F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbeKVO7e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:59:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41326 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbeKVO7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:59:34 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gPgV6-0007Ro-Di
        for linux-kernel@vger.kernel.org; Thu, 22 Nov 2018 04:22:00 +0000
Received: by mail-pl1-f197.google.com with SMTP id o23so13217441pll.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 20:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=SwfVJwcusDqOQQr0es6wUcr/zCOiXElc+NvMKi7lSFA=;
        b=tAnBK5pr5eTTtv2kXbeYZGDBLXnLfTYZz46tEspfhPYI2e9mzqPS/oSuHovXeLCOK3
         uXdP7vHswawN8KziKT/qjtZwlQJztoa2RT6VUUG61aH+hzVqJAVqn1MeBuS/OU1w73Sh
         G4/tlYNsobxQ7Gc4XCKL2d2Pspf1T4LjCyf2oSHmlYdIxz1jsfYugZYpSelj16uhyNXH
         l0CNWXGm0Lx9HbWtOQKx0/qN+hxYptKfCFa8pPYdTCSh9DcDJW+PsS/A+hPlKLhG6LzE
         xr2ErnqCKTwk9f3dupZbrcvD6c/D09GcvwKwjn6ZTFeHczXjCt8dTk+mMKQ1tCKbpK/O
         bCBw==
X-Gm-Message-State: AA+aEWYekXfuth9g45x4q0XPdKPWn7gPB6ZzLZ9nKGEdu8MQ54LLiyli
        goCS6dZMEkn7yvaOmuYDWr11AjgX3jCZ8HlAzzm2JaMuQ0lKqHazuwBBmU8jFciKCtMKmpdXSSw
        8MXF2sEi+FUnxjcqfKMyoySB0tA8+edGiFrsfwzQ6KA==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr9474924pls.71.1542860518873;
        Wed, 21 Nov 2018 20:21:58 -0800 (PST)
X-Google-Smtp-Source: AFSGD/V8HxKREmp5XxIcehYQRK/R8yaHgHPBhQR8KcOVfSa4wDdKdMw4Yk6yEMEHi4Ny2+Yr4ru1nQ==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr9474913pls.71.1542860518492;
        Wed, 21 Nov 2018 20:21:58 -0800 (PST)
Received: from 2001-b011-380f-15ec-6889-e40d-7ea9-e9bb.dynamic-ip6.hinet.net (2001-b011-380f-15ec-6889-e40d-7ea9-e9bb.dynamic-ip6.hinet.net. [2001:b011:380f:15ec:6889:e40d:7ea9:e9bb])
        by smtp.gmail.com with ESMTPSA id s2sm24973144pfa.167.2018.11.21.20.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 20:21:57 -0800 (PST)
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Elantech SMBus support regression
Message-Id: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
Date:   Thu, 22 Nov 2018 12:21:55 +0800
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

It appears the Elantech SMBus support breaks some users’ touchpad.

Please have a look at [1] [2], thanks!

[1] https://bugs.launchpad.net/bugs/1803600
[2] https://bugs.archlinux.org/task/59714

Kai-Heng
