Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D78FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035F72146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bB8APbxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035F72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeINSTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:19:34 -0400
Received: from mail-eopbgr50114.outbound.protection.outlook.com ([40.107.5.114]:60592
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbeINSTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esdq8XAOwg27qWK39vEEqTDErGne7rDq6+xWhuz0ZKw=;
 b=bB8APbxkX/lm7rvajOJNdUeQiY+0TRDxU/s0iTT+PqwUON25jGq+EbMIKjU6SYJ+z/p6miLgyANVDFSQKfpTP48FCx9TuTYldEbl1vT9uARBHQoLAL1TnerpozMvI5ERF5KU8rX508iqm56UMxN1fC6ADLJrSqW5+S6DHszbhDI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3261.eurprd08.prod.outlook.com (2603:10a6:803:3d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 14 Sep 2018 13:05:02 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 2/3] mm/vmalloc: Improve vfree() kerneldoc
Date:   Fri, 14 Sep 2018 16:05:11 +0300
Message-Id: <20180914130512.10394-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180914130512.10394-1-aryabinin@virtuozzo.com>
References: <20180914130512.10394-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::23) To VI1PR08MB3261.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57b6de67-348e-4a16-6586-08d61a42af58
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3261;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;3:UVSM/G5j3vJfrQZz8Yl6y/GQ2zuQ/wMzdY200wmDRaRO2zmg7xyfW5cEjZ2utyKIEHOZipD+ddbf9LvoMiJ5UbniqT85QHkNP0j8N8NsMmE1fmj8ZTopV0vctRgt817mHSG5W8Nuay1bgrGXZTg6Aub1FKFh2OXKushyNG7zqeyNiyFMpJDr98A0JNrkVTgpCCyvZQE2R/xpyO1+R/MLiv95e/ceMJ/HeBXmM8nOhmG2T652wSCUd6leK0nH6iwZ;25:rFsnlOHYUyXp1M1W9N5iCvKYXgJED1ZasqsLn72l9Gn2vIxeajAAMTuOISFsrABL1tS40noz0p80p0qf60dsja7cwa5ihxTJbcmSu2PF/WTXvxFQ5/baSUxEvFUQwXMdvHhjZYH+0RUze53NYI306czcVMTOmnaQdJrkxtUdnBnI7p7ZtC/5lmMeuUUHAkOIxk7WyvTqsFyIpj4UTm75pTyrzLoelNJSRc8IVjgDryxsgKY7jsjUHS+x327FQaGKVWgHTIxj1KbL8RDmvht+o5G3xOMgPkpaynYHG5RnezICkioozb1BGQOvKtJ+ZvGNZEeErgwRBdx5vVgRrpg0EQ==;31:wzD5CB5ssd4KgZxyL/MnFmV8cufdtDtzDHFfi+MJgnlvu5hsNwdvaE1lrOLb06x1cwZ5YcqeXMRLhTWw4dEQtE3fy6Cbu/5OWTTlcq9bPEWqnoZjn/VV0T2jh1j3WJ1Eg6dhr1zF3PpkQmprW5SALTQx1BY7a3ur6HA1jI+A8EKsTN4m1m9JgDxWEDH+GkjGKZK4zbtMoDe8lWHFIb8OCOVxEtIY4UC/HcsJRQDTOog=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3261:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:KZduxFcsh+K2n9WQWCsu+XnXMZ8fDqW/1kNRjdcN0OeoGcyAoNkQc6MtmHMKLHT0EmVg7d+Ar+wl2kg2nhqVF47Lq0e8kg/fW8fGaylmTUUhZ7OqUqd8QVjJnMNar7X4zt9HNGjYiV3yxMWw8GfVfqWegOsy8EjHcsARAkxZoXMLJ91rliKCDtMo3esBKEDI6ew2BFXIY6t4tiqimCJe6PD9jPFCMYaDg+027keu5v15siPgyEZMvY8+rffa35/6dMbyym8epBIF2qPtwi69ssrICRX7dq4c3LnzEvjlQ4QdBBrzKz5/xOtFhxLaAMJJu04UahpcWC6j8zoQvLEEej2sqOTwVmHJKhRk1ks7uRRktm2ZKvKf71KKmU6TPC298kAqOI/MVrfygPB1XzwUx183LzrtO+FYlp/tb2/cTXlapGCb6L/dC3qi2mZraZ46kMGrxEbc/WW5wOsz0TgUu3e04YuJnJ0PEqC7JYyzWB4GIxSx5FdJECnt66SdEoBn;4:/h+SWELyprePLoRytOxfkFKp2w3yClE43KnHISR09yZYUjesVh4df9wj1hU00MiGVakaC5MbfJ7HLXJtYpu6zFZAZ5jyQwZYcXxRe9xebh74UTr3g4EutdIfTOAa8mLuBSDICjofLZ108TuWTiYncbhPGITD8QMt5yCh0ijUHUAF/S/EGUVIkZVhjNv0iSIJGfeiNd92q38eD7uDRELQm0LvMa5l09O/dqIDYQSz2JklUulMW/OJJ7tr29yapPgSQIaqHIraAlTtr6F9aSdeDA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3261389DEB99F13105490BE4B0190@VI1PR08MB3261.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:VI1PR08MB3261;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3261;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(396003)(366004)(199004)(189003)(107886003)(52116002)(51416003)(66066001)(76176011)(478600001)(81156014)(7736002)(305945005)(25786009)(105586002)(50466002)(5660300001)(106356001)(53416004)(6666003)(81166006)(6916009)(2906002)(53936002)(6486002)(8936002)(50226002)(386003)(956004)(1076002)(3846002)(6116002)(446003)(16526019)(4326008)(2616005)(476003)(11346002)(36756003)(48376002)(16586007)(6512007)(6506007)(186003)(486006)(97736004)(86362001)(68736007)(8676002)(316002)(47776003)(54906003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3261;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3261;23:GfKxsehmrkhD3VE8MBh/KiHap9VYMUQNZlXbJDpIc?=
 =?us-ascii?Q?jXQLJasGt/K3C8rUp8m2cQkJVXiXlTvOFZmu3ZwC4eguevy/mwrs+4CfYdOV?=
 =?us-ascii?Q?guZctIzdaf8uLZtQiDm/iKUShG81YiwcxS52LI5fBSv0tFXcdSAIlHkfcrO2?=
 =?us-ascii?Q?Ftsohw9XIIMouolLhvgHENCkvyqDK6i9Q5AqfB1FWVopAhf6v8mTy7eugfdv?=
 =?us-ascii?Q?hQAnJdQc9MAvlwHbUDUCbNNYHk7XyugTbOeMmXPw4djsMwF1L7WyEYbfch/i?=
 =?us-ascii?Q?R6E2p9YO5W3fDSMykmi1tWVr4f2GMxJPPzCDmpJwGBq9RhC/oklUmfEQEQqn?=
 =?us-ascii?Q?d2ZpisnjnUjnJpghm4eXci9jQNHSnN8oXOoOH8GI1n8Xk0SCKAIwnHIXuH4Y?=
 =?us-ascii?Q?nS+Zne5/MgEbEjvzno5OicxjIWEdz5Ve0e2EDgyudrS+q7TJx+RiXndYNf5w?=
 =?us-ascii?Q?PuTsbzYYHxgz1tqdd09HmdaybdBTzC40uUG0ODmAFm+HT7SjlAgWSbeALMBT?=
 =?us-ascii?Q?qUxc6WWlDSw2KeYXqmSx6VBgI1wr6EKm/sWLsvsq6rV7XrT7jU8rWkYPyFze?=
 =?us-ascii?Q?V4zp9LYdrdgeTtSSpNmfaoZwyxSBoZIAZwzRUPegUeVZo7aATRK0YMk2sbty?=
 =?us-ascii?Q?nb+Kazw2q/1DuogN9ADD4zKu524wWDraSKp9gGUuC4Knw/E6tgLKoZ4zAMoP?=
 =?us-ascii?Q?dfBFCBT1cCaK2uzI5vPnznwqh7HsJFb5mTXJ86WxUFFpnWt1sRFzVBXaeFg+?=
 =?us-ascii?Q?UcplRWXEHb+RONlFil+dIZBtdzASlFhfRWEbO1AF+Zm3lwB8rymqXRqK2daJ?=
 =?us-ascii?Q?tZjADkWvqAnAM6JVH3c4XRGmxuyDBc0F203DLgMP10TZ6CSUIxAKR3zHOQk+?=
 =?us-ascii?Q?aUM5qgNa95zthJ66ejHefkNmR64Ekk3ArjwPrM8RV6leJvahyEpR/FfKbtE+?=
 =?us-ascii?Q?cT7CB18zVsfX8Y2tT6BhA1xTPo6nLh58Lv0ceITcODElTBc8kx4jO9eQ7fb3?=
 =?us-ascii?Q?E+1iP5MuhxJOzc76iAkP7bHgmuVz8+fa5rf+rcrTjQR8Y4vtKQs7DsAMh9ON?=
 =?us-ascii?Q?Vibg8VGKFLyWdKxMkKjNMMrCaZU3Er9UjOQJYZ5Ew/ztT/1Flb8Tb2X+TnaC?=
 =?us-ascii?Q?HcGyf6uTpFZ3YGD7jIQTs2/xqLP36wkZIG2kfpmFlDJFoOKc9qj4ZGWRcaGs?=
 =?us-ascii?Q?tNlihMm3hEbhtVeF/vm392YdkbHWu3vgXYCNd2lZE6nt+DXAFZC/MLAaUSoJ?=
 =?us-ascii?Q?gfI51ateJKdeSjF8t4=3D?=
X-Microsoft-Antispam-Message-Info: N4Ia9ZkEtzdL19ZZOAd+XhmLXisEn15s/OjjmF6JxemTdIEif+12r/tdjedeFkwMabtj5Mgh4EXT+TrlY7lwNm8wa8zHRmY9AQktvbum7uJYJvFiG/qp9MhQUqFzLGJYC8PBz5WgaQV++DZnpFQV5eP0dkgIhFNLHEsT1uJaM8LnDMJ5iCh2xwafhCMPE6Eb3C00+x6PPbr8CU79owhTcpy4Nwtpp2fZU1WEklGggCOrnMJrWPNMZ01BGYTPiT/k5WIRzlZL43G1aKKpb1P2cgVIopj1mALHkdBX7YxhVxZMeKEZlqpnDltLBEN9pVqJXRkDN4IETCNh7OaZbz52OiTDIm+jOE9rCSXcIKdWwFg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;6:hfq9fVwjvpHaTtGkLU3YB1JGzl8lkZnB/DTF3szCdBYLSlvegnGdg2YL9J8yCoJGszxb5ySPFTg5SfSvQ7nVbFP+ZxRsJfU00UXf/TZF54OIgWJYBaaCLCfj16yTSouF8wGHw0iKSTXGv+Qjegb+WvUUsMp1FQHvQoEyA5zoOcv3bTHbJ4xDioZyaZ9d1RHSlnPFFGYLG+yMps6jLhQhnMAjApGtfedZhrnLBavyc/v8D1V9DcYR82A7Bz59C7oRHHAMl+SuIrc9gvoNFLaGqzUSRPB/RRL/yCENQ3AoCnFxZFTl4/7WJ4hZMz0l6tMA/tEwWKNWUUMW17ri359tyAtuBtp2Ul40kildHEFU2IHufLnueXa4QfWD7cAh8ekQNlfjhVdHuZGpvw3CT/OKGPRd4smqypq2diaxaDUWbmidxg0EvzIVz0BMTE9E1scqiBhleiryq6490egIHeJoGA==;5:tEVo4+iYk1i4/y28m4ERyK0z+9ms9xqkUM0Bx2VHeP/0bWVeolsHX0yf8MQyHdx055rP1YwE45iDxdf8C0mRDyQSzBlPCATOShtWQ9SVXbZLlgZROAaWhGL+UVve4n4nxPU/9dPGbNlxphKpW6r76e7QeAtqAOR3tPsqprfQoUY=;7:8YfNg0ID3umqD+FJB7K9PhgB/TVE9gz5VqlU2uYLZ3BiEuZTWmgTcNXBjrhyEJa9wDYiZ+t+02e1YIi7leHIasOjJlT/Nty1YOfMi21poWnqHl5eM3mwXhpYzrCHjxR1N2uCJAtMjv5pCoDP5aXX7rQT1WixK9CAlTfe06YUMa6uEY35POtswVtzI/PP+Jfyxkyzdi5cXrZ4GdQ4Y0ItI80jczg+Rk4xlNpjbBkahE9LUl5jGgisqLN6JXSoTU+h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:DYK9fG+Ss+LyCJb4lo27nEOqnyRT/Ulk3OT2dUY3ex+GEAYnGZziONX4h/cY1Ne/OnZPiDtmiUvKVZ+QDXrWMoyAF7jZUFlEaWbfeZcXRteyegJCTrn1rbnQlMOeTfo53HTIsndKpfNo0455NQdmm51pZn0zkAeI4qYCZH2hNT4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 13:05:02.7411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b6de67-348e-4a16-6586-08d61a42af58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() might sleep if called not in interrupt context. Explain
that in the comment.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a728fc492557..d00d42d6bf79 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1577,6 +1577,8 @@ void vfree_atomic(const void *addr)
  *	have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, but making the calling
  *	conventions for vfree() arch-depenedent would be a really bad idea)
  *
+ *	May sleep if called *not* from interrupt context.
+ *
  *	NOTE: assumes that the object at @addr has a size >= sizeof(llist_node)
  */
 void vfree(const void *addr)
-- 
2.16.4

