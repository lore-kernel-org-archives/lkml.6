Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCED5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E02083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ivLlVpj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2E02083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJYOil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:38:41 -0400
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:5882
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727073AbeJYOik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6pY0H0yayKv2dvYyVvAvsiJJy8lvxdwGvq9bN4fur0=;
 b=ivLlVpj1j3soSuhoaL34Wggu12PeIzlEMcTgWpBDCSCk5PmEdSg7GrUEjQOkWkKvaju1SOI2o46lBNOjh69F40puL8jGRgY0PTbAEmNUn1LZoyXNHEbyzXmkP80meBSuGV7XqzML8Dj5wtATsIdOA46viroYXql9AkGl3fvkpRU=
Received: from BL0PR02CA0095.namprd02.prod.outlook.com (2603:10b6:208:51::36)
 by SN4PR0201MB3520.namprd02.prod.outlook.com (2603:10b6:803:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 06:07:19 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0095.outlook.office365.com
 (2603:10b6:208:51::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 06:07:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 06:07:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYnd-0001HL-LP; Wed, 24 Oct 2018 23:07:17 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYnY-0007nd-Hf; Wed, 24 Oct 2018 23:07:12 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9P67Baf024124;
        Wed, 24 Oct 2018 23:07:11 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gFYnW-0007ks-NF; Wed, 24 Oct 2018 23:07:10 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id B8EBB1216D2; Thu, 25 Oct 2018 11:37:09 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
Date:   Thu, 25 Oct 2018 11:36:55 +0530
Message-ID: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(486006)(36756003)(7416002)(106466001)(63266004)(51416003)(305945005)(47776003)(50226002)(2906002)(103686004)(5660300001)(26005)(72206003)(106002)(966005)(110136005)(42186006)(316002)(6306002)(54906003)(426003)(8676002)(8936002)(81156014)(186003)(81166006)(52956003)(2201001)(50466002)(36386004)(336012)(16586007)(356004)(90966002)(6266002)(6666004)(478600001)(126002)(48376002)(44832011)(4326008)(2616005)(476003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3520;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT062;1:Hu+3LlGG7VeKVvOOHFJKz+FzDdUrjlKaNVHlnaLI1gpPBhcoISIWVRO5M/cVrhZRnMDW1/G0Q1OeA9xn+HBBmSNBACNczYm/cyisLSSM9OJ2mr7Uf9bUhPSMqKgPn2/L
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79057a4b-2092-4d21-8302-08d63a401ebd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;3:cngoT5l9q8KUO17lC/hHIOlt4ozC7s5ZH6Qw2BlafjQ+RDvah6ys8wTFoqtytv2vBw3WiYH4cTPuuX/D6j/VgxvXrnZllrvAmmoiEfd9T+aGDT0IeaO2993JtLXDR3mLgAvpMd3A2hMed+Yq7Mbk90FcygMOmTKuUfsVMIyTRXGTKriix0hARRWCp7R2269gdxIqafx+Au9d6RgoF9GWXZRCvIIhLzGaGrUFVhOFybFaBg1Io4kDVVy+mpvcqXaViy6Ge/7Jju1htPHf+Vxmf675a6SjYwrQovmRjpG+VGPWEK3tN7r5Zjt7FArRpL6Ehsao7JhtCZoqb4FZaKcS59W8nbK5CQBW77TJ/VD+D8k=;25:vhE33z4J6ig3rOenwSNO8zdtIlQ+QGOLs779cjXfvAqJM+ZGm38PMVCtuWR53JizKbP2UVkVX2wI6y7szxt8zaTv3PLH99atkiJVZSWymh9c04VNXXOckLF2WPsdrKI+QQl8Hh8cNCOPwIbwSlWC6PYx8KDsok72d7aoEdxHvX37althIY/XU8wuaqMOZjzC5oH09GlQn281vNylfdg/Cm3XpHk3sjoslKawqN0VfFoO99AskVngJQrmrHYmgvB2Ub0bmtjmcpr+uktPAulMNykU9CkqfvXFZu24wNHJ5PkuDhNHmtJUChV4FO0jMifYP/DZQf0sHOAUOAfOT42rsg==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3520:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;31:EX4VUG6kdX7B65fWeN6vYdL9iaOMEvaPmpNRMrf5t1eWrFW4sW0h5B5QQrLIHHTIU/d2baTzJx7yyQVAApP4kHM80aWeeWzaPVb1f6wKrSLaxS8goXw9r3wOtWxTPR3OZaPmiySOZ/UREvifVxPGSYfjpO2OjsbVGXQT7WcL2U5haIeWg/+XZLAgsWseRKG6+0d08nZEHFf5SnFZWaz9x2xiIFtGZGIYEq7ddH+FqAk=;20:SamMsNDQyr9G0NP/zrie+h5yLfpzBqmliM9lT9M8VjmUBMkYsVATerMeM3tT2Jz/rgDvESwcz+ef4TQUa95wT7ZLL7oDMS+d7q9NTmyCz3qVJ1QZFt9HlCnaxQ6ycKmif5TNjBTldY6PNFKFGlA8nu6oXq74W/OAop0/7XdI6uDWu8VjGnG7Tv0owl2t9Lc+d/15S3ZvOjwjgkB4DjF0I4eXlhQoD54OFdhMKpO3i8j+1apOJy5RX5vAtXP9haSZXAXo5uifUfGyLsq70+TpX1ouLJHY8IPGTiT51aZPyNH/eDm6i7yVBuXM8QxbA8iVGZLEOAKxJFFZ20jXATX4DM8xLilxoJKaPPQRr8xgPEyFV7GH+25+m5yvz+JKsbjhe2T7Osza4/jpzRjJ5LBESLlv75J6scQwzoPolZtZJ2ZkV6B0h/fiQ1h31WLP+D2/3ITiuGtnomUe0ELXyD6Hzk5GoITr9h07NNsgG8NyFxHdukISYK3Dlvo2UZGwP7Ou
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3520A7F24FA5EC61002451EBC1F70@SN4PR0201MB3520.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3520;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;4:d2KyXqqhGFA3+bPWPcgFHDunDvpVUBRRK8q5SR1MOenNuDWEUBsE94RWeJTjhXg6oH2LiQ6Fd9MmV3e1mOP2CvfjCEiviOCUe10ICWcrCQVvciSGgBC0TFyixU18y2WPBfxoXHYj1BC0URNZMYFvGx/1TTYadh71u11o+72FNK4OGkvLTvNt5iwGf57PcX2q6GRnCRZyIjMuRhFOpljj25cbpFyUa0pmg2jQTbb5WRXTuUMQ4k71WYkIvXV741qDgfTO5mUBQlisDYUunLOB+5CwKH8Yjw8iSwGomUbYZDXHfUnZ0qJi0z8M0YAIv520
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3520;23:DW3qLrubUjLkGbazYNSm1K9LOa6l573CCYDxXKb?=
 =?us-ascii?Q?5asCuQuWu+2SdTdT8iWLgiGuBvZ7jmK60ZtBFEwWIW7aue+FOoHJasTuAqD7?=
 =?us-ascii?Q?ilYOjyP7WxBaeBcG3KV+k9vF3/F7A8FCqOpoKrY0cKadOu1e3lC5aMYvm3BT?=
 =?us-ascii?Q?jDQwLyipC4Vp96l8NHsFWKbnY0GCJznTBe0VFEqN6YH32LDuxxGwYPa6wKMp?=
 =?us-ascii?Q?SPxEVAAm1MKTUR2BroIa5eXu0Tf9+jtyXo4GJL7kSYmvl5uf99I98ywEOj7n?=
 =?us-ascii?Q?/CMFpFrJeITnGzf9g2xmbjWoOmmEPK44JXr+joZH9/yIH8t9s/epQ4JS+Zrd?=
 =?us-ascii?Q?cPoaieIkhMdHv1Q9Ofd9JTljMNztNtwA323WMKS8YxzflZbGBgDfF8HBD6NZ?=
 =?us-ascii?Q?DD5cpB+zDAwW0V4mF0TuZay2SR3NAFQY679V/NplM0bpTZ+JKTDmseduvMY8?=
 =?us-ascii?Q?Ai3domfBvU2bSD4jNgGdURsMUSbNRgxrODHeD00TVseD7xvREIvdLEyuVO2p?=
 =?us-ascii?Q?zzXf5I4NWh1Rvt1FCXhfg6OyaPpTGBO/nN4O82AA2zYwbSAqehvQnEdNd76Z?=
 =?us-ascii?Q?0CPRE5HlKP5QofUgGQv/QIxDp6w9d0qi+0pRUSVl/V7vJ8qqAghrIwbc9xuY?=
 =?us-ascii?Q?B39ySEUbYJ1K75mYTTi9ZqXmShQy7wGhWwHJReJd2owYXyb3S0zYFHVohqwb?=
 =?us-ascii?Q?2D1rlVAlLb5kA4j/M0LNOZ6Jx0HetTkjGQLKnAj7g+f6Ded0XWPsZbcewzvq?=
 =?us-ascii?Q?W6VWo3I1BCOs4/M5akZ0tSffVFG2hS3ECVE769h0GxSpsejwkuleQpJe3q+p?=
 =?us-ascii?Q?PKP7l9jYBelr/XQhkUyao3tB4Qs3WRTaj6LKq5BJNBwy0xDyIQ9QY5mYuaDZ?=
 =?us-ascii?Q?ebj6wOisrAXwfR0ebud/gaLHrTerRnvYA/3jjeJvx7S/gZhHWfylFMCQQtBU?=
 =?us-ascii?Q?lRqAtzFINqvhQIEC0IX6/vdmZsiW2/7rl0D4Ek6DkG+00BzjX/zKcD+w4FEO?=
 =?us-ascii?Q?NbGg17+THrKaKN2uElFSIL/Ltndf+OQP55wn2bhfhPVrDR6QEjWDtOuEdsde?=
 =?us-ascii?Q?RwliSJUInkj1Z7QeFCszMQFSmycUQfugyTEVhdA6g+FWAAsI8ykJn/Tq3qfl?=
 =?us-ascii?Q?058bvDQI1pZ/N+1PB10qw0Uy6lFY7KLIy/+OwIABTsNQe6pHL09fQjEwFLYs?=
 =?us-ascii?Q?BujCV6ZM2k0Lmra2zMqng8r4Ed5XAjZm28DX2?=
X-Microsoft-Antispam-Message-Info: BAEFGLwyVHMupMGXA0guqrJNuBtxzG0skDnrzIdKdYpz2/Iryi2gNhIo9gGFEGVCKJrbu0YhzTR6OXfgUvcuz3Mp1MCmt9BbeS+ZULyQ5NE+V7xmGqSmpJYgHvXglkVia9oVZPN2BsV+E4iGLJq3vJtT15zcnl4xw+zeAcy9+5THpXszAL2qBfh4SZxEFcF8JRG91ts/3yq0CVYRu0bHCVMA0nci4aI6uAS5xlH6gY5kgQXDClpM8xWhLj6u7K/yMNo/pUldSd5zFMjQ5ZSZb8sXX6IbskEN3bkG2ok97Wp0ezBi4jd0Z72TRpazMgn/FyYNu0XKjug+fUHHiA9BiX7LFv/hqZ7FQwOneTqlHYI=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;6:Z2X782D4+y4Q9UzJtDxKvrsSLykIdf5rdDOIRL3gYWO2ht3HaKW3iPfBgFV3JTR5IeE1tVB+mrMTOLgi3+0XEvtThGCldx4CEo7t9oz48OOnjCzDOwLO7YlcknqAtoBLqgsjnAoiUh1/VFsZPsdjW3j0mK3s/JeOear8w+XVPFVfPnAplMo34xDc0uTWGKD6CvukX0qh/VniciwQCkEQ19udFhVAKch+bjhWswiDb0663WWzFmxFHXDNXgOOQmzAu/slp2z1G+JbhJz1VHjhLeby06C+lQvWhPdBAPTplUawfDgqGv5GQP96HwaeXjE5GV8uJzi3fO163IHBHvVxuAxwRxYp/SzIw5poe8hTPlgThOt0UX4++EBZmOF1WI6rIyVlO5gHnJtaYJE8UBMwKPaqletgsPgHWTKESnBnE4BsNtdwe5WK06IARN9ebcmKGdpLCMA811I8833jGSXncw==;5:PgtQ3bAqW45wahDd7rSv/dXZICphkbVfUBcDy4M9VgHXbOUSR5yCaCcAnXJygBZIEpUyCl192c3Z6n6S3mEgGoCtqt4yYRSt3KmzYKUt/T7Lm8O3fRemAZuOk6qGrxz6LghYEhxAalqvIWm9+dHnHKAmaL/9G881VTXgY7pfc7M=;7:+xlMyHZLajfcCHBQwAEQf6gBblveO/hAJiqychPXik8HUIghTy+Shk3tuZMs+s7wrFCQqN7p3b0dmbFMFkx5BEOBETOKHE7YX8clF4rL1cyiZi7wScnxTwb+ihXLskd8oKq1nQpCiu+HH97V2rXi4xKfAdtOpaQrruvAB9r4Tvhcr2/Mb5esE3F/7sB3LErWRFsijhC7StumtUN3bmJ0KvFQEl2ribswLoTtYTXnIRep6ngdxY3WBydSqb9bekMe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 06:07:18.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79057a4b-2092-4d21-8302-08d63a401ebd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms. This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Changes in v2:
	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it is
	  a feature of ZynqMP DDRC
	- The Binding Documentation in (2/4) is modified as per the review
	  comments

Changes in v3:
	- The commit message in (2/4) is modified (Synopsys EDAC Driver -->
	  ZynqMP DDRC)

Changes in v4:
	- Updated the commit message in (1/4)
	- Renamed function pointer names removing 'synps_' in (1/4)
	- Shortened unnecessary long lines as per the review comment on (1/4)

Changes in v5:
	- Updated the commit message in (2/4) and (4/4).
	- Removed the unnecessary check for match data in probe() in (1/4)
	- Some Indentation changes for better readability in (1/4) and (3/4)
	- Removed repeated code in (3/4)
	- Used 'zynq' and 'zynqmp' instead of 'synps_enh_edac' in function names

Changes in v6:
	- Splitted the patches according to functionalities
	- Addressed code style comments from v5 review
	- Moved the Error Injection to CONFIG_EDAC_DEBUG mode

Changes in v7:
	- Included DTS patch (6/7) which was missed in v6 patch set

Changes in v8:
	- patch (1/7) from v7 is split in to 3 different logically different patches
		1. functional changes like code cleanup
		2. functions renaming
		3. comments cleanup
	- Added a separate patch (4) for making always successful functions as void
	- Corrected 'Too many parentheses' review comment in patch (5)
	- Corrected comments as per the v7 review feedback
	- Made dedicated functions for IRQ setup, IRQ enable and IRQ disable in patch (8)
	- Addressed review comments in patch (10)

Changes in v9:
	- Added check for return value of of_device_get_match_data() function
	  in (1/6).
	- From v8 the first 5 patches are removed in this series as they are
	  applied on:
		https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/?h=edac-for-4.20-synps
	- Updated Kconfig to check for ARCH_ZYNQMP instead of ARM64

Change in v10:
	- Moved the checking for ce_cnt and ue_cnt before the readl() call
	- Aligned arguments on the opening brace in setup_irq()

Manish Narani (6):
  edac: synopsys: Add error handling for NULL in probe()
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add macro defines for ZynqMP DDRC
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node
  edac: synopsys: Add Error Injection support for ZynqMP DDRC

 .../bindings/memory-controllers/synopsys.txt       |  27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 911 ++++++++++++++++++++-
 4 files changed, 918 insertions(+), 29 deletions(-)

-- 
2.1.1

