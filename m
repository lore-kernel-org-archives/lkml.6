Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeBSQLY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:11:24 -0500
Received: from mail-ve1eur01on0059.outbound.protection.outlook.com ([104.47.1.59]:39872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752857AbeBSQLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:11:19 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH net-next 3/4] dpaa_eth: refactor frag count checking
Date: Mon, 19 Feb 2018 10:10:43 -0600
Message-Id: <20180219161044.30279-4-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180219161044.30279-1-madalin.bucur@nxp.com>
References: <20180219161044.30279-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:301:39::33) To VI1PR04MB3278.eurprd04.prod.outlook.com
 (2603:10a6:802:f::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee9e9acd-9704-4eca-16a6-08d577b36804
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB3278;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;3:svICvCFyAat1tgyAKgoj56xbkd/VwgGsZBr6GwI3zE/PcoPDGQ70N6E1jm8UDlSs/ODjwabuld988mUmXpb3B5pfffoNipj/A/YOUqyM53q88WDJ8kFGLpeUQXU55raGaztTJCOpIy5U2rZscLyOXIGK9wALJv8LoIqHpG85/RH46eLye08682xwCYdRAG2bSWW37wmn4/BhumueqjhCGvTRj9ttuyOQ+YR4XSDTtMK//9Eli65t70E01JMTk48W;25:LTrz6Y/QgFs7baTk+kyuiOP9t3lSftEHbjzwgFj/t/HBi/eFRu4IL9xeP4Ps2WfuTQXz7D+jLAJfo3VrrfMUpFFDeTdVSITmT3g/Af/uZ97wkmzzSNbr9YUgHKdsT05n1uewvZoPQiRZkhMt/Md/K6aiXuO6g/I2BcWKFq5zGzz+1nMTkmIZUihYcV10m4H7PAwqd8GqJCUG5eJgpyIwEelinaEqyAFhO7VkElhNrwV1P1vURxmC7eu5+1oMX1kyUaQpUoueNSZHSWZIIhQWSaty8q6V5BSwkyXx0XUCOtoq6pJDWxmeN1z1vJujQ3biJikSx/jI/9pc+U2yvkmeiw==;31:c7PNstRPdivjRXGyVYq1lvH4m763ruuSaP9EjVdGSJ0pVo9kzmmT9KFnaJX+r/veZlIRI26418sb414paYB5/NlSDqTKzZD3rkwHNNwook2h4YX8j7wGWa6cwmjVwq9EmUYu3El6WIRIGxme7/MNxYFfIZ47Ix5kh7yJ9CT3bpOvKnXw19NROCKlIsxU5iB7NgQDR+c6t73oBxuJrFq/rmNiLGDqn1w6G47vApKbv20=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3278:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;20:Vw6qTpHIjngMbhFByvL9m+2lwtXDRlDzrfOOo2ZcK3RbRIC+15KewlwObCiyc/B9cpOHAVjuFMxZ85kVYtIGx8J0EcEqGOt9MOQvE8fZZ2MnvDd7kyDbB3KfIj0Fo4OmTRPL/y6aERyuqG0kcY8a+oqXHCXPBTqkdcNMyjos3arlV6E7hRdO7FMPeWMbqxwVIBZst7LM7XSkRryZQEjmk8SOsR8nzO+ggs8CeFAoChVrBLUOUTqoYrQHkjPweWXboUYGK6CUJlgf3ovr7ZGfaSq7xeqBEwZSVlteBf2Em/Oue5Q48XEwebuzC8nIdGpSkLiptXMQVZO2p6TyX3pvB2RJ+WzXy+PbHYR/4TkD3hbO2vgVIAOjp7EiDzZXXwsqg2r/2BagnCUSuZHut+Gybnzy0vj2aLCM6I5ovA7AY+hkCPQQA2jhdN5+CFC4mg504ModDu77m4JMjRDttxThOpjHfWDSmDP+NMGtXfVI5TcRwRkDh9Bz5GNRYizBp8IP;4:J/Hoj5ug9eGT6hRUWtS+Lu3uMe+7+d4X2LnM2sIRNoU0h2vzYHofkzYTZrbgy9q5VpK7Z/a6RcxzDHAkYyldXGKBwSsKDuG64WMpppPXKk9c2S9STdr5nqv0AfQPHz5c0Xjd5utSNIuooly7TB4MbUAsZwDAj8EXAFzgesmSBgTcR5rrtsSKDnEMXV4fzlcgTsQJ5RMJQNfFYiSrH1xmH99SyzvFSTTKyt/FbsqZnnSi9hhqY8an1rj/0/MiBiwKcSu4vgTqIt9uq5Xqq78weX3Zwjzr45BH8pFHzKKvDdSYgJN9de9/gwPGLoyd7RDO
X-Microsoft-Antispam-PRVS: <VI1PR04MB32782D8DAECF63645E1E19B4ECC80@VI1PR04MB3278.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB3278;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3278;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(68736007)(105586002)(26005)(43066004)(6486002)(16526019)(3846002)(81156014)(81166006)(6116002)(66066001)(8676002)(1076002)(186003)(2906002)(47776003)(86362001)(50226002)(2361001)(3450700001)(2351001)(478600001)(6506007)(386003)(4326008)(7736002)(36756003)(76176011)(52116002)(51416003)(48376002)(50466002)(305945005)(25786009)(6512007)(6916009)(5660300001)(2950100002)(8936002)(6666003)(316002)(106356001)(16586007)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3278;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3278;23:6F8QzY632olWhkqhMH+ez/p6intkJZ4i8tegjn+qC?=
 =?us-ascii?Q?qIorlF3/CbcHsULyjAn78j4A0KmkBwTbpsfU7jNs6egend4t6dP3bA6t42+n?=
 =?us-ascii?Q?ayz/oZlxs+dA8yl+E87pgZuyXL8RtzOxWIhD5y8J1Bur+ZKpmdWcVZ+OY3pr?=
 =?us-ascii?Q?OPirCY/hEif3V2dMtiD0dmMbQsRBFJjHJ8wLultPU2FEhHyVFLQ5Z7vyrvkj?=
 =?us-ascii?Q?8GOkZb2cNplBwNypS3PABKL9w+MYoUBUtgz0R+Iv2V/CW7z7Q3AppSllxdR8?=
 =?us-ascii?Q?zhSxzMhzm/nrb4S5JS+xuUxPkAqkdl5YgauMWnktlE4ZBPhj1GQZTFabo99+?=
 =?us-ascii?Q?5NacjbGD5Ufu2H/lf5QENzQOgtaWOi28X7/B71CpeOWZZli91r4dLuGuHOV8?=
 =?us-ascii?Q?W0BGDZHLap+daskOwS26G8yM46NO6xWPaELp/M3UXK8SvkfBT/ogVwC31+yl?=
 =?us-ascii?Q?QEOEss3oB4LYkSF5jari+yD+zorj56vwj2hj4zKXYj+krOOtyyhbCVa4oSrS?=
 =?us-ascii?Q?rohllQSw6FzHbckKi8bfVcFWRqyzatYILK+wO+PmRwe5o4cN1WmDHX+X3Ur9?=
 =?us-ascii?Q?7za56vaILkhJ86t2UYa1jeRFWLb+nrn6V2sr4OGMWZJl1X/ZGC9Aj8sk/slo?=
 =?us-ascii?Q?xMocnWYTvsOYQIPuKHCx7+pB9D8mVRUovfRLTV0bLAhVH3ZW8Cc60DM6zsCK?=
 =?us-ascii?Q?lcLC9xRFHizDCdDS78sSbl9vcZ8mFPKKP7PdWJHDkUcA7uDHBkzMavcSaB4v?=
 =?us-ascii?Q?KgbTtLhZEzgL+94/bO5RTD9VO1EZcS+K6Du3I6uAmdd8LGeKP4pAaWViRq5f?=
 =?us-ascii?Q?HHFx+kgcbjOgI/Wh/SUU2FqJXJr4eO2JCOhxGpkA9YfCVGIITcN82/1evImz?=
 =?us-ascii?Q?r6/AbrwDI5ZSnUO42227dj7wDlMo3BR+q7sfnENEDUuovuutjSorMTmgcK+0?=
 =?us-ascii?Q?xs+K9iXz83UbJd45qMBTe+5052ZWayHtly7cvcCVandKkyApRYo6PAODWin1?=
 =?us-ascii?Q?QbnaGUeYadlfkblqez7aRB+2bv7P6q9VnXeyW7cqVGnFM/VTi9m4X7isfSuR?=
 =?us-ascii?Q?tSWqYRfx0QkTH48LeQ3AVdDTlmdobyu0TcKj1bQuqRz8O6MxVXdg4vxqR2z8?=
 =?us-ascii?Q?BPydUlDU26TPzXRiJ7eMxK+Vn7QjUHeFri9JYyn5kgUTdtwgqXPDyaa/gnr5?=
 =?us-ascii?Q?IfAevuIJtu/rB737Pev2dasW3BC1bviKp/K?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;6:128k5kGj9u6CXXzhTKoxtljG7NpsJrNFSwsbNTNhZtQxWyJ7s1ae1XqyC/89e0/P2iH9N/LppxX2R9BgIrhz/PZVoc6zhfZRw5eHtLrEe0nUWQrq2kp+PJHqjp615YXprXVicyi6Dbc1LGt5pLNQWBMoMvT+JQn16otS8h2S1zeAtPxy6Qi+tksh6VddcTWAxxVi64MXx87BHDJaOO5gmM7h8zIkMQQdmJARnkHC+noTR1Gb1ngjpMza5UJl6r+QfA0MG87iUVv85+H5rwINYxwdhuxqzMmOg4p/AvwCxVjoiP9UcvKPIz0i3U6nk3AY9r9KBcKJn04y7baWfiX6f2iRZ8olVO7x5w1JLpTQpPg=;5:T9srj2S/C0Z44yEu9Vmwz7BIbDVLQ0iY1ErxlbLyg23QS7H2h3Ec8Igo0M9Z3c6E9QjILdAmjQv24pCXd6zE8Iat08ypUoAdbRo6mNpJhj9LbIPIkMoX0JGrvjkKuOBT0tc8QPwHLc8s7HrjZp9ZlHdEU+n19G2a/gmtv6gujXI=;24:xd3XQ6IhDghibARpkwbQb/5U3Pkh2OKrwSmnBwPHhmYklXFhv+krEvBIcc9eJPGRxM1f9LRUcRZfg+UEc1Znp/tmbATReHxH4wwm3/hUiLc=;7:hX5v3WGc6l8h8zp3otOoglY+48VZV3jTr3LjV+SMugYILKG0spLDmirBqMn9L+hc7XcHAfoswLpTZelgiC4c1lZNOk5XBWcSLf8tSrPZ67GAWLcvQ3p+Xkwwhmt+SH+p8VvhR9ZpMu0DOPqvX9Fpq8GRjW+dkwZsMfQso2ncI9a3mWTMWtF3ui/eMc/Q1/GgPYxZIQrtexdJqET5nWnnv7EmA6pmDORadAZHts1Lj0GwCXo4yTdacUx2AoqwB3vk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 16:11:15.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9e9acd-9704-4eca-16a6-08d577b36804
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3278
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 5e43840..2f53e8b 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2055,19 +2055,23 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	/* MAX_SKB_FRAGS is equal or larger than our dpaa_SGT_MAX_ENTRIES;
 	 * make sure we don't feed FMan with more fragments than it supports.
 	 */
-	if (nonlinear &&
-	    likely(skb_shinfo(skb)->nr_frags < DPAA_SGT_MAX_ENTRIES)) {
-		/* Just create a S/G fd based on the skb */
-		err = skb_to_sg_fd(priv, skb, &fd);
-		percpu_priv->tx_frag_skbuffs++;
-	} else {
+	if (unlikely(nonlinear &&
+		     (skb_shinfo(skb)->nr_frags >= DPAA_SGT_MAX_ENTRIES))) {
 		/* If the egress skb contains more fragments than we support
 		 * we have no choice but to linearize it ourselves.
 		 */
-		if (unlikely(nonlinear) && __skb_linearize(skb))
+		if (__skb_linearize(skb))
 			goto enomem;
 
-		/* Finally, create a contig FD from this skb */
+		nonlinear = skb_is_nonlinear(skb);
+	}
+
+	if (nonlinear) {
+		/* Just create a S/G fd based on the skb */
+		err = skb_to_sg_fd(priv, skb, &fd);
+		percpu_priv->tx_frag_skbuffs++;
+	} else {
+		/* Create a contig FD from this skb */
 		err = skb_to_contig_fd(priv, skb, &fd, &offset);
 	}
 	if (unlikely(err < 0))
-- 
2.1.0
