Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E202150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cfXEoODr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E202150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeHXACU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:02:20 -0400
Received: from mail-sg2apc01on0125.outbound.protection.outlook.com ([104.47.125.125]:10416
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbeHXACU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLxUM1/zqIxv4hLiRrgGA1YDQpLwrOVIrHNrynwk19Q=;
 b=cfXEoODrN+3JqdFnAsZyFR4Q0D/vapLtGK9ox6nYMovUzG72V83y4/LmJj7Px6OJIcrtDaHVawns/hJFiJCJZnjoJ8M3JVnIQiZ6z7p6Ss313hOujBHZiHpx53+9Loiem8pWlT3DPad36spKWlVxGCHM8NamLrAlBISH+YNBiE8=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.2; Thu, 23 Aug 2018 20:30:47 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1%2]) with mapi id 15.20.1101.007; Thu, 23 Aug 2018
 20:30:47 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Index: AdQ7H/34qAH7zeGBQLegJ1KnxB9zFA==
Date:   Thu, 23 Aug 2018 20:30:47 +0000
Message-ID: <PU1P153MB01694E53D6A6192A46EA3214BF370@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-23T20:30:45.2775317Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:5d3d:a618:8e0f:f35b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0154;6:Mr9oB/8CnV3TaJiYeV43BlUh2AVshOS4s67r9zY7WKMBXvvSa+phQMX/efsbDhlSfsB++dCF6yeSNxypZuTwbXKj5Ov8Uwr4Ao1Mf5xbKl4TqdKvhy+4idC4lgBmoLXZlbIJi2AuXbSQBJSB39qHLtUJTodPKw36T89eJPeUIvn5WyJBpLmPj1DIKIYYuAXzwMnnUhqwT5AsGE0nAk610RdhgqVLcD0+MNjqqpHa1Lt1RifOFv3f/6I7459YK26hhcPTLYloko9jUn6MOAGuusQkCILdOSR35q4yifxtw1DaGeDeAoGdQZFESz4I2kN/GByynXruSgyN9W1OfugiaPBR0J3PB73gaxoNZ/kIAcbtM4sI3ByEg4ggb+iut0FT/fMYcFBQXiHt5I6kN3FxJSVVMIQk9YG+qQn5lXM1kDPiT5/X0r912ql9n+MBbXNpoTcVh28gTtWiGOlAmHdn4A==;5:6fxxpa9vlxnO/DrnuHxipcgsMqicVQMAT8awU5nCV4r/YJPnTKqGpZecDPbAy3kZWiuKUdfq6DWH2XkkzyvQu3zdHBLajLV46hD9j0ufDaqInuoxxZoBaZTGF85E+Ao/4se9gE9eSheB3GmGEKhmpklLcr3deZBxPzWpg72rVfU=;7:Sr3kTWqAo16hEVHxZLIG8tYMqtDciPwiiA3XBLQfSOwVQ2smi/vajJFAM4cVFv9yCWF8mnbEk1LTCfXPPfPmeAWDSFR0jBGIvpvwr03vhPhUu/VeByuy094ImhhQ585H2mla58mRLTDLbr2Y8+T4Y6KOk1EQsu2/YVpMH1R3S9lUGPnKHp4ypHBwmVAYoHCHWm6DaXhJIf981Kg5wXS8/ltg5VFN5Zae4F/LNsVSA6Xuds2JWm+1C3Uv58CESNif
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bd153fad-7487-469a-4a09-08d609374f1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0154;
x-ms-traffictypediagnostic: PU1P153MB0154:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0154CB5D26C63D0CF87AB741BF370@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:PU1P153MB0154;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0154;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39860400002)(346002)(396003)(189003)(199004)(106356001)(1511001)(97736004)(2906002)(476003)(6636002)(5250100002)(486006)(99286004)(68736007)(10090500001)(14454004)(102836004)(33656002)(10290500003)(22452003)(46003)(74316002)(305945005)(54906003)(2900100001)(110136005)(9686003)(1857600001)(5660300001)(53936002)(55016002)(316002)(8990500004)(6436002)(14444005)(8936002)(256004)(86362001)(8676002)(86612001)(81166006)(81156014)(25786009)(105586002)(6506007)(186003)(7696005)(7736002)(6116002)(478600001)(4326008)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qvB76d9n+FjNPhqoj6m4EMaGGzrrzAw4P917mVcf8pypF6PK7KuvNSUmist9mwV+iYqPSpRprkiflLdqDdRIZtiMU/4higKaBBemUFx/CwyfOceTXUGXmRBEdHgIrv4pTbqJXQ/zOdIFvfHl7gJrSsMnJUFInTqRPkD3502zPS0UuPeWpv9QxUtyCQ8gwLkO2mrCRYhmHZDwfCJ5Jk03UICLapgZbb/Z0AJZTAw09MnwuZUhpMJYBAktLSywugmMhtI/Mzmp91v3iHDiFb1QeH55NpWlBHEB+vqdyoYl6PnPszgslk0F9HVT2/E757WMCBDBwZJAnKyPMKrJuD8spKyn1dNjlLV7qDWkkqdHvXI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd153fad-7487-469a-4a09-08d609374f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 20:30:47.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With CONFIG_DEBUG_PREEMPT=3Dy, I always see this warning:
BUG: using smp_processor_id() in preemptible [00000000]

Fix the false warning by using raw_smp_processor_id().

Here vmbus_connect() sends a message to the host and waits for the
host's response. The host will deliver the response message and an
interrupt on CPU msg->target_vcpu, and later the interrupt handler
will wake up vmbus_connect(). vmbus_connect() doesn't really have
to run on the same cpu as CPU msg->target_vcpu, so it's safe to
use raw_smp_processor_id() here.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/hv/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index ced0418..c3b7040 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -119,8 +119,8 @@ static int vmbus_negotiate_version(struct vmbus_channel=
_msginfo *msginfo,
 	 */
 	if (version >=3D VERSION_WIN8_1) {
 		msg->target_vcpu =3D
-			hv_cpu_number_to_vp_number(smp_processor_id());
-		vmbus_connection.connect_cpu =3D smp_processor_id();
+			hv_cpu_number_to_vp_number(raw_smp_processor_id());
+		vmbus_connection.connect_cpu =3D raw_smp_processor_id();
 	} else {
 		msg->target_vcpu =3D 0;
 		vmbus_connection.connect_cpu =3D 0;
--=20
2.7.4

