Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB52DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6082084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545389;
	bh=9Ny32cH5Gx2+hBIkrxuRD3SlWk7SaCsev5lC8Kd9+ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dZq35ympMnf1hY0WBoXdYmR26ehXrRZH5NHv5eyu1dRPOXwIJO7aCBTpi4GyFHVZ2
	 tAEeEPhwx8gGMsjuzE6iR1Xrczq10ZdWn0cLrpG3wl1OkU9zyIdgwvai1mwywlDQyZ
	 jrSVbfTWkuz6Q5uO6XT5hZsGOEo0U22OxGCWT8GE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6082084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeLKQXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeLKPnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FAB2087F;
        Tue, 11 Dec 2018 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543020;
        bh=9Ny32cH5Gx2+hBIkrxuRD3SlWk7SaCsev5lC8Kd9+ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD7PnnW9DNijeT2ZTbqq6J75wwe/syQrF/gJVH0ML7DX9DKkc39jytwVipx/Z5xOH
         YVbb0XzXsnFDr/Vj5j61GxzifzURgmSFXun4YNLkKgvf3Ee2jybk7G4dkiPLz6uERJ
         fHsiyI5Mvj4pwNZBBYPBwET101OwoHeV8dKU9724=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 36/54] net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command
Date:   Tue, 11 Dec 2018 16:41:24 +0100
Message-Id: <20181211151548.105645780@linuxfoundation.org>
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

[ Upstream commit bd85fbc2038a1bbe84990b23ff69b6fc81a32b2c ]

When re-registering a user mr, the mpt information for the
existing mr when running SRIOV is obtained via the QUERY_MPT
fw command. The returned information includes the mpt's lkey.

This retrieved mpt information is used to move the mpt back
to hardware ownership in the rereg flow (via the SW2HW_MPT
fw command when running SRIOV).

The fw API spec states that for SW2HW_MPT, the lkey field
must be zero. Any ConnectX-3 PF driver which checks for strict spec
adherence will return failure for SW2HW_MPT if the lkey field is not
zero (although the fw in practice ignores this field for SW2HW_MPT).

Thus, in order to conform to the fw API spec, set the lkey field to zero
before invoking SW2HW_MPT when running SRIOV.

Fixes: e630664c8383 ("mlx4_core: Add helper functions to support MR re-registration")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mr.c b/drivers/net/ethernet/mellanox/mlx4/mr.c
index b7cdef0aebd6..47c2f7c5703d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mr.c
@@ -372,6 +372,7 @@ int mlx4_mr_hw_write_mpt(struct mlx4_dev *dev, struct mlx4_mr *mmr,
 			container_of((void *)mpt_entry, struct mlx4_cmd_mailbox,
 				     buf);
 
+		(*mpt_entry)->lkey = 0;
 		err = mlx4_SW2HW_MPT(dev, mailbox, key);
 	}
 
-- 
2.19.1



