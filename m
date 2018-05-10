Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrdAU5tgTRWhVmVengNjKx+BIVET7mYir+S91kbWcf4h3IgzGzvhZQMoFQJ6dCoLIu/f67U
ARC-Seal: i=1; a=rsa-sha256; t=1525946034; cv=none;
        d=google.com; s=arc-20160816;
        b=yRz6hZgge6T85l1mvNZytL3vYLwGAKGw0Fh5gPp7LuNXLYqaOfnTCCdjxRNEORD6Ig
         iTFgYRlkHudMVjCljw9XKcFgKLvvY81Kw7HYD3Vcb2GYVAnIucGtZWehBdhKXIDoRNNm
         wWoyuvej8q9mKh38H4ktIQF4ejkPt07TKfe/uJGrPgfYGqesAqFZp+gVOs1Lq0IRWpat
         iPhvU+b5/uLJUo4ZhJPXDUCKMu/1AOKGsPKpA4myCyoNnnqQ13dbH4i1anxUCOOoJHKM
         xiSFB0eVdsRSs2M0PinVqwPMYkxvqvvw9EF5suBjD1NFBFoVx5hhlKq3/1co0twD6oIZ
         RRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=Ujn1h/KseB3zgJx/e57Tug8mCXoI+0upRyN5+30U2uQ=;
        b=upRNOpzTTA/L5T1Nxw2i4uYzTpzY3pbl4lNbAFmxXSmBEkyYTerMyxmfcUTlxEFkOi
         3AZrugLiGVb9Ut5JBstX4YtrweU9aqHidplN2uniwyOYjvo8uVNETK5BCATmcy2J3EAt
         Q2Ww5GmJqN/syWK8upWRvP511pRMVAqYBZ5XpTaHHXWOTDVX+vlwFBWjBubYmfWetGRF
         oVA2J5f92gvTGVinhSV0/0LFr5ymDxtGNjQmRafxXSbqWyy93iQSDFDQ3MSUoU4lNmZf
         Yjcx/QrAtN61AfoS8FhLD5m5w0V4S2U6dNLRWiisoZImoC48rUC4ZjGYkcZiM8JZqfHC
         Z/vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OyKtzM3l;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.132 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OyKtzM3l;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.132 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 10/13] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
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
Date: Thu, 10 May 2018 12:53:45 +0300
Message-ID: <152594602582.22949.2526776640167844592.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR06CA0052.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::29) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:Hpz5c2YXGdt+dmsk2GlXpQ9g3qjHa2xKa2IKa+VeF10S5brxny0iYZYMld+bunD+S2OH2GxQHrE0FLt3HGrulwIeFqklU1CqFKhWEX+pF59takvFGLbBU2jrds9mujCCqCvtyjtb8KQuvkjpDsnV10AUyQbmPC+q87k1vyZPPjBfZB/sgeyMLt9nh5Eobgtbzk3qfhYnOWxIweis9D6lxNgHx4AXoOC8wWo9X5EJuQbW/LSNhiUi4OmbG7rllU1R;25:00ikVQsRZ1zJF43YBw4+LTmtiaMjMAFr/dUOEbGoQgEz2A431f+GtjzzadOFaNigS/08fvCT+Mo4HrlIrH8KoXspd/zYLPsot9PwJdajwXP65ScD7sQdmh5AP3CtbdfNZsUH/pJOXVcwFPjJl2OFNA+KoAjZK6N4fxSIEQXSZUhxl9PvsfuVCapIWXoB9ZGvOVtRKxEyvTjfSUvOz5c4ec9FO0g+qjD4WYBZELnWzNNMkyWlvs9ARyNdRnzeJOJT7EYTo8ts/MZZ7jtpQImiJnepFebZGswnoVHwcjBaQN9d4ERBggohH5K1IdOhPoP75bUP3jcw9Kg4Hq5iwsy8LA==;31:r8BP0y7ZiSzMQUPzSjTFNK+cYgHt1ff7kaQgJfVorZ8QjE45+D/A09Of3JjqAvmn9Au6GGF7XKMBH2v0JemyIgEATuqgYIVLppjIydDOKOuuTcTgO8pA3pdMwvI5Eo0YMjAT6jh3/GnU6Rikhe/GW+aQ05dZZ9t8bJIbQqM4pBivovBLOOPEGD+6kkbUvxwkUZimJimpiL/+0U1BAEIe1iJC2sAbOGb9oDOWBJNtU4E=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:52wafILNvyNafy2ZY2oMpPCrW90dfDxQ0XaOuzKcgAuo8URXbNVH17mXYCToopfaTb3me36DK1So9U8hYNoOf4L5tDzm7njlA/WuKapRD766JQYj/bTt+xcvOJeSXmEw0zoccntDOAJRtKQbdxxxxvtg7LpRmy2/NmIAO9HIVl2gBq0IkzvEbxXNwvg3quhx3IN8F+Ky8VOquPRw7VycxhFc35Ro12pA39wm5yBKCULUP8eSb8ocG12hteKIFOQmK/2Ib0a4/tWT+xeZ+6fQi37xxYatZCif3U4CzmcZaApGPH4Gni6G3+XVadCKdfzfaa83v3cmYe9UKRgAL72v5jLv98qoc8pvGS5CFWLIVeMJ/5l0E3OjoGT4T4vYG0TwsGZxP+WDKL961wvMRHlKfQjmkK0z6maJWmFLEAQJ7Icee7m+w38972c5QGuD3+LL+Gx+NaoCz3drj4L9A94lvcV+ciFv9gz5DqGwymGLUejZn9RtJK3gvgvLKMZXhV7X;4:QrywgOJauQ+VYqLQuYzbLZrA5KIu4jSh2KqXksRPrcdzJokmdr6xAI9omapdeYdWFr1xrQytRcP/hLg+z+knendV3syfa9Th53j6h5+fVoZqqEyVZKUHBe7tY0qJyyEnMYrSACpq2Wv1MraU1ZyA2pvQo+7Qlo8D9lr1EsXq8r3iAXnv9gzsAZUxfPN7UkgyNrj1CpDkk6utnLrMiiFxiLqyTprhRdzparps4NqX2H4uQPo45WoAH2A4JiQQ0xfYzTw1v0t+lvyFfUgtjmefpQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13425B3967F7102BA59E258ECD980@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(396003)(39850400004)(376002)(366004)(39380400002)(199004)(189003)(52116002)(23676004)(26005)(68736007)(186003)(2486003)(6116002)(97736004)(61506002)(86362001)(3846002)(105586002)(575784001)(106356001)(16526019)(55016002)(66066001)(11346002)(446003)(25786009)(486006)(7416002)(76176011)(8936002)(305945005)(956004)(478600001)(7696005)(5660300001)(230700001)(47776003)(386003)(316002)(59450400001)(39060400002)(476003)(2906002)(55236004)(7736002)(6506007)(6666003)(6636002)(58126008)(53936002)(81166006)(9686003)(8676002)(33896004)(81156014)(50466002)(103116003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6WmI2eUUxZG0rUlZKbERpWUJQS0dsZll1?=
 =?utf-8?B?SmNnNG5jQWNVVTdXMTJqOWIvd2JUMDBhakt4WWF3ZEExVm54Sy8zVlpjZE1Q?=
 =?utf-8?B?ZVI0bHJhMGdlZVd3Y1lva2hVTEptZ01JSks1VWp3K0NXKy91OXRjTkU3UjJx?=
 =?utf-8?B?MzVERGhQVUtURjdZcVRGc2Z3U1VpYmtLQVV5MEk4dlY5NFU5SkQ2MmkwQUJI?=
 =?utf-8?B?UlhiN0JqcFVEZUwxZEluTVRVb1RybHNReHZmRWhpeDdUTDRQazVkV284cElM?=
 =?utf-8?B?RXVvS3Z6SEZzNVZYUUltYnRDMkFrSUFwM0RNRW9NZGVhYkJTZVk3UUthazBU?=
 =?utf-8?B?aDBPcGIrWkZyR1Z0cXFadUp1VTd5Tk5sQ3VJbDJHQTlOWlBwajJ1QjBsUXhw?=
 =?utf-8?B?d0tCem14NUt6MWl1SEtndHp1ZTM1di9mbXJzYzFmTEd1bExISlczejh1aWNH?=
 =?utf-8?B?ajJHa3haMXVHNnhaR3YxVDNwNEVxUjcrZ1hQMXJTSitBa2xJZWFLSjBlT2RF?=
 =?utf-8?B?ZDkremFha3grenprS0J1Wjlack1kQXp3Uk0yRHhQbVlmQjJaTkkwUGlGZ2lN?=
 =?utf-8?B?OFN5V1RIL1lrSzBudUEwNWc5MkhpbEZyU05hekVDNDJRaGJBc3h1aEF1V1Fw?=
 =?utf-8?B?cC8xN2JJSXBIaWErWU1XY2F4cGxqZTRmNXV1d25VMzhFRjVDS3NGRGtPTXY3?=
 =?utf-8?B?aHM1anJ6Um9uZll6SmI1MzdtNUZyYkZLWFNER3JiUUF4c2NwdkhBcnlOMFhp?=
 =?utf-8?B?V3ZFVXV2enloTmRhM0RLTjBQNWZIWlE0TjF4WlR0MWJnZ3YvM0MvWVF3OWFl?=
 =?utf-8?B?YlpkVkVKVlhhU0lJYUgxeEFQMWFxdXZqNjJrWEh1V0M2bWRZSWc1TUh5OTc1?=
 =?utf-8?B?YTlDanRvd3hsQXJqQlNhMG10U3lVMVJtN3BjTHorbUhacFZWTDl0WWhwQnVM?=
 =?utf-8?B?TG9XcnBPYXozYVFWN0phMFBKMXk2NW9BWFNqaisyWHBYY2s5Qk1wZ3dZRmdB?=
 =?utf-8?B?UXM3MVBwTm0xSlM2Q2lKWTc0aWE4U0M5ZE9uNmIvQ0ZWRWc5RDQ5ejV1aUZB?=
 =?utf-8?B?WTVxY1JHdSt5WmpvOTFCSGEwY1gyMlh5c1NqdDgrdnFCdEsrTVRyeXJ5ZWI2?=
 =?utf-8?B?cVI5enJsQStuaFk1VVZzUWFRRjhvSE1yMU9Ic0tBRDlKd250K3lEcEh4T3Jt?=
 =?utf-8?B?K1Z4L2thZWJEbzY1OWdlZGd1UjRhbGRYdlJkRndVVExNYjE0OU02NnN2aXRX?=
 =?utf-8?B?SllWdWdzcktXdWFYRFAwWUJZWXd6MkpSMXZSdXpkN3ZlUzkyQk5KRVZLU2xU?=
 =?utf-8?B?a2lRZkNhMzJxZ1VZbmNUekdNWFlCeGYrR2tNUFZtYXF6WWhaZGlZWGs1R1ZJ?=
 =?utf-8?B?V3dncmhYRzdydW10VEVBTFpVQklVK3l2QkN0SkxuZGNFd0xxTEVneGZGUjRX?=
 =?utf-8?B?bzZoVG4zY1U4dUJqL0JwNHVjUGxTNmRUK3VKVkRLZ2M5Nm5scll1VkxqRGFK?=
 =?utf-8?B?U1NCSWExcjZ5RmJPODNvd3c0K21xbmVtY3B0YTZzSkNlVGR3MDdyRWlsWCtB?=
 =?utf-8?B?N05JSHdSWmVhcWZMSnVZL0lIaWpWOHNtbnhMMms4TVd6aWxtYk1OaWRaTFJn?=
 =?utf-8?B?RnRndk15NTB0dkpQOUtZczZNeVA5cTRoWEJzWDNqK2QySHVRWDVITGxrenkr?=
 =?utf-8?B?UEdyTkp6VU02VEhXdVBDaW44d2pnRjU1UWQ1a1Evb0pmT3RaSTZlK1o5c2xL?=
 =?utf-8?B?R0R5VVY5T1FDUGpRNlh6dkI0TU5BSDNKZUNzNDdXdEIzMkdOdmJkUGJsRml4?=
 =?utf-8?B?K3F5NjJpQ2EzajR4ZGtHbnhkRmNqOVVuNm9INUNkaGdkbXRqamtjVTZiME9p?=
 =?utf-8?Q?b+RnRLQYp+yTQ=3D?=
X-Microsoft-Antispam-Message-Info: DLApDxYrWvwSCnh2ow0UEygyT1fub1mQEGQthmgE3YFnqyllkZqPax7zRnkrYAOUAfw1oH1bGi3WDrJsiCTD/BuoZasFJN2Q2QP6IZZOz2N8ZaolLGGk2ySRo6WyrT6tx5CU2EvYsg8shakQQqF9FW6TtU1WRAwSNRqTAjs7ZuFOzZt7wILTLClJx779GXBv
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:PCOZwhOxbxDBuzs13vAQW5vYuwcaVUxzMDP2bQwYcShpel1aLA3DQcWd4ub1X1vyxrohU4Agc7umKJmvGPduFkLsblAqVePVugr914G6F2+EevGwvIUPFjEdiho9p3QpFiHpmq2EDWAIjVRLhvxO5GlCQnceqgXOfs1d4hKls9V8vLRKf5gMeulwKQLh5Ta/ZfyLAsu0owUr/tUSG+jL5L9dlYuadbm3e0D96Q+CHkWy+0UHT05jOMZs2ojiPlBdevWrmvd/Yu6XypuZ/o73Qr6waGxoz2FTvOExgjicA9AdAgHVsSIgIsOBKKUTURTaw6XfeV5WzVMDPdjush+NUSspRF0QA5g0NCej6DV935yaFOGRvgjRr5vamylLjDPEB92wdUNiNCf/DIiBvfoNG6KYgQhyBrJUX/DDK+M11OseDw2Jj2UVw7IwPdVv0IEdeOF/2mfm8ABQ4DDVlvvUxQ==;5:Jz1Di/Ci85B5HqzAh1ISLLIU1Xnm63rUgBfx9hBEvsAIDYBB44ruxNOCojtoqzd2w+tZqyiw9zGx0sBWL0YT/ULEjp63I8kgKqEZai8KAdr1PYzUf70NfECr1T3KP03M54nKiOvKFPaljhaBBEPkHQRNrNDWJM7/8GLGThyGgIo=;24:pn4uQ5HUnC1v2NRqyc/LR5Y9LlZ16DL2dlgKhXw/MXp1bVU5KgVWxoVb9FzV5KgV4qMhqh/BObsnXcR/VcKEQeqBVwQRPysz1psO9ZqSKqg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:IRHo0N0o/jO3dEzMpXRGJEnxhpWTvR8V69CpdRLXYt1mh5Ra1rmPDTfv9POTWQF5IrSx8SaC+DnTzB6lpQsUcqAY45RjDKdnKGS6HLSCyQzkbx1rZ+XM4pti3tJqMK60DYbF8PsDlHaEI20R69ddQ9AaaxV/8d8XmLvMgK/M67K8WO14CYVyjdFciu5NR0osQUJL2WeXw+EFnVZde+/nihNWDvjNiUrPjvIsJF7Px7JgCNZ0FyWTGiGcJnsgd2QR;20:wxeZX9+woOjFYzJBBXLStJ6P2Kw0gMe5BrKoY+ueIkqNKpwY92cw9Q99Ys6utGAkLM529cYmDBertIVtNkoJxLPDeL6F9EaUzFki7UBedz80zR8AJ4qfj6k8aopum55okgUJZ+GFBlrpuKwLJptrstkEL6sncXKFBUieBKNWla4=
X-MS-Office365-Filtering-Correlation-Id: e49ef276-4248-4167-b73d-08d5b65bee6d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:53:48.1239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ef276-4248-4167-b73d-08d5b65bee6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070389099005691?=
X-GMAIL-MSGID: =?utf-8?q?1600070389099005691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   15 +++++++++++++++
 mm/list_lru.c              |   22 ++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e5e7e0fc7158..82f892e77637 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1274,6 +1274,21 @@ static inline void memcg_put_cache_ids(void)
 
 extern int memcg_shrinker_nr_max;
 extern int memcg_expand_shrinker_maps(int old_id, int id);
+
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
+{
+	if (nr >= 0 && memcg && memcg != root_mem_cgroup) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = MEMCG_SHRINKER_MAP(memcg, nid);
+		set_bit(nr, map->map);
+		rcu_read_unlock();
+	}
+}
+#else
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int node, int id) { }
 #endif /* CONFIG_MEMCG_SHRINKER */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7f6cb27aa2f5..6ce52f80f12c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,6 +30,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -38,6 +43,11 @@ static void list_lru_register(struct list_lru *lru)
 static void list_lru_unregister(struct list_lru *lru)
 {
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
@@ -121,13 +131,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			memcg_set_shrinker_bit(memcg, nid,
+					       lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -522,6 +536,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -533,7 +548,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);
