Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF36C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEB321EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pX+N8QE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEB321EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbeHIRLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:11:17 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:32576
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732072AbeHIRLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBDy+dPDhk7dMC5fJxfKCSSEFhvHn7eH+xL7qQffaoE=;
 b=pX+N8QE/PmlFgocncAsLL0khB9fCa59bWXiKp4KCxa8j08KoPcj8i3PUZKcjWaGOfu7SBT0QtCEcejqyXUkzGnAr7GDyZS9cGr/lASSVr+2edd2vyUBTyPwWTgr8FvcJmLpW5TMRvgV0BBRJZ7qvx1oQ8eZpulJFgm/qY7a1KEE=
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Thu, 9 Aug
 2018 14:45:56 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 0/4] Add i.MX8MQ clock driver
Date:   Thu,  9 Aug 2018 17:45:37 +0300
Message-Id: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25)
 To HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fed6c580-a49e-4b74-8467-08d5fe06d16d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1611;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;3:QVDk6diuBn3y4TKjY7HjLS0njAZ9fAf2llOdjF3rKyuSRgHdPwVafgcSIPYVEsKoeYBpSt35SgneDFZE+M7qF2VbeoNwZDL+du9dYaMXow3fWiQCxIVirDIKW2XiJYNcGy4uefVehjyJyHDtl4/iHNTZxmUzlYy+qbkfzcGUqQ85gkPUwyMXdC2kdYZjN0evyGfliI68flya4KVmSXZ9KFaJlj8zmdYBokGx4lLJtBHt8zWkDX9WmE1cq0Ubat+H;25:I9qRbDgds1v/m6EuRYoOondcdezzCc2fxSufGwDPY1QI/lWH6Q0t2dFdlG4DrOWo+XIs25i5v5546E+ZwqlJCGvoM+OODT0eGEiZp5ZL4sV49muA9Vq0gl7qDgRNchaElbymaQdG4Mv4Dq5wtxo8cXwXyjaANZVYp6CgkRZWm1KNjs2I6N8mGKbHnb2aldykR/YfvsnQLO24xRsRr3uxfmuCfXERLIHQRkX+gk1MBwZ3TweoQhU2beeWdWgc07/KypVdQuUCYCc3g3Knq9sl+5UNQH5h0arcWoyZ5owTQ5s0XfzuaS5wPphuSbZ0cT05tBvH4eL2S5/b6CravTVc5g==;31:lA0Q+L9ouo1nXP/sfbGrxGpOeszm0HkdTZe5Zmb96wYZNnwCOE/UFs9vHuNSL3TXQYNSbiA20qbRQ3WufOxTResjMoLPkNCr2iMTdCSBYoHcL35x2HqzYx1luKgso2x/5MioU8gM8xyCVSR+T37gnoC/DUQxpsK9Wqzwhsd6XVTF35Dh4zZI9/3UDJgT9n8W/2NBnwU5aofdMQFwVS6OzgWVPdedBAqqQGYe3IjUcKM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1611:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;20:bQB7WNjTnUx+iR4NGHL3sCDjobBUtSUaoCuxUQ5bC9rMO/NU0Gbz0fdWF5lRp3bKamhqYl2YI6OUT2F7guB8hnfyMUCWjT6LjXuYyXMH1Wh6cwLajY1SVebFsF8c+2M2wgY3LygrCFxbNapV0Y6Y3CMIxE+gfw86b1qJ+MhpOw3Fp2mcUA3SHlmVvt4rAQvBOWvk2mMvXpjeuyaGWFHnjTFiIuhIkcHreIjpclVnZ6CA9ogbkqqrxTMJzKR4+YvAD5kE0HVzoWYuPjo5m30VrlDBZQFr9CR4g1LoKn75yAedpMxhTjMp+oppRGrnPJn63Cj+8k3d8D5eFbvQM8tCXckjoRLtrNwvHiixMVs3eV3msE3Tjoij44EnVbhyXN4dlMaJq0RUjHKHj4L9ZrAAv1fECeBCD/AhZ5+K7X8yLAsyz06qFPT4vOMNQwhPc1nmLn+m7BGz+znK9v704uveXRFmR8HapmiwIC4JinffWifKOOo9xkqIkecF7tcLwxRC;4:9N3wXupB68ImLISgkY4SI6uen0+spKvZDuPTBxRatmlJs8YGwbfxbR099jLN6x6B0LvdkkQDN+3481Oee6RYodM9pYX7Ew3ee57d9KXZ8jF618JfWXIMARMFmXjBLBKKzHMI7bMXVOZlG4nErlCqfxI6el2BguypJWcXB4ORD10X2OEP+wTikCbqA7K2WJ7mPqvZcqk+7WV7EvlEuyIeoCneLN0PeWy3oqMaKpkQh0MeVzARIkwu8l6zIVhRYCNc0o+LgZ2LUcG7VoRtezSWTQ==
X-Microsoft-Antispam-PRVS: <HE1PR04MB1611B9806A6C6D42B54F536CF6250@HE1PR04MB1611.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1611;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1611;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(8936002)(47776003)(50226002)(53936002)(6116002)(81156014)(54906003)(110136005)(81166006)(8676002)(16586007)(5660300001)(68736007)(316002)(7736002)(305945005)(14444005)(6666003)(7416002)(51416003)(66066001)(52116002)(36756003)(3846002)(25786009)(105586002)(97736004)(6506007)(386003)(106356001)(48376002)(6512007)(6306002)(186003)(2906002)(16526019)(26005)(4326008)(966005)(50466002)(478600001)(476003)(44832011)(2616005)(6486002)(956004)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1611;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1611;23:2Zpxsd8c246QnU3/042T51Ge1ADEJjThODaKa1oQP?=
 =?us-ascii?Q?gtWKsV6nxSUhjAUej7KrQaRXTv9x7yYzo29VcjVi+P0/V0avS+IYm1gilT6x?=
 =?us-ascii?Q?+GBC9HX5w9hjNeEovW64chLPREbq4x6aL9uyxyvu2DJnCREYLVvsL76ow5m7?=
 =?us-ascii?Q?9k6S+JHutcVBYuL8nmabQXrjso7yPC6zK98FZt0VMQPb/6P2XcVj0dz0FmdE?=
 =?us-ascii?Q?2ANzJPKs8TdHJwC2RfxZv8b18R9oUfuxkywZhtk9BCUPKPwVYK2O9dLiLcJV?=
 =?us-ascii?Q?Ey0xn9pObO34SvA1nHCekfdoezaLb87fPc49WgNh1iRknxMiOKmHBcGNN6/y?=
 =?us-ascii?Q?PDYKzCXIRBnRslJB20nBlPGoZT6XCQifhK97CDv8YDgx3fR3ypRUSLXr0pBJ?=
 =?us-ascii?Q?vt79/wp8XG4cpdxGWceEveH4GkvzLvDK2awCri7Fx8UY3vq20FMBbMv+K03m?=
 =?us-ascii?Q?kODCoTHUcR8xewrrZRDgL5lgvE6oof27bjllkL535AOUzd9s4xvx+0BJyWmS?=
 =?us-ascii?Q?IIAn0sYPooXTesiRBwy+6AgMQdnK01D8guxyOwpZSV4TX86a5MVIqMC6TUC2?=
 =?us-ascii?Q?Etwk9tZpXV62fnwqThYJ9oYjFKNm/AONpCEsGV3ySzjTVs6qPx3TfOWft+Q8?=
 =?us-ascii?Q?itBNboSittY8a+X9ggTYQhqZQGR/CrXZFeDKQaMKZohNPNaWtxn9HxynKD81?=
 =?us-ascii?Q?UIAgbzLNslUYsgolpglixfuA8OZntZJGf0vmjv+tmLncJifLPq4/rXtIEZnf?=
 =?us-ascii?Q?uRqMr1msUEyLUv3wJ5X5URID+kZSE/Vgz0sPYt5nekQi33lYmbJhcy6uu995?=
 =?us-ascii?Q?2EgPiybvE6AKYCNSuD+JPsvRfVeEp/DbMxmLnmyhnB2M5pdXyICGbhgI6LhU?=
 =?us-ascii?Q?tKnBpEEVXIXdNd0/S2Rbg+SBECnDk5rXG9Od6OCVxQV4JRm5E55XOx9/Efd9?=
 =?us-ascii?Q?+BDKbFpwRO5ix15tebR5GqnfZAjzAyaRoJ1sRlk9NGZM54x31DrjRt9Poogw?=
 =?us-ascii?Q?3Cmf2JIjLfhR197zkQ1aAaEvOAn4HHvi8RjzZeycu5AS9GktxjbjLGrWHUVq?=
 =?us-ascii?Q?dqc3f1fK/7Ulz+tnLqd5IePS91cTc8fs+XFQtpCtpKDLhVKHe4aki0g7sR9i?=
 =?us-ascii?Q?XASuCKpMd/z4PQQPX8ACBxgJ/VSp6X68TZ2o2BrvR7ca22xkpl9DCqtcL2nL?=
 =?us-ascii?Q?BEt8wBrbNcCaJojH657LIPTDrIpzLZhtzu/6VCYzdNzD1MaM/Qql9JpxQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: LwOMnm8N+O8doCmBbq5FF6ldzxe6XUQJHRUUnj9kEIJnetUTxLHnMZYKK7bklKtfWhhjINdzm8UXG0209AsDu8FUS1YT/wtCAJIVSQs5/5efYKa7sFGUSJAJq4OeSaCAl+jmPcLT7Y1erAWebfs/wLZ9ydThTypKvZD/4o/b7ImzFLer445BxPGR/NeQuP+hKq9wkhgQpipL0TZzPH+CeoPQ807JUEhyckb9eHIHqb58G7oVfTybX1BeTrckkEiURst9VJCTweyousYrYnKWxg68sCkOX9XLNrnRvoGk6tvmjEg7M3iRsjodSlI4b6swalcjxbRTqBtYz5rHjlPAMAoC9vO5ZUVFpVuzCu/8WMk=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;6:BC1VjyNylhFajPh19w9B28gYT7YmJtFlYoWOuaNKrfKO3veYadgn4LZhr8wLlaxgvSRoYjIMnn5xge0+5YdtxqPjOnC62GxGDY92jjif2dkKt43Ih9veV3zjst1NXzZL+n8tAdIr0AESP4c04p3J4XOsRXybXZndngTnOOdAhO4BQBCgL+yeo+B3NfRw4S5CcDL8jbIK/V1Iq41YuA//AiS+dlXvXoQZ+2LkfbTLY0yzPGq+f7QaLSkPJ3su1kwq+MSksObsmaZy4Hm6Ra7nV4jgrtBaAVANkGm3vegQnxerFnD/rACqy343yeWKpO2wSRHyM4xzCB2swOfScZC8xOXmYkVEkc/QijrkWt65FRNM3WvuKusBvf7t1BgGDusN3bVHDbfAnskDsB21+l1ntwDlh8kKQ1vLkJNftZlleXO3lJxYB9f3HfDU/iHV7tSCEmGEHhdHzUl9m68dqRoTEw==;5:gL9QZ9p5075RbzobHXSAK4t/qXcHvGoBUone1nTVnVRjFpzUh7g1xSr4Ui5Raw8yKVPWA8EeGxE7t9mpGQGapjGUlf+PkYZIXEcYZKssuwFjttHNYs8ot+bP6RmqVGvmWKA8/XtTxuK0JPox2O8QHy4RiPzTNXglYt0crBMbjXM=;7:GEPxan/EbICZkgHxmsoTZxYamuTzHvpkOmnc6GoRkO1Kui0zScgfMZXF1avE0wFCXwNNiini3wKF2I80jHC/wF+uRBACpB1HOudhVwoXVGtzUpuso1LyiEwT81V1Wp0wrT3JZCGWxswPqOU/7fG0dF7uQ8EUY+/uiEvN70HKgeT9WJUJT49vlWS1WS4lg02tAcMJdaWJE2fm6xdG1EvIYTSL+POq+LvQr3iDg0DiQcpVpMlltC54+tfTbMAGd6/R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 14:45:56.7157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed6c580-a49e-4b74-8467-08d5fe06d16d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically just a resend of the following patchset:

https://www.spinics.net/lists/linux-clk/msg23141.html

I've just updated the patchset and implemented Shawn's
and Aisheng's comments.

I hope I haven't missed any of their comments.

Lucas Stach (4):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: add SCCG PLL type
  clk: imx: add clock driver for i.MX8MQ CCM

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   5 +-
 drivers/clk/imx/clk-frac-pll.c                     | 230 ++++++
 drivers/clk/imx/clk-imx8mq.c                       | 856 +++++++++++++++++++++
 drivers/clk/imx/clk-sccg-pll.c                     | 231 ++++++
 drivers/clk/imx/clk.h                              |  48 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 629 +++++++++++++++
 7 files changed, 2018 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

-- 
2.7.4

