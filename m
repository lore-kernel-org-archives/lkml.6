Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED29BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB22120660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hwK0UFYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB22120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbeK1DSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:18:04 -0500
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:31807
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbeK1DSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CHpuaOAOyZpKd5WUoPljXOMIYPKybq54FO/RuxalI0=;
 b=hwK0UFYI/ih7Ya1zPIa38x3kh0u0ASirFfTKU5uMgnwE+yoGY5EtdWz71ObrWR/dLkLnDL41c8BCDQ92kvoGu66ZC6QIfnsrD3tNULBOlAKsEtlbJhDqECEcb4CTdSswSdlYYFKo1pPUGah9UM0t+eJT2ruo1ii1HRDKsFVZXrg=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2525.eurprd08.prod.outlook.com (10.175.20.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Tue, 27 Nov 2018 16:19:34 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1361.019; Tue, 27 Nov
 2018 16:19:34 +0000
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
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH 5/7] lib/lzo: fast 8-byte copy on arm64
Thread-Topic: [PATCH 5/7] lib/lzo: fast 8-byte copy on arm64
Thread-Index: AQHUhmz7FKy3Xo55gk2BPTn9ExQlKA==
Date:   Tue, 27 Nov 2018 16:19:33 +0000
Message-ID: <20181127161913.23863-6-dave.rodgman@arm.com>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
In-Reply-To: <20181127161913.23863-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2525;6:2vh28xQodBbBVmO7PRJeCrjukdidDZ5q2uIpXK/U8vttd7fKhV+f1LIpsWhDqBDYIA6tJhlYTuAYTpnPgwEnU4pzv0A5zFF+0jH1OGL7DmjCvxkGXpEqUIwnFVLMvYJB4W4gzL/r8y1xpbiJyexgRgzGNb25DtAi8q+hQjgEAFyC/EYq1ibukoLeUSAli1iTpbff0SaqNauveHfQVEC/vOvx3NBk0kTUAZlEfv20bvWu2Jwfw+IDrBQy3jipCsgdmgRTj+Pf5jTXrSZUKGdIbyqjGkzwva56W+zRXvn9IQPJwrnHYHnZCnFVKFJ410W9JY/2jAAU3QNfqEusqYlm6S1bTwgZukdmmqCLlcrgm3ziBWvNsrJQstOTvZ+7sRTPke1XIX8hPfSeykebrhZQnJA5Po9nWl6w1ui/99a5rxVWtG4IdyB7sSErNDE3Mevfkc+x2BztnWuK32aXiITbJA==;5:JthG8yDvhBS0tO9LAFdWSlieitv5qHDVnCerW7uY/b1ecaSRHdU1JTtJOhwn8+e5Te1oMrvUMtchb8jsUh99sDE0kpaMHwB9oQtE7bRK39bueYXiCNMSBi9Ht0L+dCQhVERp3+CvgavjfQV0R9SuI3FCtwjqt4w2gCW/MzQ9P2A=;7:EW6upA+xHw+Eqdrmfu03BKMbDjPzadtI2sXyPWGlWU3HHcm1+VACy36LiZ7ID7ue0hb8U4x7QggQFIDLzM9bv1NCq7Gzu8Rl7VsmVjGiAmpPvx/Pfag5TQrAcBEEg3AIt474KR38ycfl04HI+zVAAg==
x-ms-office365-filtering-correlation-id: 3ce4249c-1cfe-425d-818f-08d654841e13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2525;
x-ms-traffictypediagnostic: VI1PR0802MB2525:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB25254343447270C2D00EC0648FD00@VI1PR0802MB2525.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2525;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2525;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(71190400001)(6486002)(14454004)(71200400001)(186003)(6512007)(305945005)(25786009)(26005)(68736007)(7416002)(81166006)(81156014)(36756003)(97736004)(66066001)(4326008)(8676002)(486006)(476003)(6916009)(44832011)(2616005)(86362001)(5640700003)(575784001)(256004)(14444005)(2501003)(39060400002)(11346002)(446003)(53936002)(386003)(316002)(102836004)(2351001)(7736002)(5660300001)(52116002)(54906003)(2906002)(106356001)(99286004)(6436002)(1076002)(478600001)(105586002)(50226002)(6116002)(8936002)(3846002)(76176011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2525;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ICzj/MPvIwk9S8HkDqilMbkYfsPwQsBGQ995mxMCkPIL8gnDb1tjPmiWOlSRIDjWle7xlsP5EAhFMfCtCYRMwlLV82MdMahfZQOfCUxHQYC2dciDLqM/NNdIi2zpOWLqFKgbO40G9HHbLl86MbGjqtVnTyztIGuqAnnu9TYo2VMLfPC51fdJBwb+nJqwJPFHzJUNG5NjdESAxsjVLEUKPJDooYOUbD+8oqsEMcptWD9ZnhYST2POU0pipclIv2W9FAU0OnO5TnGDy5o6vKMEt0J3qNJMC9fJWUJCcdh/2rRTy8YLkHO2aYclJeKpneRPdhyMfg9HuCSVdamW5Kpa6vh/eFy5ga9JUGt15yXjTxY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce4249c-1cfe-425d-818f-08d654841e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:19:33.9277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2525
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
index c8965dc181df..06fa83a38e0a 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -15,7 +15,7 @@
=20
 #define COPY4(dst, src)	\
 		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
-#if defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 #define COPY8(dst, src)	\
 		put_unaligned(get_unaligned((const u64 *)(src)), (u64 *)(dst))
 #else
--=20
2.16.4

