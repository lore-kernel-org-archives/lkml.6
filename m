Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5DDECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4A4208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oErRQ6re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4A4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeIQIZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:46 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727130AbeIQIZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWr03d3IbpI/QP8VyiCFJgq4Lm8/xO+E1ZRH0Qw+fb0=;
 b=oErRQ6re5iWJRFCYgUqpH6P9AY26P/7oiddcqCo/kBJL3799RCItGQfzc9+dIcgAk94FSYuv/lJy7ZtY3z0jQ5eaC115UiS/1eQJ92uBk04blNgofqD8AIP3B7u7nC5BSFNMp0h5irwdfdDvih2m4/C4FM4ZE8Jb90b/QYXHFZY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 016/136] uwb: hwa-rc: fix memory leak at probe
Thread-Topic: [PATCH AUTOSEL 4.18 016/136] uwb: hwa-rc: fix memory leak at
 probe
Thread-Index: AQHUTjKSqxXhiNAsNkSV5ifE2oeosw==
Date:   Mon, 17 Sep 2018 03:00:21 +0000
Message-ID: <20180917030006.245495-16-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:tns/ehJlo0Zt5Qn7u81yrLtwCfGPZLFDUWRwYpcOedUOKLVh7ucDFXkVc1Rp24d9OrDsjui+ir8foOkGK63v62RXZL8ObpFvYw0+5I7BwcAVXpksvKvuE49/ezDOMLpGvCM9zDsHAWUf4ZNKqaIWg+KNMfcUmdGLzzubiPTL51rhQZOMLRA7+cgjaMUSBUHdoIZsNCgzWF9oONNxyOQyTUHRd5cAXdOgE3i5Y7DEWXmh37Uj6nyTS67FIlh6GYcusLDK8AKLrObYpqFycvPbwfngFBkuCbA/W0HFSf7ixS6YCBN4IADJCToPSRcQvIr6Qs37GnQ4KFPfKLIWS/pQizbkmHDsuK2kSHmoCMVabtjZAcfb43gm8cJX+N2EkrM8TsSBzJM5MshsmGo9nsf9ilVtReMuZV4pCBqzlk9zbZ8SYJkU53vEVyunj9L+gtWR1C9W5sF/OZtP5tFdRt8IzA==;5:2n3r0c4H21O/b5uRPCor8lthWNcRhiNKzYaloWYuSG8/uoMtWtUKbGgeyuYqIgexCQg2z8wOH1VxXCoBLSDRr1UoDSQ8XsiaMjSjDCcbBhdXzQGzk492hrj7idTYFgkHmM4BYH7hfBwkh1PJAh54Z7BpnyFFxl7hFBzWIiWaKAU=;7:tvmJ4uaZMbAJ1AgwMMc47QxcxMqsOVHmEbTKanU04hOVwps+p+vUxkq0CFv2N2R5GyqLDPVQHIknO7rs4G95cE74fAHhTVM5CJWGYMSEZAI8kyIOZ7uryV6ObfEte9vJRQ9SYPGV/xG9Vztmjls7ly7+CgdQ2FmOnfxBcLRC86EkDU8AQpEGKaAGt9FDDNxTqKJuvtzXNnJEExalOA/gKE9sBlOeKWUPaVqC2f6uaLNWN4qaANbASZWngbegCZkg
x-ms-office365-filtering-correlation-id: 2e5c1d4a-f886-43ed-c152-08d61c49b6c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277550B3E0709C7521FD9B5FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(4477795004)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xj5SLXNTjH0uHMbP5SpiWG9LO5dnLsZ+qmfWVrAIPzoFvvunGQR241WddixcQ2t1KKYdmXX08EcN8IscyMYpXxm8D9Q1ivRCaPonarTgO6RI8KjcGJPuB8j/fKajNO3h21yVXpbs5wWIZ12I18qUg/b2ZLRwDNENQI3iEByX0QafV9R7jBCk8fefVxOvJIYHhWdtxqeQwqtFabeOOkHKQWeuLSmkUg8ODxZOl72boaVTKSMDhxapiE7znKwKpRAfPE9MpTzWNyAJBz/6utRdnCyjMpt1FAGChFi0LeaLeteAgksUIdiW/MCZBsYMSBkNi3VXvPD+Y0TaSlu/wGEXfSgmg4iZ1jHfQW1qmntOi5g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5c1d4a-f886-43ed-c152-08d61c49b6c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:21.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
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
index 9a53912bdfe9..5d3ba747ae17 100644
--- a/drivers/uwb/hwa-rc.c
+++ b/drivers/uwb/hwa-rc.c
@@ -873,6 +873,7 @@ static int hwarc_probe(struct usb_interface *iface,
 error_rc_add:
 	usb_put_intf(iface);
 	usb_put_dev(hwarc->usb_dev);
+	kfree(hwarc);
 error_alloc:
 	uwb_rc_put(uwb_rc);
 error_rc_alloc:
--=20
2.17.1
