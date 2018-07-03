Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3DAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD9221A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UoM2oaGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD9221A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933043AbeGCPIz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:08:55 -0400
Received: from mail-eopbgr40112.outbound.protection.outlook.com ([40.107.4.112]:56576
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933021AbeGCPIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc6BDwUXiMjS9w9wAYeeXkVcWjIsAaqoL2JXEy2n4Ec=;
 b=UoM2oaGPJEDvHvbQ1ZMsz4on3RANG36RKaWyDV9xKt2gCfdnGW2p4ZqkmR9A9mRmYKDUe+P56uxQJGN2ll/yN5HSQVmaW02tOzkMheBDn7LQ4DnC1VUSgAlunhdLJ70pHOsKWjIC1s+4F09TA5RDDkL/iX3GBDEu2CVAyjuOSVw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1330.eurprd08.prod.outlook.com (2603:10a6:203:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 15:08:37 +0000
Subject: [PATCH v8 00/17] Improve shrink_slab() scalability (old complexity
 was O(n^2), new is O(n))
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
Date:   Tue, 03 Jul 2018 18:08:33 +0300
Message-ID: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::43) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3cfa31e-a106-435f-8da4-08d5e0f6dbe3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:WjDodZySd4epHfiWM2WS5W9pPsip9CrNNH5wUVp5SskMWh2RiB58od/GnEnVaIR9Nqr2B9lIse8RPJkclUidEB6GczoFmPiLyvklVM9B2MRUu+2VTLI4NdGNgk4aGVPSjLwgCtQ5KUMOxLUQonQKB5/0eZn+r5X/sF9IXjN+3sHTCCjnHbqD9/27QE/9VYMqe+z8H95p92EVPlmspIl+D8PWABP9ITKUqHYLQPQ0d8JkHDeB/fxSuU6095ATGm7Y;25:qTA/m7TqV/O2uPI30kCqoCJqKVWec4mV+O5yYIrrGI7FB3UuVycuqQRrMNYsRX7NZyNK0NmEJManXsve10U5XbgVEfKhE8PzWzAkonrq0M3zoXPLF3uaH3MC9e7bIBc5Xuqi4kvei4Q7MQzlttr31H9ZVP6Ol6DbbeJKQQJ7Ca3JboodoLaVuonWMVqv45+Pi5fNoFukYYWSFlBfaMbcsk3d/rCHlDcgMeXYGnAhmzKKB5pgMafG7FYeWO7fQpt+pOeqCqTH+UxE6aUo/bHyU4+pjgqOq9PlyhMiSrvxDSRtXP7+HS0jC/8nSvDQUFkh3rgRkHi3JiZsGUtxGn5lrA==;31:E9v1iSNEYQqn0LfMZPQVWIA+IMQqow3yxijNFiwKG+XxofAaTT87zECi6FTGOgRmROJBFKr+7Wr/VGealqxugLnAeZmldll2+h7zH5ZeCOYS9qZOhazp5mx5kO5PsFRFPR7qE5wTDwu6nzjZk9dSdNimmaI7CGCPbTjBnIXhV43hE+HWeMlVW+tJcRB4Rw/PYNJuPOmm87UH1GGdRh2fL8ewGQah0N31kIP+/91Y4qY=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:NQ5XUObNp5x2jpxSTRT9yeMHS0qzz7Y05zbvg0h4NtrWvqm/HYhxVZcv24wtUvY6llJEK9bM8452aWaM1QTQKglHBw8zvDDXjveNC/QOAiTwifKJD0KjqJMRbwebrIkMqCUxRh3OTbA+u3g7pKS6R62iWLm8YsoQyfP3PzXY41YVJIttmqHIK5HnmbbwU3kAOv5EefKgEbTQwr0AN0Nd+twtYosaqQuUBUcN2SYLYzcnh3RO/6o2Dd2k0jdbmNY4QF85kVvgMHGA0DU2CsfL1WdMgaDacU7juTBrK/Ar9IkVwasen5MZjuNB9cxMTteFQW2WUWqhr1Ev7hExFPfoAc28VlumqKpf84cQWCbFBsrb3sSyho6o3b9ukS8TEZuftlY6s2yUJ6eZbx0H88G9wskhfNb//3nNhqOdpynJZvl0WO2FKd43FjvMQSzjv6NAmt61gtxvol02FEaTUCXVjzFGoZJ9wT88GxNizXvKIA7ywwpAHG/Yloo1A5sFwlSf;4:s0Y65YGkR+0OTT4xjYJdZe509eKkVOe/3cA++JM13052EQFXCedqoCmaTlP6j6s2EK90NFsLd3/o/uOzFuMohz0k+6QCdWIbsk7ApsDAs4q4B1IUvWij/DcHwQS9w3i/WZnzc9/+KWx46VVFFVcLk4lR/k/QQVKxXtL3GsGNQgZV7pV2U7WzWj5LIwTML8htz5CjLNYAsK0YANh1bVCN95/kh9i/sCDyMEJ12piPG6TP2PvUai9/15IcVqZa7B3UMBIAmTWCH+MkODiKJ3x8KU0DcgLnD6X7ca/7dfBjdJT4FnQz29cJLUKRcoW8328dLNxVK2BCowY5IGaKlnyLTzTP+l3oE4v0nOjto1ji2S9buMuKiCyMVDQsNVjFuOwOvWd+Hug8uiWiArGn9rU3CBXgYLFOixBsBB1omkKFw6w=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330BC5C31887F53EAA2A60FCD420@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(26005)(61506002)(6116002)(186003)(16526019)(305945005)(86362001)(68736007)(3846002)(230700001)(7416002)(6666003)(97736004)(2906002)(8936002)(5660300001)(14444005)(25786009)(103116003)(316002)(956004)(7736002)(39060400002)(105586002)(55016002)(106356001)(9686003)(66066001)(50466002)(478600001)(47776003)(486006)(52116002)(7696005)(23676004)(81166006)(476003)(33896004)(58126008)(53936002)(6506007)(81156014)(8676002)(386003)(2486003)(81973001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6UmU4QlhQS3pSR3FNYW11TnppR0JEMFZy?=
 =?utf-8?B?RlNLYUFjZ1J5Z3VIRU9JMldIMUorK0JsK0MwRnVQUENiTEc0UDlYVUkxOUts?=
 =?utf-8?B?OGZGQVhsZUtyUDhqRnA4cFBoU21VKzZ3czltU1l3RG5rOUlTdGFybkVxd1NL?=
 =?utf-8?B?UmxnaXRCejl3STZIUC9pOEh1Z3NJdGRXOTMwUVlNS1VSZ2VoQWxKNkpkbE5s?=
 =?utf-8?B?Z3QrSGxlcVhOajYrUmQvVnA0eGhpaGdJcUpWRmZBdSthSmdKVERpVW0vY3ZK?=
 =?utf-8?B?SUo2WFMvMG5jUmtxOENQUjBLdXB6NVo1YzhNblVnc3IyMlNidFp5ZjVTQ1Qw?=
 =?utf-8?B?TGE5MTNLTUpiNXAxSkE5VUo5eDlWb3F4T1RJVjdQbTM1WkxkTUVOazErbk9v?=
 =?utf-8?B?LytYT3NiTVZ2SjIxZ2NQTUF4VVplWGZsSTJyNFZoZVIwNWVlNEdnUUFobUxL?=
 =?utf-8?B?ZmFIb3ZBZ1hyaFZzbGNZTStLTk9rRHNpUFhrWDZDVzVLSUdPVkVCUHljR3NR?=
 =?utf-8?B?MUdhVzBYZnMyektCYjc4L3AyUGNsN2ZwRFQvK3pOL0lFSDRIN0V3bXNGNGZJ?=
 =?utf-8?B?WENUWlRjKzMwb3h3S2lhaEtmRWhKSzRkNUxCYXpzdC9kaUtVd2dDclJaKytJ?=
 =?utf-8?B?NTBCcEpFdURUbkt5ZmNQdXZKVXBxekNKSldaa2tyOFU4MWhtTmIraVJTZ0Fm?=
 =?utf-8?B?SlA2blBZd3Z5QXp1eS80MWZET0NHTUd0NEdVM3JUY3hjRGtVdm9GWUJpWG9N?=
 =?utf-8?B?UjFZTkVGNHYwQ3J1SUZmT1lJRHRaOWVUVHgwY29FdFZJdkt6cytMK1N2MnlG?=
 =?utf-8?B?dWNSL1NyUHM2Q3ByMWJ4NUpMelJjdlpGVUNMZGdKNVV6Yk9Zek5yNUNvN2tB?=
 =?utf-8?B?SnZOYVh5bVJxdDUvaytwYU03eFV4YXRocGZXTnhwdnFFTkhNb1JhTW9mZEJZ?=
 =?utf-8?B?Ujlxd3pkcmtsVFF6WUd3SzRsUVdsaVBzTHd0NVZtZEFQQjdpWkwvVTBaZFRj?=
 =?utf-8?B?L29LRS9qMlc0bnpLM0VjYWZJU2xhMHhla1A5UG44QjUyZEtta2RMWGh4VHpq?=
 =?utf-8?B?TXBmaFg4bjA0YVFTc2xqNjFnTmtFTDZiRi9McEdOOW5kT2xseW44ZEMxaUo1?=
 =?utf-8?B?T1BNRkRhWmtNa0RZeG04U0JIeDZoMkNtdzEvM2s2WVZNc2ZQOGFUQ0tuWEx5?=
 =?utf-8?B?K3pZY3FJV2hwTndTR0h4WDhsRVNkc1JESEZsYnNXakZxS1lpa1lEN1lzaXRa?=
 =?utf-8?B?R2lpUFR1V04veGM5U0E5TmpGUUZUalVnMEhOMnJ1U2lQSWVJV3RxWW5hNW9W?=
 =?utf-8?B?ZXlzSGRLUUIyRVVuZzY0bWlUMFVVTCtMVWJTNmtpTVZGRHZmd2RtNjAzaFdU?=
 =?utf-8?B?ZWg0R0FkU01BTmx6SHZTNXhQVDBZV3pENlB1SHBQVEJxd3J1ZHZMZEtMNjI0?=
 =?utf-8?B?MWZBQXV5Wmp4d3dJQ2JaWkRENCs3czdyVFcxQ0dUVkdyaURnOW9telYwZnp3?=
 =?utf-8?B?aXVvaUM4clRKUXMrMERLS0QzVy9qRnp3UDFQZ0wyZE1WckhEeEQxTDJRMnEz?=
 =?utf-8?B?bUlXS1RZUEl0SnRIYURwcEI3c3FqS0hlcU5KOFZjc3dHR0IrM2ZHcTFWUzRj?=
 =?utf-8?B?OEdERitmWWUrMkRybCtRN0E4aUdGejR3bFB3NDl5NFUvZ0JRUnRLM1RJUUVw?=
 =?utf-8?Q?iXPqHuBo26I3Pd3vEYZs=3D?=
X-Microsoft-Antispam-Message-Info: mOs1VUM4SiUkUlDsY6vA1h1voaICEG+Vjr5AMO1fKttkj4KTWY392v3VadY34HZm56UctslonspyYAZx0CPjxtI0M9TxRQFHi6j4igyG0T1q+KjxvYAPekHeGF32DQ6Fpm/5McYdvgjK8KFm8xj92efNQ6y5gMVC70kP5phMWRpT4zrxC3vKBqf533ix3PHsP61roryb+ajpfQ3gSw8uVXBTTAJo4L/f03mH7oP9+9DRtEKS7rbJyjIfu3OaUvRKoJ6tV9jd6dxReGb8/3p/JKxYXLBgIjSu6Aa/95vSR5yHl/g8IyRb80Y19GIj9W51LSWFNJVqOptIwrzz2ES5wfOe9INQfRiFFIChDmDqZJ4=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:IYaySfnRqGmRFambni4UIEonXuCBgZw0aVQJUYhwZkJD9TLTZjLMTHZNwsC38fJaY1iUxq4LEDF4CvWBmw8gEdXYKwJE7ZCamaegCmJOe+L3JD7TzXidcm+rNNdeHZmfSTykI4pVhXxcCdFaQ+4S0G6Tq0NEr0u0siT+T1i89kUQb2Pkz57cE53PzgB9yvDU0TDdNnav4kqSIeOjrTbovjcmr5h6vvPv1FMtIFOEEjKi0wLNvK2CxKSDWov/8GySxfmao8r8QRS3UuozK/gsClYWEmeZsQtfda39rB3O2hH7W05IbGR/BSgzAeSKjGTOhbrKadWWk1xhwlhvgw+MP3VDVSqz4BZyaw05JGbdRcdkjJ2ceZuQEPs/127I7pqLrtLMCJKq6OtZlrfuRmV1Tozid5lVokyKVhxBv9nRbp5G/KAK+5Bw2WrnlJijh8o28TEQp17KiszqsKArZ453vA==;5:jfklekHstB5WMGhBSkt+tvY4CLWqPeQy3uYa0YTS0Mw6CTMsPtnWtwgn7OBW9rBiH0+ok9PymVfIE5JL1oKaKuBM0hXlPKCs+j/27D1GVjF+iKgkgGR6eX6EgPruDypSYDC5A06VUp/XOJEZN0mjASVkEgruYtMvaGlc3OKtn7o=;24:m0wMb2A604m2vDGw9ohOF2vkw6PJIV+ATl/3EsiVaCp8Xb1R+wzouL2lAB4w2in0hF0yIwt+tVZhqiKx5LSmCPEAsFFWvXOPWWuoVaquguM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:EIKFqT7f8bKjxMZ5a5LUmreXLB5yWmvyJLRzr0fLCwzA44AQDGmkS/Y+CoMRtt5mM2w3MgnYPiF0PxiygGKCgokZvh6aWxmL6QVjzpPKbsyEJyRVppDYWlEIE5R2yMHon+BzBIpYkztSODjzShR+C/UoURDe7uQ25NjL6fL1ilyRvVdRLb3gkp8R/HRbpDuuPBfTK1NmKNxdRezF80P3Xh+fUG1mZnYsnird09EvNVsbIubueXoy+Izpot6X4OU6;20:iu0euFlGvW76fRUK3yuF3wWEn+WJ1gRQ7sNGfgwTkMyX++uM7awcWeZczDZCliR8YpHdEpnDie8+K4mha8kuyLvm/BJAtps+H/p8alFsTBA2a87FUlIMxdnvMkoMp1IcdutK8TgghU/q3KKCI7JoW6AG0m2kfgoJvxTTNxE17bo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:08:37.1620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cfa31e-a106-435f-8da4-08d5e0f6dbe3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v8: REBASED on akpm tree of 20180703

v7: Refactorings and readability improvements.
    REBASED on 4.18-rc1

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
      mm: Export mem_cgroup_is_root()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Add SHRINK_EMPTY shrinker methods return value
      mm: Clear shrinker bit if there are no objects related to memcg

Vladimir Davydov (1):
      mm: Generalize shrink_slab() calls in shrink_node()


 fs/super.c                 |   11 ++
 include/linux/list_lru.h   |   21 ++---
 include/linux/memcontrol.h |   46 +++++++++-
 include/linux/sched.h      |    2 
 include/linux/shrinker.h   |   11 ++
 include/linux/slab.h       |    2 
 init/Kconfig               |    5 +
 mm/list_lru.c              |   90 ++++++++++++++-----
 mm/memcontrol.c            |  173 +++++++++++++++++++++++++++++++------
 mm/slab.h                  |    6 +
 mm/slab_common.c           |    8 +-
 mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
 mm/workingset.c            |   13 ++-
 13 files changed, 479 insertions(+), 113 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
