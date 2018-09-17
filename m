Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3574DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AF4214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dC1ztxXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AF4214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbeIQIwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:52:40 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729079AbeIQI2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx2i8Ujjrtc8vebNcWTAluwsA2WWiEA7UHFcfN2A+Ek=;
 b=dC1ztxXOJ50Oar+4yuh6d1V8KZQVTtEizTruUyoEsuR8gKTa8I0gzERaE9bt/uKKd0gWT4k73EWazzGs+DGuZnXMxNZNmE4F8VeMgrFmOaWHy6dscaElo8LIf0DfSeKMcr7jEhb0Wb1u9JgKT6QQQ4u9dIj2SK5s3RhGnbMa1bo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/87] tsl2550: fix lux1_input error in low light
Thread-Topic: [PATCH AUTOSEL 4.14 03/87] tsl2550: fix lux1_input error in low
 light
Thread-Index: AQHUTjLcKmeaVwcp0kiYn2nLdHmnuA==
Date:   Mon, 17 Sep 2018 03:02:26 +0000
Message-ID: <20180917030220.245686-3-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:2ejrD/fyKx+3O++vYXofNlRi3JDgxxjYHo9D871G5ZLM88RbamUjg1FX4zgx98RS23yasbMzYioWkU8u71x1cgZhvLPvjTnWY4B6KmKDBs07HqSopVky9lBNgf025ZinKFOgnypD5txcRpkyXP3pmlhwk9j+u+L42Ch5DvXEjNr9ir9ZK6MTLWPNgy2vG593PdpW66HYU4XXaFtp9iXjokBQkrR2LHtY+zeSSUF5fLg7pW32eEoAkT0lz9cF240kvaq9IpK8+I6W+rjUJJ9LDmjqOT+RonJ+xzqldNff8hKM/wvQtooO0PotFQzEm/wAZPrqJy27DGCDkCTkAoTC3OX4Ba6W0FFDZysG4hE2VWSLc0X/9mtamWmAoGf09u4Jr2BMUps8hdLWPTGJk+nkYNVaINtJiW3LmuC+wU6iURkVpsIGrrTN/9sOQXpikAB7hFJVZjq68j/uiGeCoeHGJA==;5:fDIyZ6ektKLtSt4ITlRvosO9uwtrA1QCn1pca/h+wJ08toXQDR/J1J91U+B+IMMFGamQgXVpRAlgHTfmVkS+M7T+DhpdCfKFspqr25jQS4gOEBk6wmGwjPxzHO/Xycjqp4q8VF7iPRSWWOEArlBuIp5QtKbyULq/+leCuoF6dlA=;7:cd0t0w6+qvJCWTEB2TjRXLbkeVW/u8jDOytkPSksoNYAH2EOTnBoO0odiROVkubqtZ7EkOtbuVQ5zvL7k6cW2BTTrRZN7jjc5QguwyILco7fljoS8VzxZbA+jN8zgGuwi40NFOIHfX3l1Zch3yY5WuHjQM57W//P8mcmn9FNOsxGWir0gdnRdyA/e9CqzWQM4pcIx/l8tZfChwobhiBSoF8snBC+8k532W9RYW0SJEKE+Ehx2Tfm/ECB88FeR496
x-ms-office365-filtering-correlation-id: bb3dc203-f6c3-4e0d-5d84-08d61c4a2458
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB085540C1220E77C705A6A8A7FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Tqem0w8fe2doYM4K+TyOcA1BP2t64hguc9makwF9cwMKU5JTQqDXs7R9TmJ1tEi1FprbI1VloMREjhP4h3b92aZ8A7OBJTfQCr6STqHWHJyC1DCrbPYmKYykJbVmAPZGzvf5QiJb893P6HNyWlG67rOHT9TZCZo3t7nsisgLIUwnLL3apzXG9RpbAYN6aTca32X6NnkNCwdW09ymvWKxk/Qj0LvM60qIqBOrvv0y387IrVbtKsAP9HaIXU6rPAUmSjN5Ay1WgclR+ZJqFFwBox91BMdXGiZMhquPSyB+gfa92dFlvGHvn1tSWl67r8QoUQVmYgmCivQ4H7p/8WWhR8jxtwyUyonHdd8jcEu2JZM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3dc203-f6c3-4e0d-5d84-08d61c4a2458
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:26.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit ce054546cc2c26891cefa2f284d90d93b52205de ]

ADC channel 0 photodiode detects both infrared + visible light,
but ADC channel 1 just detects infrared. However, the latter is a bit
more sensitive in that range so complete darkness or low light causes
a error condition in which the chan0 - chan1 is negative that
results in a -EAGAIN.

This patch changes the resulting lux1_input sysfs attribute message from
"Resource temporarily unavailable" to a user-grokable lux value of 0.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/tsl2550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index adf46072cb37..3fce3b6a3624 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -177,7 +177,7 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
 		} else
 			lux =3D 0;
 	else
-		return -EAGAIN;
+		return 0;
=20
 	/* LUX range check */
 	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;
--=20
2.17.1
