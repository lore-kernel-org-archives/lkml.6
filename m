Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD3EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A906720693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CNbkbwwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A906720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbeIQIjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:39:37 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:15223
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731003AbeIQIbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoKjb4qrCh+NOrnaeD6lCdquGPYONgEjCoVB2YP0EbQ=;
 b=CNbkbwwo2P0JxJCZJPOWsWVG3w98VP2IPk+zC3KxKxrL/P3EyySWeoShI3YszY5EeeD4/FwB9IuSmh2VbkdSNxg1D+SjBVnTXDkspP5Hhd96TNAwhLvZsHbp7ayCFVLsdwADQkZ0fWyNK+1sg13zTPCd9CyDLLIIPTShp010keY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 06/43] uwb: hwa-rc: fix memory leak at probe
Thread-Topic: [PATCH AUTOSEL 4.4 06/43] uwb: hwa-rc: fix memory leak at probe
Thread-Index: AQHUTjM0/bu69+FFBkKxiFcZNKPq9g==
Date:   Mon, 17 Sep 2018 03:04:52 +0000
Message-ID: <20180917030445.484-6-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:0aLO4S3VRGOOxMl3MRkqMr4+ixKN3Bxqq22be6BZUvZOxE8D0+WFSGzerkNHCetbFr1z2yHdOP+c6lhZvIXc7lWdPvjdUyKK1bdV/a6DPiWCYPr7nVOHfJSbnjXuUldifP1UaPeRaDN9oGa0pT6ryctJsdCSMnW1Ink2bTp9cn1AiEPDGjlaaZn3efp7zPY4g9aKgrsRG9xxCVbjLLo6W8sIaI2u5tihxAHXAfQtWn6BFGwyGRHBsXQroFpevJ1f9/aYLCN/3RjOqsYSEYM7XQVgmAFBIKxoKPlF1q2V0bYbtAjRys8vbcpnVDLLt3SKtOgsWYP7K3bneMeKY3cD3AcNPlRK4yAjOJ1+vpb9lKBSoenyT37v8Y2mUiabCcVeaRYGxjDHQrSiMmDQcml5DQCKzcXFplgvI21y/oVs3hQ5/fszDeDratA+q5B01951ecAHfkySDBx4B4W4HcwQ2g==;5:nZLggGE4amhdnF+QyfcU15YP/iMln8OMGosXXklslwublhJjEGM2wzqJgahTKpjrdVH4NRFYC+bKracRzXn8Oou1dtiksJujdur0A0kBuD0WhxveY/NUdYHucw485Bj3CyPIQrOxdyYT4KpZJuJJJyeA8lW8xyLP8btijrrXpwA=;7:3NrKU5ZxH9teqReSJ95YyJFcyp6CbV1fLS8D1bPLi/9qevqIRpo/lFuTdbcNCxZCEjHJCqrzX9jt1PGf/xfz0bGhi36vQUweO8171E6YcKyDZJS956bpeN40FWjgUOMoSVVZvIiiQ5Rlkm8/P6d+eCvI7BdkFI7HVp3QTfHo6xnS6fFh/fQc7uF8aoErKLI6v89QOHZjD4zRMdbfh9NC7RoBWt/QBS+do8SaFRnlttyH/ToX8Vv47y1a6mQWCaAF
x-ms-office365-filtering-correlation-id: 8ba96a1c-eaad-450c-267c-08d61c4a9230
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01661BABAA9E06ED4B4C06EAFB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(4477795004)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1ktC03UNfuFshSsTg0l0m0FFQsIupiy4LULR99p1dc3jS67mfdyTx732K68Z7kOis0AhYx3vJFbSUEUevXOZ3n7kKiK1E4KgkY8nfJajDCKSHVI22gkRZQnALx00w7LwEbd3LSquzpNlAD4mRKUqf4OGvmGtBZnD3J70orRLslExSwBes7sxpGaXOqgwtGyZkz0aWUZ58ifRwj23+wVGMa8iVUJLEdlIH/h4NcXHiWVUjyU3qyogr0lVDN/o9/OGZN+xVoS4VaHc/xJ/wp8pUst6cZToZ/awviIybnhbjiYFNIPWHtTz+14Z/Q1hEHXLULNG6pBry3zQluli7g0WpsEMOvrq3FmIKCvyyr7C6fo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba96a1c-eaad-450c-267c-08d61c4a9230
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:52.3987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
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
