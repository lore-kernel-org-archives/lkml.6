Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA32ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59D52064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cUsBx1Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59D52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeGQUdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:55 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:61914
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729754AbeGQUdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6Tqd00q99GCo7Zqz6V0mcAdefcyuAndIi1uNYaDR7M=;
 b=cUsBx1MoIDbQmA0Y+AUKrRDqflgteMlKZfb/rVuQ8K5574uMA9qzdXPT1lwpEDozyKZBuYxHqskds/CtIZ5aFnczHyolBfMnR4F20UzDSdWJPmCQ9Rv9HaDbzipDjTvQxbStGrCc1fo/KJLiRT42572ikeW9H/4HzScd9l0ostw=
Received: from MWHPR02CA0013.namprd02.prod.outlook.com (2603:10b6:300:4b::23)
 by SN1PR0201MB1919.namprd02.prod.outlook.com (2a01:111:e400:5223::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Tue, 17 Jul
 2018 19:59:33 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR02CA0013.outlook.office365.com
 (2603:10b6:300:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59371 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8B-0003Uq-Ur; Tue, 17 Jul 2018 12:59:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW86-0004zI-RC; Tue, 17 Jul 2018 12:59:26 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-6n; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 02/10] firmware: xilinx: Add Zynqmp firmware driver
Date:   Tue, 17 Jul 2018 12:58:59 -0700
Message-ID: <1531857547-16652-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(11346002)(426003)(2906002)(77096007)(6666003)(336012)(446003)(47776003)(26005)(126002)(2616005)(486006)(478600001)(72206003)(7416002)(5660300001)(476003)(51416003)(9786002)(48376002)(50466002)(186003)(356003)(7696005)(76176011)(36756003)(106466001)(81156014)(81166006)(8936002)(8676002)(63266004)(110136005)(4326008)(39060400002)(107886003)(305945005)(54906003)(106002)(2201001)(575784001)(36386004)(50226002)(16586007)(14444005)(316002)(44832011)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1919;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT021;1:S4E1LYN5/awd0THiBgp7Q7cjBl7WX3KAKPp767KM5L3Qj9ENdjjaJf0x86OkylkO39FbemzmBYtKHBYKYAh2eB2aEhKjwhrD52Rv2LhP35c0eRZOAQF0yhhhedlDKhy4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ece0a8c-ce19-47a8-2116-08d5ec1fd0bf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR0201MB1919;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1919;3:eq3yt0RkmQYc37nZWbJJ29u8kL3gLdDmAeS3NzWJn0dlj/fohc8ve3AuhaMN8Gsva954ewnPxWbCgcrs43zJIoLzHRjeieziJl+XQOZxXjCBY7NH75afZsfaDVBSguTqE/jKg2SMfVizSuvxiTcr4FbRKktZwOPIeCfKIkMaW2o+THJRe/WorYmTrpkSe8vKwxaw+LpOXGPxHo8Y0zQBIjsErtMOUnsMhs2YLK2A6Hv7MjNP/wBf4uDuOUA38SGHhAHLHkWLtyCnxGmZnnfDWp43d5K/JSif+3dR4cfsPhwdo62mI2zF57FsFabLPXwO1B/ryPcKakOqPqtdxN+fpQ2DUxtk8RBsRUryMM73yxE=;25:i6LerE2kyKk/3i2ED2q7grRcgUo/lZQK/dh8mtJbSxvCxrULHkvOfX/k1HBjA2JTdrG6uAXWPeG8JARvd9K4ONMBphc67ZqUjLfcRPpqCx3qmnXsYuewL0ARDFfxx8gc9Yc9cwtufviU/r9X6flBjwz9ktYQeFUT0itVpH4+bFgrjDcKItl241i/+WBO13R+O/2C7RrqojcCylkqdAMYVnHB7ufVR5yBTNp2trv46Bwrr345LHhIZVpTdDTKOqCugBTmoRmgePCgviUnu6EsGanM9J+d7BXz8LsrhjdEvKO7zsDzwTOYA0GP+twVh9ylf/jCfXo0h49k1ggyFEzxug==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1919:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1919;31:l+EJLKMbr2Yj/wZCSYaP7qXk58OrdYKSv4gHdVvCKqDpsVZ1BpICswT53dS6uH3x+ANIqXuKzUm3ownvqPUDkpDRGfwDOK2W0TZ2PUvQ+LNMYIN2LEgV/fTj9dNYf1xr1FwY0oN2jNFsGeVVRIhrHFvRegNRqhyxu2ksc9sAc2fauGwq2e4RZD/gJbzky4a6ydkXiZ59jORAcL6W2JRAv1gQsW7CNb71jivEznJqLBQ=;20:4+IOSl5LhD4XY4TVoG2j8ketqxkE8d0MjMNGZx0HPjm2BuB2gQ0mbvzOoyk845jpi5ePZukuRvuOwiuE6mvK0OhGxP6MdY7SBtLGCxtu0d4D4lFRTHCmwDDsMIBy/7IJsG8qWjrFWBG8fFP0PVexcCATTS15M/w0p8oYbCiimChLYuY3fbDknDigOn9FJ92bCOiSA+d//vO63xSqUTWcQZe+/44MdiQc9Z/yxmUUBvObXF3aQmOzM9dbFA+2rhAtgTvZUmv2914cJKZ0zen1ehtn4i4InXeZje/MbkbexEbiUjq0OUlvNoHTaIE7NUYZcdsIP4UV9ck5VZflQJOmQQH+HaKSDssOzEDKI5VT/F/04uJrVgv4TgeKSEA1kvaDcD1Q7P5z3MWCBa+xIb7ft00EfVG0Xf1ChM6mNbJClnTYj5QW6AAnKxzeK1rqnRJwcmDChR1vpZgAXK3U/xVesQqsOWoGpSb6GVWfoXz9AQM9CgodsxF+3tvVPwfNGUjD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB1919E4D187ECD33D4753FF78B85C0@SN1PR0201MB1919.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR0201MB1919;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1919;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1919;4:iypOUK5WDuM8oXKcJGDhbm39nsxJR5eJZHXywY/SMjC4H7Bci1SZhGbppMtloyvpv9upGo6zNbjnRu2UnYbpfJlPSuzQdjOVR2SMzSptcvaFBWtHOKl3cgi/NEajDmfCT3eWwxO4x9Jj3e9E+VJ0Qdhir9cHOp4cMxAOPf9fYqyHAlqtVLn9ynxwEL6wvdw2vQquSuut+iOf1BdYchJYhQw2pEkoaG1d99vPIZupJQQcrHDPbuz74/sK7+3KPH5QYznwzbMtvWM+0BqLgGO7oHIPnZMA03Ak0DJqBpiIXLJfs1MqFM1a8A3ATiIeSgIb
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1919;23:qfjAUFAY6grfya4ZrZgm6DjgaH0i8tkpMBCB5kU?=
 =?us-ascii?Q?7mO7OqQFCPyTiJ1eJH80WE9GB0/Q2pjxosR3GLmAVVSyyCvrGKprwm6KO285?=
 =?us-ascii?Q?aAilp46pyiFfkmOAv91tKUnZdpoUSGhmDevg4NBJ4bKUyjMP3vC5z2rEkfW6?=
 =?us-ascii?Q?jYJHygu0FMLQdnxetKO7V/1ATt2v3JhLunjq6oTmTQcMJWRr52FgTGjscSxD?=
 =?us-ascii?Q?eoQWbJga1cVjn9vmWB56+/FS/ljvEJc3C7wmurrJf9nLQalH7+uVlPT38TDc?=
 =?us-ascii?Q?wlQIjtXsNHGITdI5o6OhgsvYLgzX1n3JerSsGC9Dy/ld+OIL2CpAHvZsNXbH?=
 =?us-ascii?Q?jj7TW9rPC8mpPYmW2UxxYHODqqqLpop1o+K3WUIcMxqM2hvm/z9VZzdEfJRh?=
 =?us-ascii?Q?sVvSDQH7R4rqNw/p2yfldHM43M+43EqQLU5lRZErmbAlBKFcqGuUnF/pfycG?=
 =?us-ascii?Q?4/xZn4bkIoFE7oZzhDP90RZn/ITn8Y0joumg39Ek8Qxwmy4g6aeakkxksbr6?=
 =?us-ascii?Q?aaXGfgBVCNuUZD9N/lDOuJ0k1oFV13SlL2fir/xH0U2eV9CvJtGg43TzdEAc?=
 =?us-ascii?Q?Z2ljCZWNCU3lOmudRSLnEJTnLZCdXMBMKzM6zCULsXZYnhwXak/MS2eR5OMo?=
 =?us-ascii?Q?ZX/3efBgmEgGGlolz9YyBQlQ549y+wwPdkBusYEoT+pJFS19UB0rZja0NTjW?=
 =?us-ascii?Q?biQCMyUZZBUJeWgtuIPHKgJmT82nQMq3RgNM5AJtevJpTyxm2N5unOo/ZQN5?=
 =?us-ascii?Q?nCQ1mePYZJZSuSKoaKSeB3CCH0AnRr9pJcHMqT8pzia2LK+9h3xjsKBaRu7E?=
 =?us-ascii?Q?I83qCMcMqsxbQJOrBODzeWXY025DsWkexY1hx7KWmdSDRaMUui/yINcorBFI?=
 =?us-ascii?Q?h23XDqi7CExN0MzVN7iU+zufcjC0UGNqPYoVHKkX4l7jMv357xFuPnjBoIYe?=
 =?us-ascii?Q?C6p9b2gav6HDNYKmxzOHs3rW2id7WbTUNUSdqEojvMDixrZhDxAgjtr6gvoW?=
 =?us-ascii?Q?Rq64U+EgzsWaeuf4uqj9MqObJ4QAVEnJJrJvlp9tx63o0pt2S0mGmF8RKJTQ?=
 =?us-ascii?Q?NGw+3j46sOC+Zp8YK08DSNjOacYP3HEfOaGhnKu9nUuAtuXRVp1NueXacite?=
 =?us-ascii?Q?Aa+uStZYHxyTv2Ijdjb6BxMccBBQzt84uPDRLoyXOcUp/MsuAQEmGn9OShfe?=
 =?us-ascii?Q?L2Exu9eLV9FlNiZeaAN0sEbpT6wqbsXSO/oV7dpexx2NRy/UPP//KhgselAf?=
 =?us-ascii?Q?EGzeTN2KZq719z7HXR3inlZ975BtLuRuqWizqYuFivmWDh1m8AkDKQ++BKkN?=
 =?us-ascii?Q?OAY+X/P5lkVg6vp3GD0h50CI=3D?=
X-Microsoft-Antispam-Message-Info: DEBi9xu5Qkl5qExEs4e8IDFZrE9hMXXsFUCJcbzeDi16C1g42HXsiGOevIMV5U8fGX7AJTLaN0xb5EtbaUCK0TCMu8riNoAG8q/iWz658/1y0rYEwF2xzuqT905s/9fvcVltJflOLV4NReMzGc30OTnuHrvgKoxjG1ZbXIXpkm6xZsSTxhX3kfVM8TVIyuwgNEepbkfsGHAd6hCTvTIxSPKSYyYzKmHJtYiadIpOULuJ+r8/sb/CL1dmCdZE6/PgTvtqVDbKgA8g/tmn2E/kIg6t17mcEJXzXhBmUuRI3fGOdy9Q8vbJXrii3tcqwq3EtfGxUxI/lcZahfFZUIXthDlq1S4nVP83aBpZTeRO0s4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1919;6:EUuyQFMIHCd9RdmRU2GHLFxK26LFqYNC83AHDxWRjpgG5jqwMbkY5hJEaorfF/YceSJk0147CULaJ6/Dh9A3Sz85hqz88YGyFJbH1wxJt/zahM8S5yQVOXrxlOnz/45Wyj2vd2JwBYrT7JaE2BFQ6UT74XJs03ToOWt5dRPU85c76SiyDkrdTihwpwWk2qUxPMjqUPNclb0YOCI6Hu8CLfcTJI4AhY3Rv86XKXK8TY4eYT8tWvlB1JfWVZDYzjj/6WaiaqVrGq6LlD2cqSl5sMBwoHuK2ikRmjaDU5ZcmuxIvSx4kgaxyLYFu/9QU7UPAbqntJcM/heVmz0KL95nuxpE18hVsgdLYEH5d6xezuDpSUhw4s7oKq4y9I5Kq52LIKQH9IfIuc6okDQ9GWt0ng6E124oHhKiB9xXbA7hPmSyt4BLfd14PqQdhnYXMi05Qje+wEcpTT+piA6HSMqWsQ==;5:uDLq922EX319JzZgPNOgh4qDxVNKR7/3zmIK8puUjNNg1T0NIv4uuFdfdlMg8En1OZ3VVQzAuoDXY15IMrk2alkbibKWX/sa+aV2F2ZhrKKS9Rs/6s77JJr/xJ/DmhqhCqYyaRCGjwCg3TQv4sCOXWCN55exyto+Dw6CB+w2hIw=;24:LSSq9EhERA6O7PpZu1rDuOpd4zTdGLQFG195RREorIscN1B/d70mYk+nMZBSHmxJZ0/b/uyLpgl8Qw4mCA+Ham0BhuVen6Nk1CBGPqB7an8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1919;7:1Ll69qmqwGQVKgH6fNzpd9CFbypml7nkjoptBZYauhlxcE/Y/W2GWjALBKqGS0xUP2ipT9xuWjo6rYq7bhMpudGT+asmGS0HhY+C1biSDjdM/Cateo5195ip6o5G+J/9TJ4l6NfVkz4ilLzmxsymX6a/T9EqYZljXOodjzHPcZzWSy6xRoqQu87PnFTIU4BHUl5AF4MzEenWIJcISRYMia4jPt8lR1WiyaqUeVSqp5SoQBH+2EnU/OClT16OG8dO
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:32.6402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ece0a8c-ce19-47a8-2116-08d5ec1fd0bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 arch/arm64/Kconfig.platforms         |   1 +
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/xilinx/Kconfig      |  16 ++
 drivers/firmware/xilinx/Makefile     |   4 +
 drivers/firmware/xilinx/zynqmp.c     | 337 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  63 +++++++
 7 files changed, 423 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..6454458 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,6 +274,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c7482..f41eb0d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index b248238..f90363e 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..64d976e
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kconfig for Xilinx firmwares
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different
+	  drivers to communicate with the firmware for
+	  various platform management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  If in doubt, say N.
+
+endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..29f7bf2
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
new file mode 100644
index 0000000..edbb84e
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return: corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via SMC call (no hypervisor present).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc() - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
+ *			   caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
+ * PM_API_ID	- Platform Management API ID.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method() - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3.
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return: Pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int zynqmp_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
+
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+};
+module_platform_driver(zynqmp_firmware_driver);
+
+static int __init zynqmp_plat_init(void)
+{
+	int ret;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/*
+	 * We're running on a ZynqMP machine,
+	 * the zynqmp-firmware node is mandatory.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
+	if (!np) {
+		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = get_set_conduit_method(np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	of_node_put(np);
+
+	return ret;
+}
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
new file mode 100644
index 0000000..cb63bed
--- /dev/null
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_H__
+#define __FIRMWARE_ZYNQMP_H__
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	4U
+
+enum pm_api_id {
+	PM_GET_API_VERSION = 1,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+};
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

