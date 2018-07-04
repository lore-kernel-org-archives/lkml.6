Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC98C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C1C208D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="FGrL6cLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C1C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeGDWQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:16:12 -0400
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:53792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752846AbeGDWQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ix2EQtDESajnpagT5MmdzOd0+YKtebRuMrH0RcUnyI=;
 b=FGrL6cLdEbcSE+jnstEuQ/4/D3HWZOlL130OTRij+eCBBnC8KQf7kHD6o2Uvn8vTA0Y5Vp7o7Q5lMzvYb4tx0DehXLsgsh4rE8II1yBcCpHFhdiC6nsKfOWushAHjeJ4Bn88yA7NneDBEf8I8sMtMDcQz/X72N+fEaON6DvZgyQ=
Received: from localhost (95.15.110.172) by
 DM6PR07MB4380.namprd07.prod.outlook.com (2603:10b6:5:bf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Wed, 4 Jul 2018 22:16:05 +0000
Date:   Thu, 5 Jul 2018 01:15:53 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v2 2/2] bitmap: sync tools with new bitmap allocation API
Message-ID: <20180704221448.GA28525@yury-thinkpad>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623073502.16321-2-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [95.15.110.172]
X-ClientProxiedBy: HE1PR02CA0108.eurprd02.prod.outlook.com
 (2603:10a6:7:29::37) To DM6PR07MB4380.namprd07.prod.outlook.com
 (2603:10b6:5:bf::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27b082a6-ecf4-4a01-75ae-08d5e1fbbd59
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4380;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;3:lg3+ZZn0KJ4P3H41h8IozLYdhRODu7YKh+gzFxc2Vxj93Ig0olXJ95feWXNEc34ecwO14YuQ+G7WRe9kJrqyF49NFt6qBmlxWueMz5RGrt7OicI2gwpiSXWSDCcD1YTjPNfuMJpNXRfopdJyVcFSKpQ0xOm42CNY1MI0t/H09tcd7I1YYlMsjz4wFCXMs6wJEIRtsfFAz2BcCG9H8HYpJMWV6c+BTkqxYSq1mxhko4pHN+vm+bCoOo27ReU7A/RD;25:17Uohb12bPy+MukojsVHfaG5VgLwhdozYvBPg95gSC+vp8SuqmAHaObYmS8NBUpdZSFlTvIqea8GUmrWdiC9G/CJZ3YkLW7PaHZDlsW+GjgM7iz4X6qbyfNGd+gsHMhRdPpqfEJzqKisDfgutwEgu95nqGtTFW++nBS9Elb7CtWAfQwbBUVrlDM33Yw/VTP22WsOQh7wz2aemTq5O1VzRnONHSNhTj0oWSFH6g4XnhFi2Z/KOdqaH3jrvoJetbz4o9gbqLVTsTaYKqhPA6freBYZBpWcRlX1Bp+UeziDrKwBLaZq3J3KLX8p/mxy2PC1ryOk0kxaFKHQZDnnnsZCKQ==;31:Xn07nKe83hl8FDACoZmN3Lu1mAt9BQteIu5uWLz+7cfaTS6jDHpJ7hQ+1fP2bOQB52TdRK6a+B9JnrYrwVbtGpAPisgHE/9aNSEHVbAV7Jv8NY7oHJYInut9qneHCr1eqvfuqt6ogxzf3Br0V6G0pRkhPl5MuhJ6C2rVyz/ZkGrVyqZhKaXIgTcmXmEObOD24rOcYFsPOo+KNvkjFYIg9wrQQGKegW0F7zArqw29RAw=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4380:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;20:j4dHSj1/jIv7w1LOAX4Gc0oDRcPWEa16b3QsFCuBaghuE8gH0bufCpa0gZ0sQzkfLj/5sg/n7UcP9H9kw4Hb2ijlIKgLJ2hEcIzW2gbiGQ/imhKkxrxhhHGnt+w6E6N/Wia+Kor/HyquXd4zG1ppqbsqY/fEs3nLj/Ark0k5tF2F5X0h4EbDEcX9znWLozRp0RpfG0lTI4ksUOJ85dYvFgxG539cusqVL3f5wyyQUo1vhIppnIbXzq4msWv1mEfxJUAjXuHzEmLW3+JfUTJJImdeHqDqkWUH9adJNeij9cBq7aqeaqcIBXiQDEa/ivDt7UszzvC8VKdqVDE/aaACqv/8H0Q3KSXjnDofdvya9uUW+6U/wZfoNQcdkMe/og4z0ZgBKUBk/Ul6T9sUW+XRS//CeGkKj+f//wyVYwK3HQbs40o2ZZFHqhX0H+jQYDvtoppiRnUSkw8sA/0+EKOZhO7xrY4ryKOkKdT+HKSgo9gKbA9QyutQ9LKedlmCiX/eobI6MJfkDmIALxIG+5XV9Ek1bigDD1LFK7lJdsqRojsYEkBbCTr/zIRKlaI0tLzU00gP+VAiHd3hH1Xt6UMBxzHjtFeP2un/mLZ0S+bgNi0=;4:BjZ/omuFYbp5L7suPTED4DLqU6JxFnXrxgCfQdrSMkG5xO/NzlAQqt4o/sYsKjd7COKQ2ggdgpWacPJL6JbmuPdrW93Ys8s2bWbWdoJbFX9N5hM8RSb9COemCNWIEV+cCIpch46Tnkq9m9TMDegpc23/yRBE8oMpCzALhHdT4mpjT3HN5rLvoJ7XEVQiLQwV92kkASgDhw44w3Xic63EWgnA5tPx+sQpaeLor7rEaI80PWkxN0OTKRd+E6pFG2SVcXcXDfUjNQToi357CxFhig==
X-Microsoft-Antispam-PRVS: <DM6PR07MB438052FB7706FC4B50DA5DE1E3410@DM6PR07MB4380.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4380;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4380;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(52116002)(4326008)(81156014)(23726003)(6666003)(39060400002)(229853002)(81166006)(3846002)(1076002)(6306002)(8676002)(8936002)(6116002)(33656002)(25786009)(2906002)(9686003)(7416002)(50466002)(76506005)(68736007)(107886003)(6486002)(106356001)(33896004)(5660300001)(105586002)(110136005)(54906003)(58126008)(47776003)(53936002)(575784001)(316002)(16586007)(956004)(966005)(26005)(11346002)(6246003)(33716001)(486006)(72206003)(476003)(66066001)(386003)(305945005)(478600001)(42882007)(97736004)(16526019)(446003)(76176011)(186003)(7736002)(6496006)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4380;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4380;23:vn0d9HqedW2RH6LFpD55Nj2UJ3ov6uqfyQeg0s0lB?=
 =?us-ascii?Q?3HNdQlP5e6IEreeRr4XEtHXOw8bBH3lBsHQl5uHtH8akJaaIF2etyBs1B7Ba?=
 =?us-ascii?Q?3JSRLAtHWEzOGEnJwZSK9ScB6nwOWh1lX3azahE7K5pHlGjUMJDy3A8HaG6l?=
 =?us-ascii?Q?qXXYrsL2PJev9dbcGN+SeTNgL+ZZVe+TVRQxbdxnH30NzEhZZ7NRLbzAULqJ?=
 =?us-ascii?Q?1/C0aqNW3tIVJwN//Blq8ojvfsDJlS5Y2Aeb7sqfXXSOCqq0RiCPTTalQ0ei?=
 =?us-ascii?Q?Bfxx5IN90o6M+8UZv2KQpsKmh1Zs4l5DyW0MMbCYt/YnonTOX8gISVc7sNl8?=
 =?us-ascii?Q?V+QSef7clcAuR7ihf6gcFfx7/zquSyo6b1If/zK1ewznuFwBXMu2qZTgpuB9?=
 =?us-ascii?Q?k1ARk+s3WcuVQ+3lRu1WuZuzVwDlVH/ENIY5aElmR3YiNoj4WKKxHli7RGrZ?=
 =?us-ascii?Q?a7LmeBKwhBJjcBh/JgN8syCKfQd1bMBgL8y7OQ6vkHhmafDUnzUdcanUc8D1?=
 =?us-ascii?Q?MTnyBJ4jiTfUOuBnCA/qlDytgBzDEs4YywejGdJyHhN18xGdWpVxLvUEFpDP?=
 =?us-ascii?Q?YSeCZVFwGQ49wZ5/mAiUYLIkvhXIvXNlKTcb7zBXlv/1dgIUgpIcklVaDCMJ?=
 =?us-ascii?Q?WepWhxY9yUmKOj2r9Ntw0LrXOTpeC0IiN1ALSPbyajLJqujLI/mNSsCHV7Ht?=
 =?us-ascii?Q?fmORCi74iWunVf42BsFbt+jYFIpIHsahsfh0YdUwAfV5XGx1eVsenh7mLl1d?=
 =?us-ascii?Q?i25xulfuzgRBPiRmstXORD6dYz+unkwC0rIHdQIYkhZGzQD6GTNoqD0orRIg?=
 =?us-ascii?Q?o3bV3d+rJLMzkpbh0KNTN0UenOgcZ6hJY8kGsQCV3N0ENa3DrN70WSAsETnv?=
 =?us-ascii?Q?KNqqK0ZK/hU2Lz0ZVQIKogcn5j8y+uFipnDpci+n6G5tneygX70TyQWASlUZ?=
 =?us-ascii?Q?0PHEf4sWOXHDcrCvxi7MSg/Gyk0SlYK+KSt/1RD9gG63MDBn8EeyJn3iIXSv?=
 =?us-ascii?Q?wdVQ39bvWcp39R8pGb1KTPwzCLmwzhSkddnsyZLPL0Ocutb9OZViHluxtT9J?=
 =?us-ascii?Q?p8G00QIRVyuwkEzl3/04xsX8ki2DiiiVOeWaEcaTHjSrnj7sMPQ+s4TEJ60h?=
 =?us-ascii?Q?QplXP95O8MNhdULOO/WSrfg80IocGxRwpSsdnCnSLW0QKsB1gAK7ORhI2E6u?=
 =?us-ascii?Q?KnzH065Mkvv6UhCOlDaHelnltM0JTb1OpFNQbB7xFA8dZhwTzHmf7BXojawo?=
 =?us-ascii?Q?mGvSceHem1pqAf4T3GvwaOYpXetPs2eB5W8iEE4bXxA7zatnRqpxvDRCJ9Bt?=
 =?us-ascii?Q?msQCYWZcriLUdLnU1/DMUFYJFBz2jccTEa2N2IF4Nt+8mNrSUlc+70L9cr5Q?=
 =?us-ascii?Q?20huftbO35aNl3avP77s3+MjRzfxg+dYPNoKjwjnSNARLJP1ZtK+xTUGmg+g?=
 =?us-ascii?Q?Gy4j3Gaq/K1UtWehICpSf5GfPb++/cktJz5YuZOIuV/VGnH5eeugS/E8i2H4?=
 =?us-ascii?Q?dF72ttm5Dc/5dB6q6Mf/97+Fd+X3XyZGUUvYFovpYlLwD26h8eUUqIb?=
X-Microsoft-Antispam-Message-Info: rZIZpV7OQSJExRhcNKY5hBUbnyhfEBBMpEaONYD9FreBdiC3cZBc7wTT9z/KLg855R15nfMdxrEzZMuopCzy0tJjspLibd1EmnEcHg+fESJN3GrZnfijOUswd64WEwluhyOyxPwBp0uSbVVNfkNuIYglVfXdT8GIIx7XxXy85sK4QieRpq1nG0c/6Av1R1cglsCr7R8WI0D6PKeoaSJQr6w7AF0AtsiRYe1hIw7iaYH4YFMOnWWkbtmxneX7/BoZN9TWL45qFx7m+Y7VPGmNIN9HpwtPa1b5jjDtedBfdYMXoldQuHFBq+TgIvTPbCex7ktrKk0D2c9VZXcoiiOX2ApjP/jiz0cQxzVchD2vqcY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;6:bxFzzGmeOf4w4YpxUcjXnygCRaEGwm3zPY9c0FDwNCMXuq36m7IdfGtgILjPlt7FgBwfTx7/feDVcGVo/ljSycYjqz4p4C21rKaY5UQ3uYDbhmvWq0SDSbr1UANdjzKynx2BtXv6M68WpbBYG4cu3deH4Iqc5D1vieWxzSjCC6oPi458SXB87BzlFJ/IyYNamqRTpt2H1X/ITJJWv4QtnwIISq7aEwjekLq+vFp0uBoLeOsNrD9ildwl+SWNW2//cIFC8NPEBmQGvgYlIR2RWf1kmdXtfL+Ygln+3Cirp4PfqY7V9MUeWZEYEW5hd//UXFTwzm03xI1gmR3ZaZfFn+oZfbVLjr+5TtyN2Jmo6DY3ILdrqMkykLlGbloqOuusRfPKdHtU3C9QWBZf2OMuKcA893Nu4CJd9dk1jgcTQTGsHUqEXgpfbXsg5MV/FkhVxmvfsOqsERCgPy5KX4WDwQ==;5:lrSUrsaGpt+++FIemfmpv0uBLsYC8es7uvohNXOSZ7e5y3AV37D71PVIIboAn6uMAUAJBcxbmZKelEs/6qQ/VuSg1LGyB5y8gczX91PWboaEVH5JkhutPIhassWuwHkFN4U2cDU6+wTP+FOrRSwUX+YnivwwQSlxDMbTfIghA4I=;24:4uI1xZscHU9SvkIfR5s8GsAdnX8rAnKRvW55jwDqqGOrsDP6Jbymtx9CFhMnF6O9BClxXpCIr2+1elz0BCqy4LZ0FnouvC4pFwTCDu8lq/o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;7:kct9xTX4eqfXp+SYk+DbiJ81JaYI9kt2wrqF03543Vs5inBE0OtJ8NUO+ELjL1zQ2Ioc4F/e81WZcVmA73vk5e1cTLkJH+HXNDJH/S5sVl0Xrz3AOkzkO+W0hfDFI7TtLMv3woxGrTg8XEQdWXmJjmGXlC/NfKWrUAUGq/rDLBMtIxeq2cpDgB6QtsIBP+ZpswXIShv9ZrqMqqBPBCTORokCrrk/O0gg9duR8I0ej26gdOWxrLMxwz7ySwpqcoze
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 22:16:05.1027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b082a6-ecf4-4a01-75ae-08d5e1fbbd59
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4380
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of next-20180622 and Andy Shevchenko series:
https://lkml.org/lkml/2018/6/18/841

The series https://lkml.org/lkml/2018/6/18/841 introduces helpers for
bitmap allocation. tools/ has its own bitmap_alloc() which differs from
bitmap_alloc() proposed in new kernel API, and is equivalent to
bitmap_zalloc().

In this patch tools is switched to equivalent API. Some bitmap_zalloc()s
are not paired with corresponding bitmap_free()s, so marked with FIXME tag.

Since v1:
 - removed flags parameter;
 - removed RFC tag: this is real bug where free() is not called;
 - FIXME notes added where needed.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 tools/include/linux/bitmap.h | 17 +++++++++++++----
 tools/perf/builtin-c2c.c     | 11 ++++++-----
 tools/perf/tests/bitmap.c    |  4 ++--
 tools/perf/tests/mem2node.c  |  4 ++--
 tools/perf/util/header.c     |  8 +++++---
 5 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 48c208437bbd..64a87921bac8 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -98,12 +98,21 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
 }
 
 /**
- * bitmap_alloc - Allocate bitmap
- * @nbits: Number of bits
+ * Allocation and deallocation of bitmap.
  */
-static inline unsigned long *bitmap_alloc(int nbits)
+static inline unsigned long *bitmap_alloc(unsigned int nbits)
 {
-	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+	return malloc(BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+}
+
+static inline unsigned long *bitmap_zalloc(unsigned int nbits)
+{
+	return calloc(BITS_TO_LONGS(nbits), sizeof(unsigned long));
+}
+
+static inline void bitmap_free(const unsigned long *bitmap)
+{
+	free((unsigned long *)bitmap);
 }
 
 /*
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6a8738f7ead3..584abe437154 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -127,11 +127,11 @@ static void *c2c_he_zalloc(size_t size)
 	if (!c2c_he)
 		return NULL;
 
-	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
+	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
 	if (!c2c_he->cpuset)
 		return NULL;
 
-	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
+	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
 	if (!c2c_he->nodeset)
 		return NULL;
 
@@ -156,8 +156,8 @@ static void c2c_he_free(void *he)
 		free(c2c_he->hists);
 	}
 
-	free(c2c_he->cpuset);
-	free(c2c_he->nodeset);
+	bitmap_free(c2c_he->cpuset);
+	bitmap_free(c2c_he->nodeset);
 	free(c2c_he->nodestr);
 	free(c2c_he->node_stats);
 	free(c2c_he);
@@ -2051,7 +2051,8 @@ static int setup_nodes(struct perf_session *session)
 		struct cpu_map *map = n[node].map;
 		unsigned long *set;
 
-		set = bitmap_alloc(c2c.cpus_cnt);
+		/* FIXME: No counterpart free() */
+		set = bitmap_zalloc(c2c.cpus_cnt);
 		if (!set)
 			return -ENOMEM;
 
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 96e7fc1ad3f9..0f7491a4e0f2 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -13,7 +13,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	unsigned long *bm = NULL;
 	int i;
 
-	bm = bitmap_alloc(nbits);
+	bm = bitmap_zalloc(nbits);
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++)
@@ -35,7 +35,7 @@ static int test_bitmap(const char *str)
 	pr_debug("bitmap: %s\n", buf);
 
 	ret = !strcmp(buf, str);
-	free(bm);
+	bitmap_free(bm);
 	return ret;
 }
 
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index d8e3d49d3638..27fd83bab453 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -21,7 +21,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	unsigned long *bm = NULL;
 	int i;
 
-	bm = bitmap_alloc(nbits);
+	bm = bitmap_zalloc(nbits);
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++)
@@ -65,7 +65,7 @@ int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
 	T("failed: mem2node__node", -1 == mem2node__node(&map, 0x1050));
 
 	for (i = 0; i < ARRAY_SIZE(nodes); i++)
-		free(nodes[i].set);
+		bitmap_free(nodes[i].set);
 
 	mem2node__exit(&map);
 	return 0;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3a6bec22baa3..8736c70ffb51 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -275,7 +275,8 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
-	set = bitmap_alloc(size);
+	/* FIXME: No counterpart free() */
+	set = bitmap_zalloc(size);
 	if (!set)
 		return -ENOMEM;
 
@@ -284,7 +285,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
 		ret = do_read_u64(ff, p + i);
 		if (ret < 0) {
-			free(set);
+			bitmap_free(set);
 			return ret;
 		}
 	}
@@ -1277,7 +1278,8 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	size++;
 
-	n->set = bitmap_alloc(size);
+	/* FIXME: No counterpart free() */
+	n->set = bitmap_zalloc(size);
 	if (!n->set) {
 		closedir(dir);
 		return -ENOMEM;
-- 
2.17.1

