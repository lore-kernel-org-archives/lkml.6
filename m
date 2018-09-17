Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0988ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94773208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M5f1YwML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94773208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeIQJAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:00:05 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728930AbeIQI02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWBm5eSKbRkU040jDQdXHBNCrQjq/8+1dLz0majuX4U=;
 b=M5f1YwML/uEWrH8GDk4m85C6M8xFCfvoEgs08a3AFJkxEJGZB5DxuGmsKVxtt66ivkDqZP+46QGRZramSWs3CxRxmvd3nqjNC5Vg2RBc4xOnCMjyzMWV1RdqPZ1er4qIxlxzRT3G+FKkjgaMeav3DoXoDJmUA6LUyj2DOuPYlq4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 044/136] ARM: hwmod: RTC: Don't assume
 lock/unlock will be called with irq enabled
Thread-Topic: [PATCH AUTOSEL 4.18 044/136] ARM: hwmod: RTC: Don't assume
 lock/unlock will be called with irq enabled
Thread-Index: AQHUTjKdin1NT3EpBUKYvXtNFjIpIQ==
Date:   Mon, 17 Sep 2018 03:00:39 +0000
Message-ID: <20180917030006.245495-44-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:Doaty3519vFxo4cR1iz37ayNxMbxO7y4GMeUdlGgLKSuqHe2sZ9B/nfJxpoHo8JDhEUSp9tyIxERyYDuSjde3M1lC3m9VlWEZC79ZI0nuDAMrasLnl9M8CAnUOa0jkOM4yDq66fZQ+AlhiWUQJcWO6OUXwDFbJfyOyXnj4xy6kNSBKRDFUw1WI4WkDE2k7TEfH0fQAwJX2PA2sLFRPNwf11Ldxy8DH5NiZ5D7blqQS+dS3Iv5I10e2WRgI2CeqzoayX3wimiO4eJBnTRAWnKGlRlQ8UByfGrvDtGQEelLCF+g19NXem2UNQYfXYXzQ7yDTuyH96O88joFaNUTkGbOuoXbhf6huJnmsXczWGxgOAJdeRbzP6iF79jnBPi4XBU3248S5Oz0Gtmt3uJXf2XhbwhK4OaeheiSUcpTMTlcAJZ1H10c+59cjGmBB52Vmradrn1TfTr0q4KZnx7XEjU2w==;5:CX+wGUbPe6D6J6+cFlGMu1B1shCrzC1AZ4XvzS/sT029ywSMBSBgmXUpALfGlStw1QgFHJS4gtfdMD2TbFYuioT9PEKpiub0n9TSPUukM8B3pR+u4dwXa6+XhpXwoe6I8/Ab0ilmo0vtvP/mxZ+JIhwHcLx9ubbrEv5UkpEJTbs=;7:IZwfNGA6s0M+QHm9st3I4zSw1VFRC3WOV0fNnE6NPKl/ADQhxuZfSXdGdlYT4lDOQvJEWEzLHBYF/OR2OfiD8P9j8Q2eO0Rsl8l3CSjq16fW0fMscbZxocQes1eFk41SWPzfRgIq20GzZiVKyEIuRIjlGs1M+ZEOug1s2waH+LJp0ouWCOkonGus8rZ3NmFujN3BhTfODpgcx5fegjO3MwB1EklNrT/PkhD3X2qWoT30Mc+IyeipDVuoECKOhqO/
x-ms-office365-filtering-correlation-id: 6704bc7e-f7a6-4bba-5784-08d61c49d1f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01679B0EF96F943D2270FD4CFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ql6bBLYYH+69EgnxJDqkqcACZFUVI6w+A9CRloz6KUOQAZ3T1gezWN+Ep47ZJ1IZxCoaugdPKsESgvGL0XCbgIL2G3nI0/LmzGNDOt313mU0AtNBIfAQxZUusSgYcqy6LsVhskV1r9yFA2bTMPY1KEOaj2+7zc/UQgR8snhljNukWsBcDLY5LtTvv3PmQef63CHtakDT/gneo3aJPgKZKgpmG2LGaOKE6jlzF1l0Idw8snLUFdbuyRNQKIf/8N8uPIu5kr1YyUK4tT1Jb8dgz3+u3K2h9Pu818iht47Y+EtLEiBbH+dmOSi67KbcDcVSfGJccD1AfUPwe5HbglXfKqQuFKahrhdVkshCozPOqQI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6704bc7e-f7a6-4bba-5784-08d61c49d1f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:39.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
