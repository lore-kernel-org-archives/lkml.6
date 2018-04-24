Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/izfo3LjNGfOqjtC2wi1tP0wbfnpsfZkvtuElZtHNIksy7bVPz2ASDb3ETVBP0K0Ki+vdI
ARC-Seal: i=1; a=rsa-sha256; t=1524571965; cv=none;
        d=google.com; s=arc-20160816;
        b=jJnAWOsc51VXlHPeMJiVA0sKdj/GDODAOc1mEMC0xIr6zLa9Tf2sxKM7TOkPBqu/L5
         PsNKTDEo9JlOQMDWULHaQGVyaL65dFTcZueTctLM2sjDQpruEG3Q8dqtoWZ5+FfFJQvV
         V39jZT4IAxZQjb1GZUYxOkMKfdpBS/wRoSbAZqqsCCw51khbM+EpgNXuaRUA1aUqysVB
         qfk9uuCnZ22HVFyXfCU0T2D5wWYIsd/kTmAU998RqpfeMUnEL8s62kAsawjUA0v6v+xt
         YyGaLCxwWhH+njDLBZkn8L1FA8aAFujKhIG1/f6GeOUpLy7GI0cefMRykAuP2hvNaCcD
         zvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=orjgtw0mtZTrzzWMuPOVXLYmwXMOAaMLrGc0DCFB4Ss=;
        b=YJSY4guRd5YsixTf3TlscjZmeZReI1pNwuW1073q8AKzwL2a6hCiE+pwKCKX2f8Uhx
         NbZpxYfQkt3osbkJqj5rKL/K+Nfqipdjz6K8eDFkodSDsPlF3bvIAF65fwYuoU2HOPeH
         0eGsmvuTqUP56+6OSxJDh/LAD7sqqywgenTAAKOrQwZyE88V4sFbH28vKowl2OIxW4E3
         Ik5MmRQCTOKWb/04cKhlKN9T2TzeJNEyBGP12KNB4IcRCRE3TinpThiwAI6YW/A267eK
         5YFu2MVe4bg5CsR8PoIniAQVuQRMXILCDLtS9v9JkIgvIjoeI5xFrkU95uudyZi+r3o6
         phjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=T/Q0YVOB;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=T/Q0YVOB;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 04/14] mm: Assign memcg-aware shrinkers bitmap to memcg
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
Date: Tue, 24 Apr 2018 15:12:30 +0300
Message-ID: <152457195067.22533.15993784850619081817.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::18) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:9EmpCUqQ5iIppvLX0+SeEgrXNoJsukdQ3zhH1HzgeKUuNo52pzoo844qmzlM1GbbsioyorLLUMuOUmuHpPpQph9SNAC3iUMXnSSNx3waghKLokwNvIrO5MTdt9G9upIx+Ic3e/xumXBFLX4UkEAlH52rEofKSo8bOEqCgn95339af5X/nAVZ5/RhSVqD8PFMFnzMTjFfZHYhy9i1KuDcOPYB2P3YlbQNEFOx3sB9SU+Xi3Vh/5O0ai/wxBjBHITa;25:kLKraTa7m2+/TIUXqlHZJL0mEQYprRG+eSJhiukni+U5xcZeKrHFJDMe+kcpyqlgnG4cgBtOhQWF+vPo4q+1tsjLi/ZP5aA8KDh8LTY8vF6jI4llQfbQDk2CatlhPjB8+jCzv7FvG+qzJvSq7w7laenYdiDalI9d4WdvPoLw/5iRu5MusrjPIMDyhnTt5i1o2WJ5NnNhf5DQCJLJZGqq4++k/dUdg1y/atXhB+fXexlKq56ASuLNWNPxZ0DHyt5nyztcdCpK2ckXtpAfsL9WULbkRqTQ1ODsx0S/ZRmfjcToqGzxeOpPMqRFJ2ska5suonaGSMCTyly2GhYUuZgq5Q==;31:UFCIFZHGYj91Jujwfix5a+RpXq752Q242uQqyuH+gADzYTT5M9SC1u7FooHJSmLQLH6vAge2gaokvAOyRklY5vcS0FeMcO8lfubII22BYPSIpXlu9JYf1xqcXsPKmTa2W6WC9uNR4hIWSCO88AY8rHi2W44TkAlLVpj00x+eOITB1+E9xHTp3bxmHx+MSUYuOXwsLIW1cYJQEC+MjvntHN/z1Kqb4b7CqoR/mubP+qI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:ey6EsRAXNRvK3/znhdTyfYev1Uxz1IfXv0J3dedyAJJVuzbFnMRXTCopo8c3r7xbtEO/V/KOqhRL6OYJ2gwVxsDt/LTbgPGp3lYoiwZxj18gFHe5TBrXAxi++DmmEwsYb2GLkFwHjKDO3RVvwGQWAEM+TDN8ya6XTZ+k1k6Vlfo3pfWKsYp5lwCtnfCbrcMuqaIVpX5mdAaiFZkNzaCAessLg/Al9l1NbC7S32qxmpAN+8vVpqtZGl23/SZG9sqGSyAqOzzPx55p8VVQNTj/krrBB+hZe6sfHs8bY6iejVtPIoiY3Oe+kkRC67pBDSYy9t/itzFwO7Xc5qLP+tjHk31Fm8F3/6f8rbhBaEp6mRB9tjByuxZrDzxLKGmIb+1bIcvf6kAd3CnY10rR18spHQe3D3Q2t1ZsSm1Vn0t67FryPvDgYkweWWckX5Bm73IW66c8xutEs627M3VD7Iyr8J67C1taz4vw2+1UnJm3BJlB/MBzVktM/0izlWe8MdaT;4:G+qGs1QZjeaD3yktTghwnKHWUuckB9bPUGgKSEr+IbWUYNMGZX1ybC7EvK1ANMIaQi8Mn+wl4u822w1FCUTcjMwLDq9G5txZzF3rSqSaQ3H6/v7vV3Km3VJcfNnNfZDavykEZBhb9nDy+yZKq/zT1K4VxR2OTKdVVQmxXSrlRezEzwqiL20MbS85c6KhlG47gF6PB1TvF9olMA/MBUY3NBE3MilSxV0/L0j4LsZPdAy20ju9rpvdTSa8cUbyruLVr4U8CrTAUQy858818ytY9C3++BENHuEcBDwQaGbuLy8Of//p07p581b/GraIEPLu
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13314C24EBD3D87C7421B35FCD880@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(39380400002)(346002)(396003)(189003)(199004)(956004)(58126008)(68736007)(6116002)(476003)(3846002)(61506002)(446003)(81166006)(81156014)(316002)(8676002)(8936002)(11346002)(33896004)(230700001)(97736004)(7736002)(5660300001)(305945005)(16526019)(186003)(486006)(39060400002)(575784001)(86362001)(6506007)(7416002)(386003)(6636002)(6666003)(59450400001)(106356001)(55016002)(7696005)(103116003)(2486003)(47776003)(478600001)(55236004)(23676004)(52116002)(9686003)(26005)(66066001)(105586002)(25786009)(76176011)(2906002)(53936002)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6UldMSDhxQ3FOQnprem03K2FYY3VSNW5s?=
 =?utf-8?B?akdKdE9VK2RKakNYTHo0QzNXZEJuRnlRZmRQK1YwRHlLdnZGVklDZnQ2L1li?=
 =?utf-8?B?NWs5MmRqcFBOWTlNM1piMnArcDFZSHZ4WUlVNDBIT2Z2RzlsNmcrOTZ4QmR5?=
 =?utf-8?B?dmw2SFZzT3JJc3R4VmpaaU50ZUx5bW9wT2E5TlNFSmhKSHlWV0V3bytYUXRw?=
 =?utf-8?B?bFN1VDI3by9JRC9WNENLTUd4ZkUwdE0zSGZQNW9qM0doODNoS2FQYkkyOEhU?=
 =?utf-8?B?VmdGYWQzSjliVThWOUFTUDNTOUVxdmN1Z1orWWpCZFNqVDZWdmorNDgyV0x4?=
 =?utf-8?B?RDBvUEdjZm9KU2xZTjEzZFdFOWU2cHFLUGtSTm4ybDMvZC9BS0VwK3dEV2Zr?=
 =?utf-8?B?WDhlaFQzcUtodWFtN3ljWS9BY1M3amwrN0x0Z25neDljVG1ncWkrSDM1aWR4?=
 =?utf-8?B?dzlQbkRRQnpkNWlVNnIxTjMxWmZ3eHBKbzRmaEwzbE01UWFYVDFpajB6Q1ZE?=
 =?utf-8?B?M0pKdmRjYno1VlI5SjdwOW9RaW1ENXdNWWJJQUNxbVNxVDdkR3R1STZtazhK?=
 =?utf-8?B?WHRqQ1NNYTBFeFVuSkNpS3ozYTNSTWd6S3dKUHpmMXZDTGJ2UXhkVkg3ZTdi?=
 =?utf-8?B?S0RlRVZCRjg2cUVtWFh1cHQrbWpFV2o3dlVCYjBFWXY5VU1yVFBzT0trVnlm?=
 =?utf-8?B?MGM3b1IwS2I2V2trSXN0NUJzZjZ2eURETHo2OXgycTFIRW9ZcjRBZ2Z4MndQ?=
 =?utf-8?B?cUZMbVRIalpZYU5OZkk2NWRNRlZTRlltMjRIbUU0NXhBZWt3YWpZOXBPSFFR?=
 =?utf-8?B?WDE2Z1JETVdoUmQ1OHNYeUwybTFSTUQvaTRpbGQzU3hnSm4rZ09IRUlpLzYr?=
 =?utf-8?B?ZC8wZTMyUHJGYUUvY1REL1ppOE85YmRMaHpka29sT1BGTjJhTm9MSWluV2RO?=
 =?utf-8?B?ZmJsTWQwMUhFbSswaVZDTTc3ZXZ1UUJzUElKVytoNEJkUWVaakcxQTVvUHkz?=
 =?utf-8?B?WGJHSld6WEFCU29XeGdtTHpTRXRnQ0JLanhWWW14VnFvMENRdkR1U2NFK1VL?=
 =?utf-8?B?SWx5L1NsNXJFTUY1MUlGa0JKMWc1R0xWbVNMUnFoS0pZUFV6bkx5RlhValht?=
 =?utf-8?B?NHpTaTZkckRDRm1qcW9TKzJiV1dTK3QzMHhYYXB2SDFVem9CSmE2bE8zcGI4?=
 =?utf-8?B?TS9YWks4M0h1L1FtUjRiMVVvUVlEN1I4aHpGQSt4U0YvcjlJaGlVTUcwdWNv?=
 =?utf-8?B?U0lWWGZjTzZaanc0UEx2RUdOcXYyREVRRFRoaVhua3hmd25BRXVOTS8yVzQw?=
 =?utf-8?B?RFlUNXlrK2EwRkc0RDMwNlFlcThGTHZ5NmpkNThzYnBub0pTbzJYeGlzSDdL?=
 =?utf-8?B?aHltUktyZUthOFZaMjlPNzJyc0E2Z0wxMzAyK2RUQk53V2VhTFJ2TWUxMzNV?=
 =?utf-8?B?YzhYcXQzVkhqcTByQXpNRHZVV0xNZXF0TzcxcnAvZWFDK1NiZWlqK2tmSFYy?=
 =?utf-8?B?T09SNlFQV2JEZTZBQk9tWklrVW5IeFd6NkRCMm9jNEh1aytWeXpheXVTUDF1?=
 =?utf-8?B?c3UwS0o5aitEcVk3b2VIMUJDTEFSYUtpaXFkS1g4Y0lzdGRYWDlDeFgvZi9l?=
 =?utf-8?B?bnJMWjNZcVZXSytxSERFY1ZZSGNZSkFvTTJlYkl0MnB0V0VxRUtvT3JKNE0r?=
 =?utf-8?B?ZDZWc2g2U1ZONHhiaS9PWDdIVUZxZ3RaUU5BeFdHbzhjTHNhQ0FFRDBOR3k3?=
 =?utf-8?B?ejkyR1Y4UGhOWjR1cUhwNmhxb0lxSzlnSnFJanRNc1E1Tit5aUtobUkveUt0?=
 =?utf-8?B?NS9GTWdOT2J3YkJrWC95SklZak9BRDJNaTB1RTB0MllvZDdOZ1pXK1FjejhB?=
 =?utf-8?Q?ZobvmLGXFbEfA=3D?=
X-Microsoft-Antispam-Message-Info: yNsIi4wRDX8lCmuSOUYRTLQfpJJOAHlc1FTR39SGhirJEJdMr13i5322auP9v7f9nO+dXB5C/i+JEyZOhWHyzCcEWhTKkx+NgTWt1YCom9jhRWwwYI8swOa6OgMReu9IT8kmjqXPGo7EqirCnmi1YJbkit3GnbYn79nL9s9lSzkBMLG0B9RtXiaHN6uUTRZ3
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:JsAtJ4mee25bv6HAzcXAhuinWSiAOMj1xLi71AhzpUrRW4Ha+vRyYvuHVzSDIVIKFnLwHWZRwIsPvDy/RFY42dex4FMmZRfKWGRBEJLdfFj3eEhQsMsjz14+aFMwMVEvzCIdqGL/ntKRPeSl5S4MUVgAsWLCw1toedtfjQPWhSQ3Ix7tm0UigrUNp0m6VcDVVev38xrckFHyTH5nhjnpIFEDgQDgNtVp0U4ESYlBZGdum6R10iaNavLLMlAUAfcDGXs1N/fSR5aE1KlXaxEoFrEh89lNDXgwsnJOvygkCAKz1NPibI6pS6qgl7BkAlbIa8Bn3cLtY2NT/QnnD8+MuboCrILT+6kM5/gSjGc2Bqv/r6ThCM/hXwBVKCsYreb3ObULHi+6NsmHvWJo8IL5I0mU9N/EaM4BepBFRhtpKCIv+yRWy0o9uuLKimN7d4lPDwQD3rT/UYMEwbrzSna7Bg==;5:W4iSBK1Z2zmQ5a+s8gBoHHHe0lRMH1XVfGp7dv1+ybgEmHXOVgnt8wFXngFbhcofBsc2ZqckAD0FlMHpukU/zo9hQIImbJ0lWUFGfBypCl5FUGFoI7lmn31qew7zyRpSnTKTO+s2cTYMALSHCNiOeayjO6aat3yWJc///CzQf84=;24:c0rT6+wDSAmZNfJT2nOl4h1gs+0vgCMUlX8xqB5mbncZkSsIfN6CIQqCCnE5hrsGMB6eEfpyRFstwYtIgpyNaK9a0E6bssxWa8Hca08hC0c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:HhErQUhsX8S9i27Q62QfDPEyiemboA8JS41deRtvcqZl68eR0bxz3eU24F3GQroLKZ6pw3C0LrL95+klgrPGndLlrt0eVbSa1TXEyQ3ioKJDQlQm3WFZxIEj3lknrXCOPUJWs4E2ObGiR5gkI7OJSTwXuYxjPyv387MjoT2fVonsMkeU5XNJwh2q81usUKMTP52YuS0R5PrdXxR0hUgJpxclT9WnV4QG7kVUEhEdYcqI8155q9bXC6ze/z/qkXwr;20:vKzv+5Sdq2G/xjHBBxQlGCRqze+O0CD8RpNIh4inwPgdIHl4BepmCjAZn1NZKU0p584exeO8X1opQ4QbM0cNIrmnpQ/wG56IrV/SuqJ1M3anxbUO3UJzt30ib12bRSrNRojrtj20/5c/vJS0qUjZ8pMLPLC2iQgBOtproIf0e+k=
X-MS-Office365-Filtering-Correlation-Id: 6eaf6e18-8664-4aac-fcc7-08d5a9dcad35
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:12:39.0425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaf6e18-8664-4aac-fcc7-08d5a9dcad35
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598629572866430565?=
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
 mm/memcontrol.c            |  118 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |   16 ++++++
 3 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab60ff55bdb3..44c5da330c0f 100644
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
@@ -1204,6 +1214,8 @@ extern int memcg_nr_cache_ids;
 void memcg_get_cache_ids(void);
 void memcg_put_cache_ids(void);
 
+extern int memcg_shrinker_nr_max;
+
 /*
  * Helper macro to loop through all memcg-specific caches. Callers must still
  * check if the cache is valid (it is either valid or NULL).
@@ -1227,6 +1239,10 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
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
index 38523c8ea7c9..76fe156066ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -305,6 +305,108 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
+int memcg_shrinker_nr_max;
+static DEFINE_MUTEX(shrinkers_nr_max_mutex);
+
+static void lock_shrinkers_max_nr(void)
+{
+	mutex_lock(&shrinkers_nr_max_mutex);
+}
+
+static void unlock_shrinkers_max_nr(void)
+{
+	mutex_unlock(&shrinkers_nr_max_mutex);
+}
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg, int nid,
+					 int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+
+	lockdep_assert_held(&shrinkers_nr_max_mutex);
+
+	new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	/* Set all old bits, clear all new bits */
+	memset(new->map, (int)0xff, old_size);
+	memset((void *)new->map + old_size, 0, size - old_size);
+
+	old = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
+	rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+	if (old)
+		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+
+	return 0;
+}
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
+{
+	int size = memcg_shrinker_nr_max/BITS_PER_BYTE;
+
+	/* Skip allocation, when we're initializing root_mem_cgroup */
+	if (!root_mem_cgroup)
+		return 0;
+
+	return memcg_expand_one_shrinker_map(memcg, nid, size, 0);
+}
+
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg,
+				     struct mem_cgroup_per_node *pn)
+{
+	struct memcg_shrinker_map *map;
+
+	if (memcg == root_mem_cgroup)
+		return;
+
+	/* IDR unhashed long ago, and memcg_expand_shrinker_maps can't race with us */
+	map = rcu_dereference_protected(pn->shrinker_map, true);
+	memcg_free_shrinker_map_rcu(&map->rcu);
+}
+
+static struct idr mem_cgroup_idr;
+
+int memcg_expand_shrinker_maps(int old_nr, int nr)
+{
+	int id, size, old_size, node, ret = 0;
+	struct mem_cgroup *memcg;
+
+	old_size = old_nr / BITS_PER_BYTE;
+	size = nr / BITS_PER_BYTE;
+
+	lock_shrinkers_max_nr();
+	for_each_node(node) {
+		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
+			/* Skip root_mem_cgroup */
+			if (id == 1)
+				continue;
+			ret = memcg_expand_one_shrinker_map(memcg, node,
+							    size, old_size);
+			if (ret)
+				goto unlock;
+		}
+	}
+unlock:
+	unlock_shrinkers_max_nr();
+	return ret;
+}
+#else /* CONFIG_SLOB */
+static void lock_shrinkers_max_nr(void) { }
+static void unlock_shrinkers_max_nr(void) { }
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
+{
+	return 0;
+}
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg,
+				     struct mem_cgroup_per_node *pn) { }
+
 #endif /* !CONFIG_SLOB */
 
 /**
@@ -4265,7 +4367,10 @@ static DEFINE_IDR(mem_cgroup_idr);
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
+		/* Removing IDR must be visible for memcg_expand_shrinker_maps() */
+		lock_shrinkers_max_nr();
 		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		unlock_shrinkers_max_nr();
 		memcg->id.id = 0;
 	}
 }
@@ -4332,12 +4437,17 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn->lruvec_stat_cpu)
 		goto err_pcpu;
 
+	if (memcg_alloc_shrinker_maps(memcg, node))
+		goto err_maps;
+
 	lruvec_init(&pn->lruvec);
 	pn->usage_in_excess = 0;
 	pn->on_tree = false;
 	pn->memcg = memcg;
 	return 0;
 
+err_maps:
+	free_percpu(pn->lruvec_stat_cpu);
 err_pcpu:
 	memcg->nodeinfo[node] = NULL;
 	kfree(pn);
@@ -4351,6 +4461,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
+	memcg_free_shrinker_maps(memcg, pn);
 	free_percpu(pn->lruvec_stat_cpu);
 	kfree(pn);
 }
@@ -4406,13 +4517,18 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 #endif
+
+	lock_shrinkers_max_nr();
 	for_each_node(node)
-		if (alloc_mem_cgroup_per_node_info(memcg, node))
+		if (alloc_mem_cgroup_per_node_info(memcg, node)) {
+			unlock_shrinkers_max_nr();
 			goto fail;
+		}
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, memcg,
 				 1, MEM_CGROUP_ID_MAX,
 				 GFP_KERNEL);
+	unlock_shrinkers_max_nr();
 	if (memcg->id.id < 0)
 		goto fail;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6c986c07dd75..5f30e33faed2 100644
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
