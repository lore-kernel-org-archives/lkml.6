Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD59DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8481721104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Z8Y7EDS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8481721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbeK1DSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:18:08 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:11920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbeK1DSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OLi/fFklxX5u3TdhwqFodvb/Pl3FnXVyWkTz0VYnsU=;
 b=Z8Y7EDS76B9f/wNblYn8uYLXxYTzzdRv8V3i7HzQEc3EYPXltMRCUG3BCtidRjEdTGOJXHmfz9Ot3bqRmcH0VnwcqohzJSqUV1O7V3eTc2NF0GjuajJ2T6d5hevCM0Ped3g0nvz1gV7iKPwsMZnSG+p6lsWWyB8rvE0dz0tuUK0=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2256.eurprd08.prod.outlook.com (10.172.13.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 16:19:32 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1361.019; Tue, 27 Nov
 2018 16:19:32 +0000
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
Subject: [PATCH 3/7] lib/lzo: enable 64-bit CTZ on Arm
Thread-Topic: [PATCH 3/7] lib/lzo: enable 64-bit CTZ on Arm
Thread-Index: AQHUhmz6ZCtm24FggkKLFuCU+TkHqg==
Date:   Tue, 27 Nov 2018 16:19:32 +0000
Message-ID: <20181127161913.23863-4-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2256;6:0r3JQbzEH1TOsftAaMlLcLP4rNuChkiP07meEhBp/xP0i5YYbvO1WMwWLjaZ8e1iaHuHiSq6aB3/uqMtloDDsjN1uG89DciYkV72j8wV3IKDJfFS53BB3obVFqHufMdFYLLMv79g6rQT6tQUBSbTYgYTWZlxR3TxKUAs2zUr8Ed2ucm7+/B6lRqjV2fZkB9lSUETWwEdKZvlwkYggtZj8fY/huHsLzM1v+YrumlVB7ZUbfAedB9RrTJpfpFzvrP/LUiEh2SlJx2gUM9tbtQsYpmZVS89IW3Tv79OytecFuLw+BmHaA6gwpJ8BhFSpjT2csGDDUpSsAzWEeb7eMIN7tu4HAzhwy6okaPGg2x9hWlifcG/Lc8kwc2teR5+3jALduMWFdX5gx2ZUN6wJlcT3j6yoE8xtwSH3aE2iA/rsE6DbzY52RWg4ryVE91kPOieNRN1Q4I/f6sIDqDOP1pUHQ==;5:MT8Y8vttQZkgaCgy2ijOL7foMU59ZlW4nkE0SluDmxKAttnwXeZRWwgcoSJLVS8DuDi7T2e4JqXnq6P4u2XdEfenXLx8nQIvOScNIjfyYvi35ikfEnvmOpHJlkBD4NICssXOHMbRKcPeHAzkPFI19YeEGT6Mwl80nu/O0HlzOUs=;7:VSicTDWfvbZvEt4XTZ/CSetQJ/UVA7TdIuBdlc/PTqO805gNuqx+zWZGW3eHziXTGbCvv2A5El/MPQ1nMdA6fche5mhSL6DXKDlbnyR5jqboBEDvX2H0qCc0Fb+PbdjccnWeE1bQucAz07jtacmM/A==
x-ms-office365-filtering-correlation-id: 7876d7c0-1247-4731-d90b-08d654841d34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2256;
x-ms-traffictypediagnostic: VI1PR0802MB2256:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2256B18F361DD409BEF111538FD00@VI1PR0802MB2256.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2256;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2256;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(2906002)(106356001)(14444005)(105586002)(2351001)(256004)(6486002)(52116002)(53936002)(99286004)(6512007)(5660300001)(54906003)(7416002)(7736002)(6116002)(305945005)(1076002)(5640700003)(6916009)(446003)(486006)(3846002)(39060400002)(11346002)(76176011)(6436002)(316002)(476003)(2616005)(44832011)(68736007)(4326008)(102836004)(386003)(66066001)(71200400001)(36756003)(478600001)(25786009)(50226002)(26005)(6506007)(186003)(8936002)(8676002)(81156014)(81166006)(2501003)(97736004)(575784001)(86362001)(71190400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2256;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D+fI4AejVukJPXWl0//6ix2Ur6H2GF4N7jg+Z1IbULfFB3e+qfWCil0X5vp19zp+jUpq+DnpezOvNzvuTW8iKlo+xENO12M3dpV+SRVPw8rOFRBj1VPCm/2uqkMYODodSuwIywDubBQBfmbm9cyL9r4iczDwNlZRMO/ejRvrw7OuWtHdDArVrg1ResgwrevH1dLxViJpnSf+oaIjUh3e3g9wDqR7P4fP0v9ltzebIJix9K4h+39rqX58LmXt1tJbucz8ZjHQZALfzOhxhjusllKLFwIdV4UM/FEts3dyh74WbUSkbFjQ6X9xj9v54ZoEuCp62ZR+t4jChwEj7w0esHs1DJSGshOk4qLYM2/v2Y0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7876d7c0-1247-4731-d90b-08d654841d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:19:32.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

ARMv6 Thumb state introduced an RBIT instruction which, combined with CLZ
as present in ARMv5, introduces an extremely fast path for counting
trailing zeroes.

Enable the use of the GCC builtin for this on ARMv6+ with
CONFIG_THUMB2_KERNEL to ensure we get the 'new' instruction usage.

We do not bother enabling LZO_USE_CTZ64 support for ARMv5 as the builtin
code path does the same thing as the LZO_USE_CTZ32 code, only with more
register pressure.

Signed-off-by: Matt Sealey <matt.sealey@arm.com>
---
 lib/lzo/lzodefs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index e1b3cf6459a9..c0193f726db0 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -33,9 +33,14 @@
 #define LZO_USE_CTZ32	1
 #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
 #define LZO_USE_CTZ32	1
-#elif defined(CONFIG_ARM) && (__LINUX_ARM_ARCH__ >=3D 5)
+#elif defined(CONFIG_ARM)
+#if (__LINUX_ARM_ARCH__ >=3D 5)
 #define LZO_USE_CTZ32	1
 #endif
+#if (__LINUX_ARM_ARCH__ >=3D 6) && defined(CONFIG_THUMB2_KERNEL)
+#define LZO_USE_CTZ64	1
+#endif
+#endif
=20
 #define M1_MAX_OFFSET	0x0400
 #define M2_MAX_OFFSET	0x0800
--=20
2.16.4

