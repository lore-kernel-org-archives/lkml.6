Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D43C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD37C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="040xTsnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD37C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeICQeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:34:14 -0400
Received: from mail-eopbgr710083.outbound.protection.outlook.com ([40.107.71.83]:36480
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727570AbeICQeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEHJofi4RJWEUAAr1tooDogPhvywXXNG8nvL/PRl/Cs=;
 b=040xTsnPhoRZQnaNuV8YwJTxhZ6FemTbVj3vKuADOU+sTLR6GuH2sTOmrg1PCc7z2mGAXBH4Hu4YYGOJ8y3jZpdfV5cvMcW62J8GdE/UmqZT5ePBz+z8k8lwsdYMry5Nr1Qejd2Xk5TQl5NF341hW8iKR9UaTGR0x1EXqB2lP38=
Received: from BN7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:20::26)
 by BL2PR02MB499.namprd02.prod.outlook.com (2a01:111:e400:c2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Mon, 3 Sep
 2018 12:14:18 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN7PR02CA0013.outlook.office365.com
 (2603:10b6:408:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Mon, 3 Sep 2018 12:14:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Mon, 3 Sep 2018 12:14:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44662 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fwnkG-00055i-Pk; Mon, 03 Sep 2018 05:14:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fwnkB-00077L-Lg; Mon, 03 Sep 2018 05:14:11 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w83CE8Uw030098;
        Mon, 3 Sep 2018 05:14:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fwnk7-000774-RN; Mon, 03 Sep 2018 05:14:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 0248E6050C; Mon,  3 Sep 2018 17:44:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <vivek.gautam@codeaurora.org>
CC:     <v.anuragkumar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Date:   Mon, 3 Sep 2018 17:44:04 +0530
Message-ID: <1535976844-12494-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535976844-12494-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1535976844-12494-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(36386004)(186003)(4326008)(107886003)(478600001)(6266002)(39060400002)(52956003)(26005)(63266004)(106466001)(47776003)(426003)(103686004)(575784001)(305945005)(11346002)(14444005)(446003)(8676002)(36756003)(8936002)(51416003)(81166006)(6666003)(76176011)(336012)(81156014)(126002)(476003)(2616005)(106002)(16586007)(316002)(486006)(42186006)(110136005)(54906003)(50226002)(2906002)(50466002)(48376002)(90966002)(356003)(5660300001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB499;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT060;1:zKTk+GdvStaXy1ulE9KbaHwI0gUAmB5yf6T4V6Bmo4pR3oDXo661+5Ms4DdbheJa5ccqnKk5GXn4+/zlyWfXEe1AedWmIND/UAIPluBDjFzgePS0MrxlBIuz49aiw8qz
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22599a8b-c770-4e91-25c2-08d61196c5bc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;3:XlTIhV2ZuhYIvvZTOKVsVLLG7zRjwgljy59craxE9xsTvurLFlRYl7fneABqkupdCKXN329mZ9dbb9F8n3RnlJRlS1MOUDF5rXHW7C1s3qU6Ih+SpzetaVqpsnBgAzzdBjxeJwb1XhaqxtfGinzmqU5YZdVLoSu0oXOXLuAOR4nyqCMd904Dafd15/hGcCT7zoZw8kXPwgVkbTxPnj3axMKno6gdp+j9AAKjmOtE8+ufsFAy51BVIEupjasTzVFf8gsD3H2VUMzzymkG2yx1XfMULhTIis+XZQsM9xWWOMv4pin0WmMALwaE8K/UeTsF1AdwbVRzefovrmVXyQ2DuGHzOrKu+eZE7Z237KE4CvY=;25:FdqBrnVqxqdA+IDeaqHmeXwg2v2VqqbBWXUOvgoFFr+H3H2QIv9bdc/dM7atZKwqOZimso15ofNQ6u/+dRk9KuIKy5vJfCV4xe70yrQT192sKlp8S0+pPT0gplLMu5faF2hDRnN7Y11byRZ7F4pajJyRzognAMP7xqYRKK8/honeNFBTnKDAYDd144aVcJoARCbNjxqtL4XekPW9hmaUxVrwCxCXt6YflY2qn8Pg0rZmahUl1CYzzrpKAjEuq/wL10xDoEYVRP9si4Lpazst31j5+gkBP6iNPP2fFmyMhwfxpvffOYG9MrvrQ2nfvV8sFl1XLpTsbPT/7HNZ6Tfg1w==
X-MS-TrafficTypeDiagnostic: BL2PR02MB499:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;31:5WY2UdHEokUEcj7RiefXJ0vXRQW3eDJ+LoBqVlgwBfCuQqnGo/hOIx2WGms4++zpTosOGfi0d9PkLTqK2c/Bxlc5EuWg7v3iCuSfqmW4ib9IdmdQbnjnOVXPfEm91nXKGQPAi1AeORrQd3Ho28WjglPkZy/X5rzKAt6Gn/6PNc6YR4GnMFe5xaWuwiXEQClfWr82R8VEmL8SVCx+U1AvWPVEFWu7UQXkfj86hpmfi8Q=;20:jdJR56zbfEsr4+VOGO9bC2kEiH6eqggOuegHbz8uvihJtgtt77P4lR3MceT1rXL2c5PY2vp+dd8Rq51ddpBR/RV0fP189IbwK8shZADV9TjDKKGZ0Olkjqfa/nhnI8X/gBzZQKjIFVRQx6bWK2lUIUiPDr8AgWqKqdcX4N3cy92oTJEfPudHY+hhbsUESERLbvoMhAzVFqiCWNDvDtnsAzzcrIFZULWe0Qi6NS7vKE4NDBK2eAqYAPYG58GI2ydgjtxREpkpZji8nos9HH8riwVqJvg+VY6WjX8SX67wiVRZsZZWVycqLCpveCBPp6ogRxT99ZF/cS0EtPKRG9HwtMmR5VTjh5mex60BgUpJVnpk1LmSIKQCjR4ObeoJLgv8et/Q/qnMSETp99XzW0zldZ9ltHNi1ecyJPm4Epu+gCtx55xX1noSec1Zir4zkp0U4Ml1P22u4q9Zbm0rzOSRZEJiqDk87u0J44y5CgPOKGgN5rGUZTlPF6kDWeaHSbnb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB49971740FD0A620F12B00E3A70C0@BL2PR02MB499.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BL2PR02MB499;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;4:q66Xg3LqvAb9JXvCbwpCjJRPQf9ppwZBPbcUIBkwvjeI8erWpnJnTvJLyMVl9GasHnLz1xRYl64f738ysEoKQ2+5ZNA6X+039hkbnRSw6LZxsiNSAEfFi5V3U7/SU08jsf+ZtjpvhtAQ+NG1BGDvVl29E/+aClkDnpzX4P/IY2YsVAOSJ+1ZoMeEUKCSvbUIE2qD6kmX+OMDpcdYzmrgEWe+KLXouwUb8HMngHePRGOX6A0cH5WQNzUy3bzFKDBJSmrn+g3UwSa4fhIPemMN0o4psX4fWPbg9ZNkGJ6D+R0gzPYuw4ZksEXF7nYmXBua
X-Forefront-PRVS: 0784C803FD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB499;23:3lxlOGmToHzoQ/Jhb840xcKRmi2NSgrFdFDpmC6k/J?=
 =?us-ascii?Q?iRsKBFfsCy6XzOT8VPCo14g/BfBmwLUQoTc7YbHGvSqrNyY0zSiQrkyqWQiR?=
 =?us-ascii?Q?gzYXiTTXN6r0IZUFSDrc0eujDNZZKK5u6kwl68qSR/4h06nx2Gj1YsG4AdDl?=
 =?us-ascii?Q?w9pifj12OlYqxXkE4EgVYPavfytfe977pOnLspd6hoHq8LuLnTRXRGPBgocK?=
 =?us-ascii?Q?apc5DQUclcOW18L1PtIGeR74O8WJ0NnNgcWjukvopCLIAN5ixdxguh//16h+?=
 =?us-ascii?Q?KA35JkwRx+M6BvkYvy5BaVz2ZTCoQn+4RYCsxetNiVubVDFrAfcfHzLskJF7?=
 =?us-ascii?Q?RGy/T5i066Or/Pb65o86+QdAqNs5lbs0qG3fz7EPI1ihcVsu2DUkdAMN8e3W?=
 =?us-ascii?Q?mUJ/oiWnWmAjIg4CqsX/XNsqzRuFMlsTg6ca4BxXV9FAiNO7bFvVrbeEwhDO?=
 =?us-ascii?Q?hvtuGmJpxG4IYicrQSj72Rqx0U9cSc/An8bhmv2bPBU7gO7FRPzAjwji529M?=
 =?us-ascii?Q?wHoNh2QoqbkteG9V9Bi4quxdk8qCfVHuygxZohaos+ceC4GXtCSQlRHSQ6RF?=
 =?us-ascii?Q?Eohld1mt2MNl2CQIqH6DTjqYUBrAsQWRye1So86tL54daYhXEnrZ842A/0lG?=
 =?us-ascii?Q?jJ9RAymZ1QTW2ppUKwbGX3UpVM/9EutKEui5PNWLfcjzyf6mWfNdlNId3gfR?=
 =?us-ascii?Q?c6Sn2kjOZvwdPPi8/UuV18+Rw8nl03Uxjd/tXpzn1oxsgB9r5N4ZUcubVLF0?=
 =?us-ascii?Q?uLC6sRbr5ZjRNc/zAjiLFCAnSbAB1b3EsLZ+62cfavhmjqmCEpauzsD2NW8T?=
 =?us-ascii?Q?PF9RNByXwE3b1i6XO/zamAhESiDUcr78B58WJm/ZFrHffwkdNKX8WroAUEIc?=
 =?us-ascii?Q?ZKujG7AudoBRxnzdtpv0JtEnl5+0fCVqKE5/mjaOB2REk0xDgA28QLpcX8ai?=
 =?us-ascii?Q?+HKMsl/gQ19xnDFyQpzyWScx0pGj8BbcJnoqGlfhxnf1KVrLRYDm+ujs5jjU?=
 =?us-ascii?Q?GWTd5OokW7Yk+I2tuiupdeArKdqk+8KBFdr+PQ5hA259ZuyEbQ1rJx5vwdXD?=
 =?us-ascii?Q?TynZAnT5XdgTJB6TsxmgGZavXNI8avMhgoagzaXAi9ueb3IL09YZfsSrVFK9?=
 =?us-ascii?Q?tnY/XzVQjXqEo3YFPTV8Af017vGk9xa4yZDPPnC9tgg6MO2rgW6JpFcIj6kh?=
 =?us-ascii?Q?PQSNLYX+daDUzj5xxdOxjhlvyUucCNiGyhLu6GcEmk1DUor7JSPw2fPN2Ll1?=
 =?us-ascii?Q?cOF3ureJjmBKdOm0E=3D?=
X-Microsoft-Antispam-Message-Info: 1cn7TwfXvM8CwoeGp6pTNO5n6ewD0b9PwUlU+uVEVw/VwbAbUD6jePKQ55sYtztYufB7wQg8tdhr9HaPnNRWGJkzI879zJVo+snS2XHKVCCgcbWCSGJX8eRuyIP3h3yRkCd/2EKTfc/6ryrgGNSFuKz0Rhx6QPvDAsAUfjpaGQoJRqpX6++HBCBP088LCfXEh07AG120LFSv/iz03418KH3epkVL2JtQfaWNURZh1lYsR577HolnDkVYv7n51F0HYhINIFSGRB/8rM0Xc0DXKwZUQPT1J4ghuwMkXNfYq96UcV2lOrT4/A4vkjmW22qDcoc6DmP2b6rEwSffLGLq3j4Uir12+jQgQYTw/RtU2h8=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;6:SppKIj7qE/bv3CP/hy2i2+yl7Y65XkCXnQENsETE8uQr/FcDIHutDyqDmG+RX2QbN8Wh7J1iObtoDMRQQmOSbXIPoSHjGRvmXyf7Q5ppNIMWcZnxTDUaq62KsqFLh6t3m/q9W6hVJwDNmaB7IhsUUbHy83TywUrMokwDCshi6j403owPRP3x1wqIdRTzvwHoIKdfwJGmqJPFbCoShauX3XBFny8VkMc7cL6OKX8JzJLolXvyaWrhJVXsS40oS4p7b94x1OLTpRQIDvZI8gC5XtDUk0txH8KMIJEOXKp6OovwZuH5SsDKn0FMlSUDOTPpmk9XFalAuDuPln4i5WGUk0vIixdkwQKaEVkBphogIVYPsaGTIu1cSZX1Iz7rGL0KQWtdT5FxoeTL57bXbq8L3sFdNLp/bhgRVB8cd73EYAT3YlTNiFxcKcvVqhZc+pbGMI24QrEK+QmIvlKl1l8zQw==;5:ShOo/LH75D+ntgQo75jRFCdixdM5+tcY1y54cUyouEvU74KtNbmRlJ5KOBHenDQ2VqVxPU4ReLUyb1r/guPT82glkzlftMpQPCQqayqE68sQAhw4UrBB/mVs4Isver0v8nI28CT8K3rqZXZgEovk440ZboAJt/JGZqCpQN5ocrk=;7:9GBsHha6KX8V+gw+zqQlWfa9FwiOGbuOS2/e2d5OMSHGIt2Wa6C3VJvbvnAO19kPbekur698rvM161WSEU9Gcx2a03dMk6/N+ssY1bxV1dz/nzKvGe7eL9f7uMw8DCeTDJZ2oVMLmHF4gL3Y3XA9q5cXYAyXmS7gLxQgx7SLxigztT53z/6thqLnW1n+UIbPRWOS0EvfWjnTHXNePu9QLxXNBNYuCTeqpU5cX9eKzxy1nl4PNBNNuyDpaKItFaD+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 12:14:17.3149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22599a8b-c770-4e91-25c2-08d61196c5bc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the document describing dt bindings for ZynqMP
phy. ZynqMP SOC has a High Speed Processing System Gigabit
Transceiver which provides PHY capabilties to USB, SATA,
PCIE, Display Port and Ehernet SGMII controllers.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 changes in v2:
	1. None
---
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
new file mode 100644
index 0000000..2eed553
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
@@ -0,0 +1,104 @@
+Xilinx ZynqMP PHY binding
+
+This binding describes a ZynqMP PHY device that is used to control ZynqMP
+High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
+and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
+
+Phy provider node
+=================
+
+Required properties:
+- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
+		  "xlnx,zynqmp-psgtr-v1.1" has "xlnx,tx_termination_fix" removed
+
+- reg           : Address and length of register sets for each device in
+                  "reg-names"
+
+- reg-names     : The names of the register addresses corresponding to the
+		  registers filled in "reg":
+			- serdes: SERDES block register set
+			- siou: SIOU block register set
+
+Optional properties:
+- xlnx,tx_termination_fix : Include this for fixing functional issue with the
+		  TX termination resistance in GT, which can be out of spec for
+		  the XCZU9EG silicon version.
+
+Required nodes	:  A sub-node is required for each lane the controller
+		   provides.
+
+Phy sub-nodes
+=============
+
+Required properties:
+lane0:
+- #phy-cells	: Should be 4
+
+lane1:
+- #phy-cells	: Should be 4
+
+lane2:
+- #phy-cells	: Should be 4
+
+lane3:
+- #phy-cells	: Should be 4
+
+Example:
+	serdes: zynqmp_phy@fd400000 {
+		compatible = "xlnx,zynqmp-psgtr-v1.1";
+		status = "okay";
+		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
+		reg-names = "serdes", "siou";
+
+		lane0: lane@0 {
+			#phy-cells = <4>;
+		};
+		lane1: lane@1 {
+			#phy-cells = <4>;
+		};
+		lane2: lane@2 {
+			#phy-cells = <4>;
+		};
+		lane3: lane@3 {
+			#phy-cells = <4>;
+		};
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type.
+
+phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_NUM LANE_FREQ>;
+
+PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
+CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
+			  or PHY_TYPE_DP or PHY_TYPE_SGMII
+CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
+				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
+				PHY_TYPE_SATA : 0 or 1
+				PHY_TYPE_USB  : 0 or 1
+				PHY_TYPE_DP   : 0 or 1
+				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
+LANE_NUM                = Depends on which lane clock is used as ref clk, can be
+			  0 or 1 or 2 or 3
+LANE_FREQ               = Frequency that controller can operate, can be any of
+			  19.2Mhz,20Mhz,24Mhz,26Mhz,27Mhz,28.4Mhz,40Mhz,52Mhz,
+			  100Mhz,108Mhz,125Mhz,135Mhz,150Mhz
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+	usb@fe200000 {
+		...
+		phys	  = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
+		...
+	};
+
+	ahci@fd0c0000 {
+		...
+		phys	  = <&lane3 PHY_TYPE_SATA 1 1 125000000>;
+		...
+	};
-- 
2.1.1

