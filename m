Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EC9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C7F20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="t4svasv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C7F20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeFTFSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:18:47 -0400
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:31456
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754023AbeFTFSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyZboMt43gUFY4eNfJH8QgYFSDZEZ30zrGMpA3uUjZ0=;
 b=t4svasv+adIyYps4PhjBDMIgOejXo+U+ldwa8D+fdrCLAkhtuECy8vBmV3jdnTfSzcbgqiTP67fDCeVJ+FrIDNJhWDR8W/HRmpqqwivnz+LeCoOuTFQNv1Vum2aDAylMr869hSucO2iC+gGxRcGPP+v0UptqayPI/I0OLtIOrTA=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:23 +0000
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
Subject: [PATCH v2 02/10] i2c: mux: pca9541: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:17:55 +0200
Message-Id: <20180620051803.12206-3-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: d6cd1574-88fc-4bed-311d-08d5d66d3fe2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:p6ewIGJr3VShg1xB+nh1n97j69EO2GDOXZq9oiHZxD0dzDh7EAPrAcSKCsWhorJV0JaI+bhLa1QrCoALGQT6uBk/dVTmhO7UqTnXwHFE+IfNTTY+GRiimHz1Lo/qkCiJFJHmP643JSzFX6EdfUdBppgKY31rKRcpbrhw28KsdZFr3HNCGCQzvMhytCvoPGIb8dvt1ugR9xZf20zYFe8/4Nec1zhmIrRPH8OFc0Fe3l3dOa0VRvcG44Gg94q2gySa;25:rd1oxfUccYYDgN5QhL5EOe0OE4W6Y5jjlowk6bLzvKVBQhB196vTiP47jv81V2CcgFrTe1bYo6Xg9QceSxKAvE9FoH1Sd4+4pzRJvqN1V/JB4cjmIPRWKL6iwey90IGIIpSMMT0xwVLT5UFi4Ga86d7cGfuGIKoRotrzfWCBNF+HlgpxqNf7voKIw4iGfzK+Tv7mleD/GYhyrd+bB0Owd+4bRyakdHznHL/2h5rWdr3zy1nkoBGw1dQyh4MixUW92yhf29sr4HXzgworHP/6vX5dsjZw6I2xnILQzT3sgGtm3VNgs0F+iXQf7ryM5H1ttaBNe3npH4pR2nHiDlu5jQ==;31:pnk7SnHOC3QKKIDO0pr1UtLTktNzvcVRAXvs5ABA7+rYqlDqKUyVbAsL9yyVOSReYjupyZkcUDfClAuaWfQcKlwGk7Tq1oZrbFiFGRFZqCCtuOtrR+orHNFatFfCrQMz9CoQ/eYI44Qbw9OHeKmAGy1SI7aoEjQuSTHMfQnQmQ6YtpJNVmorS+DkXRODDTgSocRxfJ5dDuakdUoqi937MfU0Ne8oU383bUBFDdxY+ss=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452E8D1D18BE06703778244BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:67eid3So/8r/Z4V59B8oHtOeB17ygUK9Ri4w35wj4Amgp+WmINQd9LESiSZPkLyKu70fJSyFNpyje9iFwOZTh7xMmIsFUnvo1+zIgyNrMom++i919nRmBZqGg7LSLpw1w0rvxvJlCVFo/ERCxT+PQg9PBTOctSZw6gL2F6PkLlgO5uY24zkU2jWrqCGNosPmp/w1vauIaIg9/u65MFRsuuakr0D/8SmKXNhUWxNfCNWLyA66aq0/fsifFwyBM+T+UEtene7gxtE0ET/q0P33RA==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:1VSUca+xPUvU7tP2b8jBaKBurtmnQAAZKX8YAyI?=
 =?us-ascii?Q?QRWyhMGfv00zZU1yU/2alNHWjOefGSg5HH7wafPOAux82aM0Rp03bcGLxoc4?=
 =?us-ascii?Q?H7jjFnnU0RIl8ARO9MFzkoR2h2/Y60PaKZHn2v35gBmMqRAH8MKtoHgQzs0z?=
 =?us-ascii?Q?EMEor3V7W58I9fi+TMsbxuQ+PibJ9/h62vjy0VR3vaq485Fc3T7oHHUjybd5?=
 =?us-ascii?Q?Iq/6n1pAgJLc92e4KqdkgslQLJZp1klNemrqO2jRoNks+75Ev2HvTowGPPHA?=
 =?us-ascii?Q?u7sst7STGltUT7m1/nkpDujYWdY6jp5jQtXaZFzhzAOQ2cQW2VLXrVD/PSgg?=
 =?us-ascii?Q?JRQ26vyhdVHHJKltGdRmHwXBkiAqJadRk2wW18Pjj/2IdNx8JOdCPSILP7SG?=
 =?us-ascii?Q?To+R3VPndCE8gFr74wbfTDjsLehL4ybtOMr39RPlCpGqWPTnzh3/p+CKN63B?=
 =?us-ascii?Q?wvvfuNtg4AHA2zm9hDHuMW75GWTaqgh5XmxNgVXFcWmTU8L06O0iaB8qxdyg?=
 =?us-ascii?Q?TG59lqoswYweNpEQQLeSRlCWDu+KFagmY0B61PoC3kRNO2zU/MrjeIELbEQp?=
 =?us-ascii?Q?8ZkiDfNwv9DHYqguxbXi5IYUOQ82FMGdTLJXcsUn+Rg6WZqB7hO1/YMcM3X/?=
 =?us-ascii?Q?CXTtSck4OqwYChdhHi3tjEBE3hH+5lUM/Z5ZOyCBXNgTOi/6+8t7AO6E1oir?=
 =?us-ascii?Q?BygvWfkG4QVv1CYpXJ+QvAVgCNI4HMf5B4MPV52NhKoK7nXl7X1ioB+aUpeQ?=
 =?us-ascii?Q?7ZV+mMyqHmyPtBDXQ7if5jzSNhG+cmU8iGTLVQK9dKunIdApjP6rh2C0CaEX?=
 =?us-ascii?Q?as2bdzze8h+4CT/NzFWlEBOaowG08AMl0ZntGkC+dbgVa7MkUOmCqSVijU7D?=
 =?us-ascii?Q?0QyrP7eX1wwW4xYNDGuDFFPdx+LFtX3DtEuyv6p88iTY/FMQZ/sliCKPBaB5?=
 =?us-ascii?Q?TopRfYyclu//CMXSIIfsadnJoCqcpklGtOXvIxtHng6Qx5gbP0tFehxQ1s3/?=
 =?us-ascii?Q?VvZiPDBPbxQDHPmmdiHMFM27S1jwyoDthh3dX4DGNVXypR0J+bdYGwIXgN29?=
 =?us-ascii?Q?YXpiOs617ywU1Z9PMj+aKxjft29BdRbD5cfH61RanuHtCUZSMmi3vriTngQN?=
 =?us-ascii?Q?YA61qM3kmUWQ1BJtog19HmMoLUevpMYMcrilbrEssia5WENRDZBL9oxMRMjV?=
 =?us-ascii?Q?vFk3Bb1CwUclgvK6tEyNpFlCrv4AfeKonidbZyJoH7PUqJSIaV7lGrUDvsBm?=
 =?us-ascii?Q?s1SyYtC4zjVmMrgTSFzCfDs2bkPdjc3PhCRoXmpCnQbeVGXz9/tuR2hKdAod?=
 =?us-ascii?Q?ZrjyGoVVveyjXhwz7S6/n/n3PBVdUVNjPyW2FZAW6YUYv8gIg7evF2YpzQex?=
 =?us-ascii?Q?hFAWTgV706LWtRNJsqfLG34q2y86IvVaOKD8Eb2eHBzIWSfgY7Wy7vjsaOyO?=
 =?us-ascii?Q?x2D5RVxALFKfCAPdFl4OKi/gfOmgciD4=3D?=
X-Microsoft-Antispam-Message-Info: S+BT/sVATEQWsjh0OIepT6RRk6U8w7c0p+7Mtl4f5+A+KfVb5g7kGdJsEiknVHG1FVYzFEqVnARuLmxxhmaG47VZKN/Q7rGznqRt8rBm0FbIa19FEOtl7KCWhFAijaqaFYjmwsYlQn+tH/ikzYWVvDNFLIaT+RV7IwieSXip+OXELr3BkolWLDq8J41Xbjd7mJuQ2eXpHmPXzvTDG1yiBVhg+R/GqD7vdXl4dVv0fFSx6R3A8LhQH0rB0b5gvBG9hwMIkd41Bl8Gws26ZuTNLPgqZLxCFfX17sQpnv3QCGLR5ndNjIurYQ7noS3jh9tP
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:7tM6zeKYeqcJz5wTZAQsyLqwges/viKPMPMV/elgURAwVggVHXCceBNQjQZgHCwjYd1zitQwsF6jIzP8AMCBFFiw27WjpNCdECkD68UnTEUNvynD48GLp2zE7ikV1uSllD8o6KXFRCqM2RY9qk8Qj0XwIraNlN58vNZMuKpXwS9DM+AGVD1HGppCp15NyDBQc16d6LUwazSpN5W2YdemqPpEURc90OWpfGJ006PAz579DoFX6WUnq+lodysdI5jjdGgH3bSZaXmWs6MPizjDN+Qo6wR3aZWLhWhC0zikLhMt9S2to95zVnY/rOsHLNasfqugmKg7DAbuuM+LJH0m6/GqJNIAaSyXaBrE53ZCLvkgk2EO9ZUL6WyXXc1s5d6k0BmVAEKZ1W8s/GeSf3iVfWdVetf4Z3T2N+gaTIAEpaAI+F9azzEoWH2UaGxGwj+iiOyzBFkaMb3bOGW0p2Il5Q==;5:8sb0ibL8KpykOP6St6guDqBiiUB1FnrbkAvunsbLN9yRLThhtOQkhFYu1tsE8CmBXIy++OaYLn5SjnyAVWj5n312wg6wPtdwJxiA45M1qfLcdsOVOj3NgVwXlnm38iolrnFiD/+li9njp2n/FMJdvaQC6EB8DHkh18x+XE5I+p4=;24:d+/SuG/uGadgdjGmndoJT06+tLeNdvIO2VXRgSemxvKAcsQyCB4QsA1Od29rNxKTfQDBVD9uB+VMvZB8EuqgOAfauDHPmgSf/pdRgWpKFM4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:5snsFAPX2N1YuOE0b/a4d/LuElyGGvzOcwWYxcD4AeJlY4mHONQ8WGwMlM1x6u1MpenY1Qe3RJUunSklCScLZh577Ow0321hBYnU+BZU3zw39vUuqC22mzo9hDU87D912tWXlU97COB3bAS55qu+zM0Xo0DzgXGxz0CksrszyRBVSQNe0jXdjyETEHG5O8Jvpvg3OgJo4B3HUi9dPZTenzrYecrcDRlRcWd/S0DDtGpV5JBJYXaHDph1ErEB9Iww
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:23.3423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cd1574-88fc-4bed-311d-08d5d66d3fe2
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
 drivers/i2c/muxes/i2c-mux-pca9541.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..bc7c8cee5a8c 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -345,11 +345,11 @@ static int pca9541_probe(struct i2c_client *client,
 
 	/*
 	 * I2C accesses are unprotected here.
-	 * We have to lock the adapter before releasing the bus.
+	 * We have to lock the I2C segment before releasing the bus.
 	 */
-	i2c_lock_adapter(adap);
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
 	pca9541_release_bus(client);
-	i2c_unlock_adapter(adap);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
 
 	/* Create mux adapter */
 
-- 
2.11.0

