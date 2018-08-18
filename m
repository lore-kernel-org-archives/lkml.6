Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED04AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 02:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C7E219D2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 02:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ljh+nQL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C7E219D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeHRFXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 01:23:16 -0400
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:7913
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbeHRFXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 01:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/SwHVc4TxjmfGtF1fIlFnpT9MxasPvUb+BP10/dj0U=;
 b=Ljh+nQL6NuLVRgYxquy7nK5k4lhYcFfuZ/muVoEQN7s883IANWc+im3lYLDvUxSRRjrRQ3sRaRAQM1BfFk+H550N8fzZ25xEV3yosa+L1VDsmFfJTVlN8b16fiqI0emGVP8H8Ys4Pkm+cdlexQTKHWlTEV47WqDI8DnVpM4b5zk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4451.eurprd05.prod.outlook.com (2603:10a6:208:5a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Sat, 18 Aug 2018 02:17:18 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fqqnb-0006Wv-AU; Fri, 17 Aug 2018 20:17:07 -0600
Date:   Fri, 17 Aug 2018 20:17:07 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ursula Braun <ubraun@linux.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/smc: Replace ib_query_gid with rdma_get_gid_attr
Message-ID: <20180818021707.GA25026@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To AM0PR05MB4451.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123ffb9c-959e-4800-96f2-08d604b0b8f6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4451;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;3:n7apmKsfuPMxjXDpEKTJkWSLn4DmFukEbB/qRsERjCZmr6qxDUxnFldPp2NgFWXP/O/MZq4qv/jE52vSm+ijqNXiT6q78LTWXpKKXPe8OSudXh4P1R67DDuFWoslNxy3o+1sO8HqBkflhX0VNLLKU4yGRy7fHihwRMmmo+/JmHRkMXUikLlG1Ujxd3Y06KoA0H6UGcBl0Rw69LoOlxv35diAXpJpwFO0a6nFllLJPhWbzxgz6inA88gAwQ3zCBev;25:vCWEQrrO0yyQqZjL7xxu1RsscRSybwqDbOpVSui7PxrTlgi3ygyZZGhAGWnnos64fvuP8ASAwILuSqrBsGnK2+XvZPpN9YUuNPnu5PeAxpn57/2PXhqa0O8pakDS3qy9LwzWu13lIfcF5iFUcF4Ei6XCqnwWfzj6gh5vh+hoPROALh0dT9u5wGfrdnMRHs2O73zvhQ8FlMLnhBWy305UjIRPsEw2/Oyj0mznrbIbux9pZYQNkb2uKwcN7p27PYIT3VHb5Mjoj6OkgkCvN5++aU2QQ1Xcx/lNN7SmuZfMwcWfmM+yD3Uv5UBNQda6wHGatD7V++YMwQHZdX/eJTIVjg==;31:P7EVGGburWMf9syhHg97mwfyA+ojUgRvzHWJrbl2vA2aq90hKWQortT1F8/vgHUa8YIgWVZZL9tf2jOR6Se30KuIzhSJcTi+qxZwoIhMR9bJMX5L/OvV6egpAi8XJalaFS6odgtorb3e0jwJtKSKYOnTwyEvhe4GkonqVEcD0lqGmltWg+EMh8g2y3b5obL8hJ26/000R/PCf54ISs9gUR8rOcd9XU1s2Rt5YH3DH7c=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4451:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;20:qBvBkP6OYNuPSv1oANbwj/5GsLdMp1GLX6Rs7LeM0EUxvWWp9z13BvjUgx6xOaON3S/85VXg97BpKVnGZkMGoEsQ7YuoUXWlhbKKh023GNyyQKddJusBijyeoqofpN5PM4cZupm4lUQ9vCxxlT/15l0X/qNE3T47E8+jLcv5ScDmq6lnkJjJ5KpHlPAWin3PRJzgaPXCnyzeBwvIc5KqAPL7Eo1kRt43N7sl6cHZpUKB87o/py5uXbrjXEycqfA/kaAbWBYQVOLYKU8cavSQ4gWlkSZRw43YPaASPjCD9oWpWIhOpmBxiD2hloDIzhrJ3IRCT1YmgsWQhOGL/PyFr5bs2p8yzFrL65eE0AhpgYC+a4kWbn1ikbaBA1GMq4M62UEX31WD9x5SrxiPzEBK3AoDE1cMR+sNdtgjUOZMid3crFHY4ZXB9U/hjG57lCX8++hjO5mMUVBZnXmIcbcB98f0QOCeDHM+18WS7ypUPGJPwK79B3/bhhQNRypaNBYj;4:URUyaRHTcyFUa3Ow5F38LiusRuyyaqF0DriVCgIWlnOo2pz6b6Ravtz22OPEnffBHdnuS6xnz9jsScY192BWZK1aitxw02Ol/VswS6iILOHnZJ1zbGxJI01F92ZcA8TGESZ9gZWyi2O3OLO8cqpIzD4rMnkkKjQ5qkxdHh0sYe252GGCgqBG9t5cWx/OkjKRB4dSqs2eyIjT04BHyKX1jIP0qRmaLGHUrV1I1UCmcUCCpIo/cX4XrCaY46mZQFGs/cSfLBoHwbuBDH8kwHr0e/GhgWSh1B2D06EffdlPcKb0YRDNQVlGi+zjWjAJNqmM
X-Microsoft-Antispam-PRVS: <AM0PR05MB445161208C6485D7AC84CCAACF3C0@AM0PR05MB4451.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301070)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR05MB4451;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4451;
X-Forefront-PRVS: 076804FE30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(69596002)(68736007)(122856001)(57986006)(386003)(8936002)(79686004)(476003)(97736004)(14444005)(23726003)(47776003)(9746002)(486006)(1857600001)(26005)(186003)(81166006)(1076002)(83796002)(81156014)(86362001)(575784001)(9786002)(6916009)(7736002)(52116002)(16586007)(305945005)(5660300001)(8676002)(58126008)(478600001)(36756003)(33656002)(9686003)(2906002)(33896004)(53936002)(3846002)(6116002)(426003)(106356001)(105586002)(46656002)(66066001)(316002)(4326008)(50466002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4451;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4451;23:JD94195XTrG7iueyppYavJ2T32XhMNNhqlnhL6fYU?=
 =?us-ascii?Q?8MciYcYP4NbngijPKFCCWtdRqjQQbDllAyFW8BJc8JEkSecvpHWqaTZsMgh/?=
 =?us-ascii?Q?P/KDVYAJRpI9axUsLpcuxLZVG4urBuQwyL5K+dMKnluc0U4kizE/ihdgKcR5?=
 =?us-ascii?Q?Z//NAgZBSf7FXGRX70JrZ6jgrZlWYuxOcROOAQqeb7/UmOJaz8VsC1yXlX9u?=
 =?us-ascii?Q?6Bi5YCgeU7VIjndAoTJppvYHiekl5S+ZP3bQvMQ0aBHmZNgkUimN1hQTb7ER?=
 =?us-ascii?Q?5HMNRb9Lv6OiRDuwftLD05n3fUgUfFa9W5wXgJzmtCV+iqSgGmaz+TIkQo4s?=
 =?us-ascii?Q?xi0J4JYOeDLX/N3XvIc2uww9ATxs+KK5vt3k41Lb2CgF6QrGE/3UbvLOUc7S?=
 =?us-ascii?Q?7UAZdaiP4hxxfMBegGH6Lw2SPr+RWi1v15tX5np3R/kF414JEo12g6/v0WQF?=
 =?us-ascii?Q?I3jHkIYBs7HYUIh3+DybopaInD0Okl6o6gQ+7B1R77rr/RHLGWtpu0b1wlZP?=
 =?us-ascii?Q?tBBB+lj/0D/SSx1VbauM8eezstvNhfp9MYMRMfEoULJeSUtJ49hdvgUX3RdV?=
 =?us-ascii?Q?KYqAi57uqyvq2FeYiK9PrOkiOwm4j/jezJQEgG1EG2MiOLfujRVIEo/b7062?=
 =?us-ascii?Q?TvB1Tr4p0EWIluYndNyLhs5XcREyfbz0vRnK8y8i+VXGVtVB+880kWFUshYg?=
 =?us-ascii?Q?JcnCuw1eXsthZLapV5aC8geQIJ1YTx2pEI7hAFX7nWGhIYL4epsnzpZUIvMc?=
 =?us-ascii?Q?stwRY8mPjKCplhD2dzB5ODuJ+6T4Qvro48AWDi1C9gs8in0ZoJsDG8wtM7WE?=
 =?us-ascii?Q?syDwkwcGgl/5Bpbzxtq2VeZiLG7E9rmiAD2nw0o1TguiGTnKjIp0KpqfTnrz?=
 =?us-ascii?Q?nnPEx1gi65zewjulI2T8WhUNC8gm72NMzOoCkyFTqhNPFt9RjUDiuYRvF0Ex?=
 =?us-ascii?Q?Rtm6kD21oLq7Va3pepen8T3fY92V+P0JixVy/WxtS5qo3AaPWjBHQldemMWQ?=
 =?us-ascii?Q?bKPkkLU0X7UI8aorduJVtEUsmwUy2SK5uTUnN9lbBaOvDTkpvLimRQgemjes?=
 =?us-ascii?Q?5DMxitCOxIW6TezQGOLfSwe8fgjqL+PTvw8zDN46acSG0ZjTgPYGm9oaGR8c?=
 =?us-ascii?Q?0RQXOWMy8auRg7XGqRG+8fm2tfGR+es88iojZdpI/NdrfmJEY9V13mzi/Vw3?=
 =?us-ascii?Q?0DnxAoL4ZHDNZND1SnNS1YOxmMVAW/PuduqbO8HkmRk7923RWZzrMlW+I/8+?=
 =?us-ascii?Q?co1KldWP0xzVjgdAzkj+AGCwVZZfDoGdkukWcQFJTEjj3RQuudXJmf1EsMDH?=
 =?us-ascii?Q?pDioZZpbAm1Xbzy5ZyedQwnckufs/QdANyzp2E8yxoESusxi4Y37kUz/yma9?=
 =?us-ascii?Q?xEiLA=3D=3D?=
X-Microsoft-Antispam-Message-Info: UixivDBFpWM8a0ndUHPHVouSYrqfbpTBkNO1XV8Ozh+BBq2pj1Deyvp6uViHvaa49enjqv9nUb+HK9B8GmDMel1EO5VtVQQkCIrjYkGfAp1edSGGdKpd3YuHda6SDQ9ZOMAKhWy7FfPh2BVaJcXyVeMUCD7wNmN4jaqhadBzC9b7OpwpKoKt9pcu7j1jlYHmRbPnl3c28VUP4TSWA+4Ak1eLx3k5Lii2lC4pktYfmEVNG6djnLAz37uuYz0GYT1tAr3wGnH7HXGV+kjIm8kNEuTff/pELl31lV1fwONF+PpWxcJl3XaYPMt+tYVpWpRV6IvWJxEngq2UsRGW1L79vFRTqva0c0PYSLe1Md+NBWc=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;6:BkIYTal5V8rKqnJRFYLOOtl9kvCuhdZqfkPKY9Zd434l9DzBFdm9fTRuReSaWRyz42VTwlbePCIqFROkc+ZRRdC93VMhylLVRD4TsEP6L95jtuSfQt3Hy5pNgyQTOadZ763eK4DGSWI22bzMzhl6yKKjxaBh6H5S5T0byPk+KJbIHcvxM+6j2bfEUJPwlSsvL/2OpkmNvXfhbNQLz+/mapr/NOXadchQP1QxZgN6/31NpS9XVJlvQNxLKWv8lEQao8cNgUJPHiROt4GjnSruqus0e1WAO1rgBn+5OR2JThrsFIcNjSIzXb+XPurXsx+3Q+UO6DBUvmqWgpt9l7Gltpm8fisqZhr/cEGhNSo3fEXZyWGF6RNHpSd2C6IWOd9qUwD9cayCjInB/iuVJizgQ1AI7DQCL6rO0BsHZ55ouMTm7yg/vtVu68kjVeetybmHmToe9b2XlF0ffWxlpat6Bg==;5:XoYxIkB8Pn88owWa81qaqUWXfafK/Ek33oXdbeSHK8mAmH5cxTFmv27H5bewaugkSokhImfhpKnFTZzbTj23AlPOdzuIhxK8KpFy1T2Dyk9ZQT4oExDhu9VkOqtVbyxxDUn6tec4kxGFo7iQOfDbNKb+FBMkTTAY8WTeJwe8/mA=;7:V/9YUJSqwgoAvhbTUw0HTx0JWeS1yRVAJNrs+9CD58hXCxqTUq8aotPGvxewcGXVm7UoF962k0L45lVQGpBuzabmDGvVGrbsRs06OTyDcn3ki9nmdorBgoslG2p8A+WNirikRa0SBrw7JnmTXA7tcettlWEmIFDMajSNpEoxVQY+6FpEam1q7RcyRsSSEYSYXFmgVC4wtEpD6DoiU5TdF67NBGgwmTyaTB2u4n0nYwWHtDGgzxK4O4if7/T4hxaU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2018 02:17:18.3427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123ffb9c-959e-4800-96f2-08d604b0b8f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All RDMA ULPs should be using rdma_get_gid_attr instead of
ib_query_gid. Convert SMC to use the new API.

In the process correct some confusion with gid_type - if attr->ndev is
!NULL then gid_type can never be IB_GID_TYPE_IB by
definition. IB_GID_TYPE_ROCE shares the same enum value and is probably
what was intended here.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/rdma/ib_cache.h | 24 ---------------------
 net/smc/smc_ib.c        | 48 +++++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 47 deletions(-)

This is intended to go this merge window (ie in the next 4 days) to
remove the wrong-headed __deprecated warning. If there is no objection
I'll send it via the rdma tree.

Thanks,
Jason

diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 3e11e7cc60b745..62e990b620aaf7 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -133,28 +133,4 @@ const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
 void rdma_put_gid_attr(const struct ib_gid_attr *attr);
 void rdma_hold_gid_attr(const struct ib_gid_attr *attr);
 
-/*
- * This is to be removed. It only exists to make merging rdma and smc simpler.
- */
-static inline __deprecated int ib_query_gid(struct ib_device *device,
-					    u8 port_num, int index,
-					    union ib_gid *gid,
-					    struct ib_gid_attr *attr_out)
-{
-	const struct ib_gid_attr *attr;
-
-	memset(attr_out, 0, sizeof(*attr_out));
-	attr = rdma_get_gid_attr(device, port_num, index);
-	if (IS_ERR(attr))
-		return PTR_ERR(attr);
-
-	if (attr->ndev)
-		dev_hold(attr->ndev);
-	*attr_out = *attr;
-
-	rdma_put_gid_attr(attr);
-
-	return 0;
-}
-
 #endif /* _IB_CACHE_H */
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9bb5274a244e83..e519ef29c0ffcb 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -145,17 +145,21 @@ int smc_ib_ready_link(struct smc_link *lnk)
 
 static int smc_ib_fill_mac(struct smc_ib_device *smcibdev, u8 ibport)
 {
-	struct ib_gid_attr gattr;
-	union ib_gid gid;
-	int rc;
+	const struct ib_gid_attr *attr;
+	int rc = 0;
 
-	rc = ib_query_gid(smcibdev->ibdev, ibport, 0, &gid, &gattr);
-	if (rc || !gattr.ndev)
+	attr = rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
+	if (IS_ERR(attr))
 		return -ENODEV;
 
-	memcpy(smcibdev->mac[ibport - 1], gattr.ndev->dev_addr, ETH_ALEN);
-	dev_put(gattr.ndev);
-	return 0;
+	if (attr->ndev)
+		memcpy(smcibdev->mac[ibport - 1], attr->ndev->dev_addr,
+		       ETH_ALEN);
+	else
+		rc = -ENODEV;
+
+	rdma_put_gid_attr(attr);
+	return rc;
 }
 
 /* Create an identifier unique for this instance of SMC-R.
@@ -180,29 +184,27 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
 int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index)
 {
-	struct ib_gid_attr gattr;
-	union ib_gid _gid;
+	const struct ib_gid_attr *attr;
 	int i;
 
 	for (i = 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
-		memset(&_gid, 0, SMC_GID_SIZE);
-		memset(&gattr, 0, sizeof(gattr));
-		if (ib_query_gid(smcibdev->ibdev, ibport, i, &_gid, &gattr))
+		attr = rdma_get_gid_attr(smcibdev->ibdev, ibport, i);
+		if (IS_ERR(attr))
 			continue;
-		if (!gattr.ndev)
-			continue;
-		if (((!vlan_id && !is_vlan_dev(gattr.ndev)) ||
-		     (vlan_id && is_vlan_dev(gattr.ndev) &&
-		      vlan_dev_vlan_id(gattr.ndev) == vlan_id)) &&
-		    gattr.gid_type == IB_GID_TYPE_IB) {
+
+		if (attr->ndev &&
+		    ((!vlan_id && !is_vlan_dev(attr->ndev)) ||
+		     (vlan_id && is_vlan_dev(attr->ndev) &&
+		      vlan_dev_vlan_id(attr->ndev) == vlan_id)) &&
+		    attr->gid_type == IB_GID_TYPE_ROCE) {
 			if (gid)
-				memcpy(gid, &_gid, SMC_GID_SIZE);
+				memcpy(gid, &attr->gid, SMC_GID_SIZE);
 			if (sgid_index)
-				*sgid_index = i;
-			dev_put(gattr.ndev);
+				*sgid_index = attr->index;
+			rdma_put_gid_attr(attr);
 			return 0;
 		}
-		dev_put(gattr.ndev);
+		rdma_put_gid_attr(attr);
 	}
 	return -ENODEV;
 }
-- 
2.18.0

