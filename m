Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB962C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C0B2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DR+fgtwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C0B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIHTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:35 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:37011
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727597AbeIHTtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8Rmto3np0PwQo6UOw94PVHma2VQgH+8iDl0TvajCQI=;
 b=DR+fgtwNbLf0UuIkzZ3cYK6FqcAUVO4k7u/LLBVtXwWwh1Wd2BBYniAGlKwy8rrmi48Dd9j7ShmC/mJzOVXbS/adqJnp43MKvKEO1wMgUZyy7axSt4Ou2mY6ptNSTi+G7052sT70yWKXgKv4vqmGDgxWLsiudiy3ci6ibWWZvvE=
Received: from BL0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:207:3c::41)
 by CY4PR02MB2680.namprd02.prod.outlook.com (2603:10b6:903:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Sat, 8 Sep
 2018 15:03:21 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0028.outlook.office365.com
 (2603:10b6:207:3c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.16 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54059 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelc-00020x-6s; Sat, 08 Sep 2018 08:03:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-3U; Sat, 08 Sep 2018 08:03:15 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F38Mo027664;
        Sat, 8 Sep 2018 08:03:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelP-0004oS-S9; Sat, 08 Sep 2018 08:03:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 11B0160498; Sat,  8 Sep 2018 20:33:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 1/8] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Sat, 8 Sep 2018 20:32:59 +0530
Message-ID: <1536418986-16609-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(438002)(189003)(199004)(48376002)(106466001)(8676002)(5660300001)(90966002)(356003)(50466002)(36386004)(42186006)(15760500003)(8936002)(63266004)(305945005)(54906003)(110136005)(50226002)(316002)(486006)(336012)(106002)(103686004)(11346002)(446003)(126002)(52956003)(4326008)(107886003)(6666003)(478600001)(81156014)(16586007)(47776003)(39060400002)(476003)(426003)(51416003)(2616005)(81166006)(76176011)(6266002)(36756003)(26005)(186003)(2906002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2680;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT022;1:H63LRSFLtBg4TLluou2Nek/YD6upG//T23sAYLrusoFyOV7Y/9sBbLTpY2bzoL173a67D3X7BW4tuMgnHrnPtTg92cGMeeHRVQysR6fIRZdKkndr31ufwGRI7v7pk5bm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29e66b46-d16c-4a91-ff25-08d6159c378a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2680;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;3:HI/QOzOta2iFTuO33wA/EpTzJOpdCagfTfC8hgimw77EAM1i/4C1F7dLIz2a7ZcyX2+efnRYao7JyxXAs6BGeIkimk9fZu+GSvrju0A6vPGNmK3w8fj6JG98UYGN3nmOG5i0xzV5Qr0sey2BjIK0JRyZxRu9+aK7Xu8Q47Svc0V2GJxuyXTHLuifYcYNi7HqG6+v+Z7qWpzgXeTyegc/UGkvJW+V4aAG8H/YWHMaRwATTaLyvFLiznP7n6+7LSTFoUo0fuyaVf6JbfiFS9crpqfIlYNtrBHD0KyuNycyUnnbckPcDeJIvfPYew7dqgD81TDMDjR5WetIYAb8m5CKSpiC0Thdn2ap8/eUdTkGopI=;25:qwVVOgeJC0ldDRIFsmsqsu3CuFCmKynA/rnbX+GYANSEYq9v8d4Ti5XZSEhlOSgXGIZwgT19wT6cYyTPHBdgwtQkTtTS5URnAEUcdgUZhNrwc3eXvE26jcRX45Pw9p+DM8UukhSJU7AjaWMerNdn24oW/WVrswR5qrspzuVl0OlwRkTEFH9CxEfsi2ZTQFW2mIUROjoXQVvuuWVs6g3UgJtDTEYGDdx9OTIlgZNpWs8FeY3w9sqsB+NnHOiKwRuoHynrNYDR63RheXO66C9NVuDwtzcDjxHaT375TpGFwlOzbx+QX1ZLzACD+dFe6KwKBA5Ar/i13NQa+mStdaN0QA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2680:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;31:8yiD5itCFybJHV3IJ58+nuIgU0iyG/HmZ3itEOKFJ77YKnVEAqCJ7jr+ewK6TBjWtqF2zgrcnYXCh5yoBtBo7wLpyKCI5jTjXofEUExhBn/sZEPtYvo4qZYXbXnQ6oYGwAzFVfARY7RIg3Hsym2iIvLfPVcf953ddRT7E0b5jU1GFb0RTsuluOtoZNnS1h8SAvPZV3+++8+gvGoFVgBq/Q3ExAkjpSqO01jtDkHSRE8=;20:ZwuPsS7ouzCAWKzVuY2gQ3O1i97FMiToKbPAn60gz7EJtattgesPoXS8+6x1wqIBIx1YnoGO5VPrmj55wv7n1nHROOKmA/lNNadc08gGg5d4QFIU38ib/XZO7XtQ0/Hg7mtbC/QTKX5ON43CVTwWPgw28cAd0gGbir4cJ13VGjis6Q7zrCjOBDXA/oJw5tM0B0G9DrgToFimTF6p7p3WZutgqNpet/psGGmIPJTOBOxB+YPjKusesfvdq97bYjQOi05qxEOZ+DVubcwrBpmspcmL4ZbKVbydF6fXuli7szCu+8Oy/MuVYF7rgSEf1Kn0jFprWWVXIOQxoATsxRI5NLMndCMXiPgrSyHkN42RXeXuRoNaxKDi3bZTEXqEJ5aGbpwbgRmba99RbY6BtNW2EN+3smJANU5dF2H5NGsFQcvia63S9leKdlDr+5PivhEaUhPINeeRInsFt5K1cRuEpbT/rcVem2VXhVqzMlVso16YY/LBncJ/O63ZznRgBnIW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB268016E24F0B26EDAEE0A520A7070@CY4PR02MB2680.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:CY4PR02MB2680;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2680;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;4:J2DzR0YC8vv3Yg59dN3zjXc8kl+RLBS1yL2wk44k0utrBfBH73rFJdj2aEiSQKR/OO9y3JT0qIucD/GtNxfI252/i7CEXcz1j1ZUFp5igm5Hj7zpJEn0HeoEJfTjl2U3JgtGu/sb9wkM9EWNHjuRVPvpuTkfj6aVN99bPL6BvslA/n6E1Aiv5Suq6QBNTDV6EjU1PK321/d1ffyW+wi/pq5DT1IrrrpDm5lbK8lwtwkqiytXV17JCvz4WaTcjJVLMjXntcAzrxJsJDDI4/VK5ZaBOr0gA5PoCci3dITYoAGrATPf2JyGZlCqtQFSwz0G
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2680;23:3/ZT2JKxBMCQhUy5Zhl1wS0P0q+Cafh0QEKJxmH46?=
 =?us-ascii?Q?McgF02aJERKL9+9X8ewlevmjUnWBG80vhEOecTj2GcPW64XoHH77gg2wytx2?=
 =?us-ascii?Q?0RG3Ti7Slo8jrPhRqVHLRxVr2cXho3a5qLGd4CBn/EIdOLEugUbXHtdj7t/+?=
 =?us-ascii?Q?mgQR2osT6b+ugGt8o13Vb96reJgiaNMOyfY+Bmok/njk4Bmg3WvkHW3i7VF/?=
 =?us-ascii?Q?FdmCZ7NmzJvix7Xzb6hccN+as4lpyMNDZwles6sXGzjno9Ns1PMqFsgksSio?=
 =?us-ascii?Q?ioGsHDSXxET6D/0arZxOkRXl5krz8DfJJjYoEmmqMeT3lT40MKMmX1XoS1Xf?=
 =?us-ascii?Q?/g64CvaDNLT3h1c+XuI2juVqiruUTGVzhPCS1wuOAj5WVcfYhrWgw0Zbsd4y?=
 =?us-ascii?Q?QuLSJYoBS50CpbwHlHfybiLSWjBKkKllGspu+p3pZQY7DC5M33HJGpk7//uH?=
 =?us-ascii?Q?JflNARt0nfSDuIe2y/oNPIyL+kLkgQsymx6bn/Eks2xO7h9MWy9Gf/0D7FH8?=
 =?us-ascii?Q?87+Ct4LhFRcnMRv97X35IuEXGgPeUz7TGEEdtmu+RyZEkzHrQNYSbpcyAsVl?=
 =?us-ascii?Q?B9nvfS7YTdUibwvKByiBaJKfaQ/j/pS098yWGIEZHA8hxHIpFRpxnHNam2Wn?=
 =?us-ascii?Q?8gNqdz9fvEfreqBDrpZYZCVflwdVjoZ6faDkh2lUzgJpzw9dD+oyWIYszMDy?=
 =?us-ascii?Q?7wNR/Y/HTDlkzHpFc9GUEb0Et4aFE6gfXN/9CcybAb8YgrB4t8asOWfLmmQq?=
 =?us-ascii?Q?zGz/IMao8dlJXSgROgw84WIlpWAt6ZlcI7GbM0UcvzKSZcAHO0g8kWd+tify?=
 =?us-ascii?Q?WjkNjZPHs2gSGUOHwEdUM9g9LXCrHb3Y08t+ztVytos2ogg+sJ05BwZCsRI7?=
 =?us-ascii?Q?n5p6fZjKhrPLKXyTPSUmhdsCKx5agjOMwlL7BrYxXHlg8Sc78D1vzlJHR6pp?=
 =?us-ascii?Q?IwVWg6uSOaN2hVhXETKZ3HeFLCAGkBO9ySiEjEVpGf2lvfzhGA6gL89NuXRP?=
 =?us-ascii?Q?CxqMOQJgXpCtiDY9ubh5Tr30ulMly33CA6EoOUC+5aWrZbfyi37MvyOToA8f?=
 =?us-ascii?Q?OSixx4BZzEul+B9etv6D1RbBN3CYn/isZOL2ielVy/fQgrX3UWBedFXD4c7v?=
 =?us-ascii?Q?yo4DvtW4jJHwGqPtagfXqpv2jQogDskX8R8YDGr7g/azdu+fmS+aXxvaZ71t?=
 =?us-ascii?Q?XtCeqlNzjaJd18UVJIYJUb3BMXYOk9i3gMDwFDGRQd0q7sN4kdoobONsA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: LLIG5+SBOGYQ2sYfr2vNwm38GivBuHeMsgiodAMhnL2fT0DSRtq9N5f5KVb7NAcxxyX9mfoW3L2ndCnQ1ntK1bCvfC+f/L9MkwtD2uScTardJsDipMijfCQlBex2S6lXmKajzuQRLkk66430kD9ISgt6era8Dmvv19SNInCrueOL4mBGT5LbuEPfg3uFsKjttOGi2bs6N16mi2NVQD78f78Z23HVQ5JYHW9gplbS6bBG6Ebq6D9RzLCJa/xs0OA/DTsa1Au/HSO1EoHlpB/JDKV1jH9MP79Jb0KRsTj26KLLv5wosCENh+dqVa1SfpNNiLhVFJGvYEWNXWSKy/3dW6LQr3kJg+ztX1v2PcAtV9s=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;6:ywOUmv8UHjK7d0eO1dwHaGv/gCIn2VU/uY5MZq68d5RelX5IGGI4QgrnFJvezFUIMo2cPrOGXnZIACiLCG1yGi+sZYMZ10pEE8dGmH6pdJAY4u3VB+/D+ZhgaQCrKNxN0WrAWV7slGhVZWP5pWgQTtlV4UUqFiDBZKxCOavb286GjLFTHVBcgUTrBo/hnJT68A+1h7RrHjuP3iPSLYTCQ6+v8On8ObLoq5mTvzQn+JbjTw/bwXIDWTj4N/FnE15QqEPtNiBik/oCMuHEpXTibRIDnEjoYOZKxz3Bi66+6vID9HGBpUBTouXjdMmaIwQsEBmCObZuWrBy+TbUgISo/Bu2fJiW+K+z0XXltM+7rN1aZ3RhHyRLmM3VbvspEoUP/a28cN4IS/hw5+mGkT4lyuvkiK/mK9lZBHojFt8aQ1NnnjVGVIJTSzUo1qJe0uXhVgO4ES+wl95xwQcRtnVliw==;5:4JrF/p+xssyEO1zW7BTqQbW62qBWQ42SJG/X571jhUQp8F2WTbYdyhHcTqEV3OjA8HSEmYwHJCpGjmvAjOOz3NrHs76bhV2f5DlW8TtxU63u0Oq+w1aO2ik3Az519T7DQahHsl+HFwaBDcO4iHA2iEIjzWG2nRWq0OKaziZ8mrQ=;7:CHVp2tsmitGDyFsY4Id0gRsFtiZpJh9oCo0+ozouxUyDFzawg7iegac4qXF7Vkq0kw8ov0hg4kqkRsirlSJuMkBGNANoaSvzkeIFPvZaEx2FdslCc3aGzXmB6cDl6HJCWHTsx5EITxOWSPgbuyWhNs7fxfdRm0yiLM4+iMQxra81a12ZSooxOolFsaubHhrTF+XAnDs8e0I2yOx7igyKz4vhaFUqvU169C96ioKhVNYZAevRIOaE7zngrqmicFah
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:20.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e66b46-d16c-4a91-ff25-08d6159c378a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Availability of TRB's is calculated using dwc3_calc_trbs_left(), which
determines total available TRB's based on the HWO bit set in a TRB.

In the present code, __dwc3_prepare_one_trb() is called with a TRB which
needs to be prepared for transfer. This __dwc3_prepare_one_trb() calls
dwc3_calc_trbs_left() to determine total available TRBs and set IOC bit
if the total available TRBs are zero. Since the present working TRB (which
is passed as an argument to __dwc3_prepare_one_trb() )  doesn't yet have
the HWO bit set before calling dwc3_calc_trbs_left(), there are chances
that dwc3_calc_trbs_left() wrongly calculates this present working TRB
as free(since the HWO bit is not yet set) and returns the total available
TRBs as greater than zero (including the present working TRB). This could
be a problem.

This patch corrects the above mentioned problem in __dwc3_prepare_one_trb()
by increementing the dep->trb_enqueue at the last (after preparing the TRB)
instead of increementing at the start and setting the IOC bit only if the
total available TRBs returned by dwc3_calc_trbs_left() is 1 . Since we are
increementing the dep->trb_enqueue at the last, the present working TRB is
also considered as available by dwc3_calc_trbs_left() and non zero value is
returned . So, according to the modified logic, when the total available
TRBs is equal to 1 that means the total available TRBs in the pool are 0.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v4:
	1. Corrected the commit message as suggested by "Thinh Nguyen"

 Changes in v3:
	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed the commit message
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 032ea7d..8a1622b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -911,8 +911,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -991,7 +989,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1002,6 +1000,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1

