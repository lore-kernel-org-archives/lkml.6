Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD077C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F1920880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543108;
	bh=N27+A5qJ/phjZpWjOrC/NhRNC9kE4AZ66J7Ry8WNVY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QvDcfvuz8KbfEvMZ0jcMlsax0I7o711/uJQMvRse9Dyz5sLuWJVRhcb4dNz6YrZaF
	 0ISzN8guPoX23MWsChkV2+eqVCYx0UEGX8wS4AAq9fZGsEQse98o5OVM9eN/B09lRf
	 xCs/+pJmy7Z5QtaX4cPP6nf3DFOBau/QCW3gMMSc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F1920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeLKPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbeLKPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC16120855;
        Tue, 11 Dec 2018 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543103;
        bh=N27+A5qJ/phjZpWjOrC/NhRNC9kE4AZ66J7Ry8WNVY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flqt2nByYCJ4O4XswtvtHXtnsDl7BU5MlG1tC8rare0N/ll+Kyey8nPTxkRZmy9uS
         3nKjSofhjD4PoSY60Mg4ff7ktRzs1ZjW363Xe7OqNBsv9NZD93H8rqsHPjI3doDZT2
         9jZno2gsdc7CpMR8D+Ne/OdiP3XFA6ZVehd4+ONo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 03/91] rapidio/rionet: do not free skb before reading its length
Date:   Tue, 11 Dec 2018 16:40:22 +0100
Message-Id: <20181211151606.243224733@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit cfc435198f53a6fa1f656d98466b24967ff457d0 ]

skb is freed via dev_kfree_skb_any, however, skb->len is read then. This
may result in a use-after-free bug.

Fixes: e6161d64263 ("rapidio/rionet: rework driver initialization and removal")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/rionet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -215,9 +215,9 @@ static int rionet_start_xmit(struct sk_b
 			 * it just report sending a packet to the target
 			 * (without actual packet transfer).
 			 */
-			dev_kfree_skb_any(skb);
 			ndev->stats.tx_packets++;
 			ndev->stats.tx_bytes += skb->len;
+			dev_kfree_skb_any(skb);
 		}
 	}
 


