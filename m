Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D202089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+JpIx0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D202089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeJQBF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 401502147C;
        Tue, 16 Oct 2018 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710074;
        bh=2W62ejOOyKCTJjksUn6cLMrBpWsZtgErsP0XQvtYlZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+JpIx0i23D9ySiEiwYxUpmvEIV7UbqsW96/0Fu4v0pMmxZuKSvC2GPAquiNAFcvq
         Lh8BPARWj3YArZXtraei8IOpb2cujo9pioaw9qbd8R6jtR7mSHfs/NojnvbGzoHN3w
         hICvET+0j7KsqilGu9XdmaIhO/yygp67f6tDBQA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jongsung Kim <neidhard.kim@lge.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 095/135] stmmac: fix valid numbers of unicast filter entries
Date:   Tue, 16 Oct 2018 19:05:25 +0200
Message-Id: <20181016170521.908754240@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Jongsung Kim <neidhard.kim@lge.com>

[ Upstream commit edf2ef7242805e53ec2e0841db26e06d8bc7da70 ]

Synopsys DWC Ethernet MAC can be configured to have 1..32, 64, or
128 unicast filter entries. (Table 7-8 MAC Address Registers from
databook) Fix dwmac1000_validate_ucast_entries() to accept values
between 1 and 32 in addition.

Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -67,7 +67,7 @@ static int dwmac1000_validate_mcast_bins
  * Description:
  * This function validates the number of Unicast address entries supported
  * by a particular Synopsys 10/100/1000 controller. The Synopsys controller
- * supports 1, 32, 64, or 128 Unicast filter entries for it's Unicast filter
+ * supports 1..32, 64, or 128 Unicast filter entries for it's Unicast filter
  * logic. This function validates a valid, supported configuration is
  * selected, and defaults to 1 Unicast address if an unsupported
  * configuration is selected.
@@ -77,8 +77,7 @@ static int dwmac1000_validate_ucast_entr
 	int x = ucast_entries;
 
 	switch (x) {
-	case 1:
-	case 32:
+	case 1 ... 32:
 	case 64:
 	case 128:
 		break;


