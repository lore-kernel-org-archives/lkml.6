Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34356C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010FB217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498402;
	bh=lHLL3R4xpQt2HaYS0wL7b2mwSLFW3j+WuRDSzwnzE7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dv8fE+TYzlSmcaN2QPCbLZ2ETahDbgC1fdm4khUEAzlBZPqYvzy/J13UnE9PnaHKn
	 7ojF2LZPBpPoUWmPoL2TAQ4khimZI0H+GdwHwkd6bsXrQE6iF7xtLP1PBkGu5lsfaY
	 ONUPnMGisQLeeJS9I4Esjr2qR8XTdaFjomo6KwBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfBROAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388014AbfBRN7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479BA2070D;
        Mon, 18 Feb 2019 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498394;
        bh=lHLL3R4xpQt2HaYS0wL7b2mwSLFW3j+WuRDSzwnzE7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RseztUTg5sQf59d5StTwHHvVje4lrU35lIPcURXHBAFbgr1ow4CxbOvLr0DhnqjR/
         xZwi4KPRBr9FfanhNN2V0skdXLfjobvtKO39uPnm96cUX2kRob1KU0rTAFYYxWwbyz
         mOjNatONIJexo4QkUhF9sTbXQH1TX0PIXgk5f6+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Youn <johnyoun@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 55/58] usb: dwc2: Remove unnecessary kfree
Date:   Mon, 18 Feb 2019 14:44:16 +0100
Message-Id: <20190218133512.643639410@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5202,7 +5202,6 @@ error3:
 error2:
 	usb_put_hcd(hcd);
 error1:
-	kfree(hsotg->core_params);
 
 #ifdef CONFIG_USB_DWC2_TRACK_MISSED_SOFS
 	kfree(hsotg->last_frame_num_array);


