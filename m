Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16F4C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC932089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CikEMl5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC932089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeJAHQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:02 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729094AbeJAHQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb5RorVKjb6CHEWNznnZk+4Y37fppfPNdUVZ/G3aKnY=;
 b=CikEMl5XRe9nkuND69f5+SYzTWt29eExPoSxJspOdAR8Zdl3kq2dti8ibaxvMaBzpDVvaeG8RsLguNVyWTNChHDaPXJcYfNT3KjDFQVpe5qEY5tpWMLU1QQbZqOPrjN1XNSKnsjrkaBrHJ0C+U/cIL1llur4KXzLbNWA2j4b5YI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 21/26] s390/qeth: use vzalloc for QUERY OAT buffer
Thread-Topic: [PATCH AUTOSEL 4.9 21/26] s390/qeth: use vzalloc for QUERY OAT
 buffer
Thread-Index: AQHUWR9h0Qqt0+BxJUmuxrWvvIu2UA==
Date:   Mon, 1 Oct 2018 00:40:42 +0000
Message-ID: <20181001004026.147201-21-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:80Nc/fuE5BtNoYYdfb0u4PgNWsgB14p4VeXUaEVEpj1epiEAWT5W5AH7wzXb8QasCVMaTn+Ao+Br3aZ7PefU6b18WAMm77n5UjOZ+fj9Kmyu3Dx8iKZ77dHJw0gMTgFzaDDDEX3FrndpbayftF5TNGQfg+eh53Hj4MD8Nos8RaPKQv9IbdzbCKQDCOjnQUgAkIPdyXTxR4ivCIo9M0ocPLqZgNsGDBhzXmulSGQPwb99j9X05N+s7rebNCcxUf8zv/3AEn6GZI2EhG6nLE1/UIhxltv+hzJVAsMxbQvPtlUDmf1CWXOWpqi/Ov6OTvHFupsceMwVHhG9QCPuJC1o3vtdbFs+EPXzzWiDSn70FpM6IpzG5q3uPAsZlP7PL+U9TZG1I4/MvdbKNiR+GrEFUDU3YPfeWCm+mpSBkHM1h0dJFE22bguyTBrPHeY/8bv+wbfp5ha1+RDWcd2A1bxJPw==;5:h6sGEaZbm2w7pu0te8RtOLAE6yK83TGMh2a2lBm2ZNud2RjGIvekOV2djq474NiH75rwXJBHAqNcthJBrP/exbOxctDcnd/vjWACT+wWRKs526XQsc7p70TfKY5fZvvlbbRhO961GYxfDCZxHMUWrd/v4J7Yq0urmkH9rr4OtF8=;7:TASAS39vJteDGbM7oeEumU8rmnmDdFJZT30Sw1qyEt0pFRQIL2xf0OEIZON1Nh8jKlYpppA8iXuD7y141JW8DwSC0LcZk8VyqibaXH6WKNdQQLgthGdpAL91xSS114gUPdzjagm8oCdpk0uk92a0zN2R7fotccuaL0iibSHDEfCRBW6E9uzSRYDLkkQUIvtvlm/5KvwXNuuHdhbHSaU9Io/R9WMKOIehZoww1I/OSjA97EsWaS4/zjvvY1W0lbiC
x-ms-office365-filtering-correlation-id: 8a1ede9e-bd76-40f5-2524-08d62736846d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165588E7D1AA0FA0B1FD0BCFBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7QirqPYyRN1xVYEqVD6RfGFQf/Y8YxPiiMheuSsF9AnncQcxYbr+0II2dhB6Hy4Zn1HLnbzh1Y7M8CJ9x7NfMotYW57KRmjYZSDSx+mfeQb3DwJ0SjOW6DeW1sICYMgxJehhF+DQv0eFB514XOwTvRt/QcEFwQGtFVq7jjMUaWHuqGSRxfgd52BuPy6YXQd3YHf/W4DK6Ly2tZDp1KzvESjXiFTMxI+5EGUv+F9xexalm38oXVs8wGB/3H0+epJgrkZGcp6uvgD7iBX4d8l/kAV1mlZIO2ttc4eVmnemLifBLAFzKow5i8H8IgRpcbTyxI+PE3WGDx4FuKm5i+xEXUQLpl4hQ4xwWQ/10F1lr8s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1ede9e-bd76-40f5-2524-08d62736846d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:42.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index 258a72869f57..a5e603062ee0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 #include <linux/netdev_features.h>
 #include <linux/skbuff.h>
+#include <linux/vmalloc.h>
=20
 #include <net/iucv/af_iucv.h>
 #include <net/dsfield.h>
@@ -4715,7 +4716,7 @@ int qeth_query_oat_command(struct qeth_card *card, ch=
ar __user *udata)
=20
 	priv.buffer_len =3D oat_data.buffer_len;
 	priv.response_len =3D 0;
-	priv.buffer =3D  kzalloc(oat_data.buffer_len, GFP_KERNEL);
+	priv.buffer =3D vzalloc(oat_data.buffer_len);
 	if (!priv.buffer) {
 		rc =3D -ENOMEM;
 		goto out;
@@ -4756,7 +4757,7 @@ int qeth_query_oat_command(struct qeth_card *card, ch=
ar __user *udata)
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
