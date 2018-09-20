Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4521525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ROfQti9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D4521525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbeITPN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:13:56 -0400
Received: from mail-eopbgr730079.outbound.protection.outlook.com ([40.107.73.79]:10560
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731240AbeITPN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbrhvimiBK+mHtVtbR8x8YC07wGTur3xcrs3SzLEZ0Q=;
 b=ROfQti9vMK81ieIGj5VsSpCNrTU1dvX8XubGy0a14x7W/qta3qKgmT0OCQiSJIpwTjrEbUfpPqG2kBQfKg/G9xnTrw9eqkt5Pn8P8NnuUUTuCFtFINFvybPUt37zprcMsTgmxpZADmKKrbDOMmQzsbPk/FVbuCMsDbZepX2wwhU=
Received: from CY4PR02CA0042.namprd02.prod.outlook.com (2603:10b6:903:117::28)
 by BYAPR02MB4471.namprd02.prod.outlook.com (2603:10b6:a03:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Thu, 20 Sep
 2018 09:31:19 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CY4PR02CA0042.outlook.office365.com
 (2603:10b6:903:117::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 09:31:19 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Thu, 20 Sep 2018 09:31:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58966 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIr-0002Zq-UF; Thu, 20 Sep 2018 02:31:17 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIm-0007oX-QR; Thu, 20 Sep 2018 02:31:12 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2vIc-0007fH-0L; Thu, 20 Sep 2018 02:31:02 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 34B1112167E; Thu, 20 Sep 2018 15:01:01 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <leoyang.li@nxp.com>, <jollys@xilinx.com>, <rajanv@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v2 2/4] firmware: xilinx: Add macros and API for SD tap delays
Date:   Thu, 20 Sep 2018 15:00:43 +0530
Message-ID: <1537435845-6682-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39850400004)(346002)(396003)(136003)(2980300002)(438002)(3190300001)(189003)(199004)(42186006)(6636002)(14444005)(126002)(426003)(2616005)(81166006)(90966002)(16586007)(72206003)(47776003)(316002)(63266004)(8676002)(44832011)(2201001)(110136005)(446003)(54906003)(11346002)(305945005)(52956003)(476003)(81156014)(4326008)(336012)(478600001)(6266002)(103686004)(217873002)(7416002)(26005)(8936002)(356003)(50226002)(5660300001)(186003)(36386004)(36756003)(50466002)(48376002)(51416003)(6666003)(106466001)(76176011)(486006)(106002)(2906002)(6346003)(107986001)(921003)(2101003)(83996005)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4471;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT015;1:MgzAiCTvwaAF/JbeCZkRl6p9aahBPPBwDZdzB/P0HgCb643K7Yvg+XsdmBXKVqE0tHRjbIQ7EvvNA8T5mrY3iAw9MgZLFredPHZpDQjAzRszHHl503sqyfL4JeITMoxa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b423c54f-fa73-4228-f579-08d61edbd1e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4471;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;3:DG/sl4FO4FI55eGf+4kaxpQksw6UCcIsWAhK95qLr9I7dnFUtav0l6r7yNGUUTpZU/0PDrpvSvpH5/DBLluc63m/8VZjP4i6yU1k57P7gHHxt9m/5yN2j4UY3Xgipl3EZsiI19tj3cptXtp6zttB/Oo4kbxRKa9QeYrtTr7+TK0hC48ShRPG1zYaNlg5WYqxjGzBIdB+efGc6EMbDo0cifQz2tC3ZawpWNM7GtVfFRS3C5wxqUwYzxlkLkshE4X86H/aUJWQO2tdOILPnymAcdBXN05wc6vYrjnMhgoYOXoNBma2rfrGzLdp+Dl2U9pL7jTtPiDuv+6sk3uMhmMbpkomNlgn0UkRzlpCx5oF2/A=;25:MkMyEoN+xHnXtk+hY14PtAXUjeR+5xxtKpDTJJ0yTTqdozt6NTukALjrjRdwKlfY38oc0bAmeI0QDzct9ZTSW/dNsG2KMOSQ398Pzb04JsmcHwBotQiVCn5Wx5bRbLFYUrnQhnPrsRfJor4CN7ha3l9vpmIH1fNAYoytdYXBuYd32RwmwXFM6bmsUhR6hWI3faK3tqZ5SC1QPPeE37eiJzxuRBCHK42NTkupc11/Xg5y/r1YrL/paFkYnklyNGFfeE/p2/BQ65Kjs+zG69SJ9EcVh4wBevpcis/NgBJ5ZGtfzicaUadRVjmn32eDwh5XAJfu9lGaK0LDaXYc8MuTrQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4471:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;31:R7hutVLWeJMjZ9WG2b9JJFfHrpWffX9ljbyReRAk3nSFtPo0Y49MbgmH5A7rGlyzVVURLmFqAWoV9+5xXTA1MFOkqveLv+VDv5kSITXATetfEMAKAwrk2IN0ckZKMfytxBdLs/TDeJnsxLt3uyP91boxVvL1ghNd8xAT3CYk2EkUybwRAioIJYAMd5AFoQTrBtSzHrF//nLJqhMyCPlPuINOG8690WfqYIo01wqJ/Yk=;20:FW25K+LbQi5bmd5/ytoswZeCqmm+iNyaG+l3sd0mkEqtYz7EnZosd6qJY9imhL8cPraaK2Ybd6i5FVHj6bX2yXsssesFywtePL23HSn2Sby3sVk+aaXm13oHohCfi7hkjtvIjl6N5Y2FH1lsvyh6BO1bMtmYuwP7bN9LQPVVokfFqPxVhF8D3MOL8Eq7zotUgTffMTU/HCUD4y5EEG3+v5yADocYVf1LujQ6EujyQIjFy1UgB0jGiwGBiEyQc0BoHcf2Gc3c74ILcZ0hD9r2WzCKmFMVkSRW2stTNEN9/fA/Xfr2gTA2f0mpQo/6a/9WxmrrckDiA9alyXJ731TU6LQ01XQUqG23fucfGHUrkJluRI5jOlIWc5W0gK/XBvjrLhSYTwAEUA7qj/glqshVICB/j2dMcNdyPG03ldkJqA+ZpBcSroGZvxHZ5CxgBi+pKe+yVXK0B4o0sz1iaeXzhbC8PdggXoYvBwubNNGpUhRwEbkB2CGG6wp1wStYZB1g
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44711AE21D4CDCF3A763C05FC1130@BYAPR02MB4471.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:BYAPR02MB4471;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4471;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;4:tX578yYlA47oEQJTN6p7V12bQ/SKxOgZm61kbGgu0FdoQ7p7LV/0/jXFhD/8BW1Xsaf/ag3948NLe+tVIGC7vTd2j3Inzb+AYmQBZwpAfJ4mmtQeeEHBTIoBqDVfm1CnMoSzolgUeU/Fgr0o74AL5yHo8cYwIYy8y+ej8GLlp3WoLIDO0pGHmo+c/ZIK4yY5VAAwxWlLgabVuEMeQCRiwV14hH/7mSW5DJe4AT4IBzR+4Y1PbTRebypHyKJvUNHM/2wXdtHYsf6aIOKUSJTz3MEZjAEK7NCLe2Fe2NvKCofLbI/IfJuxvetCPYvcIIpq
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4471;23:Je9uLz/fVMFdw/aAv3yuFy3SpfrxROaXkR+HgRwxr?=
 =?us-ascii?Q?6tcS0YZJAi0MjzJzKTOlnq4f3gz8tkspoPdg6b19E3I8VitIXB8R/j2FtzGI?=
 =?us-ascii?Q?6B0glNWumiiMPPVfYrbx1/znlXuPO7AH+g96UfJ1qd7Z9k5i5rMP6v5AqAAv?=
 =?us-ascii?Q?Kaud2Xr71r/RQF0uNo1A92r1liPrC5I6BTJGQjIdakMiB1/7GtGfv8SD69vK?=
 =?us-ascii?Q?zIKhne0FuKhDeIB1AZitea9f34S0ib1XFsreBMxs/mV2faTig7dn6M+LBw/G?=
 =?us-ascii?Q?78Uu4vRcVDbG0CUrjAIcGZQ0NluPWpCuHJdV3NR8qfOnWDAuGp+2GxleCz4o?=
 =?us-ascii?Q?mVK8WmG454THiw3cYCGg8IOW3YZbMnC+kaxytSmIcyZF1hgMox/WpnCU7tmY?=
 =?us-ascii?Q?UiObsvgSygvD6h9fuGZtH1I+kg/ibfJg6ohgQdSKTIlI/Go1GgpIaI1i+Gwb?=
 =?us-ascii?Q?ePCyt88mlMiKJAsZYOF5r11vwzNRjnT9Q4mjm4Z7ANjiAAptRw7IFLTDSS0p?=
 =?us-ascii?Q?H7SLTuNUpiOGt7sc7yNcdRLYmADCrf0YW09TURmh4Mf5k+uddpp88x0Tml6M?=
 =?us-ascii?Q?7uieOvsPGHnS1qVO6GALM9xvVTMsCeo1dsRF+7JvXAe1qCBkfjehINIst+Zz?=
 =?us-ascii?Q?3hzah4ro28ydyYQTkv0J2jMLTo42A7xOrYTfZRu1VwZGlVLKLVtmK5/4/Xiu?=
 =?us-ascii?Q?geucS6B6ayCZ2gq7fSh9XH5u+ut6OdmSvXecop2rtk1dW0IJhKI9JMEtdDvn?=
 =?us-ascii?Q?b9y6HNXWccul8BDqa1gsCZpWNro6cWENWQvWFyiLDUMRoMapnENBXnk8GvR6?=
 =?us-ascii?Q?0wbloJHMhZZrzNND5/bMyuozSTOKt/MBvrekbta/QEJNPPjaXPgIoAKkL334?=
 =?us-ascii?Q?f2cjm+msmDOv7kndglBC+tkV3W5FlkR7fKSnwqVfWRx7Q2qXJiEW2f8BTFOF?=
 =?us-ascii?Q?09omJ9IWsHufk5p933ocw/MAeQBVKBkt8cvG32t59i4g6L0AvCHxxNmJr0re?=
 =?us-ascii?Q?iijgYxFqvv4Sxs/asceqP27cruGE3sCsqIuBratopqBw58wCBg6J2qnjup9P?=
 =?us-ascii?Q?BQRRwwlFR22b8A5P+1htwPxIgLcpwFn4HkS+J/LmCI1qCIdufBwO4lyGKIp/?=
 =?us-ascii?Q?d5ULmu/GSVQ1j25bgBbPyux7sY80hvm3/Jp5LnP/rZSWPkjptbykfME62V3w?=
 =?us-ascii?Q?Yz1m22ZpSBdcyf1VtHhicmq/fbZpCfLTaiEZlHeq3/PgloeVqjYUZBMNT1Ck?=
 =?us-ascii?Q?7vkEIIfW78bxOaUA9ddZZsv/1obr4SPa7H4UKgxVDEQHCHUgeYsNKhxbw8eT?=
 =?us-ascii?Q?ECxCPny7zwiGNPKeWMpNXFsGHHgusXTJzBoudNBM5Yj2lIku/1/LtDYrRrjU?=
 =?us-ascii?Q?ZrXgVLUWB8RKKzDCLELpLxH6R4jH9WE415tOFYJGB/5VwKNZLRJVqHhxty+N?=
 =?us-ascii?Q?sl+k/znuQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZMVmTYDpDQAEoFjY0eHqYcwkBArrKbY050+mWoeP7Rrev7eSCYznJjYbfAOlxCcIoqddvJzV0KfPbg07ZoVvWu8+G1wJmj5fP+bFKPZd8+aTkDRnf5oMgiBaj+ldG/ex9hs6W4i17UQy4/DIyInDMYGA0P+y0RwnEPAE2Xx4InwIi0W/A+ZL41GrM9f/eoH+YtFJ6u0j9dKMGKXAZPTYGEpNc4CisiOGuui/ipNbFcWw84nvMZF+v+cMMxepEmt39JJgqLz5iOW69ffAFfSq6JPpK/7wFYyhaQaaEn+yg+tPs4mmFW+C22euZLAdqU2w9fnpYJ/+i5dxfRnQ5sndXBCRbkhjyOeKw8B3OtrShxM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;6:bOnq2Ev6kDUNDCUgI4i0IgnvuwenVvE5Y5z1OrtvA8YYPCh57KS7+FKPgOotU2udL+U8abRvW5dhw5UnvWEMrsyQTZ9aZJcJ7m2zF9s9FE62CG+TPxiz0dnrRGD9tYbXWH7SosDNmeT+1/gW6TGF5h0T/5cKxy1KBRU8ZhcaK4oiipkBgX6U4m94Um6HKELjRuZCzONcQInk0pSuOiCs40L0y2kemd5rzWHaxsmMkhZr+gELifgI/1L5HY/K3bbIebSCwFFC2m1XF5cfVfMXyd4Y7kLt9IIBNB1kCmpW5a5EwabhSXTY9DWULLk3DN4r7bGd5K/VR9W3ABlaJZKEyVilEcm0fzFzqkk0ocN4HTXaGsdSOHauXcnsjonYClv1V8lEq964m5fd5mpoEM7wx1rpacYOSXZZoy3vvn4IjKY/PD16+b2Cx2BziEdIzbr/ciiRVaeg8odayQi1HRdn5Q==;5:J0bYivgA9ne5yxWkS2IspV4pBG6Y8Bx5iishmmDgtAQoxisxDc/I5xw3ZnAMbpvXbqPmlYaIM5/LuLdWA8BIRbYVhg/vi2U3kdwcQmwj/73c2ciBpfGfS/f0dAp28LU54mqWaR3rIphJr5lwOzqqnehl+thi+rQWniLXFYTB2H4=;7:djt9T6TEy42uFIgbSTB/UnJXWwmtfEDNyqRhZBqe59I84+S3sInYpjsakL8heH05q8pH34SaAEYIlmSF2RK1nLRiuUcQ6pHNjPpHEfUfQqsM8wak7xY3Vgu+Nr9/u9d/rDZk9sFJJc9ElFXJJdTFJD1g3TExLdf5frceRqBwjOQBa95/7hwWeTJH82U0CQtKgJdxjRghKwmRq1XmBkgIolR0/+7rsKvie2P3Sthv/816BlAptgXcHQ63VpwCapyH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 09:31:18.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b423c54f-fa73-4228-f579-08d61edbd1e9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware SD tap delay macros and API for setting tap values.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 743687b..40feebc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -22,6 +22,27 @@
 #define ZYNQMP_TZ_VERSION_MAJOR	1
 #define ZYNQMP_TZ_VERSION_MINOR	0
 
+#define ZYNQMP_ITAPDLYSEL_SD_HSD	0x15
+#define ZYNQMP_ITAPDLYSEL_SDR25		0x15
+#define ZYNQMP_ITAPDLYSEL_SDR50		0x0
+#define ZYNQMP_ITAPDLYSEL_SDR104_B2	0x0
+#define ZYNQMP_ITAPDLYSEL_SDR104_B0	0x0
+#define ZYNQMP_ITAPDLYSEL_MMC_HSD	0x15
+#define ZYNQMP_ITAPDLYSEL_SD_DDR50	0x3D
+#define ZYNQMP_ITAPDLYSEL_MMC_DDR52	0x12
+#define ZYNQMP_ITAPDLYSEL_MMC_HS200_B2	0x0
+#define ZYNQMP_ITAPDLYSEL_MMC_HS200_B0	0x0
+#define ZYNQMP_OTAPDLYSEL_SD_HSD	0x05
+#define ZYNQMP_OTAPDLYSEL_SDR25		0x05
+#define ZYNQMP_OTAPDLYSEL_SDR50		0x03
+#define ZYNQMP_OTAPDLYSEL_SDR104_B0	0x03
+#define ZYNQMP_OTAPDLYSEL_SDR104_B2	0x02
+#define ZYNQMP_OTAPDLYSEL_MMC_HSD	0x06
+#define ZYNQMP_OTAPDLYSEL_SD_DDR50	0x04
+#define ZYNQMP_OTAPDLYSEL_MMC_DDR52	0x06
+#define ZYNQMP_OTAPDLYSEL_MMC_HS200_B0	0x03
+#define ZYNQMP_OTAPDLYSEL_MMC_HS200_B2	0x02
+
 #define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
 					ZYNQMP_TZ_VERSION_MINOR)
 
@@ -65,12 +86,18 @@ enum pm_node_id {
 
 enum pm_ioctl_id {
 	IOCTL_SD_DLL_RESET = 6,
-	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_SET_SD_TAPDELAY,
+	IOCTL_SET_PLL_FRAC_MODE,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
 };
 
+enum tap_delay_type {
+	PM_TAPDELAY_INPUT,
+	PM_TAPDELAY_OUTPUT,
+};
+
 enum dll_reset_type {
 	PM_DLL_RESET_ASSERT,
 	PM_DLL_RESET_RELEASE,
-- 
2.1.1

