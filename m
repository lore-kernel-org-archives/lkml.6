Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207E6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C755921479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ruvwGaiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C755921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJINDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:03:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37880 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJINDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:03:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so259548pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6NcMaIl8d3D6UR4+uWdY83sbscXJ4RqMS51ybyZOEU=;
        b=ruvwGaiCq/tRIA2K2jgj1Af9WK4v6W2dlbJ2QJIDxliOnz276/hnYbBsa7jfLajOkm
         0aLKnbBrINdqJ3bgbg7WztoPqSSNx6Qlu2fGsFWbUVJgSXcJC1TamsiqMniQSKDPRKUB
         cCjMZYqgdQreMgRb3YVgteXLghPQwIyeiG8sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6NcMaIl8d3D6UR4+uWdY83sbscXJ4RqMS51ybyZOEU=;
        b=S/Z7KDMVLeVli7wFl1GCv7Ekb2OVtYeY3n3VpmCRWQyP5+tyDaZSW/QdbI2pEI8y0w
         tN48534t96bT+F3SMDV8WaJj/8bcxQJqzNBFlcGjgFDUUTuUePmrfnQYUnGWoSTd494n
         bxDi+kFmTe2cJDdheSVkunjE+w83d6D3bmAhqF2XnOiiCjh0KGpiI2xky7JBlAQtJOsj
         MvfWJq36zYrPTR/Mu6T2gq6jtGGTu7+2ibW+X3p31DeuLp4iHYFi4MjsR2bT3R71eRJf
         IzhWAU0cEBfmevTLo9JdC1J76uEgCHhbPSQjfZnyo2EQN0f8pMzgGwySDA3szF/6jw45
         75Og==
X-Gm-Message-State: ABuFfoj1Htrfwy5PDBwTy8HTuCk8TgK1f13YN7FihDnzYYGL92/QgAKa
        BwMU/TcUw0DsepANgSg+3Jj0OA==
X-Google-Smtp-Source: ACcGV61RLBhF+8+YOYMURmOgjSpiaVNDhZIqKE0EQNZ3ozqL8lqcZ8jVcK6ksmU9feg8BQ8Lldq59A==
X-Received: by 2002:a63:7f0e:: with SMTP id a14-v6mr24175266pgd.296.1539064084964;
        Mon, 08 Oct 2018 22:48:04 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16886234pff.8.2018.10.08.22.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 22:48:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        gregkh@linuxfoundation.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/7] NULL pointer deref fix for stm32-dma
Date:   Mon,  8 Oct 2018 22:47:45 -0700
Message-Id: <20181009054752.145978-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

While looking at android-4.14, I found a NULL pointer deref with
stm32-dma driver using Coccicheck errors. I found that upstream had a
bunch of patches on stm32-dma that have fixed this and other issues, I
applied these patches cleanly onto Android 4.14. I believe these should
goto stable and flow into Android 4.14 from there, but I haven't tested
this since I have no hardware to do so.

Atleast I can say that the coccicheck error below goes away when running:
make coccicheck MODE=report
./drivers/dma/stm32-dma.c:567:18-24: ERROR: chan -> desc is NULL but dereferenced.

Anyway, please consider this series for 4.14 stable, I have CC'd the
author and others, thanks.

Pierre Yves MORDRET (7):
  dmaengine: stm32-dma: threshold manages with bitfield feature
  dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
  dmaengine: stm32-dma: fix typo and reported checkpatch warnings
  dmaengine: stm32-dma: Improve memory burst management
  dmaengine: stm32-dma: fix DMA IRQ status handling
  dmaengine: stm32-dma: fix max items per transfer
  dmaengine: stm32-dma: properly mask irq bits

 drivers/dma/stm32-dma.c | 287 +++++++++++++++++++++++++++++++++-------
 1 file changed, 240 insertions(+), 47 deletions(-)

-- 
2.19.0.605.g01d371f741-goog
