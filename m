Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEDFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE0E20693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H2nT8Lid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE0E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbeIQIfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:35:53 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731479AbeIQIdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoKjb4qrCh+NOrnaeD6lCdquGPYONgEjCoVB2YP0EbQ=;
 b=H2nT8Lid/5x3qUIGSToXhF8fTM1eRD2BrcA6WJEktFsRhnusorm4oUgU5lltnB2l7erqUx7+3yVRonPpZHKsc+s9ZYP0KNJf2RYF0fxDRGYRWCsQjdYx5EJTC3Is9QmbRWpCghz5Y5HIIlZ8qzTq84UXcT59/Bw6h9gf7mKdlXw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 04/29] uwb: hwa-rc: fix memory leak at probe
Thread-Topic: [PATCH AUTOSEL 3.18 04/29] uwb: hwa-rc: fix memory leak at probe
Thread-Index: AQHUTjNPU9EyAZW+z0GQF+EjYNerMQ==
Date:   Mon, 17 Sep 2018 03:05:39 +0000
Message-ID: <20180917030533.592-4-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:YMXvGjtxSBDm3lXgAyv7Rns8TpLCBUGzhosJ9hRvu67wstOBM4aEQN4OIHp/URlRW14QnH+m+GCLknWu8iUJgMjsDGTL1yJIq0OrPUO+OyadhwY61Fua1Dx6xpMrBiO/mxSpaMUwWshYgoPL8sQtjqU7mA6GXNh5fWsb/6FVEMJkeduS5lJxu+Y1+GBkDxA+QJLyKqHOtopzQhrMwNc0PagqWjbEOP8QKDmfWWngFFIiOeSyVmitWhiX80LQrVsIMSRtsznM0O4J79FTkaZpPMsbrwS/b6t4oEhcmFXiLxP3FbsPkyQVmidFp2rpT9DobSMd3dNh9J36P3znP4kfUAY4ZskFZ0tLgsA6E/CUjMMcd+3YTC26oOgBzPbbeI/0udWQho6gZOardeogmKkiX33M61VQibCcv5V6AlSOootofzePZriVhL0UR1KQ23cZQiu3bAqNttPRxFGF7Mm8Pw==;5:3i+AR3i3kThzZnK0khX+6IjKhVvdrwV8Fhyop7x9+guc4/scdDB9pcpgS1cPzVW8xkkuzUvgAJx7iZXOJLx4nRc0NSgwZrdkY6iLvHhRqQ2NWy0Mrdqd8eVieGFmRSRONp4h/pCWqw0A85m3m07x0DxTKIgytPSJndVu6F4mhq4=;7:I0Uy+IRrRacTFtJ3tLiLHFIk88XHLnbEErL3ItDLuniy/iF3D4D9M/63rsvCXXMO4BLm1Rx4asAeEpJsLrK9R3oqiRaaIy9dfGDYFpNIIa8nAYpnjrUB2MV7ZJF+1epiFQHJggrSi7xELZL2pDmzfF5cNLWXRQO8qZXt5YfWqOc9gayFOF5LMPNed38FH5UPG/OsPyP9+jkAyc9kAmfpT+bdP/9HwBwPjOtmk9iK4cFDjUMZ02b1X+nQ86sdYQeO
x-ms-office365-filtering-correlation-id: 095ba883-5abd-4642-216b-08d61c4abfdc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839DB90426EDBED8C2B5A66FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(53936002)(81166006)(25786009)(4477795004)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CO6HaM/b4lbRtgjFomVaqkOuf4mUgLOw8BYo3RvKUEBDS/uQr596SUxXKqlBZQ2Bm2urbOZ0/zFk+7f8It0H+6RvIMIFlvEdOsrul1EhJm95aZFFUj93DgIpqNMFIeWY0f19Q+eGC+aGL73fI/SN3sAACi8erRy1WpDZzApP0kOCohdApKINQJMTx6CpKy+5CM1e1N0r0Z4bAMUpc7jhNreycdwOM+d8ORMF5c00itceKQrY892Car+CJ28XdYhkYYo34UuQqcV8utRqrgsQqX/OGjCrtNc4wrN0Ps3OG+Sw2PAQepSABFNq0b05tARoD3xFUT4q63d0r5eZOtqKI2mYsVyj7mQ4VHbncukWFZs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095ba883-5abd-4642-216b-08d61c4abfdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:39.1703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 11b71782c1d10d9bccc31825cf84291cd7588a1e ]

hwarc_probe() allocates memory for hwarc, but does not free it
if uwb_rc_add() or hwarc_get_version() fail.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uwb/hwa-rc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/uwb/hwa-rc.c b/drivers/uwb/hwa-rc.c
index 1212b4b3c5a9..e9ff710a3d12 100644
--- a/drivers/uwb/hwa-rc.c
+++ b/drivers/uwb/hwa-rc.c
@@ -875,6 +875,7 @@ static int hwarc_probe(struct usb_interface *iface,
 error_rc_add:
 	usb_put_intf(iface);
 	usb_put_dev(hwarc->usb_dev);
+	kfree(hwarc);
 error_alloc:
 	uwb_rc_put(uwb_rc);
 error_rc_alloc:
--=20
2.17.1
