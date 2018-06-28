Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24139C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CAA27870
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py3z9jLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CAA27870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964935AbeF1TSc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:18:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42115 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbeF1TS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:18:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so6580505wrs.9;
        Thu, 28 Jun 2018 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J58y/sLNb7E7YVn6UiUyK9j6n3k7DA84brmUUI/Mrh8=;
        b=py3z9jLhdb/yHex2cgDOmFcBsnCykuv1Yeli6nL8cNp/1GJFrcgN7mMv8iNlT1ZNRi
         SfQ/mEdiVx+LNUsX5z6EDqRRYUc9yyp1vAORm7TRQ2isVjExe5dW2rPJ61SYg7YNhT/m
         Bjx8jagKwOsTsqaEt0rCnch7U7wBM+JoEtDLWDNY1HL6ZAn/wFn8CFYE1tFwU+jCrMMX
         exnnEka0D37gynUugZEJVfVv2Krl16VdQrtllKykkNyVehHoY32HfRcupahalqwb9bzh
         pFKXEcBKghma0L0A3ID0JSFOI/1cjwiZwKRW45iCruWOVWt6++e4rPO8Mkx5Rh45bTZS
         D9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J58y/sLNb7E7YVn6UiUyK9j6n3k7DA84brmUUI/Mrh8=;
        b=N7kinWzAWlBBeFGGK9rEQtVhZ1FV8dXWPtZc3DQGDhev8HuKX5VKK9OntcMGuhI9+r
         bHdxmL1NM6fTo+7Oyz7Jy84qSMZK7Or+YFu1cv0/Ze/cedZ/4Raq75gwGJPUo3wEiQ8/
         7fSa6uK9NwmiBkYwPjhLdTqt3K9obtAw20GKJxjSglNE+856cGhk9w1kJVPgMBlwDnZf
         Y8g0kwOopA+l0PfGimITqNwZk9XfPjWfCPCpxQ3PKf3dXjjBTWeizMQHQ59FBD8qjOXW
         vlLWRl+H20GtuccwuaRpGeUjU8nw6ONAzcU/y265y0RHLc2rXXRu/oPj8cCt9qWDfZlj
         W/PA==
X-Gm-Message-State: APt69E0iIwY5udDrteYnNIMMY+2SW+WubZw2N+CFZ5o9kL2GrV05W4I2
        a54Yjqyja6pJXBhyRPDtcb2h+9b7
X-Google-Smtp-Source: AAOMgpdxjOc3bxbdaVr1wZFRnNHT7bhwkBXT/WjlpbKjwUYSf23ZBmnp7GlaN0icIhXU8qc2/tQz1w==
X-Received: by 2002:a5d:4902:: with SMTP id x2-v6mr9761913wrq.66.1530213508375;
        Thu, 28 Jun 2018 12:18:28 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7CDF.dip0.t-ipconnect.de. [91.63.124.223])
        by smtp.gmail.com with ESMTPSA id r123-v6sm12289559wmb.21.2018.06.28.12.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 12:18:27 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, sboyd@kernel.org
Cc:     pn@denx.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, manivannan.sadhasivam@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 0/3] Add clock driver for Actions S700 SoC 
Date:   Thu, 28 Jun 2018 21:18:02 +0200
Message-Id: <20180628191805.3722-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626192820.28237-3-sravanhome@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog v2:
Fixed 0 day compilation warning
Modified existing dts Actions S900 clock bindings common to Actions
Soc family

This patchset adds clock support for Actions Semi OWL series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (3):
  arm64: dts: actions: Enable clock controller for S700
  clk: actions: Add S700 SoC clock support
  dt-bindings: clock: Modify Actions Soc clock bindings

 ...ions,s900-cmu.txt => actions,sx00-cmu.txt} |  18 +-
 .../boot/dts/actions/s700-cubieboard7.dts     |   7 -
 arch/arm64/boot/dts/actions/s700.dtsi         |   8 +
 drivers/clk/actions/Kconfig                   |   7 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 614 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 128 ++++
 7 files changed, 768 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0

