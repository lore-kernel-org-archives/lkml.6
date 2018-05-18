Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrDW5PSY4nA12F9AuzzFNAA9lJOuqkMGn1L5esZy9wsdZT6U0bnX6ms//orXXMh6YrWRCdw
ARC-Seal: i=1; a=rsa-sha256; t=1526633067; cv=none;
        d=google.com; s=arc-20160816;
        b=Fhr8DDQTYqu2QkyC9YRbStj8bvkffE7rzoa9BVNfT5aCKRMZFBay7RtyvgUzCX3WGb
         HSGm3pyvnt0JUu1oFwvw6QmP36vkSTNFU+pQzufYt1uaJ8tMMbRaLKdpUbBzXVxdw7l7
         5BjGNwV17DUdqp7y+RYSKX3xGX/g6gXNUMcrGtyz/w5qJf1G4Flbhat7CtYnmRUVXEid
         Jk+pzrZ1ZX4mZ7tWaqwe8nRpLdGKuJfITWCc9kSSnPUkc9aNo4Oa0xASsfQSaSRx3aQj
         iKr5HyOmS0K1fxQgDAUz8DE3nNm/h+bqv9k0qrDxJrp9SzPZvIsphgNhB+EW3E9+PVLt
         bJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=pZEIKPJMNER2+OPwDROMS4u39DjnCMBJmadM26RI6pY=;
        b=WIFZhlqWQURmgca9f4730f+ja6T2oWcpQI8dLpp224aOJ2RQDcdfeE/qqCeZyUQTGy
         IxYAckLYsrXkL/A2mVECKB/6GyYLgz60D6nAVI/kBxh3flWPrSudl6+w6LzpFqtMZnFL
         zd1AWPF9dGyhyD0z8mwhgVA1NSAeOhD++zNF6fDJsHs29mOVeFFk+BwjZWwC5Mi+DvYm
         SbowjmmuaQbmZqrWKKVjZ7Im77sXJPb+s8dCShe6xd/JKAnEqURR9wHvOTZSepLMn75Q
         JyczSSr6Exp8Kcl7pU/xyOMoGQ4KzpnBKzdev0lLo9mZVWFDYhyjGabc+9bJMRYyKGoT
         gOSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=d1cudF0E;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.122 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=d1cudF0E;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.122 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v6 16/17] mm: Add SHRINK_EMPTY shrinker methods return value
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Fri, 18 May 2018 11:44:22 +0300
Message-ID: <152663306223.5308.4934186553719870551.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0046.eurprd07.prod.outlook.com
 (2603:10a6:7:66::32) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:S4pkcA1HngBGcecZLYBf+WTM6QK6ER4afILZJ9DmXvztHfpxjAmm28n2Z/rxtqKGXGDxjuX0gospM89y6mtoxn834TEKMfBWwiqDn17QkcJfgXZE/aKs+WEwIcit3FUtuCJP7c2P7+o+V4NSlc2fOykxyHaZ5SDpk/6Ki9+0/yk+My3SJz6FMKrDfW7M6AMUp4sCR9NvlOVrblB3ceMHrK/RWqIxYJjjcXeVcBYsRXsRtR6BONd/jC4dj1P9joD+;25:1P+G9utiWxoV9dqyobAgGdWu88f1pB4PEqkp+VT7G63dRR8eU7KbaUizwjwCtjyFdWJo36r5wglbidy+xXE0iM65sllvWvakcCO+7DqqeppCh2SDU8XD1qK2q/i0ty6pzKcphQAAio4ktYRijlDdYfgAT5L+cur01oWTjVRAHXWKKKr/s3LP28TcDK7NFL1lNN89trrf6ypQi+T/aV8VdnFD89CGrQ2qDh22XZ4ceOb/mNEfDNv2Ij0X6d/HWWfiaaeDrKCVFsP1Z5RwPqi19INysw7eJh9mqCw7OV4gLhSC/eOSdPVo58XJ58HUJFggLhwENqG10+Qwybdkn2xs8w==;31:zND2jjhoGNHWQeQCIgf4R1OX2ZFmaKnEqBJmnmS954wNrUOaQPO5QJLA7npoQrHm2LnCPIzf+6jn+SkLIgcy4eSD/ugDaEfWIkzK1wPMjnR3P+w0L69MzBZDoRBi1GEJ9YvQJuu2W/MzaQNvl3PGECOtBj/8PMY/80hOMLuIgo+l2SJ8AFhuBHQnv5DCsZoaLpWelAU/cmGIxjNFFZC2M6eamgMVBd431iA0LtAdxMc=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:rJEut3Yi//nMv+bK07Z3km+UO5CDHaxGMV65IUQuEgCNHpXabJQV02BHa5PW+FeE8+yxq982kWdoGDiflQCjgpIWbpwpFyMN0d0OlkWczbxbrLQtQXQmwIUNul+nuyw3iyRn95F7PmYsXZk09AgGhzZ6CdDm0j/E5gUjuTYlieWCmdQZeyVmmXmaVPlc9BxN8McDIRPPZrYN/+ZMRb2x0rmyyrIjH16s4q8SFqSFFnoPsKSU+YSfvqmlZzmIhMpGUQmK3/vNaKPH1uKL0j5oNJXxasoCALZjnpgGwAH655iREhxhO51XkW7ojU6yimvxJ3kJAjX9L6w3SiCdayhcdZ1+XBOXODpOE9q3Mf0xABLAyMN+mscGYFwGkEcPaVhWmAW9veew8D5YJVRaXMiAxJqsuE9PODXXfn5CzB/WU1UONzXLiPIOuwduvlwPnDEUmXmkZ1SWXlwYeXQ06e1fhiDc1q7AGrbU46LBGrL7tYb2NE/1WT20eAp4DhtOuxax;4:kAM0CyRqAtWwrO7XLRU+oXZFeu8/r19Gsk/gmp0olualMTGrBuA1Ko1mzoSNkvISN62Do7tgQu0c8+oj3bXE37KdQIoDpiy742eAuTQr5uwj8Yow4gTfZdQ+XwPqorr1cKStgq88BznpZqTYJ62E0626HMoHgAcOld6mXop/yJN7xFtZnQNFFWhpqbPR9gLjPJKOCevqf3grfimds51AZP4auK2qklFoNxq0n3QgzVpgT1XGv3Vm0y8LOjoTDDxj7lblGTW37GyHH9PLfjFSNQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339E603E463DEE81300DEC4CD900@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(39850400004)(396003)(39380400002)(189003)(199004)(230700001)(97736004)(386003)(6636002)(6506007)(316002)(58126008)(16526019)(103116003)(7416002)(5660300001)(186003)(105586002)(106356001)(52116002)(7696005)(2906002)(55236004)(8676002)(81166006)(81156014)(68736007)(47776003)(575784001)(53936002)(8936002)(86362001)(76176011)(59450400001)(39060400002)(25786009)(23676004)(33896004)(7736002)(26005)(478600001)(66066001)(2486003)(956004)(446003)(476003)(50466002)(486006)(55016002)(305945005)(61506002)(3846002)(6116002)(9686003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6bEpuZDMveUlWb1pFTnQ3dm43bGc4UW1t?=
 =?utf-8?B?anFtWFNOWGpVRWpDM2RkblBXYUROL3BzYmk1L3VPVkF0bE84S3pGeXNxRTlX?=
 =?utf-8?B?NktzejRMcHQyM3VCTGI4ckgzMGZrMmpyQkZybFlFMW0yRVlkZzBGZkE0a1U0?=
 =?utf-8?B?L2RpZy8yanJtMlY4UjlNY0NHb2FjaEEyMlM2bjlHcVZYVzVWV1o0blV2V0JK?=
 =?utf-8?B?b0FRcUJDTGFaRTI1bXFtMG8wVmNCNWJmY2RVbXhXcTJ1YVpScjQ5dXVaZm1H?=
 =?utf-8?B?dldWN1VmVTR3V0tyTFdHMTFWdWQ5ZjRqTXRzN2FGZXM3R09xKzQrQTExVkh5?=
 =?utf-8?B?bVBBVkQzRmNRZm8wdi91TjJzcjlBSmlYUXhEVjZNeWZBZEVxVzRNejZ6b2JW?=
 =?utf-8?B?OGxUTlBwdmlzWk9wMnhSN25yWnYzT0x0RTNFaGFZeFR2Ull0VS9MQ3ArV1hM?=
 =?utf-8?B?YTc3ZHlwaXFVT2RsOGtYWm5icFR3WTcvTm03WWY1OG5oNGMzS002WSt6dVZM?=
 =?utf-8?B?c2w1YTR1OTRZQ052aEZpQmxDZGRWcmg1WGFidDlKVmJqZ200b013bVMxbFg1?=
 =?utf-8?B?Y0pzTks5T2diWC8vVDFRUlppQU94c25nRVFWMEFST2JMY0ZiK3RmaHdRMEh0?=
 =?utf-8?B?YXc0eS9oN1NoV05CQWFKN3BQNGFYbFNCSzUzUWlJMWNDZzdOVVU0bjVuMGFi?=
 =?utf-8?B?YjRQSi9mZzVLRktOTnFLbk1tTkN2MnlobmhBQlI3OFNNcC90dXYxais4cEUw?=
 =?utf-8?B?WnFEVytITWQveThzWDVHSmJaWHprWHpQb1paTHp4YXlSck51eWlmYk1ld0Nt?=
 =?utf-8?B?YjFmUGp0SXJ2VEM0T2hrZ3B5cmE1ZS9Gd1JUeVVnVDdsNy9sTVkzNUZwQncw?=
 =?utf-8?B?RFBLK0xCNE90L2NhV3RPY0lSWHhJYXBseXBleEUyYmxhUHB6Rmd1VVhmQkl5?=
 =?utf-8?B?R0g1R24vMjNBVjhBKzRpZ3ROR1Q2eWVmVFozM2EvNDEzN25SdDF1eUxMRjdT?=
 =?utf-8?B?OTR4K3h0OHhLRDA0NGdFY0swM3U1bDdWZEYwYXpENzVnTjIrSjBEZzM5VHZY?=
 =?utf-8?B?RlpnR2hXWi9PVVJyczB2enM4YmVsbndQcGJmSFQ5UmFQZVp1UjQ5SmlJUklM?=
 =?utf-8?B?ejRwTWR5SWFkTVVJQ3J0U2wxRFppVnZMNkliSGViM2RqYTU4QVIvcStSajBK?=
 =?utf-8?B?dnFSZStrMGgvOTNDcmE5VkNYSVVqc1ByL2MrdVl5aUY5N21CVHVQVWp0bFho?=
 =?utf-8?B?WDU0VXdrWTYra0JMTk5LNDQreENFbVFWQldldVZ5dk5INjdodWY1SjNtdUFH?=
 =?utf-8?B?YmRrM3ozMWcwQWNiQmk4aHI2WWx0ZjRZa2t0RHBXR0Q2S3hra1BBZ0FRNVE5?=
 =?utf-8?B?emhQMS9zM3lQQWVYZVlQWUVBUEFxTEw0MnV0KzZwOU9pNURKamxoVUw2WFNK?=
 =?utf-8?B?eUZIM1M5NVd1QjA5TXJyZW5nMFJnNVVGZjdDdEthTmJBWnNJMmpPRFp6T3My?=
 =?utf-8?B?Y3kzVmlKOW1RYW5yeW81bEs3OHc0UXBWUWJDaE1OTkJxeXlIbGN5eFBNYlRT?=
 =?utf-8?B?dXBqTCtTRVByTjRQU1JVSGdRSThhV0cvb1JzMUZEN1UydHpHWGlrMmFKS3pH?=
 =?utf-8?B?YURWR01lZHNjNW1SMk1OR3FxcytUZGhYVUIydjdoc0VyNnpuVWd4eU9ycTR2?=
 =?utf-8?B?UzFxTUdndnVQRlYwQjl4aWthWFZhV0JMbkNNc3hjS2xiQS9sR1JITEE1TUJH?=
 =?utf-8?B?TzY3Qm92L0VJYy83MVdTQmx1Nm9aQzlnU2h5eC9jZThONENVMC96TmxWeTZt?=
 =?utf-8?B?cTJzTDZIMWtUcm51YytRQXp4Wk1ZOHhaRnRmZDdyWThGTDFDZz09?=
X-Microsoft-Antispam-Message-Info: tG47/eMzhLmhafjt8kqYDPuQqC6c81OcsTcxSWyl78TqziB1ZJW9l2VocUbA98FTkvDSOcnvVtUV1SJ2qpApuWe2EcPDP4t9uojcDQaJqmumOv8G4ZpxVtrBVl3w2KZAwWVoCNrAb/iCQ9FVftY6S1BVZE6Ht9UhZwupo2hAHhc2VaaB1M4f2KMJaOUtEgb5
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:iWdYto0Xd9zEplyremrAQSSUu8BxkX2doDoFz/vju1qHtq4JWwGJ/nZ6JY2xhUAu/5nprqK4Y3+hqUYJqmiYppLRJ0dl6TPsbx3h/Sxk/7KIrcsJpxSHPGoObyZNnIb6+w/jov19LIgZ7d/r3hctJEIjf2SNOfI8l0m1F5w/1svdW0aHS3MeR2w3SwS10SRqn2M2pmAGGN78TLKZVFy4811MZTX0R1cRl7Fy94BExNWgMTAiKx4mTwrHUT0Qzv51QfXNrljERZK0HOIeBs9wMinjWmih39hiDigsWdBNNtGeIVYQ93lYIkQvqfj1LpxX8KetpXO1NKfhXiWRr3iyyVGBMGo/lmCV93uMh7LmseTPr/ORgxZW9fdvFs5DFBoJk+z863kpP9YE3Msb2HPK1ChajT5TytXO2eeNEBYjlhvG+4I3igfy9yz2JhKaDLoW5nt4KI9k/dWLwpZP+g2h6Q==;5:u3EXcYzWVcUbidi3efcCs3uJNiy/8ZJq6GotDeOVzcMGhh9A7/poYmO1NMFkW6PMe9A3mQHCYKNJV/OWvjxulYrYAZMUUhXL+0VvJz841eexBjRhFvBBMODGn7gQllNJWMPMK7zyMtHX0HqePrxmAbGFcsxTVBWCCXvL7MfB/GY=;24:/P1XEJKWJMmRvyQYK1jPDnXAALO6efXCgisTNPIYhNc5Wj7MMRUFci8fmLx793aiUnxBlpS+p6jCTKvO5aiHKeL4yLnL+I7JU071m3N6ldM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:2g69ZRsZbontyvkjD6ozfGjzmJKMYfxg39AbcM2G9lTPtjX0O2aKYaKY/l+gcojD4Skf7Dxu2gGReASZmhPRQ9M8+0479ZZTbD2b61gg8gqkdY/yNNuAoqmGrnqapBhtOw94OZNEs+vdptWgSZC3uk9djkE6ebxs8a1MVg/dXsp1m36U5as2jp095LA0looJFhemG9A1IyFbmHXSKBrVRaPW5EJ7zyHkngkV2HZRskpNGKzKmvNu669OZW7IlT89;20:6wCEEI9oM8XRPslmSu57n8nrGav7HQ6W3D//B+Fm1AG7pK8IP4u6fUb5+JFJN3gIFF4eiLE74OZzbbG/LMlYjd2fWoa1Do8BDxIpAMp9ivcDOWQ55gb4CUpywAo2MHRhAe68p/b2cFKPu3XoCHcOr4/Pmo/Z9PQC8EySu0yEzLY=
X-MS-Office365-Filtering-Correlation-Id: 56954916-a812-47dc-c8ca-08d5bc9b8f57
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:44:24.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56954916-a812-47dc-c8ca-08d5bc9b8f57
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790795665994396?=
X-GMAIL-MSGID: =?utf-8?q?1600790795665994396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to differ the situations, when shrinker has
very small amount of objects (see vfs_pressure_ratio()
called from super_cache_count()), and when it has no
objects at all. Currently, in the both of these cases,
shrinker::count_objects() returns 0.

The patch introduces new SHRINK_EMPTY return value,
which will be used for "no objects at all" case.
It's is a refactoring mostly, as SHRINK_EMPTY is replaced
by 0 by all callers of do_shrink_slab() in this patch,
and all the magic will happen in further.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   12 +++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f5f96e52e0cd..7429588d6b49 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -144,6 +144,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 7ca9c18cf130..b154fd2b084c 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -34,12 +34,15 @@ struct shrink_control {
 };
 
 #define SHRINK_STOP (~0UL)
+#define SHRINK_EMPTY (~0UL - 1)
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
  * @count_objects should return the number of freeable items in the cache. If
- * there are no objects to free or the number of freeable items cannot be
- * determined, it should return 0. No deadlock checks should be done during the
+ * there are no objects to free, it should return SHRINK_EMPTY, while 0 is
+ * returned in cases of the number of freeable items cannot be determined
+ * or shrinker should skip this cache for this time (e.g., their number
+ * is below shrinkable limit). No deadlock checks should be done during the
  * count callback - the shrinker relies on aggregating scan counts that couldn't
  * be executed due to potential deadlocks to be run at a later call when the
  * deadlock condition is no longer pending.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f1d23e2df988..6639d1e7b6a6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -456,8 +456,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -600,6 +600,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -647,6 +649,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (memcg && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
@@ -664,7 +667,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
-		freed += do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
+		freed += ret;
 		/*
 		 * Bail out if someone want to register a new shrinker to
 		 * prevent the regsitration from being stalled for long periods
diff --git a/mm/workingset.c b/mm/workingset.c
index 79099bc5c256..3bac1b2f649a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -402,6 +402,9 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	}
 	max_nodes = cache >> (RADIX_TREE_MAP_SHIFT - 3);
 
+	if (!nodes)
+		return SHRINK_EMPTY;
+
 	if (nodes <= max_nodes)
 		return 0;
 	return nodes - max_nodes;
