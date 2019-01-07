Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D88FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4FE206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865469;
	bh=D88nfrN2iN0VEXALLtUT14XCarb1Cpm0CmuVWKJK76w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H600+VRezD8hBba8yqdVBwfZ/lmeKv12S/azVrXa/jkFc2tM5WoBDRNcBGnpk8HB2
	 HOyLaIzJX3r9tPdZcnrK1NZTkW69NKP8qmslnRB48HMuWuhea0Jxm3J+a0bIzkNUIl
	 Yz2IdLOzuj1CDEcpLj7Gh15W55xJrCkg5D01H9Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfAGMvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfAGMvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:51:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A3720651;
        Mon,  7 Jan 2019 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865465;
        bh=D88nfrN2iN0VEXALLtUT14XCarb1Cpm0CmuVWKJK76w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3JXhpwJ7/rU4gOvo+tCPx2CxvwI7z+wevPibXvwun8+SKwAUHBt/xnVVcNPw5i5k
         d6Yl2o8nG8rYWhooTWEROGxxtobp08RSNjHFP1an7b8A9jdPglhckgoxGVJ6NoBthC
         jbPvvMlJju4FuiqM+wvR+FkivEfjG6v6l9NDC3Ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.19 080/170] usb: dwc2: disable power_down on Amlogic devices
Date:   Mon,  7 Jan 2019 13:31:47 +0100
Message-Id: <20190107104502.519941621@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -110,6 +110,7 @@ static void dwc2_set_amlogic_params(stru
 	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 <<
 		GAHBCFG_HBSTLEN_SHIFT;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)


