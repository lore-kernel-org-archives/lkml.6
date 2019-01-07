Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67730C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385C22089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864537;
	bh=qRTWI42NaMV9Uk9My8AIZ9TDzDhv7Q4VkFCWxzKdEbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xG03/wjg/9/gFxynbfLB5YrMDDfqN8vskkl32ITRTJ1SawICnsKJY8AAAonBSEOfL
	 cU7k/H1i5VXszUlBNi+4LMlkbytTlADb/kPSCVi30uicfAmABruK5gbjaboCszvUu7
	 oSbJdbnbdI43FIAFXvE4RB3EY5rkusaYzBWZaXVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfAGMfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfAGMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FCD206BB;
        Mon,  7 Jan 2019 12:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864533;
        bh=qRTWI42NaMV9Uk9My8AIZ9TDzDhv7Q4VkFCWxzKdEbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjvTBIB2aKuq4pvzYAuN7umKe7tDUhQb9uHHMA7aiVb+qAu19vqsR1Pjh+5w07kVW
         WgX40WDozrPsiBFg2TJucqV/6ZSn/QIU2Yce8IuCodqpxeJ/1q/UecIAGMZGGrrsot
         aA5UwOIQE2Mz5tRL2FAJm0/ol73q01OQIJGYn298=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.20 042/145] usb: dwc2: disable power_down on Amlogic devices
Date:   Mon,  7 Jan 2019 13:31:19 +0100
Message-Id: <20190107104442.926586699@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit cc10ce0c51b13d1566d0ec1dcb472fb86330b391 upstream.

Disable power_down by setting the parameter to
DWC2_POWER_DOWN_PARAM_NONE. This fixes a problem on various Amlogic
Meson SoCs where USB devices are only recognized when plugged in before
booting Linux. A hot-plugged USB device was not detected even though the
device got power (my USB thumb drive for example has an LED which lit
up).

A similar fix was implemented for Rockchip SoCs in commit c216765d3a1def
("usb: dwc2: disable power_down on rockchip devices"). That commit
suggests that a change in the dwc2 driver is the cause because the
default value for the "hibernate" parameter (which then got renamed to
"power_down" to support other modes) was changed in the v4.17 merge
window with:
commit 6d23ee9caa6790 ("Merge tag 'usb-for-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-testing").

Cc: <stable@vger.kernel.org> # 4.19
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/params.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -111,6 +111,7 @@ static void dwc2_set_amlogic_params(stru
 	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 <<
 		GAHBCFG_HBSTLEN_SHIFT;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)


