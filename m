Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C6CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC63D218D7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GPDr44Tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC63D218D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403887AbeHGRy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:54:28 -0400
Received: from mail-eopbgr40095.outbound.protection.outlook.com ([40.107.4.95]:42858
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387578AbeHGRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg2f3sHd7KK1BJ0cbD1TUjK4ril0zWlzMyWwFzFD/WQ=;
 b=GPDr44Tnx7Yz3WjoerHJjJryCK0MChpRbchqf77gkUN6D8LAZ2YKv6rmMjRvDX+s+yP6gqFb0zzQuVTzgNkKcwuJM5gKViHBb1W16gePdhvxuzGjJcm53nd932zGwto9XD+SxH0rQsl67Jx0qxCSlZDsQKyEBQVLTw8jTIIGujc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2030.eurprd08.prod.outlook.com (2603:10a6:800:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 15:39:18 +0000
Subject: [PATCH RFC 09/10] shmem: Implement shmem_destroy_super()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:39:15 +0300
Message-ID: <153365635538.19074.16684830171993560909.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:7:28::20) To VI1PR0801MB2030.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 227d3eae-996b-4c9c-b285-08d5fc7bf261
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2030;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;3:wM4LiZZYmPpTsig59tCi4wpjdUT3odeDnfEGBKsWz5WF4G+bWqsuYLHqY5LdROqkcFI4/bxITEFE8eqytlbvDSM/j7f+vZrh3PZkl1FBy01h6JRqZSsqFEaeTSo1BC3Ne/EkWu0PDcvb5mzWCCRCULqiFne6LwdkE+AkaFAjjyBOBHN9UOr2kxAHHRbGCNxq8Vxk0r7JX/HjTjYtvMNRij6fWZ2zdKgBrMx5kLl/QmEupQjrdCMrqNPa8mZxxSVH;25:bKwWAaq8kv4+WK9LK1WsoYwRa5hmjaUstAATuQElWrLeSV3oPzL4NlCOtev15UvC6y1IVvhSsuJauXx20/fJs8W09m3XmHcRSWNFitn1zKcxvqLpFU6TCPUmwRs7wf3BDBtwmkKwCvg6b4PNamBQsXTbPKbimQC0YTqlDrUKv3I3Mjv3HAw5WnSROWQuHadPxsgkAYWeimHSsO4b6rIPi0uXuF75dkI3CveYvHgKBY1K0w+AqXGGLv72zx73uisr/QEHWbRMiLfF9TqROZr08qaYcAaN98FDI9f72QXOjIkiSXvloJnwWS40BTrYaglzoi7rwaPekEJy0SQFNokBgg==;31:0XRHVd3k1ucJHT9frTCtfMqHM7M7IOGrXmTtgUTlX7wODuhRS/Ixp+yOT4nWM9dqbKRhtg7AWJfEB/WWYssXiPze/U1SgNpZcOytyvyc14UhTQZ4c+gWcUqBSbph46O17f4Gky4mg14r9+i9j9gL76Ipgp077HiQhw9mvB25iOzDuXCo4Lv+Qyeg8OXMTubyWFdQPBQccZ3X3egbE2Pp2nnCsZQBfifa8yuUqDaMSAs=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2030:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:CisEgI9gP53Z37pqt/0p/Kzhsp5uuZmrQ4ipO4pQakWazg1uhJvd5glquir24aAP/bUyOjoUX7HwAgnUT6y/3RySkFBWftFcbjVC/phNW9Zs14YzEa/G9UQe2/Hf37MgxISRS7/Lcjt/v6KBfgV/+4z0cJCd4Fmw2YLsZ2zPZoUSUeJBfegF/GOgKHVqjtg4iMQUv5W9M7vmBf5wHf0pVUOOhBTDmgE+IuqOeSUuXKVFE35WGx8NigQ2V81SZVk32WV5nbuofTJaZCm9TpxFxzfYqsXR7xR3CcccbNzkK2JbfLzHunvklO46HSLmDhtPtYVFEAc5Pty1CFdmxnGuHNqfb1l7CjFLKlaFEFcMQxGWlJVsJrY48Cj2vlVDQe5zJgvkqDK0qP8tEmdEwE78eH87jfWIuaX/2CQ4ji//80corYk0zse3+3Tumrl0AXlQDPxSY08DgMQSqn5aYmivLpp/YLzfZgCk5jIPf8NIh9GXhuDWCHSmr4Bo4JNX6/OS;4:CyXEkGdW3NLEa+0spKkEPWDi02O9hEHAVRsFRqJpHhEexH0jTA3S6ON5OoaU3ysPQLvDrabikq4gcyijhN2CIPmH2Jv3EVFZuK4rSFG+VfCgXSLwUeueodHg4Y9Mi6LP8MwPcPV25LADSWEfTIH70LmJWyB/xtO8l5uUJVJktsk0hyy6rjXJh3sUIk9sf2cD/LIfrmelz3rRgTyCdpaHIltQPHnJ+QaF9SZiitJuU+LjqYJZ9Vzczw36XhdpIuPWFGrkhmB5M82YZbYw1zARfQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2030D9DC20619B1FAF302422CD270@VI1PR0801MB2030.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2030;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2030;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6506007)(16526019)(386003)(6666003)(7406005)(7416002)(106356001)(105586002)(5660300001)(97736004)(47776003)(66066001)(61506002)(55016002)(9686003)(217873002)(26005)(14444005)(53936002)(39060400002)(956004)(486006)(2906002)(25786009)(11346002)(446003)(186003)(476003)(33896004)(478600001)(50466002)(305945005)(3846002)(6116002)(8936002)(7736002)(81156014)(8676002)(81166006)(230700001)(76176011)(7696005)(52116002)(86362001)(58126008)(316002)(103116003)(68736007)(2486003)(23676004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2030;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzA7MjM6bGJuY0R6SFFtSkgwQXZKd1UxakNIZmpr?=
 =?utf-8?B?UFhSSzd5UGoxRzFuREYzRU8ydHY5cTJrTE0yV0FHZWZmV3loaHQwdmpCa3li?=
 =?utf-8?B?aDdwNmZpaDhIWjlMWW83b0Q5K0hCWTB4MFVLWEhLbGs5Nlo0bVR0bEVseGVH?=
 =?utf-8?B?Wm1xRDQ1cEp1WnZVYk5kYjRyWTI3WkI0ZWRoK3d3Wm1xOEloRzFLR2M0cUFn?=
 =?utf-8?B?dXp4eWFTempmQTh3bjZYR0c3M3FOdlVITEorYjRUSlJUcnhYTFhBWXg3M05n?=
 =?utf-8?B?YmlCT3BaUGpFWFVkVFdzSStyTllPVzZ0R1JaL3hnN0Y1aUhYcDJxdzBueDhH?=
 =?utf-8?B?eURadzlvWEFtemdPamNHbXgxNHg3V2JjaTRRQU52V1hiTE8xMG12UnZOZHB0?=
 =?utf-8?B?VXVJSlR6TW5HMmVPS0RJRTFWT0U2Q2tKNWY2SUxuQ1pZSi85cGRuVFVIM2ZM?=
 =?utf-8?B?dk1EOFE5WElzTUx0aVBKL1h6T0kySll2SERoemtZWUJKazRkK0xHMWVKTnZT?=
 =?utf-8?B?YnZWdUZQRlFEdGZYZmNKc0h2R2YxQ3VTbzNGWUI2NG03Z1FCdTUrb3A4bHlh?=
 =?utf-8?B?bDAzWVczSERrWFJaakpyWTBUY24xSlZVMVNzcE1CdmxDQW1hdlZMSWpmQ0Q3?=
 =?utf-8?B?cjQ4aklmKzhLNDVpalFXZXJVWTlTOVZTalY1UFgyRXNDWS84cXVNYkRDUC9o?=
 =?utf-8?B?Z1ZyamZYUnVOSXpIOFV5ZjJoNE9nK1RJSzdHWFA1SmNoQm12WlA1dGtMNjFl?=
 =?utf-8?B?eEV3MjI5OEJyL0dmcS9obVcyWWFrTmUvSzFpYkZ3aFkwTktZYUVCdDlPYUtl?=
 =?utf-8?B?MHkwTG1rTVkvUmF2YS9wUFBEWUJFbG92SE1qMnV2SmJ6SXBBWVJ5RXF0ajEr?=
 =?utf-8?B?WFYyd1k5Z2grZ2Nya2ppQXlmMkVGbEJTYUpRUHFCQjRKV0x4ZGlVcldsKzVk?=
 =?utf-8?B?bTBCdEhSL0tIZ2o1TTgrSU9mek43QXdjTHlYRTJSU1N6RGxRb3ZlWGpndm9Y?=
 =?utf-8?B?bmdzNE1CN3prdmoxdkVjcElQREtaZE1XTkNNVHlpcDhwMnAxamZDdTRSdFcv?=
 =?utf-8?B?YkhmN1dKZlNVejh2TnNUSlBleW8xdE4wTms0QUhOQlNsZkl4d0J2VERpUzk5?=
 =?utf-8?B?eFJzZ3B1MEFYaHlieDBNN3dmRGt1MkRaK2RPUFpzVWYxSlZsaEZOb2hWQVgy?=
 =?utf-8?B?WE9FOVZWV20yL0RXR0M3OXVFcThLR0ZJeW8xTjllcG5JeHR1dkhuWjZ1Zmhl?=
 =?utf-8?B?N0IxQnY0czlBSlF6N1BhditPdENwRVIzMEdPYnlBT0lWR0RlQjhVTVN2WlV6?=
 =?utf-8?B?REQwK1RkVDRTOS9kbER1N202UGN6L0d0dHZvNEdoaThJVzZnVEd3T2FxN0la?=
 =?utf-8?B?MVdhakhTSFg0U1pwaitVaXFVS3BVQjY0NERZd3J6Y1hjL1RIN2JPRDJJZHdi?=
 =?utf-8?B?Vm4wQWswVkNCQ21GamhnM3FKdHVBYzVKS3JKbFIxaVBKOWtZNXdjWFRZMEJp?=
 =?utf-8?B?aHU5TUFuQk9MK2JCeHdCN2ZQNUVleU04SWN1MUJ2dTRneFVIdFRhSWh4Smtm?=
 =?utf-8?B?RlV0YjE4anlHSStGd2Y2cTBySlJNYkdwMHBIZVJ5L2dvQW1ZTXNUMSt1OGxa?=
 =?utf-8?B?czh1ZFo3WE1EY3V6WDRFZlN5eWlHYThCYmV6cythZjVYRVMzWUxCOUhleVRm?=
 =?utf-8?B?NnUxOHpMUXJEUzh0ZUxJVVc1SThicHloL3ZlVWVVdy9UMDFBbTZZUHl4bXQ0?=
 =?utf-8?B?a1oxNHRMVS82Nk9jWDB3QWxwUS9GbVhxbVY1azJONU5qcnNGOUsrWEp6QXJV?=
 =?utf-8?Q?4jO88ixayVoG7Gi?=
X-Microsoft-Antispam-Message-Info: Pcng21dcV2W1UiMrGgHprWfwuZWkn9VQxJBRTvjsUyjPYVxQOB0ed5zP9gX8Crn7NHvcL3rPIGUGX7TT1cTC8NyJV8t+pCN7aQPj8G+jh7XXSv1ktqNHOu5aYp9b7iwjkZm9Fla3ViApNeLz5SgwD0ObWqmAAfe0b3XnEezsHR7NogmUUd58dwblWV3hgxzb+lRU9cOnpL8MI9VXqmDIOisxuqwv1QoAc029O6Cmai/F6ML6tByMt+fcEwQkYXECu0kwx+Pr2vwLETiiGZJ5LL2UHoLNV/aqCorq642FGQhHKyqePbMpB/Ot1P7lsJCTY0zP4cATEHLrfEFk83AKapa15bLnP74o7f1Dx561cz0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;6:uUNlmx0ZQf+9KT75AJybSkTWd+uhkXxkCnnDqXRLXF9RCjPXf3hT5TTg3jCzKpNOtPjkSAcxQMlCuYAbyNJNCaqBCkuGdFHWUyktcTqaS+VVEsQzwb5DvY5ocxxzthGe36hJ6qSYvlNHn21LKfC/lmnBLSf6AwXENqWISoHbLxuXPleSes4vJM6yWNfdCBtB8/Ohc4gzQTZxOsU3q1f33QZbLpZvSZW8EhwIX3ysSvD9aY9uIid89n874gNV6km0t2jYx75fwN14LFoWrq1REQY2Ep7nkocgrcD41RGM3ea6cUP/jVUEYmzwiwyrX+QAZaL0pfOEP+mWRB3DsyTdc0/MtfQ0APMXh9dcMOOak3OKDnqnb8B+RUZrJwOH4aYAWDDQL7E5iwMWkGt/chCHEkoCPocaBixi/2bCkCMgjlrqu5qs38UFiSvxS2Ajf8oDsO3xub3ryTfiYtILVhL9dw==;5:CpQuXvE8xTcsfZ4IMwhl7D5YWXyI1WpzBN5lQRAGn20a1VALOQ3Wq4cXJlIMGEf33thUNPKWwBOTglgZz9RyRNiUmv2YqPvIuMWW62NGrJpos20UZKvES9n9RbDn0WHoVjFpnPUNQRrhbVSk3RKvffe0zrcmUgUTQsCHhSrn2JU=;7:I135MyI5CPpmz/JTWjOuLXG860YuRDmOMpHtmYFHf/2Vvp6x6ZpYkjOjepoXZOWh3CIYOM3drkVj8duRjTOG8FFMmMlgZwP76gYsXX9e2zFe2TI8zCbtWaYvhMuBzIAde9/w5AFhFJB4sXshMUFQXtQZiL4O3ZHTaYfg6Fb0zfxoiUmQHp3US0JLEA5y1iBtgb6i4NCoCSYtjo5DqRNLMhoBaR9XQMcVk2hzZJUi4sY1LZQtXls12Ez5cLETFz9B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:KUpAFL/t1fg1kF2U4kWOfITPEQD3vyA77xqygMc8Z+tO3yueNozCEpcbYEM+qcqBSNlpWHL+1ERWINuak7wEE/oUhVwA0WGGY0zTXAX2iMr3kquf4ERoWG9SCvSAErGzhJSBqLlQ46PNMN3PiADRrn/0YgRWiXgT+JQPZVmUpEc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:39:18.7221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227d3eae-996b-4c9c-b285-08d5fc7bf261
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to xfs_fs_destroy_super() implement the method
for shmem.

shmem_unused_huge_count() just touches sb->s_fs_info.
After such the later freeing it will be safe for
unregister_shrinker() splitting (which is made in next
patch).

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/shmem.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4829798869b6..35c65afefbc8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3427,6 +3427,12 @@ static void shmem_put_super(struct super_block *sb)
 
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
+}
+
+static void shmem_destroy_super(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
 }
@@ -3504,6 +3510,7 @@ int shmem_fill_super(struct super_block *sb, void *data, size_t data_size,
 
 failed:
 	shmem_put_super(sb);
+	shmem_destroy_super(sb);
 	return err;
 }
 
@@ -3630,6 +3637,7 @@ static const struct super_operations shmem_ops = {
 	.evict_inode	= shmem_evict_inode,
 	.drop_inode	= generic_delete_inode,
 	.put_super	= shmem_put_super,
+	.destroy_super	= shmem_destroy_super,
 #ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
 	.nr_cached_objects	= shmem_unused_huge_count,
 	.free_cached_objects	= shmem_unused_huge_scan,

