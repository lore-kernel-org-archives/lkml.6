Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C3BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397EB2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544955;
	bh=LRnErc5/7x8PakxExb7XSzYdBuqndEpBhRY25UXcHOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QH0oq+2i2aSNLjqvXzX8rLRhukPXujrBNbZCrkue9cUMgA9MPM9ELSQgiox1kGQkF
	 PsjcYoHKOF0guaG0dWikvSQHghb9NDPkSuLuQnYdYvRwmQwtAA4meoScrFCWwNCJ+5
	 g4eY7jH2AdfPg73yL8gdKkWoahHQ29Ia3B9DU3qY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397EB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbeLKQPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbeLKPsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CBE92146D;
        Tue, 11 Dec 2018 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543303;
        bh=LRnErc5/7x8PakxExb7XSzYdBuqndEpBhRY25UXcHOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=do2o5CySGvSzV25Es2LOO5hewBIMUKhiby/3yPD/UFOJL0EDFdfanXWFijJ0x6Pje
         K/YjjbUTNbifqtKA+Ef+GY1o4lqkQ9QBkYKrTFHb6N1JbygJG6SoA0SZ8fJxUWypgl
         fUs4Dy2iW6SFszmNoiGRwJ0ArMrSgQCKkLaQtkEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tatyana Brokhman <tlinder@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.4 56/91] usb: gadget: dummy: fix nonsensical comparisons
Date:   Tue, 11 Dec 2018 16:41:15 +0100
Message-Id: <20181211151610.606344036@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -379,11 +379,10 @@ static void set_link_state_by_speed(stru
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


