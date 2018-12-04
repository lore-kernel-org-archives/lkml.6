Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66550C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABE32082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiR2tqHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABE32082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeLDLNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbeLDLHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:07:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E77921527;
        Tue,  4 Dec 2018 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921634;
        bh=oP1jenC2wuzid8yy8iD2xOoeCvwPRxlkrzQsI0jZpTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UiR2tqHJg144ST6DQS5BIeNXUiwL9+oS1o0mZVeHneofODhcR7djD7wBno4h/2Wuw
         3/WVb67bm8t23sSoPpsdSXFbTNoU8PLDXtwiK8BF909PKNy+WuVd2JK18rwTxoXddN
         5cOklTFeW8QD5QxPk5OQaI9nf+6W0X0E7CB8oTYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 140/146] Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"
Date:   Tue,  4 Dec 2018 11:50:26 +0100
Message-Id: <20181204103732.461330202@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit 38317f5c0f2faae5110854f36edad810f841d62f upstream.

This reverts commit ffb80fc672c3a7b6afd0cefcb1524fb99917b2f3.

Turns out that commit is wrong. Host controllers are allowed to use
Clear Feature HALT as means to sync data toggle between host and
periperal.

Cc: <stable@vger.kernel.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1511,9 +1511,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc
 		unsigned transfer_in_flight;
 		unsigned started;
 
-		if (dep->flags & DWC3_EP_STALL)
-			return 0;
-
 		if (dep->number > 1)
 			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
 		else
@@ -1535,8 +1532,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
-		if (!(dep->flags & DWC3_EP_STALL))
-			return 0;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret)


