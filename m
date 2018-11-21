Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED482C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FDF21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JFGcOAdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FDF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeKUWdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:33:46 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:41861
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbeKUWdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxuV52WxKLWy9G8mSK9dAu4U07cFxhvPCMP4ujzpDFk=;
 b=JFGcOAdVX2hbat0iP9dUOj1iT03vytg/H+slOUHGIzywE/8DI5xsVPfp6t+tVWwZthimp8A2hZY+u0dzyhd3ESUBa/cSSMQGD3DwbjZinDJotwVa3UTDbQehGrEiIkkBvzRXob1AKlLp3imBmVMVETgRJrkN16To2dc6MlB/1I0=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2269.eurprd08.prod.outlook.com (10.172.13.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Wed, 21 Nov 2018 11:59:34 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%9]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 11:59:33 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH 4/6] lib/lzo: fast 8-byte copy on arm64
Thread-Topic: [PATCH 4/6] lib/lzo: fast 8-byte copy on arm64
Thread-Index: AQHUgZGqYMXhoVxkT0yDzSev0r3Ncw==
Date:   Wed, 21 Nov 2018 11:59:33 +0000
Message-ID: <20181121115922.22864-5-dave.rodgman@arm.com>
References: <20181121115922.22864-2-dave.rodgman@arm.com>
In-Reply-To: <20181121115922.22864-2-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::25) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2269;6:aJG4Cozb6kWx3kNME4C+dIk2WsyWIOJ3dxH0UTyCjMT6DzZK72G9C84O47WNZMZVoQl/I8pv0grBqI8Go3CYJ9frtlsHhhW1vdUjt0zpFbu6XAiV0AXUc2IfZYCFZnyUkW3Li/E2Fp+mbYXAF7W67x1iPbFG2foD8+GgDO5aPYoClhjpmsVDmt+m3ON8MS5xr4fMOf+kLjf2cnhxGbmYVycw++eOP6hSdlpdp6Djw14/3J2MGU5swu3fZ7Ggz27Ip3Nhlxp1vnx/rhBP/wSGaLiPo0/xDh8iQLN09Ntm95ZN4ZFW9+lEmgAQ9nqCy6qqHWLWneJaeKi4ZM8IjYpQ4YG15Azt8ZLx7QyNFw9CxAaoEjBH+iijJNHckzQWLg4aG3mf3iyZwpYKU9ic45+YFAR+xRb+xgRQleQB/3rnoD3OdD39hTJZrUBnS0SlNq87VNapur+60Irvm+1ZCDeVWQ==;5:ekd2hD+S6eCcvJOJJdhk4Pj066gKWaVFWVOvU6z54/2suvWe5++zQnHwKMZH2bW7eanx+Nx62cQ43FpBjvAlJglzlEThi/+aebqnYT50z6BfAce8NomZEmmDjIAPhjpMHgx7G4hu/XEUMLoiuwC073W1nF2lcVt+eZ5e0fZNJ+g=;7:jwphrrm6ANjUOFn1uruYJZkMg/0rqe00fV/NUJudg+VgACfzjyJVLiKJTQpJFLQCbCMi1ikgZV55yd1swZBN9CBKRpJHPc4fv+emz0P3K1V+791IZl3wwED6RqwJYskl0uUE4FL7JurucZ4rwy+iMQ==
x-ms-office365-filtering-correlation-id: 090d9343-58c3-48f0-5210-08d64fa8cd36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2269;
x-ms-traffictypediagnostic: VI1PR0802MB2269:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB22693DC79E6FB1F0120416878FDA0@VI1PR0802MB2269.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2269;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2269;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(50226002)(14454004)(478600001)(53936002)(5660300001)(186003)(6512007)(54906003)(305945005)(316002)(6436002)(5640700003)(1076002)(106356001)(6486002)(6116002)(36756003)(3846002)(7736002)(476003)(52116002)(2906002)(446003)(2616005)(39060400002)(66066001)(486006)(71200400001)(99286004)(71190400001)(76176011)(68736007)(2900100001)(11346002)(14444005)(2351001)(105586002)(256004)(8676002)(4326008)(26005)(81156014)(97736004)(25786009)(81166006)(8936002)(6916009)(102836004)(6506007)(386003)(575784001)(2501003)(44832011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2269;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hMEsRbLepPvp7nWwltfkZSifK3r0sTRgJpOCPugDLxIz1dPOKMVMjjVculpaRjCbUuDV4BIL+GBrdeGmsM3Uj03PGJ01RC0a1F+f/eFG5/HxiWnCTxclS6P83Xt5We1Xt61fbwVUudfrtA5oTrhD9+qe9a856ixb/weHNNmpby959POjmoNqEcEGTs84Cjd75y2m4Q8zvzBYmEpfjMo8jX15krZdSnWtHE9XZoVRjXS9mhOJB0YvS2b5VawkWBNykz4TLcibjZ8wup/Ci1zV9f2ZrSkcolAo18N3UfUq/NbFOBCozTyzvnICZbqfZPMZttxh07Bgu5q/cI8/hCHKeo9dttP4hCpJYBxJY1DRSOM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090d9343-58c3-48f0-5210-08d64fa8cd36
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 11:59:33.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

Enable faster 8-byte copies on arm64.

Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
Signed-off-by: Matt Sealey <matt.sealey@arm.com>
---
 lib/lzo/lzodefs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index d167f8fc6795..341d0f6095ab 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -15,7 +15,7 @@
=20
 #define COPY4(dst, src)	\
 		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
-#if defined(__x86_64__)
+#if defined(__x86_64__) || defined(__aarch64__)
 #define COPY8(dst, src)	\
 		put_unaligned(get_unaligned((const u64 *)(src)), (u64 *)(dst))
 #else
--=20
2.16.4

