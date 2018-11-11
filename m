Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59809C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22454208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1mEX1hwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22454208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeKLIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731882AbeKLIRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3BF21527;
        Sun, 11 Nov 2018 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975266;
        bh=JPUjt8Vzw/0Uv/wS2amLyYG2FuCufSl+FzUiYb8G3RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1mEX1hwhkXhlaJuASMQ1xYEteOXbNmxxBgSmWjOg9l+pmHsuZ2jo9DMleYkJQXfA5
         b4lac/JfR8KLEeOubwHLXgiu560H0H8ioJ4UV1WsFrLR5C5zK7NNSghP8gtz2xFnOu
         uIGfq5h5xMh9FH86EmpSvWqh/6CQ66uI7V7TxSoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artur Petrosyan <arturp@synopsys.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 158/361] usb: dwc2: fix call to vbus supply exit routine, call it unlocked
Date:   Sun, 11 Nov 2018 14:18:25 -0800
Message-Id: <20181111221642.688798207@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit 5aa678c7fd5371769efde30763fb43a43a118cd0 ]

dwc2_vbus_supply_exit() may call regulator_disable(). It shouldn't be
called with interrupts disabled as it might sleep.
This is seen with DEBUG_ATOMIC_SLEEP=y.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Tested-by: Artur Petrosyan <arturp@synopsys.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4482,7 +4482,9 @@ static int _dwc2_hcd_suspend(struct usb_
 		hprt0 |= HPRT0_SUSP;
 		hprt0 &= ~HPRT0_PWR;
 		dwc2_writel(hsotg, hprt0, HPRT0);
+		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_vbus_supply_exit(hsotg);
+		spin_lock_irqsave(&hsotg->lock, flags);
 	}
 
 	/* Enter partial_power_down */


