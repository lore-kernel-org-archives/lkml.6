Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B013C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D270C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zw6gS4K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D270C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934391AbeFRLwF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:52:05 -0400
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:18464
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933645AbeFRLu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynaRtMBBtvQ+gi/s12fxuoSCX6OR38RiJPpygqjAh6o=;
 b=zw6gS4K3ov90LlF/68CJrHsenVgYzo33/3Xt/c5eG/MZwPuNw6Hq8gAlVbHnxMP581KXpv5oh7asbiUtN2DbzgJMhjCJXWiyRitXyXipp+Zt13sVR3DGrc3a+b2xdxr+H00Rzf0JEF+J7/Gfb0gGPx588FKaf6n3Tvj2OT3Jt/g=
Received: from CY4PR02CA0031.namprd02.prod.outlook.com (2603:10b6:903:117::17)
 by DM2PR0201MB0784.namprd02.prod.outlook.com (2a01:111:e400:3c09::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 11:50:26 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR02CA0031.outlook.office365.com
 (2603:10b6:903:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Mon, 18 Jun 2018 11:50:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Mon, 18 Jun 2018 11:50:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36337 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfw-0002ru-Lm; Mon, 18 Jun 2018 04:50:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfr-0000Qd-JA; Mon, 18 Jun 2018 04:50:19 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5IBoD4U006511;
        Mon, 18 Jun 2018 04:50:13 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fUsfk-0000Jt-Vs; Mon, 18 Jun 2018 04:50:13 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 2C988B20955; Mon, 18 Jun 2018 17:20:12 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] net: emaclite: Fix block comments style
Date:   Mon, 18 Jun 2018 17:20:09 +0530
Message-ID: <1529322610-27215-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(39380400002)(376002)(2980300002)(438002)(199004)(189003)(316002)(106002)(356003)(476003)(103686004)(59450400001)(4326008)(426003)(106466001)(305945005)(52956003)(36756003)(2616005)(336012)(76176011)(126002)(11346002)(8936002)(16586007)(81156014)(2201001)(446003)(54906003)(81166006)(110136005)(42186006)(486006)(51416003)(26005)(6266002)(50226002)(8676002)(186003)(6666003)(2906002)(5660300001)(478600001)(7049001)(90966002)(63266004)(50466002)(48376002)(47776003)(36386004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0784;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT041;1:mzzERF300i8Hq6l4hxPF3L1ozuWCGzbCd8rELJ1m5IgxNx4GZSSVpdaSqT1u96iLMwRulwJNDTjmPncQeW3RKLR8cqmPf3otKvp0ZAcprH7hFfrflET8DdlvpSX5zjq/
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2432d758-4ff2-49dd-5752-08d5d511adf0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR0201MB0784;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0784;3:6LhIu+16uI51jENr6cVVWvqf2i40GY0Q4oXySTgf63q7IWZsvMf7vIpMhoQQbL913LV6qWaVtW7ngUr3cj+2A0E3dq6fboLBTUQVIDZyVqjZpLmyUqX4mB9WmwNT40mdIx1pXasulewsv8i1FSXk1E6NT44JZ1NeZpBs2Qd5m7kYGCwbdNHetfKAU2jMIqrRp1+TdXA1Bi6v3CiN46I7zKFTt2iyvo8TUu63FBMM8PVpXrL68EUjq58Qqoz+ArG0v1kx1GFt0DxvkGvr1fG+hFW3YiTHaLvBcGI4Pe3hOyeGeo6TezCYm9YRX+w1Tcvq2hhypMMUAoF0+oYIsV8/R6Vml70dNnitJrAeIfwccec=;25:pvgXOoKBhJ2ZQ6zi6COcchTfeapc3ikqwkUQ3wphx9+6InWbePOnmIQwt+tFHOS2tzI/4/oAarOmO7iOAY9rtyrNvAQJ/Zd2aGWHiyfoDDOGc+VV7202OcXP+5QLKs5gvSJ/6BCv+NqtI5xezCuL4M3xSlK4dRkZFNwyJWXQFuZ1YFltqt4Ur50H6gce8aiYkR/wheIr6uVsp+Fq3SHJOmICPPc42PGt1VEls+HRIy8rRmHW+dIQxdOvI6xISQPDPLylB7bT8V4I7jj2MXnbCOZafvKsh4WGhq358r9R6fRxbxER7DqeVSs6pZIy4Jq/WuycXzd7N4pc/bxlRnGSFG2Dca1WCh7xp1EiDL1Ko2c=
X-MS-TrafficTypeDiagnostic: DM2PR0201MB0784:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0784;31:siE8xkdJS6HKUmMuUp7lraB3Ad643JgOk+RzdOXxQVCNvZccl7YvjbFs7aV5bYVHBIGLb1WyeYL9ImO02tQgdo9wmcEc+jzlCOMj8ZkKqlnt3Lnu+Qa0hDAPw1TNqBkuhpNk4sM6zSsp+raZjygGA9vO+GXAmXVbVRWdLQa1g2PW6XgKgA/8IhdLVHd/bzc6TKVxu0qeYtB/3wZjqlE+3ofImI8yZ/JQmR56YVNfTu0=;20:9UJtLz/rjvi5BKrhbko6+KV3T7C2nTZkSitc/iOcYNZe6zFEkoMgfHdnxMuiApujE/+QUatUOeFMCXu0yVpC81w5DW8ZifhrX1kqVt28/yTZ+S7OCeD2IEbwnLvlnLYTtPVgtYwmqKy4ih7RgCSQgSF0FhTVSCCCx1a0SUg895i2GMPZH9+Hl7xupQlghEXSE3BS2ACEzxnUgqqoDGg/hkx5x49Vitoj71dZZBi0Pdk3PuYAb4Ea03jw0dani4CIkGqEe20xoBwhgft2CutcCnYTD6m6VnUBdEAl/FpAK/8S2j4x7VDxN7ADT3AvtN1Q2ub6pQf4voMmXTL7Np54xiUjV5DiUGnsc9n9oVzuKP+dZ+r7y6TWnAxnUm4SyPFYC/QkNl+c7E8rDJWLXpMslxfpI8OwxeSS6Fv43p/lZ90U+ShYR/PM9wPdqnTt6jJGP4IGtftp2QQHQKdEsWefvV+sUQxAh0pBAE03e32I7A4W+QSYne9+AVZdZ6MNaXa5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR0201MB0784C54B733DC2546B8B93DFC7710@DM2PR0201MB0784.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR0201MB0784;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0784;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0784;4:86nHJbILNg5WsbvioVMpMPTvZXaKcoDd4rqP6UN8asi7/Db40lWtGBjhx7EVtQOXzetv6BUHAoy77EpPOKf62A6dARx27EK+vgBE+9yjAuH4UYE7TKWeM9vWBEmgipNZGDDLQ3DCsCOWnHW2qIoZyEbGSZnJb59PaEg5RkBgO45Edpm8B49Yzf4E1LaCWDX/iCgROrp4fN1XfuObLbYhUxrcN0j44+Xe5oKBkoIlutBdgX48+NR+bhqkaoWMh/GNZC6az1L8uNY0I2JDwULjs/KUz8KKZgxxwT2tjPWZCGEpeBBdWUkRFS7DgazF95Aa
X-Forefront-PRVS: 0707248B64
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0201MB0784;23:ObNF87I7PAi+ZYPqy7hyvtbTcUNc2jhdq8L/ied?=
 =?us-ascii?Q?tzy6ZvtVbagjFB9wykeXeqdY7TqJ0dpGo6BTnp4K1271q0WULojKTOjqaT8s?=
 =?us-ascii?Q?5pfpVs1Sec4jH3R0VjNU3nMYGJTLmcLJvnRTypTKKFJrERQD9jfnBlKs5H5F?=
 =?us-ascii?Q?COO6yGd/boXnOEWvSfB38A0nCYf24jovWbsARnxgx4S0+31sZlTYrJYEPLCT?=
 =?us-ascii?Q?RzVEM6mMGJQ/y3eN/h+oA/AQqRTHNL31JWDXPXBt5MmER0eYPYU9dVJQUTEz?=
 =?us-ascii?Q?AQIbK+oaOn/RvxWnmfKvwZOKdocTNBvqy1elUEUTc+H/juuuSXjA/xE0Cphx?=
 =?us-ascii?Q?meW8RzRzIyIVU0R+5GEuUav/eTIASRc25zCCFkvZm+fBR/M6omH9P5Ht7Rrl?=
 =?us-ascii?Q?KRpHPp5MI4v4kd9ow0eOxV/ZZNQtd7EgzUN5tnkdjZHg/7Ba0S3gfH9JyZrT?=
 =?us-ascii?Q?U8UTaWFznznrPqJrWXx93zHcCMOTtmm7DVr1WGlgqZwFXlFTA7slpXnnykv5?=
 =?us-ascii?Q?WGu4I7cFHZBvwaQ4JoPgNfbkoXJyoKHhnGfMo8FdarV+8E4toTxcGrhXj8o1?=
 =?us-ascii?Q?zSfPdvDkgsQLMytwdy8z0sPUyLFAOToxJySzZsuQYvSips2QjBWPxkTksYzH?=
 =?us-ascii?Q?jfOcnaJzCQX1hhdonHaQqnMgaMY5NJznAoKOlIoYoCk/wcQl1RC/0bKDrgbK?=
 =?us-ascii?Q?UmAxAOvGNQNTjAlVNPTg8Gjy07ziEiTvcWbFQVBq38fxZHfxzyyTjuIqDlMw?=
 =?us-ascii?Q?I6ZuebWLS9D6GrVv7tc/GF9/xwToSbhE7H2N4hEufayco7ThOKxBDmXjQeOm?=
 =?us-ascii?Q?52EFTvkWi+iq3cKXDsoQyZNCsegTs7Y5X40pXNGclTMbtaCEuyaTFqfp3795?=
 =?us-ascii?Q?tEMZxEzZkJ1Dmpwq7ZTXBfLz3baV3Np+AXzBGKZEYJOC5meT6FBr9jb+twW5?=
 =?us-ascii?Q?gTqvjhNzuOSG+HdJFVticcJ0X6ynPo5BFKDJTyzyoGJegotlVjLbYMEDbijy?=
 =?us-ascii?Q?Y8SDhrUJrHcCdbBn9ajetFLK63Zeaw3b1pRC29mG+5XZfoXKtMqWJhykuy6V?=
 =?us-ascii?Q?8CU35Yr8pep2naN1acfVnCvmUDfARtblMv3SOn0Itc8wuv/AKHg+k/A43mdD?=
 =?us-ascii?Q?EOD/0IHs4kX4y2W1wlot/K8T/WdbDCSHj5EvAgV4edV1YAQYh8kGH5I06I6H?=
 =?us-ascii?Q?EekyGew7xJ0vXv/lcFLZCNk2Trmn2hyvhCVSAcAQUNfUHFPfG+LqEP/rEpw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: KEql3GyIf5BXfv7MlCmfaO/gKljmTzEPSTVkWwOfAK0ambR9mUY5k8DhSmfoZnFTE9SA1aVS7u6kCr0uGlQbqEgMDyAKF3/GxmFyNeIHaIbxG7j57De4Ln41Pze7ykiePCNar2oeIk0awDV/W10BH8Kyd/EximobCRuyq4lyCBDvlB+aNUorj0pE0yJK1+/ZsIiOmT+17eCZ2qZvUu7Ktl0dRPQdwjr+OiVn7yVnsM51qy8u34vvqz0u7co7roDVB3yyJXfzrj7xZITtw3x3ivka9I45O13LSa09fNDjfpcNhb+WgXpoLJYZNjghVSP6fVX2TmBDv3fTLc+G8+mYcw==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0784;6:m88hEqI0RPhi4g/ywo6xO0IJw5RwIXpYQVOOcZ50QLRd3xnLZ+euBCd4ADWa33xdbYrn9BbcPD7Wej9WfC6sIN/tH1d4uLeZzx1FBwv1ZT/UqBokVnoQ6COgITOc2I7Fztv6um6oFn+xPrjeD4ksVAEpEC2DjgbrHC08cEObPMhsj6TH+WahQqz4g44SnwTddfNTZJyhJ2fPujB+w80/RvoXpCCCg8icewIQYcpj41Z4t9oIRCw8GncG41FO9iiTVGUze1o4csjfjs3W3OvoAZxQpDzarrH7R1OhgNiNUrWpXsBgRuh6ocek89TQew4o4sWqg27BG0AuvdC/p7g4t3oHxQOuvOWOtdAeqIjtW9P+AwOZOzssUdiNyrQyy6+gLurDdlSdc8vZmsyYYUs6lPo0CnsNEbtBzaiG820vxuK7/OCqUvwA0HejKQBGikhnmAQczfIfUB6VpRq+RGsuIA==;5:ZtV5B+DhymaNDPaYXg7w/WIA0DooRPM846RURomssAkKUOEbjeVLzjQFV3/TAV5QCBtcDLonO1J3K1pqjANO7XQAaDv6fQJs9Uw+Fnwh29OUhPQkWJt6+teiPWn5/9OzKHEABo9xvmK9ciFvlBJXGO1B7jbUB3I1tdgckWS/AaU=;24:Y9OB6+/sCaWrOjFMkqYJ3YTjiGBEJ6JR35LX8G/WHECmNYL41KHD2VbZXOPlGGivjJ9eqiNOLXHqvYFTJwMuTRHpNu5u6lpUwWz90nuzIyw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0784;7:KNBsPIpEr1ig86YSpiwHEECDjKheygdv+0MJ3K3pcJQ7noM3PGojIcKsiz158/WviUGTJHv0IEVwlVO9BnvycJ4dMa+AzKUDEJ9zrvAHa5m8hTiOTw/mSnqtiJNg/18JExcasiCLwsQ0z9WjqMX1ERSI9+MCm4tZPye7PxPIngJng1TS3sj/2OiUb3faxyOuog3q83D5kJoep6oz+rknGUtQ0W3o7IkahddCbBISQfgJwJW/w7UrkHEYIe0Wj4Hi
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:50:24.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2432d758-4ff2-49dd-5752-08d5d511adf0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch warnings-

WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: networking block comments don't use an empty /* line,
use /* Comment

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 34 +++++++++++++++++----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0b41cc5..e8bb7b3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -70,7 +70,8 @@
 #define XEL_TSR_XMIT_IE_MASK	 0x00000008	/* Tx interrupt enable bit */
 #define XEL_TSR_XMIT_ACTIVE_MASK 0x80000000	/* Buffer is active, SW bit
 						 * only. This is not documented
-						 * in the HW spec */
+						 * in the HW spec
+						 */
 
 /* Define for programming the MAC address into the EmacLite */
 #define XEL_TSR_PROG_MAC_ADDR	(XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_PROGRAM_MASK)
@@ -336,7 +337,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 			drvdata->next_tx_buf_to_use ^= XEL_BUFFER_OFFSET;
 	} else if (drvdata->tx_ping_pong != 0) {
 		/* If the expected buffer is full, try the other buffer,
-		 * if it is configured in HW */
+		 * if it is configured in HW
+		 */
 
 		addr = (void __iomem __force *)((u32 __force)addr ^
 						 XEL_BUFFER_OFFSET);
@@ -357,7 +359,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 	/* Update the Tx Status Register to indicate that there is a
 	 * frame to send. Set the XEL_TSR_XMIT_ACTIVE_MASK flag which
 	 * is used by the interrupt handler to check whether a frame
-	 * has been transmitted */
+	 * has been transmitted
+	 */
 	reg_data = xemaclite_readl(addr + XEL_TSR_OFFSET);
 	reg_data |= (XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_XMIT_ACTIVE_MASK);
 	xemaclite_writel(reg_data, addr + XEL_TSR_OFFSET);
@@ -395,7 +398,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		/* The instance is out of sync, try other buffer if other
 		 * buffer is configured, return 0 otherwise. If the instance is
 		 * out of sync, do not update the 'next_rx_buf_to_use' since it
-		 * will correct on subsequent calls */
+		 * will correct on subsequent calls
+		 */
 		if (drvdata->rx_ping_pong != 0)
 			addr = (void __iomem __force *)((u32 __force)addr ^
 							 XEL_BUFFER_OFFSET);
@@ -409,13 +413,15 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			return 0;	/* No data was available */
 	}
 
-	/* Get the protocol type of the ethernet frame that arrived */
+	/* Get the protocol type of the ethernet frame that arrived
+	 */
 	proto_type = ((ntohl(xemaclite_readl(addr + XEL_HEADER_OFFSET +
 			XEL_RXBUFF_OFFSET)) >> XEL_HEADER_SHIFT) &
 			XEL_RPLR_LENGTH_MASK);
 
 	/* Check if received ethernet frame is a raw ethernet frame
-	 * or an IP packet or an ARP packet */
+	 * or an IP packet or an ARP packet
+	 */
 	if (proto_type > ETH_DATA_LEN) {
 
 		if (proto_type == ETH_P_IP) {
@@ -431,7 +437,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			length = XEL_ARP_PACKET_SIZE + ETH_HLEN + ETH_FCS_LEN;
 		else
 			/* Field contains type other than IP or ARP, use max
-			 * frame size and let user parse it */
+			 * frame size and let user parse it
+			 */
 			length = ETH_FRAME_LEN + ETH_FCS_LEN;
 	} else
 		/* Use the length in the frame, plus the header and trailer */
@@ -601,11 +608,11 @@ static void xemaclite_rx_handler(struct net_device *dev)
 		return;
 	}
 
-	/*
-	 * A new skb should have the data halfword aligned, but this code is
+	/* A new skb should have the data halfword aligned, but this code is
 	 * here just in case that isn't true. Calculate how many
 	 * bytes we should reserve to get the data to start on a word
-	 * boundary */
+	 * boundary
+	 */
 	align = BUFFER_ALIGN(skb->data);
 	if (align)
 		skb_reserve(skb, align);
@@ -707,8 +714,8 @@ static int xemaclite_mdio_wait(struct net_local *lp)
 	unsigned long end = jiffies + 2;
 
 	/* wait for the MDIO interface to not be busy or timeout
-	   after some time.
-	*/
+	 * after some time.
+	 */
 	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
 			XEL_MDIOCTRL_MDIOSTS_MASK) {
 		if (time_before_eq(end, jiffies)) {
@@ -1028,7 +1035,8 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
-		 * current transmission is complete */
+		 * current transmission is complete
+		 */
 		netif_stop_queue(dev);
 		lp->deferred_skb = new_skb;
 		/* Take the time stamp now, since we can't do this in an ISR. */
-- 
2.7.4

