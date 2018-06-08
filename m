Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id e2xqJ1ASGlttYwAAmS7hNA
	; Fri, 08 Jun 2018 05:21:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BF359607DC; Fri,  8 Jun 2018 05:21:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xt6wZnXm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 13C88601D2;
	Fri,  8 Jun 2018 05:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13C88601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeFHFVa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:21:30 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:4288
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751116AbeFHFV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIcKEFnKYhIrv4hpOPR3m89hB23+cp3UVtZ8Zsv1MdA=;
 b=Xt6wZnXmd4dPG5O84PV+xx7M9Sbzwf4oSOxLgDk+iuKgXNnJ4EF0z5N8bCss6scpcF67qjkEYb1Ad8oMUS8YHg0ZQKyg5wt7iNN1zsn+wC6IFaVGrEZGJk17szRzqfZac5sZuqBIzMo+DiDIUIYc5pxgIhC8h8qqebjT7kKqv8c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sahil.malhotra@nxp.com;
Received: from b42224-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 DB6PR04MB3270.eurprd04.prod.outlook.com (2603:10a6:6:11::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.13; Fri, 8 Jun 2018 05:21:24 +0000
From: Sahil Malhotra <sahil.malhotra@nxp.com>
To: linux-kernel@vger.kernel.org
Cc: Sahil Malhotra <sahil.malhotra@nxp.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig
Date: Fri,  8 Jun 2018 12:38:13 +0530
Message-Id: <20180608070813.27263-1-sahil.malhotra@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: SG2PR01CA0086.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::12) To DB6PR04MB3270.eurprd04.prod.outlook.com
 (2603:10a6:6:11::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3270;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3270;3:2cn8jvSnNsxPuPWt06NvCj5M9SEVZbaNkdwh3M1CJcLqpmYW5XMTPeOBcpXlVIQK4KyeaMaRGn+6wTtic7kfUiWKTYWW4/OHQkoFnlUK0+KjkqR1gAlVBKt1UXhNrRGzybctkyg0geWpzPXPinST7maAhjP09xLkvntuUs/Kf0szsnkOm8qPZYxXgLsaupt2th1vT8nDGIEWYbV0nS7c0RwogvQfBPQFgTBsbpw3f55jlG66sZ/je9mh/rzVMTum;25:MY/Br/lI7i3hCrCj4KCsuQdW3GuWUjj1RQYgs/zuTTbWNpQQI7hR/Jwca8oyVSPIvhFUTsHAXVOV7Ra6x1/H9Q3bDQrNVRX8sOVL6HTcMKjJEyJk/yiy/+SThb/H3WOHcOFHUrnW1HPunn/HzKJXy4uxXTo6swTfCd5vSeHPnCWupTiZBJ+DiPO30hHVrTX4qEMq0Tu7+6sQZt0MIlgi2okXkoN4mU0ptg+n5gHt3aYK6lPNaZyD73qX1xKQ7Z3Z16j43CC7c//JQwCfB5GvFRmTA46gNdjH9jGfjFku+g2BQ9QXk2MPUBUMNDaMZhoTbVZN3Z5p6ldVasnoUzHEJg==;31:fl6F2OqEmU22iLhjhab90kJeQaxegxzxzS9IGZKCJBr7zGCjC7rFMOfjPeBs/sRmwNwBUKt1FEqYKVOC5nIIWTh151X/9fVMcIdS1W7xNKrDCuldYzCiAoHtaybPWXy0jJa7xmcq8JsFnPLNuJo7EGP53v9eOt6j4isiHSmOWMGrp0LZqJGAHo7zNB5YePwG0wkYuj0gd1eV9sCCLpxGvRRFq7oXTorO818NxLpya10=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3270:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3270;20:zex0wAW49up2fpQZushZTobqi3fkr3rxwsFkWUVLS6fywgy4+ihNNDEqSz9v86rifS37OSwZ9Fj0ZkaYw7RZT+gOGadWB9g5nsP+RIzMRznWSy5NhDpCZ4C7EDqO+agLNP06VRYYiWWooush7qYsotkrUfNhvX8mW5ZQVtgI/J2yK1SFDOnQ27XH5Qs9S6jnkJ8OehNmkwNlJpZzjMNhVDc5O9tEPqr8O4H2yoF/fh5O98uFU/uVVXjlAAq6+1CX5QeUiAemSqpCmj7PJuH0rLidyuzZ9xYgHTfPc/mjt8m00VxyidePjdtkEH1YpQrLDjbQT+hksYOESyXjDbXmN3yZk406SVeXVgUPzfibzQNrjjnAHfku1np43lZysTGXkDPY1CSz36y6EoEVbud63kQJ8Cboz1adgiclrABbp36mBF35er2xaSrK47aq6FqBPTENYdBnPtlvw2yM8/U39kYojmumHPtbrTfuPEC0+c1DY7Rmrlce6q7zPor6oVh6;4:41AsnrMI1HaYT/uzWhrSdtwqG6NIh8TBGCrlDAv27SE8OFszm/BHwaBEe1ZjGk0J4cOdhDhezTNv246Vo0g5gGcCiPGBxD2A/aj5WD7wUQMomWDfwF6OaCStcDi92ZJo7QoN2O9jWuNHm92xv7ZWHzfUsr4cYCMfcF4l7xs3p+Yq7Y7tLNFEmzsy0ctqHWwteQcf9G8ppzdQWCwPQk4bxKijWkyZ1bybCGsAAO9tDmVQxb88xhkFbp1EaIBvmhN9o4mUZrNDGjuMOFaWIiae/ahTJ0qq8iJWe3aC5sPjtSauC72Z2uPWWIHVEm2M6jLF
X-Microsoft-Antispam-PRVS: <DB6PR04MB32703BC6AD9C08D4C79F877E827B0@DB6PR04MB3270.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3270;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3270;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39850400004)(346002)(189003)(199004)(51416003)(44832011)(476003)(486006)(6512007)(316002)(8676002)(53936002)(86362001)(81156014)(2351001)(54906003)(16586007)(2361001)(81166006)(386003)(186003)(2616005)(26005)(52116002)(3846002)(1857600001)(50466002)(6116002)(6506007)(2906002)(1076002)(59450400001)(55236004)(48376002)(16526019)(7736002)(305945005)(6486002)(5660300001)(47776003)(97736004)(478600001)(956004)(25786009)(8936002)(105586002)(36756003)(6916009)(50226002)(66066001)(5009440100003)(4326008)(106356001)(68736007)(6666003)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3270;H:b42224-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3270;23:CCGFnZbMzv0QmxBRHKSf9FdLaOD1I/EG/3X/EbqDG?=
 =?us-ascii?Q?55UXfWXkQY9VEEcp9Z+7YzGVZXnRdYJQe/WxzarsnfdH5bp5+Km/biNcWaA8?=
 =?us-ascii?Q?b/9e1y8J8cQzPIQuCUp27ZA6ZzeSjvb+c2oOqNTduspagDFaoSi0jxF/uSt4?=
 =?us-ascii?Q?qeihEvPFVWArdaPbixX/0CPFJTQd3fW0QTqb9Ib5JNISzx38IvgXExlsMSoS?=
 =?us-ascii?Q?QxjFthGOJpg6sQSkpxmtpQH7QmSUWS+Ml8HfRLTOflAy9a7jyXxd2xcw8p0l?=
 =?us-ascii?Q?tN7K4dZS8523s510AiDKmq9CbNxqbn+RokAT1ZVQLs0p0SEvzhX8ALet2nJ6?=
 =?us-ascii?Q?hyEpW5kyEFrLJq7P9kOPOIB28C8C8CEybfUtB8vgvvZesoxHLt83vyc6bKxq?=
 =?us-ascii?Q?ua5vWMJx/ueAzxD8ULgj+4Uv/HeRJw42hoOBNmpsnI05ZxguQVPSIUd6oS3X?=
 =?us-ascii?Q?dvQiz9gh7OKEq5M67QhKqoog18Hug58bEwsxoYoqaPDoTfTYq/fgIbikfns9?=
 =?us-ascii?Q?tzYMfKNJa9H8B1TOHtAk0eKWRXkflIdoKB685xIwVOWhtAcYzzyV2dJytAZT?=
 =?us-ascii?Q?PsRQHwVpepWhObYB52fd4H2L0taoDCYoOlWpAaK12EEMrcNeFvCoDkHk9GBs?=
 =?us-ascii?Q?90wt1/TQyenBAXrkC6CNfkNLmS9lOR+owGBdhCGgYywEhffJYpnhXb+hiPgj?=
 =?us-ascii?Q?MxHAyohQtl20PvZwhzFMsK2vWz25Dh4K388zawCeLL1deyVN0sau7Ylodylc?=
 =?us-ascii?Q?yvAYp6ohG/DA+ATnrCgGkSEwxkjuhLi6aKQvLDBAUG9p9D6ggS4WrM3Jdk8K?=
 =?us-ascii?Q?b8JQdo8F+gWZMKOHocxk7lrTwfZGihH9YoOuBJUL32XkzVkz/mmSwzFpRfM1?=
 =?us-ascii?Q?OmlHlujn8teYYE+5EWhvQZ/Qnrzl344zJnMHzgXxk5xMGiYD4V38nKMUfJh1?=
 =?us-ascii?Q?GDXU7zUaMoWseLc/56rP3tNoDg2rffbM3RVZxJUBRL72fl8RBeFCzWOAzQNb?=
 =?us-ascii?Q?PzjHcjtdvQI7oiSWRGQK22OUxLF7REqaBklI6eKzXRCQZMHY8avSQ5OU2vIx?=
 =?us-ascii?Q?8M9kSmapg+yH5qNEL3cZgIp/chcQaFuUmXvsmqJYk4Eyjk5bWWjs61+DIruM?=
 =?us-ascii?Q?PfwODst66TDPo/11ZbZl/x/RRk6t6cV9Juw4wxQh5Wz2jBj+ndYGDwU8Mdje?=
 =?us-ascii?Q?JfFSauij+LpgN1ltgeXb/O4+HOwBwBxSctbITLe3PKByP9R/A3VeyUnFGeen?=
 =?us-ascii?Q?9zmkRfI0XuW41Cof2oXdvCpMHAszD1UyojC+TDCp6o7Wc4nx3z+A8wJY0OZD?=
 =?us-ascii?Q?AunaKKm1f2vzEpT3G7uLlQMKspixceqYwWDyzXZ3NuLxAunZsXUaF6PCXEiY?=
 =?us-ascii?Q?Q/NQg=3D=3D?=
X-Microsoft-Antispam-Message-Info: G1xFRqA6LkMqKeM+wKCOY6WOygQ4YQBqIPlwuJNmy+haspGoq9pCQpJORLpYlzujPn9M8/GK+KTCaAI+/NBp0UpVbI01xw3ZP4YgJq5JO4Dcv09kezLZND1juQgdzMXsRTo4uJA/Hu9+V2Iji+FT5PNQggpiXKOlvwT9xXFiSVWmSj/JrY6OgzGF6lsmKyiu
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3270;6:JiWvPzthV4q9uQikdIfO6Ofp/SwXqquefAObkE3eJcNWhWtL8sLo3BhcQhNtBuDT2d1k2f1nBHDyhOMNlDwjxa10475QTKNdvGxO0iY63CDhoJcCrwZnnW0Ra76gMZLXUBKvPJXo2DYM2sf6SjlNQe8FIB8dSKbiCcrGiCn0juufXROLcqveK5FH7JrrvKPPfcbOER16v73AR6h3xvPXEldITbP1yuN3wi2sh+ru+B8tHlcs7797Cz3pCmUGK0vqO1q2YnlN3/KkhaJeSKVnxeBLegvt1sD0KiWnqjh2WWbEPMGiWddsxiTd5zrpbDmXf0Fj4DPhsk8fWnq54RUQrGnhcU2x2btUt8phEyMlec3o2yMFMXyNdYSzsqhLP8rUpTLb8kSfgo+c2qM2LS3j/p01TpOpyR8bliypifV8BIEFuNt9cteIdOr244Ty4Ajl7I6CVCBS1ensbzlt/qSHsg==;5:lNRoXAwkGgQTtEWsqrW1X6cerWR99Iq0rlEDQCaymMqxbj9iSqrnR9Eh6CH/aA7WXNuusJ3Q54xOuGF6hNg5vD3JkncBqmr4+V5Uu36WUAIny4kEjGnXJFQFAAYPIOOpsxq+u2PpXGFbmdm1i4QRZQvuy9zYAe23etQiYLAHtZc=;24:tRiZJ8cc5wr8EUzDRUvFvoa+OhZvzIj+G4HuM5FO6d8Zt/VESYsJD2hor7hfGwePkj33i/utY14UmE2b87dHosIyiSos3jCx7bRFaHsG398=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3270;7:kRSksMEaeKSAGh6uJNw9pJByX4CScr+ztS0jZId7dhcrdyGKBzj1xbJyXXr3dqJg/ZoQgCPw191t42k1ZTQFR7tDYKiqcmHWqKOqCoTx0tuMWKA1sFA3xAPy6i4PcmOUjwPiBcfUjqA426gyiPsZd9YuUEd8stlco1+e42CSAf+bLDDf2tyyGRews2CaiezeLFyy0jkgJxsezZRLuLZq+yXaw44ryP0Uh5daW+fuW0TS8RIa40sJnx7pORHjrJWw
X-MS-Office365-Filtering-Correlation-Id: a076029d-6730-4b4b-72df-08d5ccffae7a
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 05:21:24.5343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a076029d-6730-4b4b-72df-08d5ccffae7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds KCONFIG option to set number of pages out of
whole shared memory to be used for OP-TEE driver private data
structures.

Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
---
 drivers/tee/optee/Kconfig | 8 ++++++++
 drivers/tee/optee/core.c  | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 524c7a80fde4..f425c960a5a2 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -12,3 +12,11 @@ config OPTEE_BENCHMARK
 	help
 	  This enables benchmarking feature in the OP-TEE Trusted
 	  Execution Environment (TEE) driver.
+
+config OPTEE_SHM_NUM_PRIV_PAGES
+	int "Private Shared Memory Pages"
+	default 1
+	depends on OPTEE
+	help
+	  This sets the number of private shared memory pages to be
+	  used by OP-TEE TEE driver.
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 4a2c420d4fe4..8d3be6b1bb96 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -33,7 +33,7 @@
 
 #define DRIVER_NAME "optee"
 
-#define OPTEE_SHM_NUM_PRIV_PAGES	1
+#define OPTEE_SHM_NUM_PRIV_PAGES	CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
 
 /**
  * optee_from_msg_param() - convert from OPTEE_MSG parameters to
-- 
2.17.0
