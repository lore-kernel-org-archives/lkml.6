Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrl1odBWBBl90ujTAVAfZ9UTuEAAmJC/1vyT2ItMyLC3pm+X+i/aDVs4SyOG30HKX8EEC8h
ARC-Seal: i=1; a=rsa-sha256; t=1525867015; cv=none;
        d=google.com; s=arc-20160816;
        b=BcWaExpk/PvMrhU7zsA2wRt46MEa1z6ncvYTBcEX5w4QBI7mcwTB015SuoBDZKWQyf
         Ft23hH94w4yTY3AfyIbIjUCNcDv1/uQuVQG10ONP+ptaUb8hL89gZ178q4yrGAq1NXHS
         MlpwpOGcALgmasPWAOmsSAB6wbN/vFO6Ot4XLoeXx6AaK3bK91CTQVsZfNCuoMVJeWno
         FADn7XndZRKnMVDnK2QzZKIR7QJqMcbL4pH9uHJ3UYwxzauDiGJ4wyNCQzDgyBfv4W63
         ryr1hG//3c/1fBdfTHTCDUYpCsaqjYP0cZ+DgwUiZhihy+Tz0hUoyG+0xV/rSL2qV73o
         WFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:dkim-signature:arc-authentication-results;
        bh=K6cCuYfApzLlIIK4XjedzAqM2wKku4KF7lhk/vRqL6w=;
        b=LgjG53n8oJiIdWmU0h1HPfzMiTcXXkWgb6HpkCU9sDJB9YvAotBo2EGNZy/iK2Om//
         hU+LlEbWKUAS9/u7yESl4gWKwzEqBPrtli77wTJEycQk8FMk0YAG637z8GRTWu96NcB9
         pNRh5oobLJWHbsHExvOBhjpLjikrO79WBOHFiqfdg7KX0kdBBkKtJV+Q4OjxbzvJjAAO
         mauUWj1zlI3/nZIw+9uIYCUH7Di6fqenxdyBZcUUCJlAd8XehJ4XBda/xdsQwzQgan/k
         j9pL6DgCah4ZILF4I3OAhkwdvhzs925C7JBHZXPbw4Fld0mp4NmvKsnjcC6q5iHXvRlh
         4wFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=iL/CsDwT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.119 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=iL/CsDwT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.119 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 00/13] Improve shrink_slab() scalability (old complexity
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
Date: Wed, 09 May 2018 14:56:43 +0300
Message-ID: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::20)
 To VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:4caa3gE0/krO26r9dpi2hxy6WU952aLnOEMZ/N7byLqHr5ON4n5Hpwvwu7QRJ4yFWnrq2dQvmH67YuXUuTO/lBt/LWmCnNjTYk8vTvz/o7f4HTe35f3SQmvJbt3wdqK5oWhtU12FPBMu/MF225Fh3jnbSkysModf2HzW4YKzCGZx7DIJ7Fx7TOlwu1hrlIjB5s8TNdEWM+kLV+tZ5xKom0cGxuoNrlBpguhUva+3tTpDSsH8IMfTXlNSeZsiswz7;25:w5wG6A4+dloi3RVXLcqwhmdxX6t9XbeTcRdJ1TzptjDrcuJkijXMd3oW7jOrun8xe99uc9GjzltmexSKqjqTFDYvr35nhxsQg37n2WOQXogjnPhLfl+44MrgChpyv9dLSPaTsXvvzFBDJubl7nFwQupy9ZwjAAZiUqy3Gw7K26sUgRK0NYPCyFttSRGqUEru5A/3a+KCLpjvye3C49EKSmd/+5IbrjGwjhZvEuZnXkAb+Qd8Z9YFpuOHrjLG9Xt5aYfzWtvzwQAWmufDrcD2zHUgKa56ubGajWoAbIc0jWaV9BJ4gogi0BnD7aEDn0UnLdOrGjLSh4sTghPJluKBTw==;31:sx9AZjJeKLP/Hsl19VNwSbSrcZfwS7x+/df1IEExVah49zgUtFLivnqCNstMw2RqQWQre10nHYz+xAuYciZmpt/F0UH91xEhkAN9v65vxnAsuGp9bKk+51/Fa6MnDy1FO+M79mcJl60y/6Nu2oE7Ib+E4g7W3DWuiaPtkHrOkll7yR9h597TckMMMDUwgCJG4D9J0g7KBEQS8MDjbQMAVDnFuBXY+NSTIFScrTcHlSo=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:R7SqcYeDWtqCOjeiT6YVKw7fdJ4N4/RE+KIMV/vi9udBtNyj7iQUctCTpNQMAIjvPDhYPgUqFpD09h0hCBJ0LUmzFmJ0/5ha+5Tcd0K4xzTvdcUo1htcVrIqbqB019+vcHa6OCQx4UhsSIj0eX3rYJpN2cl5x1SZjuNs76Pj7rpBU8CktQBEzZQNOCedwgFHaxj3zb+6HPQEiTJEu4jGCrkZNTv5GXnxq86fgR6dgsF2f6KaDo9yZaM1avMUXtcJjFeHvjrocW7OfcGZynHv1ZffSaYwEu+VguF5NquX5IrAYyHrO2EJvixu/a5XG610Y8/ucC7ch6w3N3NbBSc8rYH8o5LRolPHqNIhNb2g3xL8izxpptLSF1DMCkdNDg+dwxG9eOd4eDevAMhbQmI5aYb36APh3yVDrbLNQE2v+y2RgoV4C/0fpy+KK+CJxbW7n10B3uUSnQGBcUzfD6zz76THDZ9YgLEkxYPNTeIVG5XPhh3NcETbFR+LI6NOpRxH;4:fGLIQuY0GJDEXf8FwIksUgNznbVmEkDlvrBUtUlsRraM1svjc0dwFKqDSrTjnD3T3OTtfcBAT0qIIS34KOScL7z4XdMIOy1Cv7HOH+gifUdXtcziSR0vmWsiVAEDarpeHZaS919FKhB8qHfKVVfu7YIWu5YOs8yiwzn/5YQGXRXTqI5+Cpvy4+6BNe4Zp6fv4i5GvdOuzr8aqG8dtZSIHNvhULRssuE1IO4GX4dbC3L/jcW+/alscw6DN300yM+CLCZxgKyIabeE7yKrC+Zn3/GbWw02lf2ARFGE47lx850dJ61GoTwTtIxuVZNThssj
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341C6DB381BFAC12CED0353CD990@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(346002)(396003)(39380400002)(189003)(199004)(25786009)(6116002)(68736007)(53936002)(3846002)(97736004)(476003)(478600001)(50466002)(486006)(956004)(6636002)(7736002)(55236004)(6666003)(9686003)(47776003)(186003)(8936002)(5660300001)(26005)(52116002)(386003)(305945005)(6506007)(2906002)(59450400001)(230700001)(66066001)(316002)(7696005)(61506002)(55016002)(81156014)(81166006)(33896004)(105586002)(23676004)(16526019)(8676002)(2486003)(86362001)(106356001)(58126008)(7416002)(39060400002)(103116003)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6Q2Z1RS8zR2UyOGNsNDE3ZGU2NXhvYjVX?=
 =?utf-8?B?bmFnTkNoZVVHN2thdEwwWGVPdVI1NmdJeXAxdnVWbTluaVZ6dFJ0MExTdVJR?=
 =?utf-8?B?UVY5OFEwa3lmNUxSUGh5bm14YW8vZDVzNlVvU3V2bUpHVUtvUGRLZ3A3aEVU?=
 =?utf-8?B?NTRPSjZWb1pKcEQ0VSswU202b25Kb0djVC9XWXVzU3loTFZaUTZsSk9ibHdm?=
 =?utf-8?B?MlVuT0c5LzE1U0NrdkcwN1BnODJadis1bU5rRzJwT0RvbFN2WHNHRXRDQnNj?=
 =?utf-8?B?R1JLMDRLb2NPVXQyd0pJRnBxbWJqK3J0Z3ErK0hmNGZ3VU4wZmpBVG4yOENB?=
 =?utf-8?B?VlBIbXFQREd5TWdDK0NlZGNXbWNLOWU1MUhPVFR5K1pzOFBEZ0c0STY5OG13?=
 =?utf-8?B?Z0RQbTl5Q2dmMm1WYWY4WEZSVFlsa0FPK1hISmNBdk5SdjJ5U0UvTVQyUFM3?=
 =?utf-8?B?ek1GaUlISURTa3RYZ2ZuWTBDNko3cVo4T1lzWWxHRzFJR2k1NjBQUVlvRHpC?=
 =?utf-8?B?ZGdkSXpCM1FkZUVMbkQ4dmY1Mmk2dWRBZ0FFeDZvdEhYc2plQnZNZ29MdTJG?=
 =?utf-8?B?elVNNHkxNnZ4RkxSWHR0cnVOdTlnOUFrbWM2RkxJOVdRQ1hlanJGaUR3aTlC?=
 =?utf-8?B?NkNkd1hZUW9DSEhZcENROHZJZ1FKY1V3T0NMTjBxbCtrZzBJWFNRNkZVWGIr?=
 =?utf-8?B?RDUyeXRSWU44WFhjTWVkelhaVW1JeDdlR1ZFeE9TOTdxL1k5L2JNWFYvcHNX?=
 =?utf-8?B?QWR3TERLT0tUSmdvanFCRHJaNEVENWxsT0RmdGh4UUNuY2YyZUZYUE14dklw?=
 =?utf-8?B?Q1EvcXVuRVowdlhUWDZpNVU2VFNub2hEcG1JN21HTjBBS0lDN2JMSjZxRkJR?=
 =?utf-8?B?WDg3RndOM243VU1naU1tTC9wVFdhZ01XU0FQdVpvRlhRcUlzejNXSGRObEVG?=
 =?utf-8?B?cWw0SEc5OFdPKzJJNXpEVWpwMG1aMDNQZFJnL2FKaXVDNjFpWlNWaVRSTlMx?=
 =?utf-8?B?anozWi96ZTg5dzJqZ0JaeUNHenBrYWhJd3ZESkNSaGtaeW9DRXBNWEtqNGcx?=
 =?utf-8?B?UU16UEFJUStmZmY1S3VWKzNlNC85TzNEaVQwbW1ZRzFUQkJDS1QvajMxMXFs?=
 =?utf-8?B?RWdJUVNlR0dLUFlwOTRyODNZdWdIeHVlWHJjVzhvVFdZeDVlWlRCdUNna0NC?=
 =?utf-8?B?Vlhpeko5MTFob29MSjVLSjkzeFhaNkpOR3ZQekp4NjNTbWdBL3RrNjNzR2dw?=
 =?utf-8?B?OGhKRGc1TXMrcGo4cEh5YkYyL3lSSU1Rb0tJQnJzNi9sUXZSRFpJME5UTEFQ?=
 =?utf-8?B?czVCdjhSdlJGbUdSVmRJZksvTFN1aHZuWGJIUmIwMitTMDJnNzhPVUJ5SC9M?=
 =?utf-8?B?UXpiKytWMG1VQ1FwN1dPZzZMeXlRMHRDSnBqR01QVzg5ZEVJcU1CUW5UM2N0?=
 =?utf-8?B?WDdCc0RrSFVBVmJhcENadE01a3BPWDJLVU1CQWkrNGhURWswZXdEY3E3Znh2?=
 =?utf-8?B?d21zSE9TS3FJVjgyNlYyZjBQZUZkSklBNDNra1A2KzZMTStUYkZEcnA3d1I2?=
 =?utf-8?B?LzdyQ1hIci9Wbk5DUXdsOFZ4eFpaTnZVTGR4MWM0UWtxWGJCLzVudEF5S3Z2?=
 =?utf-8?B?aVphSCtXeWN0SEp4ZGZkUUowc0tSWlhNMEJlRHJUVVlEK0pTanBDT2FKUkZO?=
 =?utf-8?B?WWlnZkN6dE5Ic2tyeGk5cVRPVkd3Q1NEL0UycVhiY3dqSU55azIyQWVIRmxv?=
 =?utf-8?Q?5HP8Y3GwrjAomkv6CdYj0Fs47Ingz6/dlGXRBWI=3D?=
X-Microsoft-Antispam-Message-Info: yK/Y/uYMKofHRWDpmuKAJ0SCOJHo02TM4tWGqL0hcyJXwnsm7B0/DUDVtjpNAL4qLDqnVuY3oIgLfVi+63EM3GMSchfCubFcj9IgqwGSmE83UiW8/NKWKeBnEOLgh5nkTzvmsgumtVNcoJmwBjcvT/14I6c1LmaACRdgSC+O8DkbW46IGcJqTgoUcVpeM1mJ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:sI139d1eHLbznrHUvnAAQUN+0WMNzMjyQ3+iMg8sWFj/uNMsVp3NHjNaOPmEIHWkDmnR05GljUW4EF/i6u9Wpp/4PPjEE5Q3Lrzv8OP7kvWxS+wIYrFK9x6Qbrsv0IeaUPCner/UGUtOlX/6Qj73IOAV0j7WfVGzMCQbOIYZT3GM2SaHbBn/1rWFH5kgobQQurjGHc14nYF3ntNkaEX8etrAmStIMOzbJBWhri//Dw909BhmmKds4SMHL1i3B7EegeaG7KEnBhvh7YLPiBsVUAz/NoCx3dbcX+4DCyPXyjZXDBv8ieYuZb9lRp2sWwzuQPakHY9B/gFvJETbV7Y6pGbbmjPd8xlqYsg69UwlPoE/cMXMSzEGqsb9Qxhw+gNhV9zf4mrWvL6bq6nW6g852JmLZnUmIgzkaUbf8CJBVbZQCBddt3F6QJ4XynQnR9pqYWyGIXhOF2BYZjuXTgqGfw==;5:HAYO8rCb1zKtnAMlU/D1oE1TIferg14PMbEIMqAeYQYg0qetVSltW8mBO/3khvIJDbLIUPXWvYFYpvfC2s3PyGByjlfMW1Sd2QDKy+gwyiBnX8N/tREhsmgSlNED3LEqCuT6TnBIXeVIItcreK5DBD5SwFLja7HT7w9ypc0mhVA=;24:LWgvnpmW4Mk+trExu/5ymSrIl9ZWmHyXloEB9NY1C1ZOa40jHEpzfYg2A2XhVS+jHlKPYD3vMwip/66JWWNmpql0A2Y9Fy9wyrTKHSbFw/U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:k8zrAQrKxXWvg/w6T9fRp/9ekO3DQUSu3WjYspXphqrgzNnsffdOWtUSIKlukqtabW+jtZ05ehEs8s+Z5oB4xdfTqWWTY4/BnjBzIpIC74xzuaT2XyLpESk9MVRg4V/bsybOHPfBGC/uK2E6nZZah921N/9QOYEVKGbLavDsnlkcE5rxgMr7Vqp+qv0MnLvuZsHgmCW1EELY6Z2WX/Zkzw8mu3vJrGxSkAQ/DgFZZCPjQFH5kK6li5ZDK8pxf1RO;20:VkXp+cCSafGJb1vHGK0arU9/SOB6a+QFX6f4nN1OqYbRwoNbOVkT8q4NnvLYNKUDJHOfk3OEuteTYFvWKiUqYWDmttBZ7eO9Vy8QEWzAPt3giK6+85PqxjuDPzc1eGYBbJNN3w2ncY6/dMZnX3CTwpM5XIsG9qt4PsLA+kF8Qn8=
X-MS-Office365-Filtering-Correlation-Id: f5cf6042-edfe-45fd-d5e9-08d5b5a3f2c2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:56:48.0725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cf6042-edfe-45fd-d5e9-08d5b5a3f2c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987531619738441?=
X-GMAIL-MSGID: =?utf-8?q?1599987531619738441?=
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

Kirill Tkhai (13):
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
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Add SHRINK_EMPTY shrinker methods return value
      mm: Clear shrinker bit if there are no objects related to memcg


 fs/super.c                 |   18 ++++-
 include/linux/list_lru.h   |    3 +
 include/linux/memcontrol.h |   32 ++++++++
 include/linux/shrinker.h   |   11 ++-
 mm/list_lru.c              |   65 +++++++++++++----
 mm/memcontrol.c            |  146 ++++++++++++++++++++++++++++++++++----
 mm/vmscan.c                |  170 +++++++++++++++++++++++++++++++++++++++++---
 mm/workingset.c            |   13 +++
 8 files changed, 405 insertions(+), 53 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
