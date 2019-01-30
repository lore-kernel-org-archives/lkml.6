Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E3C282C7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E87321473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WGtEB1iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfA3BXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:23:14 -0500
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:4944
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbfA3BXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIxYUViA6bkPS8XmvR9v9mRU+AeG9PslgO69bthaQPc=;
 b=WGtEB1ivGBb4Ee0UHnqMt/7D/tAe8sh3OV5k+HGjhe2x/bf1f+7wABpwGPGDz64I4pUAyJpdzzrcxPwUQ12JHbjnROKMIlWIdqnZVOVFmZoy2EG06gAs7CblI/5Nu39vOvXobcogQHxQzimBx8dXTCDZ7BFtiUd+rH7NW5n+uFU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.7; Wed, 30 Jan 2019 01:23:02 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.008; Wed, 30 Jan 2019
 01:23:02 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: [PATCH] nfit: acpi_nfit_ctl(): check out_obj->type in the right place
Thread-Topic: [PATCH] nfit: acpi_nfit_ctl(): check out_obj->type in the right
 place
Thread-Index: AdS4Oct5qHYRlzYATxKGX2lG5IAWXg==
Date:   Wed, 30 Jan 2019 01:23:01 +0000
Message-ID: <PU1P153MB01694923DF3280E5828E2BE2BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-30T01:22:59.6825191Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4555d01-0583-4f01-9e5c-3168cb9c12f1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:3d8c:13fc:95ca:ce39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0139;6:hHOyL6CJxAoxEeDOTTol3TF8mKxY4EOwW94AXNhFc0SayM8rMzREklKL+7o8ntQhw11wkLd23hex3nXPpljAksNdYpOzLB3P5ZMzQ0fsXa21DD8MmOqQGMDP+BJp01E+Qk06ydTNOLpE9a1JXTJWn01FZNwJwyKnsLLwxRURz/1+c20rrfC285X83K0ym8NmFOSBxCBfR6rvhwVb8cv52btipfJehgu6E42GQI1xq0RxzXeBt+iX5/jrZznH+qql593pQHT7WCyPXW82yHLbTaBQ42148rdMztr0ZZS8R4hZ0hax6ND+I0XzC5qgaRlRHk9jk7ms+F8LJ/Mk3SHMoWUh0pYLc2cceauF6vbsv1mucXAhbgZlNi2VkGpBf5PDm/+79Ozts+GT+RQHygnCVPhSRRKwlaIdhvJsAVwggAXUO/Ia/UcHOAW4kYWx+A5QP0W7KQAYizNadGb5XkPCzA==;5:oTbampaOTfC3EtYApvdZEuAkupL82M30O2VIqLR3S6iKOLdH2MmPYOgw3UF7mTsnC+w0+MKLKbqAPxzvMKi7pPBoNWBB8zQe3P8ki5VgGyEPSL4X/UFGMm5Makwi7UmW23UAv2QzxsDnotfT9aId8mX11En/QHHrtVY1DJZ7SlJlC1yxj8LAAKxlrs+kj+2z6VAjM+zdqbw9AIt9n60vIw==;7:x1qYR2SSHr+JIRRaw9UNhIwDpf4dxCnKQtycaa/44WsnYpP3rkUqUEhXPvElOrN/H9AVYx4krjYjmh/9Zgb9t86sYMFGFpIIdvkvH0QYIrZHUk6golgEMAZz8bZLP95eEItQ/twxpG224bpTjt332Q==
x-ms-office365-filtering-correlation-id: e74213d0-9a59-47b8-3ad1-08d686517a4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0139;
x-ms-traffictypediagnostic: PU1P153MB0139:
x-ms-exchange-purlcount: -3
x-microsoft-antispam-prvs: <PU1P153MB0139F30E9E0F7C0EF898DFDFBF900@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(71200400001)(305945005)(7696005)(186003)(33656002)(476003)(14454004)(486006)(81156014)(10290500003)(478600001)(25786009)(53936002)(2501003)(81166006)(68736007)(6116002)(6506007)(4326008)(8676002)(107886003)(110136005)(102836004)(9686003)(55016002)(105586002)(99286004)(106356001)(2201001)(2906002)(7416002)(8990500004)(54906003)(8936002)(316002)(74316002)(10090500001)(46003)(97736004)(256004)(22452003)(86612001)(86362001)(6436002)(7736002)(71190400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GhMBuwpeHc/K09CPgpatEec4//eww7tHJ/Ile7LueP89FMEA19x6bBV4u7j2ikA42x6nFEdZ8RlFz/dDOYsPF/x9hPvriFdy//ztKf86VNB6HdYvjLl9jVkl2KrpJLNckm0Q+sSr9tNv7DR5EZOj54z00pRfICuS0NBEsUvsV1/VTP7Bazj2mVp+jxTO7u0u35FYbtnBZQIWFdv7qF7vEVj8jCDvCwuCCmnZ2SR/WYPKKgNhSd8bCQ5/TUNFdP+u/tEzWXWacrvn/wlUYmoTPFfcBEZJprwCYmrr4n8w1ngnlYdcVP5J6IPjIfPuJ+eVaC3AhqFhTPHg+sqMvAEFPeeYuzDp/Di1uTfXTwQFv99mXjsZWOJun2K9eTtv//zrfVk14WT5zBapZNXqNxtbKcvHbiIFoTB7VKW5zQCnnTQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74213d0-9a59-47b8-3ad1-08d686517a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 01:23:01.8071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the case of ND_CMD_CALL, we should also check out_obj->type.

The patch uses out_obj->type, which is a short alias to
out_obj->package.type.

Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command mar=
shaling mechanism")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/acpi/nfit/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 0a49c57334cc..1fa378435dd2 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -554,6 +554,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_des=
c, struct nvdimm *nvdimm,
 		return -EINVAL;
 	}
=20
+	if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
+		dev_dbg(dev, "%s unexpected output object type cmd: %s type: %d\n",
+				dimm_name, cmd_name, out_obj->type);
+		rc =3D -EINVAL;
+		goto out;
+	}
+
 	if (call_pkg) {
 		call_pkg->nd_fw_size =3D out_obj->buffer.length;
 		memcpy(call_pkg->nd_payload + call_pkg->nd_size_in,
@@ -572,13 +579,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_des=
c, struct nvdimm *nvdimm,
 		return 0;
 	}
=20
-	if (out_obj->package.type !=3D ACPI_TYPE_BUFFER) {
-		dev_dbg(dev, "%s unexpected output object type cmd: %s type: %d\n",
-				dimm_name, cmd_name, out_obj->type);
-		rc =3D -EINVAL;
-		goto out;
-	}
-
 	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
 			cmd_name, out_obj->buffer.length);
 	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
--=20
2.19.1

