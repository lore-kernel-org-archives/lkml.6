Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE59DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824B62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543018;
	bh=8ee5csuBoPGvKgb5+WrQ3q5m/c5hSpxW2Zn5wvAOM0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rp66VF46EfZ7YZlVYtbB/vfonVKJ2YPkXalkN3CiLAFKm+FYPQ9Sqr4sOD0ENewdh
	 Gsv+bXMcwU/ysP+iviKlmUSrS6IFszxIYIHD9fPI6DV2VgkvCdXCabrExMvKzzzE7N
	 I0yDsbAycNI7wV2S0lCTOzi5SpjHNJk2HJEwZkMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824B62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeLKPnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbeLKPnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768B020870;
        Tue, 11 Dec 2018 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543012;
        bh=8ee5csuBoPGvKgb5+WrQ3q5m/c5hSpxW2Zn5wvAOM0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HRiLaTDtzq0RKVVfLNKxLgRAM/18ftJpPOWGomWDTy9FCetQzu8hKF14YGKaGEf+
         /3q1A7fJKGtJX4RX1U1iIS3VOVxTR4Nv1dqASvWUb/TRZQSRc/TD95dwlS3fZ/ESyT
         0zMGjMnYShYs25OES0XvWyOq/fm9Q5JWr//qqspY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tatyana Brokhman <tlinder@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 3.18 33/54] usb: gadget: dummy: fix nonsensical comparisons
Date:   Tue, 11 Dec 2018 16:41:21 +0100
Message-Id: <20181211151547.964103910@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 7661ca09b2ff98f48693f431bb01fed62830e433 upstream.

gcc-8 points out two comparisons that are clearly bogus
and almost certainly not what the author intended to write:

drivers/usb/gadget/udc/dummy_hcd.c: In function 'set_link_state_by_speed':
drivers/usb/gadget/udc/dummy_hcd.c:379:31: error: bitwise comparison always evaluates to false [-Werror=tautological-compare]
         USB_PORT_STAT_ENABLE) == 1 &&
                               ^~
drivers/usb/gadget/udc/dummy_hcd.c:381:25: error: bitwise comparison always evaluates to false [-Werror=tautological-compare]
      USB_SS_PORT_LS_U0) == 1 &&
                         ^~

I looked at the code for a bit and came up with a change that makes
it look like what the author probably meant here. This makes it
look reasonable to me and to gcc, shutting up the warning.

It does of course change behavior as the two conditions are actually
evaluated rather than being hardcoded to false, and I have made no
attempt at verifying that the changed logic makes sense in the context
of a USB HCD, so that part needs to be reviewed carefully.

Fixes: 1cd8fd2887e1 ("usb: gadget: dummy_hcd: add SuperSpeed support")
Cc: Tatyana Brokhman <tlinder@codeaurora.org>
Cc: Felipe Balbi <balbi@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/dummy_hcd.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -313,11 +313,10 @@ static void set_link_state_by_speed(stru
 			     USB_PORT_STAT_CONNECTION) == 0)
 				dum_hcd->port_status |=
 					(USB_PORT_STAT_C_CONNECTION << 16);
-			if ((dum_hcd->port_status &
-			     USB_PORT_STAT_ENABLE) == 1 &&
-				(dum_hcd->port_status &
-				 USB_SS_PORT_LS_U0) == 1 &&
-				dum_hcd->rh_state != DUMMY_RH_SUSPENDED)
+			if ((dum_hcd->port_status & USB_PORT_STAT_ENABLE) &&
+			    (dum_hcd->port_status &
+			     USB_PORT_STAT_LINK_STATE) == USB_SS_PORT_LS_U0 &&
+			    dum_hcd->rh_state != DUMMY_RH_SUSPENDED)
 				dum_hcd->active = 1;
 		}
 	} else {


