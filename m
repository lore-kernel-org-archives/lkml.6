Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 492AAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF44208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="CbCKMmwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF44208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965687AbeFOKQH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:16:07 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:38179
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936215AbeFOKP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm1UD0XjyKF5shuwv14rYkN2bPE+AJhxwpYqKGViXcQ=;
 b=CbCKMmwEse3ua9DyVxqYCfV/WSHLnLv3oa2f6PkWhtPPEjw1Cn9BFEXBpUWg4q+oKRmJJgE1Zk+biH4iQr88AIcMhDtJNMxXv0S58RNQOuVCe4hKA7HkLbpj8Az50IE+YWd9lFN2yCQoUN7klbk4ThaTGCNBMr9TJ9/iNGKEFXI=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:53 +0000
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
Subject: [PATCH 06/11] media: drxk_hard: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:15:01 +0200
Message-Id: <20180615101506.8012-7-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: d0d540f7-0fad-4e1c-0b07-08d5d2a8fa9b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:wTnWnzRQhRKuJIEpGLlD6hYKAX9cqBRGI/dGfI2Diwi4RLIpolsgV42Pp5M3W6pVUlAbVMRdU0efBcbq/jjuzGxQSZXGkVdWearXAqJlPipPOZWgGGDbYtv1X4A0QL6P+YHcVQRJC8WLbxJ8vwtz6WPL3KlFIGFC6hgtvYMpdzmjE1g/Pl89JNc/Fefc6oXjK/D48p+h9dELmq3YzEwLSk5J5BlEBUJh6potC2NuGk7OheU6icF6/idFotw2wS8p;25:hGfR5YGdEO01Vqeirlfo9p7P8/dhjNgeHlnmAurBbzkE6L8zdFXyxcWR35djwUomycS3xQav4mirxMrHmbnHW/9RnuTD7Ch533K7shF134KFCAtIcCDPEJjlIFbEvSaqgq4AwRpDp46ecjiJD+0n15FShG87Ex9RgKpQCni3EdKpV6qbUAybY+2mP3s5cDT5jurawnKZG6kYCHE7c2HVNbGE46hX9WScPSl3eEmv7H4vkIZBeDcBnF+AC48JpokHbm0R2yeOAxw6iwzoDm53SyGz9EJjvJ7mkW8W/G2VORp1+GqL2iXtWp1VWBa7gmNHnP6Nk4ESLQ6IKC+kku+/sQ==;31:OfeX8EaRwf1Rkqc9+duN9RQ2RptIMb/QtGzwkOYCkOXglykmFU7sAA80qnzDf+9kdhpdUoumTbl3o6Crq2qHL+Wh8Z973SHZV/s5MlM5bf2Yz1wDTpc0WANR3bljo0bSq1ocYQ0PVKXICqGiXx7JKfejDIFHcLPslij6wSytAy5oDGmA1kIdw6YBnuGwWsuvPK1d0xEVwo58/aoPgeyXaQ1oGLLVM33ppVovHuRJb4k=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB246037743CFA5ED500041C52BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:P013k0gvl12DQATPUR0qU0Spjb7xUOxWBWUq6VMrXECMwB6ZgGLari69vEZ91z23kwJw4O8SfpXpug/1vwT/2XmUBFJi8NYTBXfaNVggq683kP48HOV3Ns94oL/cMyJXFjamC1JqeWKW3nPT/+8Wr058dizz1/Qsq5JzIY2K2rHf/LuPvD3oWbGvdF4aPOtY1BbABNn+7+4fwQtbTZlkAjs0dHOOEQuT0s+tcSXhWtUmxgUAIrCONvwzvYBGrfYCD+EjXLemTggaF32XuzzVrw==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:RGRwhpPNw8cAY08zfhhsBDurjpNVD+PRxaOSgM3?=
 =?us-ascii?Q?T6meh8r/i92dMUrPaGXQJj17Q8iEAvfKsx1/H4DPA8065TfH6oUEyw3jy1nx?=
 =?us-ascii?Q?7TXiMoNWWMTsJBNKLWBhavxuW4wGxsvi1oAgZdv4gY7ugilE0pR6QOa1GW/3?=
 =?us-ascii?Q?A7P3935pWwKhnCgGa6PMd7qc+lfU+3azYRiZcWO4dI4uTtV9IJVOUe2VHIk0?=
 =?us-ascii?Q?27vQzU6Vk0QxZ3O2hFwoXveVHeCToE34IHFsOSaHFzDeSgOxidvKuLemwjDK?=
 =?us-ascii?Q?6yiD/xiSw8x+p7+5TKLwmVnipq8lKd2NBu2QVqszKbPMmgiIDdeWRvAo2m9S?=
 =?us-ascii?Q?cElj39DstXVFG+Jp2oS1W1KjmwX/8O/sbElJmEU9Qj/BmqWOn1dFW78/2VS4?=
 =?us-ascii?Q?R31Dv+tv2nWOdMP+vyiY0WDj9Yj29lhIk1XnOvNfP0Z/yIpyof6kYKBoHL9y?=
 =?us-ascii?Q?RqctyChs9IPJ0aJ8BZ5SwdkDc3CcTr6iPgssfuYSvn+zi2YTrFqhoe0Y6N9E?=
 =?us-ascii?Q?OCewKAV4ix59m2oztwjvsnYLIr/S6smH1pr+AJBvq8xtMh1mvXwQEIeiLXQs?=
 =?us-ascii?Q?5f1IrHoTplYBROuomKGwDbUxenGQM+/daI8P+wpQFZ5VDamaCQg16WlBSk9T?=
 =?us-ascii?Q?EyQofbHOLnnd7MrKecuRXpu6KzBvN4zQ6q3zWuGalusmVDq82aEA4QCa4peA?=
 =?us-ascii?Q?QvUr9LnH7cj5E/1ZWdABCQqVoDi9I5CTIVOOiNTVO5GXNJR8nc6stLcBqJvq?=
 =?us-ascii?Q?WkUUVqOR00hUnhLiOVpLPqjUcAuWI23mHIIWQokxsOcMMV2BVEGxremjWmgs?=
 =?us-ascii?Q?rJZN9gMM8qM79GfvIIKvr8CWgLfMk3QJWVJe2NlEjaPWd3E3x7qY0QX3/Ogq?=
 =?us-ascii?Q?Hps61w9HxXdejJR0q9MGqzlljl4ZiNPGtFCHMUspK/l5j8ApIGh8gSEkDnA/?=
 =?us-ascii?Q?XIvhkoKBdt+dKDDWq+EqR3MNS4/PpnfJUgz0Hv8ZBrDI+AKxa8+jTf/lHhJ0?=
 =?us-ascii?Q?Q28uxnmluWBxqmqWGP5/LYYAkYbIR373ykKmZKv9ElBXLl5cRfWr/9vso1xB?=
 =?us-ascii?Q?JFgtXh17IZoc0bjTBXe6sWm81dixssKlcb82QIvIL9vBKZajaym5zF6a41OR?=
 =?us-ascii?Q?uDtTAfQsOMvo4MeFSuYq+dmX0c2t60YfX56t9FAFy4nv5/0LEpwppeplKyrx?=
 =?us-ascii?Q?oSzlIH2CtyHENelW+SQG6eTkcOUKyi8Wj/brW+sDEleKm4A0rDmVXxRIDy5/?=
 =?us-ascii?Q?G0Wwa98GFprsteqIWD4iz7328aXCZb/gLGRw5wpEMMQcnPmeW8groV3YfLR7?=
 =?us-ascii?Q?yEzxAvLm6RqeZYpRiPer8e0ro6dcGsun+K/PsySFECRsY+VZoyotm6ccO0Zc?=
 =?us-ascii?Q?W1JfRY/p59+Fms6eR1T6KEUX5wFS19bSUvnHWUPtXbNjqHQyl6uY1pGGUdGs?=
 =?us-ascii?Q?FnxojP/KIi+QGxufK95Cx5UiWj0l/Bgpf+QhvTsY0Uy+7ulA5/CpERO82UlQ?=
 =?us-ascii?Q?sTOSFDjLhI87Pz2/fvfveuhigQ+sMgBhZQusElEY9+piRkCaQ5BI4gDh2TS1?=
 =?us-ascii?Q?XCrqLJdzNklVoRlmNRQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: dl9E1861y1f2DzrK4j00c04hefOje9CKPI22+9UzHJvgxLuaL98vnyBTKIWOntddni2c0bRO0cJkjONeEsfOXdhi19U6LU8S8mYtEKk9eDKsezP1ukoLC7TzBUCpwfW7Q9Xt0p5EJkDbxK2LBYZoA/ezMxE50pqEsLV4DaVqBAw42H8Nf/6llA5cfd7i1j/E
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:seBWpgRhQD0l8GBQtvUALFHuy2/xwU6CK83GKAZ8u/iUHo1USpvbI0n82O7EDsddXm4SsSTqgEIOJAkwYmU1aY7q1+mktFf7q2sLZrGtK1UswF7wtl7+90YDflwiSW5aj8XOJ3OvwkYA6AkVAh4DKp8SgGEWcujPCuLc0EDP9FRBAD+2XnFus5MHiIFWyFQBrEcyY7kFpiEwsdslSQT1y56eqh39E8KEcGXS1u7xmR5Iqyktq22SKhcM1q9Vpv5QnUS/nPqhrMVWk2B5o7jG+dxKMrpbGuzvp0EmNUPXkN2SeNOdaalW1uSHP9XPSzuTddpn9ONtnBpQm9NYPXFBz1aG8aTpBXVy7O7v/rDP1Wt2eMOtck8rXBCJdo/DZ7qoSsmI6lKLBnR6e7rROrQ3k4EmpzViWBSyRmnDAlbKwKFkPK0m86PBReFec9WCM4nP3V18BqSKm6R8QU/dp/v8Rw==;5:o4T/qlCqEy2dur03NR/sCBU0DLLOgwtbW06Qcc6z935PKsJI6kw6Zl9Vr0OTbvMxrJZJmxFVRQCfxTzLhOWy5eqNA+39V+eq/YCCz4w5Bx7xedgNWjBj/iZJXXzU3WQ5Dt0IsviNMh1USWlIFGxlNSD8h/O1yG6nd2hm3OAT2oo=;24:0AtYk2Vl+SLAq6Pocp/lYENiN6RITsmi4mPmqKqqBCiBRFVNvRJVVecr12ewy+B8hz+1OL0J1kGqQUVOgsE6esHm0EZEQDj002ekqS3uT8s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:T5sV/PZ9F3625fyR3j5hQWrB+ANR+JrS1dWIDtXlhwB1cvNxTfIvQMSj2aB5uTqDsc/HWibjKQzs3dFgv/0usxWDixL5OCdFYtlNmtXGEWsvNA0cZsZI6rHjz8Hlyxoc029mFrheWr+QMLrLTEbQ3shxbqrFXlHn/Mf4YeFCsvhsBQieGyW//42KoD9iqgVxrSs5axkC9DASXlbWhZM+B5/ueb7ZQOj1jJlnMmeHot+O4VMJWWaC9qkEdLp6gzaS
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:53.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d540f7-0fad-4e1c-0b07-08d5d2a8fa9b
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
 drivers/media/dvb-frontends/drxk_hard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 5a26ad93be10..10e6bb158712 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -213,7 +213,7 @@ static inline u32 log10times100(u32 value)
 
 static int drxk_i2c_lock(struct drxk_state *state)
 {
-	i2c_lock_adapter(state->i2c);
+	i2c_lock_segment(state->i2c);
 	state->drxk_i2c_exclusive_lock = true;
 
 	return 0;
@@ -224,7 +224,7 @@ static void drxk_i2c_unlock(struct drxk_state *state)
 	if (!state->drxk_i2c_exclusive_lock)
 		return;
 
-	i2c_unlock_adapter(state->i2c);
+	i2c_unlock_segment(state->i2c);
 	state->drxk_i2c_exclusive_lock = false;
 }
 
-- 
2.11.0

