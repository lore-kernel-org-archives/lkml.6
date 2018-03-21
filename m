Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtQ0uTCRjlNEdt01wUx47ftLG9YYXskr1gDB8Gc55lxtEHVqU4bP1mUthavsIjnLnfmdt+Y
ARC-Seal: i=1; a=rsa-sha256; t=1521638510; cv=none;
        d=google.com; s=arc-20160816;
        b=mLF2DgXczhXs3/FGaRpjYrf678W+BjdxXz3Ebu8RE5+0LzZCr1vssaMj9MUXSc1s1G
         FRQ2KhVb9bpijIAyrxLo/0w337FP7Gw2DRDzud0aSxGj1G0KhsFV/u8T/XJLolJO+Jxo
         Ga5tjyNuEM1xVerZmhm/5xkglk4VWs9fVqIIye//RaPflhnAmJv4nvTRsDjS/J278wY4
         R9xyb5uzIYFWelFN3guITHrFTtGMs04ECN5vDpQWiy7IuvIiC68c9LsOdSRN7GlQWSmu
         mMJVVC8mgjb0EPfp8NTtR7ZZh5R/bb7HIkV1bsqoI5dFE4ITdZVhAcBsd7ks5HK/020o
         zcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=oQ+ePzh/h4CSd3nNhsnoWRsMmWIpLGv4nidzORMdepE=;
        b=JO/gufBIbalgAxulyfEoksUbT1x5YgTU03G4zkULXhaieX+GnWIfv55FN6czx6MQJb
         Z1P1KGEoMXOhMbF78uvHcrEpFQGs9ri8UcT1iHaBPDYQbaANtXpGs5ldvp+CCpl+cqTm
         8Tt8uFcmcd5W5BGI7+zcimuFVYCiQJdHmUFPAZIxvg5njua6JBgy4pvx9MC7qiplcXx3
         sHgSqyA9+XMS/Ev7aCQbLPycoWuR6xTtA86UDAWa5/IlMQNvVce3/mGEk4Bsb6uL+Hsw
         yPDqtoeAjKINHX30+y2d7zF4w3AiXsNqFNZ/ME76oqg7TrOgNOBVOhV7Vh2j/RVgsGIN
         c8sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dBWiS+l4;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.108 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dBWiS+l4;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.108 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, ktkhai@virtuozzo.com, akpm@linux-foundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
Date: Wed, 21 Mar 2018 16:21:40 +0300
Message-ID: <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR0301CA0049.eurprd03.prod.outlook.com
 (2603:10a6:4:54::17) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d764728d-234d-4a21-76a6-08d58f2eb1d2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:evmm9ZsZD853LObcRWpwoliGsbT22iBLSdYnXIQeZVUapddd64d/T9ohRqub1XuYwTHgQn1uJYgegz3kTb7vqkzZek0BiW+T8mwhQKR5Z+McU5Tw14CJhRW7V9V2/CJaTYt45X7g+a80gXkr0hIjnZiZZan76HeZ+T9zgAAm1BCKGzKmUvO4l9lYYGffdNjHfJvDOfls38gjtvJYTt7c5zyLU20MYqBYx1u9CXZncRj81A9AiVKtDYAZDN7UhvAG;25:BdC4pQNgs0Myl3JPn4NpjqwmfIflrzLvlMo2/w/pW7mrFdBVdI+j/cXeKSJfyKDnLtPO8hfybKT71d028dTN0TJBLvH0hzp0Cm44Dh3DRiQ/29r5LQmV1qgseJae9FAlqFlwvcLAx3prEaYgQ2XEyVxsttohbdDg2hxWCCeqL8rPAHDZDNJ0OpM8+I9CHrcyx3EQuHbCNUB3rQLNl2nm/anrGU7IufURJWoMsb4+a1vO4EX+N170E1GA+UUQBnKuGUBQ1hwnm9f6ZkfIiCgG40c7iNLHJuh2r/t4FOgILZwQN8zZDGm13yhahvpmIrFVe9Hu7CLLSZL7/ztUBJlYiw==;31:I/xrJ0dOBfQ1srM+/3Y2a6KN7Jhrb+5tpt0ZTlxuwfW3mUiGlX6hkiRecu2ldn6WgWieYUltA4Lia55yb2MA8HebT6QjVIT5kLNw9gjPEYw6DBYwsOmLuMCkRhbVGEfvr+JBo4gBXoQLhjMN3hLa2Yl8FM/lQ1Z3NsWVWAxOykCclO1uMVB1xw1ZyhduZhbv2rbbmI5A+AxUZUUeABiM2I5SZM9XRYMzbliMtJgutdo=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:QIrpnIpTopaCcilYcrY60wjZojZzERWTHS1T0Ngcwv9v1XCC6/bcppT+vrilmaZh6bQmbfKK4+8VMbnIkYdwu1YcKrvpe6rm1V6lcMwu5szJNmu//Y9xsGFpn48G6ySyiwiqUP5WeaBn+dVDSX9AFLE/bbqt5Ptn0jxMGUEe4P9ldS+4s6RbL9jBfcj8wmgcXD/d5Ni1yPoLM87NCEyTQxD3ysY4Lsf9WJFENPxSmN5KL/PID+KRN83paj7tXDbMplgOr0rA4welsEYNtMP3hvUopussvRRwkUzY7fPrQbfV77TUJ1f06as885jqvysWntnihVY8iyECbwMAxijoPTUdmYCL3JTOvldp8RDD4uLmUU0NmZtD3cTVGpGfM2au03xkTtWGANtiQ6bjeLOPtzxsFmnxMaKlT6WQEKWB8Mjue4VyxBX4YlAaKEtvWqG1hl8L5qFF2U9aO3uhdhgbNjVnY1Z1bI+uWflLILnVE9mNKouHLBU4eK65G8MDJtQP;4:fiC0onOltu+lFnIs4nnEv68ieoDa2uK2kAWQOZKJr+sSmmpb4FZYApCFNWqXTwyZnkRxKKXnhB4n9XYQE2S2lAAL2QdWAR3U/8wRVFyVr96t5+3trGoCYERyYkgI4FVEGRTQ+Q5letHAChGMZmkjRBenk2c7nsMFvS1DS9tG+YxuzE7zVaHDh4cgCmJO4OFNvtl5uy10y3kwm0vSXjAxJNIJ8IJPhlxE0da58qjImTd4q2B2MM7Uz3c5JP/ZpZtt59PPqe5iwftNP9cX5a3bEqyGX/lJbmbSIkL8C84NRFoHADlUVlGnTh9C9DKheEmL
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133171C4410045D7F4FE50DFCDAA0@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501323)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(39850400004)(376002)(346002)(396003)(366004)(189003)(199004)(68736007)(39060400002)(7416002)(6116002)(3846002)(25786009)(2906002)(386003)(86362001)(6506007)(59450400001)(5660300001)(7736002)(305945005)(76176011)(33896004)(8676002)(81156014)(97736004)(8936002)(9686003)(53936002)(50466002)(81166006)(55236004)(478600001)(106356001)(16526019)(2950100002)(7696005)(26005)(55016002)(103116003)(186003)(230700001)(47776003)(105586002)(23676004)(2486003)(66066001)(52116002)(61506002)(316002)(58126008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6WEpZZ0dpVzFiczFTcHpNbGRKejlvenNO?=
 =?utf-8?B?Ym9XOU5sc3pDaSs4ZUlpNjNmZlNaa2JCV0QxN0x5UWF2UXoxSjVxdy8xbFdX?=
 =?utf-8?B?UEc3WUlQRnhkN0pjNnpvYys3Zi85RW5ULzVrYktiYmd5WVZEK3J0eThDamlt?=
 =?utf-8?B?cktBbjdtdWVma3I3K0VIVHRKd3gwbU1Pdmd0Q0tFVjZJeGRvRk9TblRtMjR2?=
 =?utf-8?B?QzY4bFpFR2Y1L0VSRlhxQUNhd250YVFSRmFiSVhiV3lKUXZFZXJ6UEZ6OURh?=
 =?utf-8?B?Uk5OeTdoaFB2RnMzVnY3eHZOZXVDZ0dzZGY2ZUk5N0dUV3pFcTNvYUU4Zk5V?=
 =?utf-8?B?MlJoMlhGWUg5NFlqTmdid0h6SUoyMW5vbjAxN0g1ZTl3SUNxQlNGdlZpckMw?=
 =?utf-8?B?aG1FZGZMcE8wSDh0Z1lFVmh5NitnajZRUnNUa1NvbmV2RlZMcjRMajMydGFK?=
 =?utf-8?B?MG9UTHJLNVlxM0NPYnpJeUEyRHVSRnBEY2dIeWo1WlgxYUpWb2dxbEsrVit2?=
 =?utf-8?B?SmhFVUcxZlVGdTAzRjQwR1JSdVY0OERNejJLOTF1UzlDQWd5cmZMVlZRVXhQ?=
 =?utf-8?B?RHRycGM4cEJObXVVZVdWTEV1akoxd0tHTG85Tk5CSkJXeUFENXBwNG03NzRs?=
 =?utf-8?B?QWpuSTU2c3NITldjNG1MTmhqamJtU1hkQjZGU0VGanR0c3FzbkJZOGNSaTFH?=
 =?utf-8?B?d1ZNTW9NdmNGaGU4b2xDcDZ4WnZ5OG1VNVMyVm8vN1B6YzF5a0pUMTZxbjYy?=
 =?utf-8?B?cXBWZGo5aUgrbW9aZjRnZE5xdHBuWnd0eDFsOW5DQ3NqekY0cGVrTnNiN3NY?=
 =?utf-8?B?cm1TbFJJYytRVXBQR2tlNGtYN1BwbEdjcHdSK0w3bnRPT2RTRkQxYzJUVkJ5?=
 =?utf-8?B?ZHU0aWF4RTdkK05QazYyNERCd2tkV1JocXgveDNDdGR5cnlKdDJoT3duZEtp?=
 =?utf-8?B?cnphaU00bDZZTzBtcjhybkRCK0lBNGY3Mk5NaVpTTUttenc4WGNONHBZemdW?=
 =?utf-8?B?MzIxc25OUXY1TXZmZ01qUVp0c3pPSnBwNnJGK3M5aGdiSlF3ZUJ5VmFZa3Vq?=
 =?utf-8?B?SVFGdHB2OE9rYjh2VFJsRDh3aUFwNHZoUEt0UHR5OGdlWGEzbis2bmQ4ZlY4?=
 =?utf-8?B?aGs1dXg0SG4xV2JzWkdqeU1iZDBjMWg3L2xxTG9SNU9SNE1UbDZJMmhvSEtu?=
 =?utf-8?B?MGV6eXJBa3BxNjkvcmVMTGxPRGk0bFBoUUFqMEtPZE1sQ0pKZm90ZGZqc05X?=
 =?utf-8?B?YU02ckUyamNSUWRxanU1c2ZRR0VLUGRGV2k5cytVTFY1M0dXdW4zRHMxbjd6?=
 =?utf-8?B?cTIxc0xjT3VURXJMNlJ3T3J4WU1kWTQzK3doZnVDaUt1aDV2M1dHUTBVcDl0?=
 =?utf-8?B?bFhCTEtRdW43cjE1Z3FyYi9ZenBhWTFibHdrb3gwWWY2MmRKK2k3VzU2cjZM?=
 =?utf-8?B?TGtQdlI3YVZpMW5zcUlselpYdE5QRkI4UVZ5VG0rT3MxUzBwQUNPYmtyempy?=
 =?utf-8?B?bG9tYktHaHFkWmppU2FzOExhQWUrSW1ON0swbzlLZyttSkt6SVh2WFppVWV6?=
 =?utf-8?B?cFllN1RPd1FTbDVWdmNZcytFMmZnN21pVEk4ZjBTdXd5N0Evd0h6OWpieU5r?=
 =?utf-8?B?NTZ3Q1l4Y2NPM1pQcmVBMXo1WnBoYjVnclB5bmtxelU5UmRqc2IrRm10NFF3?=
 =?utf-8?Q?ir0GN9AOTCaitYLfg/WY=3D?=
X-Microsoft-Antispam-Message-Info: 6uFbfLYa4rgyQewa/O/W0hW2CxETnoz4Woc7e8qBA/C56oztZqylGHbOcRSguVCZI1KGddpcZODskiYC+CQ6ponVOrp1h+7zwWNEKvj21bX2A/xWUIoBCSBxcR9uPx2VRB3sn3uE5dWLjoWRPrHA22gbXwS1GUxnp/uAJVYaSl1/aks7C70XesnWG45c5jNB
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:mbnQW9xTwxGPI9BXu3mh56caqKvZnaYSVV1EsVWC9bhNhEkDhV3b4WK4H8Q90YcDSRl2IJDn9DAzER7bqa1iIpg0vyJwp9auXxZ1LO6+rY2b/H6T2IVzeCG8/odYTAe9yyWEq1WgJOOlqkje2OV6f9QwbyQWk5+FAtzh4CpfwCE8rlwhCShd9QaylJ9yj9W9jOzy1jW2kZV0nQNQh9DmEQ27nmbcj5TLj4nsqESh3nfXYjzP6a8k+KFzOl1uEXpM7r67/dbi1CGHkMKNnyfcVrZyVK4KcXrCKt6WlRMCV4U14XqBMeRWV/9qVnW27BBJr6DfD8Rj4MWSjekGDwbnJe11Cn7/O+hHhMEgqj15cXH+RwZSvWC/+DtAnI/N+vd3xuGk8nwibbVOCn3bYdpR9yzT07pr691838sfIB0A7q75ITzm39q30I2FbKkFeWdfpIAnlAuD9q8RWufAvZKizw==;5:yjbt4ry/nxRTuatdKljQuLRPtKLEew+oLN/2vGTENV9mugXghgco83mTGzkWZTKcxiD42QkqgMw4QF10TVYiQuFkff+vwmJ9d5xiIRGMXnz4PYDoRvmEEzxO+fKVID1Q9wFfbeLfiS5Ql+/Ww9naXOwFYQWjoDxtazEOLKhG83E=;24:EdEWIuQh1u/8rNDITeZC2YYl88Dlku8au7uJoyNPQjssh49F4wFcl/9QBdy8HswCLaqwWgmvBTfbHsLFbEMHBmoyNBDaJ3KKZpzuC/uPkVg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:szLbZvdA4A5jm+wJmSS5w7igCW+gsgkM3ExoPawFfYC6hnLv44OVi3VEINILVs+qhM6ZeyDQ1nU2qfKjGuBLbyTc2uxmaz8e+oJhnyjs80+DIuKefBrj2vnV8lDqi/u854/HrkeNHV3K/TPT8rmCkou2YNJXhOIAhe6deMMJYl0YzJi8HGdcKEYtIksnv/UBOSnsPO1NsMAGI8LCKbMBIxgHk9MLmQezqum2MZ2NmPT1gytz97Cm058LG6qie1gF;20:uqpzgMIbajXhX68BXdkocUQGM7zP2ixqjXIMPz5htB1/0uz8fwUjXolmnuLsIL6XkV9EYI0a/t6K7cJ2Ffp5b2QR2LIcp71OjHxBq7PXdwZENRQXYWK+rQnI2jgEiRSfN8ndZmdfZpr4Kp+sRL1N0Fap6jHkobv0lAd3f4EL/EY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:21:43.4138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d764728d-234d-4a21-76a6-08d58f2eb1d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595553622756842955?=
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
 include/linux/memcontrol.h |   20 ++++++++
 mm/memcontrol.c            |    5 ++
 mm/vmscan.c                |  117 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4525b4404a9e..ad88a9697fb9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -151,6 +151,11 @@ struct mem_cgroup_thresholds {
 	struct mem_cgroup_threshold_ary *spare;
 };
 
+struct shrinkers_map {
+	struct rcu_head rcu;
+	unsigned long *map[0];
+};
+
 enum memcg_kmem_state {
 	KMEM_NONE,
 	KMEM_ALLOCATED,
@@ -182,6 +187,9 @@ struct mem_cgroup {
 	unsigned long low;
 	unsigned long high;
 
+	/* Bitmap of shrinker ids suitable to call for this memcg */
+	struct shrinkers_map __rcu *shrinkers_map;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
@@ -1219,6 +1227,9 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+int alloc_shrinker_maps(struct mem_cgroup *memcg);
+void free_shrinker_maps(struct mem_cgroup *memcg);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1241,6 +1252,15 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline int alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
+static inline void free_shrinker_maps(struct mem_cgroup *memcg)
+{
+}
+
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3801ac1fcfbc..2324577c62dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4476,6 +4476,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (alloc_shrinker_maps(memcg))
+		return -ENOMEM;
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -4487,6 +4490,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct mem_cgroup_event *event, *tmp;
 
+	free_shrinker_maps(memcg);
+
 	/*
 	 * Unregister events and notify userspace.
 	 * Notify userspace about cgroup removing only after rmdir of cgroup
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 97ce4f342fab..9d1df5d90eca 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -165,6 +165,10 @@ static DECLARE_RWSEM(bitmap_rwsem);
 static int bitmap_id_start;
 static int bitmap_nr_ids;
 static struct shrinker **mcg_shrinkers;
+struct shrinkers_map *__rcu root_shrinkers_map;
+
+#define SHRINKERS_MAP(memcg) \
+	(memcg == root_mem_cgroup || !memcg ? root_shrinkers_map : memcg->shrinkers_map)
 
 static int expand_shrinkers_array(int old_nr, int nr)
 {
@@ -188,6 +192,116 @@ static int expand_shrinkers_array(int old_nr, int nr)
 	return 0;
 }
 
+static void kvfree_map_rcu(struct rcu_head *head)
+{
+	struct shrinkers_map *map;
+	int i = nr_node_ids;
+
+	map = container_of(head, struct shrinkers_map, rcu);
+	while (--i >= 0)
+		kvfree(map->map[i]);
+	kvfree(map);
+}
+
+static int memcg_expand_maps(struct mem_cgroup *memcg, int size, int old_size)
+{
+	struct shrinkers_map *new, *old;
+	int i;
+
+	new = kvmalloc(sizeof(*new) + nr_node_ids * sizeof(new->map[0]),
+			GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_node_ids; i++) {
+		new->map[i] = kvmalloc_node(size, GFP_KERNEL, i);
+		if (!new->map[i]) {
+			while (--i >= 0)
+				kvfree(new->map[i]);
+			kvfree(new);
+			return -ENOMEM;
+		}
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map[i], (int)0xff, old_size);
+		memset((void *)new->map[i] + old_size, 0, size - old_size);
+	}
+
+	lockdep_assert_held(&bitmap_rwsem);
+	old = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
+
+	/*
+	 * We don't want to use rcu_read_lock() in shrink_slab().
+	 * Since expansion happens rare, we may just take the lock
+	 * here.
+	 */
+	if (old)
+		down_write(&shrinker_rwsem);
+
+	if (memcg)
+		rcu_assign_pointer(memcg->shrinkers_map, new);
+	else
+		rcu_assign_pointer(root_shrinkers_map, new);
+
+	if (old) {
+		up_write(&shrinker_rwsem);
+		call_rcu(&old->rcu, kvfree_map_rcu);
+	}
+
+	return 0;
+}
+
+int alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	int ret;
+
+	if (memcg == root_mem_cgroup)
+		return 0;
+
+	down_read(&bitmap_rwsem);
+	ret = memcg_expand_maps(memcg, bitmap_nr_ids/BITS_PER_BYTE, 0);
+	up_read(&bitmap_rwsem);
+	return ret;
+}
+
+void free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct shrinkers_map *map;
+
+	if (memcg == root_mem_cgroup)
+		return;
+
+	down_read(&bitmap_rwsem);
+	map = rcu_dereference_protected(memcg->shrinkers_map, true);
+	rcu_assign_pointer(memcg->shrinkers_map, NULL);
+	up_read(&bitmap_rwsem);
+
+	if (map)
+		kvfree_map_rcu(&map->rcu);
+}
+
+static int expand_shrinker_maps(int old_id, int id)
+{
+	struct mem_cgroup *memcg = NULL, *root_memcg = root_mem_cgroup;
+	int size, old_size, ret;
+
+	size = id / BITS_PER_BYTE;
+	old_size = old_id / BITS_PER_BYTE;
+
+	if (root_memcg)
+		memcg = mem_cgroup_iter(root_memcg, NULL, NULL);
+	do {
+		ret = memcg_expand_maps(memcg == root_memcg ? NULL : memcg,
+					size, old_size);
+		if (ret || !root_memcg) {
+			mem_cgroup_iter_break(root_memcg, memcg);
+			break;
+		}
+	} while (!!(memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
+
+	return ret;
+}
+
 static int expand_shrinker_id(int id)
 {
 	if (likely(id < bitmap_nr_ids))
@@ -200,6 +314,9 @@ static int expand_shrinker_id(int id)
 	if (expand_shrinkers_array(bitmap_nr_ids, id))
 		return -ENOMEM;
 
+	if (expand_shrinker_maps(bitmap_nr_ids, id))
+		return -ENOMEM;
+
 	bitmap_nr_ids = id;
 	return 0;
 }
