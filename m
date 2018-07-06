Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F49C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3023E47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3023E47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeGFMpH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:45:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932780AbeGFMpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:45:05 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MTNxP-1fiBrS3g7b-00SOTF; Fri, 06 Jul 2018 14:44:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Petr Machata <petrm@mellanox.com>,
        Arkadi Sharshevsky <arkadis@mellanox.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mlxsw: spectrum_router: avoid uninitialized variable access
Date:   Fri,  6 Jul 2018 14:44:45 +0200
Message-Id: <20180706124455.3151925-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:J7FO4Mufy6+xtNO9NwawvR7wJtxPnR2HAlVOmO9WKZzguHHJ/dV
 a5hvDI9opJZ63nthBSYwE+1Bko3C+1RWCInXBSAz4QOITI43T/oSYyabg64Zqr/eZlHAv7K
 eVSGegKQXNtstTMqaX4mtpXJT70TOETl6GW2kP6hwpvy+cX+24H06MdSBwqO8p6fMVyeQ1r
 nRRt40H2i6EfhEMdXVmnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iGqPCEbja1E=:1ZV3SzDRIuW3YylSWgj9o8
 AgUG6QGvDe/UeSDkBec+xrSro/bkWwy4VQeGqwQSoSudFOrPgOkvSHA9oP2ApUz5zx6vIsXMi
 YgPXEPuEgxRXev6ZMlzfvuLkLVVh1rqDUqp/2mXXkAdjsk/nemK4Jzl05YA+xV54bKYcLce/J
 8S05HXsbZdLrdRxNqROoazmB4fhrUP/LLaY6ouJm9O2B0cmFrLOv7mbqS72m7ODuo5GJ5q5lk
 gB0H7J6MUt+L4IGXCev1QYAFWwMxe2mATS7pePswM3ypR3fDRcq7Tdvzsblk4h20n0+fhlB+U
 xI1bJCo8nAY8mc1a6G2l4ZFUeBBbQF72yM5UV3mNgKrv9EBxiFV+WG3JUaw6fuRJ3NVNIxcVT
 TczhC+m5Cbiol9KAz8qUNXmHsoepp8BYSPWCwrlECGkU3ue61pzVTXGFk+YZf2WyriTT6sH8W
 OWnuSEsLG9iA2Uvy+dE+dxVpaiPlVpqtf3D/lG1pfKkbKjgiQfrYpwkzIvPMTydqm/7o+YpLK
 BuF0V4dxYrd3qvXC7ADilkmljrZg0vjfH8iXKEMTISQrY5wlqDUOgZZ9ZZr+odcxvx7VKxrmJ
 fPXzxXehU/TYrmjNR5niZA/G5Hm0PKEuP/cn4oEy+pyRUsL34+rEyShgViisHyY7jG2Oit6mf
 7Yg3XFsiJdvhX4SmifMmlc72wsmOpTcqmKarKsxFp4SHJXunZJkpLpeld6hVe6ei7OZ0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BRIDGE_VLAN_FILTERING is disabled, gcc correctly points out
that the 'vid' variable is uninitialized whenever br_vlan_get_pvid
returns an error:

drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c: In function 'mlxsw_sp_rif_vlan_fid_get':
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:6881:6: error: 'vid' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This changes the condition check to always return -EINVAL here,
which I guess is what the author intended here.

Fixes: e6f1960ae6c7 ("mlxsw: spectrum_router: Allocate FID according to PVID")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 071428227b91..60c352ddd6fd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -6878,11 +6878,9 @@ mlxsw_sp_rif_vlan_fid_get(struct mlxsw_sp_rif *rif,
 		vid = vlan_dev_vlan_id(rif->dev);
 	} else {
 		err = br_vlan_get_pvid(rif->dev, &vid);
-		if (!vid)
-			err = -EINVAL;
-		if (err) {
+		if (err < 0 || !vid) {
 			NL_SET_ERR_MSG_MOD(extack, "Couldn't determine bridge PVID");
-			return ERR_PTR(err);
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
-- 
2.9.0

