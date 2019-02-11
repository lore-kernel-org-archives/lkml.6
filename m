Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC1AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECA920844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896768;
	bh=9HTQkLKx+YCLPB1vQEgMyj8AkySdVQ5Pmnv45YxaoPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tYc4FGDJnULDpYBUKwnqDU5xScuCX2xW0Q/1SoFXura9+eveXIjUTMpgcM7ivx8Lg
	 cn588bWgRp1XHo2jO7xl3BWSIOOLKM1ey6wRIPIHWd8HNN/z4QhdyCBpKBfpQtBWCa
	 tahbr+CGDDAJ60Zs/mccaOxHV81YNx9Hh63cUaMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfBKOwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbfBKOwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB1F2081B;
        Mon, 11 Feb 2019 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896764;
        bh=9HTQkLKx+YCLPB1vQEgMyj8AkySdVQ5Pmnv45YxaoPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/NH6EVgExJUrkPzPHQ3nGe4UZrP7UWTREiGI8zDZEI4u5FL2O4Oma4gK6YdRYGPf
         R9zkqbHLazz0I6FgukpWS6y8IMO3B7yUlldLNZtvrovza6DTDDGtJ6Hod9WV3vA0ZW
         YGD5j6KfmEEISJLjPcSBQGfcnCpVdMiid4F1RzIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejas Joglekar <joglekar@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.19 294/313] usb: dwc3: gadget: Handle 0 xfer length for OUT EP
Date:   Mon, 11 Feb 2019 15:19:34 +0100
Message-Id: <20190211141912.659301674@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Tejas Joglekar <tejas.joglekar@synopsys.com>

commit 1e19cdc8060227b0802bda6bc0bd22b23679ba32 upstream.

For OUT endpoints, zero-length transfers require MaxPacketSize buffer as
per the DWC_usb3 programming guide 3.30a section 4.2.3.3.

This patch fixes this by explicitly checking zero length
transfer to correctly pad up to MaxPacketSize.

Fixes: c6267a51639b ("usb: dwc3: gadget: align transfers to wMaxPacketSize")
Cc: stable@vger.kernel.org

Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1110,7 +1110,7 @@ static void dwc3_prepare_one_trb_linear(
 	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 	unsigned int rem = length % maxp;
 
-	if (rem && usb_endpoint_dir_out(dep->endpoint.desc)) {
+	if ((!length || rem) && usb_endpoint_dir_out(dep->endpoint.desc)) {
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
 


