Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB5C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A922217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="aMUc6zRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A922217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeHDNPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:15:17 -0400
Received: from mail-eopbgr50127.outbound.protection.outlook.com ([40.107.5.127]:23616
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbeHDNPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p61vUsv9mmlAMLqvQNBJ/QXNDnT+89rymu5IBwudoUE=;
 b=aMUc6zRnIHfmhYS/NDaPmSvT8MaQu7NUmNkWVOuLtRPfjqOy267xUB9itu9LOW2DDDV6UT6ivkk6ATTEMWjWpCN9ms7dIydrjhbtfO8CDQ/M/1CF7FmEHF4VYvmZ4A5kD9iJtMttdM11ltk5RtiyZP4iZV/u2lD0F3JxMvNly3w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 11:14:47 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v7 0/3] drm/atmel-hlcdc: bus-width override support
Date:   Sat,  4 Aug 2018 13:14:36 +0200
Message-Id: <20180804111439.7455-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0043.eurprd03.prod.outlook.com
 (2603:10a6:4:54::11) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e28196-9e26-40e3-db4e-08d5f9fb7dfd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:HYiNIflOTt+8U46OeiwJzmOGtVwUUxLJTabK9fM1Ka1Eh+1ppL/gv37vkki/MWhAjvYS0NtIrdWKPxjMdXGyNg7xUW21dpEJmKb0PRI5upTsVpv/Cx13lyclkQBzTJEyJYQ4XwWpYdRvuUkjunMFT/atckO9ByHsRkg2art0PN/HzYuvsh+CBm2pgbSwzwQl6RJb3Ep5O9WrRBfb7tRH7axi1IinCauKIr3qxHwSJ++hfDPlc+v/nfSMHe9DVZ9/;25:gs29mL9uYyAU0cMa3J9fzMeb6E4yS24b3SeaSxoKXBBuy7wMKvU5HbxgUiPzBAFn0fOazpjVg9z1rmRSFhkeYrOCVGOj+ZOFTPMnCkmFoBFB+xUliDddUSFpqyodCNhNXqwj9rHid0+8l5URtntp/m38umFIcG+UOJud14aK6FbDem65AipVQ/6FZxPCXZXyDm/Ic+DS4jtUI2wiMa9thnl0Cu3uuIDZc8gVBbrp9Cu5gKHzhZ7WuzDGDash8nrIV6cY7NIH6eq8t6m7tds0XdHt3Ycw35ndLvGKmchFF8NTXCkUlV3uLlXrWzV67zgr60XvgSjQwCOE940VeXGB7Q==;31:F3olGO47Y7ZMm5AfBzqQMIwUMhce6Vl1R/GQG2q3x/tZfW7fjGU3kFvYPJkUSb4Zir4LUu1DQoE8UMWWemwDhozGwa6dn37NlZS4qxbeTNaypdzM0wM4LZEaG9tY8jS9JKyNE5LE2qo6eD8TFdL9oktZMhHe7lhhyq2yahzqxdW/hIdeZsAcBzDdgVDHNRLJ7Kf4rzkZLOuK5IZHBVLmQgR/4rAUqJVIyCbJwmkUDRw=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24510A29687997E64A8734DEBC220@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:eFl93XX0FlpMLeeFa4+uQFJQ9+cdntfeW9CxLuZLOWEtmLdcQIhLRG/5rj+zJg6naDpeMW+CcH3rLIdtvTpDU0h8eRL5GtuaVOqptaLKgo3WsT0Kmv/A7LzaReiqAs8Q5RqR72CVGSVylkbs69Pyx7WibMXtRfMQBwsng/AFOXvl2IJDfC/lUMUNbFDUAnSwIcR2qPi9j3pkOTuy1FIF06nw2285HbbJSjpS5B4pUzc3j1tKLfEiWACHKsACGIbrwPMw/vwWlZ2lzBHS/A08JA==
X-Forefront-PRVS: 0754F7E325
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39830400003)(366004)(346002)(189003)(199004)(51416003)(106356001)(52116002)(50466002)(48376002)(2351001)(50226002)(4326008)(25786009)(2906002)(68736007)(47776003)(478600001)(5660300001)(6666003)(7416002)(66066001)(956004)(2616005)(486006)(476003)(6916009)(97736004)(3846002)(1076002)(966005)(305945005)(74482002)(6116002)(7736002)(16586007)(316002)(54906003)(6306002)(8676002)(81166006)(81156014)(8936002)(6486002)(86362001)(2361001)(26005)(16526019)(6512007)(186003)(386003)(6506007)(105586002)(53936002)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:TVtOb3u+DYB69W4+gl/vI0KN0uF55MIzg6qwiC9?=
 =?us-ascii?Q?f75TMrF/MrgMvF5jyiTbpemAIh04HcnRKU17ViIcjCSv9qpC9JqVaFXDAxUe?=
 =?us-ascii?Q?/YgT0Fp/fcMHX3WibKktr+6/PPJgB+lEtf3WKZUruEeGdOKAz6RnXNRLOReB?=
 =?us-ascii?Q?6DaCccvQg5iMJKYhYKaJAMstJEKPW79LgWN8kxKwyL+5F5qZDc5q9nK9ljF1?=
 =?us-ascii?Q?LSFAWu2/R6eSAfF+ZK7Qkv3nLqPHbWledgStUzb3jOroc6Vkbrbl5UBhQ0Rv?=
 =?us-ascii?Q?fTZIVEpguMOCi+1Q3HR4xiX12tq9JXU/7KcMnQO6sbM+Ng8HXI85z7nrDdAD?=
 =?us-ascii?Q?pGiUNqPcOCq29XQLJaVGrQhIChaBtlgIx40zotUcj7Hy5AxNppfODks3i+2x?=
 =?us-ascii?Q?cAFG7gAFaeQoWCzvscm7NDN6mvcZmYU24mMAOIO3DTxOvxqWi87c2n5LLK1K?=
 =?us-ascii?Q?ImgUxvOlepXz0IN+D0/rL6WtptDHM3t+4YYcNvmXVx1qeJxlVmasKSRLCQbS?=
 =?us-ascii?Q?vCgKBEjAhefP5LpUceRyyjunrslKHOAvIIEnGTnZ08TKYY+kfBJDIVSnV95K?=
 =?us-ascii?Q?nfWSg3SRtyMXKveLkfJiftiIE9ExHjCjKvNbJp2RKlbYH6EkSunWhBtYmRR8?=
 =?us-ascii?Q?v+PZDCIwf0ASRQDYMtAec7PrvIAP9D2re42KZ8AEsihRhIYtsUQG+x6fXHju?=
 =?us-ascii?Q?IGyg6t9VQadODu5usy4F7WpZSzJbLK8aGZUTpO7R2vmMkHL4+WQcXZrft5BZ?=
 =?us-ascii?Q?JVz+neee/zaLA5MEFACmnSJ4F++UvTFONWMQnQNFQ5KiqQrCGfVj9ly5MIGn?=
 =?us-ascii?Q?2ZOWVm12Guhqjxy6idHqd+6yXZayO8kkNuIJeS/4tD98PDxzHR+RHktqy/iW?=
 =?us-ascii?Q?bG/moOZxRpS2rdMPf+kqH4eIdLBzOX2uu2GYk+CfILBEkuk3XaoNwslUcKko?=
 =?us-ascii?Q?pu+DjJ5ZgA5kGdlasVaZtqSvp8+tRyvWMWfrweo7/RBQs5VRVtVBkRvvDvFf?=
 =?us-ascii?Q?j/WBvBO2rDFHg9YnEMLIN1v97NuOjIiHIleB52CTSBC5koI+DUiHJu7P8q3f?=
 =?us-ascii?Q?Evq6MluEJqzVPkyOwGf8ySjHjNaVWNoazdJAsFQwXeTE+vzYfIFyNgaX8970?=
 =?us-ascii?Q?ElMHPD5NXtWYu0Kw4R8PxjEAkPDyL1FRjlJAy5ESVFC/BjtQPrIfATnVG5T8?=
 =?us-ascii?Q?FTYCfC2wgALM1fGoEZWIPmYBpFClMi8+jF6G8wMxgZjyoQnFzwdmcyDflB7Z?=
 =?us-ascii?Q?ykQFZYk5vRhM1vYqYZ2pCS/K1SlaF5k+AYW3YjC6vLogZKRZl29A+QT8ZJ05?=
 =?us-ascii?Q?6aA=3D=3D?=
X-Microsoft-Antispam-Message-Info: cwqfxTR+iDuEMMx1lirVWf5EGQ87jY1r+niHpLN4BTzOmclrGl7hV2V5oeJGf3UkLhnhXkqQeXAWEPeRWjFxtH+ZIQIukUZFbEqgQbJEvYq9jiMWUob7pb4czKmple/jdUsuBNp5gJl5m9obeG0k6enlVoVcjQZ75R7Bad2lzyZ2SdZgP6Wa91hREad2gQqTUT36YLjvIC2uXepuV/EKOpqW+PM1qawt636rl1+91f88uDx9N5Hm8akIhKN0TQB7RBOO9BWmQjtiJb4oAHo+cFQ725hNUIlRp8bBfbl70ZuEX04uznWjwE7cLiaQg+FZy+gvpwsPFKeCbBfuyokLyU2Kzf9s/9gqZemmWiKjc+M=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:w2Si5HiOpYQIgvovtMcpYlAgz+s/QQvdDlRuElGb9eiUXrq5Uat9sOnHm90cDC1BqAXW0HLjDfk0oiFHFdWCqaRepNo3jNlhPqCl3MD9qb5vEyd9NY7Y8tJlW64yBRNXBEd0qamtDkIe4weYP2Srg46VzvVXln+XJCI+jVQyQzqsjCNfTM3NJMUj9dzQ/mqGBnnnkv38l1+ahouyWG+Bf67s/KbJJkSfnkfI3SDvlki3HJDv07Xy4NTGP7FDIBMH3/MFK3YpxoX4js2hFRlO2Ht/7GYqwUwPfGbsTPkp+D6EWR5X4zV5IJNqjcI5mrBHmFBDw2nNsFRWcLedyXoCF5zyPAOgSesRMu9FHj8BXOAk79U7uvDMLsJOS/KE7nZZo21y/NQ2ov9bEzuSQCAPLkDAJKJJoQeALxV7bCQOfW5l+bQDLX4Si2zdSkOlML5qMArGlArwxm5Xf/6Apq6/ug==;5:aThSTJY5Mf/PF6BqcBkr10P6Sfj0FuxDVenZ/eZPe+T62zJWP/NRh0vn6Zb9EaGCw7nsL4opRl4p0H8NviA4zizk74B+cZFPxoMoDeen9CE2OH2EsS47MaGcadozqa+39kRBmTywgi/trpPXGF0lHwM3OqI4J7KdUYYWeQrlA3E=;7:emtGzZe+EVbntms14F5Za0eTKsGknPbH88VU4jK9N9eZLC8HYQQ8wDPLTEHvxyGUklRxbbwrpepDqu95byWAtW0zeewinJw0wHXi/0QFsn5FrKELVtF18iCRu+so9pTki9Hq6YZn+Lz4eO1RIVVflp9nq4VC8bl+r+Oc77UfOqRKOhk80HgcOdNSOFM1i1chZyLGRpAdMBq83hCBgn61rEfU4IB+7HSEga3t9nN8dv5uDwMTRjEhFyHa1GHpsgaB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 11:14:47.7099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e28196-9e26-40e3-db4e-08d5f9fb7dfd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
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

Changes since v6  https://lkml.org/lkml/2018/8/3/333
- zap bus-type from the binding in patch 2/3

Changes since (the shortened) v5  https://lkml.org/lkml/2018/8/3/182
- add reg properties (and #*-cells) to the example in patch 2/3
- prohibit bus-width 0 in the device-tree in patch 3/3
- added reviewed-by from Jacopo to patch 2/3 and 3/3

Peter Rosin (3):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 28 +++++++++
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 ++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 70 +++++++++++++++++++---
 5 files changed, 149 insertions(+), 28 deletions(-)

-- 
2.11.0

