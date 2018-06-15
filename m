Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1A892C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF51208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="vAEzGsO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF51208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965723AbeFOKSM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:18:12 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:38179
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965683AbeFOKQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yntwKmekPCgdpsx9xmSnUcLB/mPTPpwAxuhzR+BbQ4c=;
 b=vAEzGsO8jRDaibxb306jqEsrEC80ki/rBxh1x2Mr3kKTOk8ZnhaLALKlfOW35CZ0CXYtZFyg4RS2zU/D1FxE5Fl+eEFEIzi94sK6yi9vY8NbX5VOwnMcL2bD67uJn7CcxYglF6cJAAGOqnNhrhkytjw6Ii7i6HxDzLzR3gwUitc=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:59 +0000
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
Subject: [PATCH 08/11] media: tda1004x: switch to i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:15:03 +0200
Message-Id: <20180615101506.8012-9-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: b030da6c-51d5-40d6-a26b-08d5d2a8fe60
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:fYT6ze/lxaGCReho+eibXk7vBaoXblo5FkTDUcFBL6n/9f58gJxzsKd+ZrV/KPo8CnUbLSiP1NRZppBIPxF7/R9JBTrpuiYJJ/JKQaj6PmshdrnjUFSDVZNqP7+X++Ss545Fp4g1KzPsSG+vLK6vOiu47nPHEl7iltSbcPStvDomEfdKdXm0w8zmLK1flbFDT/WPr2B6RiOQoUnE9lHyxqs1u8NvcUebVNtrGy7LqFcnVT7GeCQHiqLLAMPHxKDp;25:H/DXyP0NCX4NtbI4L94Ki+93sFrEaDVKTh2uWN0l9q+ElwbY5dTe+5l+xLrtMy7uUhPs6lr1IwTdb8R3GEtkt2XgLcr5A6uGb8CgyEFIRJtSS6h4ugwfd5EHYaAW6CqGaKgTWNLsOW4ZuZrLoZLcVGYEDWQ90R4cbGNYSieik8jhJYWccpHN03XQJJvMhFWqlXcT3SwehosZw+m+VBGAl1VbudJuQnHRp2ir/rVICExOLxpW9kD13UzSmDXeRBVUPk7EurNLG9caH1JzGj/CFXbd4ETJ4/Ai1SWM6AWb2sHisCcV3PyAE/zSR7Td7+xwmqs8b4xbfsO9nIM7rIjq+w==;31:qIs4uEtL2fXdw6EZbTIl0cZldAlC9F+r0i6vC2LB3Csq8UrNRFsEmrilZehX+eEv9OORMw8Mwov+vnwSHAboGr0KaHOzdbO+63nmcFoA6M8ZdVVUh0ZEtu8tPalLRedYeThSMq6tcBVJI9hD52x5eY1EYHgGvyMA45t8B4z1o3NUkLFWPglM2QlkRWL1VXmyRv/iT8FLbU9Q7pI7ErKF1PNKICajolR3+AckZbrc4mQ=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460984BE079EFE2B7962E4CBC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:e1RL2tR0wPiCdzTUGL6PMwvA1CInxg4tgPK6qmFWWJJs47hVL+BAT2e4OoMENYvsBhpkpOsbnOsNc+/Wq1CyuIqInVo5k15NvqZhz5QP/hS4qkrwTeFIh2LVjrT8gasBDwNU/rM4rrWui45Du1tnnbxVn0PQFlvxC+TAj5fKz1ynQOOq7pJpbdCToemNturVYwj9Phha64tQ2/P3OUEQgX3XrMkK1lulwjD0OwFuoSLeck65Am/L7gf7DIjGsQHKCUh5liTDBRqbc6kunnc7qw==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:V32N9rIiLMCFIBjUZ8CvaQQ+lCIJ+1QC96i90oP?=
 =?us-ascii?Q?GkIBr+SiZ/uQ4r++79yevuUBQVVeifkDq8/y74wHhuxS3nxWzTHWwLKlEMdq?=
 =?us-ascii?Q?8T413VTWNLSGs5Q8MKdaYZvWEL7Uq5QY+C4Zk0HYScWedrDtliw2AXoupbSy?=
 =?us-ascii?Q?hUbn4ZhiNha1U3ZtORiZM4ehyp8D2jknYpT7LXn2Xxwo6Q78rEMfSpIeISB5?=
 =?us-ascii?Q?/lulKoEq5YQVAmg8Oor1FfXkfcBAe4PQFSsCwdiXye6YGmPKvMfA2SKWUe+p?=
 =?us-ascii?Q?+TIMyspn5ZWywJT6O4d4IOSYxrCdIMejdDIbyyaFhcqwfRa6NHoykKEocpON?=
 =?us-ascii?Q?/8FOT1DaE4a7Fahtur7I5KxG9G5pH0A23t3+LKeoy/jx2l5aXG64WMliSvKQ?=
 =?us-ascii?Q?rcIUMi9MfKLWIUwtQclOD2bt3ZmC+dcPcd/AFLWq2GklzOfXUcmbci96S7Wh?=
 =?us-ascii?Q?Tb7TJBDiyIg05vjdWAl55Qd9EjKh63U9fkwemLrWwBmBK5GFpPnU32jN+Qhl?=
 =?us-ascii?Q?VBaPKhIoZlCfCKhBcgY2voPH0XFsKb+4JUeRThBPtSec9nztDgMwyOChNk2j?=
 =?us-ascii?Q?pz6M+z7JhiPv42ACD8EJPoYZGYP8XACq8qzZeuYXZZH8zekXXjDMsLCSzNDy?=
 =?us-ascii?Q?40aOBkeJcsvhiyT8tmlBN0KWdpCnuxucCRum5658LTLWleMiCERWcBOFGbjy?=
 =?us-ascii?Q?CPlWeebD6kDFMauHufGJEFd/wsqJAWiES2Nkx/fW/kroiyzK8LZDQjkedJUL?=
 =?us-ascii?Q?48Q/55HpzimG25xYV6Ft8jNH2DZcajZoInSrd2BEbhJM74npAlStgraTpuOl?=
 =?us-ascii?Q?kEaQ/jQpqtd2BQF2G1MJ3qeAQD8jviFa9JzhwdJFOEE+stxQypilZx2aiIUK?=
 =?us-ascii?Q?NzuCehuHPjyJHYxsZQZGPdLssW4j5xPZtkut9iIrmK2Y3eLnTvDOGCg1ImEO?=
 =?us-ascii?Q?/OrJ5JQ/DmlgzhU7f1SeXRkZ6AQkimSBxTAn6ZLS06WH+iWK+CzV4jfO+KJT?=
 =?us-ascii?Q?ASb0qV5cSGbzUI1F3/E6W70a/3J8tKtOQSPos0MGSdg4vN8coDquE2gExGrU?=
 =?us-ascii?Q?UlboFIOk9K2YW0M7aBoidwtwHWT7mf7mHtcrNYS1+kTTMYZibM7Da6D5slHl?=
 =?us-ascii?Q?Z3X8c/Jbei0CMLrWTCOGlwkq1MIud7cwJROl+w8inC7XBfqnFsESSDhiDgs5?=
 =?us-ascii?Q?r9/AxZ5vshw/1lJvCazKedkFe+3EhyoKv7kZaL8lYwLKkVCc8G6X31y5Zxzj?=
 =?us-ascii?Q?sp66JrjXv5TfeAywI1hS755HMdjsBZUqe5I8NqUG3deRIq2pbbDQQGWCnG23?=
 =?us-ascii?Q?kNGPhwmPaZbgCRcHpMrfPR+5L0Pzv3nFJPb6UggbtGhkHSEh6nZU1iPiArm5?=
 =?us-ascii?Q?w26CqzfvaVrafEeuW/PzOOZehA9dMKb0QG6ltGMLeWqoPYjsw2VK6pkqfhNB?=
 =?us-ascii?Q?OJqKForcIgacDAKPE/bD+Au2kb/yvjVB2wIY/79SUd3iScru/MrL+?=
X-Microsoft-Antispam-Message-Info: 81n2wgiF1pB3C++Dh0NFx5UJ392C8vmciN/9vnzfcAK6rmPeWUayqa50NyAv0x/V1b9Iim0A6iDdgy/W27G/ATBsu2+K1csHBxgn9eCFrtzLVzjVeKnxMFiCGRr7nwuP567EJQmFY1ESJNL/QtLNOtks7057B994bo+4WpMxtxrA1wA0DqkI/FDWkUR23ije
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:Oy4iZ09tcwYylytv7lfQxmmyxNztkWzWkb8GhYfgHCEgZ+aMmok4zfTUdrlQYmBnD4jY97SAVtPUmL4j7KWNprgpU5WOJcTMafRcIQKEtjQ6aVJHUEvLUiZHpOarkEpzac+mbvoARljAxbFw4VnsTOmjPAzTR9FXNChFCk3SoovRkEf4Jzs1By4tpSVMk6pOvGeFGKPIWh/PNfLy/rYHIuh8/rlnvPcu/it8yCNTPBELEB1V5P+Llwo6tnhwfU0T12pCkT5Fw3kLTCIBZaTvfOr3x41bXndRagwwHMKOfS7MAR7e3QuuaRUuikhIBfTMmemq5pD4zMPVCIQ3uS5el4CEJHTtByM9QTtD+Np6CUFEYQBEjATBAZCbWp92YdaLMp0PtVhmCMF/C4c/BnbqPqjFjXSCKdLjU8sONq/gWBBUO4NlbXxIFdUvX0wGwOeGcsi9kw+k1+fHpBW6NWg0VQ==;5:7G0JjhADXjaf5GnfUV1v/HJqISXimVumSknxVenJ9rRY7LAAJKxQ3iah9fs9RjnnxhilfsnDR/0sc7tdOx58jDTFI4b3soLdX66GAA8zzIH0I5P8bxxJ3l6sNylNkAjOhTroJiju2su0N5EJ5cWuvixZPSuGZ3ksBiRTcF5RduA=;24:3b+OtCbqTb+3x8/0sSG/Re2HclKrVkRkc2cPBqltSQG29bu57faQgLwwRwk1eKbtVTIgEGoQjvbEPlEXLZdF9oc+kkJ207wwmwilj+FaFkY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:PhZdRykkUlX+9IvqERg9YsXTHaDnGL8VFADT9SYXpb9ore7CT8rEkZX7b36W6TFpskFqfzBBF45aDxVu60rwPfCYmpw8Ot8VvbTkhF3bP2zLDVVyBMwPJ9aPdSh9Z9mjh+ca++2jevUmJgOkZ9DEk+RT4kycZppwSlDgrCC4MMZJ8g4gN2+YBI+ScwwdIZimDLcjA0zJzqwx95LTLEC4AXBO2QXCpsMeiYUH2umq4JohY3utpnuzu1kAbO4g96JA
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:59.5627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b030da6c-51d5-40d6-a26b-08d5d2a8fe60
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
 drivers/media/dvb-frontends/tda1004x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda1004x.c b/drivers/media/dvb-frontends/tda1004x.c
index 58e3beff5adc..1e5c183cdd86 100644
--- a/drivers/media/dvb-frontends/tda1004x.c
+++ b/drivers/media/dvb-frontends/tda1004x.c
@@ -329,7 +329,7 @@ static int tda1004x_do_upload(struct tda1004x_state *state,
 	tda1004x_write_byteI(state, dspCodeCounterReg, 0);
 	fw_msg.addr = state->config->demod_address;
 
-	i2c_lock_adapter(state->i2c);
+	i2c_lock_segment(state->i2c);
 	buf[0] = dspCodeInReg;
 	while (pos != len) {
 		// work out how much to send this time
@@ -342,14 +342,14 @@ static int tda1004x_do_upload(struct tda1004x_state *state,
 		fw_msg.len = tx_size + 1;
 		if (__i2c_transfer(state->i2c, &fw_msg, 1) != 1) {
 			printk(KERN_ERR "tda1004x: Error during firmware upload\n");
-			i2c_unlock_adapter(state->i2c);
+			i2c_unlock_segment(state->i2c);
 			return -EIO;
 		}
 		pos += tx_size;
 
 		dprintk("%s: fw_pos=0x%x\n", __func__, pos);
 	}
-	i2c_unlock_adapter(state->i2c);
+	i2c_unlock_segment(state->i2c);
 
 	/* give the DSP a chance to settle 03/10/05 Hac */
 	msleep(100);
-- 
2.11.0

