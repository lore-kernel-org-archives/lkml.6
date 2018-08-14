Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82956C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7722170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="q0+zuVLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7722170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbeHNQEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:04:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37425 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:04:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so15345678ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKVjPK8tv5iB+OXMv7YvO3q4b+l5mYBjMsHI0wcHlX8=;
        b=q0+zuVLNGTyqUatyBHxcSPYiKgXSV0UiSqKN4c+rrzlVvP0fH4gmypJ6PPAW68fNmx
         xBSKd2685/RBpI52v19YME6D/ALsJywYuXWMIOXHkvmLCFOuWlAYpCMowTMH9HwBNci6
         ld9ZyCgoSrDhgkFxbTAYW8tJyAOqlfItB7wzgdIzOGyLJSRKYerwvYAF4e9MkBbTGs/W
         sC8JxSdK6uZY/Gdsn8BHmmjcoR6JXCDRUJa+Se+4Mw+2v+O5SjVmmrl/9Hdpo/dx9hmg
         rN6WhwGEFFnHo8bfcq0o0GHq3pJLGlhiIRvJaAiGcMWbwtaatmk4yY9Xyaymgh/g6p09
         NEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKVjPK8tv5iB+OXMv7YvO3q4b+l5mYBjMsHI0wcHlX8=;
        b=d96A/yHloKBPxF1AnvoY15uStA1F0e3s1VapzgChvyAgmsE9ku8LJirvvLVkGrD56a
         0QRx956suoCUwXdcm4RDOASJ3EVtAtfP+x35IbjmlM3mK0A166g43g6X8xDLaoKF0yJy
         UJ6TKFOyf1hLgoqoNV37L2pSDc4Bu4PRBDYM4WeCS6OqIfrZ1+cbBFLGIzL1LOMgxhq3
         RBxQMJgXZuvwYxzhlr79Zha2CyfKfLpyJRJMxhyFwId0ymg9HFkgumihehGU6tOEXtIo
         NalWmH5uhnaV2V8VoFVffw6fdxsbC46qSmlxvLzZMbJf5I7RXwYH3vNvqFPdNW+rA+9i
         4JjA==
X-Gm-Message-State: AOUpUlGmNaOVXf1OesZls0uYNAhJeGF3dLjchtq78N3xpZnP6CoC37eP
        ae3B6adNqbF49kETJtUXy+DONA==
X-Google-Smtp-Source: AA+uWPyRq8uaCFJDHuXBPe6/wcmCHR6WQ8K+0PrfjjAAVYu5jN6Ipija1ljg5Sr6wPoBvykZU1S+fw==
X-Received: by 2002:a2e:2067:: with SMTP id g100-v6mr14844151ljg.138.1534252665965;
        Tue, 14 Aug 2018 06:17:45 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id r73-v6sm3926320lfi.34.2018.08.14.06.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:17:44 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [RFC PATCH 0/1] lightnvm: move bad block and chunk state logic to core
Date:   Tue, 14 Aug 2018 15:17:34 +0200
Message-Id: <20180814131735.6853-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
core.

Javier, would you like me to pick up your 1.2 chunk state patch and
merge it into this one, or would you like to rebase on this later when
it has been reviewed?

Matias Bjørling (1):
  lightnvm: move bad block and chunk state logic to core

 drivers/lightnvm/core.c      | 166 ++++++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-core.c |   6 +-
 drivers/lightnvm/pblk-init.c | 116 +-----------------------------
 drivers/lightnvm/pblk.h      |   2 +-
 drivers/nvme/host/lightnvm.c |   4 +-
 include/linux/lightnvm.h     |  15 ++--
 6 files changed, 122 insertions(+), 187 deletions(-)

-- 
2.11.0

