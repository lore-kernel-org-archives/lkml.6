Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A971C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD8920842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L009DoQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD8920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJONOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:14:04 -0400
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:65456
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeJONOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWrBHj5E/kiM/5o3MS/ShoMSIk219+sRT1yXPTUQHCw=;
 b=L009DoQTtbcm0GDxRHrYwvgbUEX48zoOd/sEeEcpn1f2J4bzGQn7V+dKofYNgDti5AoOpDBpHeHD6ezRT5bmrxKoYtAl3Z8uOOI1aFrOXxN66916giNH8j71SYOTyCl6lJN4f0a0CWvtF6/66h4Hwskp5uFj+4Dy8svb0g+BNCA=
Received: from BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26)
 by DM6PR02MB4459.namprd02.prod.outlook.com (2603:10b6:5:29::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.26; Mon, 15 Oct
 2018 05:30:21 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0049.outlook.office365.com
 (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.26 via Frontend
 Transport; Mon, 15 Oct 2018 05:30:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 05:30:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSJ-0004Xs-VA; Sun, 14 Oct 2018 22:30:15 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSE-0001yJ-P2; Sun, 14 Oct 2018 22:30:10 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9F5U0CL014072;
        Sun, 14 Oct 2018 22:30:00 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gBvS3-0001e3-NF; Sun, 14 Oct 2018 22:29:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id DB0B8121624; Mon, 15 Oct 2018 10:59:58 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <olof@lixom.net>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v9 1/6] edac: synopsys: Add error handling for NULL in probe()
Date:   Mon, 15 Oct 2018 10:59:43 +0530
Message-ID: <1539581388-23963-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(7416002)(356004)(6666004)(47776003)(2906002)(486006)(305945005)(44832011)(5660300001)(50466002)(316002)(476003)(426003)(42186006)(126002)(36386004)(36756003)(90966002)(2616005)(2201001)(52956003)(446003)(11346002)(8936002)(103686004)(110136005)(54906003)(63266004)(6266002)(50226002)(336012)(106466001)(106002)(16586007)(26005)(4326008)(478600001)(76176011)(51416003)(48376002)(72206003)(81156014)(8676002)(81166006)(186003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4459;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT032;1:ZZw1TA7AWYEpvU66ralIE3vJFLCQDuGX+QKbUcdCTMEX8fFda/9zOndQYmBGCkdARMahKv8wHPW7Tpm6zamJ+pZ45uyJmQayTz5t3iLB3GQzYUPnBX18NKwuiq4QcEsO
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b5fa18f-7ffe-4c2e-e2f8-08d6325f4c8e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;3:ctDpdWUkjBnMzjXoEiCy/DoDAc3F+0Dua+ZoCxyNmf8Hpqb4/cRSR0fm4jJaAryCmtw/8ZaB1HfXVajGwLDwj1wS8hHl5EwLkhCLX/wHMzFtqvMeZAM2M6hudMIOzMZ+9xtvuQ1mKzF0hy7YQOuKaoLskDtxJHq+YWNapn21M0Yg+b7Li5iDQD09Zc8TmUVPkdJsUs+VGSmLSlQ1NsdR8X37lL1qg1HZ/4s5d/fLeANQSc9Qck5f5JQKvQp/flPIBhKQyVv8E0PAul2+PaSMlYSwJHcPKlLFVe2iRqvqJbqhV9Yo1YfMj7Y5C5Y+whVQIYgZU6RSdqG7oejWzyjP85dVXzC1LSU3vjAo5l6M6yY=;25:N93L09/bu20txDagMZL5116gcyxQwBkx5qfmot0ARRIV8vzWbNipQAAd+xQXYu9qo6+JJtgHdzdDBP42hMw6812GnRbdL0D97zE5HlSqeWK83+BFVxbm02kzYfCRzC2s5Gws2s5SxJBzgbUfw+s92nI3ECarcWKleEF//9rWX50rLg6L2Xdu+hp50GOJyTFJdLyZJZ7lqp7osoGaMXLn+Xp6Q1k15nsoh09eHTHnbIO3v+MNu1CQBSYcdPHphWsxTiO54+kF9EZgT9Ll3BOYCb1TUnj+5OQeicm9mv8U9WeZ/w6BIZfpe4XC+F/RtneoNSen8OLFf3KlhnIKV2PVcg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;31:UKDue5Esczc5vndStTSjNj7vcNW8+zdYftKgdXNILMIKPNk1RqnZMaZoUXZBQXfZ8STcCAMekRx/1musHSdDW319RAsciqVbi6lQNiX9TffVihRe8l1LnJa/fgOk6O1qWFktp+qKCpZqBXhS6XFaUrSDTHC3OzorgCcczUs194i+C/G+9Mo3PK72zBCt9aZzwe+tq25HkRD6ZfIjLNDwonLqox/+TbDB7zTNqkYpMOs=;20:BP+95wCWkuEKaWvpuxltDon8d2VhJJRQ38qfDRsazFwyvTq/Brj+j2KVnLdLDdy9UezlFh22A9VbMjSRh2hBtBITAsuLkFm5NQyTrxLGiLjaW5QdeseOlZHXqywIOebi3ZFIvaCVKnaY7yEVZlzUz9vdFV6R4hg6w5qNdC6KzhZw0m+J0FPKnIS2D796Gju0rdW0xBI+NH4/UcUpVlGuQUzFd/G21t9/AqpaKori2t9KCm0mpqDGxcB5MfwgDDD/YdU1yIrN1nA042WindXHmtH20kMZEvYjAU++dcwGjSCzI2P1nuqxtkGqNoBfRj69tMPn8tb8qhbxTBNSZOCuWSD2fEeqd9m5dmXIUmpZ73vUrMu/bB0o/MYGmyPYMDBPkTjMriiBOggHQGHqPFyYuOoEkBgapz3r1bxjtjr0u6Ngd1PwDYES1YDoiHOJa2kzLZqHyTGq/AYPAJSr5MRQKpCFzCf5F9amSiO5o/6SG5Kreq+VbqJC5qJhqcuXDiq3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44599CDF2DB6F12DE36BB6BAC1FD0@DM6PR02MB4459.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB4459;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;4:7ZzoD2iOSBfG697CN/o2nR5ZIwFPhKDROZQWe4o47/QWNyADptHOU9QpCtD5q6XReS0zWhO+2LHnhOvxyyhy65eOILULTIDZm4QrHoba2O+ZwxFYrOx5ls0AH/yI85/ubgteCzhHwmd3kA/gzVjdwV0o92Opv4kpKYbMT0OUK0rtVEwqomP1yQkAKKGyiV5uvn4kp6X8uoi/EiebOv75luKwYwivRicCYtUjnGirVBXCyUE7krn3AwG8JSSpPGT+4Lco0a0SpaXcZMsVddGH2wVDQ69Y0GWAxjVFznedux/Ob98acR7QraZ8wyba9Eg+
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4459;23:rwy10b14eGJh8YFoxKX44a1DHr/dR7XWT+1kUcCHQ?=
 =?us-ascii?Q?pSv+OTyS7xkORIk1qGpaUXMpnh55/75f9DUka8PMrC+nZQoeydpwXaVFEtjd?=
 =?us-ascii?Q?ABHPiDUy/UiHSW+7VSp6Sc3Eok4CIEFaqoIlIUiG2bWVRJGDk2Ddbu1TGlvw?=
 =?us-ascii?Q?D3XTG+OIVd5gkfio1If0ENjKttLbaMYyEeR4Imxme9iy9dXj6Yz5rqovnOYv?=
 =?us-ascii?Q?aPFwmt3ZjBEEmQS5LTquSw4DmtH41BxU3vmwfIb7y49fj9GNoi7X6Y9DJHPK?=
 =?us-ascii?Q?my2NQB+gkkSwHtxMX2MV3xTmdRoXEONHwRVF094+QFW5eBIThr4+6XS7n44r?=
 =?us-ascii?Q?6MDckt+9s1KLlBTMvxXJcKUEHckDpN+ZWZTlxHLpAxDdblE3nR4YcsMijd3B?=
 =?us-ascii?Q?faowpWfWSsOEB4EGUgp9HKlm+sEm1Xfc3q3wUhrQW2doU3BjZ11WNFLFHzuF?=
 =?us-ascii?Q?V33bKYTodHYMb3FSj+iQBFRUKbEDJQnCNwO1bCnWxcx8Ux9IKodo9P9RbB7A?=
 =?us-ascii?Q?u/CRjJudKOBgbz0CRR/u3AP19OJGN578RbiJ6qlES9U/cGFxeizv9DfppBzU?=
 =?us-ascii?Q?8WjBVliUXlLF4j+xb4c0axfsIahdZSRUqSvC6SioLQk+137yFQA6ZB0JieaI?=
 =?us-ascii?Q?b0pPDhpxx3b3LZZpVJUtMYEhRfr7j/LiC27Hw4+ANGD5D8WesiD9CJpdDZ9M?=
 =?us-ascii?Q?lzt4zcrfd3zj7CMhMmNUYbhX4evG6B0CbGZ+EjHwLt+FIExMXMevNMbneLQA?=
 =?us-ascii?Q?8+CmKuN+FTbVuXTKcOgU8qleXABdz9N3R4PktmlRdDz+XWT2ocJwTsyPhXPe?=
 =?us-ascii?Q?hmvqAeUM4DDTWueUnwWNFdnQEbGNgK9YPMuN0NtuH5E0K52yNdII8GMsCq1O?=
 =?us-ascii?Q?f25mMPKZNX9GddA5Da+LxXOLadOakZY6wkF4MMYdbV/tuKeOIw4o01WVsh9l?=
 =?us-ascii?Q?Z8efg3/LhSdXkHJDkAmCIfWds8PJF0SwCa4V1xx4m5E987kKHoPDxjcd691N?=
 =?us-ascii?Q?6cr1aHpD49azve5X5yOKqNZJzddBxGsXZmNhL2C0wrRCqjD2f0rAg/ZqLPwa?=
 =?us-ascii?Q?Fgw4OId+Y4eKQOPsokpAff7asl8lh6OvjHB2o4K+NvjZhQ2aMqtw6ZctcKb7?=
 =?us-ascii?Q?XpsAo15q5B9dZwsd4NiwJySOaElEECBwfLtfGdt8V9M9uD4qa22+EGZ/y8rq?=
 =?us-ascii?Q?gVo5TFpLqmfwgElUg029TzKmc4ZSnFY4yGwkEDYF4U2AbiZA7AZbeNl2A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: f5fR1ArHtoWMZ6vGSI7eUumIRoIS0PW1mvhm+2mLAYTyK9Aw9fquqc5ItgxBUTkyBcS509xFKJ4JQs484A8Xzl7HnZN0qChGtq4M/wkWmliyJZqXM7D1ewuMypNtDlDAv8xDub3DE8mxvIMs7v8nWs6LL/R55fZLBFZsOVg1s4L+X1BhHDFxUMK5MPx4qTr5Z7Y5GMyI9P2Vh3uFIYJE8wUIAzz2HiE5L2ssxsW5vqM7HQsOaTPN6FdL5kbT+l+UNYpKZ+TgoqySBrqzkPOZMjddERYRewro9jGAuVCNDzSWiXO0qioCV9FfTBY9cylsODzzMNkbakinFtXsJQWXjNz6EdHyLwW5WkxQVcytYe8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;6:9VO8Dgb5o40iMKFJKwrMZBD/t+T5lqPmpSK+aGlPlG4IQqxOGAMkDLvtKgbWQp3PH3QfNIL+lbtWIRjtPHoilLlL0UGTQ91gXyX18UgocqjhffRUWT6BvVMwt34xvN3SOZxgF4um8Kuh5nugkauJ8/tq7MzEjBhnGx0f/aKGHF+caOTRZ63LO5FlVaELs+rQQ6n68/6/KKgxDfpZJyPX8AuPbuNqNHuWiPT5GdxDvifqnUt6S+vqdybg40wgVUSSnozfx2wP/6v0NiZHJ9oAVeOtIX4gqZMuEnM+jRVu5kJ7P3yvM/379hCDXR7Mniq+pFw3ZeHs47p4MDSGcJ0CEKs9UrC1e+cC5XwqhdrI83P1H7cTNgpal9UESjGF8SisUGt45iv4GXAEEds0r9Y6dLnJDf4H5IZ94725XqFq2qEXdQsF+EbjIyaYFx+IHiYiT5ey47/HmFtiq1rUbn99Pw==;5:50B4k0qWGaRqLXb4sWOImSCNti9vAl4LUSd/ccNOVa4Y1ZvLYbCmyeX2PH7bvMfPv6cMNIKFrkJ7Wvo2rUfPApvemQnikyIqFLVnbDPN4E7xxlZCniz9j0ruMTZ6hDyDfFZWZbyMuiA26esXYGpXlreOosbpqiZ1hAHYnJ2yqJU=;7:V9Ehoeo76Wqd9Heq6i0ph3eXdWePuqUnmDgVWdUY4tljylENByWKqvB0UFjGBmPFFFSegDA1d65ibs4FsRQzajSsysXOdrn7DA6miLvk2FXu1sR1u5t6d1VwEv7lDXJyzJi5XNwDPwbNHlN8Veg1p2CCmCJjYTfQZIniAqyvM2Evam4GcC/nkmt+OWhyTfRz3PUYD8KXwxNmWV4NjLPeoQ1zkDJ21elRvi6FBagfMHN0NuK6JzV5RoZjitBcg6zC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:30:16.6905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5fa18f-7ffe-4c2e-e2f8-08d6325f4c8e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of_device_get_match_data() can return NULL in case of
error. Add error handling for the same in probe().

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1c3795d..0005ef3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -477,6 +477,9 @@ static int mc_probe(struct platform_device *pdev)
 		return PTR_ERR(baseaddr);
 
 	p_data = of_device_get_match_data(&pdev->dev);
+	if (!p_data)
+		return -ENODEV;
+
 	if (!p_data->get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
-- 
2.1.1

