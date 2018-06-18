Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D64C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D920652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hag+g9mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858D920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936033AbeFRJqb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:46:31 -0400
Received: from mail-ve1eur01on0120.outbound.protection.outlook.com ([104.47.1.120]:45240
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935940AbeFRJq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp5x6zxP9xbWByxcLKLerqcycSeJqMD9HD2opBUN24U=;
 b=hag+g9mgGv5VoiLrTjw+0K9doWHwY3fr6seC5S+N0ymQYX+LR77YLGVF11cPfILdrUPXcbafgOoznu0uzKmWsV7nkyfu1N0CJ3pcOYo6tjOXNTkgsRjIF9qK/a1k4s36VJofRL4H0TmXDshkmO3QqwGU2KfNm++Yh6BNCOCYBDM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 VI1PR0801MB1342.eurprd08.prod.outlook.com (2603:10a6:800:3a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Mon, 18 Jun
 2018 09:46:22 +0000
Subject: [PATCH v7 REBASED 09/17] list_lru: Add memcg argument to
 list_lru_from_kmem()
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:46:20 +0300
Message-ID: <152931518013.28457.11886844069560873308.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:7:15::27) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fefb7a7-185f-424f-4f94-08d5d5005ad9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:Q4ulEhARHI7Q4jtXcabEWr2KYjbZejvhWrUj3M9eyCWyQ2Ym+RXO2CtDI0To24QoJRQR6uC7hdsw5MH1UXZ9iCwUxO7Oyg1L/HUzJNLaR41VRpvlj+3xk4YMyZMgoEHRnqXjxba+A2Bsz5ayhlSUXdpkz5d3AI3ANazyf90lKf7Ig6q/6Yg3npZHw9eeDww3XBBxgpY1nDklac5Ms618xckHDXZs51iB9fKu9v8z4N3SH3ejRVmm8v4hCCetlT3b;25:g+6egeOaESU1AChAQkKUasF6kis27ICksH8t+EqLzcNM0OJ0Lp5ZBZev6LWHnHw3k2FoHYz+5ypPjMHWztu7pumIpk9P8VZHa0x86FaN5K4b1YfweCtiBcQ0vS3FUswDRUd9QM9QvYCbhtja5t8zWXov9W+SDYFKGaO5MnXFvLA+9jQ4BHJZRdh2yLI6kNf+vzfpfKbY68ctY5mn4gyviiwoQ4NeYjL15DOAKYttD2aVzxbQJU/T6jWjoBTf4atwQBQ+XnesozlsYIOs5i5WJztl2Cfo/EvSFPwXZynNuB9/YhvbwTRDOxIuZnoBg7eCKySOliANrGSUGLNnByqvLw==;31:APQOeJMAUN5+bLiggKI7Fm3UqsuysriJ/UiNzl5/v/tdBAB5S9YYPlqedH54IzwYyw5wc43fsFqLE24zthTI+9qXfoQQt4ZMoxC5hcj+bbSSFPygOQw6CKxmfrlwIStzSHIC/ukkSY4lw3UMMbT/EbzhEHoo6dZpROGLBheAIOsm/EdbkoUOr1cKL215Etd0SRd8qC3ySK9uq0a1hW0Eejg1UrHEmBxV/pFLmMEbpG0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:2L8TAiZFxcaF+jriz/VQlDkqF8hf6sOhoMtVNvcwRTuCcUthum/kmm7UuFz0gWdAb5DYF6OtRBYli9kADl2Vb2IPAAj5TVigJLnl8/7vYY8qzZGrAHuYq+fgWEf+LGU08ze60d4ROLRO9IIDsciap3lk+4eOUA8fEyNrzVMyTspKLkp63hYsjQcw3mhILYqAVCz4dyyTv9eyPci2lFoZVYsxQSbB6aE6JIWvD939qnKRQyCFuc4w/vxwOk6pG7GuGKCKvpPMDVy9gDhSkjKbdknXoDOSGA0oDSjIxit5hZ2FRGCUZahr/GmhkxqUo7FpnL2dVmWXFu7iz7FiCefl4tOvuBBwi7zOjUNOO9cSpPmtY2tJceyucVbUSKU2BeFRDTlPecjIAzRr1CEVfVyxyqObS1O7h2rU40EXoSGZoTJSy9cvJqpjNITZHtngq4ul+SzoCzuitvETJjj9wInixuB6EALHajixNPmXFy2VZACeL+DBTYEniMwTgNItOhkw;4:25eEiHTajR9GstaERq+fD553C4DFyBK26pmLccoDtFU5sdAmCPMJn8vAm3DvFelKmez4h3c7fcGXHmkL54+oYwau4uv4wQpH/dY4+FE6c5UnPVe94kS0ouhcHhWGplX7w7+HvsroT4BljS9ykJlJO49jttfeJD+CUDx88hMaEAAefVKQKAj5LjHbt0xbOZlF6zfmbY4YzBszkaEz+CXVGEq3IopgVByf/Sm30KgVcLEeyHXRITzzurhp6Rh3PXYoafskIW+LSLQoh+JeRUaxy8GUmHsi+9t+YcRgOvRJs0I4NKR3ZDbYh5c2SJETceI+1UUxXTWQWMzed1zgwfFFWVI3JhUTJU0FOWOuDS9F2s0Go3E7niy2QZtDmsJKSt94
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342C5C4B26D5707195B6F50CD710@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(366004)(396003)(39840400004)(376002)(346002)(189003)(199004)(25786009)(106356001)(66066001)(47776003)(39060400002)(478600001)(9686003)(61506002)(105586002)(97736004)(8936002)(86362001)(50466002)(81166006)(8676002)(81156014)(305945005)(53936002)(7736002)(446003)(11346002)(486006)(7416002)(956004)(476003)(23676004)(76176011)(7696005)(52116002)(2486003)(68736007)(186003)(230700001)(16526019)(55016002)(386003)(33896004)(6506007)(59450400001)(26005)(316002)(55236004)(58126008)(3846002)(6116002)(103116003)(5660300001)(6636002)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6SkJnSkZWQWRYVjltM21NZUFncklaUmpu?=
 =?utf-8?B?VFNQZC9HeFlCb0tlcFBrRDJueWtNbGw1Q1dhelAwWUZwcUlzWDcvcFA1MkFO?=
 =?utf-8?B?T3FsUm0xYXM3cENhY3dMZDdGVUR5d1hNbE03Q3RMMTh3SUJITFo2ZnRzRy9o?=
 =?utf-8?B?TW5nbWFBeFpSMmpBUW0zREEvclVQQ0o2YmRrdVZ4S3NjSjUwOUR1UG5mbnN6?=
 =?utf-8?B?cjd6WDRrQzNNZVA0a3BaZno3eVpBbTRvWlF3K1AwZng5YzNDWVRjd0xVNjJ1?=
 =?utf-8?B?YXp4ellnY2tESTJRRlRmWDJTTmUzeEVwdzdSN0tBRzRtMmcycmRGRjNqMnFR?=
 =?utf-8?B?QnpkVGlDRElFZ1NHQ0RrVGVuUk5obDduTGRMYThQOFkraG10UVVCVjF5L052?=
 =?utf-8?B?U3dtQ3JETU9OTVhVV0RKQXlzZU5Nd2JvSkV0Vzd6Q2trZlJjbFFqdFVieHM2?=
 =?utf-8?B?M2hLSnp1WTZ1NWhQTG96aWFqck1IQ25QVldjV3pLRklPN1JiTjhTaFBINTF5?=
 =?utf-8?B?eWdZY0dXcDl2Wi9CQU5NNXFVN2k0YU9zb2dmVnM1VTZRdFJlWi83RGJOcUc3?=
 =?utf-8?B?djlvRkRDcGRMc20vaHRtM0pBUGxwUGI0dXN3dHVMbjBSZTdPRjE2UE15MzZN?=
 =?utf-8?B?V1hwUTZVS1k1VCtwRWQwSloxMVZEd1k5OEFhWUNFMVpSMzNrdlFZYU9KTXJy?=
 =?utf-8?B?d2pycUhPUGM5MkhHME5hTGhad3RKWWJ6NGY1NlIwUzU1cE1TOTZZQjRCY05X?=
 =?utf-8?B?TFAwK2xTbU96QW9VYnZVZFpWYmRtM3RWM0Y2MU42MnVWOW1TUE5CTkZmU3Z1?=
 =?utf-8?B?dmJPYncxbHBBWS9HZTRNc0hVSGtOVjZCNmFwa2ZDcFArUzAyL0VDUGREVk0x?=
 =?utf-8?B?YzQxczUrYnRzN1ZBWTJJZTJ1aXpqaUlEUUNURjI5YSthaXFBVGhlcnZ1WDJz?=
 =?utf-8?B?akFjR3phMnNuTmVxNzRRTlQ1N1lrL3hnWncwMkxMbnc0SFovOXpxYk1MeGtl?=
 =?utf-8?B?RWdZT3hsTEgzeHJMM2loMU10Qm5vL0VET2poVytXTmlLeHYreC9GRFB6TlVQ?=
 =?utf-8?B?YU5BaW9VT05PSmdhMzBZbjk2eDZyTnU1NklnVDZxVUJMVmF5YUdjc2FHUHhy?=
 =?utf-8?B?aHhKQk1FUERYSWlSN2ZkOHREMjVZQ2hXUExVS1U5R3JkdysxcVNHZ2ludkFF?=
 =?utf-8?B?MUdpTitGMUtkblVvbFlVbTlnUlIvTHJwaUNIZENNTWxaQ28zMHVHWVptR29M?=
 =?utf-8?B?bWFUZTBTMk5jSWZ1cVEzMy9WR3FHczlJeGVrVTRCT0YxMzJHOXJCekpIYWFL?=
 =?utf-8?B?OFEzWmtKVGNaVUtXRUs5bVhseE5LQ2NXaG5SMjFMbnB6Yzl6TTJyMHZkcmlT?=
 =?utf-8?B?ZG1Fdk00Mk83Y0dBMmkxWUZUekNXSXAwaEpuWU5LM1dNSmdDSTFYWjB5QVpS?=
 =?utf-8?B?K0RPUkpMTTVsaTZwRUVKSXVYTmxueVNJc3cwZzJnNTI3VTBEOXVrNE9XTEhv?=
 =?utf-8?B?NndGMUxidGNZakErTmVMTjd1cWVVSTNpVUhOc3hvWjlwemx6YXNPeWt6TEw2?=
 =?utf-8?B?elVXcHQ2YnVnbE94alZzYVk0MEZmaHdRU3hSUGRJbkYrOWxPcVlQWUxkeXZB?=
 =?utf-8?B?eUltQTh3QzNLbjdkZ0xGYXdSV3I2bUxJcmlsMFJRYkcrN2NCSlZBL29TT1pu?=
 =?utf-8?B?S1kydGJMVHpOSmI2aUV2eTVGMEZkQmYzbEVDTzZUVnMrTldMd3ZBTytVN2k0?=
 =?utf-8?B?RkpydWNJKzVKTkYvL2tHLytJbnJvS2tsa05yb3gzVUxlV3FVUEdWSElsUDdv?=
 =?utf-8?Q?m24wTbpwDVT0teO?=
X-Microsoft-Antispam-Message-Info: /xy7QhH78uawalC3xBpuzEsl6eh2Rm2uvFckUmi5pLhySRlU787wwlUznaYM8ciHU+lkM0Bc/vt5J/MTlfGGhggeRhYJTTEGdCycEmnZvpqajdDpGpG1cbr41H2QVavBw6yERqRZtliLdekLsAEHqETdpnE2kcDlK8hvzj2M2bExjVA1Bqy/Baz9+VGhxTqzmZYatdRsSm/SjI4yvnH08Bo31Jy+sfFOJjZOjQUYlBEDshJeP1SnrRGnHo4YPrAu3pKiAqi8QZiHcvFAQoyKo9fIofBMKkGtlWXQGYcf79sLHhLEIrSP9Yaplh8OErwK
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:EWZdjyaiRQdkBUrqfk3B+PMK5SVfC8GmjYfAWU17e2Eg8M/MEpyUegyOSaNt+DbRoPSuFVnEzgtREcucw7FiQ7GhqjOXaJ7ZdS08RFC4iHWWOj4OllPJ51Vv/PrMZ/kq8W80//WFeQtrfKpRbAn70BvqZdFHhujIPNkBLV9HA9i0F2NodSHkHRouWRHH0D9/ekXEQcSElWXB7kHD51kaQq2bt2+N6OL99PWpWl4JL329vJJ3+mQD+wMEEcj3kTAy7rrTS+149pdbAhbd8tmGJ1lrWJKLzYPxV62MfZo2XH9FR1vJPYsr50RMjcL4lxYMx/+ILvtM1dVlI7WZwmUwjMWCMMCAGSvaQbzuYy7dciT0/zmmnM1xXa9RZNFdQJVWKIC/Vg6+8blcsqLbJrwG2sauk2m/3u2frzBQ9nh6e9Hp/BOnZE2rFpKb5UglSDZniYQNuiD99E6cKx68JOvPAQ==;5:uurzPrVGUgq9jgDK4wmeaeQClr12ehHPcl9n/z4WoGxpDGSHXAnuurKiU9qSw2c4nt3MxV/GloEnhsIG2gemPERRrmgiIDXBx5EkTaowTLjzvwTgWNptHj/3LmNJLQVWbAoH2DLSprki6sVe/BreTyn9ta/VU308L49HZI+mqJs=;24:FX4KkbsB4O9LLS3XziXs4wGtRcaaNWqogpQ0Cvf9CAIEE/tDAY2psHPl2eD4Kyt9JI6JKPc4CnjBHaczW4I8vNDko4ds0KX7SZT4T6IbIqw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:k2eMzOciHQBovNaFHrB2kXCCN8UFojWLqbE8xIMRwZsNtFSLAkTYGNNwaw5aHIMB8Zur+lHJCP8WA0yoeNEF58KvWySoCuDO13XFjceK3dk5qmJWgSawtlEisjM0cPgdOLppqlW9Yj4My768wGHG0GkbjRROrxR2OkdCjZtKU0mn0+AVkW6aeuzwRhrZMW3Skh85/JyEkeovI/v1xocZ5waEn1C8Z10EX95AgWX+NYOpf3oRp22cRo/y7F8QzlY0;20:ny1JLdtfWsLtETdEe58QeYmtK8LizcVNElHAczzP+JI2mBVJvozcf7eagHs58DQ/bFKaJbHoAvDykoB4A8z/i0HhxrcrEiUScS+Dm2D8Sr1lFqgn8+WEu0JKSJYNOILTDe8qi9BZ0EQkRAIyyGU0okYBhRxmUJDmPVXqQPcQqw0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:46:22.6066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fefb7a7-185f-424f-4f94-08d5d5005ad9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 077956f8d58f..55a76465f7a2 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -65,18 +65,24 @@ static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
-	struct mem_cgroup *memcg;
+	struct list_lru_one *l = &nlru->lru;
+	struct mem_cgroup *memcg = NULL;
 
 	if (!nlru->memcg_lrus)
-		return &nlru->lru;
+		goto out;
 
 	memcg = mem_cgroup_from_kmem(ptr);
 	if (!memcg)
-		return &nlru->lru;
+		goto out;
 
-	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+out:
+	if (memcg_ptr)
+		*memcg_ptr = memcg;
+	return l;
 }
 #else
 static void list_lru_register(struct list_lru *lru)
@@ -99,8 +105,11 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
+	if (memcg_ptr)
+		*memcg_ptr = NULL;
 	return &nlru->lru;
 }
 #endif /* CONFIG_MEMCG_KMEM */
@@ -113,7 +122,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_add_tail(item, &l->list);
 		l->nr_items++;
 		nlru->nr_items++;
@@ -133,7 +142,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;

