Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4879DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85282098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="t1IpcJxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85282098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeIQTxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:53:33 -0400
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:49712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbeIQTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzarhEKjH4bFxmnCAsq9G7Xufpt0jiGEopcXTjYX8TU=;
 b=t1IpcJxWjOb6ME5nXDwLUog5+rIfhhJRqap4JtN9d+0LYkC/5V3JdtFS4U5wOGwqRGRiTB2IlSsBB37ocAtNjJ01Z9Zycaf5J0kOignsDK8VViThcK5AtgNV7HCo9MvqGivfBFFphYCAhCuyx0doGEC2j7bzztgMK/OebUoAGr4=
Received: from BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31)
 by SN6PR02MB4768.namprd02.prod.outlook.com (2603:10b6:805:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 14:25:41 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BL0PR02CA0054.outlook.office365.com
 (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36861 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT6-0000sW-2i; Mon, 17 Sep 2018 07:25:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT0-0005Mt-Va; Mon, 17 Sep 2018 07:25:35 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPPHo007873;
        Mon, 17 Sep 2018 07:25:26 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSr-0005La-50; Mon, 17 Sep 2018 07:25:25 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 52FF5121463; Mon, 17 Sep 2018 19:55:24 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 5/7] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Mon, 17 Sep 2018 19:55:03 +0530
Message-ID: <1537194305-9243-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(8936002)(50226002)(2906002)(103686004)(186003)(217873002)(305945005)(90966002)(81156014)(26005)(50466002)(48376002)(14444005)(36756003)(81166006)(47776003)(72206003)(356003)(7416002)(42186006)(110136005)(16586007)(51416003)(316002)(36386004)(486006)(478600001)(5660300001)(76176011)(106466001)(54906003)(106002)(336012)(8676002)(6266002)(126002)(476003)(6666003)(4326008)(63266004)(446003)(52956003)(11346002)(44832011)(2616005)(426003)(2201001)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4768;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT032;1:ilJ4i/ItP7DN7Q67+6g3y4WNsGkPqrJe3/3BL2PwMl8uTQM3uyZJvOtihHcVmclx0ziHe8Q+mlAtx7tqQAmC9PFKGv3qlGv3/Z4hYrNvBIXtgGAgUTUsN0tGVks/Ez/T
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2599ecc6-32c1-49be-2f6d-08d61ca9722e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4768;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;3:Whs5oaYZdiJNeYJ/TpO206nvchmJF4XWFpxA41QNXGCneJ5LN5AKScCacmmhr5pvHQPi48I1fmqsph4lsvlhJ/hKyjw49AIhVR9At/7db+51V4eRCHuLl3lPGcN5uimt5YDMx99gfemPU7eVtYji/h0UPmqlbKZodFCyBZ+SJd+lCeGs8KHyRbadv5BUIcEIRAaPagdNuF52DDKrvjmtgG/wjF/h4IZT0b25MX+TxuE/6h6T0D1e4JzcgZ7kLfIXX2GLVPNbSHeOY3i0Nn/6/SBYdhKlq82AqXwNbZFsBYVsSjHHTfKYgUsGGPcvjKNVTcTiGGI1UWgU6DurXZqSP7bIjTofn0fQfKEAg+uyEO8=;25:4TTPBb7MSCs6FLvDjhdN2c4d5tuWeoV8M+9o1tna7XpaxvzClVXzaZ+EndYWfeN50HYq8KeIo8IBfmuxFVuaT+cC2FCnKXBqxrCngLyhgeH5W3VfNSupG5rtoTgCqkEiWP9W4pz4kCqMNmmWq6hyqyI9nn8JdhnIkdlBxX09f8tGOsclPc/wrCn9AD90woCk/lmKbFYH2sLYASuNlfDR4jwqXh1gNr3Iho/T9tbvqaeq9xtVN20rsA+jshVUupA7AXjLNBxCN96l8YUL+plEAoU9AxGLct3QOBgNZigOs4uzg0wnQEjvD8JeyibzXVZ3YSsv7ijbTzWGPfKq0a+xng==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4768:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;31:AZ9EkT3HPT0/sKfG2R5jGCc0NCy5ykrV3Vv8wIxa7YAZ/NKbX5+dXFN4ffHsNhw1qKlfDa0mlyWd0RXZBIRYCHkNbuXxTtz2/X+WB2VdVZn1Yn21gaD+NoGTSEO0Qv+VJnsKBDve8jBIcaazTLpLjsw80Y0bIHLgQOQ7fAp+c64ykwzvqLZi05rJ0XAb9UKZMNdz/qBGwK1C+3BfxGXxgwGaVTU8rcnl1JEWP14dT3c=;20:UCPuZrPzvYWGZp1ZZ6zgUzRkdaYc4ANk+RzacJLO7cPMsugZBCQChIJR7HyTF2TmnnkLZ+Eizb/eV4qTjIc4Lwu+HfHy1geniCCSo11X4rfLKQtQRKUdExQDrstqvIxTW4yMyKVJBfSj9Qnj8M+64ddN5bjbavtw1HsYeoGpd+QfDvoJDKiD3+WjwhACe41FkFwPlx/0t1DOkSCDLC0+gLQSWGrjjOe7/bEsrB23OtlEJK5SDlDIQgI2QwPpd5IeByymKXwofi1awRk4ePtiqDRNgBiCFnoFrM2k9UhB3U3n18WGeSJwstzEjcoA/9rRhPdr8yJWWNZ5GmLCSFDC58Z5zTQNoYBnb2uljl0YCmrsU/Re0q6DzZtWrK5L4MmBa3iRTyc4BuBA0bOzwiwu/7MskxIbFABbdMoHf9FXitkfgwPqHMH5dv7NwgSr5bAdhMZwgnCFhMWtu4SEuGjF9BpW1zCVGjVXj27PdSDFoog7uOVIh5rNNCubwbF3sK30
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB476851275A4823662CCE1E03C11E0@SN6PR02MB4768.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN6PR02MB4768;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4768;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;4:4Fb1amrqZraZQiahDQ/6FnAFV4i/Ly6KwrBlsL0uO4hjGTDfewtmAHP0vOCKZ/0B8/pCiLr/8Axvt0XmZrz1qiouSkSe8Z0nG8E6TqO6EWH/OZVvg7PJFvi+YRIeiGt5oCCJ1MtciDot0RMbk0Lfw8cX9hfJMN/y03WJFFx2wOpokGrDkKr/SjTZhCQBgbOLOIV/SZD/EQ0CaXFCCtT++xdfY0H/r8kS9R1YVQAwJit5tSowTyDdN9bCh+rWHkJcJvRSApXsCr5LHo3HWeHPKIsdLk05LheVT6C7HJ+Mw97dwft5OxlwMF8hKq2cpja/tt5pjKdLFoBaw1IuKLuKm70o+WSUePIrtaAwpAQKIKNINl63b5mAeZ3qO5LquzG6
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4768;23:+8Wy4S53gB3LVGJOcuK9mKNsDOV5G+rz8Ma8VUwdD?=
 =?us-ascii?Q?cJmFyL2mfUkCj+XRRPnVQETFViBZyd0z3i02rFNI8sU9o87urt//g1FRjgh6?=
 =?us-ascii?Q?gd3IDjwNn4Iad+6Pv0jVXZ0Np0/xlZITZg0Ce/N3F3Ne6miqSY+zr9N1BiTm?=
 =?us-ascii?Q?ugf/EqO0SwmOTEBeMW3XC2V//lb1s0nyLbZB+5nEFIxQc/3xfKkzMtvyULvl?=
 =?us-ascii?Q?3WJbhMYq08u5Nje5peS3iCt0wWzXhpYmRwNhQ+9ysmyh3Us21/7yRUkF+seb?=
 =?us-ascii?Q?eDm9uUX7Dw1KMou+urXgvon1xJ+t1DySKJ373+42l/iO6h5bmTW1d8tO5th7?=
 =?us-ascii?Q?FDHH4+HfdZJql9sWqqPLTa7cETny9RQ1K0b5WM8LanGWhb1TV/qdYRXz49vB?=
 =?us-ascii?Q?oxC5rNGa2CsQWx3xxpxLEzgM3Vox54rObxYk2y5J4/nN20gL4wVkDK10x3LP?=
 =?us-ascii?Q?vsY2ij/ovI38A+mWIc5CqPOhiUmKpvRhawwtumPMj64mPNf/+EJc2+ZUAzQa?=
 =?us-ascii?Q?Xgq+iYT3DfR7TKRgOMKtL1H13OFWVLZATet6H95NP7V9ZWHgST2QV0wx5mQ9?=
 =?us-ascii?Q?rIDdXizrynNATiWYUXxdyeSNCYvyA+ltBjJGmguUgKWlJDsRRdhSi/C+wJwV?=
 =?us-ascii?Q?5Bi/nRvJynwPBi+uAq+WYdH1hCa/ZvdxlKTQfTWtv96daag4rDdoGhl6H+t9?=
 =?us-ascii?Q?IbknIyMwiH6WLsyaQenmRm+g60y25JlG0elBJQv9hwpdVteqlDtXVJdc+wsy?=
 =?us-ascii?Q?OGpEC26rPjJ8kG6mbbsC63AbmENCXrDXCXsADoy0dMGfRchO2XQ0KXAv2itC?=
 =?us-ascii?Q?0ZGw3tydWD+4LOLvYRf9X5rOf9X7PeeOvY+/R4lWV4eJRhdee+4zzsf/4a8z?=
 =?us-ascii?Q?Uysc9hsAUTwPoZ7uMT6bNCZ+D724djrxvnpcAPrY6lQSiep4oHAwjH3IvcoJ?=
 =?us-ascii?Q?dhsSy2f5oU5aoRTC9WaBnv2TuG51tJ9gCY3wp+QjwtiU1B6STEMPs/1sHrWV?=
 =?us-ascii?Q?JjUMhMNfGlbSnURDI7hORxbKGY4nSxtuRNoyfBJe0e68U+K3rJYw6Prh1sE+?=
 =?us-ascii?Q?sS2izGInhY9hMK4BgRDWWE9hMTjt7BJ4W/glJ4QWJINJKn/LyockR78jSpwM?=
 =?us-ascii?Q?IsOoInuqFMFLVGTu2i9taa232+1r5T7PU+BcSSJiLXFZ5aTjaCaDQtCrmuom?=
 =?us-ascii?Q?S8/DCxSg4PVesgq88UURnpddtl5muw5ObnuVAj5/DB/uJu2m9vkdEu8DoLti?=
 =?us-ascii?Q?MdQ4zxWFoAWLFzZ3sk+l1QpzI5n2vzYe4KnLu/9F0SjBH+vEhqIIqxWqzSPd?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 053/aQk03MUuEB2G5/bsXZ4GcNzSHFz0kWmJ1dpwXTvKuNCAYnoH1KhEaJqigtbaRftdg/XIlVPPfefUM/lXPWY7VgQxj/oc0V6+s0iymwNSyQMUCowAZvtGTJm+bN5URCiCoOxWmHDbzFhrHaKF+wWysWkUPfHfMNjgfOljpVVbu4h+eBbQDphrzIuEJ+U7jQ59LKfZ7gU/4+gFrPvGmVEWLq2eAe9jjv6T3uSG8+PsDOErjbY7blbi+AR4TuEMjC1a+T96IGKIeeSnPZkK7KEibr6bWMeXYMVs3Zl0CcsX3iJA2k0cLfsRh6APYg16szy8FkrULQu50Hh56kJsT3K2jUgE+qzcEdGySTkBVQQ=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;6:uhU0wX0tGM3uY/bHFvxHsJBD6xNDx3au9b4WwLJGM5OLtr7L86AV1bSWiZI9SkToh2LzDYqlNJuEHOu1jmX5MKsCGaJ/RKVisrWfZeBfylVuNany8/QGlb0K5CYNqoD7YmJL//QJ14YTQM8nczxmV5Jzs3mmquiUERdH+pMF7sloD9H2RlWgsgdtBI3DTd5AF+fbVLp9Lrj7CItMByIO4eJaUmcQmdyE+ro0J9pBuPamMsAsULwtKBIq33hz4HA771oTypOgzhvtE0CNEctmbXQECfZqaDpT5FZ4EsY7YtY7p0lUdGiGSuraYjsMuVDJj0mtc76yQLH7COV+r8XAwPLfbU8NB3QWn5loAeWrarM9tCGx7cchrK63MQ6/M7dzHPw19Yz+nIg8XmKmn63tqyj1G5fe7GxI/Y+P62TqG8EqGpawKL6Rd5esOay2J851jMkUQ08YnKTiWVRa1JyUHw==;5:poNP9PdOEzP2BVNTqXnk5sfkE0A1n0WzbZajuCpsQMgRaG6W2uifWtEGRaZECVoqYudpSEAPPJWfq87QHV6zmHDgJZUkfjYHzmA7NlXECdheZCJ0H3kL+YmwFZA68oJ2Z/cMFof2ypWvzPA3D1wuT0aqUqxwuXn2weGadKAw6v8=;7:/DOLguhQUnDLteLpG4sR9Q0w/HhbmkzBtdcsUvRa4cv69eLQZ9x/Dx2iJuclFAH/dRh3EbQDzE3Y9odAREwSLAxLNHbsLMfuFitlkJV+dYHmckSS54ieyCq3F1jNUGkZAs1s7vQTA+EU9EDbaSKi1jriNhaVL10oLciLEaHbh9CUkQPLRPG/GwfMrliCNG0B/Xcmgc5CC6hRZY0dg6Qu5H0UaTCM4PzixbXMzBB6NOkWcO2Hiwet1JhR0vfWvdim
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:40.4871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2599ecc6-32c1-49be-2f6d-08d61ca9722e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
corrected and uncorrected errors. Add interrupt handlers for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 304 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 287 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..b1fc7a16 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARM64
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6bf7959..7ab5b9a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -272,6 +273,8 @@
  * @bank:	Bank number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
+ * @bankgrpnr:	Bank group number.
+ * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -279,6 +282,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -385,6 +390,68 @@ static int zynq_geterror_info(struct synps_edac_priv *priv)
 }
 
 /**
+ * zynqmp_geterror_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error otherwise returns zero.
+ */
+static int zynqmp_geterror_info(struct synps_edac_priv *priv)
+{
+	struct synps_ecc_status *p;
+	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
+	regval = readl(base + ECC_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
+	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
+	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+
+	regval = readl(base + ECC_CEADDR0_OFST);
+	if (!(p->ce_cnt))
+		goto ue_err;
+
+	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_CEADDR1_OFST);
+	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
+		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
+		 readl(base + ECC_CSYND2_OFST));
+
+
+ue_err:
+	regval = readl(base + ECC_UEADDR0_OFST);
+	if (!(p->ue_cnt))
+		goto out;
+
+	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_UEADDR1_OFST);
+	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+out:
+	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(clearval, base + ECC_CLR_OFST);
+	writel(0x0, base + ECC_CLR_OFST);
+
+	return 0;
+}
+
+/**
  * edac_handle_error - Handle controller error types CE and UE.
  * @mci:	EDAC memory controller instance.
  * @p:		Synopsys ECC status structure.
@@ -399,9 +466,25 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d ",
+				 pinf->bankgrpnr, pinf->blknr);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -409,9 +492,19 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d",
+				 pinf->bankgrpnr, pinf->blknr);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -421,6 +514,42 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
+ * synps_edac_intr_handler - Interrupt Handler for ECC interrupts.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
+{
+	const struct synps_platform_data *p_data;
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+
+	status = p_data->geterror_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	edac_handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * edac_error_check - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
@@ -428,10 +557,13 @@ static void edac_handle_error(struct mem_ctl_info *mci,
  */
 static void edac_error_check(struct mem_ctl_info *mci)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data = priv->p_data;
+	const struct synps_platform_data *p_data;
+	struct synps_edac_priv *priv;
 	int status;
 
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
 	status = p_data->geterror_info(priv);
 	if (status)
 		return;
@@ -476,6 +608,39 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
  * zynq_get_eccstate - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
@@ -485,19 +650,43 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static bool zynq_get_eccstate(void __iomem *base)
 {
-	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
 	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
-		return state;
+		return false;
 
 	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
 	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		state = true;
+		return true;
 
-	return state;
+	return false;
+}
+
+/**
+ * zynqmp_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status for the controller.
+ *
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ */
+static bool zynqmp_get_eccstate(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = zynqmp_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		return true;
+
+	return false;
 }
 
 /**
@@ -539,6 +728,34 @@ static enum mem_type zynq_get_mtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+		mt = MEM_DDR3;
+	else if (memtype & MEM_TYPE_DDR2)
+		mt = MEM_RDDR2;
+	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+		mt = MEM_DDR4;
+	else
+		mt = MEM_EMPTY;
+
+	return mt;
+}
+
+/**
  * edac_init_csrows - Initialize the cs row data.
  * @mci:	EDAC memory controller instance.
  *
@@ -600,8 +817,13 @@ static void edac_mc_init(struct mem_ctl_info *mci,
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = edac_error_check;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = edac_error_check;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	edac_init_csrows(mci);
@@ -615,9 +837,26 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks		= 0,
 };
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.geterror_info	= zynqmp_geterror_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_eccstate	= zynqmp_get_eccstate,
+	.quirks		= DDR_ECC_INTR_SUPPORT,
+};
+
 static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
-	{ /* end of table */ }
+	{
+		.compatible = "xlnx,zynq-ddrc-a05",
+		.data = (void *)&zynq_edac_def
+	},
+	{
+		.compatible = "xlnx,zynqmp-ddrc-2.40a",
+		.data = (void *)&zynqmp_edac_def
+	},
+	{
+		/* end of table */
+	}
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
@@ -639,7 +878,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
 	struct resource *res;
-	int rc;
+	int rc, irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
@@ -673,6 +912,28 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	edac_mc_init(mci, pdev);
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"No irq %d in DT\n", irq);
+			rc = irq;
+			goto free_edac_mc;
+		}
+
+		rc = devm_request_irq(&pdev->dev, irq,
+			synps_edac_intr_handler,
+			0, dev_name(&pdev->dev), mci);
+		if (rc < 0) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
+			goto free_edac_mc;
+		}
+
+		/* Enable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -684,7 +945,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 	return rc;
 
 free_edac_mc:
@@ -702,7 +964,13 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 static int synps_edac_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv;
 
+	priv = mci->pvt_info;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		/* Disable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 
-- 
2.1.1

