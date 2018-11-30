Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374CEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AAB2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eDYVMf0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AAB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeK3W5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:57:02 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:40138
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbeK3W5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGnRj8n7GjH45SBAmWTGfxkdhSaif/uRbTjfgn4LmFs=;
 b=eDYVMf0r4ULJeq499JcIZ6BhBKqs2LRNxoJiMmyOuY9Qbwk+gL59Yk1uS1OlbxNPEoPxI5/VljW8Lwty6W/bw7kaerP7jdLgTGNeaah+kmv6F7ZqWm4ytm3Mxc0eugZIMxCxxOlYtWs6xnpFWf8KRymmGAZzLJa0VbUKdj6OGCM=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2157.eurprd08.prod.outlook.com (10.172.12.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Fri, 30 Nov 2018 11:47:49 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 11:47:49 +0000
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
        nd <nd@arm.com>
Subject: [PATCH 8/8] zram: default to lzo-rle instead of lzo
Thread-Topic: [PATCH 8/8] zram: default to lzo-rle instead of lzo
Thread-Index: AQHUiKKERQV0N5gGqkat4wTXYrqzdA==
Date:   Fri, 30 Nov 2018 11:47:49 +0000
Message-ID: <20181130114715.27523-9-dave.rodgman@arm.com>
References: <20181130114715.27523-1-dave.rodgman@arm.com>
In-Reply-To: <20181130114715.27523-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWXP265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::22) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2157;6:GM5Sy3WSj8hH/d8AYtV4r7Qa64SUduRYIUNZRc+VpUcP1GLzc5bd70bRI1S6HW0FzRtsgEhwWDtmQrEqtGLCWQRCcsluHthdb8qOXkDPiSfoqFi32b1CILlnqrqgdelsc5y37czoDK90HlB6Pg0YOLzGqQCsEBN+qaQyJqRg8ADSUoJioXf/dH88Q0iEBSNth3Gc3mN6N4CZW8GV+eCQTB6rmgUcFDl2wXjNbq6ee49fPV/3ZrVbBfgz2hlamQXq64VUjU3mMY5U4oSJaPd9nN1LJkW7G2f/F+rflVYMcBSf3x7QZi1CwKR1B7V4/Xd3JPpoGQQxLsLShXpoMHX6EM61YMJY6d/iYNW291/Oes0lCaovG+L7XCtMH855zUs/QXiipjPJlWOpKXrM5/gDyJCQaFZYqIHHsYJz0vWRkckP5GSV9SPk9++O9WOlqspg+kcKxkubYrXAc4gRXnUeBg==;5:8eVGvOfgFeAom070cEJoZSkr4P5ue0eLBX4Uz0RUTKc+/YwrmETTDg6eh3kOyT2H+sgwaeoX1yeaYSblt3k1a7dTQAoQBefYOy/jKNqjzCcZ3I9m47HEJg4Nqwoz1vFp5mNMT/IKWII4y4GRSxTX0/vnH8FpmzhfRV8WPzlwLv0=;7:Fn1jW0EYOvbF+GnMY+aVsXMkdXEqJRTzWL/qm5sSj7iio9T6eUWhEoBX3WPfh5g+BvldpoGPpcJkR0Vkniwf4UHGUKFPLNp2Mf4DVaejuOM4GsWLK9zbBuRP68fMhovrZBQO9mUBoOZPcPQCtkt0Zg==
x-ms-office365-filtering-correlation-id: 6d991035-4a2d-468e-d654-08d656b9a6d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2157;
x-ms-traffictypediagnostic: VI1PR0802MB2157:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2157DF05AAE89498414A88298FD30@VI1PR0802MB2157.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2157;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2157;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(50226002)(53936002)(26005)(4326008)(186003)(305945005)(7736002)(66574009)(97736004)(11346002)(54906003)(316002)(68736007)(6512007)(6436002)(14444005)(6486002)(386003)(6506007)(102836004)(81166006)(81156014)(256004)(76176011)(52116002)(8676002)(476003)(2616005)(71190400001)(446003)(71200400001)(486006)(39060400002)(99286004)(86362001)(14454004)(44832011)(106356001)(478600001)(2906002)(25786009)(105586002)(66066001)(8936002)(7416002)(1076002)(110136005)(2501003)(5660300001)(36756003)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2157;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qan8QmkaMw02Lu4UtOLId4nmvQluE33yx2zegV3ML+wjUfAfR2UXbOs6dAZvIeaitZSsXhgkJjXx9dWdz4ebg38AbAvr4l8ExYKjmPtDddYPI1UYLmxUQ+0TF7yV/qKrWGL1h4uCD+J0PvdD+bOdyZ8ADaPYoMEQbrb5xp1208eN1Wu9ow1dXP/1tofhnZ/wVJbSzwCd++4odD+ifuR74/gdYhyQzR7JQ/DrvGDgIYoKIk9SS0LBB0xtN777nSbfuK0A/w8XqmeLo6NdvlbM3/CQXzSxbSXb1MSw1powz+W/EDdV46LO32+PS9wbzUrqb7pJVPEiUeEb2+L0GtGEYXg2Sml0Oy3gjgQbXo5PXJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d991035-4a2d-468e-d654-08d656b9a6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 11:47:49.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lzo-rle gives higher performance and similar compression ratios to lzo.

Testing with 80 browser tabs showed a 27% reduction in total time spent
(de)compressing data during swapping.

Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 58b025c5c83e..b8dc0976e385 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -41,7 +41,7 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
=20
 static int zram_major;
-static const char *default_compressor =3D "lzo";
+static const char *default_compressor =3D "lzo-rle";
=20
 /* Module params (documentation at end) */
 static unsigned int num_devices =3D 1;
--=20
2.17.1

