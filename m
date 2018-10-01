Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F4C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C072083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PCG6NNV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C072083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeJAHWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:22:05 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:27744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729354AbeJAHPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NummEWlUqPppN6UzKCy2l+aM6Ae7hMxML+jl7FfV7LQ=;
 b=PCG6NNV8D6OLnUURKjbL+sd+3NHBGAeWCZmKIuLLoWQxUYzf07aQ1sTIceHO/EpWvWIPj/pBTjAQOjqNkThsQZ4Uw0HemiRenB8StYs/fAtgHE2LoQ6hPIRoeHPWkGlSu+gk3vHvILkS4qWwLjx3mdW7DlofuCrHthisOL3+3wc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:40:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 32/37] s390/qeth: use vzalloc for QUERY OAT
 buffer
Thread-Topic: [PATCH AUTOSEL 4.14 32/37] s390/qeth: use vzalloc for QUERY OAT
 buffer
Thread-Index: AQHUWR8sD9+DcNP3N02ZqMcqWHcLlQ==
Date:   Mon, 1 Oct 2018 00:39:13 +0000
Message-ID: <20181001003850.147107-32-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:6uQTDMGabi7YyTibD7XQ/HufI2uhe8VMQgAmjvTffso59NCL866nCAA1Zk3O9fyWqGi14kcJFDFnZJeOUoic/VagKnXLJq2Gwxn0hWI+FsaY2ZHM+mJn3x9NgQvMslscbvRh+cB8Z7G7moZUUJi0tFzBpfn25ceorHG2yOK9p6veJSWXUR4o4Mx+a68bXgb0rv7ZEMcxSI4GNlUI0PWbrDFyPl7vIrMy5K/ecEp3B55IhhFELeb2eVB23K3r5xqwMmcSs41HCp1qGOU66Zjr9hQpvZ4aNxfjlB6wDsAodRwAWQR/WMv1OuhA+pT3GPdod5Lp+wW9Kh3QXGPFTB30tDDyit7l8zk7i8Rxspci0vmbP3FDnduVId2Uj595H91hcIjbdT8rQ9IzUL5Xk4dp+3vl17xGOywrxoWz95cX2TWaa+uRztmtb0hqwb5nf7MWacubKtLnUUOZJIRMlInjmg==;5:km3CS4wQKrsUPI0rizMPYKUoUxv01EvdEIHLZpm/NR1NKWoUN60Va4i85VipcRcPllEQ4fsy/8hGkExrk+IUt+JbDSESK4Plf6ZYo44JvlZCjaCyphlB+09QLjuy61V98AV+q9a8aAnFC/eGgnJ20+Ao9qkqVxiPu3+vwYsM5e8=;7:fpZbU7XWAYGdHWoLyevVQwphRTKzt4hO1Rtgl3nUzaHH8spJB9RkQxTaCHNzLCaSx3FNBS+oLW5fwRYCgGzEGIW6WYRBh2+wrq6DY0US+oeUohrjCeV7D5nKaVBHhio/Oj2Imyh+2StjbF9Zph0JP5tzQYcHadiNZcKNII7lTkjrl7uXKhlITpED2itAxiDIb0Yw6ZmtyACPGFrNjkIgrOT5UjNcPwanxYo8i1LRueIM+VMCIGW4U764CctUCsX8
x-ms-office365-filtering-correlation-id: 11fdf29a-0822-473c-ecb1-08d6273676b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB085440B6D11FC018F4A31082FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: uBgIt7913yZAtjBx3SagnSj5dOUDBYwShUNtWEQuor0b7k+8AfJhUn4fH91HrMDK5RvIUnfe2tmp4g+tHMy5lFUlInKpHreDI8tVNxCzEzMy0+pZv/jiNhK+azY950BkwEPtHJPwD1fZEcM/V1eHSetOmk85GFKGByKFZKJlOvS0fcBHCpaI9oq+oznMZ7ANnoDbnt2SepzFjPit5KdKEYLnEHl72cQgSbO0y8iBEruG6dRzg2KBXBw56xvGFuWTtoaDIuUNoWbXpbYbv7OG1hC6D89aL2d3uLZuhNSRiLfgVubhBoQAKUB5uYFhi1hD99eOrZe+SgBq6w/kjsvNfnxq/ouXneVtjJHNL4m4mpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fdf29a-0822-473c-ecb1-08d6273676b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:13.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
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
index 0a6afd4b283d..4f2747cd15a6 100644
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
@@ -4728,7 +4729,7 @@ static int qeth_query_oat_command(struct qeth_card *c=
ard, char __user *udata)
=20
 	priv.buffer_len =3D oat_data.buffer_len;
 	priv.response_len =3D 0;
-	priv.buffer =3D  kzalloc(oat_data.buffer_len, GFP_KERNEL);
+	priv.buffer =3D vzalloc(oat_data.buffer_len);
 	if (!priv.buffer) {
 		rc =3D -ENOMEM;
 		goto out;
@@ -4769,7 +4770,7 @@ static int qeth_query_oat_command(struct qeth_card *c=
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
