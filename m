Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459512083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="SHi0ocMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459512083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbeFTFU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:20:58 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:18750
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754122AbeFTFSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOJTqCCOKImubEu9I/qRK+7vAbQ8HfUqquZlldr/A5M=;
 b=SHi0ocMPnQ7RrCFTYQB7sG0CDL8a0gEh/zmuu7YLeOcq8371bkNG7+6M0F5LCah6/BwgosijXC9XwTbN6Ap6ahuPSErXh7RrXO18Hn29urpyNdCb5Gyi8qiBhX2WLOvyOfcWebljeHVBPt8UNOU8q0g6jIJwhrvW34n1tHrPliQ=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:42 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 06/10] media: rtl2830: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:17:59 +0200
Message-Id: <20180620051803.12206-7-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180620051803.12206-1-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 786bc4e1-38a0-4bbd-f363-08d5d66d4b83
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:jLc0zIzrvcjUZcuHdgeIxoryDrmk3UlsMkhU7PhlbgUpCy8+bwEMoQ9VrfhozNVTMosO/WLHqPiuJ/Txm3OD7qPlYhH8x6D+mHFpPCXd8RyfMg8Rg6x5Dhtqg0RjD5a0GDy1r1vp0kopCX1h+YRH/vpF6Go6HMejenfaMD2jz+FlCAx/7jhBmHJ7n78yMSPJXeVN9x/dVJrs+KxWiJ6OjjAMuHeNFZFu3RQmaRgGofM5+JQFSjKWLSZ9IG48Ia1l;25:Oc7EDR2snTIJmpCgxws6l0X2cQXZsyE7Wg4KH65JBmSOAn9eGskITbJ+OBZPd4FNUGR+O+zsyLMBaZZof8leSZqhXg84jsuCwOXqH4TchkOBJjYHC5XTfvYGc2GQRxEnmsn8Cd89dTyOB/xa1xELlh5D5maBvkqutMPvBDdExobBmnVyvt3dlnmvfMK5cKH0ypUG44jdWHMbMHV4XReKEd9UbC2HOMCvwXdPFRIbJTCHH1Wf7UMCml4kFRSkl1d3qQJowqZZQpfDDDKTLmDS1NssUj6WjENFK2SI9+OBl6Z/I6qn22wKeY1AsHNZRKX25WdUrtF3phYM8g00pcCP8A==;31:NknGn7XCMJL5Y4N1WJ4xWGR5XL6xGoX0FgN9RWatm5YTWcf/Locrco/M4/UhkNPYn/lycweLOHahsMrRlmeCsK2/ORxz0EMoCuNqXAb7gGLUadWpPyHRpfs+KeXGTE7634tIWJ1Lr6yef2gY940mrs5mJUAxwL1SvwiQsbIGNLpYT1ZOa8j6zK+1Tr6ynrcjdqxsFE78bYRV65vZNwyOkJclG76AZvAjOuNO3q7trd8=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452AD35547998C250B4E30ABC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:24aqmciruo8OyVWZ9USOmNLzkRcihiVxNofkdQUvdqExsCrYtI+ngJfLANlPr1ntrY2P8KJkGUT7x9IHmyIe2oM5wpcOUoXiSxCbqsH/N6t4oF+B07drXUo9Lhv6w9m0YznQlJcwizlAkrLyr68TKvYAN2J3+/AOwq+1Y9rYx0NYaPhy2tW8TXQlfQcPaJNYmM4zsqDjJMCXo5ZZ8onpiIRNntqg6ostzo/2deR24ibwVLvAOXdXocgqEEowkV9CP1EmjIYjGRUhFWWu5LXpsA==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:O/7fb8X+MpehE7sbh8MmgRmFGYMStdj7t4SHn2a?=
 =?us-ascii?Q?qQce35z3WFXSFtkf44W+86Yo26V3Gj0ogutA7hfffJMUNO6CAbiTGNeE2oEi?=
 =?us-ascii?Q?MewNkMjOxxCBCb/CX7KTAvroktlG460AL0BdeRLlUUouB4dSAOMuUhmz6CLj?=
 =?us-ascii?Q?CNtZzf+HF51XL+NFDKnJa65u7y+BM5feSyob/+KvIXXnpqXgNOkLCAka5zSr?=
 =?us-ascii?Q?UgYVhPLTkjrPAW6wvFbpdC4zGpnsq9Gohh0EQUBMnHfoBUCf2p6G0qS/pd3j?=
 =?us-ascii?Q?76ntQLpPitZbX7Hl7rBZIGyFaR1FWBn83gfRwORpRwmIbp67Nyv/+9vMRgUd?=
 =?us-ascii?Q?g/bq71ow6M5esXVTyMffwwCovRXefDhpw7jXCiiystjA47fS/VWVmp1mdGKo?=
 =?us-ascii?Q?jzRXraMwqRHaqgnz8MQilCiXo80TNMHcgFnx4gsTufgdh46JY6fTfwAx3/74?=
 =?us-ascii?Q?LokvjqsVgy1BwGr4MzwWaWKJImhvVPVKXjJglqoNmn4/3Kt/RCkSI7nG8ppE?=
 =?us-ascii?Q?Lf94pS6UtXvPkermqn+m3M6RA9CBdO+IHDXETNIgs6oNWrelAhqJ7bk5PPQo?=
 =?us-ascii?Q?wukPpLQDiiUo2bBj2OR7lywA+bVNSMSdChxUUwBncMQDveyg5SLFUMYx8fh2?=
 =?us-ascii?Q?48RwSXumlYu2lUpAswVbXPI8gpDsykFt4E2tkTtn3BxjBJKUBLr7TrcSSrRz?=
 =?us-ascii?Q?UtqHieJexqBgrFyoreZ6AsGozEZGCaKSszZKlbwH7OBBsygMc3bxcI0oOiFj?=
 =?us-ascii?Q?zlgxvvZ1riwBcTes0lwl/0h+2DiHlV9Zc9SsYaLBz5QOmFi4mqaou97fyumo?=
 =?us-ascii?Q?a/F5736n5AdItpvhZLs/IFJkYRYVLeju1IN14M/SZguUMhvGTk+DVIcXCiF1?=
 =?us-ascii?Q?pucFUieMTQER6gRI7IBla5R/v3HmgLmoQTK1yvqOrFgeQWIf5SHtX+wgHx+l?=
 =?us-ascii?Q?88/UJb4VQQP12fUGnv/3I8TxalZOtaEaTZFgXnOht03Ob0Wl04oBoUmxeY+z?=
 =?us-ascii?Q?pfF341MB6+d6Aq4T8u17jy8JUX8jHXgMIVI7AkigyMlRLX/n5Np+z9AJcsU6?=
 =?us-ascii?Q?snZzlBhiohl/kAGXyHU7VrjVVNVUM71sIU/vXdlTPBWJRP3rOuEZLXcN/pv6?=
 =?us-ascii?Q?vg1wpC7FLaMfmXRN0YIoI4+THbIwlAKg69gMyriPBUHOKTPtjKHw4bvU7PP7?=
 =?us-ascii?Q?gO7tYwTtbr+CXzFWdhBRRvSGGiLzLc6xEgwTeMbIlOVxZ5VibzcW6f8qMMek?=
 =?us-ascii?Q?/5LLwTTVyK1mFauLCsS3yUt1TstDFi1X83X7Z1RN9sSewXr8hVUsCqHPsJ0Y?=
 =?us-ascii?Q?aPdhalEBHCQa1iSmheM9ePYz0CPCmMdkYXbJIK+C8TIk6nfEdqTiFrEYv5sQ?=
 =?us-ascii?Q?YQbv+8tyWasmjxFNDkMOiR3uryLy+2k8Snvr0YnPJ0qIy1EriICWxBVVyJKX?=
 =?us-ascii?Q?PdVjySHd1bcT0iXevB3iBbiS/UgvL54sw6Y6nehQWO0d0f28dTkZm?=
X-Microsoft-Antispam-Message-Info: N2j4c/Kh5JunkfjCcT27YyV5Is9/Gxg+/YgVY3NjTSYNywphKusMWR+T7/b/Q8cHs84mmd/aHJ/4gtrbMr4ceODhi17RCn9rq+dbpqtDzqwa8lLBhTlsq68oM2rDindabf2i6/ToWnKg1BiNh4DQ7bdQN8V2aXXPD3SqOJkPmjNr7WHJOFnXjHO4CVPoZ5RZq2//8guDxM/fln3XYbx6GMOAdvIFXDGJ7hispHkvIoeWtDvKidbB5v+ntZn05/SzFrnF5uHCwo/aTJRG0bbD7s9UMkqxuY3Y//zsURjV77ushJLWaDvkHGd7Uk2uAzbMJOT0cyvk73a9DnR/rwk7Iw==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:224BUlHTFaA4z3hhsT9YbWZnUH+Eng2tSm+X9Io1FCpjrhBciOmIs/XryEXJf00VY4xNzCbxNdJMKhgavDwDIG1L4mZfRvMjwx1nEMv+qyw+6BHZj2DFl4M4aU9Vv7E01CVCrznbyOWkpPhf1mZyPr/ZHKO4R6Bt1//3ENlHqhc54sJ4K8UyXrL7Vw+ZfMQfdX2FR/hORe33H0GQ1ObdCWEkUHE/plBZ2x4z+Noa1bgxaDN6SV/fyj8k0h5KHGLXKWgIOKxaEgA7CYaQ7K9Sy0Wcip86sa/pe200HnxH1uI/vzgEjPjmW77j1Y/XzdlxzfgPcC8s+hfEUVV/QSE3tHcW2qbtN/Wa9/1LLL1aTyXzGxMDfdvrIpppuJg+KTFXt/nh+zehHv468Pgno5dN/HDR1KdZjqIJyf3ta34gJuIwlBZDMvAnZaZjZaf6Bs94aikT63HJHpm5r7fhAIgR8w==;5:lgUyM/yiSNy11/vn1M4iyWl58F/52QSK8JohQU+AWGVL9HbmrDFzJRGP2vWSqQZhKz91ZJ1nOG9z4RYhfi5Yn/XSTOLRNovHz2jygbl3mEnSjyBALwQt3RcQZKXcEcDz3LiHs6TSZbbnCE37FxzGizpJxbshB3v7EnZt6Vv3uJU=;24:NevFJ4nI6QyN+xPwH/HOLpg78BhR0/eTYNc++vXDtabNLCjfMHKsqPhHG5GTv4GiaxuJVVSEuT4RhRRJuXikRfdm+DrEHYWFlWzWKLrrumU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:fqZdGR3fjrJZ0RmppTX1kOLpRLUCd74CaGn1OWoGReBZusKfnR0mKdXXNlzvJOowtdqg9ZtoDdt28tD2uDkh19zCmbmBHPOTzn1nFkohc9/00IqmziJx93gQN1fMFbtIaQ0F0EKd3UMQXK1spzjF4qGwOyRB9Ww5DzSMckgDSXE4vgTO7h3KQi5tPwyOLP0HbE8JbdSFuYgoTKHCrBbiaVyujHYR4fZKzv8XJj+x7ejhSu4mXaXtHUF6mbjSgdfR
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:42.8574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786bc4e1-38a0-4bbd-f363-08d5d66d4b83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/dvb-frontends/rtl2830.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2830.c b/drivers/media/dvb-frontends/rtl2830.c
index 7bbfe11d11ed..91d12e6a03d5 100644
--- a/drivers/media/dvb-frontends/rtl2830.c
+++ b/drivers/media/dvb-frontends/rtl2830.c
@@ -24,9 +24,9 @@ static int rtl2830_bulk_write(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = regmap_bulk_write(dev->regmap, reg, val, val_count);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 
@@ -36,9 +36,9 @@ static int rtl2830_update_bits(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = regmap_update_bits(dev->regmap, reg, mask, val);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 
@@ -48,9 +48,9 @@ static int rtl2830_bulk_read(struct i2c_client *client, unsigned int reg,
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	ret = regmap_bulk_read(dev->regmap, reg, val, val_count);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 
-- 
2.11.0

