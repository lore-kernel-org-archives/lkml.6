Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ACDECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046A6208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ICV/Z3l7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046A6208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeIOGwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:18 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:29586
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728324AbeIOGwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCxC+vmiFKuMzCwyglRLy4LlyE9MW5rdhjiT4k6PHEY=;
 b=ICV/Z3l7eth9PZjxulGu8UeD5hHepZPgGL2BiDE9mzFv5GOhnh6vFUXodbmUPggC4UjhTfC4SdX6pSB3B2QVdCTSja3Kkncnk6mLdeusYLJ68cak3+QLFHGmJnvDmnQ9t7BBysAuOEYoYX1U6zDRhbsxaMKx9ou9XCMhb7LDeKU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:35:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 31/34] dmaengine: idma64: Support
 dmaengine_terminate_sync()
Thread-Topic: [PATCH AUTOSEL 4.9 31/34] dmaengine: idma64: Support
 dmaengine_terminate_sync()
Thread-Index: AQHUTJRIupZ/9JvGt0KfzF9Wv/ISzg==
Date:   Sat, 15 Sep 2018 01:34:45 +0000
Message-ID: <20180915013422.180023-31-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:C8r0N/wSKjQ+BzlAoa7q2ebBMWuBqA7BCZlqNuvMHOzaTAFTsLiZe1w7mf7Bl0OWCem1V31i3qlUIZxkUVpWYMxkR3GEPXopBXP/KlpyuKynU1mAGZSGdIo5uOYiDo5TgietCRAlsrk0eF44i/NOCBToSJt5NZmq7mlZXD/7esgVUIaa4LPYpdUa/uohguPIaKkBZztzR+FpiS94Lzq9rG1ZnP2EVS0mF9ksIn522wqbua1F9+5TqZGqV9bWzfSb4MoXogIuuHx1exizBiju3rX9+8/XP4S5qz7E7x6Fr+EM2pBx241FvbFCQ9zrBCRI8Oq3jBkMQGbOtqGHgDJz/0nHvqSFkDTvF7bXbgB4fTbED6awPceXtLJgARn4WiSK1djr2CjX3Giehp8Jdy6yMKM/PwJc6JtaMvJMTJz/j9GpxxhmZv8AqP264ENeXp2XSP+XclFIy1xMJmahUf7TaQ==;5:wffeGavycxO7rT9HQ96FgADcbs7/JRA+Py4bm/tV0dbicSCXVhYfzNe/N4fVRzK3ZtSmoIZ1nJN6ZZoGqPBR/MdjmezqCZjo9ZQGH18H0p7KgJ6oIAlHg1ndrBFriy58rZ9ZiXuBsd42KRqKGjN68aTKEzTzLMxsQRqykweMVCQ=;7:eTM5W6MgOiv2dNiLWZY824vMdSX//EGxUDrwMYljEqeXdLQjL6ce9WWAPp6glNaPVTGHzBLwrRM3k+Wn2hijeND/IAcmp7CSScHaeGdOVSE0jxthFdxcr/MKw7HdxcdijUq+9t3g95GMSf5pWy/5yUqgpEGsdKA++SVmHz+18OYJrT2de6UHLIWloy25sQ3TxwUEG6rioV4kBz6O342EDykVszzhWQ4WS1UlB5tGK2KlgQhOCervCtGM0q6+l+KX
x-ms-office365-filtering-correlation-id: 9fb540ad-c2f1-48ef-dc0d-08d61aab7cf7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08235333FED339550FA5E1D9FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(6666003)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2mNtGiD2FJbluZy9nYvNszV8MB7XHcbObFUTu6vSwIxD/uHXiPJ6Cdm28PapTqbgsAKXha/YW/v3nCRLkvJtfhI9hrjGRi9H6N2NqJt1ZA0+Y2kHLfnvWWAPMJTFH9q6F/vF2/IIW6k9J5x+C6RB0/gNwkP6MzRvnolG4hlNgpzXK1Naof7owuOeNT0IzwFohIdEZYi+eTJ+wOZPsz+RFT6O5FmrS+xvBMZUFY8qaschGvi3j55wnsfOW4oI4eoFvAun+dhHi1ALy3hDbwsPPEgUw0QXJ5Sll90RvuCtLH4ShL6/wm1w7Wl8gZGZz0eNieCvGowhumKI/RVjy0y/05S76Ddl9ZfhwMT6Tm1SNxE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb540ad-c2f1-48ef-dc0d-08d61aab7cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:45.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit bbacb8e78a3b29ebdbb6af7d54fcf25d3f1c248f ]

It appears that the driver misses the support of dmaengine_terminate_sync()=
.
Since many of callers expects this behaviour implement the new
device_synchronize() callback to allow proper synchronization when stopping
a channel.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization s=
upport")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/idma64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 1953e57505f4..2ee93cf98f00 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -496,6 +496,13 @@ static int idma64_terminate_all(struct dma_chan *chan)
 	return 0;
 }
=20
+static void idma64_synchronize(struct dma_chan *chan)
+{
+	struct idma64_chan *idma64c =3D to_idma64_chan(chan);
+
+	vchan_synchronize(&idma64c->vchan);
+}
+
 static int idma64_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct idma64_chan *idma64c =3D to_idma64_chan(chan);
@@ -583,6 +590,7 @@ static int idma64_probe(struct idma64_chip *chip)
 	idma64->dma.device_pause =3D idma64_pause;
 	idma64->dma.device_resume =3D idma64_resume;
 	idma64->dma.device_terminate_all =3D idma64_terminate_all;
+	idma64->dma.device_synchronize =3D idma64_synchronize;
=20
 	idma64->dma.src_addr_widths =3D IDMA64_BUSWIDTHS;
 	idma64->dma.dst_addr_widths =3D IDMA64_BUSWIDTHS;
--=20
2.17.1
