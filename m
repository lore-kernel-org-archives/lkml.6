Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeCDTER (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 14:04:17 -0500
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:56884
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751791AbeCDTEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 14:04:14 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yossiku@mellanox.com;
From: yossiku@mellanox.com
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Artem Savkov <artem.savkov@gmail.com>,
        Yossi Kuperman <yossiku@mellanox.com>
Subject: [PATCH net] xfrm: Verify MAC header exists before overwriting eth_hdr(skb)->h_proto
Date: Sun,  4 Mar 2018 21:03:52 +0200
Message-Id: <1520190232-7208-1-git-send-email-yossiku@mellanox.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [141.226.120.58]
X-ClientProxiedBy: AM5PR0102CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::14) To AM5PR0501MB1987.eurprd05.prod.outlook.com
 (2603:10a6:203:1a::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d235b7f9-b021-48d3-8946-08d58202b5b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM5PR0501MB1987;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB1987;3:8M8zKMtbcXs5Rsb5PbUkAPc/7DxMA2PgKAvJxe43VPajPNgXHfJMbhnmcJI3WRG+Tzom4XnUNc15jk5uHPtKRmQdDy3xknj2n+gujK9Ux3aAS3JBzKOsWJ2HsFu7hn4VGhYnxG3HI91bboIc4rlztXEeHUof3fu1mlDw/CeguZf0X7jOB94K76rUl4WX72/NjFbkr8dLlAlqEp49005FJkJhorv5hxi5BX0zs68aF+zev1e0FnNEw9LDkeeaxdVI;25:v27NUaVO2zEIGGojyA5R5j3dewa6nnqGM67loXvpX0paN1IVNscTc6z0EjHffPXlo97pJp5oNoVzm3kbaBtBqs2xpJ7uIjScLS/mZG3kU8JkO81VvugcNWzInkbOuhFRz3t1iYRGEbKUSKGfSwpKiHZIUGgTGMOLOFs55ao1H45et3JBsx1kSYPtlveXxd72ueiMCGc+hxR4PEjkagPoryqZs/rGaILxsBdw//HqmKbdheDwjMjJzlS/SZiU9MbBFDQ54rVYzrZwgnP2pBcInlWI7sdTCM8faGRbDGEUellKvVFXmgBJQu+UWhBy2zqpR2DTCS2Ix3wQZu0hjBCBaQ==;31:4xG0q4h4WucAMyObjKZ11iGpXl1of1dNoYpHXTrIwlkf2KpU/VB5vcRTm7lzDQVlG/s5FXpSfp5RinPlFbuK4tdex2qilVqszWoJc3WYpc2FkNxJgsXbntRqc6ZgG1fCTABjWM3tvlW/VoUq9OqwMwOlZ7fo63F7MzEJntvSYeayXWtwo/EPrbr6hglUnpJQZNWNRuk3r4y4SM9PE+pQfBkLRLPx0bSh9ik8vQne8Yg=
X-MS-TrafficTypeDiagnostic: AM5PR0501MB1987:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB1987;20:k7p2G7hUIVwNmC2B8SYOH2nwJHW/AechpHdHXn/qAqCXY7GQuGkn1eLdCD4zIL69tRsacO8akks75CN0USAhmrSNzZIn6gcurs/tpyHSVZzDDq3m66685xgW2ilT+NETyy8NPQdBPHZiuEJxrbOEc+hSQ+yLuIyByfZQDl2EgdzgM6t+XroMq6GS1Ea7x6Na92zG/Xfq2CVfIb6N1sA96JxT0estS8CUGv4mcQIDCJ8uJb4+ecDjpAoRWLpifWeSwU9TGkZJyETa+6+9PCJwZJwkpuy8LNs+1MQ2963pKUI53ala5S3KIH+7tBUs4x0h8joZaIYztLGhsdhj82HwVu+F2pN3H6J2wGgxKB2uLdtl9J+C3h4c1hfTiSM7agKIv1VVAzwvM0jw793RVrxxjd/JyOnRFEQft6UVOWJdhTxAj7Z/j6Xf7tsXJRLhF4uNRl9iBryxmwnUyBRR4fLdWuWDU6gS9Chw0b1YE7R2nIfYrgOWr/fjMUhSYW/YpS4n;4:aE+MFRIm7FqnpBp85C+UTXNzKIugymY6zAdx3tUWhABWu3FKEJuSmMfraM2DQInU7XV7cHswnATj77YUOFX7RhAM2RgsbSJsJhFJEDwAlGamGadBVMsXouYSUEAloIMVEpOBRJ7M9qQ0ncwjpBLCD0v3qAqD9ZpmK+re8pMSUbnExZeXjl2oAlMMKYeOQhdH3rMlso/PaGPzRagvQOJVWoSMvJF75k+kO+INCyqVNygpC7khI83l6c22pdkuEcmMFf9W+djLqA35sU//HRMTT8nD1NbRanwhA+GmP18alFWU4sFf/HQyKvz9CPkiEU1S
X-Microsoft-Antispam-PRVS: <AM5PR0501MB198797CED6744D68B1A71104C4DB0@AM5PR0501MB1987.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0501MB1987;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0501MB1987;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(189003)(199004)(33896004)(478600001)(4326008)(48376002)(8936002)(110136005)(54906003)(6666003)(16526019)(186003)(25786009)(9686003)(2906002)(50466002)(36756003)(16586007)(68736007)(6506007)(386003)(39060400002)(6512007)(26005)(305945005)(81156014)(6486002)(52116002)(51416003)(106356001)(97736004)(105586002)(6116002)(3846002)(575784001)(86362001)(316002)(66066001)(81166006)(5660300001)(47776003)(53936002)(85782001)(7736002)(8676002)(107886003)(50226002)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0501MB1987;H:dev-l-vrt-187.mtl.labs.mlnx;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0501MB1987;23:CRR92g9PnvxKH5vAlgXj+Ge8NPfti564z0rAKLY?=
 =?us-ascii?Q?JJvv53R3HZHKz6N9oVDSbclN3DN1SJZrDyHjczilISsJ55/Mmxl+pIDmW4wb?=
 =?us-ascii?Q?m+SmdazW57PXMS64GNwvbGZQRI/9wWNHnqmpURvgCj0rW4Y7IVM36Z9+pJiy?=
 =?us-ascii?Q?/ShVxuCdGXQgrbOdSWNoMrRaKGAqAJuONyre02b2mpEy0N4KtYO9i4IqShHw?=
 =?us-ascii?Q?TjNQ9RjYR7Zgc1XgFFVhQJxtahXc1tNHpcTCVdEq6L8oFyvOYKIrJ5lPgfy5?=
 =?us-ascii?Q?Bf/OvfwNFRzPcwtW/RE1z4ZRIw89/mazAIjxdHWC3Wy1HzFFYm2PqkADTlaq?=
 =?us-ascii?Q?sfaJfLOijQi9A6G/BDFEyaVG8yL0sgmDVHNyMlU3EE/2BSkT2OBn62I1jyZa?=
 =?us-ascii?Q?0MdJ3UkxFyq5av+kCnlQKXbyMU0WlH2bn2UVx4pnkWm6VlUVwqZts3sVvM28?=
 =?us-ascii?Q?7clJIAVZqng+pidNYC0yY808/GPAfV1FaBp5U+nul+NtXS9OBOmHBbUMqO7b?=
 =?us-ascii?Q?z9Ij+JEFzwTVyC33RFjDEvAsqoifuwHqT32FLzYb+nxA+gk5fERF8Yo96aqW?=
 =?us-ascii?Q?wWLwR8ystS9V+5iz0pi1SHmYwB1Lhc+1b91coOBHInJDPQYIdmf8zdwZj8Wn?=
 =?us-ascii?Q?NQU+6w8tBAGjhlShBahYSTjCzoSOlpDbQVey4Wu8+uqTsoPGY5/03E7bTPSU?=
 =?us-ascii?Q?yI5uQhfjAcxYViRgflbu7BzZbAThNajrVTAonzolQ1uKUQy5Eooy898wI4WF?=
 =?us-ascii?Q?lIemRkhmzPEq5Z2uSeGjhODy4JMD/868vI3LCvZrfOiEd21DPsj9vSkFnGUY?=
 =?us-ascii?Q?aT324nATalBEiQdCoSIvPcQCWqlW7a45HX2a6QVDa04DkbrnEWsMZBgE9I2P?=
 =?us-ascii?Q?zEiQ5LbiAN23wmW1VcDi17MR224sz19jxE3H/6QX3dqXgvOtf9ewC/KcUf/w?=
 =?us-ascii?Q?GaOGHvo2GnI1OWcgfDhmDXeuiNKkMMJz3/dKRxwr0cMgGzg/5jHYYJaMnn8T?=
 =?us-ascii?Q?FTwNyTL3OUvP4g8owUWaHW5maQBeH93i+lqZUjqRmvpt4oZfnt/9154qQ2K2?=
 =?us-ascii?Q?CnpWlWF52AHOplHmrH8ccDxPfLD7VlSXvD9barK3LKbpJkbp4Z+7+gjSz+Yx?=
 =?us-ascii?Q?GV47GKRnqntBGAehbiW4EOKsnpG2AMtMyViT3uzq9Jqr8E9pChIgkHTJIjFW?=
 =?us-ascii?Q?bCYB/zcHU4seNBRxrlRU8/WTt55OhQGACR5lDZVg7g1vH1jLOpPGdfshR1w?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: kanoFYtatJES/pjfeBLzSLzvN0hlyLOB9lOlNGBysTK+7SuE4lXdqUrtAfq38hF0rlcgD6JrZO4woiAJ2hkePA3ZqXFJmL5lSg/VOmUjk4JbT3+CLJkH9fyXxLBuW/oKPY5VUPo6brgddjKoZg7Z/YVUAlrpt0R467dEEhHMNUkN4OOQ5Cx88aWHoxsRw3zG
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB1987;6:7PluEBWCOW+/GdWvEayYv1g14O6BVJEzrJXTBmWqfSg+rE7AqlAUQo9WPf9cmT6SoMsaT8YBtRo/Y5FdRsoBd15lGyvcqF2GG6DBbdrt2GW0l+v9KkaCKRwynYcoTFcUWKKGMHPVl2Ia6IVQwhFhqo6U4Ln4HwKcTeaH+bKT1LPqBPiao9YgjIWoTL6B1rHL2rjokB4WKFy24GFAXk+PhzCsgpDUMno7gqfSBUCiIysfE9vmYzGFCfuX93x+UVCy7+rWLPTTOObD/XI+tV6MsyXwt2mHKyGMq44nOvhwFExzh6NkauMhQsXtel2omYkYYNQGoNVh0TPi92t+zC7KGVrxUi2QYKvq3BuRPNESBpE=;5:dZWzg9OhZlZlynmdlkQVFa12ecc3JzXLgloIisC7OZuXITrPKduGnmj+sSTSUGX3qOPutswlO97DeGNgUwKsHTGbJzW46vvNYT2lLxi3Jsw9m/9JRhflbXwjPZ8WNXbWCnm4W2/E54p8cGOtmJ9QJZaVDgx6k0KO7jVMpOQNXbs=;24:dvbZNwe798qYbC7FRpT1FPHvDlsdkAy9yQre1i+xugcUk6P3TCQfcz4YnyHSjeDLw2M/5dhZk5QpFWgLArxENO3rHp7KtbUMafqLaWsarAc=;7:8s36CKE95S8SLwlwmTj0UdljWVsSaOQPoQIqgslivERYuPp9f9o7xy54y+OBiwQnj/0R/gTkTaNOotmzHmWdC8ZabCuOJsHUOREDM0/CRZWI+tHtmCY7EJvpdm/deN/GMT8oH+O0uQNMeInsRP/nT6fEkmtabqiPK0yXiTlcV3VEWrxeDxoA9d1FI4NYnCgAuHXA+dA4FHw65PUGkjUGzMdW65QNaJ0s8oq0/hKR8SOvv73ckbjyS2f7MgFACAO7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 19:04:08.1555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d235b7f9-b021-48d3-8946-08d58202b5b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0501MB1987
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yossi Kuperman <yossiku@mellanox.com>

Artem Savkov reported that commit 5efec5c655dd leads to a packet loss under
IPSec configuration. It appears that his setup consists of a TUN device,
which does not have a MAC header.

Make sure MAC header exists.

Note: TUN device sets a MAC header pointer, although it does not have one.

Fixes: 5efec5c655dd ("xfrm: Fix eth_hdr(skb)->h_proto to reflect inner IP version")
Reported-by: Artem Savkov <artem.savkov@gmail.com>
Tested-by: Artem Savkov <artem.savkov@gmail.com>
Signed-off-by: Yossi Kuperman <yossiku@mellanox.com>
---
 net/ipv4/xfrm4_mode_tunnel.c | 3 ++-
 net/ipv6/xfrm6_mode_tunnel.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/xfrm4_mode_tunnel.c b/net/ipv4/xfrm4_mode_tunnel.c
index 63faeee..2a9764b 100644
--- a/net/ipv4/xfrm4_mode_tunnel.c
+++ b/net/ipv4/xfrm4_mode_tunnel.c
@@ -92,7 +92,8 @@ static int xfrm4_mode_tunnel_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	eth_hdr(skb)->h_proto = skb->protocol;
+	if (skb->mac_len)
+		eth_hdr(skb)->h_proto = skb->protocol;
 
 	err = 0;
 
diff --git a/net/ipv6/xfrm6_mode_tunnel.c b/net/ipv6/xfrm6_mode_tunnel.c
index bb935a3..de1b0b8 100644
--- a/net/ipv6/xfrm6_mode_tunnel.c
+++ b/net/ipv6/xfrm6_mode_tunnel.c
@@ -92,7 +92,8 @@ static int xfrm6_mode_tunnel_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	eth_hdr(skb)->h_proto = skb->protocol;
+	if (skb->mac_len)
+		eth_hdr(skb)->h_proto = skb->protocol;
 
 	err = 0;
 
-- 
2.8.1
