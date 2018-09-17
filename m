Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAEDECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284AB2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFlhORMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284AB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeIQSGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:06:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45352 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeIQSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:06:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so7491824pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0sS73uimJ1s5neWwBu2BrqlcqJf66GavrewFSodIHc=;
        b=oFlhORMVu5oIsw6/iceWtUuiFv5C+r0YI5zvo8zIahufmbuybHgLJt2n674G0BF7NQ
         aPA3+zk9pqx5P4J0vD4GSUSswbKqj9wWdokWc8aJau88dvAGyDnmSX9tDp1f84swWj62
         UBk4L8UfTZPf+C0makmxyvWwzFxBaGkaewNvkzrYXTmJnPYxvHq5mmkdsFowuT3BfgE4
         xQE1FeVj8WFzmqw2/pSgXBQ7d3uZGiairT2ypTgaUGTjcnwDhljQa4UIQ+KcYx7vlv8q
         /r6E4uyoSkvRazkEdLe53eH/NuoLqoJCP6d1tK88VX9ZUtOK/doxs+1jEUwE1pE4G85E
         tT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0sS73uimJ1s5neWwBu2BrqlcqJf66GavrewFSodIHc=;
        b=fBoG+y6ftAg2ZRTga4yuX+zJZ7Jz9WL7C8m5N100K5t8nrmY6gOZmgp5eq2WNY5StT
         A4hZuwi+HaGElRIhNsX52X7OWVJNf8JLYRT+kfl2J2oVxyG8p9bAYEPDF+/ZcmhlTH8v
         7bbVePTewvIhcSeorsM7YpcdU1wV0mlyRuuNnUYNe52qTiyUQpkV4eYx3tIkVoMAfzc9
         3nGg9Cm51i2IlV34XS+EysRaFL7p/V/RbNmDc9KBNR/x0F0TEiiVmmNNj8L8sue5kjtX
         f4qE/E307nrIdfDLgOR8n1ifq4i9g4x2moj/xQwOfNQcUS4vP4lcjZPrsmeNQY1xEV5b
         kNRg==
X-Gm-Message-State: APzg51Da3biJjXJSjmoYHArqbRgHBuo8LGTMufOMpZwiDYFrRj3FnxIj
        /Fe68WNE7hadMumPLvBqVUQ=
X-Google-Smtp-Source: ANB0VdYDbewcxAEeb0VPg7V0fkGB98vT38gVqfhE5CfBh/RbQW6y1ZnbChz6mD+NOzXdiqZMUhRqww==
X-Received: by 2002:a63:4606:: with SMTP id t6-v6mr23242057pga.271.1537187984038;
        Mon, 17 Sep 2018 05:39:44 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:43 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/10] staging: gasket: Apex uncloaks, plus fixes
Date:   Mon, 17 Sep 2018 05:38:55 -0700
Message-Id: <20180917123905.213639-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add a description of the Gasket framework device Apex (it's a Google
Edge TPU machine learning accelerator soon to be released), plus a
handful of fixes.

Nick Ewalt (7):
  staging: gasket: fix DMA direction for extended page tables
  staging: gasket: fix data page unmap DMA direction
  staging: gasket: page_table: don't unmap coherent pages
  staging: gasket: fix gasket_free_coherent_memory metadata frees
  staging: gasket: cleanup if dma_map_page fails in
    gasket_perform_mapping
  staging: gasket: page_table: use total_entries for max ext lvl0 page
    idx
  staging: gasket: page_table: handle failed dma_map_page

Todd Poynor (3):
  staging: gasket: Kconfig: describe Apex as an Edge TPU device
  staging: gasket: interrupt: remove PCI-MSIX-specific status check
  staging: gasket: page table: use GFP_KERNEL for dma_alloc_coherent

 drivers/staging/gasket/Kconfig             |  5 +-
 drivers/staging/gasket/gasket_interrupt.c  |  5 --
 drivers/staging/gasket/gasket_page_table.c | 61 +++++++++++++++-------
 3 files changed, 45 insertions(+), 26 deletions(-)

-- 
2.19.0.397.gdd90340f6a-goog

