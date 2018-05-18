Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoxA3N7Kb5X+jcImiBZiIkqMRywc+X/aJEQ5JGy12OgwrsaEPiDyR8n3CQvDmn59+J15frv
ARC-Seal: i=1; a=rsa-sha256; t=1526632906; cv=none;
        d=google.com; s=arc-20160816;
        b=o7695HK44d0QCp7NkmvOkioKd2PPPoSSQHABOw5nNtvp0MmYWjJ11xpmIiswLT00/B
         hhYAUS6f/pceXMkgU5B1JFaKtVcm+uPOCJdEiXQfFhQJUQymkuA9nKole9mmLC86HPVC
         5NiHT+dVBY/KJO0R34QFl/J4vFcG7bcsCS3FWNqob0u8zUV8h8me6zAX2PGf5KOIem+4
         b/ekMamS+lP++2PvnKOw69//CfmutsXDtra6TndaqJ0Ku5BqqEuMG/imuqDYnmakR98i
         R6QJcxTelxIRpE8Q9+XqpnmlGI4GUeUgMkidXCC4RcEWypoxivh1F9Q9blgc3r5tvtVI
         RZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:dkim-signature:arc-authentication-results;
        bh=iHjb1Rm5AnVtyRImFjLGKyO6dtDgEMS/Un0u/8/S1SU=;
        b=bIvGMa9eCnnJ3nm0njBbFAEPqy4JxGMF9nK0ZzUtowuDcTgqalvslzM4FFyL2jkt/k
         f6r2HyMc3/h2pyTZyZ+IZT8PgVWUIa6Yei1yvSQ8hOz5OWGAm3LxVYe5Hwo5e3oXtK/Z
         YrcULpVLTqOhb0JCALJTpFK1k/G4J2L8W3IhJ/9BqWKXJXy9o5uYY0FHCPDItJxTVzaj
         AX7ekOQgnPs96IxMhaGdq7JFgjZ3wA+aAi/VVUpMbSn2JulPQlxNyyYAvWoSCYw2v2hj
         pvfzvHnUhUdu1ym7eEZhquOpZLynAhKqVvVGLCjx6SU9BpRdye6hfVaTmqBxJijF48k2
         tUcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=BxJQaRou;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 2a01:111:f400:fe02::704 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=BxJQaRou;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 2a01:111:f400:fe02::704 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v6 00/17] Improve shrink_slab() scalability (old complexity
 was O(n^2), new is O(n))
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
Date: Fri, 18 May 2018 11:41:36 +0300
Message-ID: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::23)
 To DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:Ma2VlrDlxb0gibFoSxntgjd2YnNlmfkldJz/x/fOXFR95ngot/L7FNxgkSOvOAifjXvx65NlARCXKs/ir2uFV2gJvDweFzUxWg01ZpKJ1rzVaZMa6NzB2Uh5A28HCMkvLWHxTsd5k51twPOAuEP9vypxskiL5OBxK5yvoYv15wFGVida2bYn/ZgqkhmHeKY5SkOeE0j3+5zYxFrDnvK/QATD12chWEKjVuEjP2Xryc6kNh0zOq2CZPkZlm7jxhTh;25:GA2TDJjJ8vtV98z7AhDSwmQM9KYtSPXGrjPs0yMVsxh/5xlPewKcY90uG9TbcEvy8NlU6NyXSpAV3JAiQF4XGUwGM3EWREVo8lX1hBKDlcwhoMBouWTAVNWByPN4JYV88+QksDUz1tBS1L+qRHrivW1Q+l3NNUB436qILHNYVOOWGiby+xU8IFBaLUCCZf1X1+gW68gCfs8LmFSRZmON7An5sMeLUzAJIWjrJkumGEEFKMaTlDdceZ2WssL0uuL5ienXVIBCw+GSZy/YNFt7aTQo3b/ISH/qzLnsj/+V8cs95cWKEFRDeY4udqEhWcV1D36VfzX2RP5meRh5kvCejg==;31:Tl3+4He+nHwleOUBpQxtD2O1Qf6lrxS8ttSihe2TYZPqzY56nI1NRY2Uw606LzE0J2gVFSnCowdzV1DOZUt+K6CUzynvClUz6MPEWFNnyMudwfhbERh/efQhEcuyKJmIX5GyCwOLZlcFoTcvIxmop7+rupb194ekGAp1B84vY87FZXRtHTw8wCCfrMgM42nYILgsYqgI8Xettgyi8wjzxSMo5ZvDMsxHDrVnqc7JpEA=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:D47X/0s97/bOXR0eoEuDBZPif0cuBTPg5NieOftzZ24OssAIaIi6iX29GKtMfjDgwYoNXiSeepPFIxjoBDNEgbdZvvtEEjPMbbBa67OpRUCf2DvOTLWdiGdR4xTPEhVW5Uzj60KcaLxia9D77nDtvWT+rsIyiar63ddjAj13wBYTN0fm42uwzxwNTRaru8Y0t5Y2xo2nptSVgZXWsyZ5D4Yd/wtRa39nEWPsF9lKWxqtM+fEBNdgcxOxIRtHq+pZfZFmSetJrSTCcSxu684urQhPphWQYPJotO04EQuZSZSj/fpkmTsftsW+XOkvthJHcYHGJuuhdWb+Q9staqhof8P4DGDkaSFXGQ6Rr0+NEaPhktP+tgBlcOvVDhrVyK1GjumNOfU2oG4svqZgsIgV7p8tI9raabOX5CRfnQ7iTwFDYGdYDVEp24ZPVC37gMzGJ0huBW3/jVLfrxBVv/BP+nXLwZrZmSwRwcpO2ROu0YKHO51vHRApMsf+RSNnWdFP;4:yBMGUDi9GtqMLY2gk3wkmrmPl/yn0w/Mp4QRer4RrnA8JUYwW1Hd2lpgEIXmOcRfYYPVrl6kWEGuVq8dodFIUcBhN/faN5BQnVbbtjW8+tpT98c+Slj0EqVHrIVcxvrdIsE8MWdRZCtvVVVirnDcjThnlC1ylB2WUJd0/gKVKc2/yZO4gUx8shtE09byAt9qfKjMZhvlPCSm36E616Ht0BN48NrA38eltXHlHMFQ75Q9B0oWVSNCqZKrThKoJ6h6gNZLHqiwFfgiuT2uaj+zh1uCKEpDMSnpNL9G/0qelqfVguXV9r8KI9l28PkDQzQD
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1334ADDE30BB1A642BA917DECD900@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(39380400002)(376002)(396003)(346002)(366004)(189003)(199004)(47776003)(3846002)(7736002)(230700001)(186003)(55016002)(52116002)(23676004)(7696005)(2486003)(6116002)(53936002)(16526019)(26005)(478600001)(97736004)(39060400002)(50466002)(305945005)(68736007)(86362001)(9686003)(316002)(386003)(476003)(105586002)(486006)(66066001)(33896004)(25786009)(58126008)(6506007)(59450400001)(956004)(8676002)(81156014)(6666003)(81166006)(103116003)(106356001)(6636002)(61506002)(7416002)(2906002)(5660300001)(55236004)(8936002)(81973001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6RjZDN042NkdHbFBPRGFyQVZmY0dyd3ov?=
 =?utf-8?B?MWtQbENCQUNDL3I4cHpaSlRWVTNxb0M1bVNpRWZ1TmZkTTc4c3ZsRGhGQStu?=
 =?utf-8?B?OTJQdERaOTI2M2owem1CTEJndHlqSmxxQVBocUFhb1lwQm1uWllGRUZGTVFv?=
 =?utf-8?B?V3krY3ZuM2J4cXdkWlV5NDBpSVFpNllSTXNab05BK1JncEVCYmdMa0dEcVNF?=
 =?utf-8?B?Kys0aUdrMUlFSkZWOUtFWHlUQmJJcnQvbUEvTXdHR3FCcTA2QVVCdWRMNkdo?=
 =?utf-8?B?TnI0RkNJTHZPdjRvQXpjTisvV04reDRBTnhTWlBBV3M0M3RTRVV5V0E5NlNr?=
 =?utf-8?B?TEY2ekFUVUhJbzZLdDZzS3FGVTFtNCtWRFRNQnphSU02YnFDUmVnUWlKdG83?=
 =?utf-8?B?R3pXRlJqL3ZzNWQvRUtKOHNGck1MNnNiZEJqakFQczVnSi9JalRzVHdTNEVw?=
 =?utf-8?B?MnlFRXg4V1AyamlzRFJ1M0hGN2FPRWV0dE5JM0tBd0NWbHRqL0F0M0w0U1RE?=
 =?utf-8?B?N0pwa2t5MmpLTGd0eURDanZ2d1NxUUh4SEdVekE2U0VNRkN0a2VSa0pjdmpE?=
 =?utf-8?B?aEhrTU9VY3JtYW5qWmR5M20zZEpDcG9qSTVuSXVjV0ovclg1OEZ1aGh2NERy?=
 =?utf-8?B?NFZnRFBxZ2c5MFhmSFovS0JhR2F6M2ZtVldXT0xxWDVUbkFVRFpoRVNEaUEr?=
 =?utf-8?B?UWJRR1BOMGJ1OTJPd2hXM2FpQ3hLVUtMU3l2WDJCTmN1RlRuc0FlL05oNG1X?=
 =?utf-8?B?ai9tOThmOGpNNVdtbnQ5Y1kzaDd0MXBYbTdYQTNqM1lmSDlTNjhoK3Y4OG0r?=
 =?utf-8?B?SkFod2t1VllpckJsU2FMbE1OU2szQzZFNTIrWjh4V1lwSFpHbUNyZkdqcW9H?=
 =?utf-8?B?RmZLbkJJZ2VpWk5WWGRZWW0rbWxweVA0RHA0dDFVR2hkUldUeDdzMVBtMStK?=
 =?utf-8?B?SDlQQkphSGhoZnlJbjFpNjFIbG1aME9ZbFVEbHJlbUhSYVIzZkpiUGd4MGNV?=
 =?utf-8?B?SnpVR0U2bjk5TGtlemdQNTlaREkrbGdSVEVwWWJ5Z2xSS1BnQ2ozVll6dXRI?=
 =?utf-8?B?OWFoWm1DVjFLdTEyMy9vYkRGbVZNNCtiZmM5bjgxOHZxcEh4elRDUlBQemFJ?=
 =?utf-8?B?d2Zja3lVVUo3MzhXeDBza1VqOVZRUHBONmFtUVdBd2JldkZ5cnlNL3RFQlBu?=
 =?utf-8?B?NXpmZmd2K1Y0bDUrYzZYUzZhQnZQeG5tdHptM2cwNit4cTF4bE9UNXBTNXRG?=
 =?utf-8?B?Z1JjZnQrYXV3K3RLSHF0emhBVkNjcU9tZG9NeE55dW81aStlUlZOc1d6Yi81?=
 =?utf-8?B?OWYvUGxRY3ljM3ZUZWVlamxnRlo2MzRWWWZOc01SQ2hLcHloTk5wazJ4QmlP?=
 =?utf-8?B?NGRuZzl0ckV0VzljenArSUFsdDhja0NTbWY4bmFmbzM5RTlDZDJjcVdZN2Za?=
 =?utf-8?B?YWRkZHBLL3N4MlhJdTdLbDBUT3R6RGVYOERuNDBOMlRCMkpIazRjUUtGelJw?=
 =?utf-8?B?RkVoMHNrelp4Vlo4WWY3RW02SnNXcjZ0K2JJZmRTTjYxTSs5Y2Jrdm1rMkVY?=
 =?utf-8?B?L2pTTEJ6a1NWRitTY0lUeEhIR0QyNHZXZnVLZnNWRXNJSjVFWEpXRUsxang1?=
 =?utf-8?B?QTR4OUhwMzhuNkpTdTYzeWtTQjkxSGNrRWNGNWhjeDJXNnpOZ3ZtYjZPd1hS?=
 =?utf-8?B?WUhkNkliQmZucEJRN1NIVXgwZmhJdVh5cXQ0UU9SRU5rdjE0YUxvTTBtMXc2?=
 =?utf-8?Q?GxDeAn6/bWoSifw0T5/zqq2MxMh64B1o4oH/jNA=3D?=
X-Microsoft-Antispam-Message-Info: 5hP2vbynaqCFUpz+cLMQIXKNxokpWVcSB41yPUoe02r17/uhQuJeZ8bDDRu5CnLMJ+QGmkXJLqnCVbLjUl5X/H45HNqIXZhWO1/XRVEoD+8PvGhphEGFGGrGK1IP9SVE2/5Nu+OONbqRIvs4pj7yR1+ezDE1nn8VbuUkFVHVpK89UgqukWlQyjFu30EXges+
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:cRHpA62Ml3JRodRRVs8HbrP9ocesd92ckenUS4Jr+yFoo/h5HPMJmtYyiG538A7GoI2/v2h6oN0+MmT/DVAb8y8w2g5EltfgB/JOO0NCdpHLsMCM/cHxojbmpqg9B0Oi9mZSLXVcZAF6wD7GJcm7gq1SqC1Y18RKW2KmdXwgJQmTOVgRQMRA42l5+yJzedxSjLWT68W+GjAyts+MyseQFlwJ5gA7D7VZdrK7P243GRFo/TnBeBrQn/oKkNFRtLERHLMRkLgCcilTHE/jWmB9g0JdkDIW2Mk02/0t1Q1zyQXsgKfKg28x2kqrqZ54WSpsXJJuYrMr1JBuzezS7iIEkSTAj3NPoFMYZafsMwExKE12/RHNRV/BaIT11u4B9xmGqaXqUq0z3bTKvp1IaxO+PG/5sBSzu9HqNl/Nhte/vTlWGo8aqpR8Z8i9lsOquhh9E/nvYYLIIyyvIf1OYvEqww==;5:JP4Ok+4uWy9ESueN1xGZzP6V/V2+kzbRyFMB4JEygTqiskwHKf0dRgJ9OEJO8d6gQZ/Kog/gVVDOykzeyObX+cCRamSToBpu6nhUjpm9p2XfKVK0uszgnX+XIGuN0RVnYtC5taG/VOqinmPffmkAIXoNgPU83xYtvoVtg4iw8vY=;24:WEp7cdXsJ97RA4mtxzAL4PyRE2NBlJ2Z6eXFYpVxwX+SjcNgXTXK4qUgNCaLCdAJDthlFIgbkqHheCPFeyrAmPg+LP1Ru4aK1LVTquOn3Q4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:6L0x8ZZ7EfhZbWlZ61GveOPNWPIOVv1r3U9iR3qs7YcwCC/JgM3UxZKe49+HaysOIWWRqzkTUPuQdgEoQQLznFJ+zHfZeI4/Gvbq7dW5CTb82KbN5a5fH/BNO/XXQCac1BgYrli9PkBI7Iyt1KfRbrTnHV/HwGaNrPhdbYmunmG71fgld7/kuhKAJtJIchkglmR4M9gntBEIs4xRuGzUsrCOVKBX+/zxhvP7ezDHmgruHcjYeBdJ3y6DUgMRyBEe;20:Dronezeg3GGVtv1vlgGVT4nLhElO0JVUjtRxJfpq0AuNK6YK5cUz0ED3qYYs68NnJhs9j8nQs9P7iAubrF7psrkoO994/+FG1Z//pC2ycgZkvqjJscWhL2yU2ABWDlpfLsdUOU1NuWc+ZH3wjbFUv2A1w6H8/sCBZrMr9cK7mT0=
X-MS-Office365-Filtering-Correlation-Id: 79b912b9-60ce-4517-d0be-08d5bc9b2dd6
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:41:39.7016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b912b9-60ce-4517-d0be-08d5bc9b2dd6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790626307482864?=
X-GMAIL-MSGID: =?utf-8?q?1600790626307482864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

this patches solves the problem with slow shrink_slab() occuring
on the machines having many shrinkers and memory cgroups (i.e.,
with many containers). The problem is complexity of shrink_slab()
is O(n^2) and it grows too fast with the growth of containers
numbers.

Let we have 200 containers, and every container has 10 mounts
and 10 cgroups. All container tasks are isolated, and they don't
touch foreign containers mounts.

In case of global reclaim, a task has to iterate all over the memcgs
and to call all the memcg-aware shrinkers for all of them. This means,
the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
and since there are 2000 memcgs, the total calls of do_shrink_slab()
are 2000 * 2000 = 4000000.

4 million calls are not a number operations, which can takes 1 cpu cycle.
E.g., super_cache_count() accesses at least two lists, and makes arifmetical
calculations. Even, if there are no charged objects, we do these calculations,
and replaces cpu caches by read memory. I observed nodes spending almost 100%
time in kernel, in case of intensive writing and global reclaim. The writer
consumes pages fast, but it's need to shrink_slab() before the reclaimer
reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
there is no writing, the iterations just waste the time, and slows reclaim down.

Let's see the small test below:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
$for i in `seq 0 4000`;
	do mkdir /sys/fs/cgroup/memory/ct/$i;
	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
done

Then, let's see drop caches time (5 sequential calls):
$time echo 3 > /proc/sys/vm/drop_caches

0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU


Last four calls don't actually shrink something. So, the iterations
over slab shrinkers take 5.48 seconds. Not so good for scalability.

The patchset solves the problem by making shrink_slab() of O(n)
complexity. There are following functional actions:

1)Assign id to every registered memcg-aware shrinker.
2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
  and set a shrinker-related bit after the first element
  is added to lru list (also, when removed child memcg
  elements are reparanted).
3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
  and call a shrinker if its bit is set in memcg's shrinker
  bitmap.
  (Also, there is a functionality to clear the bit, after
  last element is shrinked).

This gives signify performance increase. The result after patchset is applied:

$time echo 3 > /proc/sys/vm/drop_caches

0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

So, the patchset makes shrink_slab() of less complexity and improves
the performance in such types of load I pointed. This will give a profit
in case of !global reclaim case, since there also will be less
do_shrink_slab() calls.

This patchset is made against linux-next.git tree.

v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
    Use different functions for allocation and expanding map.
    Use new memcg_shrinker_map_size variable in memcontrol.c.
    Refactorings.

v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB

v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups

v3: Many changes requested in commentaries to v2:

1)rebase on prealloc_shrinker() code base
2)root_mem_cgroup is made out of memcg maps
3)rwsem replaced with shrinkers_nr_max_mutex
4)changes around assignment of shrinker id to list lru
5)everything renamed

v2: Many changes requested in commentaries to v1:

1)the code mostly moved to mm/memcontrol.c;
2)using IDR instead of array of shrinkers;
3)added a possibility to assign list_lru shrinker id
  at the time of shrinker registering;
4)reorginized locking and renamed functions and variables.

---

Kirill Tkhai (16):
      list_lru: Combine code under the same define
      mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
      mm: Assign id to every memcg-aware shrinker
      memcg: Move up for_each_mem_cgroup{,_tree} defines
      mm: Assign memcg-aware shrinkers bitmap to memcg
      mm: Refactoring in workingset_init()
      fs: Refactoring in alloc_super()
      fs: Propagate shrinker::id to list_lru
      list_lru: Add memcg argument to list_lru_from_kmem()
      list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
      list_lru: Pass lru argument to memcg_drain_list_lru_node()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Export mem_cgroup_is_root()
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Add SHRINK_EMPTY shrinker methods return value
      mm: Clear shrinker bit if there are no objects related to memcg

Vladimir Davydov (1):
      mm: Generalize shrink_slab() calls in shrink_node()


 fs/super.c                 |   11 ++
 include/linux/list_lru.h   |   18 ++--
 include/linux/memcontrol.h |   46 +++++++++-
 include/linux/sched.h      |    2 
 include/linux/shrinker.h   |   11 ++
 include/linux/slab.h       |    2 
 init/Kconfig               |    5 +
 mm/list_lru.c              |   90 ++++++++++++++------
 mm/memcontrol.c            |  173 ++++++++++++++++++++++++++++++++------
 mm/slab.h                  |    6 +
 mm/slab_common.c           |    8 +-
 mm/vmscan.c                |  201 +++++++++++++++++++++++++++++++++++++++-----
 mm/workingset.c            |   11 ++
 13 files changed, 479 insertions(+), 105 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
