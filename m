Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ED2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688CC217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rZurboBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfBEOUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:20:14 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:26208
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729076AbfBEOUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mkpE7PSSeKxwuEkemNdoDbA6DK3tvHAlYRlJ0Mf4Qg=;
 b=rZurboBnqAdMHWl8XzZ3kOGefcYHcJZbquVv8DWgWJZjbOnxKj1PAWX8EfsD0h33DRrCBDSrCBQZX6e0RXBn4S79q9UCy1gHP1IQ+xF1/UT606GeC9Kx8cnvZVheExvomm8iAYlIlPTjab37xJFcYdEwd3ydpdQxk42vdGY312U=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2158.eurprd08.prod.outlook.com (10.172.12.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 14:20:09 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 14:20:09 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Sealey <Matt.Sealey@arm.com>,
        Dave Rodgman <dave.rodgman@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     nd <nd@arm.com>
Subject: [PATCH v5 3/3] lib/lzo: fast 8-byte copy on arm64
Thread-Topic: [PATCH v5 3/3] lib/lzo: fast 8-byte copy on arm64
Thread-Index: AQHUvV3mpBOmlsPtqE6/ft7UHq5z3Q==
Date:   Tue, 5 Feb 2019 14:20:09 +0000
Message-ID: <20190205141950.9058-4-dave.rodgman@arm.com>
References: <20190205141950.9058-1-dave.rodgman@arm.com>
In-Reply-To: <20190205141950.9058-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::21) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-arm-no-footer: FoSSMail
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2158;6:N+q6O1aXWBoqHqQL4kZWuDgKgYfnmeNdcSm6pBtgXYJhj5s0c44jdj8LaW7Qk8Y37seu4NYekIKZSvH+COyGDmDnADvpmbj3ENpHTHi/uqNOdRMC/4olB1SNxQMN3Zx4sRhX6NHXr9WIjO92AsnesJIAKCnH7H62YUT1266SuRWhMgZ0aCqmIP7rXGPeNdFo/8pT7DU06LjsBUpdCmORqtSs2JxNXLXxVVwXQsoRk+/St8johc3tDUDHzwdbyaFyhbl462DvT0iXU3KjXUJC6x6fncb+uSv/khSZxp5PvG9LCLH23osV7gCpB1stJUYdo0BDfRVoDrxBUio1y+jYF55Ruf3EoUwmeXdq1GysLrf0UyAW23qDI3A+jjZewPRcp17A54/IhwZZQBdxCPuBjRXPGx8Ho/mo0fWjttPe5qzcBGI40qzto8SmPqlu/ivrsFb7vLxU+80QT0voqDlXfQ==;5:vI2bd72T+3Kw8k2stIyo8ZzAgF/zrt0l8U64b9NGCryPB8xjd/JMlD3Cuj1IZXDfIpI4q8+Z03e3y58Q1SqK9a0DNRfvDls16CjcPI33XJG0qwiIweNIAL8nJNF2NdmXsemgoJmWSA3u4tB8YSDWJYRixUTaMKuiKQpFDP0ooK7mtYnZlbgP/Yn4tQQFxPwF3beKOdaSpJlW88/BwpdPNA==;7:BtGGnTwlXDLtoyr0FbZD/oUJzHHrNjoo/3bO50ART5tBssrk2mRX+ZYTEoxttK7b1Xw4TsQwVdi0+b/ZKcp1f4XOF1z2tCT5X33WsGcnKeLB87285x4O6ScIv0ENvyN6dB4b/1mT7Ax2VRXCJzwjWA==
x-ms-office365-filtering-correlation-id: 4107e3d1-424b-4cff-3aa0-08d68b750862
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2158;
x-ms-traffictypediagnostic: VI1PR0802MB2158:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2158BADD0E963AEC681A0D948F6E0@VI1PR0802MB2158.eurprd08.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(476003)(486006)(8676002)(76176011)(2616005)(1076003)(25786009)(11346002)(446003)(68736007)(44832011)(71200400001)(53936002)(71190400001)(52116002)(316002)(2906002)(478600001)(26005)(6512007)(110136005)(102836004)(106356001)(4326008)(105586002)(86362001)(50226002)(36756003)(2201001)(6306002)(186003)(386003)(81156014)(81166006)(66066001)(7416002)(6506007)(14444005)(4744005)(256004)(6116002)(3846002)(7736002)(966005)(14454004)(8936002)(2501003)(6486002)(99286004)(6436002)(305945005)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2158;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tb2ZprAiq70pS0WMDEZdKf8y0H5iIKhQTdo0IwdrX7C4ELk8GRGTaIgjfYieGN4B2MejlKwpZoVm9wPfQTq/iRRs5KB4CaNWptqN0ZLjtzmc4mlBoQX5YOPapvXy+pEJL7JruftKIZZP1SE5VatLRrrIZyqoIWMfYxnTUyFkmyURqbYeedhUom+gyKTffcJpp9W+WZsoPWCXv7W+CAXKh2BsdBDpf5ie9J7CH16q9jrg5jSbUgx/dL9FRxGFgFmE1mCzGnIC/S31PPJ7ASSLFXbzQVGqhC7guZgMlkGC9fZY0vFD9li5OkN6n7WZjZlwYBuJrabK2Fzf+Khzom/plx+BqZbZTx4oIsdXfF1Wijf1VLdLWK/NlzJAttPCUS+jve0lnpXB1g8inaEoATeBoX1DMQedAuYUf6vmBUNKNcY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4107e3d1-424b-4cff-3aa0-08d68b750862
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 14:20:08.2709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

Enable faster 8-byte copies on arm64.

Link: http://lkml.kernel.org/r/20181127161913.23863-6-dave.rodgman@arm.com
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
index 00d1080155e4..fa0a45fed8c4 100644
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
2.17.1

