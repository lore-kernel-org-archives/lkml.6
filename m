Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194EE217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129873;
	bh=UmKk5lsprCInIgerTBwZMeKvxG2BzTecr+6rKrr4rN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lrFLeltbsQsXAkLdXXFrRdyt6vU6q4Y6Qx5+AReAJYGwMeZHMoYZyvUE8qJHlNh0g
	 fsza1fyo4paHTtvMQLh8egh9QwrdyajGXZhnmYiUVI29oVBC/YSe0Prvo2FNuAgyzH
	 XhTdMjS7AxxO24gZPvXq3l5I5xX96+TH8RE1JZSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfBYVYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbfBYVY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743A821734;
        Mon, 25 Feb 2019 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129869;
        bh=UmKk5lsprCInIgerTBwZMeKvxG2BzTecr+6rKrr4rN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9DMN16S4hiuavXl5YRlYzt5GPCrhvz2XDbQ/UbVSr1RT+j4pzvOYPcp8mvfnxj4T
         Sg44EMhv7CGKZK4XzNCDtMx+qZpQYimnzVgGNPs7S6H3PPogbcm9fNnCNe+fdaIvD8
         EJzkzRI1YDmZUsMQxa0ntIDgz44luNcPiy/hY6U4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/152] mlxsw: pci: Return error on PCI reset timeout
Date:   Mon, 25 Feb 2019 22:11:24 +0100
Message-Id: <20190225195049.342767304@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit 67c14cc9b35055264fc0efed00159a7de1819f1b ]

Return an appropriate error in the case when the driver timeouts on waiting
for firmware to go out of PCI reset.

Fixes: 233fa44bd67a ("mlxsw: pci: Implement reset done check")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c7901a3f2a794..a903e97793f9a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1367,10 +1367,10 @@ static int mlxsw_pci_sw_reset(struct mlxsw_pci *mlxsw_pci,
 		u32 val = mlxsw_pci_read32(mlxsw_pci, FW_READY);
 
 		if ((val & MLXSW_PCI_FW_READY_MASK) == MLXSW_PCI_FW_READY_MAGIC)
-			break;
+			return 0;
 		cond_resched();
 	} while (time_before(jiffies, end));
-	return 0;
+	return -EBUSY;
 }
 
 static int mlxsw_pci_alloc_irq_vectors(struct mlxsw_pci *mlxsw_pci)
-- 
2.19.1



