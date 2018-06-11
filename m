Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L7CLLLY+HlviXQAAmS7hNA
	; Mon, 11 Jun 2018 09:20:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A3B060850; Mon, 11 Jun 2018 09:20:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k1/TNJYe"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A006960791;
	Mon, 11 Jun 2018 09:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A006960791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeFKJT7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:19:59 -0400
Received: from mail-ve1eur01on0076.outbound.protection.outlook.com ([104.47.1.76]:10656
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754172AbeFKJT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyz2aOwOnCZzyS4VcWDn5SicbMGLaXWPofJAFOTX060=;
 b=k1/TNJYe08cvz8k/M0lFAyfnYpDurYS4u65h6QD9UHnQirScQ2dmAtctA07UKjPrC/+zLBdP/5wng+fplia5M1Vzu42Z9+oeDKOARlK52Lh5kh+UgVWl7Rk7VvpsvCYwcGaBTnZxql3pM8r3kT0BQWaMnOiPWdRVutY3r+ZpIDs=
Received: from idcbfarm.ap.freescale.net (14.142.187.166) by
 DB6PR0402MB2838.eurprd04.prod.outlook.com (2603:10a6:4:98::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Mon, 11 Jun 2018 09:19:48 +0000
From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To: linux-mtd@lists.infradead.org
Cc: boris.brezillon@bootlin.com, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        NeilBrown <neil@brown.name>
Subject: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Date: Mon, 11 Jun 2018 14:48:14 +0530
Message-Id: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: SG2PR04CA0145.apcprd04.prod.outlook.com
 (2603:1096:3:16::29) To DB6PR0402MB2838.eurprd04.prod.outlook.com
 (2603:10a6:4:98::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2838;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2838;3:WcS+elGA0P+UBOsEYGbeK5F702Kka/UQKOAfY6s4cwjnmDcO17l2P9QcCF5L4RLFh81vbp4mhEjvxKmfVAl17bFjN1TJ85ymmXdFzTq8Mq06ejK8m0aJuYiw0mlYfoA/ymmtWWL0ILoH6avTwPrGhVApy2B4jZbqLQB9KOMzDQQ1BCkg4TKgLjZmTXe8cAf3mSwCBziZJR+IZYssOTrhFGxbyaDRJeD6sltSrt0Kz17XOZs/YHAu6Jo9hCPZv4eB;25:QVY3tZGHCRfPXwVeuozSMTlFo7+QsuRS1QzbgWGEeoKR9FFDOWF3kz1nZYDdyctfQLXz8qTwjh1vmXKXHTaRWc0EdmmDHoAv+seAmSsVMdOSiPf9HQtZd8GTq0fYfGLM4ee5lyQNKgVLpEzG1/V21mrCS0E53qwizbBcnL4ghx0tM014jlOvFL0v6JVZ5hG9TsdU+ifgw9Iw3VBFu8gzMnNnSK5ZihhjeNmv5U8mrq9zYmkTp8UiaLyEMTZTzy3uZ4f3RFL2aBiS9YalWLyUe2q53g9HxWhsybBi8DSjiJZfGoyoBGkVtQugFq/TxqbPIph0jtZR/J+WMInFCuu82Q==;31:V2ZfjOU8CQaoeIyRqss714OTceJp+x0UZewa27RxCV7gaD+0kZfZDd6w82UcRurO5rv4o0U7Zx3LK9TtdNDj0Dzolj8nMGMFSMgPqOfrHvQbJ0hfYQCfrIVwHITypW1ke/eCUooOLsP3ua8qVwpj1Fc81q48wIMFJ+iPpXRA13Ccad6kUmZq8Ho3dEfwBAaFSenBbe+sQIbNBwXiqhHDBPuEI4xicVxCrgJWbAxBiEM=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2838:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2838;20:lQblwnVW/XY5EXijpR03xBZhf0vdH9BylrLPWV6O4Kd5DOfKAcsYpJnTtjT3brpkmUkyMjOcbIsHvIldlA9BMVEku97gFrCdnLvmPRCGKEiGw7MperPrjVFp1ZlhMKa0W97OGJOpJMbZ7lzPunRqyXhr1qIL9mWkJha0aG35Uji4tNnK2SXC2Usv39cEMhjBmUEC8Ztj8YVdy5kOwSCVuaXv60RwO9JyC9i4tAZxN6/gSw2WJqB0oOsIp4zOpXTHjz3ofEbhn7sSM95aoa0zo/OPEF7u1uMP/UjasPyiuliVMys/xKBAi+tSLIgEB4txjmYjot3et1wZEIj8BMzDk3Mp90x+KPbVgWsLZhzUnJAwDp65HDnW3h3nF+CqWx3rqn2dZ0pNdk/S6F51o1AgpSLOYexAw0/J8eUWfMyu4H+dsWgiM4GUbnoTuZSEXnCNP5IsL+uUnRqBzsuS7OwPwa0+d3fBH2jTXVeWVxhmDuKqrOVV0SXTEFrxEfzPIXIQ;4:s/qOpXXi1VOM+kMTiucvsSVyKo97i6fyFpqmVSji15BnJaVRMb+/Yxz7nVL8dBcKirDoZmpz+oeNl2V0AScJbWCv0bfLxfFFkXL9FJ5a9HprHYunb+YkDahVSpj+0a1hxzSQ+FOEooSrlpZRCmjW5ODOrQlhoF8J50zGYQnkXcpIZFAKZ9NTgXQue1qGgqe2xWx36dQEtUHVpNzOzg5hx7xDNCbPisDcUxfPdbV+ezEDxOIcMaCUCFxxQtt5+p5bvnhsD38Iq2lWWVb8slmn5k/7R1n9QGNYLzLLObViAtdiBTugbZlnuy6iSa8nOdansa7oUQSGp5wgSWai/I9X8eHcYH1p/RYzsEDRYPdKvnI=
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2838138106CAE67451F2DEAA99780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2838;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2838;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(6306002)(53936002)(6512007)(81166006)(8676002)(48376002)(2906002)(5660300001)(305945005)(50466002)(51416003)(81156014)(68736007)(52116002)(8936002)(47776003)(86362001)(6116002)(3846002)(7416002)(50226002)(7736002)(66066001)(316002)(2351001)(2361001)(6916009)(6486002)(6666003)(956004)(476003)(2616005)(97736004)(486006)(106356001)(105586002)(186003)(16526019)(39060400002)(4326008)(25786009)(26005)(5009440100003)(55236004)(1857600001)(6506007)(36756003)(54906003)(16586007)(386003)(478600001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2838;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0402MB2838;23:1IFJKFnhWu21+p/QXt15BA7zFVe202iwejCqYtw?=
 =?us-ascii?Q?AdEhdKrWzLeUUBnbKohC/JjKZbWgrTFwdwejgy4iC1mI830QekpkN+aU9E50?=
 =?us-ascii?Q?EDLnE3Y2V1EdwEWMCg8HpghdEq5jJAnWh/Bt053HQaHwU37jfaKaPwiUaslz?=
 =?us-ascii?Q?UsOh9M43qJ4OTM4RIre/mpMbbgkbha+yWERnohK8QlSyGsrzmG2TTgYJaJNk?=
 =?us-ascii?Q?BEUf71j/zYBu8KR5qHauaOLUEmEzxpeMs+W6yHlGuTjc2FXwZWI4cZmENAaZ?=
 =?us-ascii?Q?2HYYimGe0fU9/ostq6J1wsCGpM2RKktZ37EVrjZhsBOOHln9VtX1UG25S6j0?=
 =?us-ascii?Q?ADh5OhPq0Igy6JDpjh2xAHiRigaWJK9ESl3Zts6rUmDpe6TaR7/mPBkJnEYf?=
 =?us-ascii?Q?6QrluXbg8/sVF4S6e+9fL9qgclHz/lcyF6TzY8gjsHe3eumrEwRLVaCCZTB5?=
 =?us-ascii?Q?O9tB8lMjCRqz1FcHvuYJCg5w9s6edeup7yF4o8JA5sDhwjBDDs+khi+gw8zC?=
 =?us-ascii?Q?xC96yEQtyaxOxKCkusezQR5CKmHM8qrYhQYAl7qleWtFAmzo91qlwQRZhBel?=
 =?us-ascii?Q?ThYvNEzhXQOOMXHp2iLAV5Xi8nBax8QAvoDwPJHUaI6bQIUi5VEvSldQwKLi?=
 =?us-ascii?Q?el48/pvpwEx+uzRchmE3A0funOnMQqN4pw8mcPHxkxTzq/DzXn7+46h/7uf5?=
 =?us-ascii?Q?d2divAMWnZ+7O8/U52nPcOkKXo/KW2+EzibL8EZLS2hW1QJ4848Sbp+CqVed?=
 =?us-ascii?Q?FfzeGf8mTHfHctaBhq+uOJFAkiOYbHjTdtrhtKp7FXAh7zcqWJISDDT1BhW5?=
 =?us-ascii?Q?a3jmsV07X2uSTOPq3A21YzdK1ybgoVsvxSK7YvQMqt5kiGB0hNuQanjMRVoH?=
 =?us-ascii?Q?raY5LHLKXcAiXvC+l2nz7vPvpT8WpsghDDf9NrzGbjvmIpb6b5Hqbf8HFhh1?=
 =?us-ascii?Q?lX8xtpSgtTTi+t5qjsL4lgQOBFceqvkP8PEVPm3qyO2y/qFsGDvcH910t69a?=
 =?us-ascii?Q?nyT7qmCB3dXBUc8fEnkH3o365smeNadQ4JN/gY/lrrU94cSMjmz0fvBkWBaB?=
 =?us-ascii?Q?eXyW15m8J5UWqnBBVn0OV487mKve1XAcM9oNcZx19DIh2lI+hihBHcT4/pky?=
 =?us-ascii?Q?+Dwh+pfAX1yPFxVyuFFBqfdP+0flrVDJnfscSTwlfcqv4JgGC9QJ1pQFE/Pc?=
 =?us-ascii?Q?Wpxj/LNg7yeBfGipnoDPC0LJcrh/ZDlljoQOVAejJ4KPDYSixDMDp++rJV7Q?=
 =?us-ascii?Q?kjXeHRSdYJgJt7+MR9SYflTCy/aIdFoBcT0jN7fcdB+bxhMBG+zCfkla3S2I?=
 =?us-ascii?Q?KXTpWwD8dAMhlHfLZDrwh/Ev5ru0IZP+piGLCeCcACFIvbbYaOLczvubosvm?=
 =?us-ascii?Q?2M4nByQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: /nkMMaYCup6xKjcCokM0xFRUL5RVUdsC7JzoFxRLtg+XyU3mME+RSS0MZWVbpGe/zXjBe9HOMz+H6ZaOFv1CEv6E7mg+vCiLjoV3mEE5mbEICajfQskGuA4uCJFSQpVS7Y7ckjR/ynBJisF51S5uHcr+ZJr9U73G8oC+zIFgdrwNg0OC57IhfG5LBTDorAIT
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2838;6:TCzaR+1/ZcEfeFmjpY6loAMm5pRNimlHDUmcHmYrNMLr1QOvYN4kz9n156akzeLb1gZAdKI7ox7tFqX/3/nSq+xdrlfOJMrjB1YuEgc+fi/EXA5Ivy5J22PgUI/g5TWQNPWCn8fgEuKVneQLq+IhJGQGUCR/OSrr3EoCZDRc2W6ovfmg3VjyvomWdQWcBj085UeHbU1aUEz8iZKbKdb1NyYexGZ+tK8jkoogmpVtTyNEMDtY5xFQS03zs/sm307K+4pJGGfYz+uaZIb3f8ZhKyVBpaaVgMEHMwIEg71frNbCH16jm0ldkBvbuk5rfEpFrFLDt4b/CtX78K+NDKy8TM0iAZ1afEfTcU07bVV8UQ6oSsYJfQ+sp6uLCrnmA9xexL2/ifsTmxRD8DAj7kcx2rwdW1vWsoVO2Xr0BUpxYhVq0sgM63zw/CTMGEQIbI901NGrzaQJj7GpmLcvGGho7w==;5:do733TEwMF3CSww2LShm43Iwm0siKY8PRR6XtbakD13QzFlkSSG/CNLQh9FJeTt3o75rREcc1LdGUQIQrgZcsOfsav7KUSRIEI3VuqQQNNru4C4nZ85k6AlIjmJRysJ6fyUncdGqDuzDgaRM/oo4gxvU5+ErolqHP9WrG+Zc41w=;24:Tm/p7RG2at3GpgjWf+wBKTyzvqtEIe0YPk6J0/PCSnU2xbzFfDEx9t8Fcwt6uBIhBFjoKuCQ04upBnDMzsJ3tA/OYoOAl3BxNMfR0ySl2Mk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2838;7:G+tmhZ5/51lQcMLNDL67+TAHTg2266I8Oy4df00feKLh+wW9vEKZCd9I/XJWbyXjbvz/QqiI4H6rcY7rRzL3zbowKWi+c25VS2R99M0bFfMjupgVWfOL51ARDDO+nTnX4NQY0tHu2m1C5rQYDlMEW/jctOhdoTXLbbcv8KtNtp3GEba+DycqDBleUzH9YQ5jGqJVNs6Sr0LudB8bX78L50apQXccvIHXYF3a2JX9KDg+XR4OkEBnBceS1/NAU/2g
X-MS-Office365-Filtering-Correlation-Id: 3141ffb7-604b-4c3b-2ab2-08d5cf7c7d92
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 09:19:48.7262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3141ffb7-604b-4c3b-2ab2-08d5cf7c7d92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honour max_data_size for spi-nor writes
In new spi-mem framework, data size to be written is being calculated
using spi_mem_adjust_op_size().
This can return value less than nor->page_size.

Add check value of data size return from API spi_mem_adjust_op_size()
with the actual requested data size and write, max, only supported
data size.

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/devices/m25p80.c  | 23 ++++++++---------------
 drivers/mtd/spi-nor/spi-nor.c |  7 -------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d..60224fe 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -72,7 +72,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
 				   SPI_MEM_OP_DUMMY(0, 1),
 				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
-	size_t remaining = len;
 	int ret;
 
 	/* get transfer protocols. */
@@ -84,22 +83,16 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
-	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-		ret = spi_mem_adjust_op_size(flash->spimem, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(flash->spimem, &op);
-		if (ret)
-			return ret;
+	ret = spi_mem_adjust_op_size(flash->spimem, &op);
+	if (ret)
+		return ret;
+	op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
 
-		op.addr.val += op.data.nbytes;
-		remaining -= op.data.nbytes;
-		op.data.buf.out += op.data.nbytes;
-	}
+	ret = spi_mem_exec_op(flash->spimem, &op);
+	if (ret)
+		return ret;
 
-	return len;
+	return op.data.nbytes;
 }
 
 /*
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5bfa36e..3e63543 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		*retlen += written;
 		i += written;
-		if (written != page_remain) {
-			dev_err(nor->dev,
-				"While writing %zu bytes written %zd bytes\n",
-				page_remain, written);
-			ret = -EIO;
-			goto write_err;
-		}
 	}
 
 write_err:
-- 
2.7.4

Patch is based on the spi-mem framework[1]
[1]https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-4.18
