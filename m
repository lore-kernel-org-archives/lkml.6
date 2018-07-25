Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215EBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A423F20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="q9rqJP9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A423F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeGYK5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:57:53 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:44281
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728649AbeGYK5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry8h/GJ+rMeKOMWsB0K/i3uIZ10SHpHo7S7nSaytG8Y=;
 b=q9rqJP9qcPuSEZQJtCg2iCyGPhUOxD4nbZFhgeJ7K1ro1BMOG1BowJILSoGv+U8SmgIHulv4DNtGVeWXbxdh7ZzNoFxZfPH1tTbLUSbYP+UpoP8GyO7y22guc3YXuzMpBgmPAms9ZMe/l79hx0LvZQmjlOntoed32aUgjPOhSU4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Wed, 25 Jul
 2018 09:45:16 +0000
Date:   Wed, 25 Jul 2018 17:42:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next 0/3] solve SDHCI DWC MSHC 128MB DMA boundary
 limitation
Message-ID: <20180725174235.1ca764cf@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:404:a::30) To CY1PR0301MB1577.namprd03.prod.outlook.com
 (2a01:111:e400:529c::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6022ade-eba3-430b-ce12-08d5f2135448
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1577;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;3:j7Ss4gHffd66sveXWCXdOYHu/c75WshoZlNom3a5ZNv7HPxaUaqDcoRQ7nrp01Tvw8gjbk04Eh8Bj1Lvy0o6JGY65zBvm4xjESG5utiPa4QCzP3AT+LCJ1A5KQzvGkb66XB5KxMz0MCNK/ks/7UXTelVZl48pf/S6buUNKrYzq5xZ52/KDdmBkTpMPuXCk2zWu69MYGJiNMk3EhZvSND+dTPUqgXJDatmkkm8P0bAxhkRO0Cs7/ApdV8Kv9Efh9Y;25:1u3Tqj4sc6QT2VJJ/p6G70isMlwPAc6K5svN02zJChIbnCM2HkBdZR4vNFVw7C8zW08SjWnEWghIAJuo5FbzwBy4oMRJxqsro41hr9GcOC6S7s+6/7/gEx111p4+vjsSx7PHlRHohQ8OJlfEKHRr5LmppC9ELJreJ57Xn/xSqfzvaqCeH23WOo0KWyFlGM6Wi0WTMBxkxjfj2t3ZRAcNKTnsamqL5caGbdYsEjWBcOr9AXi+1OTTZrkvEbJC//8BACu/RCEy40CjHEvhr2obtZqLN0TTHPM68ktDyWRxzZQVhz9aOluv9eVg1oHrYiycROjCcrXP6LMqHr1VsD3egw==;31:6OkRe6NHYEkz71TAYxON9YKjEbi2qIT1pbqnywtOfzCBF44nhcZ78EPFeuZLXG7lB2NuZb4/KL/iK1x+7i9z4NA7gp650J2Se6ugdhfX3vDyQys8BoSBW/dFl43ME8z7d+jTacmTxkijkGlIhT+pSQfTyQDrPEVHDl4LelAqqtb3Pf1vFECuP/rmAWnIPMb6C6LZDh2dK0TaJsaRxQx/3eTeWBxsAXuASEf8owmgEDU=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1577:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;20:vLfeq4a+W1zEPFkLdfw9F7TwBlas1Pwpxx02y1neCENkJWsRYs71fCuhfVBL/9UZEINCdNKr7JwLYS2+AHgm7/igBHu3sidPeJ/LfmapKbrmz+8t9onK3cJDWAvhYiJdEKH/zFT5ZSd/lSpOc+ilNMhjwuIsJDle/S+9jIlMVCZtVkqbFyrS+hM166JYt24OJwS1QgOSUMAtcNQzf8n+qa4TAPWaMyQVoJqddHIYPzjnXNvVlwv7KBIfZ0r3Pfn6KMlvvM+ck3Jo/3EQJ/KaBGLg9MCmxQ8cIZHmG8HRMFRpYuiZtU6qR7SiOyuKUhfwI8ioISRgCaZI1YOnI3ys0wECltCDxLnvNAsIDu+lvKKWoosoqj6f9fBn2pPskdY2sCxH4hQZU3LhsIih5xFVVJYBg3aMfWd2GkB4R7bdIrbrZbFVjWs6xt2Mljc3AIsncht0I0P0oVBBlT/h0htgvHYi8x/uilNhEkxt5OmabjKdSOwjfCegSCDZ+kDU6w7v;4:1OO8wZySmpjQh9oedKar/xtHgGaLeOfyWLWMa+Z1Hzn63Rayo7JVV1SYltAh9OufkyelcX4SYeXzMeoiKl/mD/FgiL7lTgWhv4b7Yht3yDZZGxENmoXiAPG3OtJJdF3zXgxkXJugonuz35UvDovKFcF4/cmZrrgb5J0hUuVVbg41Cfbf/Wo4fi1mxjfSy4K30y0A78g4QM7GROd7EdGihvVVxcjc2xcErQD3xqCO4DmywBg9j3+Ni0+kuTA9El2Y3J7/BHep4K6zjlxWLzDvaA==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB157728069ADD5108DCB25AD2ED540@CY1PR0301MB1577.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0301MB1577;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1577;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(52116002)(8676002)(478600001)(316002)(81156014)(8936002)(7696005)(6116002)(1076002)(230700001)(5660300001)(3846002)(217873002)(6666003)(23726003)(305945005)(81166006)(110136005)(14444005)(47776003)(53936002)(16526019)(66066001)(186003)(68736007)(97736004)(476003)(50226002)(50466002)(4326008)(106356001)(956004)(55016002)(9686003)(2906002)(26005)(25786009)(105586002)(86362001)(7736002)(33896004)(386003)(486006)(6506007)(72206003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1577;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1577;23:4a8zvRh0key63CEo8vVdnNy4n237dzeDZf0mBRR?=
 =?us-ascii?Q?Pi2Luua2siL/ktTSYwP8RifapIx31AuAbokSBHyz2A51u/4ZrKVQ54jNbFKj?=
 =?us-ascii?Q?K4KDv1QslR7+c4teJZxHlE8ZnkG3e89xvv3JIRNetY45Rylb96aeGR1l4W3+?=
 =?us-ascii?Q?fmBj39UYLTFsvt1j3hxsu6nj6glRo1Sa4+YMST97rZofZduM6p2tYGDYH3/q?=
 =?us-ascii?Q?C71OXr/Az0CcSQfkl0norwE72g5EloACbCQFd9zGT15uek/E020AxkCDhfL8?=
 =?us-ascii?Q?TozarJQuxh2GuxMlVYIRURumuzj5PSwFFOdGgN1I4/eYjCLKUIbHX0gUF8iZ?=
 =?us-ascii?Q?zVfvmgduRdsDjeVyvRSWcTpZ+flNwC6xZtpgplrAlyh7I7XStWSFPV/7duNX?=
 =?us-ascii?Q?76qsVltcReIvE2D4CbKYvV2/0DSqpLStq5FdcCBywVZTtn3gX5tuhX+CHjZr?=
 =?us-ascii?Q?VvLIg53uiWiDb1wiwp6Xbx64uoV4ks8FWqTePHJWjF/luQA+08sC3fqc4H0A?=
 =?us-ascii?Q?aBoUpM7VR8iaDpII7YvKHK1YaRyRL2LMiqmrCMK1JbOYKK9zytQiNx1SX0qL?=
 =?us-ascii?Q?6/pyCuB1NA2QaEFkiUhljg1ono9yosB4RfTskA0jekMppvVfPfVy0iZElm3g?=
 =?us-ascii?Q?9aVo5ttvr3/z6ygXp0KzpdUu6Jrw0BrEZqDJf34qmBy8H/DOUssQvTYO7i8f?=
 =?us-ascii?Q?aEbO/eQ/MZT05BsaqUxnL50KMM/V+GQjpsKEzfoEvBiF6zhaykZEXToMULCh?=
 =?us-ascii?Q?YKAqzRuMAyffwwgmU9O2UDmtWDGNy01tzUFSXRc0AaEqsncg5IfMwYpLS1qM?=
 =?us-ascii?Q?Svgz9+VQ7nQcxmSws0AvakiqB7sMb7sDMPsr8GYPk4pHJPqPU55sOpRpePUR?=
 =?us-ascii?Q?6hv6SI1bBLyX5XAHj9vmPNXvDOrQ/X7xHo0flyQfntQlc0x5vpWIP/XfvnM+?=
 =?us-ascii?Q?bp+SCqj6xuaFghlHSzNzgi4r1gTEtVAvnFqcMaKuSC7tJFc9B+OGQA9MDBEy?=
 =?us-ascii?Q?EEoAskUa8zK1W9x6d8K0t2gvoPASaIJBQSguAITC+v7A+vHiKJ2k/4ngj3Up?=
 =?us-ascii?Q?umRwY23C5+5D3p+/ZQ8myCR9S2LAuL3PRDnRzeoD45qg93w/3vrU+WP8MBVF?=
 =?us-ascii?Q?drH9SulickU4+Q3w/x1Dk92iOsdITqQSjDMkhtk9SesXP2rgFrOAdoZcTg98?=
 =?us-ascii?Q?zhTv/IoFVHR019ehVyoGxykXWTmQlEdA3OrgA?=
X-Microsoft-Antispam-Message-Info: 2lT/tsDQImIhS9Aehmg1mXdInUonLjwahIi3FaJo3xZFX3o8YIh3Iz7dMA1yaF6h3lzyPGmCsLp3l/NXpWfRlBe9jEfK+6R+WmDc8Ep0I7q7tZ2Z4fLaIf+iTlpHK+mKJJb8sB79Uv/14vtTxM9+dYa+kQkE4G9Zn/KorspU2d7TC8scU/PLNoWo6FikpK8RNXe8+JYr5L0X1PEgTEN5Edx4Q2DnJVxXx1lKcEXd5GQpZOByu0TISNWkf358k7Sl0rqAEBBAN6KtssAhOqv0MpVlFt4wwQO84mdF6wnL7w+tWt5XUD3ENly9KEiyQadXFeI3LDlyZi18dDSq7OMGF1NrhTacDr+L4Uuq26cUtDE=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;6:ZPDPiLXEEqq6llox3R4/TKPgx8S/uMxYCWPYkppF6bgBPX/8iBltJ4ZVsETMShwm9VI2Xpy9aw7GWonN5R5PGTl4ZUKUNY8XPVPXZmB+a5R31b0F33GhzSaXWKOtbiotMwkL/rUOuFz+QkIxgQUlbkgddKr33510oGw2PjUYuuyGI+kJ4bD8B4KqP7S9BkzJIR8QZT86MOmynrzK7fMLs3izL3qMbTyoqWs2POFQlT0iuyNb8qtH8piA3DufW7Am85lPXptkGIkCuC1QWPNmz/pmQ4Vk2ikqg9ux9JO2kSIiRy4UXKOesosBKySSrzAAvaH1sW/Wt3CHwLvQpClBoNy2PHa0JR7PVF4pAj1VGTsG7kG8P9hxC45NQ3ZdsQjebgD6Kmh1OfRlrbqK7RqqwzswT2+QQ/Qz4/rwxH9yZTz3ceTkJ2sjw62uZpdzbBKFK57AArIIb2JvIZKmzEXVRw==;5:yGmwMrXNQOxPYLKBjumyXKwiXpztSWYtzf4G9VRjk5v0qVbYiKz+mIu+99eOKJ7xrigY67JrkjEmTJCiSc1AsFwID/za1JfT5fV96SqYzoI6cOhkewIJZBkt6nGdes5yK6mq7XFli9XiIKRFpcT80Ek6hWudWgR+ocGMMcyHwSY=;7:/T5EcGjGOL6Zfmbg8dZMy90m3BI2QSiPsedFSYFn+YYxmNvUwuYfDPpRFln5hbnwFl1v9Gg3Mj+igP7TP4yEvW9DyalgeGMo/FYHkcuB23qDZNMSl0m4mgrcanxj8Dt5najkXiXp5FyrzH9vm8He59ddtn7Ht85RMA7VnqocMuXZNVzOU2yYAiAeuel6zu4V+pD9oSMNObQ1V1YZ1w9uXFcuZC1baVQL1wvFR01dbNsAU/I14DadQeoXlpe8/+rW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 09:45:16.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6022ade-eba3-430b-ce12-08d5f2135448
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

patch1 adds adma_table_num to struct sdhci_host so that driver can
control the ADMA table number.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

Jisheng Zhang (3):
  mmc: sdhci: add adma_table_num member to struct sdhci_host
  mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
  mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation

 drivers/mmc/host/sdhci-of-dwcmshc.c | 41 ++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 48 +++++++++++++++++++----------
 drivers/mmc/host/sdhci.h            |  8 +++++
 3 files changed, 81 insertions(+), 16 deletions(-)

-- 
2.18.0

