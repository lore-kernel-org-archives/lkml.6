Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7666120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xYFgXZlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7666120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeHaMEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:04:14 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:3536
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727521AbeHaMEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ysxj132QnoOBPfV2kbpfuhI7kNKJS5fQFfECjeLYMQ=;
 b=xYFgXZlzZKdH9vFjBCnjOhnyw1rL7ppXJdhsKVZDH8RdbyKIFa0lxgolrvw9lfXpCfiWaTl8SwS9nWrleDLsthjAJBHqH/rqLCxQ2IoEJC3IKH2OPpaT2c2vxIiJjerXEPUB5cLq5oCEOJChWcMd2Fdk0gZggTpnL3QnZriA4gg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:57:52 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        colin.didier@devialet.com, clement.peron@devialet.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, shengjiu.wang@nxp.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/7] ARM: imx: add mmdc ipg clock operation for mmdc
Date:   Fri, 31 Aug 2018 15:53:12 +0800
Message-Id: <1535701998-20443-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1a429a-0587-4929-dbb4-08d60f1777e6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:EzuxTBuA/SutaXZTVKXbqpXW4h/Y9cI+ADLpL2eW4MNZHJa/WIhu5UpblBopWePT6XbcghVfQcOhfLKFRFUCdCiA3S6Nl94kfJciSk/8R8IAhtZoBq7HsNaXF0IJgKV9SUIS19r/ir9FbWEiHxhLlOUBkIW9vyBmWfeoFmDoXEOrEb7PkPJFmTGtGFzXn6JkWwQtWCbscuSuqG9C9fT3Gcj4kUh6156taHo7tHYt6bvA1s/P1Uv4TA1+N9V++e8F;25:Ori8z/wLhVd/S53yQDYr1sveGGcrVFN2j3QnHPom7RTvvzPYG0MBAaXUTHOgTobfMY32t36928WN6bpO+VtXL6ShnKV+C6BBwUyLjmaaRq/OugcdZlK2p+gAgHGBL6E8iMfLoIxh79TonDU4pI+Aa25Bi/Jnjyn+tVONG3hxvC1yirAuwaW4MM1s2X/macG7noJbc7iWM1mDpcxt8FaQrZcjLXkB+gjxsizAGov4zEp3+mn7z4Pk6u7yonCzzpsS/LFm6gnhW1nQPAH/j0U3mpho8ekyl+k2I7gDOlooI2RG5CN/7id10WhTlNC4uYxxgc9ts0FizCy3NMFPDvt44Q==;31:WGwJ9r7MUuaSEt8PSF+nCQrOxsyBy7wS0pQ6weA5BOHR/j3O5Maw0h0qwGlyRlX9AnOCNDGGDoOK+RXDWKBtKycyViy4Mx2iyJSp42xEv+SQ/AYo467btJ0HI9XKL09kGfumaOqbTQR2KNQViQVLMV4xVoQ1PFRyEYup0mYaKlZqx0qOibZswLcy2oXU69glEPw6IpKvYhNFfqj4Jdjz6T7wkf5+gqX+aCPmFwMFePQ=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:dtyJozMQPKnxvZOqdpuSIg2tIo7eq/eV5cUuqrFmh5FNlHaDEq2q/TKwnk65EMNrMxkq8A5FTh9gJjk0S3LqdiMI1UZcFn0GNb4hw3BODal98EqvN3Y0+R4B/Ouw3mREES37RP+chhxoBATmLQQt+iYOnFLCQoU+hqmz1ie65ulDlFxJi/7N1HSbQdNgkAxe+O8EoEYRH5oHQJ5efY+CAjUz5H7dV5/O2HagB7VX/8kVIFAU+F9wm79+EWUDLOQTtB8ULToBHe/owahBeNa1uakmHJJ8SRmhMP7olzqoFe6mnB8j21VTD7le1Qel+T6VIUkuvJspIsX7Ibjdwh71QM3O8T3l1Uepff1ZrfgQ/WESB/eW+AYLcMj8oxlmqDNcvQz22XQA4zZIjAbduQyqibJFkaa3iAPzi2A5OJkn4Md2+YfzgylwfCCo91lWhkCnXqMH9o365DiIl8SwmwFAcH84zfScENvshpSgj+iZDJA7SmHndwZfDfZl8AJPUMvM;4:cgeH++yOnKQ8GT4wetQk4aalELoXhpTi8NrMXEeAmaXC93YCRp43p8/akpIprub8hw2bMsqLCeg4DJ9sNYFl5eFQQ0oI/NP7IBTSxgzpRCQy+a2sMZTuGQFf8DNPT215KWRYwttayxgtOOybRxFO0GWul4B2/AhlZJuNiA2a8dVJJxdVR8udLe8wGOrA+ZjGHA6uzdgSltRQM2ewrl7e/lLWxm+NBFrb8v2OdYmaWyl9JJAZVXNZPZizzHBn2uK5pLRaGRZrZmk0gAEfYvBLHOwVvMw8dJJPyLyO4W+4of4YS9mHUzlxjiYltPy/EXP5mTcfD0CCWdmqtgTISLQYb6R+eh4/jQDgL+c3fCV8ak3zzTJwM9JZNx05ME+k3/uz
X-Microsoft-Antispam-PRVS: <AM0PR0402MB39072D87338ABF3F43FCBC4CF50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(68736007)(36756003)(8936002)(16526019)(186003)(50226002)(26005)(6666003)(2906002)(4326008)(97736004)(5660300001)(305945005)(53936002)(7736002)(386003)(6506007)(2616005)(81166006)(81156014)(476003)(7416002)(956004)(11346002)(486006)(446003)(3846002)(14444005)(6486002)(6116002)(8676002)(47776003)(6306002)(6512007)(66066001)(76176011)(50466002)(478600001)(106356001)(105586002)(48376002)(86362001)(25786009)(16586007)(316002)(51416003)(52116002)(966005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:ZsUdS/VIrxMhWn58F2AfQxadhsIVKMYJ74RTAFW?=
 =?us-ascii?Q?fuuTY1PnSDAPUGd9IYveCL3TDgVrarpw6jOGiLsCQm9k2tY1v4fJqNmeoE/F?=
 =?us-ascii?Q?HQrAlXvBCojzuOB28Jct6q1Yeuq+n/8/EitElfezjA7iquYVLb9Rm0Z253gT?=
 =?us-ascii?Q?46HgurK4+P8weG6Mpt+3kJgYX9MglnVoVJ3af/0yV95XDm436WHdccVF3/zd?=
 =?us-ascii?Q?M2zXLZySEGlX7/nkh32OUhX9aevt6XNjETpfqtEOcgsxOp4S1rCks5O/UR+H?=
 =?us-ascii?Q?2L148tsgQoQ91ujhWoaNSE6Y94VxSyhjn9F8Pccq+9+2XT3ph8wOYH6hbpEx?=
 =?us-ascii?Q?9+1deuqRdWol+pwSI/W/KqzI0w2DG3TMeeTvdqpqXB7VNb6AH7apDLoOfELY?=
 =?us-ascii?Q?hWxM+31GWjwd7aVWWb0qg90nBPVIbpJu7k9EJxAKj0UHqF3qQwofS2dISGNA?=
 =?us-ascii?Q?DXwJxrm7JjKdnLQrpfKiu12zAvePujbeybRVWN1rRP4caAt06HnEASgPJ2Tf?=
 =?us-ascii?Q?07zHr8tuInmJWOF6MyOAG0Xek3pjwJ6ycfr8vcPwxNkX+nM0zAqCTBWBbkbL?=
 =?us-ascii?Q?PUR+r1aaS/LfvToX9igR+3yoUiI+41SV3HpjhIsxHbpxqsZZfFRScgYWdBZx?=
 =?us-ascii?Q?8owuC/sbVwfTgs2iKbwnpWZmU6g5xyff5X0ybEuJk8s8UZujDY31IBnJ45MI?=
 =?us-ascii?Q?k1y3ybTO22zUTj9HH35Z4BUpHif54mELXHhdzWjRGENrVzqB+a6Y2LoRASU4?=
 =?us-ascii?Q?0TUj1J6ZlVfHuvUqVzPJMdNTj8qf/HthhPMGPierlhIu5p4mOeIespB3hyLc?=
 =?us-ascii?Q?J7Ak+nxakA98kKNS2VtpX0apDibFK/dh9YqK4yChhkoSF+OviQbmNrhvi6kU?=
 =?us-ascii?Q?PXeCUc3/ckTb0cZ3M497sR7+yQ0bFDzH0+H7tsemH/Oogmrlii7ROO6zpyMN?=
 =?us-ascii?Q?li/SHLvgOoHrIr1CWiR9AkG2gs8szqMWdc8i6RXcOqQFhEEfCL8B/pWuF//P?=
 =?us-ascii?Q?VjaicGluJEr3YMlYgcGByhu6nJbRfYxHB4bDycjxNiZfkM+uZMdF+WsYUNt6?=
 =?us-ascii?Q?G513gQM7ILqaewTdGz5At4usw+y9V+00UthmhZia7/31lPNFGKVEqxeqA5C6?=
 =?us-ascii?Q?4xkGZDFcYWpSn9PmxmnEN48Zl/wctCMH+l/IbP6dHyqpAovHEIsb+h+WAUlz?=
 =?us-ascii?Q?OFpb82d6mDCjM7nujcA9xzzlXbYVJK73xd3y/lJ488gUdqp/OZmAEEkOqLIR?=
 =?us-ascii?Q?Pfp239A1MVkRb7WD9nK4=3D?=
X-Microsoft-Antispam-Message-Info: 1ZGxrSHPFh+nJwP4IJD+YgvvZmFd1IfxNo9Nxf9550j+NmydgGOtiZJXhmdYGIW6s6k7Ks4yCpT1PpGgW8xhh94+7EvRX8dsxcUuLMSneG9zxQyNLrQKdHRyDlugiAWx1pjLVy5O9ElA/kQk8ZCVDaymeQwN838ohdNlUn80RTBVTxi1lL+WcYjLwX5Eia90JfnWp1bh/Zu5QJTLFV3ANwnKSMFkTsw5whQi0+RN4XmCL2UqQ2ERngNm73QjJI+Qau89GXbkeAFLZ76leOOnkV6MsCGGCYrpE/I+lpNhrDm5lXjpxcWaQt6u8ZvJYhcA+3gVw+RDaqt51LKomMuVeprHlcbZkIeYdcVPxoFTz9E=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:a7WqXGyKzEJ9GjDQLMxd2BQgLs7i+Act4SZJtCrsOsych9rzujmZXwMxGPLrxz5b+R6PpHN+YQpht4hXQnRhMKHhIe8yoVRXH58Gwezb8LVnflMtzuf7b2bI7wZyxAVsHdM7H+d5o9olyRDyPQsoIIivOV0uz1KdPswt66JQXNmfU9sdhqwXm9WGHy3EKmRr0tFsG9HiVj5ZvIxZnXKolMTs5WayQ5wdqUK4pW+fURhIyT857Hj/Uy5LnAMcWooU+HSOSoApK+kuvRMW6SWQFv6OrEt8mM+zzA6T1gGIqkF8cyCbF1VNHVFjxAXFCRj/206cuAGujlz1DVMZRQ/9q0SN2NzOXvJiG5yo1z1BNgVb8TDaxjGAep4ai1dlL3VZqkmn0boTCFyYYddcfTHs7Pa1Ap2IWazl1Wwq11BuT6VUBcmdcUeTXCAeatpq80ylupe0b6wAsPtfIbf+a1rtIw==;5:AzDS3MWJS1c5AlsWPw1c9h86wJWghqrUyuj0jkK5PGRTBjmnTehrjcFdMmuEGFVTHOw6MjySb83GoLCSvKHIgQXv+MO+yo95Iwg7Jv/jtPHYrjSKo+Psjol0jlUvyGgwVI7ZFoxnHmPMeZfpt8g2EEh8zFGN31aFgwitIsGHjcQ=;7:H3cKiNuyjI6lc+Nv5iyJojo6oAAMm+Oa/PcC6aK29Cx+Omxi0gGat6jokcybEYE/6R6k58D7CFaODwHlJpwCQ4PUo97+ZT0VRhRsAj6wofUtpxUFWyvxvIaKLtXmy9y75dNGS9HqwOc148oCML9mmHB0Xn1u+23nBvx/rNIVb/cRnaSiImf6mugndFAIVrersIpPY1JG1g7vWTcNb9E+oqAFhQE6IqfqbUBssNyOtZxVqPwH/VozMCkHclVUsA2t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:57:52.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a429a-0587-4929-dbb4-08d60f1777e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6 SoCs have MMDC ipg clock for registers access, to make
sure MMDC registers access successfully, add optional clock
enable for MMDC driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/mmdc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 04b3bf7..e49e068 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -11,6 +11,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/clk.h>
 #include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -546,7 +547,20 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *mmdc_base, *reg;
+	struct clk *mmdc_ipg_clk;
 	u32 val;
+	int err;
+
+	/* the ipg clock is optional */
+	mmdc_ipg_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mmdc_ipg_clk))
+		mmdc_ipg_clk = NULL;
+
+	err = clk_prepare_enable(mmdc_ipg_clk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable mmdc ipg clock.\n");
+		return err;
+	}
 
 	mmdc_base = of_iomap(np, 0);
 	WARN_ON(!mmdc_base);
-- 
2.7.4

