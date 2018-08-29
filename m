Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379D8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02342083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3cskS1Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02342083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeH2SFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:05:00 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:50176
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbeH2SE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPhk1X0p18ZzvHlCVD36SDtF6V1vXANjmlGap2qYiEE=;
 b=3cskS1UdfOMuLf/MBKX7OuHFhLHEGKBmG1mFO60NfhrR9YhZYOAH3kHyj+udbyoOZtb7VOtUKy5TRgKanBi1ilTstm+Kan+xA+DhNfOm2rvTxS69esiySUgg9P+DmI6EfjpKpsMiH4LA9Bnpz6ZvbjgtCHEOn7UsmqMnW6ObaaQ=
Received: from MWHPR0201CA0095.namprd02.prod.outlook.com
 (2603:10b6:301:75::36) by BN6PR02MB2675.namprd02.prod.outlook.com
 (2603:10b6:404:fa::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 14:07:46 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR0201CA0095.outlook.office365.com
 (2603:10b6:301:75::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.18 via Frontend
 Transport; Wed, 29 Aug 2018 14:07:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 29 Aug 2018 14:07:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53779 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fv18K-0001JL-Tw; Wed, 29 Aug 2018 07:07:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fv18F-0002hl-PO; Wed, 29 Aug 2018 07:07:39 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7TE7VIU016838;
        Wed, 29 Aug 2018 07:07:31 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fv186-0002h6-48; Wed, 29 Aug 2018 07:07:31 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 491DF60472; Wed, 29 Aug 2018 19:37:29 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <vivek.gautam@codeaurora.org>
CC:     <v.anuragkumar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 1/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
Date:   Wed, 29 Aug 2018 19:37:27 +0530
Message-ID: <1535551648-29534-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535551648-29534-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1535551648-29534-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(438002)(199004)(189003)(6266002)(305945005)(106002)(42186006)(4326008)(5660300001)(36756003)(47776003)(2906002)(90966002)(51416003)(316002)(50466002)(36386004)(107886003)(54906003)(16586007)(110136005)(478600001)(48376002)(336012)(186003)(53946003)(52956003)(103686004)(106466001)(50226002)(26005)(39060400002)(14444005)(486006)(8936002)(76176011)(8676002)(126002)(446003)(63266004)(11346002)(426003)(476003)(575784001)(356003)(2616005)(81166006)(81156014)(107986001)(5001870100001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2675;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT015;1:///mr0OTaDMBb3Oh+pAtAbi0qPb7fNjJBFtlHAysZcelnctfDi2wbpDAdlraLuH/mfZyKB4AxFPtGPrekQrhLSEIlklB9mVdp1Yql1Qgn/neICg+Z7IXt//YTY8PX59/
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcb88073-f278-430f-6c3c-08d60db8cb87
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;3:vyM3aOR4RSpNFJ+8+xIxvN6CLvyYdPq2Ru6wdh8x6eX9qBEgKRElprab03UTuOM63ivQOBy7KPalfpex8UTjr7VbrQKdXK2s/x8wlFpoIicQ5meevYdNtc8JDVBbFtJn5KJ0YK2guoByTt+UwaFi12Hk8AAGdT47xYM6YliQqFCnJyzcROhfPVl6fJzWdlHQ2sdnjmKxiGvlpkFHG9ShSX7md9RIQlTNNtnjv0D8CoZGEzyCt/K/95m+AYFfwDxpm6WAS5kIHTN+4DDLWH7Dv62O6NeY3+ey5ctX/xUjCWzkL9gEC6LHtwXBJBYJEO2s3JV/ULzFoBUGmKw+VUqHVe9dLq9/XC92pgerpCheKyA=;25:sFDUOMgmbxDiD2Idv6jt4mj0fyFFobemSkcgJCW6RBsA8/UQYvHd4EOeqyo/D9vMtSvfa5RpgRz2qsiVmY1SrcrDA3RhZb6BoolFC+IGCc9cXd+lRBzaPG47Fk7+wIuzk7mcoMyF27EJ7Gfi+1WzQkYeTOLLiGR28b6KBvx0jCvV9DLyp/2+9W4zpBcqKM1CueoZF4UvJqSHwPd4vZNOZ5UJB8MSVZimWdzNgkh4nOcSYH3AI/eVc3gIERQ9Zh02SkIrFqPVrNHyoJyXcT3cRjg9SvLh5CD1dm9vfmSJWuSy6Q4mogO1Pwck4KhN0pLLyPo7p8ZmVIBZ5EB6o9EH3g==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;31:RzxKjpSvVDPL0OAHAWEJl6Z+Rd7yj7uhVyhaciF3GaAZBNYcgqdvXFwjKivIgUpm1HblvYD1oYynolKG1qfxnD4STWsZBi4ufAnSuYTodRClTqoFLMD7KycjO+X+i15kNQytkBYx8a6QC6J/31XpXd1yXv42uYS8zjTuCtl3CSIZ1IqoLMoURpCSmZF+eMJFcpH0QtET7Ymwv6du22zzLOkvTQfkzaITCNQ2mF93O6c=;20:HeX6hgdrLdYmkk9onEC+c/k65XDXGHCpI88gfux6Q8ivddWHg3YZbbFgSanil+W1QCiFisc0G/ztXOfPCmLvoPbz02F/s1FiHSST6BBiEajSyVphfB6EBjfv53hpnrNhUfARSOhR3RkhrYYLkPW/4nsKg3KWdPr93vcC+TESAOYvfResUmFrKipyJ3F1aETIo0OY8B1wJMHWycL0ywlU9538Dl36pZgSXOdc0zSN7kRA71COw+yEcwyMS0DP/bD864oe1D0zjt1fVzOIAn1zWD0seHhhAgTSsj99XY5snGsr6TZcE7OnUcJshYiRNvfpM9SV4INqtG1ZA0HnPyXNB64l8ApDfZ4BXjqeBCA0KlFoMEIAi59i2Aq6U5Z7NVJMl5G0yM1ZasDmtoN1QJ30p+F0pU9Quuq6MEeWRq/+YE0YSoW+gKmP2jy4fE4Gwz8Xc5NoaYfGmA5Mb6CaRh2CPxisCvHFbFv3NnQTS4FoD+8hSdDs9AlnDUrP4hteoDC9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2675436BDDB8229865A026F1A7090@BN6PR02MB2675.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(163750095850)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:BN6PR02MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;4:BY6H/SxTR/gxxdMrUeE6+GKBFigc4eau4hDrCTfvKe3NT3T3kuyCYgosT6mPSo4Wj8AQ/2BP1oRBF2BKhdEpCUNl/cTLLuROUehj7fTSzhpjXICyjEk6nr1VESjjKvA6oVEtLrtolr+2yp6jtWqIXs0uvMNp5QTnXGeYi5MLvNvMTaJJ6KFYegoGJLmOppZ29qhEeBgwqUEQEvjV97Z1S1oT8dRIoPPr3B4qy48ZPPxLSMD1Ork1KINL+rlJ9IU3W+7quqXrypc919LSFFqaDpe5DoE3E1yHlD3Irw2XWQlTZ2UhjwjoIzf+ZndaFwjOnuDUUgCCahoqWxUHb3P4h8NsTFYGQe/Se1rsO/ZU3ituvvd5zuEq5VRqeePW0lK7
X-Forefront-PRVS: 077929D941
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2675;23:HNCpfdp+lDopr36YN6BCg+lM6rB3UoINV6nFFQa+T?=
 =?us-ascii?Q?+eqov9GP1SO13mazrcJvhLXZoGt6dLQ51ZpvnMK74jOxWD8PIc8+T1kAA78u?=
 =?us-ascii?Q?o+kqLF5GTmFcjgXs0Tuttq14NZsYgAzPfHupqRrJpkBzIp5AdIE93kSbcw0x?=
 =?us-ascii?Q?2/hLNPXVRe3qqiv8gK3b9EHclIcM726RDa0BA5fDoHiweK0H3tC/B+Zq/+wx?=
 =?us-ascii?Q?ut/IbYqyV2qki/v1yu3nsE5H2EOZlFZM55cUGrr2m5HkjtVWXiTq+MExZaBI?=
 =?us-ascii?Q?GMo9IrP77HQWQuoUCBKeyPxFv9vGpig+efAl2tHNMV41APSm7DSo8/fYzId9?=
 =?us-ascii?Q?11zfHGV1NY8x0YhbdCpc8j5Q2adoThZcFfCLIyizZP5FqV/Gw3G7ZNBDd5qO?=
 =?us-ascii?Q?fUVgK3jQ/khacYPF42Cb1OYoKFeNqQ+up/IswzrdFrAkUrlgD2s6fPpHTiRZ?=
 =?us-ascii?Q?0zUQ/lAv33AwWJosEhNCTUBSBkyeLosN2jUVmMI0642ywsGLuQ8ImCvn1iGd?=
 =?us-ascii?Q?QTW1G+IRDnslzl8yylRvWCbr4OzIdnRhmOKcYhTSMu+y82j1Mf05mG5lOGxu?=
 =?us-ascii?Q?eLNSSlLngTA2FBk02YRQO2foLkDI9Z0Pnk1PQzW4HoDi8A717bd06JMgI1/m?=
 =?us-ascii?Q?ds/riu3ymklR0RCYwf32aFjMmfEoT+s1QENc/y5C5dAUakPgBrg3KDIKMURZ?=
 =?us-ascii?Q?6E6bMqtIJN90NVg2jdKGx2z9gAwNwoaPRQvVx1kPtsCn935TqgGTOZSnVAqg?=
 =?us-ascii?Q?ZQwpJ9Qql+pesWgaTO6E9Z0yXuRysBHLYoW6DalFdcWp9gKqUMFbf7lVTrLL?=
 =?us-ascii?Q?SwYlrXfTnciKP7RsNfPpoMe60Xi0SZyezLuHmpNKW4IB9MOzLauB7GSQbSrV?=
 =?us-ascii?Q?tqwBFiTX569mZQCW7svnQYuGYYVWWFDgrriuvTjz6woaVVy1rAQ5lqEo8dWW?=
 =?us-ascii?Q?gYFidob/hJ/Tglj+IBVbPblWxyhTn/mtJ6ROyEn7SJITPNw/zfIUQBWO0ZTT?=
 =?us-ascii?Q?/ARGSiWAzQIMIl0YfQtnZwvctAegS0TjcCM/eKbF8XbR2b8ZW+3TSEMeHbni?=
 =?us-ascii?Q?tCf4NyBNBCdW1cxnLrCwrW52UGI0SuKsJtbhrGCMudHXNqVt5zzHAHY5LPiD?=
 =?us-ascii?Q?dxyk3E+jgEogcDfNcPAOZ9Je+tVNHjfqejrGw4vTeBkVo/Swg0uFkWwFdzLB?=
 =?us-ascii?Q?3jkI1l751ui2rCWspzMjqnRefIvxSMXRgfMGEAfOtqTpPcnOSVd/BhjmUVaj?=
 =?us-ascii?Q?SGcEmvwXtpM8eNZsGkdPeUwnAyuskzPS2Aum05n?=
X-Microsoft-Antispam-Message-Info: 3MWzqcEuLUiTW+eOgqeBDDNN9LWzX9rpEuHQQrsK0ltXrXIgozU/8a2ufyhttDFK1zLGtSpgy4r907ft55eOhOcRH6PW8sBqupqeSheSifS1xfpGUKk4Oq34sD8M873Xz5KWFsiPYvPT+Yz55kbBbQ96sZa9MegLq+j0lQ/OzLG2pYcSnxvUmCpLCWoRFWmdMMcCWIMG4BeJ1RUr+Uyy/K21pmFBiJaTkV43eCYw1bL3fHUDKhOBPA2kvBqMmPe2iTRUMAW8zjFxLDDuJqj/70/xRZ6fuRLz+wjz4pk7tawBCcPWIazby1nD6tBQBpCoRUCksP2jaKR/WZH6wCXSO0YmvgasFSeHAKxtQW/Xfz4=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;6:xdudwHxNc96mnNZGAb932iCW2YRyfad22W6hFFDm86XVqpq4FlhGnzNs6MYs22moSNaHIGUzJKH22HqjhVWkCcvuyLlt7onkeZVxRf+xcESpkwQ/H6fKCCZa9NPXK4AymJcqyyPTg2cCkw0sY0GjWbT0snG+YAYz2NG48v4A9+O/ULrMb9lK2KyTfaKPmNhh4EqyyuDDfbL2twNQA3C4O285PbYywTijf3KZzulpDpVdUZhrCCskKg7TjGfrG9oAmj4kpifU7aG/RwpEl7qY4gnVIfZqGXN5gbDQOQj5mAtM/GMw3hiw0WI8eMkohdBN/+n+nagzW6RPvvkB0q6Hipaq1XT9PlP2/X5vA/XtwRa0SIATqEkVKBykKGttfyHJwPcZeSH3wNcYIoN49n/S1H8eN+0tpGWbIrNH6W7WWf3NOJx49ElzOPdaJpd6Jgusr6peOPJgM5/pex96dFMsfw==;5:Fkl6ggitYVeIZd3YmSrvKqoUY2dsCzjurSoLa/KAdmsO03cTZQ/TWqOW6XMi+YjqXbZyXdJ6qIEMy1MtNUWYnoi4iPRaYbniQnZYNYe+VGry/UfvfXAHzuGlWCJZrZ3GVZTy9VUgLcu2nkDTCElbzZC2YdLWOVWTqDFzVuK/e8s=;7:rIFWUIozSzFFvM8ag17p/b7Q+qO5yGMx2++GYM4bGvaTtffaTGxF/s1VJLnth23PbqGXqkBQTIsGK9TAkrY2s4oHcTAqeVRRUJ5ysb1AyQLwikrxwARUlIuFsL0F6rLhDRo68fc2eW4iDcSJ3IqZfxog2bnDk+bwsNKCEIPFVFd4OKUzcQTVkhphXCcUGqfYDGhVlKatJ7ULPWbM80xmmYOzKmb7mnaSYDQjjhXg7+kgoSsgKhYIfz5h+Y7n49/4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 14:07:45.5390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb88073-f278-430f-6c3c-08d60db8cb87
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP SoC has a Gigabit Transceiver with four lanes. All the high speed
peripherals such as USB, SATA, PCIE, Display Port and Ethernet SGMII can
rely on any of the four GT lanes for PHY layer. This patch adds driver
for that ZynqMP GT core.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/phy/Kconfig            |    8 +
 drivers/phy/Makefile           |    1 +
 drivers/phy/phy-zynqmp.c       | 1579 ++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/phy/phy.h  |    2 +
 include/linux/phy/phy-zynqmp.h |   52 ++
 5 files changed, 1642 insertions(+)
 create mode 100644 drivers/phy/phy-zynqmp.c
 create mode 100644 include/linux/phy/phy-zynqmp.h

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..14cf3330 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -40,6 +40,14 @@ config PHY_XGENE
 	help
 	  This option enables support for APM X-Gene SoC multi-purpose PHY.
 
+config PHY_XILINX_ZYNQMP
+	tristate "Xilinx ZynqMP PHY driver"
+	depends on ARCH_ZYNQMP
+	select GENERIC_PHY
+	help
+	  Enable this to support ZynqMP High Speed Gigabit Transceiver
+	  that is part of ZynqMP SoC.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..f2a8d27 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
+obj-$(CONFIG_PHY_XILINX_ZYNQMP)		+= phy-zynqmp.o
 obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
 obj-$(CONFIG_ARCH_MESON)		+= amlogic/
 obj-$(CONFIG_LANTIQ)			+= lantiq/
diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
new file mode 100644
index 0000000..306cedd
--- /dev/null
+++ b/drivers/phy/phy-zynqmp.c
@@ -0,0 +1,1579 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-zynqmp.c - PHY driver for Xilinx ZynqMP GT.
+ *
+ * Copyright (C) 2018 Xilinx Inc.
+ *
+ * Author: Anurag Kumar Vulisha <anuragku@xilinx.com>
+ *
+ * This driver is tested for USB, SATA and Display Port currently.
+ * Other controllers PCIe and SGMII should also work but that is
+ * experimental as of now.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-zynqmp.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <dt-bindings/phy/phy.h>
+#include <linux/reset.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+/* Inter Connect Matrix parameters */
+#define ICM_CFG0			0x10010
+#define ICM_CFG1			0x10014
+#define ICM_CFG0_L0_MASK		0x07
+#define ICM_CFG0_L1_MASK		0x70
+#define ICM_CFG1_L2_MASK		0x07
+#define ICM_CFG2_L3_MASK		0x70
+#define ICM_CFG_SHIFT			4
+
+/* Inter Connect Matrix allowed protocols */
+#define ICM_PROTOCOL_PD			0x0
+#define ICM_PROTOCOL_PCIE		0x1
+#define ICM_PROTOCOL_SATA		0x2
+#define ICM_PROTOCOL_USB		0x3
+#define ICM_PROTOCOL_DP			0x4
+#define ICM_PROTOCOL_SGMII		0x5
+
+/* Test Mode common reset control  parameters */
+#define TM_CMN_RST			0x10018
+#define TM_CMN_RST_EN			0x1
+#define TM_CMN_RST_SET			0x2
+#define TM_CMN_RST_MASK			0x3
+
+/* Refclk selection parameters */
+#define PLL_REF_SEL0			0x10000
+#define PLL_REF_OFFSET			0x4
+#define PLL_FREQ_MASK			0x1F
+#define PLL_STATUS_READ_OFFSET		0x4000
+#define PLL_STATUS_LOCKED		0x10
+
+/* PLL SSC step size offsets */
+#define L0_L0_REF_CLK_SEL		0x2860
+#define L0_PLL_SS_STEPS_0_LSB		0x2368
+#define L0_PLL_SS_STEPS_1_MSB		0x236C
+#define L0_PLL_SS_STEP_SIZE_0_LSB	0x2370
+#define L0_PLL_SS_STEP_SIZE_1		0x2374
+#define L0_PLL_SS_STEP_SIZE_2		0x2378
+#define L0_PLL_SS_STEP_SIZE_3_MSB	0x237C
+#define L0_PLL_STATUS_READ_1		0x23E4
+
+/* SSC step size parameters */
+#define STEP_SIZE_OFFSET		0x4000
+#define STEP_SIZE_0_MASK		0xFF
+#define STEP_SIZE_1_MASK		0xFF
+#define STEP_SIZE_2_MASK		0xFF
+#define STEP_SIZE_3_MASK		0x3
+#define STEP_SIZE_SHIFT			8
+#define FORCE_STEP_SIZE			0x10
+#define FORCE_STEPS			0x20
+#define STEPS_OFFSET			0x4000
+#define STEPS_0_MASK			0xFF
+#define STEPS_1_MASK			0x07
+
+/* BG calibration parameters */
+#define BGCAL_REF_SEL			0x10028
+#define BGCAL_REF_VALUE			0x0C
+
+/* Calibration digital logic parameters */
+#define L3_TM_CALIB_DIG19		0xEC4C
+#define L3_CALIB_DONE_STATUS		0xEF14
+#define L3_TM_CALIB_DIG18		0xEC48
+#define L3_TM_CALIB_DIG19_NSW		0x07
+#define L3_TM_CALIB_DIG18_NSW		0xE0
+#define L3_TM_OVERRIDE_NSW_CODE         0x20
+#define L3_CALIB_DONE			0x02
+#define L3_NSW_SHIFT			5
+#define L3_NSW_PIPE_SHIFT		4
+#define L3_NSW_CALIB_SHIFT		3
+
+/* DN Resistor calibration code parameters */
+#define L0_TXPMA_ST_3			0x0B0C
+#define L0_DN_CALIB_CODE		0x3F
+
+/* PLL Test Mode register parameters */
+#define L0_TM_PLL_DIG_37		0x2094
+#define L0_TM_PLL_DIG_37_OFFSET		0x4000
+#define L0_TM_COARSE_CODE_LIMIT		0x10
+
+/* PCS control parameters */
+#define L0_TM_DIG_6			0x106C
+#define L0_TX_DIG_61			0x00F4
+#define L0_TM_DIG_6_OFFSET		0x4000
+#define L0_TX_DIG_61_OFFSET		0x4000
+#define L0_TM_DIS_DESCRAMBLE_DECODER	0x0F
+#define L0_TM_DISABLE_SCRAMBLE_ENCODER	0x0F
+
+/* TX De-emphasis parameters */
+#define L0_TX_ANA_TM_18			0x0048
+#define L0_TX_ANA_TM_118		0x01D8
+#define L0_TX_ANA_TM_18_OFFSET		0x4000
+#define L0_TX_ANA_TM_118_OFFSET		0x4000
+#define L0_TX_ANA_TM_118_FORCE_17_0	BIT(0)
+
+/* PMA control parameters */
+#define L0_TXPMD_TM_45			0x0CB4
+#define L0_TXPMD_TM_48			0x0CC0
+#define L0_TXPMD_TM_45_OFFSET		0x4000
+#define L0_TXPMD_TM_48_OFFSET		0x4000
+#define L0_TXPMD_TM_45_OVER_DP_MAIN	BIT(0)
+#define L0_TXPMD_TM_45_ENABLE_DP_MAIN	BIT(1)
+#define L0_TXPMD_TM_45_OVER_DP_POST1	BIT(2)
+#define L0_TXPMD_TM_45_ENABLE_DP_POST1	BIT(3)
+#define L0_TXPMD_TM_45_OVER_DP_POST2	BIT(4)
+#define L0_TXPMD_TM_45_ENABLE_DP_POST2	BIT(5)
+
+/* Bus width parameters */
+#define TX_PROT_BUS_WIDTH		0x10040
+#define RX_PROT_BUS_WIDTH		0x10044
+#define PROT_BUS_WIDTH_10		0x0
+#define PROT_BUS_WIDTH_20		0x1
+#define PROT_BUS_WIDTH_40		0x2
+#define PROT_BUS_WIDTH_SHIFT		2
+
+/* Max number of GT lanes */
+#define MAX_LANES			4
+
+/* Max Allowed refclk frequencies */
+#define MAX_REFCLK			13
+
+/* Lane CLK sharing mask */
+#define LANE_CLK_SHARE_MASK		0x8F
+
+/* SIOU SATA control register */
+#define SATA_CONTROL_OFFSET		0x0100
+
+/* Total number of controllers */
+#define CONTROLLERS_PER_LANE		5
+
+/* USB pipe control parameters */
+#define PIPE_CLK_OFFSET			0x7c
+#define PIPE_POWER_OFFSET		0x80
+#define PIPE_CLK_ON			1
+#define PIPE_CLK_OFF			0
+#define PIPE_POWER_ON			1
+#define PIPE_POWER_OFF			0
+
+/* Protocol Type Pparameters */
+#define XPSGTR_TYPE_USB0		0  /* USB controller 0 */
+#define XPSGTR_TYPE_USB1		1  /* USB controller 1 */
+#define XPSGTR_TYPE_SATA_0		2  /* SATA controller lane 0 */
+#define XPSGTR_TYPE_SATA_1		3  /* SATA controller lane 1 */
+#define XPSGTR_TYPE_PCIE_0		4  /* PCIe controller lane 0 */
+#define XPSGTR_TYPE_PCIE_1		5  /* PCIe controller lane 1 */
+#define XPSGTR_TYPE_PCIE_2		6  /* PCIe controller lane 2 */
+#define XPSGTR_TYPE_PCIE_3		7  /* PCIe controller lane 3 */
+#define XPSGTR_TYPE_DP_0		8  /* Display Port controller lane 0 */
+#define XPSGTR_TYPE_DP_1		9  /* Display Port controller lane 1 */
+#define XPSGTR_TYPE_SGMII0		10 /* Ethernet SGMII controller 0 */
+#define XPSGTR_TYPE_SGMII1		11 /* Ethernet SGMII controller 1 */
+#define XPSGTR_TYPE_SGMII2		12 /* Ethernet SGMII controller 2 */
+#define XPSGTR_TYPE_SGMII3		13 /* Ethernet SGMII controller 3 */
+
+/* Timeout values */
+#define RST_TIMEOUT_MS			1000
+#define TIMEOUT_US			1000
+
+/*
+ * This table holds the valid combinations of controllers and
+ * lanes(Interconnect Matrix).
+ */
+static unsigned int icm_matrix[MAX_LANES][CONTROLLERS_PER_LANE] = {
+	{ XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
+		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
+	{ XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
+		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
+	{ XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
+		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
+	{ XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
+		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
+};
+
+/* Allowed PLL reference clock frequencies */
+enum pll_frequencies {
+	REF_19_2M = 0,
+	REF_20M,
+	REF_24M,
+	REF_26M,
+	REF_27M,
+	REF_38_4M,
+	REF_40M,
+	REF_52M,
+	REF_100M,
+	REF_108M,
+	REF_125M,
+	REF_135M,
+	REF_150M,
+};
+
+/**
+ * struct xpsgtr_phy - representation of a lane
+ * @phy: pointer to the kernel PHY device
+ * @type: controller which uses this lane
+ * @lane: lane number
+ * @protocol: protocol in which the lane operates
+ * @ref_clk: enum of allowed ref clock rates for this lane PLL
+ * @pll_lock: PLL status
+ * @skip_phy_init: skip phy_init() if true
+ * @data: pointer to hold private data
+ * @refclk_rate: PLL reference clock frequency
+ * @share_laneclk: lane number of the clock to be shared
+ */
+struct xpsgtr_phy {
+	struct phy *phy;
+	u8 type;
+	u8 lane;
+	u8 protocol;
+	enum pll_frequencies ref_clk;
+	bool pll_lock;
+	bool skip_phy_init;
+	void *data;
+	u32 refclk_rate;
+	u32 share_laneclk;
+};
+
+/**
+ * struct xpsgtr_ssc - structure to hold SSC settings for a lane
+ * @refclk_rate: PLL reference clock frequency
+ * @pll_ref_clk: value to be written to register for corresponding ref clk rate
+ * @steps: number of steps of SSC (Spread Spectrum Clock)
+ * @step_size: step size of each step
+ */
+struct xpsgtr_ssc {
+	u32 refclk_rate;
+	u8  pll_ref_clk;
+	u32 steps;
+	u32 step_size;
+};
+
+/* lookup table to hold all settings needed for a ref clock frequency */
+static struct xpsgtr_ssc ssc_lookup[MAX_REFCLK] = {
+	{19200000, 0x05, 608, 264020},
+	{20000000, 0x06, 634, 243454},
+	{24000000, 0x07, 760, 168973},
+	{26000000, 0x08, 824, 143860},
+	{27000000, 0x09, 856, 86551},
+	{38400000, 0x0A, 1218, 65896},
+	{40000000, 0x0B, 634, 243454},
+	{52000000, 0x0C, 824, 143860},
+	{100000000, 0x0D, 1058, 87533},
+	{108000000, 0x0E, 856, 86551},
+	{125000000, 0x0F, 992, 119497},
+	{135000000, 0x10, 1070, 55393},
+	{150000000, 0x11, 792, 187091}
+};
+
+/**
+ * struct xpsgtr_dev - representation of a ZynMP GT device
+ * @dev: pointer to device
+ * @serdes: serdes base address
+ * @siou: siou base address
+ * @gtr_mutex: mutex for locking
+ * @phys: pointer to all the lanes
+ * @tx_term_fix: fix for GT issue
+ * @saved_icm_cfg0: stored value of ICM CFG0 register
+ * @saved_icm_cfg1: stored value of ICM CFG1 register
+ * @sata_rst: a reset control for SATA
+ * @dp_rst: a reset control for DP
+ * @usb0_crst: a reset control for usb0 core
+ * @usb1_crst: a reset control for usb1 core
+ * @usb0_hibrst: a reset control for usb0 hibernation module
+ * @usb1_hibrst: a reset control for usb1 hibernation module
+ * @usb0_apbrst: a reset control for usb0 apb bus
+ * @usb1_apbrst: a reset control for usb1 apb bus
+ * @gem0_rst: a reset control for gem0
+ * @gem1_rst: a reset control for gem1
+ * @gem2_rst: a reset control for gem2
+ * @gem3_rst: a reset control for gem3
+ */
+struct xpsgtr_dev {
+	struct device *dev;
+	void __iomem *serdes;
+	void __iomem *siou;
+	struct mutex gtr_mutex; /* mutex for locking */
+	struct xpsgtr_phy **phys;
+	bool tx_term_fix;
+	unsigned int saved_icm_cfg0;
+	unsigned int saved_icm_cfg1;
+	struct reset_control *sata_rst;
+	struct reset_control *dp_rst;
+	struct reset_control *usb0_crst;
+	struct reset_control *usb1_crst;
+	struct reset_control *usb0_hibrst;
+	struct reset_control *usb1_hibrst;
+	struct reset_control *usb0_apbrst;
+	struct reset_control *usb1_apbrst;
+	struct reset_control *gem0_rst;
+	struct reset_control *gem1_rst;
+	struct reset_control *gem2_rst;
+	struct reset_control *gem3_rst;
+};
+
+/**
+ * xpsgtr_override_deemph - override PIPE TX de-emphasis
+ * @phy: pointer to phy
+ * @plvl: pre-emphasis level
+ * @vlvl: voltage swing level
+ *
+ * Return: None
+ */
+void xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl)
+{
+	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	static u8 pe[4][4] = { { 0x2, 0x2, 0x2, 0x2 },
+			       { 0x1, 0x1, 0x1, 0xFF },
+			       { 0x0, 0x0, 0xFF, 0xFF },
+			       { 0xFF, 0xFF, 0xFF, 0xFF } };
+
+	writel(pe[plvl][vlvl],
+	       gtr_dev->serdes + gtr_phy->lane * L0_TX_ANA_TM_18_OFFSET +
+	       L0_TX_ANA_TM_18);
+}
+EXPORT_SYMBOL_GPL(xpsgtr_override_deemph);
+
+/**
+ * xpsgtr_margining_factor - adjust margining factor value
+ * @phy: pointer to phy
+ * @plvl: pre-emphasis level
+ * @vlvl: voltage swing level
+ *
+ * Return: None
+ */
+void xpsgtr_margining_factor(struct phy *phy, u8 plvl, u8 vlvl)
+{
+	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	static u8 vs[4][4] = { { 0x2a, 0x27, 0x24, 0x20 },
+			       { 0x27, 0x23, 0x20, 0xFF },
+			       { 0x24, 0x20, 0xFF, 0xFF },
+			       { 0xFF, 0xFF, 0xFF, 0xFF } };
+
+	writel(vs[plvl][vlvl],
+	       gtr_dev->serdes + gtr_phy->lane * L0_TXPMD_TM_48_OFFSET +
+	       L0_TXPMD_TM_48);
+}
+EXPORT_SYMBOL_GPL(xpsgtr_margining_factor);
+
+/**
+ * xpsgtr_configure_pll - configures SSC settings for a lane
+ * @gtr_phy: pointer to lane
+ *
+ * Return: None
+ */
+static void xpsgtr_configure_pll(struct xpsgtr_phy *gtr_phy)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	u32 reg;
+	u32 offset;
+	u32 steps;
+	u32 size;
+	u8 pll_ref_clk;
+
+	steps = ssc_lookup[gtr_phy->ref_clk].steps;
+	size = ssc_lookup[gtr_phy->ref_clk].step_size;
+	pll_ref_clk = ssc_lookup[gtr_phy->ref_clk].pll_ref_clk;
+
+	offset = gtr_phy->lane * PLL_REF_OFFSET + PLL_REF_SEL0;
+	reg = readl(gtr_dev->serdes + offset);
+	reg = (reg & ~PLL_FREQ_MASK) | pll_ref_clk;
+	writel(reg, gtr_dev->serdes + offset);
+
+	/* Enable lane clock sharing, if required */
+	if (gtr_phy->share_laneclk != gtr_phy->lane) {
+		/* Lane3 Ref Clock Selection Register */
+		offset = gtr_phy->lane * PLL_REF_OFFSET + L0_L0_REF_CLK_SEL;
+		reg = readl(gtr_dev->serdes + offset);
+		reg = (reg & ~LANE_CLK_SHARE_MASK) |
+				(1 << gtr_phy->share_laneclk);
+		writel(reg, gtr_dev->serdes + offset);
+	}
+
+	/* SSC step size [7:0] */
+	offset = gtr_phy->lane * STEP_SIZE_OFFSET + L0_PLL_SS_STEP_SIZE_0_LSB;
+	reg = readl(gtr_dev->serdes + offset);
+	reg = (reg & ~STEP_SIZE_0_MASK) |
+		(size & STEP_SIZE_0_MASK);
+	writel(reg, gtr_dev->serdes + offset);
+
+	/* SSC step size [15:8] */
+	size = size >> STEP_SIZE_SHIFT;
+	offset = gtr_phy->lane * STEP_SIZE_OFFSET + L0_PLL_SS_STEP_SIZE_1;
+	reg = readl(gtr_dev->serdes + offset);
+	reg = (reg & ~STEP_SIZE_1_MASK) |
+		(size & STEP_SIZE_1_MASK);
+	writel(reg, gtr_dev->serdes + offset);
+
+	/* SSC step size [23:16] */
+	size = size >> STEP_SIZE_SHIFT;
+	offset = gtr_phy->lane * STEP_SIZE_OFFSET + L0_PLL_SS_STEP_SIZE_2;
+	reg = readl(gtr_dev->serdes + offset);
+	reg = (reg & ~STEP_SIZE_2_MASK) |
+		(size & STEP_SIZE_2_MASK);
+	writel(reg, gtr_dev->serdes + offset);
+
+	/* SSC steps [7:0] */
+	offset = gtr_phy->lane * STEPS_OFFSET + L0_PLL_SS_STEPS_0_LSB;
+	reg = readl(gtr_dev->serdes + offset);
+	reg = (reg & ~STEPS_0_MASK) |
+		(steps & STEPS_0_MASK);
+	writel(reg, gtr_dev->serdes + offset);
+
+	/* SSC steps [10:8] */
+	steps = steps >> STEP_SIZE_SHIFT;
+	offset = gtr_phy->lane * STEPS_OFFSET + L0_PLL_SS_STEPS_1_MSB;
+	reg = readl(gtr_dev->serdes + offset);
+	reg = (reg & ~STEPS_1_MASK) |
+		(steps & STEPS_1_MASK);
+	writel(reg, gtr_dev->serdes + offset);
+
+	/* SSC step size [24:25] */
+	size = size >> STEP_SIZE_SHIFT;
+	offset = gtr_phy->lane * STEP_SIZE_OFFSET + L0_PLL_SS_STEP_SIZE_3_MSB;
+	reg = readl(gtr_dev->serdes + offset);
+	reg = (reg & ~STEP_SIZE_3_MASK) |
+		(size & STEP_SIZE_3_MASK);
+	reg |= FORCE_STEP_SIZE | FORCE_STEPS;
+	writel(reg, gtr_dev->serdes + offset);
+}
+
+/**
+ * xpsgtr_lane_setprotocol - sets required protocol in ICM registers
+ * @gtr_phy: pointer to lane
+ *
+ * Return: None
+ */
+static void xpsgtr_lane_setprotocol(struct xpsgtr_phy *gtr_phy)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	u32 reg;
+	u8 protocol = gtr_phy->protocol;
+
+	switch (gtr_phy->lane) {
+	case 0:
+		reg = readl(gtr_dev->serdes + ICM_CFG0);
+		reg = (reg & ~ICM_CFG0_L0_MASK) | protocol;
+		writel(reg, gtr_dev->serdes + ICM_CFG0);
+		break;
+	case 1:
+		reg = readl(gtr_dev->serdes + ICM_CFG0);
+		reg = (reg & ~ICM_CFG0_L1_MASK) | (protocol << ICM_CFG_SHIFT);
+		writel(reg, gtr_dev->serdes + ICM_CFG0);
+		break;
+	case 2:
+		reg = readl(gtr_dev->serdes + ICM_CFG1);
+		reg = (reg & ~ICM_CFG0_L0_MASK) | protocol;
+		writel(reg, gtr_dev->serdes + ICM_CFG1);
+		break;
+	case 3:
+		reg = readl(gtr_dev->serdes + ICM_CFG1);
+		reg = (reg & ~ICM_CFG0_L1_MASK) | (protocol << ICM_CFG_SHIFT);
+		writel(reg, gtr_dev->serdes + ICM_CFG1);
+		break;
+	default:
+		/* We already checked 0 <= lane <= 3 */
+		break;
+	}
+}
+
+/**
+ * xpsgtr_get_ssc - gets the required ssc settings based on clk rate
+ * @gtr_phy: pointer to lane
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_get_ssc(struct xpsgtr_phy *gtr_phy)
+{
+	u32 i;
+
+	/*
+	 * Assign the required spread spectrum(SSC) settings
+	 * from lane refernce clk rate
+	 */
+	for (i = 0 ; i < ARRAY_SIZE(ssc_lookup); i++) {
+		if (gtr_phy->refclk_rate == ssc_lookup[i].refclk_rate) {
+			gtr_phy->ref_clk = i;
+			return 0;
+		}
+	}
+
+	/* Did not get valid ssc settings*/
+	return -EINVAL;
+}
+
+/**
+ * xpsgtr_configure_lane - configures SSC settings for a lane
+ * @gtr_phy: pointer to lane
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_configure_lane(struct xpsgtr_phy *gtr_phy)
+{
+	switch (gtr_phy->type) {
+	case XPSGTR_TYPE_USB0:
+	case XPSGTR_TYPE_USB1:
+		gtr_phy->protocol = ICM_PROTOCOL_USB;
+		break;
+	case XPSGTR_TYPE_SATA_0:
+	case XPSGTR_TYPE_SATA_1:
+		gtr_phy->protocol = ICM_PROTOCOL_SATA;
+		break;
+	case XPSGTR_TYPE_DP_0:
+	case XPSGTR_TYPE_DP_1:
+		gtr_phy->protocol = ICM_PROTOCOL_DP;
+		break;
+	case XPSGTR_TYPE_PCIE_0:
+	case XPSGTR_TYPE_PCIE_1:
+	case XPSGTR_TYPE_PCIE_2:
+	case XPSGTR_TYPE_PCIE_3:
+		gtr_phy->protocol = ICM_PROTOCOL_PCIE;
+		break;
+	case XPSGTR_TYPE_SGMII0:
+	case XPSGTR_TYPE_SGMII1:
+	case XPSGTR_TYPE_SGMII2:
+	case XPSGTR_TYPE_SGMII3:
+		gtr_phy->protocol = ICM_PROTOCOL_SGMII;
+		break;
+	default:
+		gtr_phy->protocol = ICM_PROTOCOL_PD;
+		break;
+	}
+
+	/* Get SSC settinsg for refernce clk rate */
+	if (xpsgtr_get_ssc(gtr_phy) < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * xpsgtr_config_usbpipe - configures the PIPE3 signals for USB
+ * @gtr_phy: pointer to gtr phy device
+ *
+ * Return: None
+ */
+static void xpsgtr_config_usbpipe(struct xpsgtr_phy *gtr_phy)
+{
+	struct phy *phy = gtr_phy->phy;
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	void __iomem *regs = dev_get_platdata(&phy->dev);
+
+	if (regs) {
+		/* Set PIPE power present signal */
+		writel(PIPE_POWER_ON, regs + PIPE_POWER_OFFSET);
+
+		/* Clear PIPE CLK signal */
+		writel(PIPE_CLK_OFF, regs + PIPE_CLK_OFFSET);
+	} else {
+		dev_info(gtr_dev->dev,
+			 "%s: No valid Platform_data found\n", __func__);
+	}
+}
+
+/**
+ * xpsgtr_reset_assert - asserts reset using reset framework
+ * @rstc: pointer to reset_control
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_reset_assert(struct reset_control *rstc)
+{
+	unsigned long loop_time = msecs_to_jiffies(RST_TIMEOUT_MS);
+	unsigned long timeout;
+
+	reset_control_assert(rstc);
+
+	/* wait until reset is asserted or timeout */
+	timeout = jiffies + loop_time;
+
+	while (!time_after_eq(jiffies, timeout)) {
+		if (reset_control_status(rstc) > 0)
+			return 0;
+
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * xpsgtr_reset_release - de-asserts reset using reset framework
+ * @rstc: pointer to reset_control
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_reset_release(struct reset_control *rstc)
+{
+	unsigned long loop_time = msecs_to_jiffies(RST_TIMEOUT_MS);
+	unsigned long timeout;
+
+	reset_control_deassert(rstc);
+
+	/* wait until reset is de-asserted or timeout */
+	timeout = jiffies + loop_time;
+	while (!time_after_eq(jiffies, timeout)) {
+		if (!reset_control_status(rstc))
+			return 0;
+
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * xpsgtr_controller_reset - puts controller in reset
+ * @gtr_phy: pointer to lane
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_controller_reset(struct xpsgtr_phy *gtr_phy)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	int ret;
+
+	switch (gtr_phy->type) {
+	case XPSGTR_TYPE_USB0:
+		ret = xpsgtr_reset_assert(gtr_dev->usb0_crst);
+		if (ret != 0)
+			break;
+
+		ret = xpsgtr_reset_assert(gtr_dev->usb0_hibrst);
+		if (ret != 0)
+			break;
+
+		ret = xpsgtr_reset_assert(gtr_dev->usb0_apbrst);
+		break;
+	case XPSGTR_TYPE_USB1:
+		ret = xpsgtr_reset_assert(gtr_dev->usb1_crst);
+		if (ret != 0)
+			break;
+
+		ret = xpsgtr_reset_assert(gtr_dev->usb1_hibrst);
+		if (ret != 0)
+			break;
+
+		ret = xpsgtr_reset_assert(gtr_dev->usb1_apbrst);
+		break;
+	case XPSGTR_TYPE_SATA_0:
+	case XPSGTR_TYPE_SATA_1:
+		ret = xpsgtr_reset_assert(gtr_dev->sata_rst);
+		break;
+	case XPSGTR_TYPE_DP_0:
+	case XPSGTR_TYPE_DP_1:
+		ret = xpsgtr_reset_assert(gtr_dev->dp_rst);
+		break;
+	case XPSGTR_TYPE_SGMII0:
+		ret = xpsgtr_reset_assert(gtr_dev->gem0_rst);
+		break;
+	case XPSGTR_TYPE_SGMII1:
+		ret = xpsgtr_reset_assert(gtr_dev->gem1_rst);
+		break;
+	case XPSGTR_TYPE_SGMII2:
+		ret = xpsgtr_reset_assert(gtr_dev->gem2_rst);
+		break;
+	case XPSGTR_TYPE_SGMII3:
+		ret = xpsgtr_reset_assert(gtr_dev->gem3_rst);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * xpsgtr_controller_release_reset - releases controller from reset
+ * @gtr_phy: pointer to lane
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_controller_release_reset(struct xpsgtr_phy *gtr_phy)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	int ret;
+
+	switch (gtr_phy->type) {
+	case XPSGTR_TYPE_USB0:
+		ret = xpsgtr_reset_release(gtr_dev->usb0_apbrst);
+		if (ret != 0)
+			break;
+
+		/* Config PIPE3 signals after releasing APB reset */
+		xpsgtr_config_usbpipe(gtr_phy);
+
+		ret = xpsgtr_reset_release(gtr_dev->usb0_crst);
+		if (ret != 0)
+			break;
+
+		ret = xpsgtr_reset_release(gtr_dev->usb0_hibrst);
+		break;
+	case XPSGTR_TYPE_USB1:
+		ret = xpsgtr_reset_release(gtr_dev->usb1_apbrst);
+		if (ret != 0)
+			break;
+
+		/* Config PIPE3 signals after releasing APB reset */
+		xpsgtr_config_usbpipe(gtr_phy);
+
+		ret = xpsgtr_reset_release(gtr_dev->usb1_crst);
+		if (ret != 0)
+			break;
+
+		ret = xpsgtr_reset_release(gtr_dev->usb1_hibrst);
+		break;
+	case XPSGTR_TYPE_SATA_0:
+	case XPSGTR_TYPE_SATA_1:
+		ret = xpsgtr_reset_release(gtr_dev->sata_rst);
+		break;
+	case XPSGTR_TYPE_DP_0:
+	case XPSGTR_TYPE_DP_1:
+		ret = xpsgtr_reset_release(gtr_dev->dp_rst);
+		break;
+	case XPSGTR_TYPE_SGMII0:
+		ret = xpsgtr_reset_release(gtr_dev->gem0_rst);
+		break;
+	case XPSGTR_TYPE_SGMII1:
+		ret = xpsgtr_reset_release(gtr_dev->gem1_rst);
+		break;
+	case XPSGTR_TYPE_SGMII2:
+		ret = xpsgtr_reset_release(gtr_dev->gem2_rst);
+		break;
+	case XPSGTR_TYPE_SGMII3:
+		ret = xpsgtr_reset_release(gtr_dev->gem3_rst);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * xpsgtr_usb_rst_assert - assert USB core reset
+ * @phy: pointer to phy
+ *
+ * Return: 0 on success or error on failure
+ */
+int xpsgtr_usb_crst_assert(struct phy *phy)
+{
+	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	int ret;
+
+	switch (gtr_phy->type) {
+	case XPSGTR_TYPE_USB0:
+		ret = xpsgtr_reset_assert(gtr_dev->usb0_crst);
+		break;
+	case XPSGTR_TYPE_USB1:
+		ret = xpsgtr_reset_assert(gtr_dev->usb1_crst);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(xpsgtr_usb_crst_assert);
+
+/**
+ * xpsgtr_usb_rst_release - release USB core reset
+ * @phy: pointer to phy
+ *
+ * Return: 0 on success or error on failure
+ */
+int xpsgtr_usb_crst_release(struct phy *phy)
+{
+	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	int ret;
+
+	switch (gtr_phy->type) {
+	case XPSGTR_TYPE_USB0:
+		ret = xpsgtr_reset_release(gtr_dev->usb0_crst);
+		break;
+	case XPSGTR_TYPE_USB1:
+		ret = xpsgtr_reset_release(gtr_dev->usb1_crst);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(xpsgtr_usb_crst_release);
+
+/**
+ * xpsgtr_wait_pll_lock - Waits until PLL is locked or timedout
+ * @phy: pointer to phy
+ *
+ * Return: 0 on success or error on failure
+ */
+int xpsgtr_wait_pll_lock(struct phy *phy)
+{
+	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	u32 offset, reg;
+	u32 timeout = TIMEOUT_US;
+	int ret = 0;
+
+	/* Check pll is locked */
+	offset = gtr_phy->lane * PLL_STATUS_READ_OFFSET + L0_PLL_STATUS_READ_1;
+	dev_dbg(gtr_dev->dev, "Waiting for PLL lock...\n");
+
+	do {
+		reg = readl(gtr_dev->serdes + offset);
+		if ((reg & PLL_STATUS_LOCKED) == PLL_STATUS_LOCKED)
+			break;
+
+		if (!--timeout) {
+			dev_err(gtr_dev->dev, "PLL lock time out\n");
+			ret = -ETIMEDOUT;
+			break;
+		}
+
+		udelay(1);
+	} while (timeout > 0);
+
+	if (ret == 0)
+		gtr_phy->pll_lock = true;
+
+	dev_info(gtr_dev->dev, "Lane:%d type:%d protocol:%d pll_locked:%s\n",
+		 gtr_phy->lane, gtr_phy->type, gtr_phy->protocol,
+		 gtr_phy->pll_lock ? "yes" : "no");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xpsgtr_wait_pll_lock);
+
+/**
+ * xpsgtr_set_txwidth - This function sets the tx bus width of the lane
+ * @gtr_phy: pointer to lane
+ * @width: tx bus width size
+ *
+ * Return: None
+ */
+static void xpsgtr_set_txwidth(struct xpsgtr_phy *gtr_phy, u32 width)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+
+	writel(gtr_phy->lane * PROT_BUS_WIDTH_SHIFT >> width,
+	       gtr_dev->serdes + TX_PROT_BUS_WIDTH);
+}
+
+/**
+ * xpsgtr_set_rxwidth - This function sets the rx bus width of the lane
+ * @gtr_phy: pointer to lane
+ * @width: rx bus width size
+ *
+ * Return: None
+ */
+static void xpsgtr_set_rxwidth(struct xpsgtr_phy *gtr_phy, u32 width)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+
+	writel(gtr_phy->lane * PROT_BUS_WIDTH_SHIFT >> width,
+	       gtr_dev->serdes + RX_PROT_BUS_WIDTH);
+}
+
+/**
+ * xpsgtr_bypass_scramenc - This bypasses scrambler and 8b/10b encoder feature
+ * @gtr_phy: pointer to lane
+ *
+ * Return: None
+ */
+static void xpsgtr_bypass_scramenc(struct xpsgtr_phy *gtr_phy)
+{
+	u32 offset;
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+
+	/* bypass Scrambler and 8b/10b Encoder */
+	offset = gtr_phy->lane * L0_TX_DIG_61_OFFSET + L0_TX_DIG_61;
+	writel(L0_TM_DISABLE_SCRAMBLE_ENCODER, gtr_dev->serdes + offset);
+}
+
+/**
+ * xpsgtr_bypass_descramdec - bypasses descrambler and 8b/10b encoder feature
+ * @gtr_phy: pointer to lane
+ *
+ * Return: None
+ */
+static void xpsgtr_bypass_descramdec(struct xpsgtr_phy *gtr_phy)
+{
+	u32 offset;
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+
+	/* bypass Descrambler and 8b/10b decoder */
+	offset = gtr_phy->lane * L0_TM_DIG_6_OFFSET + L0_TM_DIG_6;
+	writel(L0_TM_DIS_DESCRAMBLE_DECODER, gtr_dev->serdes + offset);
+}
+
+/**
+ * xpsgtr_misc_sgmii - miscellaneous settings for SGMII
+ * @gtr_phy: pointer to lane
+ *
+ * Return: None
+ */
+static void xpsgtr_misc_sgmii(struct xpsgtr_phy *gtr_phy)
+{
+	/* Set SGMII protocol tx bus width 10 bits */
+	xpsgtr_set_txwidth(gtr_phy, PROT_BUS_WIDTH_10);
+
+	/* Set SGMII protocol rx bus width 10 bits */
+	xpsgtr_set_rxwidth(gtr_phy, PROT_BUS_WIDTH_10);
+
+	/* bypass Descrambler and 8b/10b decoder */
+	xpsgtr_bypass_descramdec(gtr_phy);
+
+	/* bypass Scrambler and 8b/10b Encoder */
+	xpsgtr_bypass_scramenc(gtr_phy);
+}
+
+/**
+ * xpsgtr_misc_sata - miscellaneous settings for SATA
+ * @gtr_phy: pointer to lane
+ *
+ * Return: None
+ */
+static void xpsgtr_misc_sata(struct xpsgtr_phy *gtr_phy)
+{
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+
+	/* bypass Descrambler and 8b/10b decoder */
+	xpsgtr_bypass_descramdec(gtr_phy);
+
+	/* bypass Scrambler and 8b/10b Encoder */
+	xpsgtr_bypass_scramenc(gtr_phy);
+
+	writel(gtr_phy->lane, gtr_dev->siou + SATA_CONTROL_OFFSET);
+}
+
+/**
+ * xpsgtr_phyinit_required - check if phy_init for the lane can be skipped
+ * @gtr_phy: pointer to the phy lane
+ *
+ * Return: true if phy_init can be skipped or false
+ */
+static bool xpsgtr_phyinit_required(struct xpsgtr_phy *gtr_phy)
+{
+	/*
+	 * As USB may save the snapshot of the states during hibernation, doing
+	 * phy_init() will put the USB controller into reset, resulting in the
+	 * losing of the saved snapshot. So try to avoid phy_init() for USB
+	 * except when gtr_phy->skip_phy_init is false (this happens when FPD is
+	 * shutdown during suspend or when gt lane is changed from current one)
+	 */
+	if (gtr_phy->protocol == ICM_PROTOCOL_USB && gtr_phy->skip_phy_init)
+		return true;
+	else
+		return false;
+}
+
+/**
+ * xpsgtr_phy_init - initializes a lane
+ * @phy: pointer to kernel PHY device
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_phy_init(struct phy *phy)
+{
+	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
+	int ret = 0;
+	u32 offset;
+	u32 reg;
+	u32 nsw;
+	u32 timeout = TIMEOUT_US;
+
+	mutex_lock(&gtr_dev->gtr_mutex);
+
+	/* Check if phy_init() is required  */
+	if (xpsgtr_phyinit_required(gtr_phy))
+		goto out;
+
+	/* Put controller in reset */
+	ret = xpsgtr_controller_reset(gtr_phy);
+	if (ret != 0) {
+		dev_err(gtr_dev->dev, "Failed to assert reset\n");
+		goto out;
+	}
+
+	/*
+	 * There is a functional issue in the GT. The TX termination resistance
+	 * can be out of spec due to a issue in the calibration logic. Below is
+	 * the workaround to fix it. This below is required for XCZU9EG silicon.
+	 */
+	if (gtr_dev->tx_term_fix) {
+		/* Enabling Test Mode control for CMN Rest */
+		reg = readl(gtr_dev->serdes + TM_CMN_RST);
+		reg = (reg & ~TM_CMN_RST_MASK) | TM_CMN_RST_SET;
+		writel(reg, gtr_dev->serdes + TM_CMN_RST);
+
+		/* Set Test Mode reset */
+		reg = readl(gtr_dev->serdes + TM_CMN_RST);
+		reg = (reg & ~TM_CMN_RST_MASK) | TM_CMN_RST_EN;
+		writel(reg, gtr_dev->serdes + TM_CMN_RST);
+
+		writel(0x00, gtr_dev->serdes + L3_TM_CALIB_DIG18);
+		writel(L3_TM_OVERRIDE_NSW_CODE, gtr_dev->serdes +
+				L3_TM_CALIB_DIG19);
+
+		/* As a part of work around sequence for PMOS calibration fix,
+		 * we need to configure any lane ICM_CFG to valid protocol. This
+		 * will deassert the CMN_Resetn signal.
+		 */
+		xpsgtr_lane_setprotocol(gtr_phy);
+
+		/* Clear Test Mode reset */
+		reg = readl(gtr_dev->serdes + TM_CMN_RST);
+		reg = (reg & ~TM_CMN_RST_MASK) | TM_CMN_RST_SET;
+		writel(reg, gtr_dev->serdes + TM_CMN_RST);
+
+		dev_dbg(gtr_dev->dev, "calibrating...\n");
+
+		do {
+			reg = readl(gtr_dev->serdes + L3_CALIB_DONE_STATUS);
+			if ((reg & L3_CALIB_DONE) == L3_CALIB_DONE)
+				break;
+
+			if (!--timeout) {
+				dev_err(gtr_dev->dev, "calibration time out\n");
+				ret = -ETIMEDOUT;
+				goto out;
+			}
+			udelay(1);
+		} while (timeout > 0);
+
+		dev_dbg(gtr_dev->dev, "calibration done\n");
+
+		/* Reading NMOS Register Code */
+		nsw = readl(gtr_dev->serdes + L0_TXPMA_ST_3);
+
+		/* Set Test Mode reset */
+		reg = readl(gtr_dev->serdes + TM_CMN_RST);
+		reg = (reg & ~TM_CMN_RST_MASK) | TM_CMN_RST_EN;
+		writel(reg, gtr_dev->serdes + TM_CMN_RST);
+
+		nsw = nsw & L0_DN_CALIB_CODE;
+
+		/* Writing NMOS register values back [5:3] */
+		reg = nsw >> L3_NSW_CALIB_SHIFT;
+		writel(reg, gtr_dev->serdes + L3_TM_CALIB_DIG19);
+
+		/* Writing NMOS register value [2:0] */
+		reg = ((nsw & L3_TM_CALIB_DIG19_NSW) << L3_NSW_SHIFT) |
+						(1 << L3_NSW_PIPE_SHIFT);
+		writel(reg, gtr_dev->serdes + L3_TM_CALIB_DIG18);
+
+		/* Clear Test Mode reset */
+		reg = readl(gtr_dev->serdes + TM_CMN_RST);
+		reg = (reg & ~TM_CMN_RST_MASK) | TM_CMN_RST_SET;
+		writel(reg, gtr_dev->serdes + TM_CMN_RST);
+
+		gtr_dev->tx_term_fix = false;
+	}
+
+	/* Enable coarse code saturation limiting logic */
+	offset = gtr_phy->lane * L0_TM_PLL_DIG_37_OFFSET + L0_TM_PLL_DIG_37;
+	writel(L0_TM_COARSE_CODE_LIMIT, gtr_dev->serdes + offset);
+
+	xpsgtr_configure_pll(gtr_phy);
+	xpsgtr_lane_setprotocol(gtr_phy);
+
+	if (gtr_phy->protocol == ICM_PROTOCOL_SATA)
+		xpsgtr_misc_sata(gtr_phy);
+
+	if (gtr_phy->protocol == ICM_PROTOCOL_SGMII)
+		xpsgtr_misc_sgmii(gtr_phy);
+
+	/* Bring controller out of reset */
+	ret = xpsgtr_controller_release_reset(gtr_phy);
+	if (ret != 0) {
+		dev_err(gtr_dev->dev, "Failed to release reset\n");
+		goto out;
+	}
+
+	/* Wait till pll is locked for all protocols except DP. For DP
+	 * pll locking function will be called from driver.
+	 */
+	if (gtr_phy->protocol != ICM_PROTOCOL_DP) {
+		ret = xpsgtr_wait_pll_lock(phy);
+		if (ret != 0)
+			goto out;
+	} else {
+		offset = gtr_phy->lane * L0_TXPMD_TM_45_OFFSET + L0_TXPMD_TM_45;
+		reg = L0_TXPMD_TM_45_OVER_DP_MAIN |
+		      L0_TXPMD_TM_45_ENABLE_DP_MAIN |
+		      L0_TXPMD_TM_45_OVER_DP_POST1 |
+		      L0_TXPMD_TM_45_OVER_DP_POST2 |
+		      L0_TXPMD_TM_45_ENABLE_DP_POST2;
+		writel(reg, gtr_dev->serdes + offset);
+		offset = gtr_phy->lane * L0_TX_ANA_TM_118_OFFSET +
+			 L0_TX_ANA_TM_118;
+		writel(L0_TX_ANA_TM_118_FORCE_17_0,
+		       gtr_dev->serdes + offset);
+	}
+
+out:
+	mutex_unlock(&gtr_dev->gtr_mutex);
+	return ret;
+}
+
+/**
+ * xpsgtr_set_lanetype - derives lane type from dts arguments
+ * @gtr_phy: pointer to lane
+ * @controller: type of controller
+ * @instance_num: instance number of the controller in case multilane controller
+ *
+ * Return: 0 on success or error on failure
+ */
+static int xpsgtr_set_lanetype(struct xpsgtr_phy *gtr_phy, u8 controller,
+			       u8 instance_num)
+{
+	switch (controller) {
+	case PHY_TYPE_SATA:
+		if (!instance_num)
+			gtr_phy->type = XPSGTR_TYPE_SATA_0;
+		else if (instance_num == 1)
+			gtr_phy->type = XPSGTR_TYPE_SATA_1;
+		else
+			return -EINVAL;
+		break;
+	case PHY_TYPE_USB3:
+		if (!instance_num)
+			gtr_phy->type = XPSGTR_TYPE_USB0;
+		else if (instance_num == 1)
+			gtr_phy->type = XPSGTR_TYPE_USB1;
+		else
+			return -EINVAL;
+		break;
+	case PHY_TYPE_DP:
+		if (!instance_num)
+			gtr_phy->type = XPSGTR_TYPE_DP_0;
+		else if (instance_num == 1)
+			gtr_phy->type = XPSGTR_TYPE_DP_1;
+		else
+			return -EINVAL;
+		break;
+	case PHY_TYPE_PCIE:
+		if (!instance_num)
+			gtr_phy->type = XPSGTR_TYPE_PCIE_0;
+		else if (instance_num == 1)
+			gtr_phy->type = XPSGTR_TYPE_PCIE_1;
+		else if (instance_num == 2)
+			gtr_phy->type = XPSGTR_TYPE_PCIE_2;
+		else if (instance_num == 3)
+			gtr_phy->type = XPSGTR_TYPE_PCIE_3;
+		else
+			return -EINVAL;
+		break;
+	case PHY_TYPE_SGMII:
+		if (!instance_num)
+			gtr_phy->type = XPSGTR_TYPE_SGMII0;
+		else if (instance_num == 1)
+			gtr_phy->type = XPSGTR_TYPE_SGMII1;
+		else if (instance_num == 2)
+			gtr_phy->type = XPSGTR_TYPE_SGMII2;
+		else if (instance_num == 3)
+			gtr_phy->type = XPSGTR_TYPE_SGMII3;
+		else
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * xpsgtr_xlate - provides a PHY specific to a controller
+ * @dev: pointer to device
+ * @args: arguments from dts
+ *
+ * Return: pointer to kernel PHY device or error on failure
+ */
+static struct phy *xpsgtr_xlate(struct device *dev,
+				struct of_phandle_args *args)
+{
+	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
+	struct xpsgtr_phy *gtr_phy = NULL;
+	struct device_node *phynode = args->np;
+	int index;
+	int i;
+	u8 controller;
+	u8 instance_num;
+
+	if (args->args_count != 4) {
+		dev_err(dev, "Invalid number of cells in 'phy' property\n");
+		return ERR_PTR(-EINVAL);
+	}
+	if (!of_device_is_available(phynode)) {
+		dev_warn(dev, "requested PHY is disabled\n");
+		return ERR_PTR(-ENODEV);
+	}
+	for (index = 0; index < of_get_child_count(dev->of_node); index++) {
+		if (phynode == gtr_dev->phys[index]->phy->dev.of_node) {
+			gtr_phy = gtr_dev->phys[index];
+			break;
+		}
+	}
+	if (!gtr_phy) {
+		dev_err(dev, "failed to find appropriate phy\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* get type of controller from phys */
+	controller = args->args[0];
+
+	/* get controller instance number */
+	instance_num = args->args[1];
+
+	/* Check if lane sharing is required */
+	gtr_phy->share_laneclk = args->args[2];
+
+	/* get the required clk rate for controller from phys */
+	gtr_phy->refclk_rate = args->args[3];
+
+	/* derive lane type */
+	if (xpsgtr_set_lanetype(gtr_phy, controller, instance_num) < 0) {
+		dev_err(gtr_dev->dev, "Invalid lane type\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* configures SSC settings for a lane */
+	if (xpsgtr_configure_lane(gtr_phy) < 0) {
+		dev_err(gtr_dev->dev, "Invalid clock rate: %d\n",
+			gtr_phy->refclk_rate);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * Check Interconnect Matrix is obeyed i.e, given lane type
+	 * is allowed to operate on the lane.
+	 */
+	for (i = 0; i < CONTROLLERS_PER_LANE; i++) {
+		if (icm_matrix[index][i] == gtr_phy->type)
+			return gtr_phy->phy;
+	}
+
+	/* Should not reach here */
+	return ERR_PTR(-EINVAL);
+}
+
+/**
+ * xpsgtr_phy_exit - clears previous initialized variables
+ * @phy: pointer to kernel PHY device
+ *
+ * Return: 0 on success or error value on failure
+ */
+static int xpsgtr_phy_exit(struct phy *phy)
+{
+	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+
+	if (!gtr_phy)
+		return -EINVAL;
+
+	/* As we are exiting, clear skip_phy_init flag */
+	gtr_phy->skip_phy_init = false;
+
+	return 0;
+}
+
+static struct phy_ops xpsgtr_phyops = {
+	.init		= xpsgtr_phy_init,
+	.exit		= xpsgtr_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+/*
+ * xpsgtr_get_resets - Gets reset signals based on reset-names property
+ * @gtr_dev: pointer to structure which stores reset information
+ *
+ * Return: 0 on success or error value on failure
+ */
+static int xpsgtr_get_resets(struct xpsgtr_dev *gtr_dev)
+{
+	char *name;
+	struct reset_control *rst_temp;
+
+	gtr_dev->sata_rst = devm_reset_control_get(gtr_dev->dev, "sata_rst");
+	if (IS_ERR(gtr_dev->sata_rst)) {
+		name = "sata_rst";
+		rst_temp = gtr_dev->sata_rst;
+		goto error;
+	}
+
+	gtr_dev->dp_rst = devm_reset_control_get(gtr_dev->dev, "dp_rst");
+	if (IS_ERR(gtr_dev->dp_rst)) {
+		name = "dp_rst";
+		rst_temp = gtr_dev->dp_rst;
+		goto error;
+	}
+
+	gtr_dev->usb0_crst = devm_reset_control_get(gtr_dev->dev, "usb0_crst");
+	if (IS_ERR(gtr_dev->usb0_crst)) {
+		name = "usb0_crst";
+		rst_temp = gtr_dev->usb0_crst;
+		goto error;
+	}
+
+	gtr_dev->usb1_crst = devm_reset_control_get(gtr_dev->dev, "usb1_crst");
+	if (IS_ERR(gtr_dev->usb1_crst)) {
+		name = "usb1_crst";
+		rst_temp = gtr_dev->usb1_crst;
+		goto error;
+	}
+
+	gtr_dev->usb0_hibrst = devm_reset_control_get(gtr_dev->dev,
+						      "usb0_hibrst");
+	if (IS_ERR(gtr_dev->usb0_hibrst)) {
+		name = "usb0_hibrst";
+		rst_temp = gtr_dev->usb0_hibrst;
+		goto error;
+	}
+
+	gtr_dev->usb1_hibrst = devm_reset_control_get(gtr_dev->dev,
+						      "usb1_hibrst");
+	if (IS_ERR(gtr_dev->usb1_hibrst)) {
+		name = "usb1_hibrst";
+		rst_temp = gtr_dev->usb1_hibrst;
+		goto error;
+	}
+
+	gtr_dev->usb0_apbrst = devm_reset_control_get(gtr_dev->dev,
+						      "usb0_apbrst");
+	if (IS_ERR(gtr_dev->usb0_apbrst)) {
+		name = "usb0_apbrst";
+		rst_temp = gtr_dev->usb0_apbrst;
+		goto error;
+	}
+
+	gtr_dev->usb1_apbrst = devm_reset_control_get(gtr_dev->dev,
+						      "usb1_apbrst");
+	if (IS_ERR(gtr_dev->usb1_apbrst)) {
+		name = "usb1_apbrst";
+		rst_temp = gtr_dev->usb1_apbrst;
+		goto error;
+	}
+
+	gtr_dev->gem0_rst = devm_reset_control_get(gtr_dev->dev, "gem0_rst");
+	if (IS_ERR(gtr_dev->gem0_rst)) {
+		name = "gem0_rst";
+		rst_temp = gtr_dev->gem0_rst;
+		goto error;
+	}
+
+	gtr_dev->gem1_rst = devm_reset_control_get(gtr_dev->dev, "gem1_rst");
+	if (IS_ERR(gtr_dev->gem1_rst)) {
+		name = "gem1_rst";
+		rst_temp = gtr_dev->gem1_rst;
+		goto error;
+	}
+
+	gtr_dev->gem2_rst = devm_reset_control_get(gtr_dev->dev, "gem2_rst");
+	if (IS_ERR(gtr_dev->gem2_rst)) {
+		name = "gem2_rst";
+		rst_temp = gtr_dev->gem2_rst;
+		goto error;
+	}
+
+	gtr_dev->gem3_rst = devm_reset_control_get(gtr_dev->dev, "gem3_rst");
+	if (IS_ERR(gtr_dev->gem3_rst)) {
+		name = "gem3_rst";
+		rst_temp = gtr_dev->gem3_rst;
+		goto error;
+	}
+
+	return 0;
+error:
+	dev_err(gtr_dev->dev, "failed to get %s reset signal\n", name);
+	return PTR_ERR(rst_temp);
+}
+
+/**
+ * xpsgtr_probe - The device probe function for driver initialization.
+ * @pdev: pointer to the platform device structure.
+ *
+ * Return: 0 for success and error value on failure
+ */
+static int xpsgtr_probe(struct platform_device *pdev)
+{
+	struct device_node *child, *np = pdev->dev.of_node;
+	struct xpsgtr_dev *gtr_dev;
+	struct phy_provider *provider;
+	struct phy *phy;
+	struct resource *res;
+	int lanecount, port = 0, index = 0;
+	int err;
+
+	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
+	if (!gtr_dev)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "serdes");
+	gtr_dev->serdes = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gtr_dev->serdes))
+		return PTR_ERR(gtr_dev->serdes);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "siou");
+	gtr_dev->siou = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gtr_dev->siou))
+		return PTR_ERR(gtr_dev->siou);
+
+	lanecount = of_get_child_count(np);
+	if (lanecount > MAX_LANES || lanecount == 0)
+		return -EINVAL;
+
+	gtr_dev->phys = devm_kzalloc(&pdev->dev, sizeof(phy) * lanecount,
+				     GFP_KERNEL);
+	if (!gtr_dev->phys)
+		return -ENOMEM;
+
+	gtr_dev->dev = &pdev->dev;
+	platform_set_drvdata(pdev, gtr_dev);
+	mutex_init(&gtr_dev->gtr_mutex);
+
+	if (of_device_is_compatible(np, "xlnx,zynqmp-psgtr"))
+		gtr_dev->tx_term_fix =
+			of_property_read_bool(np, "xlnx,tx_termination_fix");
+
+	err = xpsgtr_get_resets(gtr_dev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to get resets: %d\n", err);
+		return err;
+	}
+
+	for_each_child_of_node(np, child) {
+		struct xpsgtr_phy *gtr_phy;
+
+		gtr_phy = devm_kzalloc(&pdev->dev, sizeof(*gtr_phy),
+				       GFP_KERNEL);
+		if (!gtr_phy)
+			return -ENOMEM;
+
+		/* Assign lane number to gtr_phy instance */
+		gtr_phy->lane = index;
+
+		/* Disable lane sharing as default */
+		gtr_phy->share_laneclk = -1;
+
+		gtr_dev->phys[port] = gtr_phy;
+		phy = devm_phy_create(&pdev->dev, child, &xpsgtr_phyops);
+		if (IS_ERR(phy)) {
+			dev_err(&pdev->dev, "failed to create PHY\n");
+			return PTR_ERR(phy);
+		}
+		gtr_dev->phys[port]->phy = phy;
+		phy_set_drvdata(phy, gtr_dev->phys[port]);
+		gtr_phy->data = gtr_dev;
+		port++;
+		index++;
+	}
+	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(&pdev->dev, "registering provider failed\n");
+			return PTR_ERR(provider);
+	}
+	return 0;
+}
+
+/**
+ * xpsgtr_suspend - The function for driver suspend.
+ * @dev: pointer to the device structure.
+ *
+ * Return: 0 for success and error value on failure
+ */
+static int xpsgtr_suspend(struct device *dev)
+{
+	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
+
+	if (!gtr_dev)
+		return -EINVAL;
+
+	/* Save the snapshot ICM_CFG registers */
+	gtr_dev->saved_icm_cfg0 = readl(gtr_dev->serdes + ICM_CFG0);
+	gtr_dev->saved_icm_cfg1 = readl(gtr_dev->serdes + ICM_CFG1);
+
+	return 0;
+}
+
+/**
+ * xpsgtr_resume - The function for driver resume.
+ * @dev: pointer to the device structure.
+ *
+ * Return: 0 for success and error value on failure
+ */
+static int xpsgtr_resume(struct device *dev)
+{
+	unsigned int icm_cfg0, icm_cfg1, index;
+	bool skip_phy_init;
+	struct xpsgtr_phy *gtr_phy;
+	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
+
+	if (!gtr_dev)
+		return -EINVAL;
+
+	icm_cfg0 = readl(gtr_dev->serdes + ICM_CFG0);
+	icm_cfg1 = readl(gtr_dev->serdes + ICM_CFG1);
+
+	/* Return if no gt lanes got configured before suspend */
+	if (!gtr_dev->saved_icm_cfg0 && !gtr_dev->saved_icm_cfg1)
+		return 0;
+
+	/* Check if the ICM configurations changed after suspend */
+	if (icm_cfg0 == gtr_dev->saved_icm_cfg0 &&
+	    icm_cfg1 == gtr_dev->saved_icm_cfg1)
+		skip_phy_init = true;
+	else
+		skip_phy_init = false;
+
+	/* This below updates the skip_phy_init for all gtr_phy instances */
+	for (index = 0; index < of_get_child_count(dev->of_node); index++) {
+		gtr_phy = gtr_dev->phys[index];
+		gtr_phy->skip_phy_init = skip_phy_init;
+	}
+
+	return 0;
+}
+
+/* device PM ops */
+static const struct dev_pm_ops xpsgtr_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xpsgtr_suspend, xpsgtr_resume)
+};
+
+/* Match table for of_platform binding */
+static const struct of_device_id xpsgtr_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-psgtr", },
+	{ .compatible = "xlnx,zynqmp-psgtr-v1.1", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xpsgtr_of_match);
+
+static struct platform_driver xpsgtr_driver = {
+	.probe = xpsgtr_probe,
+	.driver = {
+		.name = "xilinx-psgtr",
+		.of_match_table	= xpsgtr_of_match,
+		.pm =  &xpsgtr_pm_ops,
+	},
+};
+
+module_platform_driver(xpsgtr_driver);
+
+MODULE_AUTHOR("Xilinx Inc.");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx ZynqMP High speed Gigabit Transceiver");
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index d16e875..09cc0a6 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -16,5 +16,7 @@
 #define PHY_TYPE_USB2		3
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
+#define PHY_TYPE_DP		6
+#define PHY_TYPE_SGMII		7
 
 #endif /* _DT_BINDINGS_PHY */
diff --git a/include/linux/phy/phy-zynqmp.h b/include/linux/phy/phy-zynqmp.h
new file mode 100644
index 0000000..1a62d9d
--- /dev/null
+++ b/include/linux/phy/phy-zynqmp.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx ZynqMP PHY header
+ *
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ * Author: Anurag Kumar Vulisha <anuragku@xilinx.com>
+ * Author: Hyun Woo Kwon <hyunk@xilinx.com>
+ *
+ */
+
+#ifndef _PHY_ZYNQMP_H_
+#define _PHY_ZYNQMP_H_
+
+#include <linux/phy/phy.h>
+
+#if defined(CONFIG_PHY_XILINX_ZYNQMP)
+void xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl);
+void xpsgtr_margining_factor(struct phy *phy, u8 plvl, u8 vlvl);
+int xpsgtr_wait_pll_lock(struct phy *phy);
+int xpsgtr_usb_crst_assert(struct phy *phy);
+int xpsgtr_usb_crst_release(struct phy *phy);
+#else
+
+static inline int xpsgtr_override_deemph(struct phy *base, u8 plvl, u8 vlvl)
+{
+	return -ENODEV;
+}
+
+static inline int xpsgtr_margining_factor(struct phy *base, u8 plvl, u8 vlvl)
+{
+	return -ENODEV;
+}
+
+extern inline int xpsgtr_wait_pll_lock(struct phy *phy)
+{
+	return -ENODEV;
+}
+
+extern inline int xpsgtr_usb_crst_assert(struct phy *phy)
+{
+	return -ENODEV;
+}
+
+extern inline int xpsgtr_usb_crst_release(struct phy *phy)
+{
+	return -ENODEV;
+}
+
+#endif
+
+#endif /* _PHY_ZYNQMP_H_ */
-- 
2.1.1

