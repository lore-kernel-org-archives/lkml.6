Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953F72177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499247;
	bh=73NdfoQrPli5G1SZEPbjsjyVGPA1SgDA0oRC0AqVLwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BM+0jMHrMAKzR2LFb7lO55guVq6tTwisGfEvuSFdf0PzHoarTnm6KQqqGeBP8eMlO
	 KvxddQLakJLXlej94BdSnr9iClJPJ6f2V2BR7Z49vXrHiKbF6TaACN050fn0QSKI2V
	 c75AySKay3iATqHlJ4l5r+qHN2Q6joAvxoFQirng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbfBROOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391776AbfBRONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:13:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E457B217D7;
        Mon, 18 Feb 2019 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499220;
        bh=73NdfoQrPli5G1SZEPbjsjyVGPA1SgDA0oRC0AqVLwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nsm5+IEnyRASmlAu9wdGsn5eixQLoRLTrPVFpbKSXwWL/F6QVuq9/7ive/pjRSBao
         9qkK/B+3G3sfOV6iH8YK9kTgT3ndANG/pRAAEg7EKHeKSnPRVBmiocdSmLZQ1lcPD3
         wvfVmTVo95ngn4Hpy4h2musJIUDO1Mmr8JvqwqqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Youn <johnyoun@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3.18 107/108] usb: dwc2: Remove unnecessary kfree
Date:   Mon, 18 Feb 2019 14:44:43 +0100
Message-Id: <20190218133524.625975057@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Youn <johnyoun@synopsys.com>

commit cd4b1e34655d46950c065d9284b596cd8d7b28cd upstream.

This shouldn't be freed by the HCD as it is owned by the core and
allocated with devm_kzalloc.

Signed-off-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/hcd.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2953,7 +2953,6 @@ error3:
 error2:
 	usb_put_hcd(hcd);
 error1:
-	kfree(hsotg->core_params);
 
 #ifdef CONFIG_USB_DWC2_TRACK_MISSED_SOFS
 	kfree(hsotg->last_frame_num_array);


