Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7F4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A234214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762169;
	bh=2HKTe0TVMVZcKEgHEYel5Ff2z3+M1XetuQMlAbyZzNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MseF5WulaEHmkWGBnuwKuoBT5HviPpkNz5wb30VmsQejLcSZS96OlBV8MrRhzPmDQ
	 I/sym/tu7s+6Qpw6vYBnp9PckCzXvD1AKXZZkggA2g55a8dF4vOtrguuJ67XYIdHoS
	 gmEZCtBp7FyW5aULt8uyPdxfKuR5RFmUju9MDVuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfA2Lms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfA2Lmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E363220856;
        Tue, 29 Jan 2019 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762164;
        bh=2HKTe0TVMVZcKEgHEYel5Ff2z3+M1XetuQMlAbyZzNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaQ5taBEm/3M/ngxUvpSO2t0Auzb+ocrJErna96H8YtTN/+O4guR1QbAXbnKoNKuY
         WP8QsYSqjx4O0lOsh1sL6h5JPwuI4faVZZq8SVCAQ7jyAC9sGbTNPfOF3tnz+PpkYI
         u4gPY5bs3S0Rb7LSPNDClvbIajXPjYaPTAU9Ni70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 013/103] mlxsw: spectrum_fid: Update dummy FID index
Date:   Tue, 29 Jan 2019 12:34:50 +0100
Message-Id: <20190129113200.321744932@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit a11dcd6497915ba79d95ef4fe2541aaac27f6201 ]

When using a tc flower action of egress mirred redirect, the driver adds
an implicit FID setting action. This implicit action sets a dummy FID to
the packet and is used as part of a design for trapping unmatched flows
in OVS.  While this implicit FID setting action is supposed to be a NOP
when a redirect action is added, in Spectrum-2 the FID record is
consulted as the dummy FID index is an 802.1D FID index and the packet
is dropped instead of being redirected.

Set the dummy FID index value to be within 802.1Q range. This satisfies
both Spectrum-1 which ignores the FID and Spectrum-2 which identifies it
as an 802.1Q FID and will then follow the redirect action.

Fixes: c3ab435466d5 ("mlxsw: spectrum: Extend to support Spectrum-2 ASIC")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -696,8 +696,8 @@ static const struct mlxsw_sp_fid_ops mlx
 static const struct mlxsw_sp_fid_family mlxsw_sp_fid_dummy_family = {
 	.type			= MLXSW_SP_FID_TYPE_DUMMY,
 	.fid_size		= sizeof(struct mlxsw_sp_fid),
-	.start_index		= MLXSW_SP_RFID_BASE - 1,
-	.end_index		= MLXSW_SP_RFID_BASE - 1,
+	.start_index		= VLAN_N_VID - 1,
+	.end_index		= VLAN_N_VID - 1,
 	.ops			= &mlxsw_sp_fid_dummy_ops,
 };
 


