Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B15DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F43120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SGRSPXZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F43120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGSLd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:33:59 -0400
Received: from mail-eopbgr30134.outbound.protection.outlook.com ([40.107.3.134]:47680
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbeGSLd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAYx74G/QhJJuhyx7nO1mnM8DtBmbNLlKP1iuceOsCU=;
 b=SGRSPXZpaGjKO7UsgSXVyK1+LMj+62bAiEdC4jWa0NRL3b/WLPGd4PbFqx3FzJtlaIpDzDcIv0wBZh6nf11Se1R+h+o0VM4Zc0xnyfgh+AewsbPgzz3DSvF1O9JuqcrhDehjf1M6GK0tljMXnRIqbDJKrXD3V/PzvG9qt6dc4P8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB2024.eurprd08.prod.outlook.com (2603:10a6:4:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 10:51:21 +0000
Subject: [PATCH 1/2] mm: Keep int fields in struct shrink_control together
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, vdavydov.dev@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 19 Jul 2018 13:51:19 +0300
Message-ID: <153199747930.21131.861043607301997810.stgit@localhost.localdomain>
In-Reply-To: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
References: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR07CA0006.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::16) To DB6PR0801MB2024.eurprd08.prod.outlook.com
 (2603:10a6:4:76::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903ea6f9-1ce0-463a-645b-08d5ed6590c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2024;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;3:asGjgjZ1OkMfg6thlHLIL/AHMQHcMkOVpBlMCPJVFRbePMT3BfZuEXb0jqNoOa558J3++m7CQUanQER/bedgRhDWHJ4p5+Ih03fDdaF17HlnffcbpOwK/jjRSScdZFcvkzwN2V7Cnq/Ufau3nYVA2eyaJeciWx6yaullTsqEaw8PsOlwm+JSkV1PvP8MpvpRkaHdQexTT6i12nBcui44u0Wyx2ZnkrSne4yWaCshFDYeBPyURvvD0HegfrvHZw+G;25:O9TuEz+LymopZCf2tVokGEFRrRcRUXFX0ltk5OGfhV+ZyxE44fNOM/plC6y//ZJzTsmq4P3281TrHhBs+mS0YSr+K3hWZyEV0n1qfy6Hgz0tnIeaqn8Wckx+RPsHCqragfvgT3TCawnX6tlEyXaF6JEn7TgL+QXnYCIvz9pbRvmIR17LfsaVyGFuMIqNEqD01RbDICcdUz+jgXAELXxffKwswxtfmtWPwFc/Q34JJcZ59LAzqoUzk2GlPe7PNFrlIE0VmC3ylFWEcUJzA9tzz7WDooHpg0revwT5G//ie9sVltvOTSeGk5uwD5oYol3XY56WSCCtD/ff3XWouEXMOw==;31:VqE9SFo0aSHt9WLyQbEFi0tbF3HvsadGEXuLzESNURKP1uD0VRYoa+HH6MCmIgRgm2YBYH45xUmaW9syiTXqD/uzBhTiFpOOmcckTTFH18l2y1u7qv0spU+PdSJkkt8W8qdCqTJqG28/GoKT4P9hGDh7gSja0Kd9qWYHQG0oONspRAndf0NG88o/Hrf+YPyQha5scsDt4pyVp6HNUnEz5UzqoIOFJlyTNfBcWFibRNA=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2024:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:Q26YRtoJ3YDD7tgWdJMwaJyKmbj8JjXSrrnTqAwNSnxfRYkxtZE0GHl6D7bOPfhxhoe3x8LUEiWfWNwZbu1L7NDcVq6TYqP2TMfEjPlcsV+T4oRHgNhgl+iWLWgJ0CT8or2+rOMR4yBYpP65Mfhz+UCATgzBcC5Y7SsyAdY6Bps+JZ2rE1CbPlOexWkF/kwHkbZlTMY9LhCRdzdckeMRh6uKqeNAHm/w+KGgIBur3qZsoUXmUgd6W3tH88r5+HkZeOhycz3Juw2AEqCHn4/NHschpFvh1w3xBKlczcM8Dm+l4WAqXihVjKxKp0sAKmGqjDLYwNluKQrqUyMFMqXs4Bc7KMegH3cb9gzDRbKQKi9KfY7Tntry5/wDE9sgpGnL1X2ubMGM5dmNLusOQi/uapuzPN0mnF2C3/YbhYcozAc5ryIFNNZVf3c4uQsY2/7QxzYUw2fv1CErTD+/91bBXG54/v63TmkP5d4g7cC8ngjNhzYWoDZlkYi0yvemvtye;4:rG+XDZYNPEBIbuB7nLIbSVgS/8maqDvSohAk2n9aYkm84RQApSCTcLDmrJSLOIgU32b3xvG/QfDv9zb4qlYrpUajrZk4ssqqjSRWcscGiFIuq2i+txPTaMNumPn/zCB5FqPYUqjHmk7ZBG8tVHdHALydDiiFnFBKCQmHfFYjvJtx/XHLdAI27iuqoWazI9kFYgRnAWmvAn+kxL+xa7qpnks87WN/J9/N9fW1lxCKCIw2wLxdA5669wxeFHxSM+B2pkq49gFRTNNto3GwGXB+QQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB20248C394BCD9330216947A5CD520@DB6PR0801MB2024.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2024;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2024;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(366004)(136003)(39850400004)(346002)(189003)(199004)(33896004)(55016002)(186003)(9686003)(86362001)(103116003)(68736007)(486006)(2486003)(305945005)(7736002)(105586002)(26005)(106356001)(16526019)(23676004)(6506007)(956004)(7696005)(52116002)(386003)(446003)(76176011)(8676002)(81156014)(97736004)(11346002)(81166006)(53936002)(8936002)(476003)(66066001)(230700001)(5660300001)(25786009)(50466002)(58126008)(3846002)(39060400002)(2906002)(6116002)(478600001)(61506002)(316002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2024;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjQ7MjM6cHg3bmwvdStNZ1VFbUN5SUlweWJuN3A3?=
 =?utf-8?B?dGU2a0VHUkdrTlMvNzdDaEQxcXUyRE9KaXI2Y2tUSW5JRDE1blRVbmRoSHU1?=
 =?utf-8?B?b1NDOHNQWi9JZTRiKzh2clk1SndWc2t6Z0IyaS80QzFJYmFMdS9NWTd6U3Vj?=
 =?utf-8?B?bUxVQm9iNEUrOWZWeHhrNm9hck5XM0hNaDNTSjJlWFE3ZTZOT0pqTzI1U21M?=
 =?utf-8?B?WDBpZW1qV1NheDFoTTUzeWJWclNCVWFRZ3IrQzl1bGE5VEZTVGR2SDROMEZo?=
 =?utf-8?B?QlZZZVloZTRBS2Y3Umc5a2dkOE5PMGVZU3ZrTVY0UnNuTWE5Tko1WmVGNm1K?=
 =?utf-8?B?bkhYdVlMdXZRWDE1NUpXbFNJNUNtKzdsY2ZHSDdGdy8zY3hON2JrckhEUytM?=
 =?utf-8?B?VEE5c0VwYmhsaitUUHdLNGd0R2c4U3FzWjBUUVp3QWN1a2ltMDRVak1za2Vt?=
 =?utf-8?B?RW44RzRxbzVocG50d0VyQnJpRHF5bVR1K2hIdlZ4eExFVjRMVmRHTWhJRWlJ?=
 =?utf-8?B?ZGliRnpNSGtVVTY3NWF4a1I5eXoxMTlMaS9FMGNEaVk0UFBjeHhIazB4Q1VI?=
 =?utf-8?B?SkJleFhZcnAzeVY5Q0NYZC93WjVrV054bXl0VkVOTFYxaWlMRVpKZlZmMnk2?=
 =?utf-8?B?b1BYb2VHUmJ0a0h4OWlTeGxlczliLzd0NVdYclZibFI5eno5QmxtbmNEZlV1?=
 =?utf-8?B?TW11UERhWjc3NnBSb1kwVHc5QXFnVVROaWhGdVJnVDNSS1U4OWc3R3FkZE1w?=
 =?utf-8?B?RkgrWlM3N0dlWENZN3dBTUgxUVlRMENpcFJ2N0hFaUxJcS9MK0VnQWh0SWhC?=
 =?utf-8?B?UnFhMUdhWDhZTnpaWEJwWjduQzVFWEt4WEhXQThSeHpLc0tXQjBjbTgybDAx?=
 =?utf-8?B?cVROU3Z3T1Y5eC93T2ZXTUxLWUlneGR4QTBVZHlZcys1M3RMeC8yVW5BQ3Fs?=
 =?utf-8?B?SG5LRHBMOFRyUlBPUlNsZm5vdnZ6UmMxcEEyWVFpTEYwRGRGM1U3RzVxMWNx?=
 =?utf-8?B?emxtd3FublQ3QzBRQ3F3ZG96Qlo5YkZaRVA1Y25aRG4xNzdjaVFaWGhWYnhR?=
 =?utf-8?B?ZHNybDN2SUpmY1o0T2U2SXBiMS94RVpQZGpWL0dEM09RR3NSUW4zQUlsVUp1?=
 =?utf-8?B?NGZKT0hLUk9mdWJLOU11a2tPWVJGZFJvcnFqY0JYdDlRb1NYdEhrSTAyUlNH?=
 =?utf-8?B?bFFkWHQ5V2VnMDloaXhaU3JLd1dWUm83V1liSHVvYkVDMXN1dkZkQk9ocEk1?=
 =?utf-8?B?UHl3RlpsNUxHQTV6WmFobDRQNnpZeW03Y3Z3M3dwdldMQk1PZjN6U2FoTVNX?=
 =?utf-8?B?L0YwdDNFSkEyZ3JWOFlmUXI3Yitmcm9Yc0FSRDM1czZ4K1lobGpmYUdNT1Yw?=
 =?utf-8?B?V3ZZdTltM1lLOElMZDArRUUzYTlHQTI0Yy9uejhkSzZpRjhQNnAxbHk1TkRo?=
 =?utf-8?B?bi9CdHJNaTNHdkM2cWRONTNQUHBhcjc5ZnVMTnZWanc4OHhEQ0Q1dkhEdkVG?=
 =?utf-8?B?VE1yL3E0OFUyVnp1bVdnclNpYlBsNlF5RCtqendYaGg5Tmx3ZE5DMzBIZW12?=
 =?utf-8?B?S0F5eGxjR2FmN0t0R1pzK0VLUHBzdERzVFlXcGdDKzFYZjNDOGxJRDNJaFhZ?=
 =?utf-8?Q?xG7EeiaZzxHPPRJvORpFw3?=
X-Microsoft-Antispam-Message-Info: W4aXsptsO9b63mwzYx2e7bZbl5dOF1Eso4/hyM8wDMFO2aylzBxtWSe6QxPpbzH0JR/6p75eTJSqRj2s5dARCWIfyPeCvnD0EIGxaYbWPRcu4tpfiFUoLV1Gpjk25yfEesgZioFRabQPJ0DlpQPxSyTZlXevsmH+1Xrt9mFPXzFMkEJEUxTjZYu02QNN5jijR8kWhNi2eeOjbshYgviq1U+eXBCnBza1bs5Aa1cOR3QKnP43m+jlRCGp1BXr9ii9rVnqPBXHsrTslqH75TTxqnPgkyZAb4omNJBiUoVUo9OJ7ajI9O3Sd0f07hdbzBGAxH4JW84wmZm0MBXB1KoYetmhkYHY10Oe8gkQRxYCzPo=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;6:qrZ+WXvR2Z/A0UQh1eUxEBifj6Tvg24XmUOIW76Yd0aJH947i8+eQ1VFYJQEpyeGIVf297U3BN53CSvpU1NC1haqwXfmrYGO2c7dUrQ5ieuyV+Yp/pjSmVWTwfI1EXPac9a3ZcnktjMA5Gvb/Loh9kP4D1M9U6GFRy/VEBG/googm0xTXVtfbYH/+GUkJPa2eAaCj0avbJLr0eypbDpRB9hDWsDmZx+XKtvRD6pzFJqVc19zLh2+9s/CEgDwctQmiMN6Yj6IikE15aSGDPv++iuvwG040EPZBbtWefyPg4fXs04Z9MciMgHur4GU+g4erDYezWkotJYZmbqHvqD2IQIYcORLYGKCYEnOZ9ej18PxOcoyoXHsF2TU88ncKakT2xzesTCXTZZ5XQO+PlyOHngqNGNlbZv54GDDmGc/grxFCkMp1zHKBUFCi0F76hosX1kKw08NpHf+nVhA9qq6WQ==;5:KKClUHn4Gqjzkg4SbmVR3lgMjL97kDUB6DyIBhUH9P+YCuaFK0iyuSMMIi+XObh5kte7QB2386XI/LDjDSeIJkq7YspLjhTeE+s0HdIKVId/ILzHHaW3gWJSHs6383c2qUjTxMzieXtHzDn0ki6ni8/yJKVBNo2fSzul2zXW/hw=;7:dsr4S064a+UPvWpaaX1Xr/CVx7p2XbkLxlT0715nDbJg0BKtnuTHnWG6sucYyao4de5xI9xMk1H4L1G+uqvaLFL0A1lhBDhqZih6Rvcz2HT2H2O3WrZKB0zxpa617LPDqdxOsXCtPDZcyOOHJvdRgZN3aytyDK5GJo3QUA6BmuG8KySTAjl/p7ZF3yHhTRJKBJ3ZyCvSdOf1ra1c2t5NoPZSoLIrOJt9wu0uqNY/mtglMAXgBpWBNC9WROYQtQTE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:gJiiXeC6ijFrG4CwiYZiQj7jXk6KqBXyRCNHARoz40nTn1qh7QqDvshtCXdj6BN8PRqrWo7RyidOADSw3bsc+h+gr7kwXcBeCv8a4eCXsvdwxw96PXZGp4PnljqYfs5pERl4OzC4urboZTH5xKmjXIyFUXONTncdoJLv+SWBU2I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:51:21.2081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903ea6f9-1ce0-463a-645b-08d5ed6590c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gfp_t is of unsigned type, so let's move nid to keep
them together.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index b154fd2b084c..d58aaaed34a4 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -12,6 +12,9 @@
 struct shrink_control {
 	gfp_t gfp_mask;
 
+	/* current node being shrunk (for NUMA aware shrinkers) */
+	int nid;
+
 	/*
 	 * How many objects scan_objects should scan and try to reclaim.
 	 * This is reset before every call, so it is safe for callees
@@ -26,9 +29,6 @@ struct shrink_control {
 	 */
 	unsigned long nr_scanned;
 
-	/* current node being shrunk (for NUMA aware shrinkers) */
-	int nid;
-
 	/* current memcg being shrunk (for memcg aware shrinkers) */
 	struct mem_cgroup *memcg;
 };

