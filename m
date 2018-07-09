Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A7C205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1q2grio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A7C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932937AbeGIMXj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:23:39 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:62272
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932445AbeGIMXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm1t/iarBujNv5xt2heWfdIRRF+eFaaCWF9e34xit7A=;
 b=n1q2grioarb0yy++QRy6/spnNbOAVozp3YBW1vTxfG7c4Y+6o8GOtwHa0+q7f0gtPcpD6vpPQh/b5dbxnfD9i2cR9O9G411bnGarAHb+Mjqv8BhpSXUMYfC+ab/1asf67eGSPjV0MBnKI6FO1OAEzBGSiWsa1dFCf6PrlBBIZKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (2603:10a6:208:67::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 12:23:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH v2 0/2] Fix imx6sl display power domain
Date:   Mon,  9 Jul 2018 15:23:00 +0300
Message-Id: <cover.1531138446.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To AM0PR04MB4291.eurprd04.prod.outlook.com
 (2603:10a6:208:67::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e5aec8e-1553-414e-9312-08d5e596c90c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4291;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;3:BdsFqT716FoPD9U24LS+J1W4OXtEw1LpcrdPdAJ+Q/FcNlwdN72u0yG8rC0ETe+2SA7KpRn2thaXLjk1KzueMGCWNG93iaQ1eKWeArD7d2LtoI2Js1sZ9Zc7LYdue+npr1gNF50nSyvaHBIxRZkvaa5J5WstHEy2m5DjbeJyZYN5qnCCgUJ6RilOeXocjfptk2vgZsHqYwsczMdCUJakviFGEqv5xd05N6JYBa5WU+ghgzlqDRaXV3WzIFPNFSFW;25:pD2Uwq4Bj90YdYUMbI+n4RWeg+uP0o+NeJInniRYRydpPMEJKzYD4XJEDa4gl0jDJJFnlcZYjwHlsJX9CXHmgIET50412TVUbARdlDeyj3bt+Fev43KQNFetkpIbA25v6SQ7s622LbfLdr0HDiu3GgfciMcVy++jCjnLbTioGVBVDGYopBtQEBsruO43c3x2wfmlIJBLsztcd/sMJU1STrdQgwppvTP//290kALm8NOXoA1F1DiFd23dgl/ZXEJcDFj+AO8AedZWu6CrQJ+f6owent+nso+wV3lxFXRbydwld5eJTMIMKBvOnCXoJEgc0lYbe5ccxhbvQia7gOylcQ==;31:ypNMIv7I+Ss49+qKPw5JIU7SEoHUA+G9p147Q+EcEemi8qfSWMkFrJIDap6LC8eWS0LyqeFhB250Q/P/ygQrmTs/Bx5TBT9xc5qVB855OFyjDwnvV7P2g++fFv8kIRlUfFaFUXCzeRMQxqq7IdoQ9zh5J1aCkVXcYrl11iGwKvFCRlx0yzkJbVzOsILJ6wSFRzOSJg4izNQpojtPk37Pz/OGyoaf6f7sm1oNBIysrCk=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4291:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;20:AXv5rgo7x9WV9reQdF+ic2AP4YYebsdLK8faDC3XoNGyc7CmDs4HRGxHeyT1BDbHcYyewLnFcTfpLnIFVr87JCBWPTgn6bO8exFLM+oPFHdxiacAoVReWr/fjVoD+zK1XKAHuNzKQF+C2XWW0NXVxYpEAswwn6ZAytFDEWZWplcWzOzVtHrMOfpYfpX3C2Sv+Fagw8OzGUUQ/aXawNgr5TgcEe+TMQNoYhshpSxWjegnk0SM9iFaHguPOpcRz4h59Ul2oi4+XN8VOU54MVUYEWDLmtnIgwXlp8oeME0WHwHF5g2DOv/6DJTq6zQDnJGg88KLxmrw4+bLE9AbiNZ8WKI1EGj04slDXx8Jxw89Duc8cYnL250kyjXYvVjWXsEU2mYwvpfFjZEWRcoP2WQD6MR7Tb7eQdNWNsh16XFdJ9RDhb8OFazalWLevQJtR4p5+xSznna4jBpZ6QgVU1JasYlEDaje4bDVH0LaW+vGZ4zwn7w7HKj3qtcgUrdM1/tN;4:yeqYCKuE98dVg2W4tmneyfD06uVgGYR1WLVgee33kruelGvoyd3lv6cGMYJOPd6f+aPxO7/Hj8pBYmw2xawrUoBwvB72mASsivpmuN+dq3YEx8aMpWyvAqSwL75+Yn46EcCwHD7e1w9uZFyQo1Ong8YVbJhmk9+L72vEZH/z2Dk0OHmwqMYT92VfnOFLsMEg2NmNP5TlP7AIwSISN7f866XPta2poIkbSm2IYh20e6xM6Xj02i1S6WY4Yxm/lImPyV8H4U/ZXw6WQs6vF4o6Nw==
X-Microsoft-Antispam-PRVS: <AM0PR04MB42916C64FE75B194CC3A53B4EE440@AM0PR04MB4291.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4291;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4291;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(47776003)(110136005)(97736004)(6636002)(316002)(106356001)(86362001)(36756003)(105586002)(44832011)(16526019)(3846002)(25786009)(54906003)(186003)(8676002)(6116002)(956004)(51416003)(26005)(52116002)(66066001)(486006)(2616005)(305945005)(476003)(81166006)(81156014)(6666003)(50466002)(16586007)(2906002)(48376002)(8936002)(53936002)(6306002)(6486002)(50226002)(68736007)(7736002)(5660300001)(478600001)(4326008)(6512007)(966005)(386003)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4291;23:OAD+B5jeo0ZNWcMS/JU78X7Y+4KSwdkrpBwJonebM?=
 =?us-ascii?Q?pju7ejPhJf602RLYqI3iayK+fmECts+AW7Fk8VK3MLY/muMmcECyUPJ+P5xp?=
 =?us-ascii?Q?DkUJUOplkybrK8jEExkJB1EbKVZzm3Bvg7TlcC9IvatejNOCHcqbLvyAMS3/?=
 =?us-ascii?Q?Ozi5vgl3jr95yJxIOz8ItKuIvuv6PnvLmAjGunyNAM/95630XSkGjL9n2IQl?=
 =?us-ascii?Q?N+Vsnh+0LkuJafm1o96zOQ6NjyCqnDlzNWRkXswmwV1JbNWSp+AwQAAc7FjI?=
 =?us-ascii?Q?8m3sic1JQ6LjXLIrRc7B5vUAa23a6mrCfgpkJFEEeImFJrn7LhuMMuxfs86i?=
 =?us-ascii?Q?T8PXVOanpI0YUF5kRFVnb9/M+MCMX7HJeng1LBF1E57ukRaX2AiEPP4u9jS0?=
 =?us-ascii?Q?9kpe871WJneMDef/rPcN6pcBtwqAJeAnEyrilrLZe7YhE5e6t+Yfbzlrom4v?=
 =?us-ascii?Q?7LisL5ixh33H8eyvIJtFPMwKDpPUHQ0CXEwReAJ1zVWGORiDretcCDh0ZJjy?=
 =?us-ascii?Q?qHZRMoXa8HqOWV1LNH7lLUX7CX+omsXU6pqleJEm/7iFaQ/Qsm4FPthvlS8h?=
 =?us-ascii?Q?lETlfQB2BoppoMCGdAr8zXc7MHcUFqOeZSoGLcmESTTenLpkd+5erUZYXx49?=
 =?us-ascii?Q?9q+6y+gSXVofk/GUKq4wMtchUxrK+hK04KqQw4nx3QeHSWRoDgzr2YzbGnsc?=
 =?us-ascii?Q?iLXrn4U6pPwasmQk1xGgLgE5hilqWb51YZ+ZU5WgHlNBjvN20lEvyUNwpVvQ?=
 =?us-ascii?Q?db17yBGQYHbu7yWWjoL4q9ItebnfNmThJm5oANoRfeyNxsj3TP132x1NazJ0?=
 =?us-ascii?Q?WXuXOCpkAlkTnXNxg7eJj4/P0Cm9AD0K/uaUD2QRv1UMFgN4TJfrNECuIkfF?=
 =?us-ascii?Q?sNLOjbjJWI5Tn2elOu3Xl2muN8OysAF+/jUF0oqbQEhoUvkyktiuKwkC2wzz?=
 =?us-ascii?Q?ocd6d9D6Yhhi38V5HEhQ25ncodbsja6LMQ0s1qloBA6bHoPqqtQIGjdPazDB?=
 =?us-ascii?Q?/EE4RR1Nhd4q2N1w+Qv25toUAo7qFu6LuK/crqj7pABtx8aR3M2KmdhSrJ86?=
 =?us-ascii?Q?czSChicUOmdm7+0h4sYeXrHU5gNkmyjVKaWbjaLXsRxBhqSU+RakQENMs0Ib?=
 =?us-ascii?Q?mHO9Rs0tojd4fAUHQ4Szm0QOwGU9SLsIXaGcyuPdqUo/fCgmg0UCT8EwwxqJ?=
 =?us-ascii?Q?U4essBN5UQ2oiaf882YIJehmwHIHADD5szfN7XkTOzQPDu7fd0eSbHyNI5H1?=
 =?us-ascii?Q?s+9l40gOK510CTABNg=3D?=
X-Microsoft-Antispam-Message-Info: LnNRWDT7/gwXMTwbtF8cfs3AhxK0CUmFnyjvCPClyxrdtsk7wq8O79+oRu0D0Irs7QjrO9nxKkKyhact3T435mOEc+g4p/grhzUoywl97vLujXrxR/ZlIY7dJlzaLXvDqRmVKn+3kxcuSFgcVD7OKSe9hQtpCJGaugWzpHTOi6QVAZHgC4zoYQi3SIZHbfjFGsLT5edzbJdwi8wIF1+/LcPyQZobBg3VI7OD3LapP2y5UKEWg1WYLlwESjz9r5vUSKDQZio2vvboIZPvfHc4I2oGRrBC8KRUldM33/DF6hECAVuHNjUAVJ4ZD/InVYK8dJIDjLNPE2fGVH4JnouCuX8rdU+1mmPxMR/df9WW7Ds=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;6:qsfRW+wx2YVZ5giRpUpzE4Qh2Ijs8Wd8mjn4Tj2thw3JIFw9y8UrD72UqL3/6v4bdeMvuTQOKT0ksWpfT8ly4sjuXOzY8vq/91KyWsdpk9yquCxWn+GRXs7V/rIFwdZWAcyEiBTTxkET4GhaNHWfXtkmwWesWApj2M1U62BAIAilzChLfHxnbbnYlIYi8y3N7RqV5ODUJjQJbdRnYKEJPWZ05Aks5/sZGwvRhdruHsFh+d2qCpt8TwoblYHc91gbvyFuz0Bx76pwBYBBuCPcfs+cabCZ/tBieVQYeM41kESm0jfykBTuahlkHlfr90tEMtvZBW92c98T1UXRcWm0AREqPcXA9YVr3SR5Y7KRmb/s7V4bkIsaO9wd6hLBotHpxIMrScbWje3b+SwQOKAMaQ6b65B3OdW9nOoh+PkMrQT105qrD3iyYT6VTDuvpBQiiNg5yNjetc2eWmrzv0lqjw==;5:nPLZ1LdLNNOhl+scctuuXqHShVh7wuMIIXSRYINU7VX5XdoAPvMH75fcnduDEsaXTTkjApnbbZ8Zghpb8zNfMWT4oB/8czWUhPjiZLm6hBg44MdyB3wgTvf4S4nDobgf92+JH9eTaVZiF4kV1mwnxdvwxhT3wj1QAShQVHCIuFM=;24:ZRVbnvEc2NCCxJzZuYZMHUkCurzBLh9vI9lBuVkZ1ARPF2p7SIxVVV5XDjB13mYz1DYh2xYBuoSizS2UZMpw8yOua6yBVS5Ysw04Z8S/I6I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;7:ApAOQV/9WpdwBclCsORjJP8S22knTJKcrPPCxEYxCS/VoH3J2px+hS8CKjcJ1njxTyGKtaZQuxMKc6chxF+oiDoup4f9CWd4d3FPmXJFRfqUVkQghhcffQcKQB4oUYtHuekrW+IxQXB/Aknxi6NZchbc91DO4XkKTSAmb6Dghy4HCSLgUGGES+upmQpuOkROwXjFJOAu3M6ayQFjiAnXnhmu8LZvU7/Guh39MhznFNRilADVAr06akJ17OPNuInk
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 12:23:31.6627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5aec8e-1553-414e-9312-08d5e596c90c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the imx6sl display power domain is automatically shut down
during boot so lcd doesn't work at all. This has been broken for a while
with old gpc bindings, since nobody noticed fix by converting to new
bindings.

Link to v1: https://lkml.org/lkml/2018/6/5/689

There is also a nasty errata here, treat it like on 6qp.

Previous version included a patch to improve lcdif power management, but
since ERR006287 effectively disables runtime PM for display it is no
longer strictly required.

This doesn't depend on other GPC patches I sent either, it's an
unrelated fix.

Leonard Crestez (2):
  soc: imx: gpc: Disable 6sl display power gating for ERR006287
  ARM: dts: imx6sl: Convert gpc to new bindings

 arch/arm/boot/dts/imx6sl.dtsi | 36 +++++++++++++++++++++++++++++++----
 drivers/soc/imx/gpc.c         | 10 ++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.17.1

