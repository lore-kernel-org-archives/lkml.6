Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39252C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D488620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="erHlcuGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D488620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeIKPKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:10:51 -0400
Received: from mail-eopbgr70105.outbound.protection.outlook.com ([40.107.7.105]:46825
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeIKPKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGVQ7LONaJYkv88zRz+vowQruY6FmjG6LNj61+EkXsE=;
 b=erHlcuGMZyEArRB7cNDOeKkn5zoixArlmk42ZaSP7Y7zcNUTaYkVFCj2MR5X6LAcy+ybh9CR5VbvZTMNmw7ED2Ziwt95AUjBSPSQaR4SR4aKq5RhINdOnzKpuQFAkMMhh/j0b6oXhqK74jptOC0NRXIlrwQMe5AKFvdgXQUMP2k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB2021.eurprd08.prod.outlook.com (2603:10a6:4:76::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Tue, 11 Sep 2018 10:12:08 +0000
Subject: [PATCH 2/3] fuse: Kill fuse_req::intr_unique
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, kuznet@virtuozzo.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Sep 2018 13:12:05 +0300
Message-ID: <153666072546.19117.8470733578671949444.stgit@localhost.localdomain>
In-Reply-To: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
References: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0048.eurprd05.prod.outlook.com
 (2603:10a6:800:60::34) To DB6PR0801MB2021.eurprd08.prod.outlook.com
 (2603:10a6:4:76::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44b25356-abe0-446a-aac5-08d617cf08c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2021;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;3:j/ipjxIzFU0Amb0YaORR3BXefo+GAXGIzJPOWisCY90hFAVxb00EfRre7JW65Lyvwm5KlDtv/5tGRTc53GGRvXhYIs+tXj1/rts24OlDc0Oba4raYBLtAdYU9shcka9s8rgJ+yC87nRaOOY0RqNl3BtJ+XkSR6w83kpLoFz39Rqz7M1bEhDsltwE6O+m0XtuJeHbk9A5mDc6mbZO4IjlKPfLn9QFucKdsytnch0/iq3qb5U6w1bDgxv8d2kqj0vJ;25:hxepqkvg2Hx4sHp3C0u0jb0VXdaVcQn+2V/FHdMpMSuq8YUDiZWOoddD0+1RhyqLTQc6QOnM0eR2iTOL55dhdF6D3S11H47pNf8WR+pzyrqqs/FwIzmaBsHHCzgJa2xYxMMK6VK3qFSnUmJboyClZ/0w5SYkXOXpbCwkQMlI4ezU14QT+80rO2F7TJ9YtpCxCCpoZrWlF70gi8+HymcHr1dGvClAGUizo+8XrXZAU/AfgH/La/fzTIqe9kfoBVa/khNSJtLtjuqLCahM4sTwBcRJsJ3yn4FJJzm432wKHkT3L3f4gz0EVLk8TGUvHZ2DfXpgRY5q7YICZXfhvaNYlA==;31:kkkUohcs9fN18CyDALY+mfWoY65TzsnX3Zvt9KDdX3X8swECTF69tlt1yWCdNq1dgO785sW359117q0DhwUDWICCeJdHOmcb2e6i0GFU2xSsuP3dX3N9C1UWhRc2m1QqtX2TEWXfv+X0tPbQxQTDGXECNzdUk/A5lMaFUdD1G3X39i3R9O6dChwC65XGZrfVaB3trS5VlSQT9t7A6wTSGar/maR6nHQl8/+uGNR+n9Q=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2021:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:+kpys9YuTDOQAUuRhWP1otmu/GSfpXMMtXq/4P8220UW1MAsGiHojHXhUtb465IyjsjOt/tAmM7k73BCQdHhkAfT+9dTbDzGqLKaV6SIuXxlBP9S4jRHxIL36gyzmv9ZaOOl9XLgR0CFw6pqLYec+f6x8QwyckkdBaib/2P61Pz8p4WWKyj9m4p5bfHt29zD+d7ZvHca3DWjynUvtqj2JxSrl5UeBUoSv6/sSY7Ps9Ujyzky8e2MIz5u7g89p+5C8xZ8MY9HFhm+SUcgOaXB5AwdY248F1TOxS+oNaZ2K1+gMe2i52nmLY+8TZQWbnX3g7uOsE1tKU6pCkptsHQOyk6p61K7z1nyfvUUEjxLldsfmOUS8xwv4FBO/PGHZadQRM8u6spyhHf+qEHMJfFaveaJzQ4wgGuEoBeW2msJOrqRqgwUIoeJqpqXqgV7QY7uDp89/9n3cpXmZhQAkIj3IbDmDFxD1fKYPc8PMwkJvh1TLfshlDPZ4alMWJ5nveFw;4:GCs+1nNs2Bnm2EohxjgchcA6CO0SgTQmhJOFeRAQz4r3ZY+cNL5WijhRWTfCmBYLqYFpbILgjBaSNQaYUFtdM+NsfnfxpYypdPqEkCZcklpz/RtpBOhvOCehrTXcthDgklqv6YgOivxBu+TFaaMoQK+2AU1YOl8Woad69oFibdpFrJzWacI4Ye5FJAMd7BkYKwrSG4iA9prCN01xeV9dkju6mv5EjiNfmb/7OGyY74IhLFE/SN+G/ceXYEZCJYhhQUIDNLf/0xywTi9jLuP6Qg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2021B7326CE82DCCE5C68940CD040@DB6PR0801MB2021.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DB6PR0801MB2021;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2021;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(346002)(136003)(376002)(366004)(189003)(199004)(14444005)(33896004)(86362001)(47776003)(230700001)(66066001)(61506002)(478600001)(53936002)(486006)(81166006)(81156014)(76176011)(446003)(7696005)(11346002)(8936002)(386003)(97736004)(6506007)(26005)(476003)(956004)(58126008)(23676004)(186003)(2486003)(52116002)(316002)(16526019)(2906002)(106356001)(105586002)(68736007)(7736002)(50466002)(103116003)(5660300001)(9686003)(55016002)(8676002)(6116002)(3846002)(25786009)(6666003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2021;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjE7MjM6NWh3ZGF3U2ZhQTBKN2VyaU9tTnVGWnE0?=
 =?utf-8?B?dEJqbzRwVWY2SEY0UG80MFJnb1o1elBQR3NRWE1IazBtamRxOTZVaGkxck1s?=
 =?utf-8?B?d0pVb1ZZa0ZvbFY1QzdXQUl3aklQbzNkb2drbE1KdmFsaTZlWGZKbGNLazJ2?=
 =?utf-8?B?cUNGalFib0pBS0c1QkVBb0JrVUlYczhDR2x1OWZ0Yk5YOGZrMnp6Q0xxTm51?=
 =?utf-8?B?d3hQU2d5blc3dlU3SG9NSlRRVE1uQ0JaT3RycHlLS2VwTWQ5bUd2RmFCK01V?=
 =?utf-8?B?OVpvbXhYSDZTQnY4ZGdLMC9CMHNjY29oek5NVG15V0RicG9CMzkveWxyKzV6?=
 =?utf-8?B?Y2dZRHBGcHg2My9kdVdleHB6c0JqNW9xKzJkSXhMbk9xOUs3VktSS2ZDdVNM?=
 =?utf-8?B?aW44MTlVVjZtL3RJRU01c0xubFVnemVBREIyK2NZcDVNbDZWTVhqWUpZQ0xO?=
 =?utf-8?B?WDZTV2QzaXl6UkV6RjNwT0tuVXNWUWQwcXQrYkI5cHdJUGRhcG05RC9OenZx?=
 =?utf-8?B?M0g2SDFVMEVjSHhxZ2szejU4dGljNTk3ZGI3SXEzZEIxR3NzUEdvOEtOdHlD?=
 =?utf-8?B?ZXVCN05INFJBV0V5KzQwM0w5ZzVSMHlWclNWeHg3OUZRbjMyaEFsN3gzaGZ6?=
 =?utf-8?B?TUtma3dLTnhHS1VRYkwwMlJPNWxPK2dVUkQ4Yyt1bU8rZ1l4QWVMMVdsMkF0?=
 =?utf-8?B?Mys4NmM2L1BBTGxjY2hRbmhJRXVjL09TdWJ3aXlXa0pFZXJJR0FtNjJmSEVQ?=
 =?utf-8?B?Ymc2OEhBd3J0bGpiR0lGK0JBM2k4QkRyeGlaYVAwSDlBb2JJV1NYeUtKUUJY?=
 =?utf-8?B?MUFqUzM1SFVJbmVpOERTejlVZVF6bGM2UTZWVmhNaDA5YlBhQjl5bEpIdkJy?=
 =?utf-8?B?dUZ5S1ZDemZGU21oZDZJckYxbUFibE9wQThIM2xpdTJ6Y3l3RkNtb1lkRGpO?=
 =?utf-8?B?Z3h1L1NhQzJReExtNG9Eb0N3N21JMDRnV2RxOGhsWCs2LzY1VVRxOUJxd3h4?=
 =?utf-8?B?dTFRTndnTWxPM09PUHdHSFBTOTF6WE1xS3JiUk9tak1FdHF2VjljOU5Vd0FD?=
 =?utf-8?B?cVBwTzJVVDd2YzUvVStHdXhaQ29RaDJ4SnRtSUdhR3dQNm5SSEZOYXVQTXpZ?=
 =?utf-8?B?S09SWkp2cDduZDRHcExtVEZWUEhRY215cmtDa0hZWUlPUGZiamdwU3krVDR2?=
 =?utf-8?B?ejR6U1ZQSTVpYmNHWkJNMGFaSTFrRUw0N0E2SU93TlUzVEJNb2NIUFdEeTJK?=
 =?utf-8?B?eTVkTkEvTEt3U0xhbUZCTmV4QUlyTXc1M1BuelkvUDVuRkJ4SEpEQmVtUTFZ?=
 =?utf-8?B?MHc4U3UwNit3K3RFQXZ2NkVkNDVoV1lHU3NUdStMOWVTaytEV25JOFAxQzlu?=
 =?utf-8?B?cDJYSGJ2K0ptdmJqVDRqQ1hRMkpITnNxUkFlMTdBKy9Uc1EwUStPbW5GdzZC?=
 =?utf-8?B?SWJYZTJUWXVLVjZZK2xIdEU1N1Zrc1F4djFRaWhuYmhhNUZlSFdTdEYwOHZT?=
 =?utf-8?B?aWQwbkNBNDEyZEVnYktFdkt2UUVoQU5jRVdhZjYyWHNqSDY0SVB0R3FvRytR?=
 =?utf-8?B?VDhuZVJTNzAxSm9BR1NYbkNKcXV3ZElRNE80TFg4YzNFRnArK3ltZjZraVUy?=
 =?utf-8?Q?8vL9GV1tikTjtwwoet1lM0?=
X-Microsoft-Antispam-Message-Info: 3WydYcV2959viQmiw+wqmA+rhkTwg+T/RsLP4WNtyagYXTrFtlNDMGCm8T6YehyEui/STSt0VdQGM4ajiqtQ2XLA+q2NjVb1zpJyEnd1Lf6buaqlhqL0oAfaHUUOcpQfT8/NG0AkPEePrFiZBNi9UQoOUDMn+6MBt0E7CaDjgMz4fY/HAk80n8hfU6E8JG0Yoi6wZlSnrDz7v/rDsUWhT/9WsCb3cormoaEpwnBqpK+f4Mvya+P1oM28bPZbGKmndiO9LjhwxWzURkBopYdgAC+Kru0v9jnr9Ly9WFXqBwj75C4ZKuoQ2SyuNfYi98PGi+3Z85cQiNg9PktT0YxIulrNfu6gkBYxF6DftS3Gen8=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;6:C1fQz4yCEkraLwGT7aj9Gr3LJOt/bdZ5v8rSGnb8uBtDMPxEIUC1OUrTZSj7w45kSbF7hoZwHjw5Jq/fYcO0Mdqg7tx/GWY0B1SkNSuG+4uvjDoQ4JsGgAe0xMGC/aeA0089uVCAsKxWovpMRuPxrzPjqqNwySb28bDdsC1BV21Cy6BGTQGR+gCfly54MO5iiRsdLRNAvVrvaMNgrol9/xuIwXt7kOWuq/12Ydgq/InEzVg8ibQfE+T1IZaHjXrcbLuxInKKtJJuezQ9qqVwfqJlSlDNlfmarqDxL81sMw0bpJ21A/NKIakU7NuedJNceCeI2uX+DKTd2d6lwImVNx4O1uy436M1gl4hnGJus5ZHizP2xQIELNTAu5xUnYG4uXNjAf+O/9y6goKCtm7O+PNgmXD6r9c+nv20PL5kNKz9pJLNI3gipU5xn2RfQckS6eMVzUATZCcTLKSO8QNeQg==;5:mkY01MTv7xJ60hq2a4z+vX/a7cV/CspPPaItQZXvqrNiiJ32aGHpeaWPV/06yt7oKoRmq/YLWcOlllndvz1lDtZUottDNCckU1Y+7bg/v+MpZ8+l4zoTYDbQPHSRdiDdwkfufP1psqqjV2hk32HvDXwADWFjZkmyVbCcBtIPawo=;7:3AeLSmbgd2Up9tvHpUbaxNFVJftVtm8AOfr5Qs+pW4UBKQDoqsz/x0s3sQByJ1a1HjuUHV33dSmFMf/b4QcJ1C9sWVJrNv6VrDETia6VlcWG9nydAoYzEgJPfm/fEcSR9fJr+guqLtZI1komgpmZlZivyZrPjdsBI97ucvxJPfEM+y9/jpfVL7UjLu2qmcjSPkrW1gdpbmtFIdebK/L0LhDlfzeqVXvMyiSk4E2PUS1LuUQcX5GLO9ZeRK01hakK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:SvyE8MslvFGK7fX9ZNVg/ngGW6UkBOcM8rKaXeXd68n/lvRJM3Y4UM19yMNY5HParVPTglj//t0RlxnjLMqdijmQ5hZu5oG4M1mv63dvJzqTV/SOX8c1BvqiKEZvA5L7hI1FFgAQAdMg3sSKZbWV1MHItM40T36xHZS9jFo7d4Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 10:12:08.5672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b25356-abe0-446a-aac5-08d617cf08c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is not needed after the previous patch,
since we can easily convert request ID to interrupt
request ID and vice versa.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c    |   11 ++++++-----
 fs/fuse/fuse_i.h |    3 ---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f24fd6f61a7a..dda177b57ea2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1089,12 +1089,11 @@ __releases(fiq->waitq.lock)
 	int err;
 
 	list_del_init(&req->intr_entry);
-	req->intr_unique = (req->in.h.unique | FUSE_INT_REQ_BIT);
 	memset(&ih, 0, sizeof(ih));
 	memset(&arg, 0, sizeof(arg));
 	ih.len = reqsize;
 	ih.opcode = FUSE_INTERRUPT;
-	ih.unique = req->intr_unique;
+	ih.unique = (req->in.h.unique | FUSE_INT_REQ_BIT);
 	arg.unique = req->in.h.unique;
 
 	spin_unlock(&fiq->waitq.lock);
@@ -1799,8 +1798,10 @@ static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
 {
 	struct fuse_req *req;
 
+	unique &= ~FUSE_INT_REQ_BIT;
+
 	list_for_each_entry(req, &fpq->processing, list) {
-		if (req->in.h.unique == unique || req->intr_unique == unique)
+		if (req->in.h.unique == unique)
 			return req;
 	}
 	return NULL;
@@ -1878,8 +1879,8 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	if (!req)
 		goto err_unlock_pq;
 
-	/* Is it an interrupt reply? */
-	if (req->intr_unique == oh.unique) {
+	/* Is it an interrupt reply ID? */
+	if (oh.unique & FUSE_INT_REQ_BIT) {
 		spin_unlock(&fpq->lock);
 
 		err = -EINVAL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f78e9614bb5f..f72e4974b3bb 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -311,9 +311,6 @@ struct fuse_req {
 	/** refcount */
 	refcount_t count;
 
-	/** Unique ID for the interrupt request */
-	u64 intr_unique;
-
 	/* Request flags, updated with test/set/clear_bit() */
 	unsigned long flags;
 

