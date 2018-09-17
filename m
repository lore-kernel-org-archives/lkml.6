Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A870ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE0B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TP8IcXck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE0B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeIQIbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:02 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729253AbeIQIbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWBm5eSKbRkU040jDQdXHBNCrQjq/8+1dLz0majuX4U=;
 b=TP8IcXckyC72YPWyAVsmiSRf+krKyIdh6s9zRRdkoypyCxIg2jDb4Isv+SJaZUhYgiPssQTxVrLmCfF3Krqh71YPNL6D1YFXAV7GqNqBEMLLq4b8xClYmOTAuCsrQZ5AWVII5c0XpPvgIkwBNOkp9snqTnYhXNv9Y5leTWRGCkc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 22/57] ARM: hwmod: RTC: Don't assume lock/unlock
 will be called with irq enabled
Thread-Topic: [PATCH AUTOSEL 4.9 22/57] ARM: hwmod: RTC: Don't assume
 lock/unlock will be called with irq enabled
Thread-Index: AQHUTjMS+v90RoZt10Okz1fWVGNLhg==
Date:   Mon, 17 Sep 2018 03:03:56 +0000
Message-ID: <20180917030340.378-22-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:xmhHbhZhzC97hTKLdGetpYhV547uXD3HQ9shed8vlUTuudTM/+tFsRzIL8j6Cdd1VvisBCJp7BWKaEpU6e7sre/V50apaLtXbCSSNdLr5wnChLwgk3VuXEQw039A72GfwUBi/gl8S5vCHQbQmJpU/RncqNMhfSiUT69+34YTBmOOSjOv1b6IIc4YPcxy1T4OoqZnKMBefq9g7YtCQeIT5zgT/jVpYcfGIxuWm7yObtVLqpsuC86ifwvAkHrWQWmH8deL3kVdI1MeIUveuEQzniOi4Ufhfx2qYzmcpqE+tgh6UuAFbd+WF+mhqTMbxgmoLUAzALX+EpNFzAdYqClF6RqSddWKKhvKfQ3HZ7CEtVKdzax1ZPTMU2eWM/WO9TNLTN1lsAl8shswgQwuq1q9FCmhG/kP7M2vK7Qr/rhG/84QVwcU2H9BVq4n/6xreBmELSrzeNhZOq2mtJ0oNq7B6A==;5:RDuUYfUmpG2eXLM7Z5z3ie+ITlxBc8RXM/BarvDDPqH3WySm9I0wS2yastO3WY3sLAdMKwjfrOlYzRD+YRyFTayq7Hqr1v9ybk5iJhz9nmseLSOf47VH/Rd3nvVnYDhOp0jgvn5QAA6PXuU1+JGEzrmA7D/v4bJ+A4pK34V3kcg=;7:alhtivMtQM1v+OwY5P78bnGSDUj6di1TGRwE2uPSYXZFtlXkASGW66jpO0ETZeT6bn6Cvu+5+es3trXVV3m38vyKqjUPH5QJcn93TN0jZVw9Y2Fh+7+VVBn/qhq/5wB1Cj9UCg1+iiw1rR+lSe+7cJIQLQRk9wVzbYH5q/huU9PRAPO+3KJqkutebp9vPjChGDFCu77pmUPPM/zkuJbW0Njkl8WFrITI4PD87mrhLSIvt1qr52SvdqWuPIHMN50n
x-ms-office365-filtering-correlation-id: 41134d4f-ad77-4ed7-bffe-08d61c4a74cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757A5F5FEA87F556146274EFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +TQA9od61XaBP7Mmc0Xxuh528iJFL2x9MsT+TmwoQ/2VRGaAYje755M1e2kc7yhnME6t+oPkSin+dwGPTucUP1kWFD7LH+ZrM4HYrxiRDon0G0ZlnwCgwKzaDEdrMcP8B/nUpQoCEoyRf2Pi+D0lchBLg9xUZku5v+c/2+q+vEEbD893hhJyWWf7mlrmiUDx7Nu70SNjSWGtkGThXfNlaX4GV4Qv7v6LMY67uMa0HkQwrm7CihZciplkyNXPL3YPSQ93JvuigDuVHn0iyBYuoEJymdXXt2vSkYUwCMdDGJHzfaR8fC0a9kwdZY18RVPGODlEWugVAMzqk4hqw8TFKE8JdlT9CY/agyCd4Hy6eSs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41134d4f-ad77-4ed7-bffe-08d61c4a74cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:56.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
