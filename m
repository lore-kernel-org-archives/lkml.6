Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0028C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7332077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jYAMbnw8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kxa5uKkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7332077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHaV0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:26:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54333 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeHaV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535735866; x=1567271866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PO/uANhXYSz0E2q3iiKRoIqZpBsShauzFuZC9Ydi8PY=;
  b=jYAMbnw8WWtsyJM/i9f3ssafWTlAceYEtjvQQ4GxEO/O6ukhn9tx8miB
   Op0CHfkPWw1M0pb9psV5mV5ZCkyn4bnJqGmObdbNiGCC3YgQGQaknpM9b
   HBzrUDmioh0kdI8kcGBz9BJMEDAfdlKsko8lL9Qcas1MG9mC+kaURDZzk
   lV1127rItEvzi707DpVKNtafPNPzwJ6p0/YFUJgUQ34eNbKU/yy0wXiHu
   oW92BG5wgitN3x2qyi7ypJGIoy5pDJMPOHQyMg907Gl12y8iiCDP8cDFM
   ZuXa8K3mss6Kq111Nripoi8rugJ0tJIbb3BvFaTyXbp/KeP2LRtio3U92
   g==;
X-IronPort-AV: E=Sophos;i="5.53,312,1531756800"; 
   d="scan'208";a="92871973"
Received: from mail-sn1nam01lp0118.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.118])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2018 01:17:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ujRCW4Ypc9LicVgzY74lfOwcZTYWMB098uWUta1xw4=;
 b=kxa5uKkrNrjUR9tRRq5XuWs9NfE41tCgxRNm9SBnseiYrS/zVoAWgWzr1Jd0qpe2rXOG0UZJ4cxk91CBf6CbifmV9tLTGjLawSQKYs88+84v824C2RQewBYr3Wm7zu+Jgu5epyIJE84hqRyPrxp30uvqqyDXCa0LTiCDVVJbChE=
Received: from SN1PR04MB1824.namprd04.prod.outlook.com (10.161.255.18) by
 SN1PR04MB1805.namprd04.prod.outlook.com (10.161.255.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Fri, 31 Aug 2018 17:17:35 +0000
Received: from SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6519:abd2:2212:fe2b]) by SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6519:abd2:2212:fe2b%5]) with mapi id 15.20.1101.016; Fri, 31 Aug 2018
 17:17:34 +0000
From:   Jeffrey Lien <Jeff.Lien@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        David Darrington <david.darrington@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Jeff Furlong <jeff.furlong@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v2 1/3] crypto: Introduce notifier for new crypto
 algorithms
Thread-Topic: [PATCH v2 1/3] crypto: Introduce notifier for new crypto
 algorithms
Thread-Index: AQHUQHI9xu2hvSjTOkC0mpV5fsqYDKTaGvsw
Date:   Fri, 31 Aug 2018 17:17:34 +0000
Message-ID: <SN1PR04MB18242CFC7BBA2A40495FA9BCEA0F0@SN1PR04MB1824.namprd04.prod.outlook.com>
References: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au>
 <20180830150016.15661-1-martin.petersen@oracle.com>
In-Reply-To: <20180830150016.15661-1-martin.petersen@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR04MB1805;6:FijkAu5xcoINvWmtOQ5IipE5NJwz6KU04Lfbl2pcOhAweq1+J8v1bDMDW3Se1SMGtUWANdmGnrxXfyYKPstSro7zrNUbYKqp0xo6jcWKdsIcPp0sdHqlMslROYjPtXGO5WvlOvYZFqarL/eF9YQDljp1cu/IYkElIbrolUQZQqLtDU9jibNMVf6/XdZN1T6adYWrhSph2nIyuCYIvIslKdi+1Lyv8C9rNo9AP9BLaINBZedoTw4HxdO22QQDl1LpJHA3x0viOamnWsbEi5LChTj1gtjgZJCMdU4lXRfiGWaaEJb3DqUMKo8JOD7P53zAQ/aDSaFyDm1SV/cfPzN8qp3+yWAzltIgV9C2Hr+Z0YRUeekwd4dwsLWWz3FGzjICmGgeM5jdowYW/xWSXUWA8zFUy0ZJVhpmK2elEYfRDcasJHqDwkwfMX14vL4obtGRyJK5m9FYDJ8nKjOj69Iy6A==;5:rW5PKxfIbkbNgCzF1972XEG3XmAAUKdG0HaRywqmvu1/gsJoMpHHtjy9YR6pJ7IFWCvT5K12062h8ZQ4tApvJkL4DuMgQGelAezPBF++WBBQSAGaKONUi8fjkDFQSQvbxK5mpA0nkP2k+08ODwyk6jVbIRnuSEwSa8gvCsW1d+A=;7:F5fIautq1LNet0osfZR3Ve5H+p4TBqx8NwpoXvlGw9IaGm92nH3QHrIGjWPrytEIlw/v+HnYAgyOPdp/veZdq9lGlfRBFIwL99WU1If3JxVKEHYQ9dIqlGqZtMR5YqNx+RHxgvqdSMWH+vvH4LTqmGAS7asJWgpq7BXYfTvCOnOjXPTKw6ko19QiPN1kWaxy/MSddEKaEaj29p/OE42OjTWzp88gka0mioQ57dSEWV3+VUIlbABL2EA7+KGWbSEK
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c791f788-3323-44af-1017-08d60f65a4b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR04MB1805;
x-ms-traffictypediagnostic: SN1PR04MB1805:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN1PR04MB18050DEC3932F7B558AA1B97EA0F0@SN1PR04MB1805.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:SN1PR04MB1805;BCL:0;PCL:0;RULEID:;SRVR:SN1PR04MB1805;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(13464003)(189003)(199004)(11346002)(446003)(72206003)(186003)(25786009)(6506007)(53546011)(33656002)(6246003)(14444005)(229853002)(256004)(8936002)(66066001)(6436002)(7696005)(99286004)(5250100002)(68736007)(14454004)(9686003)(55016002)(486006)(53936002)(105586002)(5660300001)(2501003)(2900100001)(106356001)(4326008)(81156014)(81166006)(478600001)(26005)(102836004)(8676002)(3846002)(6116002)(97736004)(74316002)(54906003)(110136005)(86362001)(575784001)(7736002)(316002)(305945005)(2906002)(476003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR04MB1805;H:SN1PR04MB1824.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: R4GMDcqdyzVf+IybiYbLvGDsgTTUxPAfaIHoaOstJAuWdRnSEFmWzyq+L2hsDLugVl75i95OzzPQs04PPy2qOXCrfqtwAJCqD0oCF+wRzRrnMHTN4nzAQBV9ymgO+nZzVyAqDD1cL6rK4fMUgZXq4qDxwSSFtIktFu3zvofid3/qEs9XvpRZ/rpozG93lMxfay4jem/oMx9AKVU9aX9wXLztOtHHz2TGS12mmlzcHv9V/SVx8PHDSf2Nek9XyroC8SBf2TdwsfvMOQZX3rftLpfqCslH7dC2JXxqeWqCasPl5mGLCLrtAhwKQprfizpo1hP0DTrEqChK4ixfaox7CDbBIk6tTRgFKTiRtAcjwqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c791f788-3323-44af-1017-08d60f65a4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 17:17:34.7697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR04MB1805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,
I tried out this latest series of patches on my system and the performance =
is matches what I saw with CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3DY, as expected.=
  =20

In this case, I applied your patches and built with CONFIG_CRYPTO_CRCT10DIF=
_PCLMUL=3Dm.  =20

Is there anything else I should be checking or verifying?  =20


Jeff Lien

-----Original Message-----
From: Martin K. Petersen [mailto:martin.petersen@oracle.com]=20
Sent: Thursday, August 30, 2018 10:00 AM
To: herbert@gondor.apana.org.au
Cc: Jeffrey Lien <Jeff.Lien@wdc.com>; ard.biesheuvel@linaro.org; David Darr=
ington <david.darrington@wdc.com>; hch@infradead.org; Jeff Furlong <jeff.fu=
rlong@wdc.com>; linux-block@vger.kernel.org; linux-crypto@vger.kernel.org; =
linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; martin.petersen@o=
racle.com; tim.c.chen@linux.intel.com
Subject: [PATCH v2 1/3] crypto: Introduce notifier for new crypto algorithm=
s

Introduce a facility that can be used to receive a notification callback wh=
en a new algorithm becomes available. This can be used by existing crypto r=
egistrations to trigger a switch from a software-only algorithm to a hardwa=
re-accelerated version.

A new CRYPTO_MSG_ALG_LOADED state is introduced to the existing crypto noti=
fication chain, and the register/unregister functions are exported so they =
can be called by subsystems outside of crypto.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/algapi.c         |  2 ++
 crypto/algboss.c        |  2 ++
 crypto/internal.h       |  8 --------
 include/crypto/algapi.h | 10 ++++++++++
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c index c0755cf4f53f..33522a14=
7412 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -367,6 +367,8 @@ static void crypto_wait_for_test(struct crypto_larval *=
larval)
=20
 	err =3D wait_for_completion_killable(&larval->completion);
 	WARN_ON(err);
+	if (!err)
+		crypto_probing_notify(CRYPTO_MSG_ALG_LOADED, larval);
=20
 out:
 	crypto_larval_kill(&larval->alg);
diff --git a/crypto/algboss.c b/crypto/algboss.c index 5e6df2a087fa..527b44=
d0af21 100644
--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -274,6 +274,8 @@ static int cryptomgr_notify(struct notifier_block *this=
, unsigned long msg,
 		return cryptomgr_schedule_probe(data);
 	case CRYPTO_MSG_ALG_REGISTER:
 		return cryptomgr_schedule_test(data);
+	case CRYPTO_MSG_ALG_LOADED:
+		break;
 	}
=20
 	return NOTIFY_DONE;
diff --git a/crypto/internal.h b/crypto/internal.h index 9a3f39939fba..ef76=
9b5e8ad3 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -26,12 +26,6 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
=20
-/* Crypto notification events. */
-enum {
-	CRYPTO_MSG_ALG_REQUEST,
-	CRYPTO_MSG_ALG_REGISTER,
-};
-
 struct crypto_instance;
 struct crypto_template;
=20
@@ -90,8 +84,6 @@ struct crypto_alg *crypto_find_alg(const char *alg_name, =
 void *crypto_alloc_tfm(const char *alg_name,
 		       const struct crypto_type *frontend, u32 type, u32 mask);
=20
-int crypto_register_notifier(struct notifier_block *nb); -int crypto_unreg=
ister_notifier(struct notifier_block *nb);  int crypto_probing_notify(unsig=
ned long val, void *v);
=20
 unsigned int crypto_alg_extsize(struct crypto_alg *alg); diff --git a/incl=
ude/crypto/algapi.h b/include/crypto/algapi.h index bd5e8ccf1687..807501a4a=
754 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -425,4 +425,14 @@ static inline void crypto_yield(u32 flags)  #endif  }
=20
+int crypto_register_notifier(struct notifier_block *nb); int=20
+crypto_unregister_notifier(struct notifier_block *nb);
+
+/* Crypto notification events. */
+enum {
+	CRYPTO_MSG_ALG_REQUEST,
+	CRYPTO_MSG_ALG_REGISTER,
+	CRYPTO_MSG_ALG_LOADED,
+};
+
 #endif	/* _CRYPTO_ALGAPI_H */
--
2.17.1

