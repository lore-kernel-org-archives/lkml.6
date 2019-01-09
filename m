Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A62C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFC220821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QLZT7I88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfAIJ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:26:48 -0500
Received: from mail-eopbgr720089.outbound.protection.outlook.com ([40.107.72.89]:30752
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730112AbfAIJ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGtqOluLi2kgFFCGn53gClLwUt5dzZrVD35awALsV54=;
 b=QLZT7I88R7RcSSOucWpe4mkHMlIBB9THlwbnQEkac89rYfOrLrD840LXGUc4SDm8rjsp/dV8J2ZgyMHJqau549VHSHyXEdzRd0aTb9fxxSDIQCu2irvK2dr5+HthDK9Pq5vQvLyl0uaH81zPqxPRyX2ntxyv/LZd/UIMetzxTak=
Received: from DM6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:5:1c::23) by
 SN6PR02MB4336.namprd02.prod.outlook.com (2603:10b6:805:a4::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 9 Jan 2019 09:26:38 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by DM6PR02CA0010.outlook.office365.com
 (2603:10b6:5:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Wed, 9 Jan 2019 09:26:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Wed, 9 Jan 2019 09:26:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51902 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA8B-0000Wb-BJ; Wed, 09 Jan 2019 01:26:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA86-0000jl-6E; Wed, 09 Jan 2019 01:26:30 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x099QS24019288;
        Wed, 9 Jan 2019 01:26:28 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ghA84-0000iu-7s; Wed, 09 Jan 2019 01:26:28 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 5D5F58009B; Wed,  9 Jan 2019 14:56:27 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH V2 1/4] dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
Date:   Wed, 9 Jan 2019 14:56:22 +0530
Message-ID: <1547025985-7228-2-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(36756003)(48376002)(50466002)(8936002)(50226002)(110136005)(54906003)(106002)(81156014)(476003)(52956003)(2201001)(11346002)(446003)(26005)(6266002)(336012)(478600001)(4326008)(103686004)(2616005)(107886003)(2906002)(42186006)(16586007)(316002)(126002)(186003)(426003)(81166006)(217873002)(106466001)(76176011)(63266004)(356004)(6666004)(90966002)(36386004)(47776003)(305945005)(8676002)(486006)(51416003)(44832011)(5660300001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4336;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT037;1:V8Cz+aeXJlTMD0as0nzIRFRaL5ffks0fi9v0bjxE3iTi3IlIcepD7MrUcWYnMfr7eQrl81t5JdlaKfW3HHUj7tiSNg4lRnhsFdWT5zR+S/o5YX/E8oejhYeReM0uPvWu
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78cf7b94-35d0-4260-227f-08d676148e49
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;3:JqWaE4dq/KpY/qooPffkggN1TUs4A56qsRqCJRq6ItXQRPUShf28/xa4Gp9jekpFnWBkrSSZ67HAvREGW6zzk8V6BLQPVSvyC++8dtkYyvRsNXfNXpUGSGz+qHQAzas3f0WV7BoKP8idq38XEcy4ctBX8gGrut+xSW6E98DraG7rqRjDe1loz6ttvr/xW9x90XiMNhbfjO3B1Lvpv3wlz4ApvtKujEAfuS0v3qTKfqsrsRblwu7mR192uKeXOt/e+MqosC7FP+5oiPrMxJ8VijH9Ua2Y2QTIpdw3lIiOElXXsbb9b8YkakvmHBvqaZsYQDmVafKyRlkQNkrxMj7xfv+UH2SlaEBcSQXzQW0N9JQ3lzT+H1EivvjgdBF6iA8M;25:EI3l0WsyFzT8uNipjdCPyTmd+d2q/cE893AWAmV9ljcJKsrLZ1Bhwb0660+HL1cEW9XimoKOY4qQxIciLsOz5HT1VQESE27w+MfjkX51ndtkKf1+mVslPZ/NDCFlRD4/ohWENVxYo/j5S2YBnlUuYROLJDtt+ZJhGbIfEeznbfHaMe7z2Bfx4eWtX8txhUzcO0ekwBcnR1+spoM5oPBO9mshHKGwoeQPw8okbtkcSIC+jZoUMV9wCDypz51MYwVOdf9O3Tpn6Z5lIoiYvnoXF1F72fDf8EqP7yYFj+gBbSVcc812/J2+I03tk+jnSsBP2ljG7u3uP41+4D1nrZTz+w==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4336:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;31:cBO5EphXtnSVuF6yO+ykOoCHQM3ltj6xbiPgliYkdf2ovlw6h3ha1QZYx4a7PT79WfMBHnt9Li4GiuD16to1BgsdLlmKd0jGiWONeYfP3dPJ5aagBpsZP+MpR9GO4va3IjL5IW4q2OaIboHKr4UejVaEWauu/9LzfuKW/iJV7xzbrF2O+xtH9+Po/Q81wZ+/LlmkEkvbTzkAX6k6GjI+M87AhAhqBHPgOQKlE5Jjkwk=;20:tQ+Y0nstiUxrbEbnwht+F3p4l7r1Ep3HSR5vR72uu41B+TZyR3kfTTApz0G0rzKKIXNI9Qx3tUtUNYnQ0YXwT073sRwS4Jbq825BqafejOAIsZxfV6LrtZs18poDlCVK4DarJbhB9OG1uoAYhrPh+cIitlFGW85RQSvGOl/RFsuLZJ9dFJX1OQ/ffBt+en9SfDQUIRe6EE1PkFv+gJgsubDler8eJ7EWE88uhKomeVfRv5YReyUPv60Wb/udcbeku0qw3EZD5PoY1WN2C3ewnqkm/AbiLNzSVNrsbflvAqUdsdM/AX6XqRVejWj6HORpFAS/uNvJWMB9mURFCIMPUPZJSx7YZdWo2xjs46so3OKjayEb8TlSJcLyTAhNR90MgMloAXE31PTOmAdYeWTDJhwhdv1J56crl95HTmEdK1gDWfZdv5Wj/Gg+VSAkvw+gBhmqN/f/Memxr3NCH5ke0lfZ68qUFAyJLDiapIB5BxHRZF8LMl0WILAGMlqoLtrW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4336E74A3D5BCADB5A12ED6EAF8B0@SN6PR02MB4336.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;4:J8QSewr+A2DDA+24k3+/e7bI+iMkPuXQ3aNHHqJ9ZAq28u4JcvY4gmLIwTv+n+Wq3myrdPrb0/YAh/sOTnIRuRCyNBkIe4FL7mRhB/YMZ8lyULrs89gtxriaMY2ipyrhv8BekVB5WoBDVZwR9/HYdjVSWvrDy7H7gcCEryjcOskhbMrriMzt8tTIYfh9PH/vLL+YpiRN+B3Wp8keoDCAll1eZ95fO9SMPOSPD1a+9SF+AhyY3OrsIFqx01oaUOfgYpsNqJ1VpeAs/NG0+bDMw1Z+Q+sjoeJ0YIhAuiuoL28=
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4336;23:2Jp39seudmi0izyVx9pudEHCDpZesSoscYKXBH5dl?=
 =?us-ascii?Q?KCXvEO8dWiyrGtUN3cT51HpNqISBtGdOOrnbfozK0BwEEV6QZ3HM897INApy?=
 =?us-ascii?Q?ebMC4r+2+5RViNrpjE4SU0IAZWz8t09FeIIR/o0HyhxlIRGIwfU9bG3daaMQ?=
 =?us-ascii?Q?ayK2ozPn3Gd8U31Fe5P5KPFaMLiwHkoNfHh+cLXYhoCjIhB2fA51gJ1MQj+c?=
 =?us-ascii?Q?o3IVeeq+Kfl+BxEeWK1Xk1BTvL6anzyGldayCMXL1WBcXq3QUoExgx3XN8ta?=
 =?us-ascii?Q?QXBJrmvvqN+f7KUPkv13m4ZIaTeWFpED3gWvreodCjSSTb7a6c/esGQNLqGz?=
 =?us-ascii?Q?E8UKIJxR184w0TCTJtboQ+VPFNb9p9QCBnRKK8X5Z/Y9Fg7Sm4acDPv82Qmm?=
 =?us-ascii?Q?xVy1yeHIbYfI8lEjW6QG0+myH0Frs67eJh9F6lxvnNjAJHxt9pCXj/ktjxRd?=
 =?us-ascii?Q?oslnNfmQm2Eq5a0ri3BIc5AKQ9eQjf/GzBge1iIDeysrEsuyDZHRFf4vdrV5?=
 =?us-ascii?Q?/KWOEOxPl/6zQuoOtRXAnU7BBs02LtRGYlnuCXnozEnpZERU0WDnCVZnkaM0?=
 =?us-ascii?Q?1kbsH6nf5Z+kkyLASX/VogYTFv7emo3Y5yFfip2F3iJsA75odjE1X82745AH?=
 =?us-ascii?Q?jhN8KGdlHRrIoaZSxchYdMcLy0vKPX3MzPtFtCcu05d+IZTBq3DANcrZyoK3?=
 =?us-ascii?Q?nL3APxcIcil3CwkjQukYH/f1UmPb2CjpFR6UQxfMTrgoLFjm+yjRiLbdr8+I?=
 =?us-ascii?Q?tomSZlUmANhFpUEqZWSgpb6XxHj+PcKwbQBkc+YqRBAgfSz1AJSyzWy9fy8b?=
 =?us-ascii?Q?3HI/VjtxDy8jLb3KTGxLtDKqXhRPlOa+WVVafZU2IfL9g7NYVoPNDYfG7tlJ?=
 =?us-ascii?Q?ig9U22qoGelU7PR3OlD54vnPjbUCLCtbOOW7NfXx+W+u+9TZehtN/7G8pbt/?=
 =?us-ascii?Q?8gj3jSKDbOMhiqxo5IXwe1w3B2J6FcrnQ8LsIxhSWBFEhRq2NlUHaRUh11Tm?=
 =?us-ascii?Q?B1O+IROaQMdNgrr67naPlsAZrVj+g2iDakmvDRNOKXsnyCVsn7silAKwCzZt?=
 =?us-ascii?Q?JB8Gg4c08dGge1dJLKmt6ZPphBo/E4Evm0bhp7tLV+Yf/p/tWMri4FBxXH1A?=
 =?us-ascii?Q?Teb/JFpJX0/rhYFkkH0NzB1y4xFhsuJTlG0qhRKtQvzWKfAceJ4LHJVfrJdz?=
 =?us-ascii?Q?5bUGhWn1DFTeGwthm5V6vCO8NO/BKKZ0zVVVa/4EFQtTsGmeIUfLfK/FQ=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: foUU712Wh1E4+QblLP+ACy7Ou3PspK7ipTDCyrMY/UZCC4WBnBVaPImP5dggLIKmIEQnwXHEomjlu33qTYIa3hSuD/p228PR+x1ZHge3zV4mgz69K2W0jPxUqPaR9MBzUqkzAmU/uNgtAlKrZo/HIcRYUjwQV1BMvka7q1Gvn+ES2qaV7Fc/h0Je5dFt0Gol+90porsY91Bl5BCqauyIWCPyZ7uJlIujY6zy5c6JzLfBbsq06/sdslIRZ3mU6WjAAjxW3GM206lZfBL1zjMCH4hDmCnecc6f7+bIzJesk/wBQ//iDdkK8kOjQgREZ6Ld
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;6:SAwrKzraG5+PwlxsyOoFmhA/lN50zc4GrlE1sma/SbskidyRolLnodGieah7k2d43/hBjW0BlxSrN6puH59tNwYRNhVZjVKf86v3CnrFZCDnUZ2wLfbgUq6mbzQ88gIeu9wMdA4NoVYoLff7jjVvJ9zurxwipHRB1MZtyyA75bMrY2Yu1jRUV+HY3/Js4i2O40w8Qwl0DMUBsUQjxRcIbuLnjitkFdJOl7/080NyxG0y6k4SoMPC+gMlfRJMgqWfKNEdNw3zwVerTXB7FN2hhatehqsf7p/PiFJOtxHvejgSVqK62QabEcrQ52iF3aWiRGk3kXyJUGd/b/UDLK+z8vokRfEkowcHuE3oZ6kqdHmVFSI5PMHtjJKMDBbqfFRvE3U+kDNOlQ/uLEuw8lcnmNcDqSdgU7mx2oDtJ8XUYF1rkWt5Kk10h67QtSNC4C2/Bdz0u9h8uE+Pvbp8iN9tog==;5:Rxty48k32ThwVjMKhMXweUD/kY8/nu/wrFax+9KEbAPOEeki52UG+S7BAy/BW1ffmEaXQoNQTqAaYQ0rGviarqE5iIuZOveUA9UBoWzzj9Oe+mAEgQF4VZXpDczqv6WQm/6Zxt+2W9+95ir+tydLkVWDmI1/egy3GKKUYkQtNwnkuJ48e6fr47+EqnWcz6zpO+sntUHYjvjyOrfG9cm+HA==;7:ChNHSbmQiZJWuY4XNYrLDF8Qk08y4PhqFbY0b7nWcpMJJoStBvt9FKOmRZSYHeqexY7KG6xII/r7jWLDisY2R0kHqS6BXRUPagtx5a7g34UAPpIzo8BYzhIC5hplEjrsVump2FL50M5fovTa9dQH6Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 09:26:36.2459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cf7b94-35d0-4260-227f-08d676148e49
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP SHA3 driver
bindings.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 .../devicetree/bindings/crypto/zynqmp-sha.txt      |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/zynqmp-sha.txt

diff --git a/Documentation/devicetree/bindings/crypto/zynqmp-sha.txt b/Documentation/devicetree/bindings/crypto/zynqmp-sha.txt
new file mode 100644
index 0000000..c7be6e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/zynqmp-sha.txt
@@ -0,0 +1,12 @@
+Xilinx ZynqMP SHA3(keccak-384) hw acceleration support.
+
+The ZynqMp PS-SHA hw accelerator is used to calculate the
+SHA3(keccak-384) hash value on the given user data.
+
+Required properties:
+- compatible:	should contain "xlnx,zynqmp-keccak-384"
+
+Example:
+	xlnx_keccak_384: sha384 {
+		compatible = "xlnx,zynqmp-keccak-384";
+	};
-- 
1.7.1

