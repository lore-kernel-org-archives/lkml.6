Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922620665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="wjPdfkJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3922620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJZQRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:17:41 -0400
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:7492
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbeJZQRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiPGo0CEqNI2z/Pzwrbm6LlxiQ/CKxdITMC5yKNKJQ8=;
 b=wjPdfkJ//GdCtwqyU/mwrut81gk059kFaMgJqwf7pR+CQQyPoUGO986DO65bLuIMRCfxYcpNaDYnNKIYdcNMWyiHMmoJCUcL7ucLHyd86dvb8ahbzn0KMt+/UyNPxHI0sN4RpJQVXXxSbZ3AHbsVE26aajs6wo3d41c7/jdHgQE=
Received: from SN1PR10MB0461.namprd10.prod.outlook.com (10.162.102.29) by
 SN1PR10MB1008.namprd10.prod.outlook.com (10.164.24.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Fri, 26 Oct 2018 07:41:41 +0000
Received: from SN1PR10MB0461.namprd10.prod.outlook.com
 ([fe80::ad75:1416:ac86:7388]) by SN1PR10MB0461.namprd10.prod.outlook.com
 ([fe80::ad75:1416:ac86:7388%2]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 07:41:41 +0000
From:   Mathias Thore <Mathias.Thore@infinera.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] uio: Fix an Oops on load
Thread-Topic: [PATCH] uio: Fix an Oops on load
Thread-Index: AQHUbPxTQ0zWZR23OUSV++64OIH+4aUxI6Og
Date:   Fri, 26 Oct 2018 07:41:41 +0000
Message-ID: <SN1PR10MB0461756071FB42591D66941684F00@SN1PR10MB0461.namprd10.prod.outlook.com>
References: <20181026071951.fzapvcruvzknkmo6@kili.mountain>
In-Reply-To: <20181026071951.fzapvcruvzknkmo6@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mathias.Thore@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB1008;6:4jhykfNMUElN01sqaOsmBdG4lT/hJdWaBx3Ehd97b5nNB51taT25Lda0pctmreMj3gT5XuP/nq+q4ApptN+Xr+JYwHL06cWojBFKNtmDKvgwqzU2e3BiaF+lBuvRnUM4C34SyRo8yUfB4FDaamJIy2xM+kWUzsUZpTNQB1gaHjMeIX0F5R+kyBeeQwO/EEiq0J2L5CDfyrMleJa+pqKpPp8HQcHpd/e7bzMoo/8Da08P4OSZzBW1ePXN/g4b7t7fTcG9tVI6Wpqx3GTrq2yfSyqxuCe2wZ0X9PolT0jOvkpweTXdex0ku1w3VoJx42QcwQ6vcM7Yiffzv2Z8qzWSXf2DS3tymmcL5L42J/4VauVlRk39d+W1gH70tkgtXyoERRYBYz3WyUL63tlR7p4j3W8Nh0Bzhc3JkWpUHBljf5YYrziI788JE1bQxqHJn5PgvFL+a1IGhQBSusr3mdPnUg==;5:fLx42bSjGfNpHDc7b4OeuloNK4S5m+6RDKCJoHJgexoxJVbcrChgF16NykYZ0htd+vmqcJW+2TENalKNwhLCYLlmXH6kHdXsyfJ2c8U5WQaGbCFjyavixdoYvhS9TPGyQme8mUP0C/vDNBtqlTS7VwgZAlEY3ipMt6oU+TRWO5o=;7:76aQoxgUwgSDHHNcLFODObfcUQYpR7nthi48QVzs0F3hUKGWROcDfeM8ngxXsHCKb0Ar6HkWYvW5Jo+/O2opbpNLacb6s+UvKK8qqA2T8tGESE3Cb1ro7MMFkXbxxW+hWwypD+4e9BWUkaZ74/2Fow==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f59dd01d-fb7b-4b46-e7dd-08d63b167834
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB1008;
x-ms-traffictypediagnostic: SN1PR10MB1008:
x-microsoft-antispam-prvs: <SN1PR10MB100887E99841AA1815B5191284F00@SN1PR10MB1008.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR10MB1008;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB1008;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(366004)(376002)(136003)(199004)(189003)(51914003)(13464003)(3846002)(6116002)(76176011)(102836004)(53546011)(86362001)(14444005)(6506007)(256004)(5024004)(99286004)(229853002)(110136005)(74316002)(478600001)(5250100002)(26005)(71200400001)(71190400001)(316002)(7696005)(5660300001)(4326008)(9686003)(25786009)(68736007)(81156014)(7736002)(72206003)(8936002)(53936002)(6436002)(2900100001)(33656002)(81166006)(97736004)(55016002)(14454004)(105586002)(305945005)(186003)(11346002)(476003)(106356001)(66066001)(486006)(446003)(6246003)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB1008;H:SN1PR10MB0461.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zqXLlSLSsgPEfSzn2QyTXnnc7XN8JoDW8K2AQTGHcO3Wa4d++56xdbN1q4Bo2G7DacOqRawQTrp1lbyxjA5vOIGcDgb+u/dFpkLG2gwl4EAdRcg54Z24IZtX6e4cr6dFldJ1NJebdMyl+9USapJpgJmAUR+G44JjAWbWuEFAr3Db2FV4znoOa4zj+dGV1rnmztc6MAM5TtpoHH13yywAQePD3N02RPT0SjLrR8cqmGFAs8M/SYlGJecfgujYVuGzNcWMvvff8Au6PM961O/PpbzKRi26V8pCLvIIHPLF1qStBhev2Say4KGINUn5mkTRyuyWplIcBNRJdt9dR9Vb/eL3ST6JXOR9tA/MOJk+o9s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59dd01d-fb7b-4b46-e7dd-08d63b167834
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 07:41:41.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB1008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick fix. I've tested it and it seems OK.

Tested-by: Mathias Thore <Mathias.Thore@infinera.com>


-----Original Message-----
From: Dan Carpenter [mailto:dan.carpenter@oracle.com]=20
Sent: Friday, 26 October 2018 09:20
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Mathias Thore <Mathias=
.Thore@infinera.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] uio: Fix an Oops on load

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


I was trying to solve a double free but I introduced a more serious NULL de=
reference bug.  The problem is that if there is an IRQ which triggers immed=
iately, then we need "info->uio_dev" but it's not set yet.

This patch puts the original initialization back to how it was and just set=
s info->uio_dev to NULL on the error path so it should solve both the Oops =
and the double free.

Fixes: f019f07ecf6a ("uio: potential double frees if __uio_register_device(=
) fails")
Reported-by: Mathias Thore <Mathias.Thore@infinera.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/uio/uio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c index 85644669fbe7..0a35=
7db4b31b 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -961,6 +961,8 @@ int __uio_register_device(struct module *owner,
        if (ret)
                goto err_uio_dev_add_attributes;

+       info->uio_dev =3D idev;
+
        if (info->irq && (info->irq !=3D UIO_IRQ_CUSTOM)) {
                /*
                 * Note that we deliberately don't use devm_request_irq @@ =
-972,11 +974,12 @@ int __uio_register_device(struct module *owner,
                 */
                ret =3D request_irq(info->irq, uio_interrupt,
                                  info->irq_flags, info->name, idev);
-               if (ret)
+               if (ret) {
+                       info->uio_dev =3D NULL;
                        goto err_request_irq;
+               }
        }

-       info->uio_dev =3D idev;
        return 0;

 err_request_irq:
--
2.11.0

