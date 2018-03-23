Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799269-2-11556847515744830033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521799269; b=BGOi49yJmUd3jDxeLQtCNB+y2WMMinaNyL3AOYp4nGGv6qh
    TM9Hd14aVX9WUBjqfyWaKrIn1TR43bxkAloS6bqbnPAHILU3fNcbLKQ4cUR9WOUm
    Abs700bpuDdvAqiQU5CWZK7Bv2r4IjY0cdMGzGaL0zkmQYyatAiN8mLdi5rfUXfJ
    sOwG+MW6Co/5/FDoO3PMsIZaGPzH4Dz5T6cFqhLTmnu5LPyeJU5qaurvlWSE4VRH
    qGa8tF0rlBo746TEHVqhGf5Sfa/MaM6zLbKdfSjR1jWj8ZJm+miRignAUCBuficO
    aAspUxb2vLRJ12cshr7U2Zn3VkS0rOmbPfs0EEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799269; bh=/Tog9Km9BaB09ZFe4Wqvkyuyek
    sYcw5Ewe8xMv5p6UI=; b=RJ/LChK9dkp/A4bFFzwlaGTQKXhGVjHVmsnSDs0F8q
    7NIcmpFw3/dkDAinFZsaDLyJDH8aeovNRVEePGhnN0gazpffHYcdRCraY4OLAY79
    GgL/hXO3XHS3acjrrSsk2OsV0uU8gBmhuDmidXV5afP0JPOmSjbRoBjjZoa+fCeC
    PVPGsPBVX+3pWDRSS/k2VzHxlwZRwts3UXhGi+qUiNrR8Wi+etdA4b33QoxcXx/d
    iXO3lv20nMQLmoXV8RocN6R47loEzgBoGeAGViktPnrip84DcL4/FjlWaIIjTJVu
    zZEr/ruPvLXC3ZhUrWO6dHOC0uxuYa3YnCN9CbFgYMDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeCWKBG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeCWKBE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kedareswara rao Appana <appanad@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 25/77] dmaengine: zynqmp_dma: Fix race condition in the probe
Date: Fri, 23 Mar 2018 10:53:59 +0100
Message-Id: <20180323094143.903687111@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>


[ Upstream commit 5ba080aada5e739165e0f38d5cc3b04c82b323c8 ]

Incase of interrupt property is not present,
Driver is trying to free an invalid irq,
This patch fixes it by adding a check before freeing the irq.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/xilinx/zynqmp_dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -838,7 +838,8 @@ static void zynqmp_dma_chan_remove(struc
 	if (!chan)
 		return;
 
-	devm_free_irq(chan->zdev->dev, chan->irq, chan);
+	if (chan->irq)
+		devm_free_irq(chan->zdev->dev, chan->irq, chan);
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 	clk_disable_unprepare(chan->clk_apb);
