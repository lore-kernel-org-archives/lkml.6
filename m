Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB02C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C832186B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="XkIXWDI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C832186B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeHJPeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:34:05 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:50963
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbeHJPeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RCqGeR3e6gufhiVf1ubUmx9CAG7ZhKPBeWRpkccAUw=;
 b=XkIXWDI8z8k9Ci1FvbW8V3wDFNWDyqi/WuxSFfEJdRRM3r/9mi2DeK6C6DOnCl0G4tk4qiLhZKOXJX3ZZDGbmqGqRBR/cSDOpzQxgkeeIVLTYgjtUQjbGPOsj42T4+BWwKo5E9jcZ8PByJ4dA2lT/8Rl2MQ4f2qPcUhlGVGSsFs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Fri, 10 Aug
 2018 13:04:08 +0000
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
Subject: [PATCH v8 0/4] drm/atmel-hlcdc: bus-width override support
Date:   Fri, 10 Aug 2018 15:03:55 +0200
Message-Id: <20180810130359.9882-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR07CA0241.eurprd07.prod.outlook.com
 (2603:10a6:802:58::44) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 399571d4-0e28-4c26-4497-08d5fec1c2ec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:yNPJkztUyoMEo98snkPIl/JUN9uDwA9yEx94SrJRyqMc38QpmGcqAF8GbJFBYbvMzBmIJnk7y5tbZ6zlM8rvM5h8PXEVh8g2kLKou7piE1qVIWstHVi4sKNeS37yeASrHRuWmxV3dsJ8ZxzNCeT69+Aq9oPwbL3ImLL+382V9d99agh2IUf/4rY8CET/XgiXiafEN2A9JHNhGugoJ8ByHvlAz2iSceSJ6e7T39iIZ7JxCYOW7qQ5vfoEi8o+jhHT;25:knNa43ZT3Gnc2ZOva0lYma5DyK+K9yz4u00ikW64YQY+mvd8sco5MHaOW1rvLCKk8gZAys6T5xFr00Cs8BZniQWPPhppSAEapSQPO4i8dz0bn9ASwtPL+969bf514b3QMCWriOV7MfyNfUPUDOEToyrpXEka3WCt6y8dbltvQD+WSe4aBYMx8dzXBBhnWoZ83f/usKJGliRdAUecx3Emh7guSHZcW3FGvT4P/PwZHmRWWoMNtV8M7E341al7zckRm23cyM8aNlQL/eTAdPdCjIct6htIp8KHnsmMkgwWnnWaiOfk7UIRYtF03kXfa0tSCbBfKHnRlHi/KJxctuildA==;31:i9uSzO5puIz0/AQPsP8AziMpTziSFmJZOThmdlOKG9YKqJZeGRchJPlBzlvBbIZgws8WJdcjl+I8fLqaDoohAC7wK3K3sags1wuRU/LObe0kYC30KBkEUZvq5994Iw87Xs3h/rGCQcFK5aIdBcqgaixrIfO30t24aLNWdfOIntviV2cBgcGZ79pu7cJvwOqD9/5rx0wurQtF/MpPDNZCFpiodJHPgfn6jETTBAKnNIQ=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24648A2706BE3812727FE390BC240@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:3rRXOu6GfrffsX3/XcHrM77f9qngnWWlhunVgUrzed066I5BWtxOFDxf/gkRmZDk15OtZkkSWnGbfPKZwZcX2skuAnVTIbiq/POpEz712XuPsxNDByine6LK4mNU1I1xLctXl5CdGcenuxd4inWK2/1wm0zkZ0+wrUHSeBS9sc+DG2f6uHS6NwjdSux22H1v/KxXblf0BGNHTEbFNuecr6a0NLxA0wxY6woOuJweDFEiozicCehfWyFPo31wXhsURIt96cJi3RgMl9hN6P0H0g==
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(3846002)(16526019)(50466002)(74482002)(50226002)(36756003)(305945005)(47776003)(8936002)(186003)(4326008)(86362001)(26005)(54906003)(14444005)(48376002)(1076002)(6116002)(966005)(68736007)(6486002)(7736002)(16586007)(25786009)(7416002)(6666003)(105586002)(81166006)(81156014)(316002)(8676002)(478600001)(6512007)(476003)(53936002)(956004)(2616005)(2361001)(2351001)(6506007)(52116002)(386003)(51416003)(5660300001)(106356001)(6916009)(6306002)(2906002)(486006)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:YSVCX8DmwtY+WiHvfq4SHlvM7TGd+I/0HfmBPWB?=
 =?us-ascii?Q?6nQBFlZ8y5QmuaQw66kTYdOK1uHpUHzpdisIuIu70g1HmQJv3LVne5IPsFsa?=
 =?us-ascii?Q?FOeZZAP5xH/ZWiLDftmiB2ieffQBk5lbuIdjXhXOgaKQ16NjtMkdfE7H1lCO?=
 =?us-ascii?Q?TIEBb042rgoAlqFZGD6a3meRWZ+TAkv7zGEgrTtLe6jCmDfRrvxOADAI0uDb?=
 =?us-ascii?Q?HbDIqvBMssnCmyFFjvMgl17iFVCH16RX7l3ohcPb4/wCDy1bZRadJgJpQiEA?=
 =?us-ascii?Q?J5FArVoW0mopLwRHIeFHkqCMWngOB6sF/qY3y1WRmPOTJgR1+2lkfBGD9E4z?=
 =?us-ascii?Q?Qz+9C2co1JVw2NFh4nm70gsB0nO/gzqG5LXZo6AILy7pVHMWHv/F27uIRR94?=
 =?us-ascii?Q?uLeEKEnXyCAscVEa58NNPLy+7apg2CqPzLuij/wUcPBu9z79ev09FvIC2wXj?=
 =?us-ascii?Q?IO8bRSUzkjGdyq+Pyd9pBvckp18+BMorKmeGoSrUzc4qA0cscsLqIHiRv/vJ?=
 =?us-ascii?Q?+U1PvbL6csHw25LT2qDUxdNw7Wum8/gTy4+b38s7C4cMVasMM893RL+V4G4F?=
 =?us-ascii?Q?qKWr+wg3LXG2c6WgGtSwtUIRt9Xj0DtqUwuDSYfqI/wm5IF0kWAG7DBNiR6V?=
 =?us-ascii?Q?2n5cOLTek0vIUV8/2jCJXrEacmZwugaAoOyvEmONzqvNIW7BgqvXbXV9wvnC?=
 =?us-ascii?Q?QcenmqmbxCm3RciSRLSsASMKmGbYgZ9COmBLOwGmVmZ35kNMbIeFsIcecirN?=
 =?us-ascii?Q?YqELNwyLDDXP8/Kh485kMy30C9rg/fxSg+oyegnoE1F8giOdmSsZ0/puw2Js?=
 =?us-ascii?Q?HNjJJ9dTHQlhKdB7kjyW7VRJSqDc3qGTkDrRsrUIRY+KiWflpATq8hci1MFa?=
 =?us-ascii?Q?lxo9uvAa/8F/kRdLcwLxOYiieN8HHIysZIlrc4vmyItNcynEtw6qZFD4Bh/T?=
 =?us-ascii?Q?/QL5djZzq/MQGQK7aSxwuEDxttjV4RFF6si6MmGZCr8BtQPcuFD7VNJpjmUF?=
 =?us-ascii?Q?8zt8BeftBjTIO2pjyig6J+o8msmhCzigIJcGroqGlR0x7hqlMmWQ4HVSxP4R?=
 =?us-ascii?Q?MftYXVdDZT8Q9EyuntHVa6gJnG3c+nm/z6aPvdrRC/anMu8sl56ScPKlWQr6?=
 =?us-ascii?Q?dYYADSg/p7EuirO1wyB8hJEyhMLpnKrtseB+0N6tC9dwDXqM0dowNNidDTSK?=
 =?us-ascii?Q?Af4CRw0TrVv2Vb3HOz1fGyHVWw+RfwuCOqP0nlIt1kglQPO5nPRDY3svwUaD?=
 =?us-ascii?Q?FwdDC3EjtueG9d8DJNXWTbVrtZZnCtEFGto7XNBRfaHEsX5den9NUMFpIKuM?=
 =?us-ascii?Q?9CiM3wtBfXZW/7F2jelqw1Bc=3D?=
X-Microsoft-Antispam-Message-Info: oC6CXG44ihmYCvK+zBqBJa4p4xJqPyoOU0bLa8TnAqPeZICkJGBtzyr6VtxcPObF1VCT9pRU7nRZBpMrJ54UQ558kLQRThz3KJBHmfHq+oxPtb4LtAuoSf1EeiidR14VHchJ7E/eKDjCQWH6vUPm7EGqojJjJX/4afALQujwjcHITk7kHn0UtiU5HeMjwKO+d7zZpSRhzM25t6rYpOxkg2AtBCSWeZtee2Jx9I8i8NRLd7G/KUBa+Ue92078YNArvIacKLxqxQP+fcZjVSWcEUi+zX6gS+0RylitAiv1Ivnn4SqVKhNPACsXUvAaXwdNHLf3zZDyRY9J/2h76diSZSelfPGME/fm0BDR0Mi1/1Y=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6://duVudv0J0q3FOwqZsN4OxGtZ5znVnH/2W1jYDUpKfYIrVNQmET6G5qmuAPxzGEE9DQmAWeHfnHJHT2BBr6UfEn02GkDY3MlEZerdK43IPCqw90DifnHSvtG+Wn3nqz65MeMsD8poaJgzLisxTiGw9e8nlJSlas74gc/dOKkZP7VRVf10XNJpzMUUt37acGwi+4C4Mkl+/Okz8jy+3Dr/ofDr0dl96h/RbODhq828K3uFL8KCS7+JUo8CKVx3hWzYDSZe1D2bGfYOKij1rHbyEQgwfI2gvFZMtibo57HCSf8hBNxQnpYEUatrNXayfezGapiByv2w66DbXYQdrjZOk1eDZayvgZCxy9Ufa0dm0Jb/aRZtr1BlT3QPd50OV+5LM00Bfgg3xWi+Rlw8ndD7hjEyGLel4jX0uHXTLmQigpO4/gW2ynkHsEmg68S7yST9HEHH2T94IVscGEomLSFg==;5:mrw1X8538/sxxJBoekySMEBQ9Tg6Ii58yi7tF25RJ67afHuKP2++ojiEsgfQ2aYjjaqGb4yFJND24jOFvtORwH49WryP+aFIbwsKUiM3TjfJobFr0PBzcQJW85t6+ghqr6XXlCEXn7yKYrOkoOrwZpF++oHgBLVYrVICXWqbNXU=;7:8rGD6owily38UQm58vQ2ayOtsEP+NF7sLkgRWpNSLUuDeCp0U6oYJb/lzSfaA8XFoU6QeuxLTPb4Qyd/pi7z+Dm0M/rvNgCuKfrB1+0JA1ah5nN4ar6ddJkNb/c95aPMh+4osO0pZUWqlfwXrnl/P/ieSvfTZ7PHbghD5k1MDf8kzuWVhhZ6zr51b0it+3vVmyHCwWsdKh+kAIRpF8frgebfwiaNnN8rj3jzUEGOexC3pc0NLpTnfx7s/Brq0zYL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 13:04:08.7075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399571d4-0e28-4c26-4497-08d5fec1c2ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
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
  drm/atmel-hlcdc: iterate over all output endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 28 +++++++
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++-----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 98 ++++++++++++++++++----
 5 files changed, 170 insertions(+), 35 deletions(-)

-- 
2.11.0

