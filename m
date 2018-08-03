Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1242C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E0A2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ulkkSrWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E0A2175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeHCO7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:59:37 -0400
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:3728
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729603AbeHCO7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9fYBjGAh2S6oF7T7syrwM9ts3aPU3sPg/GfFKIa9WI=;
 b=ulkkSrWeqnEoO8lwZUg6SxRJ43gGtpP1pmSkYzhsVRC+rZaWSfY7ZgFDK1tv3rFU+AIclIkG+E2dREfdDbuH2iQRMnS12po9x1MnUsVBATO/qxktfZNxuLpNenmn8OMlPmvAb3EUdMxEV9BWmWVOlDj2JPHgNz4fVtLdr/cQCBk=
Received: from BN3PR03CA0056.namprd03.prod.outlook.com (10.167.1.144) by
 CY4PR03MB3125.namprd03.prod.outlook.com (10.171.245.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 13:03:18 +0000
Received: from BN1BFFO11FD025.protection.gbl (2a01:111:f400:7c10::1:154) by
 BN3PR03CA0056.outlook.office365.com (2a01:111:e400:7a4d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Fri, 3 Aug 2018 13:03:18 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD025.mail.protection.outlook.com (10.58.144.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Fri, 3 Aug 2018 13:03:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w73D3Hsw011947
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 3 Aug 2018 06:03:18 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 3 Aug 2018
 09:03:17 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Date:   Fri, 3 Aug 2018 16:02:17 +0300
Message-ID: <1533301341-26560-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(426003)(4326008)(54906003)(51416003)(106002)(316002)(336012)(126002)(7696005)(16586007)(305945005)(7636002)(50226002)(11346002)(77096007)(106466001)(53416004)(110136005)(76176011)(356003)(446003)(36756003)(2906002)(5660300001)(1720100001)(47776003)(966005)(6306002)(44832011)(508600001)(486006)(72206003)(186003)(48376002)(246002)(50466002)(8936002)(26005)(8676002)(476003)(7416002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3125;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD025;1:NxxXoSctFUp/KwIVwNu+KJZE8KmWpXAsyiRiMguBTClj/V7k2qNQwUPfQcigNi+MvL48tIaFXQ734cIy2bZiEy37I7ILA8XzQ7PxlMHJ3+F6WMtU2PRxgemzQPiTReIA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4fdd10-461a-47c0-7887-08d5f9417bae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;3:gSFlbOXBPo+BhD7OhzyLB3AY7HLd0+s8lwSZdKjxr/HPKjkyOBI8cTW04ljWhrlvDrE+d1+MDrAr0yIpRkUK7t6M2o2v1WrbqxUVAuEM6cbfwFokJ2IBFwFG9I9ha2i1kAruxFjZaKr0ynYo9lBYiuEw2uPoP/dfCQoUvHpz7Y30nAGq1lV9efmTJ7LYeb3WQlNxG/X5RZIgeDN20fvfFdThAct7Fy/11jCPU3IvIjJM2fKIpcY86EKTc49xnolDz+rDCzFJRUsV5yCoEwu5yHYCHcpiLVnq37xaQX06aw76RGWMvBgfhyh0gXLoVvQ7+HDMdri5yPq3MWJf/7jgZ1iOA2VPKfoIlPozo9RSvQw=;25:BwW/fsMCub3LJO4P8VJ+u9n60/BHO4TKC1dtwIlO/0ziX5T3dL8mMAuv48S84h/81Mz2iqg1hhjQS5+yQj2EXoP4HFfFe9V9RW2Lu8Qj41rnFX8PoOdVY9DAZ0hq41kWBNLN1y0sVVSzMmXuYrNTNwQzn9EhXIGIGyb7jqvN5DfBWArTRU0AFZmqDAa4PtbSgwOWXzdK/N+6GzMm5mxTnnR2vWPyXLjnVS6yJkG1I/gwF+Z3JjmTK8U8t+mtNnJt8ldl/TO4KOTcIZyXzy1py1fzQE0fB3VDSdnSHjgRvi3xI4DqShyTNWPhFyzwVrUJXZtqc38PDoSps5aj09P+sQ==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3125:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;31:cNNEHx3zJFV22lszdAOMi0iZ06ZM885Oe5piU3tZS1tfPpiKESD24fP+qhdnDmBOqt5zUpU4Y92ibqobqjSP//+k0qTK5+B6xqBJ52lfyxJoexnJHVtV6NqmbNdgVPGWwkE1sCbUGXEHmUDzvDDPvXORMO1PhybZonHK4TkHnA8m3zTaVOcRi+Ii5+uUKWrcLjeb3sPMOU4FbGWgFdfMBWYtISOVNH1ciUl/XQfRp6A=;20:6l99rZm++WXkHm6RaV8G+j1BqE17sHZyBof7NN1H7qKedKcuDRJQYsbT4AG3gmOJQ+AOpoFR2V0pndBmiKUYN6VJ2nImxpYALXP1psvvAiCzr02L/laiHeu3NH8bFNhrP9w1TD1gBkFoBVB9XjWvy/WiNXvJfxaae4gkpqBTsRmc2r5tadi0Jr//usAeI7xVOQOzx51UND7FhwH/2mgHT+DvFWZVCLuTcWOlitrpqhOWLYyiJ15zLrJwfoX7qRyaivfDjhWt8jhJ2Q1qKUYRVxihsbJj+MwQ9gP16zoFcXjRKgX5t+LzYolXlW8scrHkTEpcp3hJ0lFmhNZ6+YSduLO4RVIlSDuHhtSopqHKIy/1L5DVdoJh8MhNhPWYL3o2fc75O5n2ExfrDFRbAQlLes0UQRCTuVH87Q2IoBjMgCPt2PvdnIuYIxHOq1CHS5vKZeIU7FV4t+6U0KrdxOoGPsisUoi6igb4tLRwhOG6ZqtPDHB6YqWlHN4GYF81Ux+M
X-Microsoft-Antispam-PRVS: <CY4PR03MB3125712A9F864254FC1700129D230@CY4PR03MB3125.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB3125;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;4:UHc840iok4LCi+qje25s6Pdl2+W8cpMpQ30lPDZfT3TZlzPq34Xq04ru9QFPXvsn822jQaYxs6WFlF3ySSL6Y1gcSwno3IomLWmu4bt91VwND2RYf95Nz4ky79vUoJt/1c3+ZYyLj7pA/fsLr/PbNWYG171lDnETBOlP/95Ec6+qVvRsZlh4H5zfigDNQRfQcfkexy3iPOzzO/GALfM3Im4mlEscwB4VNWdrt80CmbLtrN6JSiD7WiWiksW90MbQXvb3pZxNWzBeoqeKd9rOn72/hXrtuuRrGpOQD0JZBRqdMd67FkoOD6Wbc8rNjztcK+g9lUTOb4SDA3HsxZZ1AT/uGXEgCMHPjkjqpA6RTmv8o2bPnta4VVQ6goCxbmpw
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3125;23:yWTmX9W64jReK0zVoDFcV//6cXPznouKQWT31EE8p?=
 =?us-ascii?Q?dSO1AEceEmJ9TNHOu7sYx5w3mRuAEe6cfUTqmOqt1SVW+apfsVx35eK85ZiH?=
 =?us-ascii?Q?ehG01BjTMafxQIeAPukr3V7K6O7POA3g9/A+pV2Gi7WkofUVdKdmSkyL41Il?=
 =?us-ascii?Q?S/r5hGw75eCrBLM1YK9XIELio8jCTx+OTedb4IGvTDzP1wl5zfAuqyL8mjRT?=
 =?us-ascii?Q?CUC7gBr9kuDxf84qZZXngURKgYoDzo5hIMM2KJOFUjC7Ttzkwm1YMoI+sfGh?=
 =?us-ascii?Q?qPGYs4kCp1/58TaRqxnp24zsUUNzW6mXvJtFqQCPSJxnkMsl9zZ+ER+KfGO0?=
 =?us-ascii?Q?2XyPtVwPqxRuVoebXD0oI5EqPuKZVHFg1L3Hid/1fQw5UeoxQK1TrKuWl7q5?=
 =?us-ascii?Q?YdsTvKqci7TyDkw09e9oqPbEPIe7Ai3/ZfU5WcZzZNOWuoB31clUAefXES3W?=
 =?us-ascii?Q?Ry04xE4pdNvMRwamqDkFhUZpOsYPT4v1FPs699+Ocj2+HzG45GK3CXz0OH/G?=
 =?us-ascii?Q?rsZY1J+J/Q5559rZZvXZKAMRsrspgaXXTcTBSbJrKf2/9zQNWyNAMw2pZDHk?=
 =?us-ascii?Q?PaVVkQVC3C1G2TKry+6CCkzPeY2rmnJ1XU7i8erflmmYBnFOdUDIVb/c9Gow?=
 =?us-ascii?Q?a67fnQeuIM2vCB1CqhhIRrdGDfqe/DZRnKenXXm3rUg6sIc26LMB2nO3d/GU?=
 =?us-ascii?Q?JeTIRso8SS86b/GxqJXVax8X/g+iLQXwYRKpfQSa0LIgK5xSSXkKkt8LCfkG?=
 =?us-ascii?Q?dDOM57NlqP2q4b1wkBxRx8nPYrC7eW4Rk/NSPcV1auMml65N7PCknpA3XrLD?=
 =?us-ascii?Q?SLG7Z0725JTkW7LPacIhNrn/SaTwbx/sKSN2IYsQFcnW5P6ywgqAhzAs62NB?=
 =?us-ascii?Q?9dhtjlVeZfFpEWEPGoH0Va5zN5D0ssENCD/P3jEDNjqXeQzotpb2UArhFHlm?=
 =?us-ascii?Q?9GBNjAGbWhFWdGdSz99/58/yCpV7Uf2nSJDqbfrA9j+p1cezBEZFzMHY+V74?=
 =?us-ascii?Q?QWzmqbK70QPzU0Ju9ogIpTITwRxI6nY3UTa+C5zfyHY6Wn/b9WsZ/doW4T9Q?=
 =?us-ascii?Q?+tvRvXjXKhzwCcIBc+B4UNNTUktJR2Fbuyc9HQAl7t+LzbtMntSPg9ZXqMoW?=
 =?us-ascii?Q?pfZdt9tQ5SwP3Z5wJj7J3dxsdqGrkHR?=
X-Microsoft-Antispam-Message-Info: SzEq4D1c8lwb1nLuI5xgd8AYt30MmLtfjA635HD7olRinnNRhRTV2uhinOKdfaww/dYZkRFhj6ycnil1gcbG3m9enkNW+Kzn8mvysGTPaGmf0y9p0SLdxXL8tTQvTVzw1FKD/OH6984MQetmiLG+fXdIGTyGKzGEdynjVN3gjkWNRMUKTUxKaT9OZiumA7/QUrRtpCKZ7SJklp68t/+WR3CDLTQajmUgv3vRF7Eu8XTdKA3iVEYFWB6iJ2VJKpYzo5FfZzP3mvprL1fzigXCm5MP1LA66lwPB6Zng2ZpFkXVNcKGypKOqq6b18/fiu/NsI6Hn7PzXkz6+icrmHau/cf1H5EKbXh+g0wnLP55Q18=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;6:Znf3TalRDHDzeyQ+/RxUMd2W+jzvRnhamfJKtP+phrYlk2QmOsrTA2aTR9HxlKvHliiqF7LAT4cjsokgOekUYzECogdW7d/4/qy1OIakgQmzOqNwGQgdJfS7qOYx8EvccSTL/MGRclNvxB+Gi3h3ORlroCMqqe2FMzx8kHikEBwdnibMEDDDGX6Ili718WiLRQQqZAGOeWQXtgLslP8YxKOBRnFzOcJGgbpqPNddTbaIdEvr1/MFpb7C96QoWYdrzH9zGJEotkU2LyGP+JRKKy3wCi0Q+eP5JiGMpebtM0zVulU5bSPZUizAdA3EXJn5cFn46rs4qJrwPs5h4iLsJR3bLsH8t2pNMHNU98fnmwmBf3hMmhOeOuykz37L9VGs7LXx2mQh5H9MR6LB7gbY7PYQfkq0LvXn0fzZuul5JscQkoyQgPGO9zP3Vl2KkH7wJDnMo3hZl3PSKw8cumM8Gg==;5:pFZYCxNWfMpgW/bCOh50a+BDRxGfP9htnaCZIvdAwFgc1kf963C6TjxHpS2/bc8sWcCxmQzwTgRAnU+EkrSKOmGcu2rHvstTzDt/oAueKTY2eHjTLyqOgj12tgQ+AVbS9Sr7UW9+ltEL5VvDINstLithtwqt8hDr2ATUXn3/J1Q=;7:xPr1V35Q7L3u1B+fyRhf343jcUENwbujHH4YjRX5d5ZVK4Fh+a5Qh8nqZ7zgbi+6QC9iZY2T/WeaPQIo5Nba66bubQiikuDgRo8RaFSaA2JA3exKoPtUElpxQ7sFuBKO3c6FDPTHweBzagVYUlgoGcnhsYgoma0nDoxcAWMtPtSVMESZWNWeOMwZ/R2t7QfrzfVoZgPQOXhcEl9D6XCgm82n0Go45JsYA02OkvELM/PtvHtA6hH2K1j82cpE7Kl0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 13:03:18.4297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4fdd10-461a-47c0-7887-08d5f9417bae
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree binding documentation for the ADXL372 3-axis digital
accelerometer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/accel/adxl372.txt      | 24 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
new file mode 100644
index 0000000..41493d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -0,0 +1,24 @@
+Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
+
+Required properties:
+ - compatible : should be "adi,adxl372"
+ - reg: SPI chip select number for the device
+ - spi-max-frequency: Max SPI frequency to use
+
+Optional properties:
+ - interrupt-parent : phandle to the parent interrupt controller as documented
+   in Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	accelerometer@0 {
+		compatible = "adi,adxl372";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ba47bb..c8dd09c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
+F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.7.4

