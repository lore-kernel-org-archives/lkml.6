Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A55DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39DE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W8jVO12R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39DE2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHQP2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:28:30 -0400
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:37216
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbeHQP22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oUcBefZZDizQhh5U50j4/ut2w/sXtUKikIytlt+zvk=;
 b=W8jVO12RELlTcIsiinsALM70Z7ld2VkqrT1sxoWaIi14DJ62CbeIm3jDXY+FhOsW64DJITaxAdN9e91OOf0wPEeALr3yGGCcUJf+o5MkLGamJzi7a9fvFVmYLzgQC6OFJsesYC/McBZM66pBWTclYVXk7DQL8FglIDlSvnkB6WY=
Received: from BLUPR0201CA0030.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::40) by BYAPR02MB4326.namprd02.prod.outlook.com
 (2603:10b6:a03:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 12:25:07 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BLUPR0201CA0030.outlook.office365.com
 (2a01:111:e400:52e7::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42365 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-0008VO-HZ; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-HB; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOvRx019091;
        Fri, 17 Aug 2018 05:24:57 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoH-0000TQ-B4; Fri, 17 Aug 2018 05:24:57 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 6140160508; Fri, 17 Aug 2018 17:54:56 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Fri, 17 Aug 2018 17:54:48 +0530
Message-ID: <1534508695-12642-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39850400004)(396003)(346002)(2980300002)(438002)(189003)(199004)(305945005)(6666003)(76176011)(51416003)(186003)(26005)(90966002)(50466002)(48376002)(39060400002)(110136005)(54906003)(103686004)(47776003)(316002)(4326008)(16586007)(106002)(42186006)(36756003)(50226002)(8936002)(15760500003)(106466001)(107886003)(63266004)(6266002)(356003)(478600001)(486006)(476003)(2616005)(126002)(36386004)(52956003)(2906002)(8676002)(336012)(5660300001)(446003)(11346002)(81166006)(426003)(81156014)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT007;1:CiudDmc2Z/dATSP+1ojfLhQUwHM4t0anuif4Ikd8bHbRkbNLRcE21BHBBkSZVHlOOROOVTo9RwwMiobmbXbhH8NtXivsuQV1ifOQ+Y4uBDiYwsViNfxDk5/llHZMXd//
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084ef1ed-40e7-46e3-37d8-08d6043c7728
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:FsU5/sQuUQhRp5mtD9E/eHAjeDNXuK48sFSSlRDXM+8CFmfHo0SOyU+Gp9sQMauyNMhe1ZU6KY/vILGvubGiRVRDo1XA1utIAgDS0wYANsCN13teq9JvJlz3MdIqQoeRUB8v9Evd4nkN9c35qk348njyFLoLS7HJEuphuS+Hp195u5zyYJrkbsMCVINWQh+g2U7U9JThkRPyFN8vh24IIIPBrwolUTmUHJ7tMxXD393pvfqnWF4WPStDXyks1F1MnvqZ8OriC+3bJWHsWlgqx/jDCSLx8K9zY0FtY2N9hERaHXHVCduDBLIBs4LN+63sQ++oH2TD9u1siEKpFU8zbUy4ZBd0dHu5inlSBOer2lM=;25:ajV6Tc8axJTWktG8bZDk/PeTVg59an3MZVD4wbzPOq/0ssDu+Oh/m/2cMIiSXpBLfud8dA6fxrB8XUcgk+xNRX29ULUdSYhOc68Exe1135VTI3bx41I9uuIEIavzMDlg78BNWwx9mNjfVlarLUs3TuAH2GCwKoAn3hEpyNvXhJ24+7pJeqEiQ6xhDtJoJUL9R8K/PxiTmcsh3iDEVu8Ve6NmL58bKuN7jM1aUNGcOU+9kwIJ3SxQMeElMRxQQwYiJZYRwgALv4dtaG+rZKq90ogJZS5iS1UyMMDodkTywezC0D68x5BLk7466aLA9F7ZjqtnZMb2pjcWzhdGg5rVBw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:C8VHmyb/EWDwV1IlV3ru3YRFC28/BPpXCU3OYKZqME0fCPEIj8uohx/F9eY7Zjohp3LJlF+IDn2vO/KQaP5jYvq1SlvJJrfFQUhQy8kNRJLJ1QBuT/oqxLfl4hhfBXQfJ95FqshSE//Fpj0Q90olrtNqnBRxaGFsaNuYohITrKlig3HqR8ch5kUpSQijTfOFbkimuqNp0JkPGtAguXzQirIG2Nnf6n355qE/JFoH2Zc=;20:idM/w3hROXJ7Arl+UsxLUtk5noZVCpqc9DqzXnKUXICVnr9ZEjwQ+lG5ezQ1XprkniYYqLusw4OwShSz85jSq22KrrZsB0563+0xO24uJ6RpvXVu+op0b1sn5BP5cDBkz6/8fQn27XUGlk2DHF+0dJcX8Jp0EdTMWF3lNySCSp59+7VfrES6WyGJOxwf4GreIjkvG0G/Km8Il0JYQ1GbZCvcv9HIAm1/fqYk/xm5/S8ecSieWMKRBoHQFPghSa9igPrJW4dtb+aSGPIfPgTmoT5ePVlroIqCOh3lUldEd0B4yZJYKzFGtNvrAPOzovPWWjQVOMEuc4tFbS/n4VY5e+l7XzVQWcytf2WjrzaT55aHNNwSZdi6ZqsxT9aTTUTlkc3SKySHJAanRiHBGEcJDPwVI5dpUtYqKv+dsIQONrhjIZH87G9y+Ex9Tx1Te5z+2MRUDyov+JLdRZubwm5OFKYKU2CqShvokWucepvXVy1+shLrj+07qwbTA0KyDzJQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB43262C7D491E02182011B5D0A73D0@BYAPR02MB4326.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:3rK/U51LeIaEgz0VSVZeDELTotv0Jb7quLd/Ao2MTc2btglbCfS8prOqNZRm4k54ichTc6XICAIOm5tpDaLkFifCfy+Yc+wm2NJzdxbaXpqwcUkwgu/I2WSIn3lsd0ujP7HFR2LmFMqmXpGzNvpQKhO+TqNMxpNYV/gk8iYov72Ew7ys0+EjSMi1l/McCshT6DqTd9fjjp/GILAJUzxSER+SO9nXVQDYJ2SVfURTeUBB0mmbleTcyoZfXO/NIrKr7tGBfqGY8Mg9t8upg1q5P2o7I3YgLXjr/a2A6pgxEbJFp7Iam+wQuZj9j6xb/cLh
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:f/mjmHBVd4Ez+OO1+x6+sGXVdVTUhsRs4OWEOxjG3?=
 =?us-ascii?Q?W4GUjFITROxtmB/7zLLwo9ZqIKezNB4vx2l+Bo+E0klG0ZMxDZR8yiOuFP/U?=
 =?us-ascii?Q?fbZTpp+X4ODljZy/u3rvBA7ev6K8UF5eElvCT+Vwb/I2UYbvk4sEC2kxPtEO?=
 =?us-ascii?Q?wBG7vznCq8oQHXAGIFGcrVEWpH5HpRIt1a2UKBkqa808+sx+ZKPZO94aU426?=
 =?us-ascii?Q?+1pMwk+MJXBKGVxpCc0lIV7U9LctZd0UYFHx335eu/rTtN5oYQ4/ntQ3oFou?=
 =?us-ascii?Q?tFLhAtgZZs3rAKzxL8BS3DrxL8+YSYajpiS35xIXLQrV/PNd1KvZHRj+UtxO?=
 =?us-ascii?Q?Go2a7IWDOeeiB+9XmT13KviscZioqv/qUEo+t+Y4c3cYIjDAMiG36Z2gnBhn?=
 =?us-ascii?Q?TzuMIUDgBxKPLHrjcHvB+Pzs25+iJHyaxoXsIjcsi3un5vVbFyftxKtsiwDo?=
 =?us-ascii?Q?pSFrrrWJKR5iXHVNXSFkJtFPo8PkDmvSflL94pgHoDiHEcqyGpKgM8dpwe7U?=
 =?us-ascii?Q?XopRgjFhrG1z1ynkrRM8yYcKC1wWEqupJ6pYL1q5u0FBOBjN72xSsjSZTO6o?=
 =?us-ascii?Q?EeIhAYXkntXsoLuEXf65VmPkdcYpTrd7ze5AiYurVXtOry4lDBgeUEgS1jiH?=
 =?us-ascii?Q?g/7j6VFTjZcgYHscyj28/1QJrIwi4mNqYuOtn9t0VPUe8gV2Wq5HJEmEpHKK?=
 =?us-ascii?Q?191YR17dQIMVg7rgbUx0nwCg7+ZQYCkEgNchYErfZlkwxGOIRr9pmqHEQ9mx?=
 =?us-ascii?Q?KI7hRcNGoemTWG7IE2pQbe5O/dKC8ubaw6A1vOavfBJy6EseWvXrQ8FA+xvD?=
 =?us-ascii?Q?IddEAs0Smvaa0hJwnmC1CVLOouTpY21ydhzqlYCOxVrkTdCSRXSNQ45/CEDq?=
 =?us-ascii?Q?Rt7+p0aDgJvIKkvCeqJALtLItK3njCnzqi95mZLxV1YY5nd/+wo4Vac0VVc7?=
 =?us-ascii?Q?lPm4QLTueFuakDY/iQMLokaC2HEiyXCo/pOQfRn1M+GZS00Y3XxTgcus8xRL?=
 =?us-ascii?Q?xj2FCTkWt+AKvX8EtawGdXlch6uSfskbWL4JYektcmGN8eTIP5iO7WBnhADp?=
 =?us-ascii?Q?h9aUNnbt0rUxWpfucJFDUiV3bZZ8qjNY1a1oaAklISUyd9hYS5Uy1c5EuiEj?=
 =?us-ascii?Q?fiEy4S4yk2BnixyYhnAnRqT3bV6RPVPfFJFlkKLZOsqQedA87q1fgCd8wdOz?=
 =?us-ascii?Q?n3peDNVZ4hhydU+UANrT9vMJECogjPQyBlDxSOJ93rPgEY03nLouLiVsQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: nziTQOwrlAGUqNVrorleEIdfR9G9YVXELSmApyIYkl46rtWtRUsKxg+zagvP8QXbqXJe+/B/y9nRJbfF1lOaAhn+jwmwLBuSsgtHrhWSPG6tBFce7PAzSpgEaZEAXq8kaEAXBP48ETtF6thM3Y5hSQepoUiiAtQETU02DGxFnzkw2qsfcl+2lJURimhAK3LzfVbRraKizA+Lcyg35B6kQmGHP4HO0OmeI2sys7k8mA+lUyuNjNqHFv7aRkDAaieiF39Kc3XxPsDmhfp+wHo8Bkzi05LaPToICP+LlEM+f/WflYGltqVd3op375wyjKi901+RgBMD3Ue3fCbbkwxdhWmdl0BNP30kWfMi8Wb0EhI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:s5f5EFvGPirp0kKmF0s2KW3cXP8Gl1Z7OGc4wBK/JO4kFM0nv2z8Iw+4s0Fu2joYHZKvM8PerWRmpPY2RL0HD+D29f7y84o3C5loe8LqRu5n355WKJ89nPIAB/c8Rk3fukRF01ksY3riXTzRWuvxYQWS24GjL/DWHI9BhG6ejC3pFmQgNmvhE2VwOZsmOW+v+2kAjYrrxZGnpkp1j3aHS6BM7g4MYNNBm9ZIQwN+uvsjf5MnUp6KyGJJeKY1lqgi/aZZBopi4ehJywBlgXnH248pDy/szqE0h3ZJAhFQzK3DoOvkfsnRU9eu2Ih64NtUmwL6oyBBmY58kN7eZXvYU1lKAzpQlyYlF6F/GmNl+SL/jD1A8dpd7/NE3+Cu1gwhddUvS49jV6vpFbDCt6KhvEzdeKdP/7vEUTHoCAyIK/dQT8jBnhJ0Y2ekbyc3SV7RhnSIpl0LAaWd3/LMnUgjCw==;5:hTlMZRTCqBp/PyIIjq4TxLyz4I7/O+eOCvFWjl5RxJMbQgxFGjp9yLIsliGiYGAataGRD51MaKiEH8r8+1BRGxm2i+jKyBVYlchN6ss2qvnDMD+QsW3hX0oqDigSrMNNtTHSTBq4lbKWM6caRlfrnspufo9TSR0zF1TB0ayXqEU=;7:ruToaiP2VjumQR9TAA2eK7oLb8p/l8DGa0Nw/mPOAa8zUUiAmDb9FnaiBvRXYGt/bJIMB5PxbafFkFt/0AjBwNHX/r8qW/aNgRoT/GlsgKhODWvEqA5abl1J1Ygfo4x9mYzG9PfdB5CjJ4wph6W+0SnsWzGiAw6Sy64Izqa0OKZ1XTpLRBsJR6/jGBqNLaZz7tcBfmC+G9qmsFCF9uJrzI93L/KmYRez+rDfAM+F5JJtE68r6/tSQZA40jN+bTeK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:06.1302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084ef1ed-40e7-46e3-37d8-08d6043c7728
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Availability of TRB's are calculated using dwc3_calc_trbs_left(), which
determines available TRB's based on the HWO bit set in a TRB.

__dwc3_prepare_one_trb() is called with a TRB which needs to be prepared
for transfer. This __dwc3_prepare_one_trb() calls dwc3_calc_trbs_left()
to determine total available TRBs and set IOC bit if the total available
TRBs are zero. Since the present working TRB(which is passed as an
argument to __dwc3_prepare_one_trb() )  doesn't have HWO bit already set,
there are chances where dwc3_calc_trbs_left() wrongly calculates this
present working TRB as free(since the HWO bit is not yet set). This could
be a problem. This patch correct this issue by setting HWO bit before
calling dwc3_calc_trbs_left()

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. Changed the commit message
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 69bf137..f73d219 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -990,6 +990,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
+	trb->ctrl |= DWC3_TRB_CTRL_HWO;
+
 	if ((!no_interrupt && !chain) ||
 			(dwc3_calc_trbs_left(dep) == 0))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
@@ -1000,8 +1002,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
-	trb->ctrl |= DWC3_TRB_CTRL_HWO;
-
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1

