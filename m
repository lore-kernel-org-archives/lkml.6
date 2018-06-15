Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F1DC6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94260208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="u5GoSfb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94260208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965693AbeFOKTK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:19:10 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:10720
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965610AbeFOKPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90keiCHp3IDfvV63uqmCdLfF94S0mbMt3HURU0OhIrs=;
 b=u5GoSfb44MNtQriNCyxnaRR6Yh9uOcaGxWRchvQ5NLjK/1Oej3y7hGAqjaHbsI7EH5BykZgfiI+MGxpHASwrnFfY3MlKUzv6lI6yAW7UeqCrYC/pfrznHPtbRQbwcVRyZAEL7IQGa97tzdMRDXiymq8ckMqNTLTC2ZQb22bAVbE=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:43 +0000
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
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 03/11] i2c: mux: pca9541: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:14:58 +0200
Message-Id: <20180615101506.8012-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0248.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::24) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4267fde4-44ab-4eed-7c88-08d5d2a8f475
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:eKYM4/PTuwzBQpcwyWQKDKYFGt8Sjq8+f7MJfPk7V74ISaaRgX03q0cL7rJciTvpSXJ1Jteyj44L7yiIz2f7ksYeppNzn0qskjim+5XTlIBOgf+LmOHtQEOQXIK8r+R+HZCIFi4HLEOfUIrm/R/wM98h5oMnGd6xdMxpGsZ3BHtqGV2/sqfrDxnv0rrYUjOA/NflQ9vK5mqVJK0Zm2whc/fViwOZkYOxMlPOCFqZHl+PLw0yi8FxTXmrC4GrHyWU;25:zjr95wGtvktLZFtC6b4imW+UYb4ji92oNGc525XhsYGpEK12+Hc7bmOI3QJlWwL+k11dIoZI+/xYeQLRwEMyMFmYSENpZfYL7wlcGmmEr2ax7iiP9TFFHo8LN34SA98U4WeYDZxYiqnrcrlu8ArenNtv7aEztUtXOimkS4SSiKLFnbJNywCTmb5dZWIAeyUN7ZbS7x5oPBCKJKOVlIH0bJpC9xt0AAkHndjXOf5DHsjLWYKpeUh+EM9pJMeLR4UeQMpkhnAXVAnCDIbai19BzdKqh9HI6SUw/ad2nypLC7KVbOKB/wnKspCuKDHa6YKUS+GIJkMYddpB6Y58DEsx0Q==;31:9VrqSrZ1pI83fgvp2EOkxD1y5iP9Dhlys+9+PiAUnf9GO1DZYA6YE+qyCE8dSPczHDhv6EZF90pyqilRMuMvsC33wDqnY0mn1tc2W11MjhOmOGS63WsNIUzoeB9wmjhsSkwpthLqiGwv0J7Zv0cP6ByuT7d0tI780BFn1DtKSKfW5QSAzw/+pr/HTydQl+mX3Or0FQu6kNUW6yQhnuRY3r7Yy+l6UJQUNNQpvkxFglE=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460EA1E0A64FFFEFA58E4E6BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:IaYtehS/QzPzebgu2PkTop115xY8mdWkQoTwgjAEUxNYbmEhN86nOgb+8Gi/OPR9QjcHuZ02nNPWc8I4S0CiGJY7lkX9xGfM83xqd/yDTPfkCNpJZW86vTiINivhLtR0SKVk2tTzGcdty7HMyWO9YXqMeUf5dZNdHpjRjQJ+zM/AHNNBTeflPnHgOLnlZ4MvlIhPYbWFdJk268RFUVBANUtwPOHF7U01iFq+1HD5gao+2IYRiXqHqmC4V7WDYEa5QsNDYFZsBweKlfEi4GEJ9g==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:d/PcocjkYUm+95xovb/4La5eXz6tfNFbUFWBn8Z?=
 =?us-ascii?Q?aLGBHPHCW2FCCjBwygx+kFnf3zqXuAps3yw69MhTAYPj+rR9wHSL48Sa2M9l?=
 =?us-ascii?Q?eomK32bzUWFRau7LDG2kK7xoD1N5DwX0om+ro4EgjKyXwKA6tNy0/z800Q1x?=
 =?us-ascii?Q?Fmxl3Nr0acTIF68JblbFVOZXC6wIQv7DS1XX1VXu/sYODmT/rTuP5IY3WFm6?=
 =?us-ascii?Q?OlJg6VqY/jWDSIwSXofHt3MrivbxLXvF11MTo8RW5bSQAHhSGZzdQowIfqKq?=
 =?us-ascii?Q?aWQAXPBnALKRsIVp+IQaOidPIxdAmMsX8RveFcUof+uz+mioHVn6RYvOuCLj?=
 =?us-ascii?Q?ZSVrbTWFbrGbcDuYu/dcD2F2H4Sqtb42EyCx48Bl10f3O9SCm2Ch0OwenOwp?=
 =?us-ascii?Q?V3XHga5arUoqH9MyFG8Aw85L4G1gOFdK7DCsX1NLrNlTSYeoOMsfmLP0R0FJ?=
 =?us-ascii?Q?pu7sKqK1EHqFbnXdje0+HI1CVHlu2TXzZAGxN7nlNMGcsUWOZeXiDxZ04YhC?=
 =?us-ascii?Q?cPQ8Ttkb3zaoLnw+Wxf1eoMvJoQIQ4ikVEuIuD3bJFsg6JUEx2VGfYRmYiYh?=
 =?us-ascii?Q?BptkcfJBDcL8Vbaenqj00Rijatno0HCdV/B274sXjF6lVUh0vU4JFl6fTNIg?=
 =?us-ascii?Q?EOBjczY84ssp1u1aroZCAYk/RVDVYsZjAZDba3KVfgFOuzMiUFei/xnMU4DQ?=
 =?us-ascii?Q?kPDWC6lgr5agKm2FJlg1iGqICZITunb+zT7tm9saU+2lonvk8L8mNWqzj5bX?=
 =?us-ascii?Q?FHMWkBxJQ5fFxq9jTqvArXoopsqLWWN45oB95bsVpy7Z4yT7Vyx42dV0EeFA?=
 =?us-ascii?Q?0rlZoD2wnlikABeUWc20STCoQQ/YYaKABCijCuXKl9M18HmThNBRfkHVyNyL?=
 =?us-ascii?Q?BWNpZjGC+5e8TifjZwAe9d0SgoLO+VP09ZKiKpOeW+BlblkcIU0exklu6Mmf?=
 =?us-ascii?Q?j2J8tKcaHjnSP4RotWBUf9HUJEJep9s+8qM85LsIAx3goFzXuaAaWGo6kO5b?=
 =?us-ascii?Q?+Er5+Z6Rsc1KqB2LAnQ4P9CDX/2H/bEHH4ZKscHMsLGqMdSy5Nn7/yfJUTet?=
 =?us-ascii?Q?j9k7ygQedhRiy658NZnB5pYuueRgs92QkD+fCt/R2B0RXXTHJrswUnzkdLtL?=
 =?us-ascii?Q?7XkiOTMeMb+G5Ft2odjylRR2ohNpMVJePPB2WxwxknPN+Fx57xfmH0Aj1fkB?=
 =?us-ascii?Q?p3t8FoDn5wTCq/kNLmCkiRrkN6m4K/7wY3H6Qlp9+7xJ50CnTfQ1LckSVPws?=
 =?us-ascii?Q?NID3eOiYKDAntFp+nBqlyjcim9VA65LcPUKNxI7LrjSmaQBKv8Tl1dpX4VyZ?=
 =?us-ascii?Q?SSbaOw2+M5qWXYYDXLKDnSn87Y7fIgR2vYYjo7qW4tsxsDjQeR1YqWTlI+yA?=
 =?us-ascii?Q?mZE7pPQ0u8LQEitfEeMiw2YSrQSGog6DIzDIBkyr3id0bHnv9hZMANwpL0/l?=
 =?us-ascii?Q?5Rvrh00AkBLXxHgg0eXrmNs6b0Y8rNRE=3D?=
X-Microsoft-Antispam-Message-Info: 31KRcaR8XUsxsJXg/BC/iEPc8mPHgNXLmOKe4RXmc9eae/VhWwUABi+g1FGO8kkvsAtkyQzZbIZI0/VH1yduj0MrtStIHfBBAN2gBnAo7N4+hQ5iLwpnAMiqLH/R8QJmGBp7urWihcT1MN2sUyXJKeykO6XiQTyPuQ5ge5Yl6S2bM3zNnCUFCtCskjVDvxC6
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:v0S5oGEJPa4mpdH74YDpykMrIkwgwkcbj+TKP81gbP9CAO8H/CcktZ296DahNhSfeTcBJbVkNI638a3TWSVHTS6rtP4lUjTwxW4nwNzZahyxAR+n3WcKozvUfdWYh3NXDCfxv3lYF0oC0FHqVtKuhGZrso/E6wBo3ParbQN6mfR0SnIbmjbwcwirqJvAuqL1MS7XjlqpWFU5QdAMDlLeUROmcFYM7twI+lTmeRrpUeYgVUpL4ISQmRmnoiX7fRLFXnKGrfyykjb7r/Q3jfGRHayE36x3/T4Iu1i+iVfjB/ICQ1raRcALn6Muw8wBSgjzE7RGuA8t6PbZHBITOYUzml73OW9zyTux9AI7FbrLBARZnr7wjOPslwksHRu1AlbtsTlmyQR2ej2XYCO0yrV7oGTO/JMOKiG4Dr+gPLpipHH42145lTipsxZBt9b8JaQaRn/yNLaOVl8PVBcyzWnUbg==;5:e30EfANgGnNZN2PV8aRQYYJJ3x5KsHhE85kaCT0Kbsv1iZSUU1Abk3uKEEZRmOc2AGwT40PCYcPxuIOviVHRMIP+97TiPNSGMAWpJdqXHs/4bTM24zMvJknZ2wk23oxTiiJ2jMqsDYFQzGfR2ZFpnr+XuEP/as7U95WDT4eZrp4=;24:LZxYMws2mopxT9vNUYSJ1Slmqqcp43EBW85wgK2mNFElHJ/Fzjker+7uXwJSUPSxuDyH2Go64XDCQ5mQPecdJdBzMYSGjQ/hKsj07Srcx/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:hHzEL2wxp55gh1825eKAypp3EFX0851PLDmtYav/amAI+OvMDkru6zi4rR2EQJhmIOctcM4IHlGFPfg7RsCsuBSk0g9hnQm080EEEBzzxmIMAW2LKAwqkQA3jF/BHq/j2lE4+hEGpSsBKd9strYLInIj8Q3jO//TB/dxoL/2cTQVadSDVcqMGrViGq4bBytq0zS/uR1PBJZdGguvH5pLwFq19DcCL47QxYqISL5D77rJVz/l/kI8+J5PHn2f+zrb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:43.0628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4267fde4-44ab-4eed-7c88-08d5d2a8f475
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_segment. If the device does not sit behind a mux-locked mux,
the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..74c560ed44cc 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -345,11 +345,11 @@ static int pca9541_probe(struct i2c_client *client,
 
 	/*
 	 * I2C accesses are unprotected here.
-	 * We have to lock the adapter before releasing the bus.
+	 * We have to lock the I2C segment before releasing the bus.
 	 */
-	i2c_lock_adapter(adap);
+	i2c_lock_segment(adap);
 	pca9541_release_bus(client);
-	i2c_unlock_adapter(adap);
+	i2c_unlock_segment(adap);
 
 	/* Create mux adapter */
 
-- 
2.11.0

