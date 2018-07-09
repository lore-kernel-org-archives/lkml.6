Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3FFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9D20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DW0pN3v9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E9D20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbeGIIin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:38:43 -0400
Received: from mail-he1eur01on0121.outbound.protection.outlook.com ([104.47.0.121]:18944
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754077AbeGIIik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXe7YKWjRmEZE3mUe/iW/B2RET+r4Nhkxtqtifjjkfw=;
 b=DW0pN3v9owO1oAOPN/C0yOIIxDdb3VdS6c2Ss8n4eNQxnmPPQjt9bzlAays4qoSOmW5hqjDI+45CiGGlLUPOzSYcKCLcjz97ihxk3LUjRt5t2KVTt600RYTwfco/eeJ4Qe94Rpy9DpmOWmEf93itSfQcxyt1GpNByCJZuUPhCi0=
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Mon, 9 Jul 2018 08:38:35 +0000
Subject: [PATCH v9 07/17] fs: Refactoring in alloc_super()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:38:32 +0300
Message-ID: <153112551213.4097.4983689312654935877.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::43) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d6dbedc-8d3e-4abb-82ba-08d5e5775d69
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:kNses7csZOXNS9YoYH+4cqOOh5bf8ssclrvGYvBg38F6yaT80MPTHpE5rBq+0z1tLV16xvlr9JOe1lE2xZW858jAv7Uj2KLL1TmjPSmUVDxusNFqBdRxQIELP60JJLdsDGLm5R6pRd/QXNfRgCDlVLa9eIJt3pgTGVckRvPB4BYVPcVRusc3h0cML5A313tiy0pET5CFoRYH+9XbkrqTf34L9MZRwKhIB3XfGtARKKC1K3A3XOdW7UwehQx2A0H9;25:R+fSL6+r4joXzVPeg2LcpXizY9P62gAI9GaZ8IR1iQEXYbtseUuv45YJlSY9obAHGJP2C/YPDoBGElituunsR0JvT73xGayNs/N2KmyEMjYnCoYCI1N90OW3bcq5+myurkrvl8JAcELMbc7/FPfFF/DaDeO8Js9Be5r1opAnPT111fVaM69d486SOiX4QNqs/KkJgnpFJHx+bZk+qW8w/k5ctxsc4iupetll6Fo9i+9cPnTZzJeflx9ft0pxzZOU2JpT+XSEaeZbwXfBPqYzsqGDlgyYrMqjKjVJ58gV7KkjCK7Jir3jzPT7Fupvl2aQeudBeNg4Ghy2xCwUhLnEPQ==;31:r0k82yo0plKrX8kRJC6lT+hlfcIP/Le96xvhPK5qizIYfFdXlUS+PAoEn8rZ4E7rjSobYEBVC6uK062+JtwDRFVAV6uuzfsAJcQ5NWgXQYbTpb/GU4JRMBVPgqCkTfesDPFlHYjjyQeE7l9NHvymtaw54W9yy3xnLE4pzYbdRXMUaAcFaYChori7pCQBylo8kfADaGUCqTNmqi5Y/W3W+Q6xzKuhVzRpcF3pFda2MHU=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:SNhJb4oaSwbSA5q+VAZhbkzUhQxvrjaGfZC2lSsOUhAvVkPeDbgxS1ySWLcez8lcxZp6sAbFqH4Z/VYH+y15L6rkAkgfWJDee2JcvhzpqxFhw5CMKE6cw8QmXh5rMet8BrWqN3mwKqWcxf44OzxzfghQZHbaB+fChZhRRPWpXaQhZj7tcdn4emXgTnawktGqzHED+hiGLB/TKAM9nYVuolJ0zBsrbsaAJQPBJ7moZwkPXuzUe9OJnIFK8XdL28MuqKyDb0/BXaVXLjfUkK4Egf+big5kGNB+I6HiNVMFbhJjcUDLy3nnH1FWYHHOPYvMG9O53hSkfwji9Dqef3Z9cxToMbJkrb9iKQtz+BT0vvd9v9QwVwV0hQfVIq9SmoaqzFkJk3LW1JKeCVn7XrGWhDIgzj/8sE80QX7/WSuBjAC4FMPTwYCOM8jmgJl2BHsC69sY1qaWXo+z9ie0+zGXameA9vHpQFrK2bHx8xj4wXXN5me0TJxNjz8hkJ6bkKWU;4:J56+Qiugk/M9RnkoFv1wPa7DJIbWz1eZ8/tI+z1yDqgvaKafh0vUdmuk9TqzsAtxyvWz3OwbD9GiYxAVsQMeiz4WgU1NM7UVVZFa5gK80djW0hAaRdY1s7WOaH1qoqIJ5Gvqjpek5Wj3g6VFC/pqcQroJenLzWyFiLTYkHMZsapI44zImWXUl3W1hByp3kIAzdEAUWS0H4BZsHAh+MgW6q52gls2TKOqkOByT73pv+W+L9HYIPxOE/Y/vdTgIVE9gtmTGhp4mav3of7Zt1y4NiKAWtZ0Ky/i5UH+HNIyZYCOmsKvWup7JC/5ndHHlZwYrGnzMLiisN19996b93GNOZ/fLmzmmfCB+5gmv2suKIlfU+jYBEOBdKxIEQT9b9GE
X-Microsoft-Antispam-PRVS: <DB6PR0801MB133481534FF3D4304471F8DECD440@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(376002)(346002)(136003)(39840400004)(199004)(189003)(33896004)(81166006)(103116003)(316002)(2486003)(23676004)(66066001)(6116002)(3846002)(53936002)(68736007)(58126008)(97736004)(7696005)(52116002)(386003)(6506007)(8936002)(230700001)(106356001)(5660300001)(105586002)(14444005)(25786009)(47776003)(50466002)(76176011)(8676002)(7416002)(81156014)(26005)(7736002)(186003)(39060400002)(956004)(478600001)(476003)(61506002)(6666003)(446003)(2906002)(86362001)(9686003)(11346002)(16526019)(305945005)(55016002)(486006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6cVBUYnVRSENTSnE2enNCYmxQekpKNGZa?=
 =?utf-8?B?NGNVWHVLWmlsOTN1UEI1bnVkUy90U0FFT2o0VjhiMnhCcjR2OUlPVkk3SEMx?=
 =?utf-8?B?bVB0NEFFUFczRy9ZNnhEUjJpbFF3UXgxZmVHTXBZQkJaaERJcjZnT1JaQmJ6?=
 =?utf-8?B?MGRibFF5WGIxcnZ2VGxYRFAvTk9XajVVUWRqdnl2VDRCYjlHTldLb1RwNVNo?=
 =?utf-8?B?MTVlSTFUVGhCNDhHRDBBc21adm8vZ3E2bEF3RXBBcnM3ZXFrdDczdTZUMnNX?=
 =?utf-8?B?S2lQN2hKT3V6SGVHVUJXeGxGbkRyS21KMTdkNDB4cGRYKy85MUhKSnQ1NjQ1?=
 =?utf-8?B?dW1JRTRMS1k4MThjQTdhRFZYU3NWUEVia2prNXloRlZiaiswWXNmRXpDTVNp?=
 =?utf-8?B?Tlp6Vjh6VXNXQXpuUGhLd0xEendsUVZCcjU2ZmFnd0YvZzlUVjFGYnlXZ1Nv?=
 =?utf-8?B?VlVSeUdqZ2Y1TlpUWkVOVlk1TjZDK0E2YXhiQ2VQVzh2NDlVK0RaZ1JzZHBG?=
 =?utf-8?B?SFpwMEc1MXFmdmZDWFdRekdUR2VSM1VtOUFoQ2xVSG1CTjVEZHdrdWdIY1Av?=
 =?utf-8?B?RGRxTWZtNWpGams4ZFFteEpyK3BWOUowUjc3WVJrN2xoYnFJMERXL0pMUjRt?=
 =?utf-8?B?aXlRWFU4Z2k0QVFRSHlTL0xGVXJyeHU2QW9FRVlXTStOYm5nUzhIT0IzVmFB?=
 =?utf-8?B?Z1NadGwySnNlRlV0WjFOU3JyOFFHZitVNmlFZWpYeFIzMGI2SFg2ZERheUt6?=
 =?utf-8?B?dExCWDlzbFBuT2xZeEFwWlE3NEpWMGZ6TlZrSEpwbVdKeUp4QnVZS2RLR3BS?=
 =?utf-8?B?SnpEdlRXdkxVelY2RktNQU9pM3AyRkxBRTBodUVxcU1xcjl5cEdpMlNucWJu?=
 =?utf-8?B?UTBUVWZhK2hnRGNsUjFGSHFTTk1xM2tMZWprSk1Ha0gwVTFuM055VWsyYUt2?=
 =?utf-8?B?MUtWNGRNV3JGQjI4ZFNCK2FFQ3pxM21NUEkzTGx1NHY2ZzFSV25RcDgvL3J2?=
 =?utf-8?B?ekthVktNb2l5SkdsSDFoZXJUVTNFZkc1OWcxNnlYak1yRXpiUkY4alhYT3Q1?=
 =?utf-8?B?Y1QyVHhNUUdlR1hZTFB6YWIxWUQyNFNwdFNXeVRkbDFNVk5uQTNHMk15aFEx?=
 =?utf-8?B?LzhVRzdTV1ZySW1xckg1bDVUSlppdHNBOFlnQUhlaDNBMzZJcDBQVVl5K3Iv?=
 =?utf-8?B?R1hjTjZyV2YydFdGL3pGK1gyZmZIa29VUThxMi8zREs3RnNMRUFkT2xMYW1z?=
 =?utf-8?B?V0c2UHBYdUZrRyttbUVXeE16dGkxZGdNcmxPOWp3b3NiZlFlYVBkNENFVUpk?=
 =?utf-8?B?akdmdlF4b0NkVGZia1pKRE9XUDUxYWtEMnQrWGFpUjRqeUxZcFpkR0xDWXRF?=
 =?utf-8?B?dFV0S211Vk9iYjhlOE40bHlYZzBpOCtCaFgrUmNIUlJBS3krcksvb0c1SHg2?=
 =?utf-8?B?b0d5TUcxZ0RYdEVLUC9sS0c4ZDdLaEszeHVJb2hBakRNd3F1alpMZlJ4MnNB?=
 =?utf-8?B?aGRYR0RDdHZtRUU0cEpnWldNd1gxTTk4dkRkaVNlaUllWHF0ODhPamRROEhG?=
 =?utf-8?B?bFgxbENoVThMWm1WODNSTm9ueHdtODF5R2owWXRBY0pmQ3lhNkdmUDF3UjF4?=
 =?utf-8?B?aUtFTUxNTEJGZlZ4U1RCSUVlOGxrRndwSUJWNnRtZUtEV08rNTBEU1lRamgz?=
 =?utf-8?B?aFRtbWN2SEZySWVMcTVNdTdvei9pZFlhMnF2dFFtVnZQY0NKVlJza0NkMGh4?=
 =?utf-8?B?UmFlczZ2bDAyZFJBc2ROZS9nPT0=?=
X-Microsoft-Antispam-Message-Info: hh+8VeNEhZHqRlXyox61k9/jHFVG6nYuNHcZ8eAoDOKS2mLLwlrK9GAEdEmU3DFtb3HvHdgSSQTIMVA49Gf2hquonasuCh/kgx9RAiooSa+cSNX0p1KNw2hfpnjgTSYTdDSBxItjR12ZWftZpVikSYtdf8AbZHudw0bItlC5adhphrbGKHtCq2NDBZGP6ZP96D6r+zJ0Gb5Dkj8qxRFDAxQ+mtx2gj35dIKjvCS3EErn889OKIbfrhNAiNCfayEl3rH+KfG2llejjpHOsbVLOE8zzmRfXj6v+r4gdtBlEnlxS6JF6cj6ZurCWa2CHHx1Yb5pNVewLQxIivZSSipw6e33+mBFlZTRYuRHHdKG3Ss=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:pZd8QID/+6vdb1wZHFm5SULDA71fRrV6APf6I/dThblvaQQAJ9qek1JcAMU3chggEJsVRB7Q+Vms+fIgY03LLtmYTk5GWz8ZoxNCIp32slRNLvA66j04OdlUtT/PunNPWVqI/tPL9lFy4o0H5SbHMWTcP3qQ1olExo93cLjIFoAc/9d+LIe3l1V3YVweDedZRIznxW/IYvZf0q37iv2tQhI5OOBLh02WmkPy4L4LTKWuA11xg6J3OeI9HPrPHJkwgJ0B48bH6dmsn/F78w2sZTGBHLKrKZ1irfTSS4teughDxzb/aHbRHzmTu/Wavgqqb+EXQzVLUFe8Uc1xaVx4j66YmEvHdVGq+noBneD4LQm8BbCWCQoyodKDAI5EbU3MCTVYjt21omTWvXhH8j8Jcgx5R4abGe17tFICM3spw8eiyx/qvIqwuT1ASWCR+xzkgvKa4I2hbMyrwKC2w4DfyQ==;5:cDzTPi5/Imwvs6Kksnoz1Aplz61GNvRRJ45qCSyqf+/nmmyZWs5dnk5kMrs8kGwC58Y5gFmQ4QULPWmyMlnQIDMoHjVANGz34/gJtPwjIdMOCXLaIsHFnGuC2GzbPTeTzVWqTY5csBKynoJBKqa89eXFFzvlPYDUeeg/QuNAqZs=;24:AmpzhEPJA/Fitc9gLgJQ5XZq0qqNXfn47wyV/uHaMBTDM4b6TGgJEAgkXvqXWlOi2Wkrwgd3dK7IkUCBO9kMNlnjMc7Gcs3EoD0QR+WJ26s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:7/F2zR7Wk7zoBJ9CxUEbc5kT3unO0YqF0I5xg8CeGlQ/65UiHxgjYZgrjS+lRTWbfO9jcumw6dRwOoc4EMdQMXcQ57h9yvOq1zJo3vbfdDCbPz7sFmDqX+pK7eS9SM3dPVDkPmuQ8SNe7+yyV5+cNwrFbdZN2vbt6hxsP7oiN9ff9//HjGvZoezyQa+qRC2tQHXVJVY6dnW1VwhcG/Eua0k/QLbtZbpmt7ARRrm/r8R4j0+BiowLquslhclGsPN7;20:G6gRajAb/zgn23GRbJCs0tJlQcXrhvT9LR3r32ACTwW4ql56JbnlWfNHb3U7MDRnjkfL0Q52gfUXM9JE3iyNOpFDnuDZeVbvCE2hFSQCz03BJne3O0dGPon+tcc1pGw16do3vv+w+p4zXOFE0rAcBBlWG74LUmD1HG3kJur2fG8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:38:35.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6dbedc-8d3e-4abb-82ba-08d5e5775d69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do two list_lru_init_memcg() calls after prealloc_super().
destroy_unused_super() in fail path is OK with this.
Next patch needs such the order.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 50728d9c1a05..78227c4ddb21 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -244,10 +244,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -265,6 +261,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:

