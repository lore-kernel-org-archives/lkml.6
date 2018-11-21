Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979A0C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDEB20878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C+XsB/9a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TohyuiMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDEB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeKUKjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:39:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48064 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeKUKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:39:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 25552607DC; Wed, 21 Nov 2018 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758841;
        bh=ymWRLdxhtGffimJs0ImqbZeoiQqqToKmXnV5nJowi8U=;
        h=From:To:Cc:Subject:Date:From;
        b=C+XsB/9a+AQ4j44cE0vv9xHKLZ08Vl3r/jynNbvVvBxCu/tgGtqFrWwSWldRj6liY
         JdexFzZoTdR41HPlqZ7z6nzYUOX3yI6gBoHMPCaYnWRhuJ5+TPeKdnVGFcj+GkeC1z
         fT0gIzxAtfyeaPaO5/h4AOQaLfsBKoDiz8sf9MPc=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B62AA6071B;
        Wed, 21 Nov 2018 00:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758840;
        bh=ymWRLdxhtGffimJs0ImqbZeoiQqqToKmXnV5nJowi8U=;
        h=From:To:Cc:Subject:Date:From;
        b=TohyuiMxns3IX+E4zXPd6Mk4DGblcalw/6Tk62SES1oCLEiAC6avSrvcVVLnNazF3
         bWVsgfKJ1wk90bGxOkdkybxHvhgs1Ic8cce0cmir+I6E+Det2WmnjivQlgr+HATuep
         jICdrVOdckV5ej0Ih79Ncqq5Muh3EJuOF/qVUyfc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B62AA6071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, Lina Iyer <ilina@codeaurora.org>
Subject: [RFC v3 0/3] qcom: GPIO IRQ wakeup using PDC irqchip
Date:   Tue, 20 Nov 2018 17:06:45 -0700
Message-Id: <20181121000648.29262-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an attempt at using GPIO as wake up sources. Based on discussions with
Stephen and Marc [1], the idea that is used here is to make PDC interrupt
controller the parent of TLMM irqchip. Wakeup capable GPIO IRQs have
corresponding parent interrupt in PDC and therefore the GIC. The TLMM irqchip
has a summary line into the GIC for all regular non-wakeup interrupt. 

This idea uses Thierry's hierarchical GPIO [2] and is dependent on [3]. Also
PDC device bindings published in [4] is needed.

Kindly review the series.

Thanks,
Lina

[1]. https://lore.kernel.org/patchwork/patch/998238/
[2]. https://lkml.org/lkml/2018/9/21/471
[3]. https://lkml.org/lkml/2018/9/21/474
[4]. https://lore.kernel.org/patchwork/patch/1008046/


Lina Iyer (3):
  drivers: pinctrl: msm: setup gpio irqchip in hierarchy with pdc
    irqchip
  dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
  arm64: dts: msm: add PDC wake irq maps for GPIOs for SDM845

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |  31 ++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  18 +++
 drivers/pinctrl/qcom/pinctrl-msm.c            | 125 +++++++++++++++++-
 3 files changed, 169 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

