Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F1EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BDA27053
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p+bVB5X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BDA27053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965038AbeF1Hk5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:40:57 -0400
Received: from mail-co1nam03on0053.outbound.protection.outlook.com ([104.47.40.53]:13745
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933741AbeF1HkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kuz8LIpl9NwPueukAhsNaTVF4LJUfmjFvp3tCK7pVs=;
 b=p+bVB5X/sdXHjLfzpe9szlly9dleJIfpmVHCxzahI4HFSaa79JdshFAC3xXDQtLrbXc7DCdo1e89DRBhvoCEl3V7bCMUehO9VgN0WKHoNMStp5DmnapooVuxgfOVQjeTz6oJwRHlulKA5U8ogxd/ySsPPjWtKseMXHf7ukzVmyQ=
Received: from MWHPR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:301:73::42) by BL2PR02MB2147.namprd02.prod.outlook.com
 (2a01:111:e400:c74b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Thu, 28 Jun
 2018 07:39:59 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by MWHPR0201CA0065.outlook.office365.com
 (2603:10b6:301:73::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Thu, 28 Jun 2018 07:39:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 07:39:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34919 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRX3-0004OF-QZ; Thu, 28 Jun 2018 00:39:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRWy-000195-NP; Thu, 28 Jun 2018 00:39:52 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S7dlZh027092;
        Thu, 28 Jun 2018 00:39:47 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYRWt-000187-Bs; Thu, 28 Jun 2018 00:39:47 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 845A6B20852; Thu, 28 Jun 2018 13:09:46 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] Fixes coding style in xilinx_emaclite.c
Date:   Thu, 28 Jun 2018 13:09:39 +0530
Message-ID: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(50466002)(478600001)(106002)(50226002)(48376002)(16586007)(47776003)(81156014)(5660300001)(90966002)(2906002)(14444005)(51416003)(42186006)(81166006)(54906003)(186003)(316002)(26005)(8676002)(336012)(305945005)(110136005)(8936002)(4326008)(36756003)(486006)(476003)(126002)(6266002)(2616005)(36386004)(52956003)(103686004)(356003)(6666003)(106466001)(2201001)(426003)(63266004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB2147;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:ZoXwU9MEZ6IpEb4B7YloWfdJu4VHgZhLqirpc1Xsl5VN67X2P/2vTNfrN8bZVksG9WoMvPg7P26qg0MFAIwnyjPt6hPM/ew2vub3FgkZmP+ly6yxFRNP0psDLUf+Vwlz
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cda98d7-a5f0-4d22-50ba-08d5dcca5987
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR02MB2147;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2147;3:kOpHa4Vhg3PhOzctLoMhqZYVZqHHnh7Mndp5Cr/TmhSl3PvP5rli+qeA2r1a3FY4kqjVMu8a4xgjuydf8Mo6tvuv/Omd8T5aEQ+zbgROIir1WrnLEsrAnfcYSAekujvzYuTNaY9oK4DaFTLDUxrjR9HzzMxtLYQYNfKQsFaVILrpchN+sBruIxWUBWF3/XqOyPoNMM1jAGKAm787C3EBedZU8rMeQmxAMImwslZ2cX3nFCuGpbVrC0M7pSpfgxZ7bK3yrpcTR9UwEGSqEuxnaidGvvN37+ru2iNrC629NIG4lJAzVq3kjsmqHQ+M3CmHA0FpUhJsTVla1Hbpa1gzV+/S3Z0yee1y/vKYZgS9Wc0=;25:5PGJLGB1y2+aN3DkpREbK6qEiQZkYsvEtgB6rh53Cx+FyB0hPB/IYQ5K08d8TjWMQ6t5SEMvXoKIZB1kkGkA6UU+6RcGmAN+gcPYdjdxi/6DHAV5L9h1B8ubnztGSGzRimjozY/Tg4OICwQMBtVRSB9YOtNtFCiKmz/xy2wW/Gh/gTdBwYkeii7/9AG2WOoHOn3scQ45aHjKvZpUxiewpxJGunyuLMEIrAUmDghtA3vyx70f69BJ/nkw9KWDyjlXini5FTgGP6ukQ0CUafaI2ynaIZC1Rvthqjhqsh8BvtbIgBGkqYcKGe1iRMFbZ1REQzaj3bLbNO5OiPBSe5kZew==
X-MS-TrafficTypeDiagnostic: BL2PR02MB2147:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2147;31:dQzzEO50c81VTInF4XrTv4EZWH3AVxyZPAd17TEA3HwqcXleE9xPKXjusvAtqXWmQknF90w2XONevbo3KCjNQGv8SRBNwyWwNy54NgsGN8gQMyuAttd41gXD6kjhGTo9yVQygjmYFTLzAHbuzULjABq/dpCKYG4SoHQhD0ka1keb+gkDLinuNwAfm1acOwSR0LAB1rTZVlbLln3pFHOxSKOPvEgvvRhrAeWTRs/y1+I=;20:2ZTM1/Ye868Xy2rcccfrsx2CuD9ZHoSdIjpE6V912yhh/daS0nvm0o9GmQBuxaPtMFAhFL/lLvd8YzNQxn+d0meQU1wTgWaovs6tNkusdlKACYzMsjr1ALWLWVuepag8kig7OfVQ5aCaqNrIPQNuRKBRA6EQNA9zMNydc4t5M+R500mQic3F7/F7j2NTy9iiPwakFjBmPvM8IWEUo1WOJdYqbIqS70mjyTQq54giA2Vu4nvRr/6BJ+ke6YEVrh5R8aTPTKHCv+3fFx/dgPPV+XM7WLlwJnJJJixcYJkgggWVM4KMXoC6V2hYedESvhZUiuPBqJfNCP8ASnnyyohWqcshsUHSUVSkQIQXMi67VKazKuf48t1P5cX4o/rLCoidjBIyV6R0GEUYUR2+YwYPGRp4mvyt2y1GozBCsl4OvprWplYFuObPO7tpk+BVORvEyCUokkEkG5IFlcIwa20jmFCv1Q1fxi5oC0p443ZDgAweV7qLQfIHkxDT6KLBL+EY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB2147984C6BA2DDE00A65517AC74F0@BL2PR02MB2147.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL2PR02MB2147;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB2147;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2147;4:Tho35YbeNHSwEuKC15EQ8dH8rmWn7MLGH8eRfLm5b7+psUTgKBoLzrr5vaDGXgB46m27Nlb7D3QnYJQeOLvh7jz/yKsuLryzhhkm5hDDAiAS7dkfNX24sIdICWa3wGYI2J2pYJvm7MHFdTuHlkTPpY4yCqbvZKCZyEmNAI2j46blzIBCxF4huGmRmmXYxr4MyvCDLloBe2zDfBEGXvJervF319XZnhZ6jxl61pm5kHp4efsrhXDBuAD6FfUJjUZjnwpPhQ3T5DBjh754NWCLvg==
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB2147;23:IFilExG1Zvt3BE8JLOS+Liat2xCV4K2td5ChsS3od?=
 =?us-ascii?Q?c4EYoW2Y83v0i3i/umpp00sOdlo/dFl2K6YEEAR2rWnu/tSvipAZcPp1MLEx?=
 =?us-ascii?Q?b1/h6vmmIk02VNKtdz60k9jTfexdudqBvzHbBRM/3VEWO0PuSSQMr5m3yyPX?=
 =?us-ascii?Q?3yl3juATQiu80HLBjDR2R1OagZvAR2HCyIaalhrd+/Nu7pLr3sB3yQTJRYz5?=
 =?us-ascii?Q?9eL2/ZiL4qt9TGL3TxM5dL2OHvXeLjo01ls9VYl0alqR+h8DJ8dmGYueQDC8?=
 =?us-ascii?Q?YFu0FzZLbWFTDhUXEVhOKxL9nciSmfVIKAa6Qcfp7L+ZS5FZH96VVMHR6hyF?=
 =?us-ascii?Q?fVE9WjDAd/Z5wP2CCYOtBOANUukfyGpRS5EmgYDlrsuz3rdKs+jjYh7xHrVD?=
 =?us-ascii?Q?SZTfJibvewydzK8A2iwB/pnmofkKvqEtBiytss4CrAl1n+4h6yBeNVkmZnFX?=
 =?us-ascii?Q?zEUPSgj5xezKK5yjZ8vyHct8Ne7R4W7t0jbZnA8IS405P00MEIE4G0QVv1DD?=
 =?us-ascii?Q?1te1NTJeY/Vqmf+maUy3XcartCQwRWtRHFmandRvxCp5h6JsnNilUdAK+gNJ?=
 =?us-ascii?Q?4yyO2PLt8OhESG8tTxxiEP4hau8nTB26JnwC8WUZDjpGsErzjfzqi8trk9LB?=
 =?us-ascii?Q?CpHCz7OwclSkdkIl2E0O8Ri0AmoC69ZIbk0QYhY2Lz0JKnyxCSWn+d5Xkx1q?=
 =?us-ascii?Q?+gwWpHc0lu8KxnrhTXELi5BKhO4zUHIhuY1rTbwXh9LFa0UJ99Q1vXaYULVh?=
 =?us-ascii?Q?Bd/jGRvFWqIVPnskQPDOHJYjPZN4PGjLVSLsetLsh+BtdnV27mxy8/LWpN3C?=
 =?us-ascii?Q?GYHyth1ItLm7lReHiTudNMJkP51KcmfBfXfXmtTJebgAVrV4HICpU5NH2B3v?=
 =?us-ascii?Q?o2HuC1W5kxSbgb0ORgkSTcjcNep/FT+kRa5whlNNfmEqIFtQ2xUqPZh9kwyY?=
 =?us-ascii?Q?a844Uaye9EFnmIUkdy4iP23eWu4/kIPnvfaw7kzRbwixoKiLtj+eANm6zNgF?=
 =?us-ascii?Q?0Gfemwa99OFI+1AbDGhUxGGvW6w4G7vjvlEn5u0uvGWTi19AVduIx2NTkeeP?=
 =?us-ascii?Q?89a/MrDZX6+YIyl9eySwN5sIKVSDC3s/Bj5Ko47qYF13UTedQenSK8LACZM8?=
 =?us-ascii?Q?lZxSrOVhNj/VO9GqRWP5SFhs0tPrZuw?=
X-Microsoft-Antispam-Message-Info: WyzcNO0k/XuX5zSFH+nZMtRZKLkCgK6mpA2mVEtypv1PwWW80u+Y7aV/cHUMOs12RLKriq1biKBkVAcobDbJhb72KhEw7ACbHrQxSKVQMmOzrb7JYNFTjOYdm92ZnwouaUspkbuueiG9ndhMlO6Oli9fwKA09FsJPXecH+OG1vsFj9CKfZOFkczx7vr8H1+1urf3w3p7E+p+U9GEPJOs5qr3ymvwieEpK4NSEQo4uXAZeQZ9u+LBl0oyoqA6/qQ1jPhBbIcGJQXEQF3AUJe+BuYfnUOicMkon+hajkzS+OAhFd8RlLVQkyeQiFpPFUb4M931+j3qFo4VJhu5t+uH6KuHUxKcqv09O8WCYw8Yx60=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2147;6:+eg6i7/qGRLPO/AiFgSWkwBkMUCs5cTcYx0eXU69WJyRRcM1+ZKeHZ7WozJtgkDjqbpijyeszLkWpNVjj8Ku/oXOmy8yIgUXOBQl3ZB9QiF377dMjaKhl9PP2gGZKuz7g0rh/sA/Ii/QSj5TWa3EtWU7rj1DVcyDGov9j6wG1MjwHN93hBoMdFNYtNH7txZ1e4Hf477LrZ1+bgAUejesxnag9m4SGWLoF+w7dFJmEpbMAzsemjj6h/Y++v4qn9KUYPOZZZxR5Ex2B1SzHSPDVcmyDDLwzYoAd9GxTGPUf4zB03+HmZcVxdkR0IL+O4SpE7nH5aTbzjUn+XekMdtafrKZMD8gY29b4ew0MWze39x7KMSiA8dQqGaPBLqIUIebOsp7fkEGC5Or6o5wNsY9WiIMWeGPIMiYAEEkMbY9r06w98HJBL4d0xfKFxMxBYWErL0S2HoIo3ikI1B20H0i+g==;5:T5dKSSGsBB44b4R2m/71k0bpuZSHjlxLx6WwGT5jVtYEceDPENvZBL6+IvArGr4NURb1PN1iax/iEuqbRVtclK41tvHvsG1q9QnEVcLmtL18tz4Bi1o6LG5UEUQ69whD/SycQFoC5rf9P42cJnCCaILQOemMx023JZp1qf9jNIM=;24:NTjUlaCkq1hY126uAkHrIWgoCEwNxJj8h0jeatchCscP7Vvtk3wGhntoL/kpy282MYulbTR9xgAB88rZQOmNITWtq9ZkENXeOMjjeOHz7iU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2147;7:CcmSfo7E+sWwx9CtIj7viUq93/Wcjp0PAEDkw3oMJ2GqYj3d20vimXPRBZLsqUs3tb8866tzjFoQA+vbBscOla4A0lRLyN3bvysM13jIg3vXX+ncRa1/BuR6tmpPGc130nlEhK5ulISdf4169KiK5MxZSNqrxh6ucT1bqc5qD+a2rgSqT+fQ89Kb8Xv+z5pwUo3nUOUVRRijtN21UT9doPT45Wcz2kPitsE7Glob8UpUR5cq5frwzpgppKngCML8
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:39:58.2587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cda98d7-a5f0-4d22-50ba-08d5dcca5987
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB2147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes checkpatch and kernel-doc warnings in
xilinx emaclite driver. No functional change.

Changes from v1:
-In 2/5 patch refactor if-else to make failure path return early. 

Radhey Shyam Pandey (5):
  net: emaclite: Use __func__ instead of hardcoded name
  net: emaclite: Simplify if-else statements
  net: emaclite: update kernel-doc comments
  net: emaclite: Fix block comments style
  net: emaclite: Remove unnecessary spaces

 drivers/net/ethernet/xilinx/xilinx_emaclite.c |  109 ++++++++++++++-----------
 1 files changed, 63 insertions(+), 46 deletions(-)

