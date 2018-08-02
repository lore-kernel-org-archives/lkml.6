Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9354BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59722150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IBCkxHn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59722150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbeHBOnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:43:32 -0400
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:65120
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387420AbeHBOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrQ4OtiQiqnPVb7Yy5hDKC2Z9fmO2PYE87BeoM57KsA=;
 b=IBCkxHn+n5+SrBrLtHS+oIDtSAGdJWuerHocLEaF9wCTrmHZT1LZhYQ8TxSlIJpmWC4QO2GB21jCaIguie7Xh8Evp7lKENTM4T25iTkpLE+aH3mt4MrKR4kBj1RlsBwVuQO13yzQds00VpsThEVP5VOYFe/Ex4TQOwKV+VD57q8=
Received: from SN6PR02CA0021.namprd02.prod.outlook.com (2603:10b6:805:a2::34)
 by DM6PR02MB4457.namprd02.prod.outlook.com (2603:10b6:5:29::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 2 Aug
 2018 12:52:15 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by SN6PR02CA0021.outlook.office365.com
 (2603:10b6:805:a2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 2 Aug 2018 12:52:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:52:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5R-00022o-2y; Thu, 02 Aug 2018 05:52:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5L-0002XR-VH; Thu, 02 Aug 2018 05:52:08 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CpvMn011592;
        Thu, 2 Aug 2018 05:51:57 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flD5A-0002W1-Q4; Thu, 02 Aug 2018 05:51:57 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0A3EB121417; Thu,  2 Aug 2018 18:21:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Thu, 2 Aug 2018 18:21:21 +0530
Message-ID: <1533214282-9977-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
References: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(51416003)(44832011)(103686004)(63266004)(107886003)(486006)(186003)(36386004)(76176011)(50226002)(72206003)(110136005)(16586007)(6266002)(126002)(26005)(316002)(52956003)(217873002)(106466001)(42186006)(36756003)(54906003)(2201001)(478600001)(2616005)(476003)(47776003)(90966002)(14444005)(5024004)(7416002)(48376002)(11346002)(305945005)(426003)(336012)(50466002)(5660300001)(4326008)(446003)(356003)(106002)(53946003)(6666003)(2906002)(8936002)(81156014)(81166006)(8676002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT056;1:KkWujIlywc6+LO681EvDucGP/lVeDpFVIX4RCl3mPmEaQqNUQ4zuJVtwy7srPfbGGIl3YS0sBmECP9YdPIiDnPDVG6X2cUZbmVczhf8Puevlg+g1YymQtRs8m1t3kY5Y
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dabc7fb-0ae4-4f6e-118b-08d5f876c5d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:4TngFqGo6LEi7ehL28z6Feu1VKSQLlQpbnMzjf+7TBXzAJyQxgckVdu8RXjEQkRaIaUJ94vJDnFODH/qHqazw++NPxVl1yGL9TWb5VUHysh4SQY7/Tei8QD9aSnwPaDCP1Q/EqC+xK74Y3/M8o86X4epITomUQKrv8SL2sydMUB8VMBZSOj60kecJBUjgk28X2JvFEV7brx8R7Tuh7sl7KcQFJtOvJ2KeYnObyU7p9dmvG9agXcviUmwpjfDiUfns0ILWiuHQtYpwUvw16o5iJ9jbsxx2ye3/wilQALgker90lF63JYqDmXsTuBhDiJrym+rSQmtz5PvveohQmmbRdBA41Q907mV7IGxmN55pJc=;25:BPWpjYN8xKxi7SFo22U6osNByytBJuyX+r0ZNBXx7pQOjcLFsBy+Py0QogNvi4kXmDdON+gj4FAZmo3wIUekTsCruRvQUldoW7lMxvToJs12GY9ciY27VAGcX7Ve81x7xcRk3uInEAG543i672XSyrTMOqG0ejAZD2Qri20rg+IicOYMzjXdIkdS3/7ObEJtOWiRkgdui2Dgp3aHYKycK15ocPEF6IJivYGVZRvgBrijDfjqSm9puKc4ansqG1skcW8nuiTLQYcPhO+Co0CmKizlYikLf8459X+N7eEz0wttogtiK5bSfz1I6PcV4+6zECaS0ep8rnPOElWd/P54zQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:tiRv0mV199FAsIAGY7A2/PP6Kdo5k9eLg+vINsEVovYrG446EZc7SN1+raGJ8z9UPcne63LBCuEOvlvJlU7fAXFKaon8P1CyRQe47qspGDzcFEtSK7GKSwfydLVVlHqroE3nNaMLYON55dl4T4HfA0Hlsm4QfvpfynKN8pPm3yczJ8862Zi3he8VdEZtUggpmn1Z9zwGA9/wWGDNmV/8oSVrIqCpwAFqoXI/1+hiNw4=;20:/KfdfPQjh4OWgv0hc+5kFBoFC0pih6RGLu67XApb967C1NkMqQ2nFK+FgF5GnQFPemcX1FO8QxAeewMBCnALiOTjcCh/vhmVhRF47jUiwiWSdb5wY+Gg+bG1dKGc5Niwu07T+/83H+SsvbG4Z8JlAgFxODSIaHRDFfQPRxW2HrzainVWy6RTiBcKkvrdbVjQd/zjBnNmWogNmSHB2IEOTJHUTlh7NXzoNn5nnsi6gADbqw23eKgJ0iKeTOiEkPcNQCo6jjvr/IKy/gh1r5wlAtWTEZFL0o0crEDLb92nyIpyMtVn+Y8de25Khv6GOWapnwPXbLsIqBQyE5QwDgn2P4XMIC/ez5k05U8QOtfjpMh1jCWAHk6CUxHCn6PwccB0OX9BTj7Y7WWfMeYgmTEnfms66KB35Yf7iKp6rky8dFj4QqjIYHs/ESTRQ2Pgmd/q+h9iJbZMoVSw0WkkhJMI7CkAQqSPYUXJGGUs6WH8ipdE/uCQJMc5l9pTzxxl7XXV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457E538776701375CCBA911C12C0@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4457;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:audevSoF9/tdQ1hpSJtXOEw3wHUUMV1pFiWwAgADt0SAwqHxe0u+qnYH1AYTb7xy4fQTFclzqjHeFBz3CRoVum+M2nbl3SR18+B4n8B3HNr7ub46lPG6eJ8+KRraJky4PdZ78yRaarSekRP+ksduZuoCaMlstxB0Oru7Y25gJhYzxR7T1/v4z9yQvQP/hV1IocX5Sjy5b2h+6S/qd+7M98z5aPwj4IOyN/KS4QYrco66teI6nqhKP8pCkx3D1mfxR2uiN41lXambGbJC2mJmubU458OAfGHn8cYLua8UlLqJ/WqFbkRg8lxG0noa3XNr
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4457;23:BFvT7FlkKURkOC9K5aO0Ily6VuNbLticn0eAxNjAW?=
 =?us-ascii?Q?S+yQXx1mA3UfSY77kHMcpl+i0IJFWhGPAxhepn1HiT7g3ivgDia1uJdu2lDQ?=
 =?us-ascii?Q?JTABv7vSeTEtX5zdBdhU3b5p1x9LtJ4ngeP2QUj7vS+I0OtzZ8UC1XpO3XGS?=
 =?us-ascii?Q?zflhVRDMdiaWDMEZx85+maDnRkRN8Vhty90kvInDjAtcPoSzsudVFxfc9LRH?=
 =?us-ascii?Q?eg177RIXMJ43vHVLsgOE2OjEDibMZI3o1uHuGqdwG21TnmmP6+ZtYclP37J7?=
 =?us-ascii?Q?O+bR0YusUB+41fJnV0trje4eliDoBZxZr4IfygSUunqSNLRmsSL2sS3KYIWp?=
 =?us-ascii?Q?q/R4/qMdIztARstmV2sM2P9eI08wmGcdq6RUbpfDkiFVigqqOjTIvBMn308c?=
 =?us-ascii?Q?w+OH8vMbT0g7VM4LmNgolSMnjE24D/zs/GV3FIad+rG74X59Bj5IE9wJxliU?=
 =?us-ascii?Q?MnC+GtrHrkqYdIga4EmP5X8CnQ20iL8BVTPcne+TCdixqOm17FXLLbZZAvah?=
 =?us-ascii?Q?cxIS9zX5u9Xtygm2h/ZWeNB+ttKJvwvtJMC53dr69iS7vOQXAoTIPJrOb7Si?=
 =?us-ascii?Q?xU2IuYfUjnrG8u7IOlXlAIBWSFnLzFQ7FHqLE+alg8dwfS7KNYgyz6EECOJD?=
 =?us-ascii?Q?z5LA/GKqx2Y9WVTNxIBK8waFiSxKK3KSQysasCoY+v2LIRHdUzPqmCry0/Lk?=
 =?us-ascii?Q?EVRYu8H8okEWuTDiWNjLGXiAFu+7Pu4RMHPD9WOS+tqAa7a4uxzicWKWjK5v?=
 =?us-ascii?Q?KigAACVkZpKVT/KItKdNTVnjRUHYNbfPi/Zncvn6Jz3O2ml0gUBuMSMGcP1O?=
 =?us-ascii?Q?/xxeuXbNQy3TanS0jnDaq0VybCXmQR+zDeLhbvcd7Ok2DcvqgwY01lDXs1XD?=
 =?us-ascii?Q?IlPxwh1ppDpGgS2EgRC+ELgrpqstaw73RT0SmzplnLObsezd+ZLMbN6YU8eK?=
 =?us-ascii?Q?emnM8LwMNaqpsQRIBe8LRADg6eRPi6xqMi75aJN3PhpOlZzrXA7b8KvdJz//?=
 =?us-ascii?Q?293xfcYXcHDU3zHFlsQm2HtNlXwLV6LDLX8ylgmgO8UWSAm02gtZSt988MZ8?=
 =?us-ascii?Q?22Ka+HXeJCVe9E2k4qf0MO1mJUvx7RAL1/S7BzixR/2DQL13AulxJRVMC6gz?=
 =?us-ascii?Q?EKOUIgAFu8Dm3IsqKWcdsT3LAAKKChXp1F1OHCf9Po6CV3LohjppVV1Dp2xY?=
 =?us-ascii?Q?y/KuHElKJCHXWsiYtmv3oUkicyqXcJcKQtQo6PhfioCRJ3VpqTMg41B5pfbB?=
 =?us-ascii?Q?8/851lpbitydY1SPQX4iFxAqxiy/LBe/YpxazS+l6H4KhTKBTl31czmG/Ia7?=
 =?us-ascii?Q?nqdJUXIXDkNLjSTV1CTJMdy9onf2DQbhVXOuUtndKLUVTRhgbH9uYlh8oEz+?=
 =?us-ascii?Q?8Tr9g=3D=3D?=
X-Microsoft-Antispam-Message-Info: rhy/tdnxn1LS/JjNlR3lUemjmplKU1gjdDPoVTGlsUX0JYKQloLXpGdYYfJh8IxuxdPaVQc0PKW2fHNDUJXoqDKPTZXN3FVDCpcsSe1usqCtxqojfc3gw5+n/mHkG0MokLz3zFcOshwmBPLgMfwkMC+LmBXyEovjEPLy/7kiixYvxEZA7oCu2GNh7sdP2ETZ6/uUcg/8S4Ja1EocMQNUpf3vY4zt+4lbmixi7OQFP7+LMGlqFqOCW/7LP8kMsRsq9SS+JFVfYGlWVgbATL+5au9JDbR2eWYI8ffChT5xk8DbCl45E/fbT7Ps9+FyL+4uwH9Tl51Fm1J3/56IUlkMxn6JKuxi4V5QHaAOrkrJu60=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:CnjG6QTbkW2QHDIquL3kMzrurWa2nFO7Y0uxeF5VYkOeZILzE4LCO4yJw5cq18d2byD34vUzOsb8deggiZVv8NJ5M3qPCjhrTM3u95kGYrwnmkhn6S9jy8WMmZCDHt6lJxAR/X0RqaZdBJXNqEyJSrRBXoTKFtQzbtExZf62gKK+aWdJbHUBX7LJtTPjtQ+0uo9/VR9CHHCy5WLwCxudXmkNl0cOcIrVzE1jvvlzAgqfeBmr4myc90O3G/6jTkoK5K11LoZWGMtmypRT/61BGWUnRSAM4wlsJEUQjYcXrBnpmEBAF889BP+f5ein6PLkE74lh60NKOiLJX+1wABFOehyw75JgP+4vwi3djvUGt9lLEBwv/YuisbyjwFMexrL9juuzugcTy6eUoFxN9Rz0l8+yA4ucC6lPRG+I0X/dLhnmadJEz5ARbPrh8eCQTZGgVnxgDgEKZLx5aFYdDvEiA==;5:1odZ4YllX+uilbbeHppFyZ5GEmKtBbBgE0mlHAFWZxFY4hMH62ke+dIQLoidlwzucpvrwZLl7q9lzVJ2fFipXbfCtpUxUSC5dQnom+aoK5lip0St+tYlcOePme8mxHNUXY7kl2dZh9mUlbzJ+Xs6Pbe/EkPcxEF/OfwPHD37hmc=;7:X2jaoM0pIVsCbQB0MDtzNcR52X+7eg5QIDriHXryc5wtHs4VhD2ROL4m2Vg3Rd6dNdC9M4OKEDMLRoBzCKn1L8T8unY8cDTlxHVJ9aN2fqLGpwSBdUtHWo72VwD7sXdE3PYOOGlVLxfr1wJUiMZ0ToiJFoSvmaFKh6eH3l7jS2Qv7uwUaqv7Wq0WZxvCa3fArj2redxgllLXtuNdi71dgrHkRCRyvUfYv2AfdBuaU3v+bpvpAHuIAjpNOcvUeplA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:52:13.8325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dabc7fb-0ae4-4f6e-118b-08d5f876c5d6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds EDAC ECC support for ZynqMP DDRC IP. The patch also adds
support for ECC Error Injection in ZynqMP. The corrected and uncorrected
error interrupts support is added in this patch. The Row, Column, Bank,
Bank Group and Rank bits positions are determined via Address Map
registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 857 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 841 insertions(+), 18 deletions(-)

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
index d4798e8..8a1c327 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 
 #include "edac_module.h"
@@ -96,6 +97,170 @@
 #define SCRUB_MODE_MASK		0x7
 #define SCRUB_MODE_SECDED	0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT	BIT(0)
+
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT	BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST	0x70
+#define ECC_CFG1_OFST	0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST	0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST	0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST	0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST	0x84
+#define ECC_CEADDR1_OFST	0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST	0x8C
+#define ECC_CSYND1_OFST	0x90
+#define ECC_CSYND2_OFST	0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST	0x98
+#define ECC_BITMASK1_OFST	0x9C
+#define ECC_BITMASK2_OFST	0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST	0xA4
+#define ECC_UEADDR1_OFST	0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST	0xAC
+#define ECC_UESYND1_OFST	0xB0
+#define ECC_UESYND2_OFST	0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST	0xB8
+#define ECC_POISON1_OFST	0xBC
+
+#define ECC_ADDRMAP0_OFFSET	0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK	0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT	12
+#define ECC_CTRL_CLR_CE_ERRCNT	BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT	BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16		2
+#define DDRCTL_EWDTH_32		1
+#define DDRCTL_EWDTH_64		0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK	0xF0000
+#define ECC_STAT_UECNT_SHIFT	16
+#define ECC_STAT_CECNT_MASK	0xF00
+#define ECC_STAT_CECNT_SHIFT	8
+#define ECC_STAT_BITNUM_MASK	0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST	0x20200
+#define DDR_QOSUE_MASK		0x4
+#define	DDR_QOSCE_MASK		0x2
+#define	ECC_CE_UE_INTR_MASK	0x6
+#define DDR_QOS_IRQ_EN_OFST     0x20208
+#define DDR_QOS_IRQ_DB_OFST	0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK	0x3FFFF
+#define ECC_CEADDR0_RNK_MASK	BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK	0x3000000
+#define ECC_CEADDR1_BNKNR_MASK	0x70000
+#define ECC_CEADDR1_BLKNR_MASK	0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT	16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT 24
+#define ECC_POISON1_BANKGRP_SHIFT 28
+#define ECC_POISON1_BANKNR_SHIFT 24
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3		0x1
+#define MEM_TYPE_LPDDR3		0x8
+#define MEM_TYPE_DDR2		0x4
+#define MEM_TYPE_DDR4		0x10
+#define MEM_TYPE_LPDDR4		0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL 0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK 0x3
+#define ECC_UEPOISON_MASK 0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_DEV_CONFIG_MASK 0xC0000000
+#define DDRC_MSTR_DEV_CONFIG_SHIFT	30
+#define DDRC_MSTR_DEV_CONFIG_X4_MASK	0x0
+#define DDRC_MSTR_DEV_CONFIG_X8_MASK	0x1
+#define DDRC_MSTR_DEV_CONFIG_X16_MASK	0x2
+#define DDRC_MSTR_DEV_CONFIG_X32_MASK	0x3
+
+#define DDR_MAX_ROW_SHIFT	18
+#define DDR_MAX_COL_SHIFT	14
+#define DDR_MAX_BANK_SHIFT	3
+#define DDR_MAX_BANKGRP_SHIFT	2
+
+#define ROW_MAX_VAL_MASK	0xF
+#define COL_MAX_VAL_MASK	0xF
+#define BANK_MAX_VAL_MASK	0x1F
+#define BANKGRP_MAX_VAL_MASK	0x1F
+#define RANK_MAX_VAL_MASK	0x1F
+
+#define ROW_B0_BASE		6
+#define ROW_B1_BASE		7
+#define ROW_B2_BASE		8
+#define ROW_B3_BASE		9
+#define ROW_B4_BASE		10
+#define ROW_B5_BASE		11
+#define ROW_B6_BASE		12
+#define ROW_B7_BASE		13
+#define ROW_B8_BASE		14
+#define ROW_B9_BASE		15
+#define ROW_B10_BASE		16
+#define ROW_B11_BASE		17
+#define ROW_B12_BASE		18
+#define ROW_B13_BASE		19
+#define ROW_B14_BASE		20
+#define ROW_B15_BASE		21
+#define ROW_B16_BASE		22
+#define ROW_B17_BASE		23
+
+#define COL_B2_BASE		2
+#define COL_B3_BASE		3
+#define COL_B4_BASE		4
+#define COL_B5_BASE		5
+#define COL_B6_BASE		6
+#define COL_B7_BASE		7
+#define COL_B8_BASE		8
+#define COL_B9_BASE		9
+#define COL_B10_BASE		10
+#define COL_B11_BASE		11
+#define COL_B12_BASE		12
+#define COL_B13_BASE		13
+
+#define BANK_B0_BASE		2
+#define BANK_B1_BASE		3
+#define BANK_B2_BASE		4
+
+#define BANKGRP_B0_BASE		2
+#define BANKGRP_B1_BASE		3
+
+#define RANK_B0_BASE		6
+
 /**
  * struct ecc_error_info - ECC error log information
  * @row:	Row number
@@ -103,6 +268,8 @@
  * @bank:	Bank number
  * @bitpos:	Bit position
  * @data:	Data causing the error
+ * @bankgrpnr:	Bank group number
+ * @blknr:	Block number
  */
 struct ecc_error_info {
 	u32 row;
@@ -110,6 +277,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -128,12 +297,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @p_data:	Pointer to platform data
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * @baseaddr:		Base address of the DDR controller
+ * @message:		Buffer for framing the event specific info
+ * @stat:		ECC status information
+ * @p_data:		Pointer to platform data
+ * @ce_cnt:		Correctable Error count
+ * @ue_cnt:		Uncorrectable Error count
+ * @poison_addr:	Data poison address
+ * @row_shift:		Value of row shifts
+ * @col_shift:		Value of col shifts
+ * @bank_shift:		Value of bank shifts
+ * @bankgrp_shift:	Value of bank group shifts
+ * @rank_shift:		Value of rank shifts
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,6 +317,12 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
 };
 
 /**
@@ -168,7 +349,7 @@ struct synps_platform_data {
  *
  * Determines there is any ecc error or not
  *
- * Return: one if there is no error otherwise returns zero
+ * Return: 1 if there is no error otherwise returns 0
  */
 static int synps_edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
@@ -216,6 +397,65 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
+ * synps_enh_edac_geterror_info - Get the current ecc error info
+ * @base:	Pointer to the base address of the ddr memory controller
+ * @p:		Pointer to the synopsys ecc status structure
+ *
+ * Determines there is any ecc error or not
+ *
+ * Return: one if there is no error otherwise returns zero
+ */
+static int synps_enh_edac_geterror_info(void __iomem *base,
+					struct synps_ecc_status *p)
+{
+	u32 regval, clearval = 0;
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
+	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+		 p->ceinfo.data);
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
  * synps_edac_handle_error - Handle controller error types CE and UE
  * @mci:	Pointer to the edac memory controller instance
  * @p:		Pointer to the synopsys ecc status structure
@@ -230,9 +470,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "CE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "CE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -240,9 +488,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -252,6 +508,41 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
+ * synps_edac_intr_handler - synps edac isr
+ * @irq:        irq number
+ * @dev_id:     device id poniter
+ *
+ * This is the Isr routine called by edac core interrupt thread.
+ * Used to check and post ECC errors.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise
+ */
+static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv = mci->pvt_info;
+	int status, regval;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST) &
+			(DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
+				&priv->stat);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	synps_edac_handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count ce %d ue %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * synps_edac_check - Check controller for ECC errors
  * @mci:	Pointer to the edac memory controller instance
  *
@@ -307,6 +598,40 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_dtype - Return the controller memory width
+ * @base:	Pointer to the ddr memory controller base address
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type synps_enh_edac_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >>
+		ECC_CTRL_BUSWIDTH_SHIFT;
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
  * synps_edac_get_eccstate - Return the controller ecc enable/disable status
  * @base:	Pointer to the ddr memory controller base address
  *
@@ -332,6 +657,32 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_eccstate - Return the controller ecc enable/disable status
+ * @base:	Pointer to the ddr memory controller base address
+ *
+ * Get the ECC enable/disable status for the controller
+ *
+ * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ */
+static bool synps_enh_edac_get_eccstate(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+	bool state = false;
+
+	dt = synps_enh_edac_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return state;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		state = true;
+
+	return state;
+}
+
+/**
  * synps_edac_get_memsize - reads the size of the attached memory device
  *
  * Return: the memory size in bytes
@@ -370,6 +721,35 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_mtype - Returns controller memory type
+ * @base:	pointer to the synopsys ecc status structure
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type synps_enh_edac_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	mt = MEM_UNKNOWN;
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
  * synps_edac_init_csrows - Initialize the cs row data
  * @mci:	Pointer to the edac memory controller instance
  *
@@ -437,8 +817,13 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = synps_edac_check;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	status = synps_edac_init_csrows(mci);
@@ -454,13 +839,409 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks				= 0,
 };
 
+static const struct synps_platform_data zynqmp_enh_edac_def = {
+	.synps_edac_geterror_info	= synps_enh_edac_geterror_info,
+	.synps_edac_get_mtype		= synps_enh_edac_get_mtype,
+	.synps_edac_get_dtype		= synps_enh_edac_get_dtype,
+	.synps_edac_get_eccstate	= synps_enh_edac_get_eccstate,
+	.quirks				= (DDR_ECC_INTR_SUPPORT |
+					   DDR_ECC_DATA_POISON_SUPPORT),
+};
+
 static const struct of_device_id synps_edac_match[] = {
 	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a",
+				.data = (void *)&zynqmp_enh_edac_def},
 	{ /* end of table */ }
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * ddr_poison_setup -	update poison registers
+ * @priv:		Pointer to synps_edac_priv struct
+ *
+ * Update poison registers as per ddr mapping
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) | col;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+	regval = (bankgrp << ECC_POISON1_BANKGRP_SHIFT) |
+			 (bank << ECC_POISON1_BANKNR_SHIFT) | row;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+/**
+ * inject_data_error_show - Get Poison0 & 1 register contents
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ *
+ * Get the Poison0 and Poison1 register contents
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_error_show(struct device *dev,
+					      struct device_attribute *mattr,
+					      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+/**
+ * inject_data_error_store - Configure Poison0 Poison1 registers
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Configures the Poison0 and Poison1 register contents as per user given
+ * address
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_error_store(struct device *dev,
+					       struct device_attribute *mattr,
+					       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+/**
+ * inject_data_poison_show - Shows type of Data poison
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ *
+ * Shows the type of Error injection enabled, either UE or CE
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_poison_show(struct device *dev,
+					      struct device_attribute *mattr,
+					      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+/**
+ * inject_data_poison_store - Enbles Data poison CE/UE
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Enables the CE or UE Data poison
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_poison_store(struct device *dev,
+					       struct device_attribute *mattr,
+					       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+/**
+ * synps_edac_create_sysfs_attributes - Create sysfs entries
+ * @mci:	Pointer to the edac memory controller instance
+ *
+ * Create sysfs attributes for injecting ECC errors using data poison.
+ *
+ * Return: 0 if sysfs creation was successful, else return negative error code.
+ */
+static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+/**
+ * synps_edac_remove_sysfs_attributes - Removes sysfs entries
+ * @mci:	Pointer to the edac memory controller instance
+ *
+ * Removes sysfs attributes.
+ *
+ * Return: none.
+ */
+static void synps_edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers
+ * @priv:		Pointer to synps_edac_priv struct
+ *
+ * Set Address Map by querying ADDRMAP registers
+ * Return: none.
+ */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12], addrmap_row_b2_10;
+	int index;
+	u32 width, memtype;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -475,7 +1256,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
+	int rc, irq, status;
 	struct resource *res;
 	void __iomem *baseaddr;
 	const struct of_device_id *match;
@@ -524,6 +1305,27 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"No irq %d in DT\n", irq);
+			return -ENODEV;
+		}
+
+		status = devm_request_irq(&pdev->dev, irq,
+			synps_edac_intr_handler,
+			0, dev_name(&pdev->dev), mci);
+		if (status < 0) {
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
@@ -531,11 +1333,24 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (synps_edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 	return rc;
 
 free_edac_mc:
@@ -553,8 +1368,16 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
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
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		synps_edac_remove_sysfs_attributes(mci);
 	edac_mc_free(mci);
 
 	return 0;
-- 
2.1.1

