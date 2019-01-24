Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49A0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FFC218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSn5gDEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfAXUZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:25:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38572 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfAXUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so3161709pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eg4nAxAXcXkNuIrbMcRJ+fzvQseMFVGhfj9rOi7KduU=;
        b=jSn5gDEIAVqq/AsVfDWAu0cGimFUSBivUdA0jPLdipy5yoRP9CWxJzi1zQ59dvybAW
         jvjR+VnSVekOGEjqOUEWyqo0R1j4cCywBZ6FW2ye97UtP6Boq3i2a/UOzdAx7SU3BsB0
         Gwf6ETiR4Mwx3orGx63y00EwLkMdPy5sceqXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eg4nAxAXcXkNuIrbMcRJ+fzvQseMFVGhfj9rOi7KduU=;
        b=HHBEOwvW5s+rPojbyFuC2gtl6q/veeFYFt8+0YWR74pLB4urIvliDCNgqbHjLUaj9U
         dIBIbsIksL4K7t1p1ZXtvbsM3Hh8GZ3ThcfYNguIQZgB1Z5h5Z7wNg4Wzc5ebnoXJ5id
         FVHlHmsaJemJxHOwySOXmR4CBc6DuSAIC3yyfUi7RNjFyYpi1Njz521gKEFEfQMrvefF
         59kugucBkpVCBDvTJbYEcKSp1LH+mYMsI9OqG7VxeZtXUotA00PyLIefkFhP5Xzbyzps
         HnQZSgcZVWdummyEv+LD4kIn5JTmjfMZTWqY/KknDe13zlXWHUTZ9GtUpVoSxWqbaQb9
         qqLg==
X-Gm-Message-State: AJcUukfSLYXK+7wm8fEEvx/Kam3KLxdqCObSbo74jSxnFGtHJebyQ71M
        AZ2BOJKJj/94PdVKd9A4VGmxkwlP+26+Mw==
X-Google-Smtp-Source: ALg8bN7WMfoTVni+wJrJRkqP8mH/wMyNUMBD9xBmHZIeZSxIsBVF3ZVCZzEcn9jiM+sY2nBzMuKDwQ==
X-Received: by 2002:a62:a209:: with SMTP id m9mr8111866pff.218.1548361471229;
        Thu, 24 Jan 2019 12:24:31 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:30 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/8 v5] Documentation: bindings: dma: Add binding for dma-channel-mask
Date:   Thu, 24 Jan 2019 12:24:17 -0800
Message-Id: <1548361463-28372-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dma channels can be reserved for secure mode or other
hardware on the SoC, so provide a binding for a bitmask
listing the available channels for the kernel to use.

This follows the pre-existing bcm,dma-channel-mask binding.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Renamed to hisi-dma-avail-chan
v4: Reworked to generic dma-channel-mask
---
 Documentation/devicetree/bindings/dma/dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
index 6312fb0..eeb4e4d 100644
--- a/Documentation/devicetree/bindings/dma/dma.txt
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -16,6 +16,9 @@ Optional properties:
 - dma-channels: 	Number of DMA channels supported by the controller.
 - dma-requests: 	Number of DMA request signals supported by the
 			controller.
+- dma-channel-mask:	Bitmask of available DMA channels in ascending order
+			that are not reserved by firmware and are available to
+			the kernel. i.e. first channel corresponds to LSB.
 
 Example:
 
@@ -29,6 +32,7 @@ Example:
 		#dma-cells = <1>;
 		dma-channels = <32>;
 		dma-requests = <127>;
+		dma-channel-mask = <0xfffe>
 	};
 
 * DMA router
-- 
2.7.4

