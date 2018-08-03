Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE1A2172F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="XQH19ioF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE1A2172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbeHCJSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:23 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:60424
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732189AbeHCJSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK/ndGoJfSBn/qeoWsx1XTiZQtGc+hjmb+BNJ0xhs3A=;
 b=XQH19ioFn2+5lCgmNuK17FZtoUXRQeVPi9JXYgmz5gs05X3l8CbgU2b4YTXAO6VbczPyB6lsjvQnlbCnyk2cGny3xj02x8wmxke5Os4ZRDYd97Z//q/KR56tPxVTJu91zVtJnj2XL4tBg/hpNNFGN87QlAc/UHoQC2DCEG/eG2Q=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 07:23:18 +0000
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
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND PATCH v5 0/3] drm/atmel-hlcdc: bus-width override support
Date:   Fri,  3 Aug 2018 09:23:05 +0200
Message-Id: <20180803072308.14962-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (52.133.96.161) To
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42f8b599-062d-46b7-0e6e-08d5f911fd11
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:Aurl/z0SCbh4V02PeUnY+coeMr9mUY1P+QRfANO8OC+Y5aXu1biFmGicoVPaqtu/gB2O72zk14k33Pzww9ic11G8TROZXmkPBh5VqxDWgeQfZyqRSaLtrVNEtJwPyr4ywMJG/Od9COYX2bORSLIh/ZktF17TseY1qLY+DsnujqGY49+bU9vazsSYmH2lYdOJUbxehek6c968I0MhEaIViIhZdfwOPJKe9L81ZHUDkijmZye70qhKdaYlILfYJJQ0;25:1bAmaoWlnFb6KozXn8aV0vxi6mGZR18/YQ13PA//U00nVh9rAHP2K5iYfnPwQH1Ypa8/r+SN2Ph/tGuy22/TaZ+gLBN+uRGMN/KkmGzDVjeX5lIwzl1vRZBpmDDMsuUPLfkDqkxAmY8vgO2aOuW3Rkf25RDTuwEmy29muNk2UEtwRuiCkbVJUw50lfBHu7UI9vjLQgdPocgvVfXEnMhEXtTwDq7XgP+aAdC/i2wUMNpuqrYxmfXl57+D9nLv1uOZJa0Q6//1L9LHEa9FCqBrDuFLIt03bfduDzBD8/uoSAI8OFsbRKziALLtWB8qN3PlSg4iVklaqWBPD+itkwiwVg==;31:W5HVa5l4lpgoc1Bk5he/MRi63joSfsPzBmwicJ5dyL8uNrzYCsfH9mtUjVeuHang+UjDBIjbNxveN/1WakVdqSqHJdsApP2gLcZSZ7+HonlG3vGqVzgCg9GDKov/hEg3HbYlLMbHrdlyMjXT8VTS2Z3Qj8EEJfIYtbHhnlY6lFkMTSBTEvqZfy+sx8YNAoyjq6pgzV12bOC2McGcrpGPdoAP+JVHm5jrPj6IrLUkPJA=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460BD726F24374F5D7DC7BABC230@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:75bdtKl2/tZNmYWLatWhbW3XeME6ELI2ESHKTPZxVB9d+vTRpR4SkUh6vYDB4f5AjJexwhpEytAmy6l09Iy3WiIKGggaIhebiyKSlIkuFCvAKcVp5ByLudH0U+Pmtmddpq5IawoPZ//TySA5CttY0ylNfLjIeYakrfwXVG+FcrjOEM9i0DaWHItAYHVsQ4+ud+mD3s/MX9CBs2xoBb+O/Go/3aqsv5ZadHrtUR1mznzxbA07LT2qf6gMqf6O+YQCn25FsnkK6Z7tILQvmlFIkQ==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(2616005)(476003)(16586007)(2361001)(478600001)(51416003)(4326008)(486006)(47776003)(305945005)(52116002)(25786009)(217873002)(54906003)(66066001)(2351001)(956004)(105586002)(68736007)(36756003)(316002)(106356001)(74482002)(186003)(50226002)(6486002)(97736004)(8936002)(1076002)(386003)(6512007)(7736002)(8676002)(2906002)(3846002)(6116002)(966005)(6306002)(16526019)(53936002)(6506007)(6666003)(50466002)(86362001)(26005)(81166006)(81156014)(6916009)(5660300001)(7416002)(48376002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:QBVS8AsWXi+VolqZbINdN/mtAuc0w9F+CzrV9Um?=
 =?us-ascii?Q?X5KIS5fU/iUSlODFcdnqSomf4DpnRpRbtVVpt6gznHUZuj8qnUaamlb5asc3?=
 =?us-ascii?Q?qPdYcymj1Zt73wZo77bruLcj81GlQRRu4ynSHX+WL+QgXrSM8zPDdtT1qYEI?=
 =?us-ascii?Q?kKGYd6gJGPWXqssRba0TlBBu93V/YkD51yAQgZ7pzlHa48EYa57tlBk6eK1w?=
 =?us-ascii?Q?zSbFRjEjpLWjSm97OGzwtKB2ugcca5F3cpKXtKGlxgbVMhL7wSI6eonSEM4e?=
 =?us-ascii?Q?tLyh6oNy+1Z95mYl1OlRSFwV4x4y1qs9R83ZE4Uqjm0wthsaXAQIQZfbH9U8?=
 =?us-ascii?Q?xlCXuGCP1LMhdesqTxlX1AEEVpnDmepWPiYPXREO1QESmD2Fqx/J86TEDaHX?=
 =?us-ascii?Q?YDnInOyqE1j3pNFlOopI85+1Y103HCPjCyTIeHS8dBO7N+zWCOWOwxqmjUMw?=
 =?us-ascii?Q?+1tf8OSddPWS1aSaeSc9HdCYTV+VIys/XKDnLOvxdoMhjRLrapOdr4sRUVWu?=
 =?us-ascii?Q?1lkxCeakHElzN09HwBCJVgSc6zLVOgGtsgghsIZr276ENQ3+QMF27BP4VVNs?=
 =?us-ascii?Q?2f81/aRVSBwTBPiPcTwaQEJKp4qpdAGZNCAqOdlZS5c+koD1NRxqXWDAIj8j?=
 =?us-ascii?Q?8g+K6Wc5O1/qARghsMs72MQUL52MGhlVJUxJTPeg/Kw9SfhCrGGsQXER7vZW?=
 =?us-ascii?Q?2++U0BxqoHE/rmAnMgZCPBZu08z+LRLpR68GruD8EyEcc1lUhr7w02dHc/6D?=
 =?us-ascii?Q?MF9kFibPj5yEpaKSoc2bNQQpd161H9ryB7BrFLhgNUKyjIGKx1y48oIhI0vO?=
 =?us-ascii?Q?tVVn1IhV7uc75bcg2HN9D8Wfp2z1nRFj1mrNFdtNIOzKqM+2BDte8ZG03eqS?=
 =?us-ascii?Q?DTT/k7xM7ir7DgHasKzPqyYwqtIvk1oa4hB2TXkltqPwhtN7BvhMYqI4krZm?=
 =?us-ascii?Q?X5GNchuQFqtXpMUscyneGAdC7cK7LV4kC5YfAzXE5e/XGwEmkXxoaWbL7YL9?=
 =?us-ascii?Q?tnlxNcxywY+Jo29eK98SPbMCDqoKds5Ra2G92o+CvFQ+pnMsSPRphU5G5c5v?=
 =?us-ascii?Q?0Uxlh7uRqeeFPoqGD7vvz6DdeJ2+CjdcT6W1OckDQ/f5gCiL2JuZzbOxhM2q?=
 =?us-ascii?Q?3IeSzs2ZBB1Bb4UYMuMTOi4heq7ChBLtkzQXFmcp9vlKhjJT3bjzmEIRMEDl?=
 =?us-ascii?Q?+Y9gqako97nFn8TB/7AYXRhkmftY7oTwrUk5EFBc3IbnVyB2C9cCmfJyXSft?=
 =?us-ascii?Q?uMu+l/MSQY6K5a3BqqR0zvry+N/izzL3NiwcD+H3NCc/bZmZfXx/PpfIFDw0?=
 =?us-ascii?Q?IyDkEgsbHNK6ytnB+l5oiV30=3D?=
X-Microsoft-Antispam-Message-Info: m5m4X0L84vs/90yCJcVVtpllV8/k5RbG07Q9Nf32PGZJdKNgyJ2vFcrwyB5dUayTnBuZJRopunHQ02Aqb/NpV4nYIA5q2szgeCY/phl4tT0dEo6fOHyYgH7tA9tFRBLaOiMuVc2/RNEzIO55Klue86c7ZkAK1XD5+BOTZsbOLBx2n4Rx+46kxGdjbc/cv1IPODJj8m3MpA7gVSPwuXpaiq+S2luCOonUZzsberY9kKJo/FP6P/VUe7WAp+uwmeNEALDWAuHJq783K3ENYWULXhckUtooZPNYzKNlCnNvNmDdTov96gQVe9fnbtaWBqBU1fhJeWAaL9VBYc61l7ZpUuFFUV3zeHgtKxDjAtLyEE0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:Q+3eoPBYAKxLaycGEmD0l0EIWh9kcb30S5Rn67bNLOkeGLBYxPaQ/vfHGN52L/70BA9gideaX9rSWcAEciRpLsbpLJfTI/x65qgXv0uW68FAqEPI0wDCfJ8+09xxdUuxql6OLebbR8J/RqlUrDkzO65mwS9oTmDqSKg/dKvxY+nQbVjbBPkTRq0VlMujw1ZCYBUkfRhgekjyOggPhzq4mbF2SyusSUHylPKrP2V3vRH1KxpHY/jsfhyKjGmF43t/TTzw6V/GmmBi5LvD+hLhiv3u3z85rapEljF/jAUwrKuyEL1kouajnBmBzARKm5z8+nmW7rI7YgpoJ0FWEs8ifzhTpXvkq4bvQvibBlBX94UvRN7iikj9jyqwPgN7h8sBSAv5PC/yyilp/WQm3cVzazfpnjpsNOl2Hh6J+XgC03g4LDq6oXqCqyFnxl/8EQB+BdYjMgqCAi/K/Ch7OhkGjQ==;5:ay5AsDem1fE2NE8UHtD8OxZ4bmPuVKMzJmy63OPL+xzb4YNaXJq9QOR4X6DF+VdjFAnFRqIXAR0xpcOE2JNlnI4XoOyr6W3sxfbWHxCbNd9M1vHdChF3RyuT2Sp1RlWkHOE7h0kehJuamXUSVHNU88yMdGmpfX4isrpheWYJrlc=;7:/2Ya+xKCLD6RiLZ3OnEeYPv/QhhKvNh/cE5UNSIMX4eef9xI5j6plH1HCt8cXxT7V/6OC5pNzXE8PKpB6kePa5V2UOG8z+vFq4ukE8i5S7uRMmMDlkkjk265FyJkU+xcCejO6D+EwesNhJCHEd8P8W6mRfv/h4JeQX78S6VI8Zeuaz5fdtmn9nt+UdDM4rGIDNMmBjoMMn6/83GbA1ZQ8xwksc/7TfeWx15Kndu5iKoOY/dG06veorQ3IEE1SJhi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 07:23:18.3775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f8b599-062d-46b7-0e6e-08d5f911fd11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is perhaps not a true resend in that these three patches were
originally in a larger series [1], and the series have been rebased
to v4.18-rc6. However, I did ask that these three patches should be
considered separately. The other patches in the original series have
been adopted and reworked by Russell King [2].

The background for these patches is that our PCB interface between
the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
this has to be described somewhere, or the atmel-hlcdc driver have no
chance of selecting the correct output mode. Since we have similar
problems with a tda19988 HDMI encoder I added patches to override
the atmel-hlcdc output format via DT properties compatible with the
media video-interface binding and things start to play together.
I of course need my old patches or the new ones from Russell to
actually use the HDMI encoder with the SAMA5D3, but that is not
directly related to this (shortened) series.

Cheers,
Peter

[1] https://lkml.org/lkml/2018/5/23/273
[2] https://www.spinics.net/lists/arm-kernel/msg669238.html

Peter Rosin (3):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 ++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 67 ++++++++++++++++++---
 5 files changed, 144 insertions(+), 28 deletions(-)

-- 
2.11.0

