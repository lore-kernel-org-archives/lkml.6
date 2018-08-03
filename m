Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EB021717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="cnmH0Tbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EB021717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbeHCMHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:07:15 -0400
Received: from mail-eopbgr40115.outbound.protection.outlook.com ([40.107.4.115]:63945
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732233AbeHCMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK2uH/oD7Xmy3AEwf4ATIolHvmjpMTP88aHim6p1xbI=;
 b=cnmH0Tbe7ckoTRBFhU7iMYts5q8jIlbTpE/8zWBDwkyo0zAasHsv+r0KfmSyBpE0r03lT0a/xYINj3uFwm2y9YKL7HBISUtwci9IohQ1Qg8icZRrxJE0ryet7Vj6H8I02KHcd/so/0KGpeFFdoOJI82XUZaQ16qoo81gxQhoHAY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2456.eurprd02.prod.outlook.com (2603:10a6:4:35::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 10:11:32 +0000
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
Subject: [PATCH v6 0/3] drm/atmel-hlcdc: bus-width override support
Date:   Fri,  3 Aug 2018 12:11:21 +0200
Message-Id: <20180803101124.4622-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM6PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:209:15::16) To DB6PR0201MB2456.eurprd02.prod.outlook.com
 (2603:10a6:4:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd199e0-1b78-4b49-5ae9-08d5f9297d47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;3:aSdWEp2+8CEzgPo8dry2up00JXVOvvrtv+GjYBjDT+OB09Sd+zZ7k2Jo+JU/qdYNnUoqrNaIDZOaxVgpC9BMkhxepg2eGE+nmhC25S71JOiBBHKYaM+zChURD7Mg4XLhnNmwB1qQvpr8d4hawr6FpqeB1+iw1L8nPhvqvZgBNPs88jAO8k2qJ47mlTvON8QAmWtFreXcHmcYo7RoVLRRfca9RY9E92Ou3VNIjqkQDtogd9gtAm9GS6EcnYfQxkJc;25:VnSJR+ljUFVXyiTxqOdGOKv3rSw8BBNaB6UjrbrlHZnEPh59Oc/18hAOTzHstcTrtSVpX73LY8riTafx8ETKqau5OM9R+BX7vQsXxPZbKfIE9rIKQa5GH9c4EDQ7KHFpdaf3HkRN+/ykIO2Fn5DV7y/g/uIPMckryfWBmJ4ZT/ZnEnWgr0y96Gja3/Lkzs+RkyN1j9B/rgIgMX0XK4Cb9Fles4iJwzqJgW8WDDak45hrMHu/U6KE4mv/aB/2rx/8AmPTfWzpt854RQi0YF6kIOHiJm7iw/NG/RlktfajFtc/drucGWdCNZ0jACky6X1m+kTsjL4VN9Bc0zGhsuaFBA==;31:Fg5Qb63qPMfuOCGljcdRC8iJPBi/KFj7hzmEQPi3psLJtXRlwT87tYQJzXkeNWS7inEpSmqow3ws69/ZCfVD0ZagIoSxlUB7QFCltQ33q2kQDujNpRlWl5CgF/JCsP9VCskkj/sM2LZyW34fVEBaitKrEzrcdLyWXAH2XBzr84DoZ1krKg+qe6aazKbWE/7e1wkRPKwIGlmOyRwetsmfaUy1NarGl3Y0D0GgEiqLcas=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2456:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB24560327463902BDDD76ED07BC230@DB6PR0201MB2456.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0201MB2456;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;4:gOaDejxzZt0lrG/FGu7oz8bXF1BYBhQ4/I3oqBCA1atHfkcyx/rhuCKDopbAeOBU9c0g34QkXb2okUlvlQ0GdeOC2TDu7fvdXUSfEuw8bVNQ8JgUrWuCYlt+Vo6LFUX89oda4ApWO1VOw3qO1Cx+vZeXQGvf6hbiFp6W5zyjWUH5jsrJpO4m4n73WOb9nMso/zCLa0g4rwFsgZKHH+YxojMTMX7rGZ6XikYoYDW0udpi3gL9AkYC6MEcjipkLHievOY3+vYTL7RgXeN2pSZaXQ==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(346002)(396003)(376002)(136003)(189003)(199004)(386003)(25786009)(3846002)(476003)(956004)(2616005)(2906002)(16526019)(74482002)(36756003)(7416002)(1076002)(486006)(86362001)(26005)(105586002)(186003)(97736004)(305945005)(106356001)(6116002)(6506007)(5660300001)(66066001)(8676002)(2361001)(6666003)(81156014)(6512007)(966005)(68736007)(47776003)(7736002)(81166006)(54906003)(478600001)(2351001)(8936002)(53936002)(48376002)(16586007)(6306002)(52116002)(51416003)(6916009)(50466002)(6486002)(50226002)(4326008)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2456;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2456;23:/S5gtmpiFwHM5cce4tiZzfeQ+v6aWe3Cjz9Klve?=
 =?us-ascii?Q?ZdK0UQiN4VqSN+emCi9A+XXPMjvuijbg5/SSQ/kOZweKf+o1ysqynAPgMbu2?=
 =?us-ascii?Q?1zG+ut9jP1x7e+1Skx/xvu1Ic5jIfuvPi26pOjBYd8xrf+3jjHwKvo5QCYMn?=
 =?us-ascii?Q?nAF45KtR1KOzJ+pkPISAscKYXwSlp7dUDWeqqwPKIQoxEPd7oQqjjIteLPpn?=
 =?us-ascii?Q?KWlYZtq4wXt71tq1LlLtfSJIBbICZwAEul6x/KEydSSwKyR+lByML8+ghrGU?=
 =?us-ascii?Q?/oQgAxFXd2qf6lVwPv9At9EscB/hgdUEeajTBykFJzkApCntt+7pqU0IctUZ?=
 =?us-ascii?Q?YPsUtBx1NshT3RYvrcbFknM/RLx0hrj/JCpVoBiMSuEle+tOVoxWpkemMyOX?=
 =?us-ascii?Q?LGWLXRbu1ZG2X9jtWYSI/1yrnj0mMaaqKD/BhjxUN21t17/4ojSREx0Lc1UU?=
 =?us-ascii?Q?wF7RCVsbaGZY4ZUuaeto7lsZUskdontLIkdwu+mzw8Kde+QIgi08dZBq66/+?=
 =?us-ascii?Q?dynNwTNEVCDYCZ5+/PwgTOp4Fjl8cvwNCYFxNOOzwYIuRqfbeT+jPcv6W3Mq?=
 =?us-ascii?Q?NKRESyI2qGOIbYMswBrd5NmSRnWDq7XL4JGxKEllH50Ed1y/QMIvhbVQnbT4?=
 =?us-ascii?Q?5Wk3BT2TdHSoLQ+wGJSncp3kItEkKhK9fURUtLLbRq657uSNsCQqZqRIYcr8?=
 =?us-ascii?Q?8GUoDdWP51u5jV4cXV5HI6P20KcSKmxvr0SbpA2AAkvCcWIiEy0BlL+PTTev?=
 =?us-ascii?Q?iCQG8UDf9xKVny12R+KuQuGbmY3Gf/kjulXHTRq3Ry6XUTcEPWjCyG8ot7gX?=
 =?us-ascii?Q?jYCXVd0MQ5GYRav0Azng2fl+Nlvf0+JEGHyF3kzUa2L6JNaVt0Z2+TOgx557?=
 =?us-ascii?Q?vYSF6G0qiRbQ3t7vCDSEbH11lRE1m78wRGnbVOJKOMylURUO4zrxTlPXNKVn?=
 =?us-ascii?Q?vk0z84ilvd0pksM28a/HR73RIR+UP0h/wFIJO9oKzENxe/WcuATwf64P16fG?=
 =?us-ascii?Q?6k00YUJJ6YRW5NUT2LBaHpHDiRKvT9fPn9QWua/4sb3uPljmTKnDcNcdgjxS?=
 =?us-ascii?Q?EUuDPKNVXL0K6PFNZITUqnG1GLdxvor+1KZSikvu5X776enQPR8reHzNum3H?=
 =?us-ascii?Q?6nxGapAXYV3h/Gp6MGlAckJaWnyTzrJSjLPXGDsNYQaNJyuXr0qUB8cPe94R?=
 =?us-ascii?Q?7mY6sWp7MsE0lB9UO3fcqNEpERVZ8EGuUvU2JBvEF9kSSF8YrZQClTmzCKPV?=
 =?us-ascii?Q?68UDmpqwjCMfBTs7o6qKPZxzwMMG2WPPmTa63dvcVBkaniPECCOTWVom4DaC?=
 =?us-ascii?Q?VVg=3D=3D?=
X-Microsoft-Antispam-Message-Info: aEUTxmaZdld+Q8XxKCLvSdw2hluKRliPvVTplfaf1mvMJ7B5DydkGj86KRUe4F70HY1hzuOKLpmq3HaVG2YbTdOISCoKU3PFLIWfs1GnbAvNUTdo81hHA6VMEvncyEjezzj3ZLNH9+kdwdP426N3YsRK/S4kDm7dmu6XqZvLTq8eaZTFwEpKMMU7je57kWiezpufxfdYqYXQtMsv56m4aGTMRFO4d6GNCpl/wCz/i78/iR4HnH48bp43zJDjJpa2sWE8yjYY6etOLNFtU6LtKyDsbJ8ts4GofXp4cuGBFlgz8Vo6qQeWN2NPOPQ38HTnCPELrOGQk8RHG/4S7Ht3ITz14Xtirpn7nFG/X4H0s/Y=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;6:mAPo5DJDZl48hcK6LWtZ6jt3PD3NDtaZ7SXiRNnOqSPFwpPYNS9eifpkaDykV/Zv/Mamif/q80HmXTnHfZLSQeP6xl0ZYduLzrQ67PdFTb76hTd077LFW5U9L2jYv/dZ6MGcoeSTSD33H/bmsd9VvYODd7EgAHzsJmsYRssT/dmisslWilxhqDrknXqQkocUBw9X2aF/Vg2Y9pxb2AUTc4xtEFzV0+8frU9x/zCHYipHGrV9gY+p7k9AWYFflQ3crwhSUKlpzOCm6KTqsQ7nXATnOegFDM3aZOP5QfM+6uO5S6A0uDN2hl+NQIWImxWM+h/iahggOqnuJrCzMxiDMdzzmjf2XDPsvQxGKurM9wHy4I2lv59Bj7ngTHaf+eOIXKVnEDfHO2TZ3923gFmB0BGkLFYyJErRpYjK3O3HCkiMEAWAwS24l+1bB7Zesbxv6Le5gwoRVJ3Y9fz4l4uRqA==;5:ATUxXLI3/Dci5Q5OSovwR2Rd/Yg5Rv94dkslgNVFld2LI2Cdm1Ca1dvvicXkVEfaM21KTBU0kTkx71VXX7CtqsdM0ZnocMKe0Hi3A7JkdxiQfTes1Fy/84YKeIPQ/rk57hR3fHDTQaKeVftP8YROpDFXvujKVzh3lvHsVv7/vpA=;7:qHY4jXAMeZbPvInOMHcJ2mY/XcTkyGybNMWzGaTa+tz+B5TrgkmTmw9uvuFKpgM1ytebD9BS35EFM9xah3ITEFSfX6vHg10qiH0gXZQs0F1Bn4wS3KEh1Gsp+HCFlejFwRDzGg77DPRjZqQawJqoeDR6nDL7Vf1qUvTcQAfQbpgjqIsIY9Gnk7ilPxry8Vf1r6UMReO0PyS2uiKkfVPIVoimkfRBnKPzeK6f9COtc8JqyWSkh1g0DN6sXMiSpcic
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 10:11:32.5159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd199e0-1b78-4b49-5ae9-08d5f9297d47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2456
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

There is still an open question regardning the binding in patch 2/3,
where Laurent wondered about plans Sakari might have for explicit
bus types for parallel buses. See https://lkml.org/lkml/2018/8/3/278

Cheers,
Peter

Changes since (the shortened) v5  https://lkml.org/lkml/2018/8/3/182
- add reg properties (and #*-cells) to the example in patch 2/3
- prohibit bus-width 0 in the device-tree in patch 3/3
- added reviewed-by from Jacopo to patch 2/3 and 3/3

Peter Rosin (3):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 30 ++++++++++
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 ++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 70 +++++++++++++++++++---
 5 files changed, 151 insertions(+), 28 deletions(-)

-- 
2.11.0

