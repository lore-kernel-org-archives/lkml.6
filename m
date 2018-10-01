Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016CDC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF2320666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WvPXRUrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF2320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeJAHO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:29 -0400
Received: from mail-eopbgr680139.outbound.protection.outlook.com ([40.107.68.139]:29328
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729229AbeJAHO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfxJU4M5tCfqQg347zNgsRosiG4Z9R1Z8drkXgEj/Rg=;
 b=WvPXRUrZ4gnxgbki2hntXLmU1TDckxiONnZWp/jqXQE7Zdd5H/IGz3nZ2vQgczbCEQKTlJnbv9AroY5kwfUp5yQwahZDT+zxVYk/dnIDkeGLAYQNQJcOQJFl9rFxLcFgSmPhkKfFDFBmaOE3VP41hWjFZu38ejaNbWp0Ij0dYdw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 58/65] s390/qeth: use vzalloc for QUERY OAT
 buffer
Thread-Topic: [PATCH AUTOSEL 4.18 58/65] s390/qeth: use vzalloc for QUERY OAT
 buffer
Thread-Index: AQHUWR8Y8lID0PRflUqI7gnK1w5ErQ==
Date:   Mon, 1 Oct 2018 00:38:39 +0000
Message-ID: <20181001003754.146961-58-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:BI2rofoauWXhXNS0V3Wn/N3exyzkxu44gdQhu0tOQzWtY5Xy3dmPqIDxQg7Oj0JNHFHe87hmRgKD/Wzy7CTyCTQQM5h0Uy2ZjNl8PwwdniLO5etMNFliYf16qOKOCmeW0rmxQcZ1+mX8ApGOp5Y6Pju2XBWn/30KhbY+luzrnyWL2qfCqnBTK9lkrii2jngRcmj4PGft32o73y0uGIFKxepcorab2b2qCq69AXaV1tdGc3zTSPjU03fqXpCacOPFylxr/l2fIA5upud59VqWqR8ddELc5IBOct0QU1UPzMnwrbN563Qr1FiX5kY3MLO96qhizwvvq9RLtkW0TtXYBWF7qcu80zPT86R2GuE7fSpqBsZoB5QbfledBWncdQho/hPu/jH+iCpmr7x38dhku/WLi+xsL25sf5a4jRPzHcWlHmbK4AdCiXe3646gwjPbyNWFRmSGgnwRz4QPygcd9g==;5:m7hZO9V21TpTb8nZncMiLcD9At9GAFgoZcXaE54/nGlmKb0CS/NAd2VKSRSlssuqea9q5C7SiZ8+lwEs4GXj2QnqN50fP81q6JZVG5QwngwTD0Z0nEZTB8ELwQgsKWf+g/smnLas4esBY232fVyb6I1TrZm5GSbSH7nX37cMzEc=;7:k8RwqrDovVwGi/amK+NePimDLxIOqhb83iFmT3sgvSls3r4kKkhOW8V/gAOwczqsSJ0n9ZGEAeopPelYZIYU0CYE0XDv5AGg0Oxe/8KZWhhvIhuynyAtRb7BpH3jdpBLvPmZm+GLT/d+/Z0f7Bqj8zLh3+LhsusBrZUHV1N3T76zhl5G2g4nHdHHWazSa9z7qGPVHxEnEOUFN3VdDfSh7mpC4IRm9Bfj0nzjn0W6ggW9iPDbXZTKsZ0ilJQJ+2ET
x-ms-office365-filtering-correlation-id: 4d8a80eb-61bf-4637-ead1-08d627364a9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08245B7E7AAFE31BC1FF3DEDFBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BTNOSTlP7o9QWF8SHMP5ISCdVMQ+p4OQjAvd97+SfHe7Z5DBvd4OLk4PId4Sps0aOL82v69RivvhUbVOmg8VNA7NVHMSV/ReBnM7bqWu4JtEiL4/bidQ8gA8Fgbd9lQmriQ96yiDpKWFsFSLHgnn0+cIEwajarpgrMLKfZMmrX+rZbAnp4P0Ts34AL8YZaXWYhKwjiKgWbX02XE2teokkrUnJWhWEn9Hz71wO7rhGxuTjFAo4VY2/pVFsRpANo3FHEfQ0q01mvviX165S+inysCYKuQ0tjM+mJy09zLItFWxoT8Cqx7h91ThPQ3Kvh43O15OuvPH/I2B2xE1n6pKi06SrcR/5hU6G1hJKzZ76wM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8a80eb-61bf-4637-ead1-08d627364a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:39.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenjia Zhang <wenjia@linux.ibm.com>

[ Upstream commit aec45e857c5538664edb76a60dd452e3265f37d1 ]

qeth_query_oat_command() currently allocates the kernel buffer for
the SIOC_QETH_QUERY_OAT ioctl with kzalloc. So on systems with
fragmented memory, large allocations may fail (eg. the qethqoat tool by
default uses 132KB).

Solve this issue by using vzalloc, backing the allocation with
non-contiguous memory.

Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core=
_main.c
index ffdb78421a25..b0f0d4e86f67 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -25,6 +25,7 @@
 #include <linux/netdevice.h>
 #include <linux/netdev_features.h>
 #include <linux/skbuff.h>
+#include <linux/vmalloc.h>
=20
 #include <net/iucv/af_iucv.h>
 #include <net/dsfield.h>
@@ -4738,7 +4739,7 @@ static int qeth_query_oat_command(struct qeth_card *c=
ard, char __user *udata)
=20
 	priv.buffer_len =3D oat_data.buffer_len;
 	priv.response_len =3D 0;
-	priv.buffer =3D  kzalloc(oat_data.buffer_len, GFP_KERNEL);
+	priv.buffer =3D vzalloc(oat_data.buffer_len);
 	if (!priv.buffer) {
 		rc =3D -ENOMEM;
 		goto out;
@@ -4779,7 +4780,7 @@ static int qeth_query_oat_command(struct qeth_card *c=
ard, char __user *udata)
 			rc =3D -EFAULT;
=20
 out_free:
-	kfree(priv.buffer);
+	vfree(priv.buffer);
 out:
 	return rc;
 }
--=20
2.17.1
