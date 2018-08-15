Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97498C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749802152A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YONegN+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749802152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHOXax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:30:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42221 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHOXax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:30:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so968871pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uF+sfIz7hhjrmMB6KIH9I08rwQU6IctIHtVKQdVaLs4=;
        b=YONegN+TSI2n+fhOK7vAGgo11iJoTcquP0mGmzjnkgWwLOCVtW0hRqbj48uzs4B/EW
         xTwqQNtlYUFRjEl9Kz7BUd49NziHuJ72q2ksnUOuDzNpsC+hQs6CuDiE7Gn41mEkjBOH
         E3uOuN49BfgVdJN9SOsE+S81D6Rao8tR2SrPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uF+sfIz7hhjrmMB6KIH9I08rwQU6IctIHtVKQdVaLs4=;
        b=hxj9vYgPH0k5bPxudeuDsgiELGHLT78a+Vxoyz0i/MY/cwts7F8K/c0A+1yZNemoDC
         gkwuOUUMgSGXAUzJbT+8EtFYlVYrhZGINQSK5i85A9TczrxUVl3DYC9F/QnC7kUnP9Yl
         UL35zJFQk8NxxXqEoe/n/7Vqhcd6u1jq0K+09pfA3Np6OJsLd5TQ63wV4XYtfSRO+/9P
         9jj/cpWzjrKei7wUh77fBgc6S0j53Jgz9PcNU31FXnq93o7KytFl/DAjiw3H5xv3orET
         q0PPDwiNrB11oqS3KtljuT1kUXVNPQZghrzplpPTjK8brTB0fXTlpKIYAhuJhphSRmGg
         CixA==
X-Gm-Message-State: AOUpUlF29cB5awIWR5U/OjTo78V2n4ogiS9I9NFwAwJc+0+wn4x2AYCd
        yKhQoObigkz7c0Xu6uoLKkHNvg==
X-Google-Smtp-Source: AA+uWPyazyHg+KXMUMz50O/cnd7+ObPTVzRSybjf/l84/LpFSNPnp+i41wCDzuD5vJl9qqJLOhoAuQ==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr26461820pgt.164.1534365429808;
        Wed, 15 Aug 2018 13:37:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id z20-v6sm54606269pfd.99.2018.08.15.13.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:37:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 0/6] firmware: coreboot: Fix probe and simplify code
Date:   Wed, 15 Aug 2018 13:37:02 -0700
Message-Id: <20180815203708.67090-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks the coreboot firmware driver a bit to fix some bugs
and then simplify the code by changing the design to get rid of the
different platform drivers, remap memory with memremap() to fix sparse
__iomem issue, and finally simplify code. There's some risk in changing to
memremap() but I think that should work out alright. It will either return
memory directly, or fallback to ioremap_cache() as has been done before.

Changes from v3:
 * Dropped last patch for resource reservation 
 * Pick up review tags on patch#1
 * Always unmap memory for table instead of keep it around

Changes from v2:
 * A bunch more patches
 * Fix iounmap missing on error path
 * Fix bus getting unregistered on driver unbind and never registered
   again
 * Request exclusive access to table region
 * Pull out table signature check to driver probe

Changes from v1:
 * Split out fixlet for DT based driver from platform driver change

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>

Stephen Boyd (6):
  firmware: coreboot: Let OF core populate platform device
  firmware: coreboot: Unmap ioregion after device population
  firmware: coreboot: Make bus registration symmetric
  firmware: coreboot: Collapse platform drivers into bus core
  firmware: coreboot: Remap RAM with memremap() instead of ioremap()
  firmware: coreboot: Only populate devices in coreboot_table_init()

 drivers/firmware/google/Kconfig               |  26 ++--
 drivers/firmware/google/Makefile              |   2 -
 drivers/firmware/google/coreboot_table-acpi.c |  88 ------------
 drivers/firmware/google/coreboot_table-of.c   |  82 ------------
 drivers/firmware/google/coreboot_table.c      | 126 ++++++++++++------
 drivers/firmware/google/coreboot_table.h      |   6 -
 6 files changed, 98 insertions(+), 232 deletions(-)
 delete mode 100644 drivers/firmware/google/coreboot_table-acpi.c
 delete mode 100644 drivers/firmware/google/coreboot_table-of.c

-- 
Sent by a computer through tubes

