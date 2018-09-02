Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B047C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078662077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a508fTfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078662077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIBRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:42 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727660AbeIBRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waYzcIXyAsbyfg2FGYLw2IU7sgEvNxbc3qbfjzEJhJg=;
 b=a508fTfub2mdvve9Rfoq1PxJY2qO4Zengdz50Jjrm1tWj+3pdkyu+p86A+HWEJuw+lB35FROWjlqmttjOK3D7F/mkJjRn/HxUEXK1xl7fBoncNebcb4/O+RvZ1z4WeglHw/asNOcQniiNsKq6u4bLMBZUpjIxH9TdS76Ch6IzVU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 029/131] uio: potential double frees if
 __uio_register_device() fails
Thread-Topic: [PATCH AUTOSEL 4.18 029/131] uio: potential double frees if
 __uio_register_device() fails
Thread-Index: AQHUQr1bdOyo7uXWm0qB/v907BzP2g==
Date:   Sun, 2 Sep 2018 13:03:34 +0000
Message-ID: <20180902064601.183036-29-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:ujDgANcVorgVeUM0eKv9VDNZC516J3Cw/QbtMwQm/5slcQJrt2uzfY3oNfNbZvKjTwgfHNhm5AkmTgCURjztjI0dY/QLF+991vmwNYsul42avOdcyJlKtg0mDRapuIw2bgsYLa6FAGQXFFonzObLjWKYaSaJPgQEp6WKbAEwm7ygcX5ktpkahbJepEfXFcDn6bbaPGTCN/3Lv3oIx5I5wxTMsp2eKoaQaSN3Nms/wq5tziwhFt1kb2pDolsecV+ygSJHt+UKPMYHTpgLIIPEBioR42i6LRzpFRHAFO0ClK38gNPcGHihM56jGrgfa4OoinMWNS77Mj6e7cesS7oCZ+c6ch6V6d9VzmPbP4aOpXVNyT6Yw6AdHBHNFE6Ov56du4KigkNDY3nFPqY4r2Wkl0H62JozAO9BmXXT70gzqeSEQaiD8f4EEhhpPtzOFjKGEhUW1nQWRIhcKw9L0vWMtQ==;5:JW1DXqBaT9BLDE/c1hTS4G9eCwAs4ICHSlk/sN3+AjMlkX/JVRP90pZMSxuXc8R941QbgncL6nYMQXhMC/6E57svIUBGalPPjaI0AIBcN822VAXiKTbR/RzFUBqNykGX6r/jK34gXJDGu0KnFKcx1xr6yapUDCvZ68nssZ0iPN8=;7:1AEo1W2OeT0Q8BWa4s7dFjeYNHQUiBR5BOmrcapkaawn2V+feikhqGYk3eRkuuUEwQFOOCceadcEVoxdDm87wewgHt8/rjBZaJMzWpmwyFsMVpu1uTGdgnlmcuj2r7bwxBXH1+QWmRp+Xj+w0a3umrxAQHwOpLe8+za7z26WCs+8qYY9ljEEkuRVitCmVzPpshKRve6yJqFhlX7jOQh6TIEKj+awvYnYrnstwWTIc2Jv9aHj52f4S/KLRAwvxQSl
x-ms-office365-filtering-correlation-id: d8ed7650-7078-4f63-aae9-08d610d47db1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB015057925E6624BB11C6DC11FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(575784001)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: knWBymH05rZiiH9apCbZeIhoBtArHYMLkP65nIfJVaxxpHNBLf1JZpWGG2kZ6HTrKuThjRs4pJBWqkWW0D6JPpTDngTuTOnnTlpEyLYETnAi0fG4LSXEXrGq0OfeULfDUAqzxFw3c9rmI1B0xWYV76gQG3/Yj3dJLTlAyMJttI2H1VOTL3BYSbs8XQS5K/d2YuNh8gUFv3BkMB7xGuM9faKZs1xN5mjBBZR7XqS5LVnHkR1hAlvTG8ex8bcIcCFkjZWZUROaRl/tI/QHAAGYAeJ6INFnUvWuTT+elNnAf+8y8OW57c+ryKD/UPCujPUli6MjjjBwvIk5VajAlJgMj0sttKzx4pLnJH1O3JP3uyQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ed7650-7078-4f63-aae9-08d610d47db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:34.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f019f07ecf6a6b8bd6d7853bce70925d90af02d1 ]

The uio_unregister_device() function assumes that if "info->uio_dev" is
non-NULL that means "info" is fully allocated.  Setting info->uio_de
has to be the last thing in the function.

In the current code, if request_threaded_irq() fails then we return with
info->uio_dev set to non-NULL but info is not fully allocated and it can
lead to double frees.

Fixes: beafc54c4e2f ("UIO: Add the User IO core code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index f68c1121fa7c..c8c76a0c6107 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -955,8 +955,6 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_uio_dev_add_attributes;
=20
-	info->uio_dev =3D idev;
-
 	if (info->irq && (info->irq !=3D UIO_IRQ_CUSTOM)) {
 		/*
 		 * Note that we deliberately don't use devm_request_irq
@@ -972,6 +970,7 @@ int __uio_register_device(struct module *owner,
 			goto err_request_irq;
 	}
=20
+	info->uio_dev =3D idev;
 	return 0;
=20
 err_request_irq:
--=20
2.17.1
