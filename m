Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6B9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1681520693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="NkcrN0u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1681520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754771AbeFTJno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:43:44 -0400
Received: from mail-db5eur01on0111.outbound.protection.outlook.com ([104.47.2.111]:56192
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754014AbeFTJnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orCRzr7lOgSkz+wX2vQLMTe8SM4qVPc9723F6NojNMA=;
 b=NkcrN0u2YqpIARUyV+IuWTTqgyv17cRgl1vc0By1CWfMKIP3XGLHaocA+xPjfHt5PWQU9GEqiqiZY6Fgd5GHaSJoa+lGUpTyD/yoteJPFKINA9Fs0Go4MELUOqL556tjSEsp9nBTRYnWcAibno2LXuL2qb4EAtcjL/3QXW2WGzw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 09:43:33 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers
Date:   Wed, 20 Jun 2018 11:43:23 +0200
Message-Id: <20180620094323.8447-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0901CA0062.eurprd09.prod.outlook.com
 (2603:10a6:3:45::30) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cf4658-1003-4618-c759-08d5d6924a36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:wlhIqU1HZoxEyZ53lt9kPdi2JGiPhuwas0D3Ptmy87ke11qRhrZy/JtjzyFG7jL9bBD7FJyaNBJaNqIbpoycdGWz/wtHO7Ka/2npynTxap8QCUg/Qzz8Ui7+38oGJ8z3PiXTTjmX0O9MTDZIco8YFthVGayUr0S/hBqYBcHH5UhtWp6YZsBCc+gAJHf8WLVYu9Bx7i5v1jfXOn42ytrlM001+D8Or0VDi+BFvhXOlo7bT3fQ/ghahDilW6fp6Mde;25:a6tfUu8+prtfcFPEF9spdiYGbEi+MnsxnJpy8FuhYnYaiWwL3q4ntJsEsAF+q4vg32xgRyJoOIRisO6GjzO3qFsf4I2ppPxGudtqhbFydPmShG7Nh7EnCqSsvP7nczvY6gRnXMDmKN06r5n3mEC+79QTuAaRHvbSVf4jOLKWYiIqLulgEKQCvigWsSBkzKlpVjlZoDMWS4+r2IQqMQzvmIVa/QBZgDD3OgVcJM/nyVt+zk5sSQ0XI2np93W09iqLFjCdBFxJ8eF4CrOI/YIb2GbAxMfa60XuxnsPOeOihrW8K109DVe5aB/34FOj4XQ6nPqUfBUciD16qu3uIlM7Ag==;31:ElYWRtUsrJTkziLdpRB5aBe8zaEg7rb/NXDceGb5OVlMYk0vJntzS5QbxO/3ISi92ehJVg5mjJmNVxcIlQex7PEf+luNzTARcl+LVsu6UFjWKH9745bV78byN3zQUDc5GqdUdSWaVhNzhqHbC/kFAQu/th1E4ggY6O593seVbo9/QT2FDjNM+OTMmsgSUlM90DYLgWhmQu1wR7ew3fpXm8AU6kA16LBIYRPdyOvfbvU=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464F9D9988DA3C839886B37BC770@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:Uvag6bTJIzWvLZNTq62MNw5vPFoMUh9Il7ICH+RKg8boylOP0hv9FPiMl1avb7mcvMcBukerPuqjBk+Y3HVuyyNnaZ4fNOKmPSzhnbYydxSD1EJ2C8HyXGJdc4Ib3DqI5TiAr3qTL1XYXA1e2MP6S565ItzV5gWy+WAGf2cAn08gvIy1oZdzw30T5tDmXQFoqVfsEwc+4ri3JPzlL3XPQ70XMtg2AMvtlm6EICzKz0A1WJD75Zfe9wek6ob5YsWWhtqAGhjgzwPrbGyY2cbdxQ==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39830400003)(366004)(346002)(376002)(189003)(199004)(2351001)(50466002)(48376002)(74482002)(478600001)(305945005)(6486002)(7736002)(3846002)(97736004)(6116002)(1076002)(6512007)(8936002)(81166006)(86362001)(8676002)(1857600001)(2906002)(81156014)(4326008)(53936002)(2361001)(26005)(25786009)(68736007)(50226002)(6916009)(54906003)(316002)(16586007)(5660300001)(36756003)(6666003)(52116002)(105586002)(51416003)(106356001)(47776003)(386003)(6506007)(66066001)(476003)(486006)(2616005)(186003)(956004)(16526019)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:W1+Vkcc0v6pIDrNJrV+X4bK3AxG+2TTJ2F9im9q?=
 =?us-ascii?Q?IvGFeJM3HT8fiahu5YmwwhGJFxsxmt3WDztLVdBtnI6O6KsmS+t8eLCyKlvQ?=
 =?us-ascii?Q?H4DznaJkFiEfvo4eicbdvl2wWv2547gIuZ66IHJidTHwlhrGfJQ/uDWKEOww?=
 =?us-ascii?Q?UyODOz9oij8VRIMs8vC7fGIEme29VNpenr3qORAG4hU41i0HHmqnmmgIkHvq?=
 =?us-ascii?Q?sXp4E4oqxa2uXHjr1OSRDxxC5Mgy+54dbZ7b17/3f0VuN9sIZYdkogCp8QHR?=
 =?us-ascii?Q?e0VR7dpEPM4Mw2A7NEv+amUq9PaspladnU6pW0fFQVWwZ1cvZ21ejZZV13Ae?=
 =?us-ascii?Q?3+uya72UdrXh+4QxX6nw+uMIW1rRpS0WFYuXMdF7QpXEITQnfQYB6Fiiz4xi?=
 =?us-ascii?Q?Ta/60nrR8/5gOVSOhNmu4DuMB/YX7yzukiI9gsuE+F5zW+Vfb8bzr1lIMNpd?=
 =?us-ascii?Q?EvgqB504QVq671posmS3i1/bwizRX5/lCP7wwdD84u0g/cd4HOhQFdLSh4Cn?=
 =?us-ascii?Q?FXXPr3Tnn7UCzTKzHMfPnT4fWx+Ap6YkfShLa3QPMrq8p9q+s/D4epAhi+bI?=
 =?us-ascii?Q?OTeq68Q3FubuL+RqaPtCX7l7QytDlLLbpKkFgIp5MMuUbaxieTPKY6pgWWVq?=
 =?us-ascii?Q?BTF4YsqPu2Cjh4mYSB7gg9HrEB2yoyMzPLbyS0wZ3AuLjFTGbueiMViY3gr/?=
 =?us-ascii?Q?6z1tB0mcKETLzgfOYIZ3y7Qmq+EVSZqacYFeYxkwMi7fIi454RLE+9MYBwm0?=
 =?us-ascii?Q?kRcMGWYGG850neahUP3ZevnX7upheoiPka+yGEW6mcpEQfoUahruGxfHMdJv?=
 =?us-ascii?Q?EqeJjnQSCr8+zdJWWZbh+HUlK0mNpD/Fstl4bpm0kygf+o7av4FhdrJaYxPj?=
 =?us-ascii?Q?HNRdB3tTId2zDNrstYfmxd3iuUa0e/l3rnF7/U1zBlxZRmJmA0GDB2ijH7SA?=
 =?us-ascii?Q?K8Nn+jN2QoeIW3XsrbwfQ5+86OJTh/c+EkP2iz72GBIZnhvyecquvuba8gu8?=
 =?us-ascii?Q?DMJX4glPs3MlNjSTJgVl+o7AY1xUMRseOj6kfU6UYLIAh4JQaGnKhVg/Z67e?=
 =?us-ascii?Q?lWVvoxSZe+lIYV5X3n5dNJAr3+nwTFbl8DAafBswfrXTVaqFYpyDrLER0jDt?=
 =?us-ascii?Q?Gub9HY0PTy4+WD9g2MCsy6qEuhOiTbEo5TzU42Ym0ozg5nAIOJKCg1Id0vLw?=
 =?us-ascii?Q?qmF5RpsBoLGdN93rw9x9yMiNQKaHvMprCuuRDombOt+p6QzBHfPd2LqtjXBn?=
 =?us-ascii?Q?pxxz5CQePI/AZ9vEr3HlapSd85Lw2kax6iNHKr/DD?=
X-Microsoft-Antispam-Message-Info: eAczAAxaTSz88sV1/qlPf/3Ht9uzWikBWkGRAlP6yWb6y81LwPcCQdGcEYXzItUr9YS9VRmVLUXDlhMKwrfYFXRI53MznJfi3ZEWr+60dgmCJgBE86pctKfOAPvL4U3j7D0IZ9/q8RshR+bZF0uDULe4/HciEbSy3sqDzfWxrhy4kDAFgJUf51u/UAkvPMLMhOPfcC6ke2NgqTs2VgxzVsPqmHakAbVQKyedKiNQHP7qQd+1xCwZnEokeXbqH7oOVjwkQd98K9nRwGJf6aRK1fzvFZ195Yo+T9hDNvJCbSDxfFMqOtye7lWc5RnZ9sfuk35eHTjRK+oLNd25qZZu6w==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:Ie3g1VuHdYXUuFynMn7eUpssTfnsvzShk5E3VhG5iWRiCclIZr0xTG+XbsFly/x8Pcz66s4x/+djOSouexgFoLApEFxm6RnfgHinrntIyZWxUMhT3y90El591u0jmrwG8bp7BEfzaeScJVBeKA+r0xKjf6dDYmVd1KFYU7Fna693FZOtC+RqrLxsmaxZB+vH2XsUqJI4Nk5zJkcJnzM7A6suoJUDIuiQ23gmhL3MytQewAWHmIsLVE+1J/EG2uebPHmaDs/b+QW3+Uaipns6p2xnWmLsq8CdJ4Fi/g6cScocDU3cIyxgN9RKuQh7ABnur8+f1G7592ZvBZ5+HoPhF7q7/XmbUKKIAhQHy5fsc5vveuC+1kSwiMIfrrsBfZKJ+q/of4eMzmAaVs5tjK+EVPJyhuxf+CWBOf/dpmwyhpv+hU98dm+TcrHGmPV5NXR/YCQKKM33fNON1esLmYWVjw==;5:jStFpgSq/kCtwo0NWNCacGNiLLiBZCD/m7/yDeytXj0K0L3rFLNFfcml/q5I//nf8rRjeuYD6Y7MD1aUUCThc1j6XCh0cSZ365621N/4geG/3LQrqHYq2AwFZlAW41Fj9I3COleAzupT/0z0ZzifpReuqRwAcf4cTxklpX6srRc=;24:McCk10uKy6lMGaoeyRCYWOLBjwKP4BQu7dMsww3ZY9LcM/iPet9HgfJrVhfiVgFppsL5dBPoTiPh4kAJWx3QqzzK6ziawQrUYwH8/z0DWrg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:RcTuf1bgG50ha6PlumwR5KPHN8JeTIZrXzm0CeYTIlO3JgyekUqHnaarHcgDTEiuY79sld+Ic3+Yn7XBX29g1SiOwfK3y9VcPVnQN8IQtVhhvvP8x3xD2mUuCrAn+A4PaUbmyyeiIGPe9DA6L+J/HcU+gUz/9AYdTvAdKCbnmojxVCqyXqEw9zvC4XSBz2zBOgZri4yAUz80vofJFFtUU2YeH+Z4W4c+WYbDkJxAjfgnwxjTscgsIYwg8vbF/HeW
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 09:43:33.6779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cf4658-1003-4618-c759-08d5d6924a36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DMA safe memory was allocated, but the subsequent I2C transfer
fails the memory is leaked. Plug this leak.

Fixes: 8a77821e74d6 ("i2c: smbus: use DMA safe buffers for emulated SMBus transactions")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-smbus.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index f3f683041e7f..51970bae3c4a 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -465,15 +465,18 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 
 	status = i2c_transfer(adapter, msg, num);
 	if (status < 0)
-		return status;
-	if (status != num)
-		return -EIO;
+		goto cleanup;
+	if (status != num) {
+		status = -EIO;
+		goto cleanup;
+	}
+	status = 0;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
 		status = i2c_smbus_check_pec(partial_pec, &msg[num-1]);
 		if (status < 0)
-			return status;
+			goto cleanup;
 	}
 
 	if (read_write == I2C_SMBUS_READ)
@@ -499,12 +502,13 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 			break;
 		}
 
+cleanup:
 	if (msg[0].flags & I2C_M_DMA_SAFE)
 		kfree(msg[0].buf);
 	if (msg[1].flags & I2C_M_DMA_SAFE)
 		kfree(msg[1].buf);
 
-	return 0;
+	return status;
 }
 
 /**
-- 
2.11.0

