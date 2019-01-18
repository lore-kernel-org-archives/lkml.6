Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7E5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8622520652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf4nNOEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfARODi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:03:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36409 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfARODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so15203705wrp.3;
        Fri, 18 Jan 2019 06:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WR1nFNQ/cxF8iimNSvdE701p5pXzi5nUdfvJequTVDc=;
        b=Hf4nNOEwcdvIiWlwcHar7yGe3wlCEQY+rm54PfaQ55CjCH1f+yyQQey9kkPN2oAOgg
         mUV0ZtLVNJN28AETiCI1WDlY4UcllKLBdm2lp/VSI2zPoXHs9oo68nwZlJGeNgdbFIla
         PpSXz9bOBQRXpXdmZ3702CJEowwGoGks1HRl0qgtfz8+BJN4yd7kbQtNlR/CtskGBh0S
         qJqn3JjLyRAB20KoGknypj4RWSNDD0R/ZX/fE6hxN7L53gBw/PDwD4miX25aYYpUjGj9
         /d80N8mKDQKvesFZOMp8YpjePqSXlp5vnLypvBV5ibqntqB3ZD/FHb4znDzOVfwCKYwJ
         dGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WR1nFNQ/cxF8iimNSvdE701p5pXzi5nUdfvJequTVDc=;
        b=DZoGQidAjgMMdvkQcOYNthVdnZkzYn+cyU5kRwkvjK5MGNRl1ChTKJwjHh2HZEw1Jj
         0swUSs+PwM+Op1mLX9fgX864dKqe9b1KP+qXCCA2ylUvQAp9fIQQTl6Y7D8y4OknbUw1
         2RvYuiaN5SHMd6QaBuaWFR3WIX01ceLDxWRo1mW5/bXXxFKvqZ8kmZidse4Ft0Aus8cf
         fdUAR861yeLsXbaH4L2r4MgpcR/MR/OAKvKM6bbBjXB4tTvU9MZHkaE6bT3UWzQZu5Ih
         r0bVP0NduOq/mke8losklhYSp7mla6XyzxgTcSwceIBbkEMTsxwKH8IxWK/FGizIoFDl
         tT1g==
X-Gm-Message-State: AJcUukfiM8YUDBPbub7XB4Oiozx8NBqXCpQ+rTrYN49GLV5SD73eu6zV
        KDj7YjTAPTy367mA9z1tm80N4dv7
X-Google-Smtp-Source: ALg8bN7DDKCKo+OD01EwDbnqiGZmEOiAnBYhA8dQ6hmHS/xAphe68sGBh5+hhQykxng5lflL98ycGw==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr16293255wru.291.1547820215961;
        Fri, 18 Jan 2019 06:03:35 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:35 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 0/7] hwmon: adm1029: Fix most style problem
Date:   Fri, 18 Jan 2019 15:03:22 +0100
Message-Id: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Thirteen years later, coding style have change a bit.
This patch series fixes the gap.

This patch serie was tested on my precious so rare real hardware.

Regards

Corentin Labbe (7):
  hwmon: adm1029: Remove write to FFF paragraph
  hwmon: adm1029: Add SPDX header
  hwmon: adm1029: replace S_IXXX macros by their numeric values
  hwmon: adm1029: Add blank line after declarations
  hwmon: adm1029: Fix Logical continuations should be on the previous
    line checkpatch warning
  hwmon: adm1029: Fix function alignment
  hwmon: adm1029: Add a comment for locking mutex

 drivers/hwmon/adm1029.c | 67 +++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

-- 
2.19.2

