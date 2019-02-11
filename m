Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8A7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF95B222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898121;
	bh=oqnp1PsJqeH0S6ezSHuU7DZ3bJbzlsDCvBfnveAY3Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iihxYdBEQAmPM0NLgVeVO0qduT2pAe8UrXmaxm3s00vdLje/V/iSUxDbq8wKBhzO9
	 BoSaXorGqMBRheSArwKh616Nkr8dQ4Lq6PWKmFnvPHcYTP4MmiCJSmKbaozdDeR63Z
	 j4yDE8u2go8Vr73hG6qzAymtWlrZQ95BsAN98su0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbfBKPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:15:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403813AbfBKPHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B689222A7;
        Mon, 11 Feb 2019 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897666;
        bh=oqnp1PsJqeH0S6ezSHuU7DZ3bJbzlsDCvBfnveAY3Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AY9bzJVgxrexmgIceHS0rFO7DcVMnY5RS6WTUeW8Y2dUH2H0rwedY0HaxeveaK9LN
         xSsFbeftOFigAgBUvMxTiyFVi0hLJmMUvL2+/cR/KW4pzeXuDsl44nk9MAGlu2IJWH
         p3SflZneoZxk8GFvEK+1xIKyxSht657dsGUifNUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 074/137] i40e: define proper net_device::neigh_priv_len
Date:   Mon, 11 Feb 2019 15:19:15 +0100
Message-Id: <20190211141818.876079401@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

[ Upstream commit 31389b53b3e0b535867af9090a5d19ec64768d55 ]

Out of bound read reported by KASan.

i40iw_net_event() reads unconditionally 16 bytes from
neigh->primary_key while the memory allocated for
"neighbour" struct is evaluated in neigh_alloc() as

  tbl->entry_size + dev->neigh_priv_len

where "dev" is a net_device.

But the driver does not setup dev->neigh_priv_len and
we read beyond the neigh entry allocated memory,
so the patch in the next mail fixes this.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 57c7456a5751..7836072d3f63 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9194,6 +9194,9 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	ether_addr_copy(netdev->dev_addr, mac_addr);
 	ether_addr_copy(netdev->perm_addr, mac_addr);
 
+	/* i40iw_net_event() reads 16 bytes from neigh->primary_key */
+	netdev->neigh_priv_len = sizeof(u32) * 4;
+
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	/* Setup netdev TC information */
-- 
2.19.1



