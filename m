Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA803C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913202083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="fMvD2pBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913202083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbeFTFUX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:20:23 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:19840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932154AbeFTFS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVCaTmUVpSu0VohK01KJoBZsRDS5hWscDr1aaUS8BEo=;
 b=fMvD2pBZ6BihPXY5Y1KHOd8qaiw70v37okHoPtvR2BzePl5mZy4v2sJCFXtjTZXCmUW2O4sj0M75b2nQ5SMIYgFCeEbFz4FgUOUJKOlrFg68RD31eo7Lkrh+L9WJBRKMjxHdMgqlgTyh4uGcS7Qbp2yfTW7sAfZVDRpRcJLXZRs=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:52 +0000
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
Subject: [PATCH v2 08/10] media: tda18271: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Wed, 20 Jun 2018 07:18:01 +0200
Message-Id: <20180620051803.12206-9-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 0652a9c4-a8b1-4526-b969-08d5d66d5128
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:NBokvFBBeEjHTtFUFnAHLc/VXj2HKvIPg7ziInUSLNOubP1aiD55H442vhYdj0+PcEwpG3u0hDjozjfnsnrue6KIFvgrxFkcRz60ENiQ5/3UDludl8qE23tGcFm0ymAan8ZBOs3aT5Saq03MCYQ/V+4JGBuPuEG3yhG3RgIIHDBjDjG34WH1J+XjStM3eo/iDEjXdgsLtN1nfXaY8PNPHXohk3ATrs5/vsRdrFoVxt/L5sQ5vYNAaXZn/daSF7fa;25:49T3zb/Jm3VkVxk76x952hJXEvotWgV6dsFd58P27sDSr/FfiZ1dhgwbV/w50cKjIc6b+KKWyP7tBb9O0wc15NyZ30yiT/BvK6csY3D20AC/kgM0rYtNNqCN0HlLYlDgDqUghpE6G3BKXujM8JMl5XiqxJhfyNk2XJFWPLGscZt5xUYklglvZhOfbRtkef9m8vZ5QAf7kmWUK5NwYe0roJSiEsn051dbCiOZdjFy8KiAv3VgLMdpkKyDRN7hJPKJCJmWROBd6lPn/kwwZRmmaq/kdAd1D3KU0dJjB1MiLYGvdOXPk0crfAnLilL0PAPEssRweGfWn91yfchKWZK2Bw==;31:szMvBagUHVp0jpRwTV4ZyEmT7aU02jYxLh821k4pQ+wvFEX00WA4VEVBO9djoMK/prt03JmXBZFiDMQFoD/LKWXWGGxiAaatQLGFJreLbILMoxFbfklPbpU738A73qeapMLo88zbArEYz7psppNSFWfp/Y0YEmybwdHF8Oc/hAJV4sClwox26kKbPxn31o0uHVTeiw5nDcFpFJDUkZz/IGeDD2jM6DDUELYXVyt+r+s=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452414A94C0393E562B22A9BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:iYQG2rmT6UDBy8pqGsufKK6ernxWVtnrlZMU8EqgeEYdrIepWsF1S8DVebHrGg5MVLiVk9n1WtUsRQ1AIy37PwUN3JbC9D1NRo2CXqVBmhR9TySHoirvy6b0WcY/6lhozpvJDSQW+FxIDD4w0mm+D0RLjz3HznjJdZzVwHk9BAHBerkSDoBXbviFqnIStSB72oKAINlOhx/rhWwAXY/BUBrt9Ncygjr7sD5OatOVn0Lp2JcS47tf7Bj2Btb5M7tB+uNT120Rhmfm6nZNypPWIQ==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(1496009)(366004)(396003)(39380400002)(346002)(376002)(39840400004)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(76176011)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(446003)(11346002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:0AdpY6RyuVBvyXLpJin2nURgfNBa5cyqiDhV+jv?=
 =?us-ascii?Q?yWPozx1Gnqb/hSPFZdKuthAl2G9hgwT2zYxil6gewrHhtwgpzSMp1P/tp0eY?=
 =?us-ascii?Q?N1rZKHMoUKjdf2JfRTH3w33bOoXVrBGwqV0nV6QQmXJSuzWb+BJ6JvYgWh12?=
 =?us-ascii?Q?+/NOn3ffKg1qeFxQUsuHKnZ5EyAJ3ZMIGe2Ajd8SHQkW9SKFd/DJXpIu8OCP?=
 =?us-ascii?Q?oEHRFHuF5La7xAY0zaj+cvSpnffUdJaJBOIAsdCDdKC7Tf1bf3rarKYm8Is0?=
 =?us-ascii?Q?Hv+xGZtm6oTUX4yzgyLU1FjR4DDlV3nuMQNz7WQqzmY/X368lkxMGsWXejgq?=
 =?us-ascii?Q?Oay0YMoWO97JD6U3ZlfYUv5PJYNd2hakPsYJmMJtKUpUX33iYMIdSKDkBdKF?=
 =?us-ascii?Q?66Ug6cL6eFZJlGn5NbP9N2ltmdehW2FsZBiyHcjCwTJYBfGsD3zjzKj9VAQF?=
 =?us-ascii?Q?6OxfE7OKrqK2Dbmxh4xqFLtBzMJo6Iu7UrP1XZDrWECT+NKnKbyqDzt14nR8?=
 =?us-ascii?Q?c0zeOtw0c6UqhDKwBlOqnvXAOPygdf2fyh1KQgtmp83Z+wESABE3nkLCbShb?=
 =?us-ascii?Q?u5Gx66l63lLzd9Jbt652DNDtQUZoqgjsCUxjPEzXknsc9Kd7GZB1nWhHHXd0?=
 =?us-ascii?Q?3RLVb2gcs3AyxF5hcJR+R2tttl1AbGaH7Sbcs0FDky5r2HhRcKxkhpz5Kx/j?=
 =?us-ascii?Q?xtghh/L9o+v5zfX/kCa+d0x8XXkqbDUUVRZNEpObxbuouEjEsBL5szuD7oyn?=
 =?us-ascii?Q?7ME+LMd/auaqykcfqqvN1BJGKH4xiVoxKPJQ7xRLBz9hVXNRKzpcEDzZMcMH?=
 =?us-ascii?Q?rkI9zC38WPr/Po8XPP+5h31jsrKKYwyVfgXguXzEkNHtT09+Y/Dkln5jc29f?=
 =?us-ascii?Q?Gtwf5jaOY1Db/WX9RZA/GV1+ore96Ep03v1BkKBSWHg6EoEAOpWTY1yweXun?=
 =?us-ascii?Q?YJj5zCeQyTLCpMwhO4L5XeVkbVtyE9mO3d+BUiDOHbTDSBQzwxnpMGyfS+Ol?=
 =?us-ascii?Q?GlWiHgwbYPFE4Op7c4pz6Za7JljvlaJHW+iM2t33U1dCx5POd+xFX6cLwFhj?=
 =?us-ascii?Q?xWb3rnWBtXlAueUAKeTYYVjahYgAZ68aRuaMn/k6Ujp/SfNKoJnaK+Zmzgzu?=
 =?us-ascii?Q?WphsNQmBeWpBuGvPPGXrSjipt5XI/PyD5EgwBWFyB86+6ysy0h5EV+WSBPGv?=
 =?us-ascii?Q?EBPOi9YWJ8Inl9SDIVtut5nZ9aRUZp3IPOav6SXvOtyBhNdZ95rqvQU6eEnt?=
 =?us-ascii?Q?2Dht0x9BNgpNOpQ6NJuxDRNE2GymQZ+ILhHH+tZ3vUuyzE2RfREvdqwWleqD?=
 =?us-ascii?Q?SoRiKY6DglB/suggjD2FJJWhhCXDIVoQ+QqudQJuqkK9e/NQYHYfsvo64Cp5?=
 =?us-ascii?Q?4oNJeuJ+eq0XOg52ujJc8nSgyPukrts3xKfq4afIaTAEJyI80z2hFIojsjX/?=
 =?us-ascii?Q?lTyGDsePah7vFriuMhBkAQmSIWE9IDfVjr76nJH/RSMmYbDF/Gk88fkXAd/2?=
 =?us-ascii?Q?nbPy1SPjpB9njsjRa+ljjByyfQlGwnM3/4TtrSb3ehyWOZKKHtEdI19lBC/F?=
 =?us-ascii?Q?ANgHylrFRxqLZ4vswpA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1pT83Wg7SwAo9QT7Z/R6BR5xXPffExV5HuN3Gx2lD1hTBlO4RhtbWAbEO82GNP3hNAxQe8QkLe1iuHE34y/kz+O3FXixGcW1iEHoNYJ8MwlQk7kdn1VeZXZmuZCRTCBThCAhK0lIBfO8Wz9ksVyqxgJQgWWeUoxKD4e3CC9NwJ5MdpSMCBODMDxMM78C5roM4jYB7kNwaE24bQFz72y5MsX2cajZNxzWf6f1nObrA2vHADl+TsYvd1XNMHLNrJNBGKsS7sagOZlI9F7m8wEnLBLvtdp44QqaAiRS3ksYNbqP27a2IGx7PlN96usCk1QkdCzg0T0GxETFkUkXpTDsrA==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:K8FMiyXVsXDQk94Xq+RdBPvSWRDtLFQFL7fRkhmUDIb+4QByYI+zWuJR5zV23bJ/3Rj8p7NOL5ZboLcZbiAePpXBWuNvP7VMrHCKVlODF03ez+eDIRBdOh1lPThGQMUaIF4bkXT7feEFppSlbH2JWhEkePWIzB6xufjKGuyNcunS1iwK5t2LN3EZiUi2QK4GLSUdEagq5CjGS0kKcg6BZzJJO/OA0kVyslbjZke5jPshl5n6Qd5Ea6pyQhby2YxzJNZGwNr7PGvAbjENL5//feGKQFn1A0TUoRFIGjhPSCiB+kAHz+nxBsWiL1KU6edytd7n8BHycxHt3114pTcyvgChi15xamdY06mX3LcsbhYWzF+ggqEA0GBeTK/+pgfqHGYQJ9bgIB+cqOCIPuItFbeZgQLy0YHcAQISr7nbIN6ZyMYzRcI5ujVRk+qRg8Gnpr9JCnWjg9AW0YZwkOssag==;5:NV0qyybv8YCHVbKPQyxytlqwjGqnVoqAoNKDGCyZ2SW2MZe+BiMCRNxhEK3nelksQJ0dBmDaFq0i+Q/xM6unSx7g0wcQR9vcTzPYntcIWxKG7pWL95TotECLK5vJ8U6KfUvxpOT7RSPUazq3jnqs4EYksmG2gLXtn2oq15TqDUU=;24:sVARYiukGqxwAq4u1tNt0H06PK5vSYsaIsEdME6nvPjOah23hsN/3M0FTiimqJL891rGtizjreo+EXACL1DuZHnvBi6MkFcKxdbgUWM7LHQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:MJNm7HSEH47+JuZOmR3HWpdgONtSrliG/4pZNOvbZQpSiC+YRO062v+0gtIJ4QKPuQvSHSGRVs4L9lejOczoSTZ97rwZCJOIjNu6Pt2uCTNKepl8hxmz64CQO1vGm3YPbfOows9mwZpY5n3xaV8ZYerR7tDdDGO3c+S0QbzC1eDXGbrmyYpAo5+02/tvcY+2oDegL7bFI5ReRuNk3D/3H6ecsY0xTO05TR1HmEKrmSFQZcZQGC29dAeTsqloHjmr
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:52.3259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0652a9c4-a8b1-4526-b969-08d5d66d5128
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
 drivers/media/tuners/tda18271-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/tuners/tda18271-common.c b/drivers/media/tuners/tda18271-common.c
index 7e81cd887c13..054b3b747dae 100644
--- a/drivers/media/tuners/tda18271-common.c
+++ b/drivers/media/tuners/tda18271-common.c
@@ -225,7 +225,7 @@ static int __tda18271_write_regs(struct dvb_frontend *fe, int idx, int len,
 	 */
 	if (lock_i2c) {
 		tda18271_i2c_gate_ctrl(fe, 1);
-		i2c_lock_adapter(priv->i2c_props.adap);
+		i2c_lock_bus(priv->i2c_props.adap, I2C_LOCK_SEGMENT);
 	}
 	while (len) {
 		if (max > len)
@@ -246,7 +246,7 @@ static int __tda18271_write_regs(struct dvb_frontend *fe, int idx, int len,
 		len -= max;
 	}
 	if (lock_i2c) {
-		i2c_unlock_adapter(priv->i2c_props.adap);
+		i2c_unlock_bus(priv->i2c_props.adap, I2C_LOCK_SEGMENT);
 		tda18271_i2c_gate_ctrl(fe, 0);
 	}
 
@@ -300,7 +300,7 @@ int tda18271_init_regs(struct dvb_frontend *fe)
 	 * as those could cause bad things
 	 */
 	tda18271_i2c_gate_ctrl(fe, 1);
-	i2c_lock_adapter(priv->i2c_props.adap);
+	i2c_lock_bus(priv->i2c_props.adap, I2C_LOCK_SEGMENT);
 
 	/* initialize registers */
 	switch (priv->id) {
@@ -516,7 +516,7 @@ int tda18271_init_regs(struct dvb_frontend *fe)
 	/* synchronize */
 	__tda18271_write_regs(fe, R_EP1, 1, false);
 
-	i2c_unlock_adapter(priv->i2c_props.adap);
+	i2c_unlock_bus(priv->i2c_props.adap, I2C_LOCK_SEGMENT);
 	tda18271_i2c_gate_ctrl(fe, 0);
 
 	return 0;
-- 
2.11.0

