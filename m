Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3FEC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50847206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="F4olRp1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50847206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeILCgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:36:41 -0400
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:31598
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbeILCgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xvIp/Jeg721Icx+a0+eTvA6fZ+J5HSKBu0nfw7NJPI=;
 b=F4olRp1fTvH77+dCoaDh13C0ZLaeMs2I5rWCQxadBZbgEn+A/2yfA4Z35PIyMR3Dl6FAz6aM9ytBRNVjF4vCSBnee07+sHfr+gAVG0VjvZir+3Px71TzhHMJPxLweaXSZb/mRUhzEmCBxw9ltlcouYW5KBCuqSmO5ewuEgwh5b0=
Received: from BL0PR02CA0096.namprd02.prod.outlook.com (2603:10b6:208:51::37)
 by BN7PR02MB5107.namprd02.prod.outlook.com (2603:10b6:408:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Tue, 11 Sep
 2018 21:35:20 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BL0PR02CA0096.outlook.office365.com
 (2603:10b6:208:51::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Tue, 11 Sep 2018 21:35:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Tue, 11 Sep 2018 21:35:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47466 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJa-0006av-Ko; Tue, 11 Sep 2018 14:35:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJV-00052s-Fh; Tue, 11 Sep 2018 14:35:13 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8BLZ9xB003957;
        Tue, 11 Sep 2018 14:35:09 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fzqJQ-00050U-Rr; Tue, 11 Sep 2018 14:35:08 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Date:   Tue, 11 Sep 2018 14:34:57 -0700
Message-ID: <1536701697-23949-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536701697-23949-1-git-send-email-jollys@xilinx.com>
References: <1536701697-23949-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(8676002)(6666003)(81156014)(5660300001)(36756003)(7696005)(51416003)(81166006)(76176011)(54906003)(316002)(2906002)(16586007)(106002)(63266004)(44832011)(106466001)(126002)(356003)(77096007)(186003)(486006)(476003)(48376002)(7416002)(575784001)(110136005)(478600001)(14444005)(9786002)(305945005)(47776003)(107886003)(2201001)(50466002)(26005)(72206003)(8936002)(4326008)(446003)(11346002)(336012)(426003)(2616005)(50226002)(39060400002)(36386004)(107986001)(921003)(83996005)(2101003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5107;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT039;1:oU/HM8wS8siG3HxWUDqFYYQPtwcBccrQpnK1GeZ8NQ7PlH77nGbRxiAUAgqzAbh/NCWi+URc4+izdv8XHbvZHcBFTHNmIo/tRPYG8ZjII/sCKBtgsJYbc+IQ9w9FRHzi
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3f9f85-8cce-4b6c-cb86-08d6182e78ef
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;3:59EK2YflsYCotLxUyFkMX3wU3Kqkq/vu947723rUTYqWl82VUI2SxGvgJ+tHyCAGuOCJftNdG7d+SOgFrqU+c3V5IIYsw4IA1UvYQJVNtq9MzfGaJCQX+MLn0D/KzkdTMcKXoOv4p+Qt0481PCDB9MB+jQkqwJhiosQGBnYD09iKON4NdTvMVCnSQA5Q4LSy7fuQrOTzqVapswEXlPd92wCl0GKBxAV3Mog3s6oMf+4JjStC9XD2vTJ+GqyAvAYZLfMf1saGYR2n7PV5w6ygFR2bo+9qvdX+phkbgQ6gQtIZTHvd+vKFvmx4bgaz31oz22ptI+mikL4JNcRdF/Y6jPF0YawGZWZXDt/AAXN2RnU=;25:G7jZShb7C4wmdLGXLuCK5ZhdcZWMGp00wCrZhptZCecovMdkOxq2fXt3pLM94OA+1w1g70rkGkBqAw10Xn+10ZQXmYkLTeeRneyZrjdAy/54Cp5qL0NtHmeAb1WJRonNB1Sv1fcw8kb3EcpgMFspX/rDOo0zlRKJv8ZZMU+qdh5BsKJCV0jiWLvdcw9OcbSA45z7Iq9dthSJ2flbiSLgMrlkntNpXnOblRAyzb8JBxpa5OzdifuxkH1GexVdThH5OjJIxxCM79v0YRoD9udRXvxXJNEqkhWMIaTfsy5jaqZaZDtucNqmmdcPMpvLqjf0olp4x063tBzdn1ksTQKVsQ==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5107:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;31:Ax6ljv6cLF/5UeDBXR46y1OGpM38Kyh8AK1P8vodN3rMiBEIcXfS9ZdhOUkgj1bLvJgW5qf6UECUd4+Y9jmhPkKgwZymJHLolrOOI69pkQDEA42oT+ghzzIa1DBquYpArPM6DWv6e03dh4tG0dncPG3F9PbPRZeq3skPtCKle48hgEVHlFxjRMkL+lVK/mv89ELvAi1os9ldJrZy1+bJu2985vSuQ17jfJGclNRPc2Y=;20:ujen6HKHvT8o9cw4R3rTme2A8FqbAYz4pDv9aqgRUcipf91og2vsD4jnEt/zlquDLzXl8X49fJCvf0A6IGE3pnPbggkMaVFXzNtEJWyPt4g8x++2dnVpEpIbF0Ipx2nX6Q1eNq8mL3fZYSAVPziFWfx7YuiJDPknXHBLNQAOS+03RnkiZ+kmPX9LA10QdSsbw2v4Aj839oe5oJRVr+RZ19/yvXNsITVRJLuYybbHzKuBWUVCbvI1Yph9jpCbCPiXvz4zONrMUl9ovhqeSj6U8JB5l0WhH/WFTg5sjyhdnLP58MU/kqdmD+ep2Ef3Yp8pka6w2TO3vkKcTros9oLph7bG+7mrF2HSyVz/W8U0oETyePcvKNWexrDRFG+UOrAoQmPueThQuoe73vK7zbGrZC/B97LuOKzCim3AZF00vvx85F3A0dupPW4nLCEEeguJQCMQV9XgEVvPSiPZIsu5Y51IjUp8CDQjAeTyIEJ/PkCSYquMqIS9EvYZ4nL7AUJL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB51076DE14472C34221D50A92B8040@BN7PR02MB5107.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BN7PR02MB5107;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;4:lR/x+U5FKWD/abL1k17yW1DoN5JUjaq/JdCS0u9smVXV/XlcmfiT2PABzeAxXbcfuwtBJUdHckYB63fwi9JeQDsDQ3hx+JrkBgSuXO+c+CAj+VljbPG+Zwoe81OUHieJSctjF8kwHdAkvNQFfj8B2yZ/QiVM1NG2MWC76DhSLocKB8RRtkJ7Bslxo96H5nLlTlep9fVl0b2ghzyeZfX/YaolV8ghlgvo41den8f3mIUdPqzvTOKlIMIPXeoxCg8m91bm5L62NsjMBOINB5sZACFu2RBy2cxXv/j01w/+7CuCCi/PAc0vYWcLottYQUVx
X-Forefront-PRVS: 0792DBEAD0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5107;23:mo+ykDCUieJuPS23fPWNQVQvwuyEO/AhjqmfeCWxw?=
 =?us-ascii?Q?fzTMtkMNyux9eY99SWW+zxadGnZA2kGFxzMLL2JhY44qeYBMu43ZbKkAmRHg?=
 =?us-ascii?Q?7vdFICskBquDo9zbbPmbPwr5l7QbFf5FJqxBXmjfYzVQTuHce3nbJVCo+/gC?=
 =?us-ascii?Q?3TSUNZHVUPRcnWjlFy109Z4PanwUZNiezt5VFMdT27gMOBeVolXI3Ub8l6T3?=
 =?us-ascii?Q?Lrc1PY4M608JNmQCAPC6lPxkheRnCYsTTuQ/WiEOWfVEvtmAJWVsVIyhKfUb?=
 =?us-ascii?Q?nx3etPQfwaeqZYpHOK9hMi5/mIuDpKxo5YEY0C1LHdZcDpWTidVRZGg67MGl?=
 =?us-ascii?Q?43bHk3LB9r+oygigTE1mY3ygciE7Qi+ZEYLsyVuEuliTVYQsLRE8rr57zxTn?=
 =?us-ascii?Q?sdEFSXJEMisYpB/X9A2PbwqnNuqB83fXHYM20jo4MzPwgfAKY3hwX/Uorm/I?=
 =?us-ascii?Q?0OkF2x+o+sG+0J1dVcIIWKHTirQsvIzo5uStG+QMHPnHI7ykjipfigCSuCbc?=
 =?us-ascii?Q?5naeaxqE0l9yRyfoOy7BAj1WIlwj8KAQm9QhDVob/86KZJ6RcnqEPdVy3D1X?=
 =?us-ascii?Q?A6Nhz8zeRN9FISsXFSJRD8JCr99yM/qxhnQ0QBJo1ZbCF2N9D1XSOnMMAzdh?=
 =?us-ascii?Q?DmDNAvMn91whgK5acUtIUjOH6IWvMwiH34yL/md+9b7lOCprgD0hpeySf/PK?=
 =?us-ascii?Q?76aZaVrjcmV+VLg3HX6gF2U7hjUMoKQ+gGraeE88T9xwEyM+p0BrxNdgmY4R?=
 =?us-ascii?Q?5KeyitpWTrdGxuwbn2CnGcNXusNqNeeiCqLaPsI0QcYfn9DM12Wrz/36czqk?=
 =?us-ascii?Q?v4Ctm5N9paj439oRNnQ02Yg2W0pWfG3REN/AnNIr9VVwwQOpTgIEQumQPjO8?=
 =?us-ascii?Q?Vs7H2uUY3EZ/7ZYp57lQmnMbE0oXUzgJHbzJ5F7SnUurUveNLC3pFHQoMP62?=
 =?us-ascii?Q?0TGmGBRJVGQU+EFr9AyX5v1sX7Ov9YcvjJ5DR0vemMZWbjR1tAEBEGUAm/sV?=
 =?us-ascii?Q?T0q7CgWIU6EREvHDimJMyaNv3HOIS6SYOinshBX4FSMr9V6uUyyHSLikbc55?=
 =?us-ascii?Q?IXqG5J+CzIT2rFCXmOtue4Qi7uLlJjhuDgXJ0/2OUFyWmz2aQW/YhFWwN2cx?=
 =?us-ascii?Q?8jZFy5t59+NjV6H8WFtCweq3B2H3Upi0D5fH5vL67FR+8SkpGaYy+qeNiolU?=
 =?us-ascii?Q?45HWtVoWqXdka0CU4UM6hDkxoEHsfn4/EFFVACDqTtOIK/nm8qWbGOMAMBAc?=
 =?us-ascii?Q?jZ9ChPl3KbRObY36J26MteP64XfZ1Rs3cR01P7XlwtEJBHgze3yF0ZNJLtT4?=
 =?us-ascii?Q?5MMo51RbFQVC7ncOyaiNc79ODEFnEnpI+DMseYze3BqLfy6n4PtaoNFtf0IQ?=
 =?us-ascii?Q?tx47Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: tYcpe9o96qcaMIzTCTpT7bSmyaibJqvQ7oGFgiZ5kHqx6iY+/XTBmIhk7VSCzSzqKEVqSR6mElZA9MnrO/4jDB9WPxcDzUWmjBgHfMs+cDMOP6rq6OhosQPug8WTHkTETIbmWPNFTRlII1cwC89kx60g9/SC9TW8AsaW42Kov/SBnCODaPvJtP8gdHY/ElFSthmynLN4malCYMKxr/j2+FnCICswpbkfe0Rc7sXtDj2v++nuHc/3AzoQz3VaT4qY2tbIPOV3l8Xg3mROayhMsTd1NS8s7vUP9Ol9ZRTl5ttxiuP3eDdnMhrS9CZpzj8u/Na2KaD+DAi2XdqIVaKwUO/lQ0b9RtmOVVF4lsHVOPo=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;6:O/WItsGoEiBUFOtxdTpb+8IGBl1NZnkILVBDrKRGyrSA2dXc/vHerH2CS2/OeEIeY0/4At7pXJaxYaDC4iR2m4lxPl4LQ7MjPJ7+Wgfkyxw7VyGk3ymfw2X8KgOYE7WErMvp/4LmICCigIshesF/d6xz57K6k+omA7y09/jIKpvvscEBzxp6dNOmnd+YwGlSJC4R6VxDNHkyxU56+L5wwbgdKiWsFOxcIPH2WhR30iGp9m/cvA3/aKMKX5Qq/yYf0Vq9AoyMOvYC/If8OnIm6S2QtgjOj5wxXtCpw8GCG/Y76aY/lZJ2Jjyy1QFFlZtT+FzEp+4sIA4BRyGa2sldBIoKKVSJZMMXsAYwX6jG5IgXMDD/nK7NHLl8L3/OpCF2ORuh0ohNZaOImX/aJwMUwuspwYtZ89BesMcU2Kr/wDNsVY6itTDx3RceXwQbRAdbz1qyJaI5/b29u/EGfcXKJA==;5:6lZpJRRitoGHfJkZ2dPAvXI48v03xndAoM7MHMsk3dhiCrHoS83Nayt11Prpy9GfFER/Zfl12tcOVaP3VBAdCE8G8YsuFpv5Jv1fXe1EwbOxS9WO17fX6vaSQJvQqaof8aTVwtelkhE2qFFtfeuJ3h2k2sAdFbHeHxG0geRAy0s=;7:G4miGf/Ii8DaTRsz7c1YfIKviT7vZSKYH60wuc76AQVjl+NEK244YeQDQDVODY+kNO+umfmIPxO+zidiWIYtIjPt1BbIxrqLOGhlh2mLNUHGfWVko12n4CRxRKEgdLO1wQf0Zy6NqXutB1H82zxqPWVHeqh3NvbbVdyLuLLyExbrUqlb7ODM/qoUdi05UF5zSI5b6zfx5TssT+b2fvHjwBxyvIkaRIT2f3uskWmwgJwfJuYJUG3K6OHdb5cD685/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:35:19.2922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3f9f85-8cce-4b6c-cb86-08d6182e78ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig        |  11 ++
 drivers/soc/xilinx/Makefile       |   1 +
 drivers/soc/xilinx/zynqmp_power.c | 230 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..5025e0e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,15 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM && ARCH_ZYNQMP
+	default y
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers isr to handle
+	  power management callbacks from firmware.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..428b9db 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
new file mode 100644
index 0000000..9071948
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * struct zynqmp_pm_work_struct - Wrapper for struct work_struct
+ * @callback_work:	Work structure
+ * @args:		Callback arguments
+ */
+struct zynqmp_pm_work_struct {
+	struct work_struct callback_work;
+	u32 args[CB_ARG_CNT];
+};
+
+static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
+
+enum pm_suspend_mode {
+	PM_SUSPEND_MODE_FIRST = 0,
+	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
+	PM_SUSPEND_MODE_POWER_OFF,
+};
+
+#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
+
+static const char *const suspend_modes[] = {
+	[PM_SUSPEND_MODE_STD] = "standard",
+	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
+};
+
+static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB,
+	PM_NOTIFY_CB,
+};
+
+static void zynqmp_pm_get_callback_data(u32 *buf)
+{
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+}
+
+static irqreturn_t zynqmp_pm_isr(int irq, void *data)
+{
+	u32 payload[CB_PAYLOAD_SIZE];
+
+	zynqmp_pm_get_callback_data(payload);
+
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
+			goto done;
+
+		/* Copy callback arguments into work's structure */
+		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
+		       sizeof(zynqmp_pm_init_suspend_work->args));
+
+		queue_work(system_unbound_wq,
+			   &zynqmp_pm_init_suspend_work->callback_work);
+	}
+
+done:
+	return IRQ_HANDLED;
+}
+
+/**
+ * zynqmp_pm_init_suspend_work_fn() - Initialize suspend
+ * @work:	Pointer to work_struct
+ *
+ * Bottom-half of PM callback IRQ handler.
+ */
+static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
+{
+	struct zynqmp_pm_work_struct *pm_work =
+		container_of(work, struct zynqmp_pm_work_struct, callback_work);
+
+	if (pm_work->args[0] == ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {
+		orderly_poweroff(true);
+	} else if (pm_work->args[0] ==
+		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {
+		pm_suspend(PM_SUSPEND_MEM);
+	} else {
+		pr_err("%s Unsupported InitSuspendCb reason code %d.\n",
+		       __func__, pm_work->args[0]);
+	}
+}
+
+static ssize_t suspend_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int md;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md]) {
+			if (md == suspend_mode)
+				s += sprintf(s, "[%s] ", suspend_modes[md]);
+			else
+				s += sprintf(s, "%s ", suspend_modes[md]);
+		}
+
+	/* Convert last space to newline */
+	if (s != buf)
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t suspend_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int md, ret = -EINVAL;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+		return ret;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md] &&
+		    sysfs_streq(suspend_modes[md], buf)) {
+			ret = 0;
+			break;
+		}
+
+	if (!ret && md != suspend_mode) {
+		ret = eemi_ops->set_suspend_mode(md);
+		if (likely(!ret))
+			suspend_mode = md;
+	}
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_mode);
+
+/**
+ * zynqmp_pm_sysfs_init() - Initialize PM driver sysfs interface
+ * @dev:	Pointer to device structure
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+static int zynqmp_pm_sysfs_init(struct device *dev)
+{
+	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr);
+}
+
+/**
+ * zynqmp_pm_probe() - Probe existence of the PMU Firmware
+ *		       and initialize debugfs interface
+ *
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * Return: Returns 0 on success, negative error code otherwise
+ */
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret, irq;
+	u32 pm_api_version;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	eemi_ops->init_finalize();
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version < ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENXIO;
+
+	ret = devm_request_irq(&pdev->dev, irq, zynqmp_pm_isr, IRQF_SHARED,
+			       dev_name(&pdev->dev), pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq '%d' failed with %d\n",
+			irq, ret);
+		return ret;
+	}
+
+	zynqmp_pm_init_suspend_work =
+		devm_kzalloc(&pdev->dev, sizeof(struct zynqmp_pm_work_struct),
+			     GFP_KERNEL);
+	if (!zynqmp_pm_init_suspend_work)
+		return -ENOMEM;
+
+	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
+		  zynqmp_pm_init_suspend_work_fn);
+
+	ret = zynqmp_pm_sysfs_init(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct of_device_id pm_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-power", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, pm_of_match);
+
+static struct platform_driver zynqmp_pm_platform_driver = {
+	.probe = zynqmp_pm_probe,
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+module_platform_driver(zynqmp_pm_platform_driver);
-- 
2.7.4

