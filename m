Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEDAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85E02083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="IMQS8mG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85E02083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeFTFVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:21:37 -0400
Received: from mail-ve1eur01on0131.outbound.protection.outlook.com ([104.47.1.131]:23328
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753896AbeFTFSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zchVYeGS8ChEzT0NgwxQMMJI2btJ66LexAHSvtOL5kU=;
 b=IMQS8mG6YYD/B/bR5rJh7zMKH5+5eiGET2jy4jZKD1T3g2hJ3q8X/aIG4JFJ72dqooAlXDQjKb3jECIGh7293LuQ8n8Yrlez2e6SVQDf02E9KnqcMz893PvzaGllF4254yYo0kvnhnpG+FGmzbpsvO7PK2dqCMwQOP146xGq8do=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:17 +0000
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
Subject: [PATCH v2 01/10] tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:17:54 +0200
Message-Id: <20180620051803.12206-2-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 52da9687-c185-4310-00ca-08d5d66d3c3e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:ulYxBNE+U4iO6GErMm+Eapf+6P7zFMIXB+wpZD1N1lcpYpsBITegfnpIosF4/7+1bkQP7LVykCje93CBuvz8kDl1AbU10D51eb0RbCK7rOoEZ0/olbq8p4tdk4jyVbtBYX32qhR36Be4AtDPYtwmtvCmEhK6LTxed7MXcykRwl+nT9BTX42Lj6I2DTI4xkioMLILiLdX9+dW1BSG/Zo+aWvXk6McKn9oQ2IO9lh98sbW7w41dHg/KO54acw9tmoy;25:HqPEDBmXRnffnYUS1cT+bZWsc745QSw7CHZ5YintuBifN0vT1e2euFfEZTCinaownTEmJEwYzzelMyfNGgFVWKa5eMmm3Y+gltnw8Th+DoDH4tO6+mfob9l8AMetTChNeq1T0B9d/S3KQ96QL8B+lj/SMfXd+jRTlJHgtEqJZtponWVerjtkQh5nIN8iggXxX83+OlvRc47PrfOx/lsVdxNhX9upd79A7rT6/YSf3+JQxSPYz23lCgUVeF6WfViziz6RYA2W9zNiAjR5GMcg+NlGnztM6lL0w51iRt83qy/LlhV/brX92+PxdFJzTR7xZTM/CjPppTlpzTEqEYWmLQ==;31:L1nXfH9U5UOceCHAPcCWmMK8UMyGATKFjoHjc5jomHUb/+nMzCKZpd4VWRyns2wPPb/GLN0r/WGpHVkVSSBVQubL7CER2jCgaMyEes9rJeXZURYuofYp0CFGTelIO2LqfvmKAk2hhOQuX7tRZ+88VtIc1qU4pHrCXF8eOv4p8uw7eQwT7y9sVlIhUixT5SvH9do0CAxgvtFgFlR88wr3YB/dl6baiu36P14QqQZt+fU=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24524E8A8ABCCCE4D41A9E77BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:hHIx3iWA1EX9BZ68SKntO/J5RNNUYaCbVKdRoBwgX8ZdajL5GvDgMH6C/kP+volAT51eh6f//LvQDtGu7HM1tHiWH/Zf5vS/A5blmk1T5NIe+6f6ebg5Ctf02x5lZ0pVSOWupckIvt+csZjvgQqQlgtK9f3YGhjR1zC4ccUqC4Im+fgta3l8T2X/nVDBu/P46IsOu2NyED9A6O06zWQrIiSoIPgOsF6bes8NlUwTRzLq3t4B6t5Hz9jRBKIfvLmMo+MsPit5Wz+SmcoiflXYAw==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(43544003)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:OS4f3rCmweGDplp1LtMr1uwwa4hVsN/EOnD3Rd9?=
 =?us-ascii?Q?Zk+M+L5du0yivTZRRTtDGJ657P2IRf/8oaFaBR186AU9oRUDRgVPtJ2eeUE/?=
 =?us-ascii?Q?KOjIXJ8jEiYKWIEbi5OF8YR7ZlUrWD8CWMLJSiiQym8BY42CdrzTPomg3Gnl?=
 =?us-ascii?Q?TazTTbUXXDMCmS7tVVKa3shahC453vqlEbS299QFCA8YdwduJ0UJnBflGRdF?=
 =?us-ascii?Q?6uzZAlqchuz6CwBiY6CePnT9f0+6USCZf1EFnV/BaDLmiHr573bRFM6kc8Dk?=
 =?us-ascii?Q?IQv7L18qjRxz7uNOlBh5BpeojU8KTO63UxGglMW6qryXL8g2sMSmOPzuWWuY?=
 =?us-ascii?Q?c51iHb/wosrWNczpXjuIzGaSpMEU67xukMPYCSa08nHoZy+rriAwsI2u/Twz?=
 =?us-ascii?Q?8RrnGTR3h4eJef7q+aoDGBI94eheAu3C3qjaMHz3LmxSg0BMzDX9a8eCBQzT?=
 =?us-ascii?Q?Xd+b5eK1e6F2TPUyMU5G2I1KvHmKVORZbWAXfDHm3ZyM0X7HDYhaOetzA2lP?=
 =?us-ascii?Q?nv+CNuNu7xFUNrWMro1HQTJ3Bf+pu06HyGluS664V0oFiILm+q2r0EWX33Ox?=
 =?us-ascii?Q?bY/oDdRJ2xhxMqrByyomouspVgleNZ+NgsmCaK5AdqAm2Z4ErQDXQ6NDGvVH?=
 =?us-ascii?Q?hy9KedJOHF0XbePPKk5D+aYLcEuDnrVeaoZRa/cMAF8a2OOt9m/2Iofzu0Wd?=
 =?us-ascii?Q?+Vs/kJVeNxN2rgscc/93o8BzatbWqcmVNSHvDA3e2iAs7ESYv9s1cPiRv+wK?=
 =?us-ascii?Q?YXl4hZOFMeBHOBCSCDCng77h3/g/kv765lIaVfviGWu9UcIbo1ddPTjxdaIP?=
 =?us-ascii?Q?/d4MUDnfgfCbHHlENGVu4SF6KkT5WjDPEEagtkMljPHeFR49tsnfgVuIbElb?=
 =?us-ascii?Q?qszzs2zNApvWyPzUloidz4Huzx4tc0ZK14rlZuoRU5thx1uuzD7WslAqDno+?=
 =?us-ascii?Q?PfTyNB4JiO6dMgznhi2LUQtpX6S0rnezvwphFuMadLywiIgA6p+b3dHjph4Y?=
 =?us-ascii?Q?yLHb33/HmhoLsk6W3y9IWJGxtK0NYzCqEk1O9SRdFjscsHE6FSphF9cgjOUW?=
 =?us-ascii?Q?F1lt1aaaSEwUNv+En+DqyM1LQJkdg3Hf6OncdUh0vMBA4AW++zV4cYLxbcmT?=
 =?us-ascii?Q?PxF8zNTPvcMLZ9HXU57hlTv6HMJ9bwSmbo0//zjSg+/9WpNOBKbVfcfxftbi?=
 =?us-ascii?Q?AH27o46Sj8ZayCgJOYaENq1/2WpZTJM9goScxbQQVEt34qeLurc2nqUYsVzO?=
 =?us-ascii?Q?ru3h4ObcaaH5roP6170Yh+dD2Ha4Isb2ZPqbZXUFK/aAYekbypvcq2hDWpep?=
 =?us-ascii?Q?os9nF6Dz1Xgn2oPHaCgpP9hV/qZYqsTi8rrOKjGasF3q428QVblWJPSntV4B?=
 =?us-ascii?Q?uSBMd9Ij77RYMrD2rB7wi4QMmfuElmXOenYwFlw93xd2I0o3Ug5Nv+A4+7JF?=
 =?us-ascii?Q?UIdd9n1Vonh7zM5idP+QoZO5fEsQ8SLz1fH595g8LoIDLWC6CoXogmtSerUZ?=
 =?us-ascii?Q?gQMR9H1feOkknkA=3D=3D?=
X-Microsoft-Antispam-Message-Info: m4BPkcslxAJ3X62BfdJiwW8RbudD3/16dsVPI0RXV/95YW27GJzj6BIEaUIma4+csMV4ebtRtn1ZWNkCVL+tu12REheorqW+pAI6RMpfOlcOK83iIs8+iEhlwyYkGQRAfuErgpQOmXd+9OayfYUUc+eXxaSw3p0BU0M5h+L7eFo/Nd6QCZtOoqHDSGfLKEicrao8id4NS4O0sjH7tcKmjIR4rgD2u9Gv9H7/hkazelM+nygQujNpcG3Xp46DqnNn60OtPV+GMiJPIQJdrtunoUClmKWoXJkfnndno5LA/MMsP6TDhaIOl64lOI5XEFGB
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:EnYtub62pgGLRfH+1Phq7WIVI/nuTkTzTU+JfuTOYaXZiCGlxBQtPvOc2y/9ClZfcDKL5mRLLOXxHDNpa+zUd4twcafBzvXir2y0Qa1P0cyoPZdSSTQGdsuK9uEULbnGyFdN8+5gLIRN0pkU0qBhpy0pG/ZgILdFvfZM0AKNnRhk6i8sFKZC49j6E+O/AcIsglyN1J9jE3WJm49FlX9f4OYn+pXnw9P2136siimnvDZM0ePcAJzP3q2gj5AzAlNR7uXeNMeiKglysQ6ALLMD5nhfAv4Xb6kKJMEftHMBf0kKwvIZ/scgR3Gc9G2TqGZRlcSLXo09rvQKAPZtffucWJL8WbKBsie1siZSGPWBGH1T0g1E31MB6sx+u6KEcYMaWHOx0U/YSCCrmxgmu1P58BQLT+qK5E2jxFk6+hG+wN0dH2JHg/U/fCY0eOTHbB0CwR5HrVjyANAJPhGef7GDdg==;5:+1v1z2kfnDPxTAd3xL1R4RLa3qki4nZchHelvBt/s5kpnE4v0QpIWc5iObJ2ZQqdQXXGM2n2FJjxgi0+tntpi/wI6QY8cUp8y8jRWMSQ8gA2O6f+Nv7y2b/HXAhZTIKCneAvfpZ62E9XWEvUbxiRrWwzAAehdYAfa18CuVJJtlY=;24:aqwEFjtsmzjPtmyJ+LR4dsl06d5DtJmiwNrJ7/BPMTLqNjVf0luJADZsVVjp5a9RnlBAj19M1MIroleaxloBeFUzxEAwSPxeIdC8Qhm2UIQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:lc+N61iyPx4CMtzAeQQVvM/dpR0LML9p700qbaHYSoiDUFAOPdLFx5/XSdDb3xwx4MDjy/vIXR0m1DHNXJ7LMvyJQgOXhnWEA/BuUl4WCx8YAUCUaRUBeNZdeKsDePCMXvvfUhe7/fuNb1r693ggF9s9VdsdzGVlkl/8gTk+Cs1zOBYYLUe8MLeFbCAr3dUFDZQL/nelWddP1jq1ppyfaZ+LsONlDXz4XoCcg5oAkGqGQTNAWvsdFxAqiZ3Kq03T
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:17.2332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52da9687-c185-4310-00ca-08d5d66d3c3e
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
 drivers/char/tpm/tpm_i2c_infineon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 6116cd05e228..9086edc9066b 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -117,7 +117,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 	/* Lock the adapter for the duration of the whole sequence. */
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 
 	if (tpm_dev.chip_type == SLB9645) {
 		/* use a combined read for newer chips
@@ -192,7 +192,7 @@ static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 	}
 
 out:
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 
@@ -224,7 +224,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 
 	/* prepend the 'register address' to the buffer */
 	tpm_dev.buf[0] = addr;
@@ -243,7 +243,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 		usleep_range(sleep_low, sleep_hi);
 	}
 
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 
-- 
2.11.0

