Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B4C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BFC2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qgpKVzDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BFC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeLABfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:35:54 -0500
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:30386
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbeLABfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YH0/Fy9rkH1beOwQgOrxjhKFEC9fsiKGvkKxFz4qB8=;
 b=qgpKVzDI32OY8YZTCnAtMp9qBc7QPqcfZxV1yuFiNlorU6hyUQOPla91UE52pp7wLHcULioBij3cUKJ7hotyI/2XciD7T5L1lkRXmSNN1xMpPaySougwXBS4+9KtMNavuBS/LVo6vPn6xY44ZucFNJaAg8JrHm8/khqpZMBJhK8=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2142.eurprd08.prod.outlook.com (10.172.12.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:21 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:21 +0000
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
Subject: [PATCH v4 0/7] lib/lzo: performance improvements 
Thread-Topic: [PATCH v4 0/7] lib/lzo: performance improvements 
Thread-Index: AQHUiLiqITo/LLyl1EWjCUTAJp49+w==
Date:   Fri, 30 Nov 2018 14:26:21 +0000
Message-ID: <20181130142600.13782-1-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2142;6:szz1RH8fw/L7ciNcUIhi3TMR6WIGqbnybqENuOokKZiJU0tybBEdyUuUWdwHWx0fOztB3xFs2X1Sgf73PUde6Hz1NakNUqaT2jokDLYvwROC/ZyIeYRUF9ET31Mf8i/NCASkW47NgmomEd3rzCq8yeycBeXAQLM1MZ8d8kMLZ7oSJxkx51tg66g9OFc5QY6K6Qc6MIDqUx/zKA2dS6MAQg9kvw4myOfqQFLRdTeEV0oC4Ej1YvGjkTEOkxykaUu5UW1PJPo0Pk+xlH4t9n66jp0tpbqByChSMBY2aL4BZ4Nri7KpSCxJtl7pZBYp52B1Hqz6KF+po9pyI48fdS/DWUU+5X3sck/xwNBG7CKQyVtPRU/3+ambOBFc/7+8DZRymhS75pKdFUC/nDi4msH0t7e3SY0hDzCaEwM9KuZ7vnbpAZ/kNUbtO3cXM2BjwCuNLpBCGiQXy9Cs4PomreRwqw==;5:uJYLX0e2gWbQVVO6XIgi/xR4PPZSDXwWbgwsOo6pHE3G2Nt/AqHF6FKjM/NGsqXgF4f3xEjxk1spnRclyGfTck816HezClrAkuHmDA6QkqA54tiQiNc9FHmFoaOKKB3pPSMdRTaFZwox3gYxHft356aB6jMkINwHb/5IhSNxudE=;7:f6rO0s5qLsJRaPIvjjeGFPnTuvrCKM8wOEzXvP6kRwDNu8yf/sWDgfH2x/1Ccf5gjfuyaQw2qb9WhMwgZuaDLBXmGvjnF+55lTXW6PorbCvUe6gnQtOeHHreuYVxFm4IUpl0durVu9p3bljRp7AO2Q==
x-ms-office365-filtering-correlation-id: 2738d15f-015e-438e-982d-08d656cfcc71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2142;
x-ms-traffictypediagnostic: VI1PR0802MB2142:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2142F0ECA3100DAC7F24D7008FD30@VI1PR0802MB2142.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2142;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2142;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(316002)(4743002)(110136005)(106356001)(105586002)(54906003)(14454004)(486006)(97736004)(476003)(2616005)(2906002)(39060400002)(44832011)(25786009)(305945005)(7736002)(81156014)(66066001)(3846002)(6116002)(478600001)(5660300001)(53936002)(2501003)(4326008)(7416002)(6512007)(1076002)(6486002)(966005)(50226002)(14444005)(256004)(102836004)(86362001)(186003)(36756003)(26005)(8936002)(99286004)(386003)(6436002)(68736007)(6506007)(8676002)(71190400001)(52116002)(71200400001)(6306002)(81166006)(558084003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2142;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K9Khrp+YuzKg94CT9N55aeW8E4y5Q4jBt4uLNp0qFJcfD6zlfF6aG5778BPBKErJa3FtV45K5NHqp7fg7j5X6wz8ovUK3CG8uKMI4GcjaYmV5dcIRIy0MDTm/1Gbdguc/BmdVEpTfApEDnkC2o0aj4iK6Oy0azROViCmDU8Ot/E7Y3Pirsa31YkdSxWB5NHNGueBl48LPZqZfJdkmcF6BpSH/cHoMaQWFgJB2MO5WSDz3Vf+ulNAEr/2srVOcGzjyqoh3cSyG33OCrLTbiJGw/jxW6xQniVgALgqD7vlbBDTv06TV0/LAiuEF2FrRaza5HRAzyUeNUM0Xcu/dvQZjeBUqfmY/Vd6uVMGouPcSUY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2738d15f-015e-438e-982d-08d656cfcc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:21.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces performance improvements for lzo.

The previous version of this patchset is here:
https://lkml.org/lkml/2018/11/30/807

This version of the patchset fixes a maybe-used-uninitialized warning
(although the previous version was still safe).

Dave


