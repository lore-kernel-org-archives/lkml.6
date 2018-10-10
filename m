Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631A8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F613214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pxD177G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F613214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJPIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:08:00 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:18219
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeJJPIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyK6fdeFnnNigNXJm1HIVJOfPU2TkwL0lKxlNLedpco=;
 b=pxD177G/T+Ef+gyX4C5cisPj5jUB6i2ABoqAVEM6O+Bj8LjLAKyTxF6XGw9eCWrpDUYTx5nn8G7glLt92VhnpxoioSdj4IqutYe+RWIGDf5NiVeX2Z7SqVW3hmzyHj/U45PMxvcXKKSquLY3D1msAbm8FdnztvaJTJJe6F+0EPI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ro-buh02.nxp.com (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Wed, 10 Oct
 2018 07:46:57 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v11 0/5] Add i.MX8MQ clock driver
Date:   Wed, 10 Oct 2018 10:45:15 +0300
Message-Id: <1539157520-25081-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: CWXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::32) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b551ee1b-88e4-4014-3952-08d62e848ec0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:WoDSzICXwmKAL4o5GowQzN7lpQCuev8nxqXypK3ALZIetIaClNm7ALgbW1oVtAwuf88iDhYRSXy6b15PzsAF6Uq1aKqz0v4Lp9DgKtB6nocJvR+haA7JEOnppvB4Hvy3jBY77Kqe1btTZfdxin6niRqDK7nBJ9HHVJe7LsIjcyIPjgF076MuSVUV888GQ/VQlNsNA8psRprzT1TnJLSbfYIX3FvcgaXkQ+mw2Ti31v6U6Sf5GeyZ9mVLNh7YzHI6;25:uPAu4YPDlKaQdWM+h7KI2gfnTXCyYp8BhqtRENUBgE2zPr2ryWNUzgs0Dq8oZN3hX54h/KV9fyiKRkUfOQF79oXZxS8gzieBBd10Y5x8cc5PuRJBZWv8ixZsZUjmEsUAttGiqguDJXIkXKfSCw44XFWQ03o+BmPeKAbhbSrvSmnnsgjzUrNPXHozkcfAZhNNri6rzzBSrQt/sbvIRGcNDHl5rHZ/mQoGRSapg2lZzBFnjEsU/wIjJaO+cAdzsKUpQPEeyLd/3JM/i1wESAICm6YaCqInitqR9+lcGVlW124wyPp6lPlqhSX7HCa00BbZ/N8H/acfhsL/9q1mGbGF+Dr3tnXFESZ1tSP4AHQRLeI=;31:cYsuVMfF9PsdoyMUeM0tZP1fo498/37HjwgVNjbeHmQPDcliERDg/IXBQ4rscgUmXctiUQYqIfSs1z/FZMILIoOajv4HaLbMvP4mT1dNOzS97tqKW/8SqNU7eIeBgyFqDbcDyW9Y8/hn/pje49fmAlDqNf/uYE3zf9ipC2jMBgaZF8vEQyqQd8Oj80mkWEuA2gLR96sUwCErxeqqlrqowX7wW5s+jG3BSuD7HmQUo9M=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:lKf6zEg+K+MdRJzNkvVxmC+TFLuayUrwhRwr666u+dYYeQwBIqIU5YqI/H3fF9LIHsHDobXX+XCBXuS7YXHKf6XmJKuDUURkJno9occeewkEoU8fuBlmbBHpnIpLSuCzSgbohuN2G6p6vT+jM0rj/l2/7R7eexs9a8OgqqEVTOWCMmOtRWBDYNkNV964+wsWh7HiB3fZPl+hEbDQtYCUTnl/LaMAEJSLGOTl7kciNO/4r8Q9IBiEJglOZ+eKe+Xkd5JKPrzAlA2dFE1shACEuKuXll8qrrtjxFFLA4n4BKlciZPmiWP/ktVfPwSxDeWvPWYo1elVJQSiYjp+/G21U2eEBjokeMsRliAmbH9BcmAhRESdIk7eWTI0W1sCUjHZV7JbYvGw7Wxglgkotf5esq5UEsRFc40+R4GdRGEdvnfsi02gQCmdeJjS13664e3KV1sImldPTSuZGAoQjqDgWjgHGKfFfmNnZjq0DGAdFykdw7ywtikRHARTm4TAxoei;4:RSGqC7YLst8EgSx7PGzPJvRXP4KW7kMjOVxSALM2OHn1Gu19ybF3ubKtvlCDy7BvciJEJNt+WxlYJEe9c79xl3bA0O/XZTvJjHs4mk+vA9MCuuzIYMVcvebMIoeXinyZqqd75jaOT0kd9uAbrjMyceezxEGozHOJ0gQzdW4pcdIm+5mVb7x3zcMfbaTBbnFUXolgZhHwep+hHBZ1wmnun0Jet1CacqRRt5Uvus9rEoNT8+2lUTe6ZqEUBs7/0ePphedAwoFNdaPcEUFFrxgc1Q==
X-Microsoft-Antispam-PRVS: <AM4PR04MB1601B9E39483434DC52057EEF6E00@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 08213D42D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(7696005)(51416003)(52116002)(48376002)(4326008)(6486002)(105586002)(50466002)(25786009)(16586007)(478600001)(86362001)(186003)(386003)(486006)(16526019)(44832011)(97736004)(26005)(14444005)(106356001)(68736007)(2616005)(2906002)(956004)(476003)(47776003)(7416002)(50226002)(66066001)(7736002)(53936002)(81166006)(81156014)(8676002)(110136005)(36756003)(54906003)(316002)(6636002)(6666003)(3846002)(305945005)(8936002)(5660300001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ro-buh02.nxp.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:iTRgqSLtnXlWdztPU5sW6eNChqZ+IWvsk56c1az2q?=
 =?us-ascii?Q?viLxEn8kH8dPs3Ab8C7bp2Kb0ea38iqzCkpt+yQJEGo7wrOKJdvLWWvpt5Cq?=
 =?us-ascii?Q?+ClduNpOriJo7sJqXjqvMMWC4PA53Q/duyTsZ7cZVAdS/pcPpZyNB7YEiQ+I?=
 =?us-ascii?Q?zIi8Rv3M0cw1LT48xGAAH3Ro4cySvSVHO5kjJ0Q1e6/l+OOjo9TZsYaeMaCA?=
 =?us-ascii?Q?wf6yVFdaZ8DwVJXMRO8O4c9BPNINOHuSYuoiZM9AXQmncB12EK+dNSTarVo4?=
 =?us-ascii?Q?63c/SBF19u89mZl72n3084H62/y0gppUZ+u9jVdkT8exn9NN5OGvhYbGmRa3?=
 =?us-ascii?Q?l7rWKXdqDu43UE9XGMsba/RpvFiwp1GBKUuMPgchnynbSlDAG1IQ1f4qJFB9?=
 =?us-ascii?Q?8qSTpBe/Q3O3ZgStiVI642+deGtCvFQ4juHLNzxWoi+2MKDeSL9egRsIyx9q?=
 =?us-ascii?Q?XFG8wIh4qxxLelhwqsG70T0BrknQzZkgq5BCKY0jxkuwQpvkaxCsshSUhIdo?=
 =?us-ascii?Q?zZT3WHfUJJCGrRXDykjPHLKvbLD8KTFWNF1Hmop6wTQbTD5cOvnHjhHBYZvy?=
 =?us-ascii?Q?25TGSy27LhAe0M/2uNH7EPGrP1kltwZ/NjnT/SJAyFNZwHfSx9CHPQYDkxLQ?=
 =?us-ascii?Q?ff8Qy42i9fxnNVaGtt4bSVujz6ErDjDy39fr34ukQhl20mA4DxUgdm3MQELm?=
 =?us-ascii?Q?QxWJ/cV4WEfKpZgcvFNc6IiE9ftCFc8jpU1G2IRPIsddq5+NhMoVggqv42PW?=
 =?us-ascii?Q?hBIz0PewxU+lPTGl4te6BevsdZXuzVu/RwzJqhLBo9uxgIwLBd8EPebdfJJR?=
 =?us-ascii?Q?BSPxeLyQHgPAMfRu+axo7OFU/pkKPVfzJn8HJ2Gs+HaHv5S+40Cuj2ZN212m?=
 =?us-ascii?Q?JIqJK/gzNi+ttacvk6JKgCzfxS8awtKlTy036s0SsnXK8VG1ag/ZpgNzTHbr?=
 =?us-ascii?Q?WSKLVpYpxj1Hu5aFzobEjDRHIFGKKGEFdn9TatBlQ/MQkYwtBwcT9bXB1FaD?=
 =?us-ascii?Q?ArpNZRWloQqRZfkJysGGviR6gOPYXke5vLLOkH8UsTJOvS8J4t0BSVlOsy42?=
 =?us-ascii?Q?Q+gPwrAPbdcf5yXxmwwOvoZrYHfZTi/ypzJTJOAcdml/vj5PlpM+0om7iUMo?=
 =?us-ascii?Q?DqBG7jL9NHmoq5prK9w+3elb2JcSc34yDiVjsQNgWwZZNJU1Zi8hSeDxEkdR?=
 =?us-ascii?Q?oCU5/ytQZQXTs4=3D?=
X-Microsoft-Antispam-Message-Info: tQg73jcIfzb70IufP0GcJn/DWlhbVcm1NclPFHdbKTqutaqZow0ARS9xZc3t7KiK0khi84ntxvfRtkwrvJdkH5WeRbV/FiM4VPsrQ+1ERf/miFM7Nv3WKU4c36eLGyv3aroA0knR9fz0Tn3wKX+LsccGNRfsPhNc4zMLEaY+9PtLRQeraYfl5a1arGt6EU5DWRtMyg/J9t5jTsHPxAmPB+4UdNMoGojxhDp3D+IZQYw0QT2Eqt+Fa2O1yhaaoiktiIeMGVbCCw8B5VW8vQhpgIQUuKHcMlWN58O1dyOj1s2sl/Xc6tbXEZAQJOZU2X/jnEoc8AJh5F5/Vw2Wr/YH+m2mEPeVrrPnp8DtBS0LwqI=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:yMjx+4U/IeXfcE+ihM5coyOzYpsGsfbISyVmk6+VqagYX1ZxSKyJNbVHXSVYlJEJUnI0GInSbkRFdA72elu8G+1oC2klaAr5tBoH8q8Z5EbQVDmP9erAjWgNoLH9VZM9OpLFE11Lc1leXXIilHVYU0TLdbhQkbmlW4+DIS0elSrJS6muTN6pltcPlJTf1SJjNLIzs24kfdfzb6wI7JtI7DcyyWewHPCkx4CDxwulLFpp2Ql7halPkQjMYM8/Ew3JuhotstUYhwAZA1VK2AQbPObtTxaO9n+QHA61Wi4GWAF2BeSA6KMML/AWEZCQIUXBZe+Jn4VP/7W4o9mYCsw5GRPeavA9Y8tZqM5vihqPB5/irk6yp8/7ykcwWRwLYY9Bsy+pMhx95p/mO1SukftfZsE79FMzGvie2ugO2Z89u3DXJo42AkDzIhJr/6ySnqAcow8vv742eoSJueEwITSkpA==;5:F9JtTyiy97c8xXpy91tdKwzX0KHvFaHop8bSfAlufcpsoGfilMKxVnUPCLCkMs9zfSe9NZzwRuNjewKzZrFCsIncx6w+B3j7u/9My56TEs1CZ7Jh+jedv8EigmOvCLR2ATdJHixwhAwgjwIjsNuwwvAC6dnd/3NephhiaNbxq+A=;7:ERdsSRmjjs7B2YHpGkGSc/g2pSh018hElQSjAVb5CoU2/8n56JpkBAfVB8VNHAbKSuhaWIDdAxtQeERlJvD4V3tIKPKTkayIXjDwCuvwU7GO2sJ1dC6YjNJtVJQmWKE7iwEVQmqW0txz9E4uzquntPnIySztt3Wc3wc02hIGw4bJ7IoaKe2vv1TiO5pFluZDPqZNcp5nlzR9zVDYDjDfS3Ati/Z+t0PKfeYCk0hGYgFkmAQ5bjQXpujxlTkQVQ8Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:46:57.3967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b551ee1b-88e4-4014-3952-08d62e848ec0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v10:
 * Renamed everything from imx_clk_composite_8m to imx8m_clk_composite

Abel Vesa (1):
  clk: imx: add imx composite clock

Lucas Stach (4):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: add SCCG PLL type
  clk: imx: add clock driver for i.MX8MQ CCM

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-composite-8m.c                 | 181 +++++++
 drivers/clk/imx/clk-frac-pll.c                     | 215 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 602 +++++++++++++++++++++
 drivers/clk/imx/clk-sccg-pll.c                     | 237 ++++++++
 drivers/clk/imx/clk.h                              |  64 +++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 ++++++++++++++
 8 files changed, 1719 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

-- 
2.7.4

