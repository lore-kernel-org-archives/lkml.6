Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE858C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8825020836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuG8AQ6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8825020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937766AbeFSMca (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:32:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38487 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757202AbeFSMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:32:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so93276wmf.3;
        Tue, 19 Jun 2018 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nyixbL+vRft6CxKU8b2vHJbimic3ReHAQYaU+gE0vro=;
        b=NuG8AQ6BLbeS4B0O/Lq3uv7obyEUSB4UqTzKX1IKWOWJ6Tva8PsFQQDeT7sjJwQuKj
         aYDazDvqXyaZCliTVqSq4CV6A5QNuuhFdjSoWuHgjlihrqy1A1/ewhAI/eXtJSsBF4T6
         rRtKU4ZzByP8KwQ7ZxEM51DnVnCK5ttMLxJNMJR8p3EkGlfzERUfmw7aiZ5RCxzNFeoh
         Cjkvy8ZmhA1DB76/mwcVBSdzFLsPoN5QLMmWdfEOS09PFvQQGS2LYvO5ZL1qQjpRB3zs
         Gi1S8e52n5nN7oRgvpJ39YLg4OMz8fI/hQ2HckNAGLiUdGsq4PMDWy9KKs1PPmavY/Az
         NNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nyixbL+vRft6CxKU8b2vHJbimic3ReHAQYaU+gE0vro=;
        b=JwohYcxtxU/9WXIi/9HTjMpRwCvwaTQ2NFJ4FjoKfOxW8ee8kNl9viXocKPzW2sPVT
         619+uAEqD+cBC7eMzyOy86HK+O48Ryf1b3kQOKzczkXEcNso0mdQR3hmhHzLeNDk5VpV
         jZ0ZJTOvz2lkLJMV9VUUOyPBwx6qOiL4Ufp6BDQjNHYOArfG0vRggHZhWSduh9xbMx5/
         35Buj9X7aqKcEwD7hygI3vZ2ffc8bEE1rFzlE/Bmo3n7yiSU5y+1XBLrZ/7TTMxsKHum
         uRYS66r0eRNl62fTW6xQ773bhQ7zvGps0IbZ3YCz3NGevrBhBFo/79nPKTiG4dvEL25c
         RMnQ==
X-Gm-Message-State: APt69E3DIcIBRNVyCTtFR888clKsJqLOwfGyBL8CkMMyA3ECE1fbbYQr
        AvR+TC4TezwA4ySQfmVsUAY=
X-Google-Smtp-Source: ADUXVKJlB2ePtAh3iBm1dm4WIsvfsJ7tk91DiB0DfQxzZElrz09X0rEzvhs/+xOXggpwXOjYczk6Aw==
X-Received: by 2002:a1c:d650:: with SMTP id n77-v6mr12531454wmg.140.1529411548240;
        Tue, 19 Jun 2018 05:32:28 -0700 (PDT)
Received: from kitone-HP-ProBook-4530s ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id 63-v6sm13242627wmv.48.2018.06.19.05.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 05:32:27 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:27:38 +0300
From:   Kitone Elvis Peter <elviskitone@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: REMOVE CODING STYLE WARNING
Message-ID: <20180619142738.GA12449@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a license identifier for this file to remove the malformed
license warning. This will specify which license the file is
using.
---
 block/blk-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index bd365a9..83220b9 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Block stat tracking code
  *
-- 
2.7.4

