Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqr7jylmX7aqcGMwbOX8mgLdnvLVcLv44rkR2rsKEOtX0/QWT/rqAMiOQzlZr36sk18LHcQ
ARC-Seal: i=1; a=rsa-sha256; t=1525867045; cv=none;
        d=google.com; s=arc-20160816;
        b=SC73YsyoG0mZ7b3S9dyPeC+UjhotxAAZz9DSTTd01sJGE3ce1PdwQhHxX4jlZY9oze
         frWpILcZgbs6IjCoFQCPNHGdtrG65OEmwBaP6S3ngqSHoct3z2jTsm0aoHzGya2N2yuZ
         mhRs2o2fLGSfJB3qCAuf4kNG3Yd9sJR4cx479vG/JExqTmcnuIDLz7iCSVLnE7G/wmmA
         +plSV/uORQ0JHmba11VY4MYPr9A++bXJxEJp/ybVEi7R3zINu7kFKsWCusW+E2/jlmTc
         wa1l6f6Lfz5Kuwru3WPuD3/HTVNqIvSjOaJ+fuvc+AKLgVWAeI9iBK1o/Oa7yM5PJSqZ
         TgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=V/5d1F+b40xlz7eUN8DQJXXM1B5REWMcXjwE+J2pzcw=;
        b=P/h8J73w4KC1FdSuo4nEMnhbZx8doRdN7F5eWadggFxnRgJE7pYgPpqa4Jmgy13jez
         yJZVZvFKHeRkfLMCLoVLmkQoWyE+BcuesoV14Bx9cSAxaItfbFBMoCIc9Lw3AiI/PBRE
         TXopVU4LRXQAnaJsytK0SvXspL4MWDDnc/8JauEzDnZvNSv56mkQ6uhn1ympkj3+XKJw
         ZF7HsyZ8NxySjxVNY3R3ZAzyxQZhl6kpaG/SoEwSmSsTaUC8+bp4PvG945Phcnt3DCos
         YYxO26Mqiy8w6AsrJ6vEaY7rlMlNSPb2OHJBlD5TGIFPe8vTIqi1bqVCuPvsf3ajeXYX
         XQnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VkbOB2fn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VkbOB2fn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 03/13] mm: Assign memcg-aware shrinkers bitmap to memcg
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
Date: Wed, 09 May 2018 14:57:17 +0300
Message-ID: <152586703707.3048.16626399548423763053.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::34)
 To VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:4To13yekthXEv1J0jRMtNv6OZTiO6Isef7W0b/8yRc873cIWKJxsPUN1BvsH30CwMTe1LBkc7SNJG7n5/pTt+VwlYiou0B+/y3cLdG8Jec4OoicCk6s0r4k0+DeL3R5/XhUhPgHq95RaVR3lmsKepK5IJSjgGKAKq8AwFMwX7VUX5yHAZxzu8lzRV47pBXEvGv177YdKbVjw9RmogUnsyjmM/deaHeXLMqlfWx28pcVv0BBJqrBBpU43+xq3xFuc;25:CvAjSnC8T0JRMed4mNyLzHyyluOGAcr88BnI4lyQe6RMHQCoJLVuRtxls4OUYM4Rpc8zP4one+49FbDd19umj+Rgew99aEeaDpm5c+Pu+NEcTk9KbNdZCENKOfEF3YysDQBmT1qJTA3+PpcEnDZgcgzlaXHiodi/SjPVOTZy+IsHj3GBkkY7v7gKLLNctdieZz5ZWGZ/DDtPH67yI0Fqhtf2rhtrwNDaehYw+xl7lSaFQHaChHj/hKptRPsVxbZEXw436dEcI7x1LV5rtVx+G5hu+ymeG/NnL2UOlLNoRhDFqSpSIX//jm8b33+sm7ne+TlJaNGvGthyUnwpvcx5+Q==;31:wWlwPDly/rfcTremO9wUm9YRS6GP4tuE8pJzuq7gzBaqoGWQP6+LGwdDXuY5Im5leR8kZ+m6sTda4Ht504ZnAR5CxXVXAAJu4lACcNk91TDms9ZYP4d/gwFyBKJJozNQxX+GfxNaFmSjlDMdT0xfsmdnvaQkVVzrpDPl4bKLT8Ooq6Vl2y9iyZIynCHgbrwRvBdVwzuxdRhrqOS6vaE3CxHBZD0NphmzgrftmrcGcy8=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:cuyzYAQ5XySRou4KHAtj+joFzmh4e1FRpP04KakG9nN7H/e6CLYSGR+lcR8QT+41eORljjs7Z1OtMD+wgzqhGZtglF3+hWi3HJ1PL9Pegr0MRaFFbjIf9dqKShQC/LstJNLe4WqN7tQTucTTSSJyS+fSiAgXCg8YtTAI9fGPToz0o2y27fjRtGQcy4MHvTMNvzWfMXd78977Vl5k3Dpl0GNPdh6fIHsPo1pd8adPycPwxdeNmt42QSeS/UrVDbevFnzV2FFHEEi0inQ1+woaWyYMBNrSBSm96WkUm9Ft9TNtCR10hcG+ou9ZZ4v1jEitFdkPpU2CsRCrynhwZ7klDFGr1Uputnm3fDKYxDQAIDj3HIVBrm/mJ8Dx242CQ+M3aL2LRAxP7aOmg2+UJMalv2cySYwRAnggMwOT/VHtggc+UiqPrrRtk+BDS3iokR+ID/s3CZbY2DtekYHyWuwFo0YF563wr30qWOXkGKqhMFKMEoYKKz/9EX0QfvoJfZkW;4:SXwyum/YH9yleVHdf2M0T6TIP2mYVeFJ/z6yeH1C6VsdlMOELWClNXMK+ve/UnL7Dckc/qT6hWPVdo/+VyF9J1QjNIM9TLuYOYHcYfOV2fHMHZnpVFfA6CMk4b5sKvaldolJKPgO2waKFyqWQ6RgzETVr4O/zLdDfyzDLzM89bkCqV+PS2G1Ez/gsVWWf2GiqvuKwXDTecM6rF6bW2zjl4C3fjV2POD5MLdax5aPNQOj81RXiQ7ZI0G+1g3+A0k1rpnfFhqFa2J2G/bROjhQeCsNOgtm55Hl69fvsBQZS1lGadaNpCuGqVKSdr7qGzbEv2L0u/n5PBu0gIeQvpudAuihMnCSyk4eAEjrA7yJdwI=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13418287A28B0C86AB84E07DCD990@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(346002)(396003)(39380400002)(189003)(199004)(25786009)(6116002)(68736007)(53936002)(3846002)(97736004)(476003)(11346002)(478600001)(50466002)(486006)(956004)(6636002)(7736002)(55236004)(9686003)(47776003)(186003)(8936002)(5660300001)(26005)(446003)(52116002)(386003)(305945005)(6506007)(2906002)(59450400001)(76176011)(230700001)(66066001)(316002)(7696005)(61506002)(55016002)(81156014)(81166006)(33896004)(105586002)(23676004)(16526019)(8676002)(2486003)(86362001)(575784001)(106356001)(58126008)(7416002)(39060400002)(103116003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6S2xTdkhGSnVqQnZ1OWJmNU1tSWNhMnEy?=
 =?utf-8?B?eVRLRDRQeHB3R1BERG9lQm5ZNnBmdkVQT1g1cXdMK0VJSHM3RTh0MDhwR0hv?=
 =?utf-8?B?SHFxWFA0YitteDNxaGtHbDJ5b1JTMEhtMVFnTGU2dEY4WTRZVGVqTExOMysz?=
 =?utf-8?B?RlYyVTNUOC9ueU82eVJGZ1Y2anhDV0xnVWRreW9FYnMxWVJsZU16dmFKaGE2?=
 =?utf-8?B?cjdOVGsvZ0RoU25jRzcwN3RxQndNa2dUUFRwSjlPdFlZa25ESDJUWkRCbk5S?=
 =?utf-8?B?cU94M1A4NjJ1dkQ4WGJ0WHNwS08zbzJFUFpmRzQ5YW50c050YnpzWnNmWVVz?=
 =?utf-8?B?WFg3K3g3R0FmejFTWU1RdldaSFQ0cGN6azVDaVBMLzFMcjByRnhLNzhFdDkr?=
 =?utf-8?B?YzR1c0VLek1YblhZQ1hoaW5RSVI0b2l2TTNEMDdRc1NtOG02Rys0VVhpWThE?=
 =?utf-8?B?NkhOamRMdzc4SElIUzZsNmtHM0wvZFJQc1QwUjNuZUFoNEUzYXNtSUgvRlBF?=
 =?utf-8?B?ajZVV1ZFMTY3ZFA5MFM5S0xORVQ4K0RKbERzaC8zZ0tTd2JFQXR5MVFqRXF2?=
 =?utf-8?B?SlZCQlJJQVoxY3hmTWtQQUFrZExKajZEaWNxN1V2NkJzc0xzeHRwd0ZnY2N2?=
 =?utf-8?B?N0l3QWxKSXlWV1hjaUVoRXl4YVdydzNiaDJ3aUdrN1UwUVdQT1RRUGhJb1pu?=
 =?utf-8?B?TkV5dUFwSXp2YVR4bnJrR1BLNEZPcnVzSzhsWXdjc0NEREJQWFZFZjVHcUxw?=
 =?utf-8?B?U1ZRTDhJeWVqRTdvZTc3dCsxSjBTcXljUlQvT3JZd3YvQ081M3NXYWlUR092?=
 =?utf-8?B?d3pNQXhUTWx2S2NwZ3dzWkMxaDRzOFlRMjd1WGNNd1NVMXdOcFdkRjZWTFRI?=
 =?utf-8?B?bXdsT1N5MnJVbG41S0lIRysrVWhMbUZoVGNnNlgvdnlRKy91RDkzRlpYbHVL?=
 =?utf-8?B?NkwxV1JvMWJSTTd1ZFk5enBHaGxHRFJhNUR5aWdEOThQN01Jbm0rZ2lYTGxn?=
 =?utf-8?B?Q0JrTERKbDNhdmw5UWZEdGowRytQSVBFd1VLOStHMk5CSXFSTlRBV0VPdS8y?=
 =?utf-8?B?WEJuYm1DQzVBV3JLdzRsQVZrYTV6ZnNzZmJEc044NmVVemcvSThiQXJzcWxm?=
 =?utf-8?B?QjNUMlhidTdCM241UkYzVkwxcytuSzJOTmhmMjZlN3VjNEtaVjBjRm9zOFJG?=
 =?utf-8?B?R2hxQlhkTlVvY25lQS9NcE5veFF1S1NaKzV6YmcvTTB6bzB2a1QzdmRTTHhO?=
 =?utf-8?B?TCs0dytjZHhDRGZxcmkvVWV4Wi9CZThvZTdmdGE5eGVyRy8zUkUwZ2kyK05R?=
 =?utf-8?B?eUxtS2xlZXZ0dkd1SlJNQ1VqUFZOeHlOa2FxeDFLWUFzU0JhVzczUXlQL0Qw?=
 =?utf-8?B?TzMraDh0bVcxSzlZcDYxaDVYbnlkQUd5V0p1d05oc1h0MnV5eEdsbSt6TWNG?=
 =?utf-8?B?T0dGU2hxSDJnTHEzMVJMQnFnSnlOYmlIVjErcGc3TzVYK3l2RlVvbXIwOGZH?=
 =?utf-8?B?N1h1ZHFObEV1bUFOSi9ibms1ZitCVWJGeHM4Ky9hZzlqcnhTRG83cFF6VFVT?=
 =?utf-8?B?ZWNaL013MUJuTkZXNVhVSWJLOFB0RGw2ajdGS3NMN1liLzd3K2pubEpxLzN1?=
 =?utf-8?B?Zitsa3BDUTk1WU9vaXpmVlZOeTJNRHNGL2srdTVJRFkyUTYyNm90LzlvNGxw?=
 =?utf-8?B?WWo3K3BOVmRtdGdURWkrMUMwcGFWb0h2SkFyS3ovY21IYS9OcDlYRC9XUzhB?=
 =?utf-8?B?UllIdzJrYWQ1KzNiSUx5UVhKTWlTanUzTFcyMW1pZ0xGSnZIYmRaeXRZWkhM?=
 =?utf-8?B?MklhRmEwNkxjSDZ0VnV0ZUlvblJ3RDBHenVnRlIrbFFzMmRnZz09?=
X-Microsoft-Antispam-Message-Info: Tvtw4BguxFKhLub6FKBf5ekAf+K2tv8wHFEeGPpCBuh2ceOXPMFktJX3nZUwrrLDcv0vsVst3bYL9wW1HYvquhaCexsu1mSjsN6+DBxzQfizYL+9oKuP5KjeBZx1MET2r8KOwK2ASpg7blJu6YSlM5iuWxxQJN13vfo/WaOh4yUs46ryowXcIYVxCgaiKyp2
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:e3Zfkkehfl7JsvZKuFnAKLYajLjcVd+gFPW7hNDsnbncbshkRrQFI4f+3Kkn9l9W44WJLomanwlxUbMot8tMxHL2AAor2kgnfvBr4hZYeVkjQ2T23VXO3D6TsQBebNBKPsFIkYjO2L/TrcHIkIvMGtN/dzSaXM/3+hY6cHN17HXglXnPjOiErsIeJiqBLX09zWoxHfDOMmeT4arr8GBFwWvHs8FOHE+no1D7oOc8JMMK/NoajYITnwgWvVYr/00uPw1Lg+lw/V8r7fYU+paqEQhMTHA/P+s38qfo6tkwjDgmAxD0u1MOPQ5PEA3OY+iFVjhqJNZVBg4KfbHZJQ+eFWfT8Dhtoj4mKtHtoA0qC2tjmmg0ebA363V2aqOIEb0QZIZDJIQjjoEdQ9bWwv+zknEYkvFtXMMj8fMaJ3Bb4Fwk9BNKu/WZ5qvI7O+kNJW8bbieD+TEOlV7vsT6G1wmew==;5:h13JYSxGTbQqQocxPremPw9I350NaXmlWS1AsGB5Q4NXBG29u/hJDyYdLKe9mrJsIE+2EYNtRYMCqPM/T4ZMv2efUuimsn94xutks/4OHvIpseT9AyRGTxnQvpU5X263Ao2ZdM3ihD4lRycTjTmJN4v39ZY6t8mieR0zoL1R1y0=;24:T6+FIEgoyssz78L9CHPjlV4G8muQym+p0951CtTrtavg0WKTMT21LyQ4TivmVchdcexMixmkFBLiSothvK8WhF91iOXkG+3hLCjSit1F7Bc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:FK10oJUon6NG1i+WS6RetVn6Oh9UPwlOYzEFWXdYodouNWMQ2pBLZMu3Ny0wzwy1A0bkgWHATnbuV1d5m8UOLEEQxeiGJh4I5tMDhLHDBP0RI1eF4CcphMfu+lJ6Azk86JmhVIcsglgxIK9c8PsdIyG5+WIgrrqKWjP7SgnAU4t0oFpcUQjnmkCgQGQ+Gk0gooRatury1HkVaPr7j8L6IkD8BkkQwWfDARpEYd+HUHc1K/GbIiRj9LqM53AtbRiH;20:d/XvIYeCCkQWlvLVj8SFyOBInQv5i18iDbYtf+jSqelYbYF2B3ebVF3OAEhwfKuvNKxZ6tJhYUoOy1VO+ISu2ood4N6Xn6BEBYYoHW0gbPfZeWBVXlFyiv8hzXnCCdYap2mweSK13DL/RwV5wavbzS3jeMgsUDC1AHzQ/ksQFiM=
X-MS-Office365-Filtering-Correlation-Id: c1f5eace-7674-4c63-6ea6-08d5b5a405c0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:57:19.9491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f5eace-7674-4c63-6ea6-08d5b5a405c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987562902474950?=
X-GMAIL-MSGID: =?utf-8?q?1599987562902474950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, every container has 10 mounts,
and 10 cgroups. All container tasks don't touch foreign
containers mounts. If there is intensive pages write,
and global reclaim happens, a writing task has to iterate
over all memcgs to shrink slab, before it's able to go
to shrink_page_list().

Iteration over all the memcg slabs is very expensive:
the task has to visit 200 * 10 = 2000 shrinkers
for every memcg, and since there are 2000 memcgs,
the total calls are 2000 * 2000 = 4000000.

So, the shrinker makes 4 million do_shrink_slab() calls
just to try to isolate SWAP_CLUSTER_MAX pages in one
of the actively writing memcg via shrink_page_list().
I've observed a node spending almost 100% in kernel,
making useless iteration over already shrinked slab.

This patch adds bitmap of memcg-aware shrinkers to memcg.
The size of the bitmap depends on bitmap_nr_ids, and during
memcg life it's maintained to be enough to fit bitmap_nr_ids
shrinkers. Every bit in the map is related to corresponding
shrinker id.

Next patches will maintain set bit only for really charged
memcg. This will allow shrink_slab() to increase its
performance in significant way. See the last patch for
the numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   16 ++++++
 mm/memcontrol.c            |  114 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |   16 ++++++
 3 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6cbea2f25a87..c159f3abe168 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -105,6 +105,15 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+/*
+ * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
+ * which have elements charged to this memcg.
+ */
+struct memcg_shrinker_map {
+	struct rcu_head rcu;
+	unsigned long map[0];
+};
+
 /*
  * per-zone information in memory controller.
  */
@@ -117,6 +126,7 @@ struct mem_cgroup_per_node {
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
+	struct memcg_shrinker_map __rcu	*shrinker_map;
 
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
@@ -1208,6 +1218,8 @@ extern int memcg_nr_cache_ids;
 void memcg_get_cache_ids(void);
 void memcg_put_cache_ids(void);
 
+extern int memcg_shrinker_nr_max;
+
 /*
  * Helper macro to loop through all memcg-specific caches. Callers must still
  * check if the cache is valid (it is either valid or NULL).
@@ -1231,6 +1243,10 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+#define MEMCG_SHRINKER_MAP(memcg, nid) (memcg->nodeinfo[nid]->shrinker_map)
+
+extern int memcg_expand_shrinker_maps(int old_id, int id);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3df3efa7ff40..7b224a76ac68 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,6 +320,114 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
+int memcg_shrinker_nr_max;
+static DEFINE_MUTEX(shrinkers_nr_max_mutex);
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
+					 int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+	int nid;
+
+	lockdep_assert_held(&shrinkers_nr_max_mutex);
+
+	for_each_node(nid) {
+		old = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
+		/* Not yet online memcg */
+		if (old_size && !old)
+			return 0;
+
+		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		if (old)
+			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *pn;
+	struct memcg_shrinker_map *map;
+	int nid;
+
+	if (memcg == root_mem_cgroup)
+		return;
+
+	mutex_lock(&shrinkers_nr_max_mutex);
+	for_each_node(nid) {
+		pn = mem_cgroup_nodeinfo(memcg, nid);
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		if (map)
+			call_rcu(&map->rcu, memcg_free_shrinker_map_rcu);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
+	}
+	mutex_unlock(&shrinkers_nr_max_mutex);
+}
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	int ret, size = memcg_shrinker_nr_max/BITS_PER_BYTE;
+
+	if (memcg == root_mem_cgroup)
+		return 0;
+
+	mutex_lock(&shrinkers_nr_max_mutex);
+	ret = memcg_expand_one_shrinker_map(memcg, size, 0);
+	mutex_unlock(&shrinkers_nr_max_mutex);
+
+	if (ret)
+		memcg_free_shrinker_maps(memcg);
+
+	return ret;
+}
+
+static struct idr mem_cgroup_idr;
+
+int memcg_expand_shrinker_maps(int old_nr, int nr)
+{
+	int size, old_size, ret = 0;
+	struct mem_cgroup *memcg;
+
+	old_size = old_nr / BITS_PER_BYTE;
+	size = nr / BITS_PER_BYTE;
+
+	mutex_lock(&shrinkers_nr_max_mutex);
+
+	if (!root_mem_cgroup)
+		goto unlock;
+
+	for_each_mem_cgroup(memcg) {
+		if (memcg == root_mem_cgroup)
+			continue;
+		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
+		if (ret)
+			goto unlock;
+	}
+unlock:
+	mutex_unlock(&shrinkers_nr_max_mutex);
+	return ret;
+}
+#else /* CONFIG_SLOB */
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
+
 #endif /* !CONFIG_SLOB */
 
 /**
@@ -4471,6 +4579,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_alloc_shrinker_maps(memcg)) {
+		mem_cgroup_id_remove(memcg);
+		return -ENOMEM;
+	}
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -4522,6 +4635,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
+	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 36808bdf02ae..d1940244d0bf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -174,12 +174,26 @@ static DEFINE_IDR(shrinker_idr);
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	int id, ret;
+	int id, nr, ret;
 
 	down_write(&shrinker_rwsem);
 	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto unlock;
+
+	if (id >= memcg_shrinker_nr_max) {
+		nr = memcg_shrinker_nr_max * 2;
+		if (nr == 0)
+			nr = BITS_PER_BYTE;
+		BUG_ON(id >= nr);
+
+		if (memcg_expand_shrinker_maps(memcg_shrinker_nr_max, nr)) {
+			idr_remove(&shrinker_idr, id);
+			goto unlock;
+		}
+		memcg_shrinker_nr_max = nr;
+	}
+
 	shrinker->id = id;
 	ret = 0;
 unlock:
