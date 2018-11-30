Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C13C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DE82082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aew5QiVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DE82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeLABgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:36:03 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:30574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbeLABgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPF4bhtqJ+JqysWU/N6G63wLNqMMCtuBE78n/TbjM1w=;
 b=aew5QiVqE9M40G6iaHloCqyrzfHI5Q7NVPvncJ7nkugebaPdeYq+aWCVaOEWVTfVj7xcg36w/PxqDU/n3RQBSxULuw2wpfPb9VaR4jTeXPyWxxRgOv/YE0b0mn74GgJ2kgNVp0L0Dtfn5g/25EwOzQdk6pwp2ioTqYoCQcGJ3+E=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2415.eurprd08.prod.outlook.com (10.175.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:26 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:26 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: [PATCH 4/8] lib/lzo: 64-bit CTZ on arm64
Thread-Topic: [PATCH 4/8] lib/lzo: 64-bit CTZ on arm64
Thread-Index: AQHUiLittSxylaroqk28J7OrAXAvFg==
Date:   Fri, 30 Nov 2018 14:26:26 +0000
Message-ID: <20181130142600.13782-5-dave.rodgman@arm.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
In-Reply-To: <20181130142600.13782-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWLP265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::36) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2415;6:mTfgiZUTyOYonmveB9mShTYWgn7IOFr32i6c/rDeqiawtolNN0UXboXSTuDYFvRJttwUGpZi/BWHzVbj6twtfyV4nWj4q8gWaliw+fFcGNtggkFpoH2UnRfuWtJRQLHESsAqU/am09HBvz0SZvt13FLblhczWrv7tmUIbVhtuEfW4lOEHJlaghkK8vLfhhOBJe1VmFGs/rHv67AJvSl7er6cwx931ypx2J790JhyT88j+W/PV2c0As/vSyNDXr7630K1fE+URZvwH+Fv28jul5mp6cUfCikrxrARLn47qgC7gxpaT3+c2oHnqJO94S6MNLceJNSimFifxZ5Xw6RkFt/Xfs2HsMUFyVGLiw+zz7cqA+d+yr3JeUDXFIrL6F1VSwJE7brZVjG32J+cCLVBNKVEM50Rg6Ub8SP+uhM118tfCnIIn2rtU4/FDU3dfpW1rj8HBWFSZkArWxcBeLJD6Q==;5:cs3hSp4kR/2loV5t31K1fhIWmpJjx0eMr5lRb6asWSZlt+Qj6mt96F7HCPidJAwuAawd7AG+2ShLcnxAdf3ZF8CI9CGo2xSU+WX/VDwvaaiUg+GD69PAcqxb2EiGMTuOMLCbvkaVEFySH1dwNvDn+HhhZkbif1SofJz7jsrEqnQ=;7:15XSEslHHTxKhFrQTZmThujq+HfMcWeGpu12mByryscdWvc8RWhjxc8WQ5SDeu7DkzT8NJ+CJu87+KoZavbYjtF+tsb9Weph5Bxw4uJ9UYXs3+jrxkl5gusp7UbhjyU1QHDcebn7SEHkX+fmy30AWA==
x-ms-office365-filtering-correlation-id: a3e531e0-e090-4568-12ee-08d656cfcfec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2415;
x-ms-traffictypediagnostic: VI1PR0802MB2415:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2415B0CFEBF7420FCFF016ED8FD30@VI1PR0802MB2415.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(4982022)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2415;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(386003)(6306002)(5660300001)(476003)(50226002)(11346002)(486006)(14444005)(8936002)(446003)(6486002)(7416002)(39060400002)(25786009)(6506007)(2616005)(44832011)(6436002)(4326008)(66066001)(102836004)(6512007)(110136005)(71190400001)(71200400001)(76176011)(81166006)(305945005)(81156014)(52116002)(99286004)(186003)(26005)(316002)(8676002)(54906003)(14454004)(97736004)(68736007)(1076002)(256004)(7736002)(2906002)(478600001)(106356001)(105586002)(36756003)(6116002)(2501003)(86362001)(53936002)(966005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2415;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tFjXNrlVkYmG59k01y2yaEqEmsUYf7Kv8xnNDIzMR5W3/rgsfcu693DxpqVK9js4I9yrT/xkU6eL9g/2g3i7XwrB608m/pmkdTHHduAPW4ZloywIF0QN4iDIYy42RO2wmfmEWToyvxFt4fLmIGlPki6gl8GEi9gUogBj5fBrn1cWhYx201PjXZyN1nhtdbsjqPkNJf4qWBlZW5JPnqFJc/W3hG3+cL4SnurlhjDo10zJ+mQ3R3dVL9dOfu+prfpnSyZEdrQm/IzsyjQQTOIpr5GQOBbvxCTRhgnb8r5uY/PSbdDDxi5zYa/W+A1cmWE4QYJrxLp31DeYdemHsrfKxCvEf0U6NGBu+ANZfLlduEg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e531e0-e090-4568-12ee-08d656cfcfec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:26.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

LZO leaves some performance on the table by not realising that arm64 can
optimize count-trailing-zeros bit operations.

Add CONFIG_ARM64 to the checked definitions alongside CONFIG_X86_64 to
enable the use of rbit/clz instructions on full 64-bit quantities.

Link: http://lkml.kernel.org/r/20181127161913.23863-5-dave.rodgman@arm.com
Signed-off-by: Matt Sealey <matt.sealey@arm.com>
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <nitingupta910@gmail.com>
Cc: Richard Purdie <rpurdie@openedhand.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sonny Rao <sonnyrao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/lzo/lzodefs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index c0193f726db0..c8965dc181df 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -28,7 +28,7 @@
=20
 #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
 #error "conflicting endian definitions"
-#elif defined(CONFIG_X86_64)
+#elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 #define LZO_USE_CTZ64	1
 #define LZO_USE_CTZ32	1
 #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
--=20
2.17.1

