Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeBLTii (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:38:38 -0500
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:56672
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750930AbeBLTig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:38:36 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
From: Trent Piepho <tpiepho@impinj.com>
To: linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: [PATCH] spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc
Date: Mon, 12 Feb 2018 11:38:14 -0800
Message-Id: <20180212193814.17644-1-tpiepho@impinj.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <1518463905.25398.281.camel@impinj.com>
References: <1518463905.25398.281.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [216.207.205.253]
X-ClientProxiedBy: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To MWHPR0601MB3754.namprd06.prod.outlook.com
 (2603:10b6:301:7d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ddda1ef-1342-4270-b42a-08d5725031b9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR0601MB3754;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0601MB3754;3:/8yQTrU23R4icxY9TNBENiyFyb8Y8gU+W5g8hQtU5FM7ssYOLoh1EARWds/V+4J4Fxq9N8CzBAq2z5UXoOLMOkyIqFsK10hlKeuWdEM/EW6iBVQu637iomf05DhqmK9zluAwfB2Yjl9OkTwVeRSOP379apI0V1qCmHU1XcJcJDwc9J5Hg4Ii9bv2/dG5+NFog5weJ/3Ls39q9X5m0XTgaCwDbJiUSUXiKWXvg6mFYg/jIaWDTWJyTdXKCQjgvjqg;25:aQXrulIqYB6L+4eVAlZMyfZS6vRoVb8laUPTwMerJpoEsu6ZSQotomA5chmOLQeRT7UR7t3BfQiqU6iPLE81U6NeRVc191/VfkB5bFyre5hBA+X3jPipKTyWP6hDO23v0XgPN8/f6AQfTQzKjIoM06sJirSKe7X6p0JEJV0e7sC1/TNb9ugHQFs+Z7an95yjvqbuRRb//A7wFjOtASZ4lA+nMnNRNm8j0Rp1XRZTyXNXth6M6XyslAh1RfQ2oUqamr/iCydeuuoHYQ970X/ySsKZhKmhyBv5b+Qt77jeLNMNsO5dnxHhrFUnrIT6gG6FWRwlRW5sbg/oHLKyhoNBmQ==;31:+7nd7EE2rwNDbB34BzrzVR0hRv37Pl3CpF4EUzPy+D4fLvXveddybXEA/aMHOqGJS3SCtY5i815gPd1gJT1EfenQ2SmAvTCwCIB95T7/ubu6977nVsGUDY2edfpmCPlNQxAHTvQnw7THuZtFIF5+GyvXObDKSAdopryWzT0XlEobbP6t30d8k+Djli6Bk5Ssh7BUHE9R+lDUM7p5DNTQogBOuJfurIW/4Z3tdFvo4LQ=
X-MS-TrafficTypeDiagnostic: MWHPR0601MB3754:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0601MB3754;20:GMv0WpafHAhdhaExdlYp6MqBv1RYsUJWIcmDrUjSpqPabks+xAJNpTJxoLXymKOV+VVweZdlb/Jk3tyrThGESb4bSNkz1sI8TPqdlwXMUvlj19CBNBadvuKOipp7iMAyYS/7qQ0gnaNW7fp2VWOzknrppDB0/6jeC9El67o/UsrPfDpmDVbuFAwmR0TFWdAsJ9Vp0zGeW9r1jMiBa8snJC69Y3bkhg1/69JBLgYi0wc3ml5G/5a7HXHeLMoj83OSxcwzLUNy+NwW/cEu/v+lvCQaA+rtNLrTbiW9F6A7YZM20vKMiCU8OZKe+gYvxhDGvInkjv7I9KKR4klC8/sjeaeej1djETCBuLrJzeX34Cwvzt/ih2Q/xhPBD3YcuDH3bA3cZ3mtNXnozCni2cClw3jZhJQLIyScPLkTwAazAgaIN5/CRInGxtYQ60il0W3lXQmShlqvTfbWX5Fl2WlKfUlQS1NirS3InBFfBIu5O5+bPqyAOADAxMdnSH2ESU0I;4:a17dWkAKfMYi7LOMl0s5az+fdElgel9cMarAmAEme+JDK+VonMepnvb0ldst7RCz710e3ecDf/2Hxvo6msJuNfoD8EsETGyzRezZNPgUqbR/OPk4TJGQu0hRmaTekVzmW7ai5T0z6L7gzCkBv8ot8ocLGs3riGooJFiEu3qdDmLst+dcZUpUIwS/lceZV2cdLjAAugFHGUrC2DTkNTP8fyq0+IhneMOaOtNzHUzU8aZzNORt1hWOmaR9YZDUtV/mic0LehlbtB8D3fSEOU+37g==
X-Microsoft-Antispam-PRVS: <MWHPR0601MB37546F39A6425005054BE3AAD3F70@MWHPR0601MB3754.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR0601MB3754;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3754;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(39840400004)(346002)(366004)(199004)(189003)(6666003)(1076002)(2906002)(68736007)(23676004)(54906003)(86362001)(186003)(53936002)(81166006)(8936002)(59450400001)(50466002)(69596002)(105586002)(26005)(316002)(478600001)(16526019)(81156014)(97736004)(47776003)(50226002)(1857600001)(386003)(66066001)(2950100002)(305945005)(2870700001)(106356001)(25786009)(7736002)(4326008)(7416002)(39060400002)(107886003)(76176011)(5660300001)(8676002)(52116002)(36756003)(6116002)(55016002)(3846002)(21086003)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3754;H:impinj.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA2MDFNQjM3NTQ7MjM6TU5oR0FQeVQwb0MzRExJaU5rTVlLTDhJ?=
 =?utf-8?B?bFlyZ0QySWkzZlF5d1hlNFg2SXkwM0hBekdjTU1peGVYNGZZVnU2SDNWRWxN?=
 =?utf-8?B?UCtDcUREUS81WHFwcW9mZXlLNTd1dEhVeU43V1FwSXhzSmRVTHVpK0tXVkxI?=
 =?utf-8?B?YUpsMjI3UFAxb3dlU3FldmdVMDdMS1QrSjE1d0lvcmswYWQzWVE4djkxL0RF?=
 =?utf-8?B?QTNZY1lGL0FrbWxSdjJaTkZxbmswd2NsaFZLTUQxMDhERmJETVVMS3NUMWNH?=
 =?utf-8?B?bjZzSWpEQ3dFTmdVSEZ1bU4zMjRWVWh3dWhndHc3YzlUczVJaDFpcldRaGRa?=
 =?utf-8?B?MkhkLzRrV3lUS2VxckpMNGdqaFExOERsOVMvNzhmaHliQjVyZStaaEorMEdu?=
 =?utf-8?B?dWxybERDeUpQK1pyeUxYekNyc1F3bFhlZGxZeVNtSEJaY25UaWR3R1VSM3Vj?=
 =?utf-8?B?MGc4V1pncHBvMmorWDlLNldmNHZGSnFNUzlIMUZ0dkdZeXJWWkd2RCtYSVcv?=
 =?utf-8?B?cklNYzZ4bmdDWUk5Wm9qbml6L0JMTUpXRDBQcXZESzdaUXVKUTA0ZlRQZ2NV?=
 =?utf-8?B?alFiaUI0UDluYlozc053WUFKVXJnakhMQ3NpcnUrZU5XbHhkeGVjWm1GT3Fx?=
 =?utf-8?B?YTZVT3FpQmZGZUdOWlk3ZW5TRkFIYlhxdmVzVEdaRk5INEJtM1BZcGZTeHA2?=
 =?utf-8?B?VUJyNklrWFV5ZHNKZWQyWHgzZ2VnSDVZRURKU0VVbEw5dS9PeDVWZ0xqT0pa?=
 =?utf-8?B?alNSamZvTjZHUEFkR0JPZU55RmozSktFZFdUSEJjTXBvV3V3amQ2aEZmeXdW?=
 =?utf-8?B?cGF5TldBTFlCTEZndzhHbWpmVDIvbTU1UTdzRzlqcVhqdFI5cnFJT2JIdURC?=
 =?utf-8?B?Sy82UHR3aHpZTkVCb3QzbTZTOU1nNmRmRXhGYlloUkg3cFplaFdZOUxabTZC?=
 =?utf-8?B?aGsrTDJLZ3JmQXZRcENGeU0wZUIxMnlRUytweitDMENKeTJ1cGVMVUlkRDZp?=
 =?utf-8?B?eFh5MDVFc3VLaC8yWmlZTlZZSmlkT3FjWVhodS95eUdYY1Y3MVl4UTkxUmdR?=
 =?utf-8?B?UjZMK09VWS9TNSt5ZHVnNllDQ3lvSVpqSFgyS2haYyt2QndZVDNIMktLRVJU?=
 =?utf-8?B?bFhra3ZzbGpWZlQxRmpFTW9FaHhGN3d3UTNKQkgxYkIybjNJWkhmWUZVTHc1?=
 =?utf-8?B?ZjBlK1BCbkRVQ1ZYaklZZ3VlZ2c5dDA3SXFqelJINnNXZmFzOTJTZm42SzlO?=
 =?utf-8?B?a3hyS3hwMjJiRWQ1VWNZbjdRcStaamN1d25iWkUzSXdwc29HQnZzdkJuWk9u?=
 =?utf-8?B?b1VFbVUrcXFVK3lnMzNOWTd2ck1VSG1FVnZFSFEzNzBxZGlPcGJ1RUJnUnl0?=
 =?utf-8?B?WEk0TlRrdkNmeG1lcVZZUXJOanQwaFBIWjJZMjRscnltZloycDlRVmZxTnJp?=
 =?utf-8?B?QVB3T0VRVW0rR0l3YUZKeGNxOUZNcUJJdkNUcytlaEwrdVplSHZWYW00V25i?=
 =?utf-8?B?dTZGNGNXMTI5VHFXVHhWalhsODdrKzk3M3ZxMndUL25PRGNjb3U2WUV2cEMx?=
 =?utf-8?B?NTNkOVVIbmZRZVpYQm9iOWlORnpINit1ZzAxWmhZT0tBUTl1c0ZHUXZhbE5H?=
 =?utf-8?B?bnZhYThLU3hWZWtGeWZIY0Q3SWVERUVrSVp3SytJTk8rMURzSWNTbzBpd2VU?=
 =?utf-8?Q?auxi25+6BAz8FUIByJiI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0601MB3754;6:wFXG0ecm6qZdrEQ91trxpwS6zRzsuzu8ftkFdh9RKZL56SgUaryfd3fJ8fG3r5CV7Id97W2OjXXwS3x5Cfd73MtLC+8ZPEvJUgiH6ubXnhBO7N6j9X3NuVHun612mNgpLp33QcDhpfmQsCBMwdGEKBV1BISD3SeDmqATZj0jd+I0I9q0+xcc4mmRK36KpNA93ktuUZ0rwmFQFCybNvLvRL8ysTEKkuN5PHiBLHyTNifPiBL5JzBGdQ8UJRsMPDvE1gwJrzL7GbiR/9jAHGw5sXny1BY1nbOzmQp6XO6MrVbFNkC2vaQ7Enl8J0YdRfdvb8ACJEQ1CLdYeEvni/BUdR8i+V5wpvIZpSjLryIIyBg=;5:4Q2G5spW0+6QDDZ65/ZEXi/RJxyUeDSi+D7EXRhTagwX+VkjVoHeaZSDJIfeWWV1Gxp5C1BscewGQH0DaISZEvYscCIMAvi5Kp1FazgyWykkk9+8fBTctsvZIPapfXHCKUjiWsLpwlL9+A+XUM5Mo5iZ7r3pVDcl1JHcc2Ekymo=;24:q+4j9MbL3ltJQyONBhYlL+Wl6rrEXztx/Dea9PYFxv/ZQwh6HGu79Vv9nDO3kwgKq3Mzpy5QcT1I9XMn78SvWG4vdotTZHa6KPgD9dr69mY=;7:rSF1WxfFUZUDzhxdPBMLluL7At1ZqIC2n6tDPnZVpWBAE5O48KcIAg0cznl9NDfF8K9sFT+fWxrmp1nKfNLM8osKbLqqpyezrGsjd0VfBwERbhAieYMPKOlfN/Jh3VuVMp7YbXgKuThxi78+5Ap0pMo1UwF6E0aW3gAu7K4Unn7TemUhVkVprhmyXSCq25VlFuULySreUi+RFshgxZl5w8icj/LjLQworqXcf+NVhzG1OpIAl5iCSlMGXPXV24Og
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:38:29.9059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddda1ef-1342-4270-b42a-08d5725031b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3754
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to check for xfers that are over 30 microseconds.  Rather than
find how many µs a xfer will take, instead find how many bytes can be
transferred in 30 µs.  The latter must be less than 32 bits (since our
clock speed is limited to 32 bits), while the former involves 64 bit
quantities and more arithmetic operations.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/spi/spi-bcm2835aux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7428091d3f5b..1431cb98fe40 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -321,7 +321,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, speed;
 	unsigned long spi_used_hz;
-	unsigned long long xfer_time_us;
 
 	/* calculate the registers to handle
 	 *
@@ -358,20 +357,21 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	bs->rx_len = tfr->len;
 	bs->pending = 0;
 
-	/* calculate the estimated time in us the transfer runs
-	 * note that there are are 2 idle clocks after each
-	 * chunk getting transferred - in our case the chunk size
-	 * is 3 bytes, so we approximate this by 9 bits/byte
+	/* Calculate the estimated time in us the transfer runs.  Note that
+	 * there are are 2 idle clocks cycles after each chunk getting
+	 * transferred - in our case the chunk size is 3 bytes, so we
+	 * approximate this by 9 cycles/byte.  This is used to find the number
+	 * of Hz per byte per polling limit.  E.g., we can transfer 1 byte in
+	 * 30 µs per 300,000 Hz of bus clock.
 	 */
-	xfer_time_us = tfr->len * 9 * 1000000;
-	do_div(xfer_time_us, spi_used_hz);
-
+#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_AUX_SPI_POLLING_LIMIT_US)
 	/* run in polling mode for short transfers */
-	if (xfer_time_us < BCM2835_AUX_SPI_POLLING_LIMIT_US)
+	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr);
 
 	/* run in interrupt mode for all others */
 	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
+#undef HZ_PER_BYTE
 }
 
 static int bcm2835aux_spi_prepare_message(struct spi_master *master,
-- 
2.14.3
