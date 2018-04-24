Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+T5nG6T1iT4F+kOnGPAPsyvPw2C7jMQ4hLW+l7dlJ4ljYyVJXx40raB2g7ruUTEFVfsiYi
ARC-Seal: i=1; a=rsa-sha256; t=1524571937; cv=none;
        d=google.com; s=arc-20160816;
        b=ZYqIHMPs4p9vJBbpr5hvsUL9S6/XNGu1baHd5ftTLsX2e68Zqf7z3F2Ili1YttZZ41
         dMj1t+swewYOKV6JlEfsYfWa95LE/t7fT7pxNeumpYBnFRqkyWKL3DSsgBC5ikyY9eZI
         zOorpOABBbUlCYtVYjYD5ZwkiMXe6WiKOImlQDdKMPi6WVDXpdg2q4tohki63hiIZWjA
         +JhZ8NiyN3nMNKU+VeZs9imlhvEaT7tQ+cI6ZtWFcoYGl9pEDTa3vso29J6TYHMaAjd0
         mQPoU+iVLKgj5d608+nAnkuOkvAyqOX/2CoOeG5TBeFiv2Umqc6HHL5VRGoW7jQIaePu
         LdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=t3oxNAEq346xl5/ksycfeR2f73tF8ie8FSYzhJ3qbEk=;
        b=qzxZ9/53JjXZFgl47uAKKxESZ6fwNL8q+rs7az3OatWMcci6fKctcqpe9547GRe8Di
         /7jU/KycF7fNj2PbE/5UAlwIH1wGW1j48t4vgIym7mF6JbFYc6s3j1r8wnqENdFvm4mP
         o/mFvuQqPMB/9PIZxvlVwL0F1RvDeTGY0MS+h+qxZKWrSqNny4rxaeA9iPOQ5msh/YGc
         O4O3/aSjDH5CLzDUTa8slL1vILkQVl7pVcRCH5HgsHc0WkpSFkAZ1POt0ijgUVfLuQ6U
         NIK3ZW0k8RvIgHEX5+HI3YlRV3g/8971AqXqWA3pIufM5V2lhhHNd3J6t975pybnwigb
         OHlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Pa3oNIIV;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Pa3oNIIV;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 02/14] memcg: Refactoring in mem_cgroup_alloc()
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
Date: Tue, 24 Apr 2018 15:12:12 +0300
Message-ID: <152457193202.22533.3646608371253505321.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0057.eurprd04.prod.outlook.com
 (2603:10a6:3:19::25) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:MgUPTd479d0zdcV/g1YlqyTtLBEiqkOxVeygI1rUKGv7douQ2Y3Irvq5UCHnSXtCd8vZEkoONNwn754b+Xi53a5lfKOB7keULCI2zcg2z5JwNzJvMrcQE1paGo7ZP6YDEoiIMYhRBrE2E8JO8jhgQUWv8LHhcNHGLsYujAzli7EqXKS5W/N0dBoOntQX9fB/ZHTm+H5OqxDScdxiFS1nS/sf1uRxSjCclsSTrSLrETsxu0CfwZ2oaao1yTt5Cj4s;25:LLk6hB0ROoZ56Y+2+2yL9G/sq7o1qpBKXkXmVUfAdQ4Y5PfzTm5i3c3CZoC0P60tb4odQn1k4EK3PexFTQcvjkaaiK6aTQ+qU5cb7K292sCKoske052IFhpOZ+/gW4m8nJSjUEM2YlQ9tNOMmY5NUXC+CrG4mVw1E60s+18wqGaPcuSjyT/O1ZVS3OmprRdFa0JxVHruhpHWlW/Dy5lRMW8yCNXR4rinX6tRYp3zoAbmGSnNcfSLEomjpjpCBOCUqMpYVFX8jFpZtpP9LYWD2ugqSXbhvWZxpCgqip7X6Uuowx9+s9L8/ocRDN7FuESyD/vFlpTOdpub/wauxXK6UQ==;31:DIOY0wBXIKzIVEaUt4w+3sHKz7SY+Bwc7SVZfCtB2b/42XOgwAYMlOrnxT8jgh0A7NixR+QrKDg1ibAEfImY7ocA97l0dZ1X5dnVHOraLjUu/Zph5/M0+pQA9SSF87XfHdz/tczumJ8nKMPBAs5aNYTVCExeyavICKhU5zg8ON6abnLuPqyR6WML/NO/aZGbu4gmE5h8f9d8yMRys7JR/UGFml5PCiI5FCteZhD1KBY=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:YE2ML0Vrqtcd3sWdQ+SgjdjtLffIj9nuyafOXbQIZcchdKuh2o2Ew2juuqV5F+9S5y2ucrpxWORwgFRaH83m1CUv7xioZDXMYLc8xsi55C/CpO0vfurRzVpWq/OgUuW5OTX4yWb70yVl6kwEf7Ud/sM/OP/3pYgrp6WvvRdX471SzTsxt+BPqX8jHZk+dQ4FtoxJSkgDot+iz7lq0aW5msggTlk+JPEOsdm387Hj694vXREDp2CBZMz68nKxpuLJAMvj7Ef0wAyzFNJvLHaHYYj88QHnTquAHljW2fDRmr7IsOyU0idKZ2Vvc1yMWzxyC9oDwkf+UZMeA9XXKJXddRTzQaWaEFORdMUAYkw4firf0BeXzoCOSme6Gx4xiA7PgV1YP2YYKgydc2EGRSpkkNVu8IJhziKuddhjZyo4swWLJ7PFBvRVe1iXT0L7zEpSIHAsqOtkhhH3SoKZ600UAYlFJMYq1+bPTiruD7+f2CxqrsgGYftC942U1kcb0X8E;4:Kd2xerZUnyeB5KXxHdh1O1XlNinOs5j+/nW4Dh2bdaOKS5KQ/o2K5/u6J6ih7yZjoWF08WMvYX80dTzx3rePBXcBhNkrqPycPdoiU6uCi+Nos2JmmXXMzA3YUY2kZtvG4cgj8eToEGmsEPzbPZSFtwc1JRbrdR/hYNgutctmxxvI/Mc9r4yuBA7R6C2W6LXwCl2nDgdOM2HTkS+MdVWmKupBtKh2va+gqJNcEoD1NNeFULC5ugd9ZxDyM4dyo/cdv+6kDB15KMng7klQltZnlg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337362926AD048800703B6ACD880@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(39850400004)(376002)(39380400002)(346002)(199004)(189003)(105586002)(6506007)(386003)(59450400001)(9686003)(55016002)(33896004)(55236004)(86362001)(446003)(5660300001)(6636002)(2486003)(8676002)(956004)(52116002)(7696005)(8936002)(76176011)(81166006)(486006)(106356001)(7416002)(81156014)(11346002)(23676004)(103116003)(478600001)(476003)(3846002)(39060400002)(25786009)(66066001)(186003)(61506002)(16526019)(6116002)(305945005)(53936002)(68736007)(47776003)(50466002)(58126008)(97736004)(230700001)(2906002)(316002)(7736002)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6aFdNN3R3ZXY4OUs2c3lUenpZQS9XUHoy?=
 =?utf-8?B?ci9TZzJCSC9qOE1NVTZpaytnWm9sRXNoc3VFSThjVTltUmNia1JiS2p5TzhN?=
 =?utf-8?B?dDhXUU5paHJpRHVjeTIyNjlJaGJ4SVZSem1yQlNtS1g4M1lqMW9tdkdzVmU1?=
 =?utf-8?B?TFBpTUVVc3dlTGJiZ0ZabVJvMUhHZ3luNzAreEVMVWFUb0JFNVE1WExabWNk?=
 =?utf-8?B?QSswbUQzUndOWXQ5bnZvTkllZUJXM3diZmlhT3BqeDVnN0F4MzYxR1hBR2Zp?=
 =?utf-8?B?bGt3dmtiS0hsdDhzU1BqTDZodkdCeENkT09YOGtydWFsTHBuY3lEZjJYUW5v?=
 =?utf-8?B?U1BHc0o2dFpCamt2NjcwK2RDVndVM0RqUW1PMmtUWmlHcWJIWmFLb3JQdDNq?=
 =?utf-8?B?M1Y2Zk5HeE5WYmQ5RmwwUERPWEhUR3RUbHpLcDh6THlmVkJIOWc5WTlIZE04?=
 =?utf-8?B?Y0F6WnJrc092MDMrY3RLblJ2YWlSWjZRMFY5bll3VnZDUXlSZnBWUWhVWlRZ?=
 =?utf-8?B?WUN4UFZOeGJISlhuYkREU2lKRksxWjhoNXVpS3VyaE5UcDFEQ2cvTnoyRVdR?=
 =?utf-8?B?emV3WHN2Q2F0d0VIcG4xcjdGZExJK0YvN00zdlpoNGhzMnF1U1ZQNmdTTmZI?=
 =?utf-8?B?MkRDaXQrSjBlVDJhT0w1blFRWW1MM0Zld3M5cDFPRHk5NGlGNXB4MjR0clNu?=
 =?utf-8?B?QjRSZXo4M3REVk5EaGRBMG5td2JTRVlCaGZvQWxJVWZvMVVsalE5VlJBRzZ2?=
 =?utf-8?B?YVQzaUJmQ0dqY2RtRDRNRVlQVmwwM1RTSTMvRTk2V09BcSs1dFdLNkpqQWxa?=
 =?utf-8?B?QmNlbWVsbkxlRTlXNUVIazVSQjV4VGE2dDNWYisxSE9sTnlvR0ZUZ0ZlSUoz?=
 =?utf-8?B?dGpJS3JmRzM4TEMwa3dTNVJJTFdtd21DVHEyaTVmaXFXTkR4WS91NWxXQ0Q1?=
 =?utf-8?B?czNnV2ZOL0JocWpDV3pmWVVnVXJ1blBSNVhYalVoakgrODR2V0poMFRSanpO?=
 =?utf-8?B?TSszcDZzTWxOTTZzNUtvcXJCaUkwTjVncHhwRU8zY3RqM0tiZlRKckduRWxV?=
 =?utf-8?B?STlBN3p6Q2tGeVF5cFVMQjB0RWxUN25jaGxhK0UxZ2NHTnpSUUx2U1c2UXNh?=
 =?utf-8?B?VG1kZUxCV05sVXRZYnBxM0pjOVhkeU9SRGhqYUJ4U0I4R3htTnNPWkkrSTlQ?=
 =?utf-8?B?cE5WSGxTUmkzTzVjT3FabldqREFXTDU1SisycGZCYU5idmxwUWx1QmJCT29v?=
 =?utf-8?B?OWFydE1weG9aNnpCbjIvQmhXOVhZREk3dUFidGJ5NlVoU0QxYURUandxd29G?=
 =?utf-8?B?RWNZMlBaTHJIbTM0UHBtdlJjUGVEZzZjT3pmaG55RUh1L3JCK1Z4YVp5YnBa?=
 =?utf-8?B?a1FoT0J6RnRuQmJKSTY0YzU2U3FZcmd3eEZrZkkzV2FxNENDdUtwcUNsSjNr?=
 =?utf-8?B?bDRWVzRwUXdvbkc0VmJpeHhUczJvYVFwSERaYVRlZzRncjJLNjZFelQxVUZz?=
 =?utf-8?B?WmtidjM1QlBvWm41KzRFdzJDV2lCdnRNdHVLUXhwTnNyYzRtWGtrRDNqUkho?=
 =?utf-8?B?SkM0ZU5sZ2tCMFZyOG1OUmNxTHBxWDNibU1JcDJqSUUzSzdHYXhBS2k5c3BG?=
 =?utf-8?B?a0VmdFRGbk5LZEp1Skk4ZE1XdzFoZ0RqQ0p5WW1vUzlzZ0tTUGszTHdVTi9l?=
 =?utf-8?B?OStZZ09GOGVsMEpXQUlVbGk2NnpKdWpnZk1TQ0h0ZytqdUhyRXFZQXVYOE1Z?=
 =?utf-8?B?OXBpWVJ5VFdCZGE0NGoyV1NvWVd5blFlNEcxdEQwdVFaRnNLZjZUd3BUVHhn?=
 =?utf-8?Q?up0r/YdpA1XAHXk?=
X-Microsoft-Antispam-Message-Info: CFBQzGwQf1W8lw6LMovXKJVev7WdXktTEtADpFY/hLF5Dx/egHYvlveEU1cX4TV3mx3+HREvkKFG8KVrkmNwRAimQ6b0vWRHv8hx2uNV+DNIzzfC7kJKzBqcKG/w/u5/WFpxbX6+ua7y0VkveZKOP3lgobNPCspHwO/sLLGfSORI8KuHuc6DSRf92fHxabnm
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:OI4bkA8aX6PVd/Scqr1n4XpCj4CahrrBHqtGCxZRaL5LoPla91IvUQ5/uEit+A2P5ys8uZtx0UtZaAZCQYlZk7MvqpV9yu+yhOO21ii/mRB68Xkxyg89n5DIkR2UrlBdwAz+CDK+O2A8/KthL2kLoDEF58oYgG60FhiOj28rowL40TK2O8IrmoET9+eVJV/byIiIfPLU6SJp1Bm/ZRGnoPnoGW5to8XU1UP8kZhPRMq7Z1ZBUKCzG2UIbyzaH6rJncp3Dz7VjzDu2/66RGFYo4tvmSQMKPMtWXhCumy9RID2Czt75zk1ZI0J6ir77rDfzibHWGzoVyxw2X+mk6Y/gbshKLQSOh0n0nvFlk9Wk34oSoEXs2AjNKlHJrsN8gkpNBvuaqmHBRGcFcxLJ86uo3XlZG57sRl+je0KhiTYjIGKbN00EzmKqNfrRkLvd/K+EIoWkyfSdAIU3fCb06FV3A==;5:i1UcxwQLl/EpyxuwKWaCsL4FUvTe+Vl2XP07E1ijZTPZDMLMp27NMt2P/N1nKI3uZz10zoOPc5HNevnfqdnrPOvGZA/bDH/x9uMUpLI60wCQ/8dnGjCsmOHLZUXVnOQm5FCvmfXIo4iqUvtNEBLl6lWul3wFNIj1XuuPN0RbRxE=;24:muBYk8vzy6i8d051QikvOfLD+mFKlNeQp+53RDNddel30yttUGxUHsN6D+imBZUI6FOjuJqpqqzWozI5a3bpeznf1u0UEcVA4EJogJcWCNQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:MCc14fuWW+lM5cfpAahbGD7cWh/Ezho+eogOl7UejMjLoX8+94iBq0/S3ejRUjwnMcixMqYtvRYFPAUTRZFhJqGthBnTNvc3nMCk7AMmoVV3f44WErzkmqkaZseF8n/ERT8w+PRoI6v/NCiot2W8uH1bgbrUOyNBn1M/FFR0RdvBZF+wd0D+57wET3ML/gfOh/PtXvz6cu8OefvjeKiVYY4Zt7r6nlKlTlYgPKJBc9/vmmMGwFdJEVYRiPDy9PNP;20:cXuX6WYmkrj1hw2Zu5SuJFS6TeoHsWbL30aEhfFAAvMIyxt0cCAZsEQpvgTBJm31tFt3uOFoLi9SzDk3Zn1urjl48GhdvpfNAR9csU9bIv9zxtyNK12tGmC3vAmesHBfzIHOH/4WayU7XB8ADfVe9THTC0Y8jPqfgLglVvrE8UQ=
X-MS-Office365-Filtering-Correlation-Id: 3402a990-a1d9-4700-1f18-08d5a9dc9e31
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:12:14.6430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3402a990-a1d9-4700-1f18-08d5a9dc9e31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629544437389167?=
X-GMAIL-MSGID: =?utf-8?q?1598629544437389167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Call alloc_mem_cgroup_per_node_info() and IDR allocation later.
This is preparation for next patches, which will require this
two actions are made nearby (they will be done under read lock,
and here we place them together to minimize the time, it's held).

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25b148c2d222..acabea274cc3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4382,20 +4382,10 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return NULL;
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
-				 GFP_KERNEL);
-	if (memcg->id.id < 0)
-		goto fail;
-
 	memcg->stat_cpu = alloc_percpu(struct mem_cgroup_stat_cpu);
 	if (!memcg->stat_cpu)
 		goto fail;
 
-	for_each_node(node)
-		if (alloc_mem_cgroup_per_node_info(memcg, node))
-			goto fail;
-
 	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
 		goto fail;
 
@@ -4414,7 +4404,16 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 #endif
-	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	for_each_node(node)
+		if (alloc_mem_cgroup_per_node_info(memcg, node))
+			goto fail;
+
+	memcg->id.id = idr_alloc(&mem_cgroup_idr, memcg,
+				 1, MEM_CGROUP_ID_MAX,
+				 GFP_KERNEL);
+	if (memcg->id.id < 0)
+		goto fail;
+
 	return memcg;
 fail:
 	mem_cgroup_id_remove(memcg);
