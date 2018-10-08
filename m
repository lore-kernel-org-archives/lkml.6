Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1D821479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cShUh559"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1D821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeJICA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJICA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B75E204FD;
        Mon,  8 Oct 2018 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024470;
        bh=ePhFmbzezQxKICHPewiO2ucVAZ67zK/Kq9+PUujphTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cShUh559OX5TWtRNO6RiCsQYczSvLgXB12QLE/YzcRnTjhyhW+1O76HRcciOn5TgW
         4GLdJdwjVC5bJE0/5MHVmXkXJa6z3KqdpFs/LIhp8UR3YdKumdDB4LbYI2gxKdZMl0
         aiV6/SJXSmR61Sp6aE2w/W+89HwmPQsvQqT9mils=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 050/168] ibmvnic: Include missing return code checks in reset function
Date:   Mon,  8 Oct 2018 20:30:30 +0200
Message-Id: <20181008175621.962188598@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit f611a5b4a51fa36a0aa792be474f5d6aacaef7e3 ]

Check the return codes of these functions and halt reset
in case of failure. The driver will remain in a dormant state
until the next reset event, when device initialization will be
re-attempted.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1841,11 +1841,17 @@ static int do_reset(struct ibmvnic_adapt
 			adapter->map_id = 1;
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
-			init_rx_pools(netdev);
-			init_tx_pools(netdev);
+			rc = init_rx_pools(netdev);
+			if (rc)
+				return rc;
+			rc = init_tx_pools(netdev);
+			if (rc)
+				return rc;
 
 			release_napi(adapter);
-			init_napi(adapter);
+			rc = init_napi(adapter);
+			if (rc)
+				return rc;
 		} else {
 			rc = reset_tx_pools(adapter);
 			if (rc)


