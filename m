Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F60C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C67208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZAnEKcgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C67208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeHYMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:34:52 -0400
Received: from mail-eopbgr50130.outbound.protection.outlook.com ([40.107.5.130]:53664
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbeHYMew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2XpuqSLsK9LhIb5uTzDwCeIMadHloaP2FWW7uqpLGM=;
 b=ZAnEKcgzvj6m6F2nQV782nKrWDN2klv/PP6PtONeYTw8cBsL4HIozzQF0EEcWNRDK0PxG234rPh60K/nsPJd4l0QClQAIlkCsAiHljhY95aU1PpwbGEmnwBg2o8FtLDfMxVO+2GUigWu94MnxsYoJ36FaqtMlsPJ2dtOBuVw6Zc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Sat, 25 Aug
 2018 08:56:29 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v9 0/4] drm/atmel-hlcdc: bus-width override support
Date:   Sat, 25 Aug 2018 10:56:16 +0200
Message-Id: <20180825085620.10566-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::17) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92b04544-cf44-42dc-74c9-08d60a68a6c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:CMIOW+lj55suK3y3f+oqjyW/acLorlod05HcnDegu5R8QbUwhQv70MQONZwkMNRwFDSVwlbl/k+DvBUJC0TyfHHacYmwiklFGtz9CPY/HbP+G68lR6vqpH90ttQe+ATlMQ9qqRMv9BYNZAQGHku/msDeMG89pAvnYbdYYogRUUzNu8OvuyL5gpbkS8xK7elncPMUlVl0y24e0AGqqUYx8alir4ESHo7iTAwoyceZxIDD/dCv079KTQtC5hq5FIAP;25:v6CBkN39Jc2ZvzxrCmlggfCRbtFfszHxIUUEcntOFeOXy+A8gRL4aDAQFwiH/dKvzX2MiOkNXRQBVB4lP4C94w3n5x4HfK7m0dQpN/RXYqIHcLZN/Mtcq+C3ss6WtaDOz8PFFTi7dQwwVEHIDz4NT9G5EVy/v0XlCHhJV3hHlyYngGO6X6fMkfb10TpRLHxkyuau4Napovxk5ubH1iQekNk3Ti1HSvwdWG7vDQIFxOTUpb0z3GHkP/32FEgNGvvNulahwAYVPDmu9Q35JiHSsLosWs5AS6SvXPPYjFlPvIpMRHbC7kfOpchjaXVUJUWWWpMtboFdO9Ww1lyv6fankQ==;31:KJ1m4AcUxCUdYV9NFlA8oSJEh5rXbt5v73oDB3b1bK8+vLQj49ey9cA3+UxPtYPpEJBxaQKgI4d/8urqf+7f+4yBIjHBPGlC3PtrmzYPL0TpWHLmAOYs8IstyrDDpLVcyv1Q/VdPwc2/XAxUWTj2EIM9/iBba761TilvlVfa9qiz4OQUUNzQqdrU1K23CnZT0rA1YWXJj9aKpevvaVO07FreVpgIa8kX782pnDoL4Yg=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463A201ABB9B3AF66B3E8BCBC350@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:QnAIYC09hXbAP63jxVk5go6ypURlNdt0EIfkWFxxlw/MiTi/HKG+mkrJTGuIuzDchM3hNip1w0ppjfL3LIhVYuAwpMEjaWPicMUytn7bHPo9M9eMasK35BWeBevgN/ta8vq2eknIbuFDhUx4cP+wWnWE8kFmyrKKBuLhWuGNPwrfWOX9igj7PVOt7LeWBGvyNKvWeffvSRhqqC26X8/sXNY8st0UtoiyX3VfXqEJhOa2v6dkzEBdR/RAV/S4XqDZGK9NeSN6/xzhBXo5BsREUg==
X-Forefront-PRVS: 0775716B9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39830400003)(199004)(189003)(52116002)(54906003)(105586002)(50226002)(478600001)(476003)(2616005)(2351001)(956004)(106356001)(316002)(16586007)(74482002)(966005)(486006)(6666003)(6916009)(81166006)(81156014)(8936002)(8676002)(7736002)(7416002)(5660300001)(2361001)(305945005)(97736004)(386003)(186003)(68736007)(26005)(6506007)(16526019)(47776003)(50466002)(51416003)(6306002)(6512007)(66066001)(48376002)(2906002)(53936002)(3846002)(6116002)(25786009)(36756003)(86362001)(4326008)(6486002)(14444005)(1076002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2463;23:xwfpCqt+/rs6sDAoV68WIg5ddgCsS1p5MtK1D14?=
 =?us-ascii?Q?4WnVOTbkT/sfdg/FKEEsWsPWqMg58FNw10svRClia+wUgpCtyqSf7BAMabcs?=
 =?us-ascii?Q?TSaYqxBrzDkrcVmadK3gf2KmxyYkRtJBiaicsa05MFQbvuROpJoqEL8PalqW?=
 =?us-ascii?Q?HMS5a/XoLLs0t6R1EdgHleEH0h/Gl1mGhM7LKxvF2GF7nl3Dwd0WPMr+RofJ?=
 =?us-ascii?Q?HZU5cjovwfn55MiMH5smqcbOH2v8ouWFjK8x8wssWhc1UBBn3FJEUDDaS1ro?=
 =?us-ascii?Q?C/vGNfO5TjD33LiZFemcY3tXqBOpVcVExCyGz8upIFjZIttwqsim685qaVYo?=
 =?us-ascii?Q?Vr4Oc/Bqe636YobITc+t+YslQmpAYXHLkplm9ZzAwKDhaocauFwPBApGePcU?=
 =?us-ascii?Q?XcaV5n/SGPqNGMXf17Qj2T0v5K+T9kLuhMmOfMSfRjjI1w5tvF+QWHuQeNTD?=
 =?us-ascii?Q?ZSl6Yz8da89dC2qE/f67W5LIRgC8uZMk9s7odv/6yNZszdIgqDDWI5yc95g+?=
 =?us-ascii?Q?axae4PUXY3aT5PDNXrxZVO/jjwxxtAjZWs9jl4jMv+soI0SCGOi6yd3Js+z1?=
 =?us-ascii?Q?vNpx8Z9V65oC00kplXMh3+Pmev2uLpcj0u77gmjnmd6zGTugApn0qIyvO/8r?=
 =?us-ascii?Q?DkuVyM0bPPsudiOs/oAfd6NzooHEApPG95mf3zsqQmgGHG38QJLKXAjI+D74?=
 =?us-ascii?Q?aV7Mdqkm+6bSFhOn94UtxJg+hKUg18RzluRtc2mcy8up1J7cRk/etOu+VFt9?=
 =?us-ascii?Q?qOUMD92MgONt23o3EfuDZCKybOKnsZNhG+YQMKbMQrWDNq4FaCSazlyEu2Lv?=
 =?us-ascii?Q?6gddba5/RDkR+XBGxA5xH+F/n0FS+fUZ9dPAZdee5Lbj5NgFNEoxnNGOUrzm?=
 =?us-ascii?Q?R2tAWJK2bOzIuXCbAbVFLexM5eu03yzEu2NH5eoNea4tXFRY9tNQ+lEkIVsj?=
 =?us-ascii?Q?aA7wUQyYvwI/asfU6lCIznVRx5kQajYH/Qyf9WaCIaY0wasuv+0Axg85Diao?=
 =?us-ascii?Q?x0gc7SFZtPLqlsVEXtqgmTy9enCvD0OdZFJVBvq8vjMDEz6k8LzT0D66e5b6?=
 =?us-ascii?Q?KnYmbKUzpW+q1nbxEKtbPoOVFmRlU1CImTOAbqIa8lY6P50XKbLTnqJ6cSvK?=
 =?us-ascii?Q?HKPMJEuiBL9UV9T2V3f819T4OKR2X2sCn86V89YqZfG5kHQJzXY6acDrzbOA?=
 =?us-ascii?Q?A8wMYRBDL17yf6/CojdI0yxfRTkT8nLapo+DKo/57tAk/HpnE1KUjigERZ1u?=
 =?us-ascii?Q?cqJm4EYP3cA58aMp28/0kvkesDMfXspXr6ODvq1o/TiaHovZJ0uP964FJ+Sd?=
 =?us-ascii?Q?2cU+2eFWiMmkiYSIuDBIoW6Y=3D?=
X-Microsoft-Antispam-Message-Info: P8gumnWiiGR9AvlEpl8MwrKu5I2dnar4Vql8fjL9lGqD3tHZNGGdRW2StggCkbzEul293TpPFk9R3qWRxDLzZ+dxoJsNR41Qv0+mmMVv0pLptBWz/+RXXKG19v9erg6jofapiWZjChjYxtdXwC+La0NmTdxdpmC1dQlcLF8CuvJG03sqNgzjjwmL9CFALFmJ1uh0qMXGSzONMsRaYHOc5XDMCCctBoFeQPqljMSY+my2VzgiT1zutgnEV8kPZ1fDo6O8+t0ODnLVeCZTPRE/QBRRdXlkv0MeV37HOt4juzyzBT+Uqc5mt7WGtofsekN1wwEEo3WBXZu2hgEzbN8hGsVozzKmCb/zaDbjyvgxhEI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:y2lq8g+AEjlq3EILhPKIJTG88iVIzkpBefUxnXXXL9CqarfzBepwh49OT8VD8JsWkl0a9uPgW1NyS+7/N1WiwQ9Do9o4H73ygZxR4mQIA9bvBjhWAtvosInihtQb6+f42l6wXz9Fr1AF3DYhFxF8Uk682Wtpsbqo7nltxNZ+aAr6T9KBFpeHPVaLydMpN6DtJRehbrJuZ0i7ylhY0AawL0MthChCz2k3SzqRsZx1GW5C51B9GO6PBRV6gvUpc5n/sYT6RngW4dVLScB7vqkkWO1nlFvKeRk2DAPY/81QZB13NWWLWFb6kwXdWL2j1EISv0XuowMDuawhmiG4v/kVP245e0W9Z1vXwp1bfhWgYoSu79tYQG1Fr1Yzy07kX1ZZDi+lwxl4RR4tyomkywnMoEzaKILQKXfqwvQErtABMOstk+XoF4WvYC6AU3je50RtwYF4AVxEv52fPKwGwjpGkw==;5:lZtHutFIWHglyDNvQGYaQIrbuVFl0dBJ3uwyyYpsgMFXxKuEvHJUmN+kSRuvTB84ULidg1l+Mnv6cdOYb+bfmoWq28nVVP61P+HNeiLXtLD8C1vawOkyGJUXxVGujqnDp4nyDSU6DLsdaKRgYl+HClWsdp4y7f72aW2bfRVSybE=;7:89kadFiumdPPV9Oq44EXPjMnOry8rBY+GR7HjG6r0+oHW4Mn6PWbSELH3SIqZ+nLKoNVrrvV5fded+95owlLkraCxOKffoN5DYC9fr160vhNIbv3gtHnpUtULdJN2e2AUf2wqezQQbz8Aq1sKj61LXUarLQZ9FVgzLMvZtl8Ley2YB73rgEVSA1igodBohfPYd9qlzto+HQ1sAa8Lep48bRZxf7oOvFUTZRRvXsPHfyyrf5TP4K3cYgbavDzb7nY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2018 08:56:29.4229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b04544-cf44-42dc-74c9-08d60a68a6c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The background for these patches is that our PCB interface between
the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
this has to be described somewhere, or the atmel-hlcdc driver have no
chance of selecting the correct output mode. Since we have similar
problems with a tda19988 HDMI encoder I added patches to override
the atmel-hlcdc output format via DT properties compatible with the
media video-interface binding and things start to play together.

Cheers,
Peter

Changes since v8  https://lkml.org/lkml/2018/8/10/309
- go back to the solution in v7 (but the ep device_node leak fixed)
  for patch 4/4
- redo (part of) 3/4 w/o using the disliked of_graph_parse_endpoint

Changes since v7  https://lkml.org/lkml/2018/8/4/288
- The ep device_node was leaked in v7 patch 3/3, so add patch 3/4
  which simplifies fixing this in patch 4/4 (and adds flexibility)
  and adjust patch 4/4 to the changes done in the new 3/4.
- return -ENOMEM on allocation failure in patch 4/4

Changes since v6  https://lkml.org/lkml/2018/8/3/333
- zap bus-type from the binding in patch 2/3

Changes since (the shortened) v5  https://lkml.org/lkml/2018/8/3/182
- add reg properties (and #*-cells) to the example in patch 2/3
- prohibit bus-width 0 in the device-tree in patch 3/3
- added reviewed-by from Jacopo to patch 2/3 and 3/3

Peter Rosin (4):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: always iterate over the first 4 output endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 23 ++++++
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++-----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 92 +++++++++++++++++++---
 5 files changed, 163 insertions(+), 31 deletions(-)

-- 
2.11.0

