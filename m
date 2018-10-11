Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB070C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E72120644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T6Q4nYlw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T6Q4nYlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E72120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJKHyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:54:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:54:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DD44360C60; Thu, 11 Oct 2018 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539217812;
        bh=0aXyiwe1SAE8Xcd6d95PVJLduLYfURYgIbvrjJ+4CgI=;
        h=From:To:Cc:Subject:Date:From;
        b=T6Q4nYlwCWgPBqNS043ljrC9ys/hwqzR2RMlDQaHR4pvAhZBOl6I+yubQA4cwLzHp
         5k54CUoSsll9EOeWp20K7uS7C07INANVzHbFYWge0tnjM/rwcpo88d5tCWXBKeO71K
         o6vOkC1cwF0EDtij5QpaQ5KhFPtQVlRJ3izUSWpk=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24E62600E6;
        Thu, 11 Oct 2018 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539217812;
        bh=0aXyiwe1SAE8Xcd6d95PVJLduLYfURYgIbvrjJ+4CgI=;
        h=From:To:Cc:Subject:Date:From;
        b=T6Q4nYlwCWgPBqNS043ljrC9ys/hwqzR2RMlDQaHR4pvAhZBOl6I+yubQA4cwLzHp
         5k54CUoSsll9EOeWp20K7uS7C07INANVzHbFYWge0tnjM/rwcpo88d5tCWXBKeO71K
         o6vOkC1cwF0EDtij5QpaQ5KhFPtQVlRJ3izUSWpk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24E62600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 0/1] QCOM: GPIO IRQ wakeup using PDC irqchip
Date:   Wed, 10 Oct 2018 18:29:57 -0600
Message-Id: <20181011002958.2597-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a second attempt at enabling wakeup using GPIO IRQs. On the QCOM
SDM845i SoC, even when the TLMM gpiochip is powered off the the PDC always-on
interrupt controller can sense the GPIO interrupt as a signal, wakeup the
interrupt and replay the interrupt at the GIC.

Since, the wakeup interrupt is replayed at the GIC and not at the TLMM, it
would have to be considered as a separate interrupt line and not in hierarchy
with the GPIO interrupt line which is chained to the GIC, using a single
summary line.

The earlier approach [1] was based on configuring a PDC interrupt whenever a
GPIO was requested as an IRQ and the PDC irq line was kept disabled. During
suspend and resume, the TLMM line was disabled and the PDC line was enabled.
While this works for suspend/resume, it becomes an additional complexity to
handle when entering a system low power mode where the TLMM could be powered
off when the CPUs are idle.

The approach here is to use PDC interrupt at all times (while keeping the GPIO
irq disabled). The PDC interrupt handler invokes the action handler of the GPIO
IRQ instead. This allows us to avoid interrupt hand-offs while entering idle
states and keeps things very simple. The wake_irq_gpio_handler() is the crux of
this new revision.

This submission does not include the DT bindings and associated documentation.
Once the core design is resolved I will send a complete set with dependencies
for this SoC. Please let me know if this approach would work or do you see any
issues that I may have missed.

Thanks,
Lina

[1]. https://lkml.org/lkml/2018/9/4/846

Lina Iyer (1):
  drivers: pinctrl: qcom: add wakeup capability to GPIO

 drivers/pinctrl/qcom/pinctrl-msm.c | 91 +++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

