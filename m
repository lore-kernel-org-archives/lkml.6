Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E0CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432982147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J46DT3O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432982147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeIQI33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:29 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728969AbeIQI32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWBm5eSKbRkU040jDQdXHBNCrQjq/8+1dLz0majuX4U=;
 b=J46DT3O0YRE3a2h5uXtwin2sUWENCopst1CjCvQKlZN8HiHQgq5SrXz1omNaI4OUCKsjTCNh59mcAyLED0R+FuCOJYPMSroFeiUF9exHFYXxXdw/eQmcP8B0kJXS7EKVn4tjHaj5zJ6Rb3wMUotqxysgF+Woz3QvoOltquCRvFY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 31/87] ARM: hwmod: RTC: Don't assume lock/unlock
 will be called with irq enabled
Thread-Topic: [PATCH AUTOSEL 4.14 31/87] ARM: hwmod: RTC: Don't assume
 lock/unlock will be called with irq enabled
Thread-Index: AQHUTjLnAYF8TwVOs0GpSx6YQ05a4w==
Date:   Mon, 17 Sep 2018 03:02:43 +0000
Message-ID: <20180917030220.245686-31-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:XdRqTn3MJPru0MLvP/hL6zgZIH9voQ4MrP0UXgtq5fOLcDHYZ6UohYFriCGMo7o4qhoxx2QOFlfrC1N4vzhdKT17KxbXI29AtnsxrNFXA3Fv3syKuNLuSn4IcqSoJ1B/0Iv2fdm3cPYe6F/q9HaLeV3zHuMLeX9ztmwATGyo5d5Kpms7dR1s2DfQ2jCbuUeJ7VlzUMu9PDRZUI8fMXjPskbKAWFPbTHlWcY8al9W7T/7bJCtqbUB8XjhYfgy28k0whyTXp3KNCTBSidY6ZWkyYFvhnLQGzHh8uaI37BZBBNDyhirQ0UqoWQNZNrc2AkzenKvuJU3Mmp7lc3cutdnlqAvgbsXDFIfblZsqVlKAs/c3EgptDPLCPjHVEOS/NlHgACQx5NkDArnEIHoZ9YgieMYkzQ2YMU4/yEoKTJlcPTSg7ZMPrn0D84sgljDglw+F4gL6KgIcSo8dXZip0/SjA==;5:HLCTQOpnvXO0GUH6pseWiGdHIuCa3tbq+OhVuCUxgV5nNknki9cSQgJD0K/LBpENeqZJUL3TRaRXwMZN3JF1lRL7Q4sdKMO1B8x7LRNZ/nPgHOdixwlVjZkCuA49lwnqZWL4bbUdiQtL4901vBqBWzv3m5AAqRipb3qbXMx1saY=;7:DNKfyUDB9glrp1I9qKgku4ZZiFBfq7zkipFLEnQyb1vhNg2EJVvCOumn3rulfrv4485Q16CKiHonLXR1BesLKuNGeUFZAurmWwaFgOgR0CVD/4gaaCbnM7XQTgyhUP4tzKkOSmFvL8YtRMuUxW2DnkEh2RtY8bJpRfI/3z/ZS9ssSPBFocqlTaQYLM2G36HlfX+3FDIBb0/n9s8mOrZzIMCHBQhpnk11e8U4N6bRsd+xgX+nVxGaJchBG0YoNGnO
x-ms-office365-filtering-correlation-id: 3c27fb87-aa36-4d5e-e089-08d61c4a3de8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB077612AEF4FE05600FB64D72FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6tsMBB/a/WuTrpQwaQkTLi4I/KotUUAOWai3VywNcPAPb3umO0++1O7Ex5G8D03+KP1H5v6y82T9g5KU/xgjcNgCcpQMZ3YMu3Z3ftGcFdpKXa/RzXmFpwSPDvEUrxRqWR1PvyYRwZ9zhibArawcPV2bvf7kFg3d3a6DdQ1LiP0gz/Mh0gkNCZ/gFR1jbxp+/R+CFZU1RaPmVJ5s3baNjbivMnj3mp+ZdXdFgq1jHG3Hw2DYgM3Bzx3LAF2f7nE3sODlZfYX+qP9wwsdlZHlLvLTIgjzeK9KqXesJGjb/heHvErgtxQ2ZYyRLWmYoSGdMP0aK8aJeUy6So64n5Nowk4CXXq8x9WhWz+FggrCRLo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c27fb87-aa36-4d5e-e089-08d61c4a3de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:43.3844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

[ Upstream commit 6d609b35c815ba20132b7b64bcca04516bb17c56 ]

When the RTC lock and unlock functions were introduced it was likely
assumed that they would always be called from irq enabled context, hence
the use of local_irq_disable/enable. This is no longer true as the
RTC+DDR path makes a late call during the suspend path after irqs
have been disabled to enable the RTC hwmod which calls both unlock and
lock, leading to IRQs being reenabled through the local_irq_enable call
in omap_hwmod_rtc_lock call.

To avoid this change the local_irq_disable/enable to
local_irq_save/restore to ensure that from whatever context this is
called the proper IRQ configuration is maintained.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/omap_hwmod_reset.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/o=
map_hwmod_reset.c
index b68f9c0aff0b..d5ddba00bb73 100644
--- a/arch/arm/mach-omap2/omap_hwmod_reset.c
+++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
@@ -92,11 +92,13 @@ static void omap_rtc_wait_not_busy(struct omap_hwmod *o=
h)
  */
 void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	omap_rtc_wait_not_busy(oh);
 	omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
 	omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
-	local_irq_enable();
+	local_irq_restore(flags);
 }
=20
 /**
@@ -110,9 +112,11 @@ void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
  */
 void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	omap_rtc_wait_not_busy(oh);
 	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
 	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
-	local_irq_enable();
+	local_irq_restore(flags);
 }
--=20
2.17.1
