Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9877DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E30521872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217475;
	bh=OoN/exucuoLXT+fnM3ky4F8iWPXon5mGZ1DPI3PxX/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bsQ93W9DfTdFNf9o91RDo1ISfyNXbwAbTWzv6edM31FCKAAE9IdOXM2j97A+uzIxK
	 PRTq/umEgDkW8g6AdZg2nhL27/ln5ZFlkJt2Vw5ku+gL3JEmsb6wf+fll6bqDfTNJB
	 CTRoWAA0eKn6+GC4m4mbn668sfhYCi8ThY4naDJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbfAKOhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390236AbfAKOhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0660A204EC;
        Fri, 11 Jan 2019 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217470;
        bh=OoN/exucuoLXT+fnM3ky4F8iWPXon5mGZ1DPI3PxX/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKVYoAASSj8F/4MbL+KXbqnB7MaCgwFithxBk0R9M7lHB3hZJfAxVN72DG7hFyiKv
         PYEqgVDTLK+mwIOTfncyAbaZN572bYxMd9DpK7yVgzKhGiFVtFKTjL5sxh15lXpEqR
         IPlSDOGprnDocESjQjaQifb6H6m5OMA0arBX1wkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/148] net: netxen: fix a missing check and an uninitialized use
Date:   Fri, 11 Jan 2019 15:14:11 +0100
Message-Id: <20190111131117.153772430@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit d134e486e831defd26130770181f01dfc6195f7d ]

When netxen_rom_fast_read() fails, "bios" is left uninitialized and may
contain random value, thus should not be used.

The fix ensures that if netxen_rom_fast_read() fails, we return "-EIO".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 0ea141ece19e..6547a9dd5935 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -1125,7 +1125,8 @@ netxen_validate_firmware(struct netxen_adapter *adapter)
 		return -EINVAL;
 	}
 	val = nx_get_bios_version(adapter);
-	netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios);
+	if (netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios))
+		return -EIO;
 	if ((__force u32)val != bios) {
 		dev_err(&pdev->dev, "%s: firmware bios is incompatible\n",
 				fw_name[fw_type]);
-- 
2.19.1



