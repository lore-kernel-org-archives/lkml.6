Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZp+5zxA03Gz1923jp1Onz5PxVhdjb1tqc9qdZDHYq6e1Uh87647RBsCdCIowNd3ecbi7H7b
ARC-Seal: i=1; a=rsa-sha256; t=1525945947; cv=none;
        d=google.com; s=arc-20160816;
        b=LSqEmGsJ8v0HGToSpvEkreP0e/IyFADNxD6U3RnNB8YczBcIYkK6VRd+gSFx/auSgT
         I8nofVnGG6b5Lz4gKEcD38wuXL2RyYasC5e9z6Mj7MeCyW3cu8MVm0N5VJKWX6M2xNqb
         j+pKZdgpE5U5eugFVuCSdMt7hjD4RX2Z52zyKjd8FKnO0Fh9tE9YwH1gg9FSwAhhjYqX
         sYz+sEiSQnnAoaTpLszUtKY7DSIzAITFTycYpLThX95KmPGUwRsXBdVOeB4I1iYuidXD
         hoyOMMklHILu0+WYusiJ2jyLjuU3/1h86CFmHVzpWFur+LxSn+LodrLQZPtPhd2mrGH3
         qaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=ZopJs9YZJ5AStz2kEP2x8LdjSK1V6Y3zwOESzDJ3U5w=;
        b=jPIUKTii3SdDzR1K3MjFyaaUwxjH1IJNWVdDzP9OoenPG9q6zfLOSh8SfosmgsrH+G
         dclqiWfZPggrupp0CMPNefs7CBdHf0R3DdqvlzYCIp+iLFmplDvC1LWtSR4okSRcTRAR
         dFnPh03WlKSqYMnf+tqFx95pRe/7mz15+Lz6hgNL8X/xxP8d7jS0WrBcdKisQkFG3zyS
         +/iamzGbYgH7AN0PHoUgl3mrwluzPm75mVkcvz+P9nD+zI2SsXZ6Z9xZg+yXaURKRoVU
         sBAaAwk+8foVa6lnVP1VdTxW9WCvXW5ocNHaOHZTHuFIpFTADxj4sZDGUxkcOabQjy9g
         kX9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=C0JTtU2y;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.119 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=C0JTtU2y;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.119 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 01/13] mm: Assign id to every memcg-aware shrinker
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
Date: Thu, 10 May 2018 12:52:18 +0300
Message-ID: <152594593798.22949.6730606876057040426.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR06CA0030.eurprd06.prod.outlook.com
 (2603:10a6:206:2::43) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:4ewwDEueiII8n9qLdcJYEci53/q9cj63g824EwxG/5ZyjVxVp25KQMYKqjy/PfKkYISnIgMu0Fsh/dL3vXfyyE+9txtSRO7C0meEwhV8mG0uoXq2DVQ7JL6h2kzAabRfbE4cZwARsS1ZZiEjtNMzbvlITzAhFQVVgppxZ6WnbxqjpZjPHO+2pl/OwEr6plK3pGztmTANmcV0uBeNd7Ten9XSwe7Lc6DgPqnDx08JwZSSJAsERQoznpOxu/r/TSz5;25:rbHRUTmKr9aNEF3jNoBlHfZZZHLMI+YkTF0GPcj8ZU829f4JrJu6k71hvPd/bCnlvmC80Vql7fhKexB5h16k9iUlLtf9wH+X/z/PPxx1Nxww0fJotdbeGkHeDEkeyKBn8/pLnUPxRg/wx29FkHiYuZqpEKaKN4LQVBCyR157q5Rbrj5rfZ+HPNIrygMpnJduCmBnFRVt0LDIm4anqoMsTQaYVknhNDiZLjeAUiZM17XQy2KEXuG7laANFRdLvOnb2gK7kT7euGiupfqrDKYkrLnfiCtmbyqgUuWMzJ+EIc0pBKQcKMw3rnoznE5S2RA9CzdEmVdS7ULV1WP52URPdg==;31:fwNmssnbyk7v9UR+JoWlQSasvfmiTq2tG+x/JEuwUinIqVWhA78i8Fad+MgC8fsuH50pKYm1OZjlQGCt3qiujjdAhM1GCLsxPLnUK7JJrNhAl9O9kXtkMXZcDUqF7W2hpyqTDIIc/8afRZ46KhwCvh4m03wjYTKBC8CTsojumBJMLG0n/3Sygx7Ge6xRvp1PTUheX7OejhttnbXo2yU8lZug3/s5YW1cTznw7lj4OVI=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:49sD6X7HnD1htoTjaH0O9JW1N4JDPcfb7YMNFvAjDigSlcdP0ijT/boNfUtUaD1j2Bvb5OknTe9GVRwFbZ/MlQfzTWIB15c5B9xRiWweYSf5gwJMX6zehC4zcwXSUhc2oHxQG5ddGdCi5rhJMMKvFWZ7IGi9ZRJch/yxnASEY0WikJ/m9zgxzWs5lqECjxi35ugZNeLFVelWFUcaZ4wRFaF1JqVeQOgzjaiPXmkoT+kKrueuKUmaFIF7Pz6RHASOdRQL13yT7lQm1yRhEXeL1q+Ewq62zb9XuuxZMkt7Bm05frHSmID9rf1aKGJtNXz184dNN1Swn7VDUnlDai3Wd8SFTdQCvYB/4PdDqy5iCbt76okVnBbtHh/CA9feu8piubR2yRvSriiuxtDJKtGbz/yAFmoygNVLj7wDD8UXiun8Cm+1p/Ed4SY6za/JoEqgapS2BSzQu3vggkVJw080ByzOmzVJGQj2uXiLgZUotP3z77QIMkKtB8kfdZI58fWB;4:IQGPSMRk/MaiGT3SUlxWoFDhtbXbs22ZqmmwAjGGOfrP7l8W9OVsPET62+ZCZLhJ6jJFVFyLmkEPgwJ3tNOUg15ENn4ainveyWTiX+z5IAgOkBoSx8LBK8yhWsnlDKTbOxOknWm/wXr6Zzpbn0RB/+q84TbVWs8N5poAQ/y9VmTQRw2VC6UgJA1r7ox2KhHU6q5pxJXlRFP67H11avzZASmPlZ2PkPSoDbaoYXCEdb3XJxCA6anrX78P3vihT0/serPA7USrUqw9ziNZ58shXQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342BCB3ADC922B1D6D007F7CD980@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(396003)(39850400004)(376002)(366004)(39380400002)(199004)(189003)(52116002)(23676004)(26005)(68736007)(186003)(2486003)(6116002)(97736004)(61506002)(86362001)(3846002)(105586002)(106356001)(16526019)(55016002)(66066001)(11346002)(446003)(25786009)(486006)(7416002)(76176011)(8936002)(305945005)(956004)(478600001)(7696005)(5660300001)(230700001)(47776003)(386003)(316002)(59450400001)(39060400002)(476003)(2906002)(55236004)(7736002)(6506007)(6636002)(58126008)(53936002)(81166006)(9686003)(8676002)(33896004)(81156014)(50466002)(103116003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6V0J2RVZtT0hSa2xldElKa1NYSUJudU9y?=
 =?utf-8?B?ai9hSGNyWXZXREp0a2dyTTBZM05aUzFLTjduaHBETjJYMXpaQ3lheFJvTWhq?=
 =?utf-8?B?ZW1oTE9TdEZjR2Jqb3hhaE9hc2x6aWRLMFZGZWVPSXpmbnpIWVNPeHhaKzBn?=
 =?utf-8?B?a0xyS2FENTNIMW5Ma3dRaERYRUNZOFhkM0xXa3A2V3ZXM05UbS9BRm4vbyt0?=
 =?utf-8?B?Y29lL3pVb1hQVzdjNVVRRUtCUllBMkYrL09vc0FWTlhvRDJRaWx4MnZXVEY1?=
 =?utf-8?B?M2lZYStsaHNOSWxHaVNQd1RXenI5UjZjd0Rxd1dDd3BFeDNwYU5iWnprMTR3?=
 =?utf-8?B?YjY3S2JiQ1U4TmpSdUlUSitCdEc5Q0dJYXM5TUc5a2lBWUdxd3dIR3E3ODF3?=
 =?utf-8?B?S2lySmNneld1LzlIR28rZ0Y2bGtFbFVpTWlBMW91amc3NkZJYVNtTmpXeDZN?=
 =?utf-8?B?ZXZpd3liMU5mZGtFbHNST3BQcFN4czdiQVdacUxIcUdKVHRtcjNhRm9qNWRE?=
 =?utf-8?B?R2FZV1R2NjEvUW1Fc3VtZFhMWEVRWVdRWVR1TkNsMVgrdFhyTUdqZkdMUTds?=
 =?utf-8?B?Wkl4eEZxOUE0VkVWaXZ1THc1OVo2RWpVdDM4RnJtaDVBRUUxcHJFNEZ1bExL?=
 =?utf-8?B?TFI4V1h1R0xNdXFhMkZMck12MGFST2taZkdqRlRmK1FTWVdTRXpScGw1eFFr?=
 =?utf-8?B?dkJYa3VNTHcwSXZZR0dsVWxFY2VKaDYrRGtYWUJoVnMxbW9Hd1Y2dTFRcXgw?=
 =?utf-8?B?dXd5amVKNUFhVVlqclBRYTNnUGJJU3pjRTZ4Mk5PQ1pjUFpJTFkrVkxGKzhP?=
 =?utf-8?B?ZjRFTER1QjBiRW94M2l6WXpzcTNoV0RVMFk0UlBGcExGYWZKREpwR01EcWRs?=
 =?utf-8?B?TEp0Q0pXNmh6bWNOMkI0aDZ1WndnUDBFdkpES3pDWkhieFFaZzFCei82Nktm?=
 =?utf-8?B?RWpaN2o4MDBmeWdxaU1iN09ZM3lSSWlDUzQ4ckkrV1NHSEt5eU9uanBFbFY3?=
 =?utf-8?B?Nmw5a2tvZzZrRURtWFR3Yk5rZFU2MzVJMkdRdkhqL1RCckxhUWJvbW1zOWJu?=
 =?utf-8?B?a1pDbEdSaHA0MlpzV1daZ0x6eWkxQTI3K1BzQStPRHpaWEZtNkpPZG9TbFJD?=
 =?utf-8?B?TEkwaHd5SklVV1lpNk5uOWVTZVl3WU1NSTNmazMzaVF4OE0vMm9DTUlxYXV5?=
 =?utf-8?B?L09qYnVKZ2ZTU2plQStxS2gxN2IrUVhCeU9QN2JtUWdEVUJBV1JwZTZXb1Er?=
 =?utf-8?B?UStxeGVxdi9aZ3J2VDhrT3N3RUoyaXhSbURuaG5xclh4UFNmMmtJdmdqZWg5?=
 =?utf-8?B?ekVuc3FKN2NodXAxNW5leGtrc1ZaalVUS2kwUzhqRGZkbTZxYTFSZmJ0UGxL?=
 =?utf-8?B?dkRvVG5ObFpSLzFTVWtKVzdiUzAyQitTM0I4NzN5OEsrQ3hFNWNMNlBWQVBv?=
 =?utf-8?B?NlNNc1RRdURLcUo5SmZBalBBUVpTdUduMXNtOVdMOTl4enh2NWxPbWJSRWVY?=
 =?utf-8?B?K0lsV2JycGpWSm1XbjZOYWNiZFgwLzNwVktnenNzajlWNVc0a3E2M1FYQ3pJ?=
 =?utf-8?B?Vnp6Y2FrYWNTNkZ6Nlo3cFYrWnBOYWF6dWFJMjFRbFI3ZkZ5c3hiU3QyQ002?=
 =?utf-8?B?WXA3YVlJUDZLckMxK01NRk11RVBQc1RoZE5Lc2ZKR1A1WUV3YXlBTTFJczJX?=
 =?utf-8?B?V2hQTkVNQU9wdVdaWXJ5TE5oRTZhV1ZDdkhpUnFIMnc4aWUxQzFlN1Y2bnk2?=
 =?utf-8?B?eVNyMFpzOEQ5Szh1ek5QL0QrSEZaN081b2pVT0dZaGNDem9hazhXYXNOMnc3?=
 =?utf-8?Q?EmbwGpaFT9bpAte?=
X-Microsoft-Antispam-Message-Info: LA3Y/+xOiM/7zCLxxKXuonE3oHhecWfZ+4Mq9Zx8uSoBqxE5Sb+1vDYlJw5zQNcUuBnpDZ20c00DrngnZsKB4E+IzwOWmaBgacNKrxGRvnnfP7eKJgUIgZsLzX/pc+L/xm9NWRYdidwvmIpRgB9pFWuk4/qvDDzbpQwudNcQkXXhnPv0wPz+LIBw4o1j/ttE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:gWv61OXboPAtdz+OolZgU9xN+4D+oJoBoYyK3c3YPktmD4FIoP4bKdDvHguc2jYRfykBRDlknG5Sd3+vUU0aBSugmKEsaAvDYFxFr6DQ48P/1PuL8T7EwiciVYZO9esdi3iTezIHK94f9UgnQ1Skbz5WMG6kl0AirZevhCDJgsGWAcoSKAQ6z/EEA732mNtf9N5eKIA/We+bytiOWTVdo9Hn4Xk+BjOb7Uxt0k/0fI9SfJgZ4EHRK5iRxo0AQFLkqg7MJ0rBWjdaCoHBas5TBZ3dhIiRJqwafzK9dqcSNSK6QsQhvzX9sGHqZUPqAfLznyhX9KUXIC4A1qh3Lqa4gH66H3IVViBmB7cSpxAZ75JnA/ADZ98Bm1fU+ltYolpluehbunLTQ1x6ls5h1OIJzxAxbuxyLrTs/YPztjnsylvevDHgs/fcBLm6WUNCeirVcm+cMttBsqNghCw5gaLjug==;5:RCGqMlivslTbDDsWYXlHarlsUqxGJyT2SZSwMXAo3VfD2lK0o7j1N4gv1oxGlsyhNj8vSMWQ4Fj64iTSyS7Hv2cq99qA/db4UlL3W6nYP6dyfOnt9ApcCmRWFz7Wu++dfqxjQatBzJ+ZnC43Y5eBe7pbJlk0mZIKR0Rb6v6EkJE=;24:o9c/CUEb3rW/0vGkw0pfQwAC50+sBNph2HSX+3NwoDgOvXYtEaLHNsnBhusLTWrUdVYXp8dE3srIl2CNSzhPnw9zuq6wvB4n2WK/LsBdpdQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:6Bj7BnDBZzmjdYUw/z7qn0IDV7veFAxAWZqJVs29wV0RuBa2NAa+H/c11v8NCzOtFdeJ8qCnVxfRIVTzBnEXR71F2ARoEAiaofAC3pNi4KvIsR43h0tIYwsV877BP78LI2cJUwVges/jSexAhb33AvxgTSGNtsqa8WtlCU0XT4TxOqsckh/0DID8rxkZWLnMBr5PFOJTr0SRcosRDQTAs0bWft1HJC6gOmqLAk0UI2n36XVPVdC7WXhjwJxqx0Oy;20:aoYn5m6Ch+d/S2gH/bWaiWTqAldgWggiIHv9n6v0+LNnxyiM5DO9pj09uGYjyc2UHs1QeZe77sB/xyk9rX31Fdl+KfNx0HBxSMKBrAmT9KxxcknuRYPijkL7mcxNNcFQ0X7Dm4I1H4W3TXzUK/ct9H7RECvipqRZmtTVmOXLjJw=
X-MS-Office365-Filtering-Correlation-Id: fcee02ee-68a8-416a-3db4-08d5b65bb9fe
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:52:20.3706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcee02ee-68a8-416a-3db4-08d5b65bb9fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1600070298364035189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
in case of !SLOB only, the new functionality will be under MEMCG && !SLOB
ifdef (symlinked to CONFIG_MEMCG_SHRINKER).

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    3 ++
 include/linux/shrinker.h |    4 +++
 init/Kconfig             |    5 ++++
 mm/vmscan.c              |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 122c402049a2..16c153d2f4f1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_gran = 1000000000;
 	s->cleancache_poolid = CLEANCACHE_NO_POOL;
 
+#ifdef CONFIG_MEMCG_SHRINKER
+	s->s_shrink.id = -1;
+#endif
 	s->s_shrink.seeks = DEFAULT_SEEKS;
 	s->s_shrink.scan_objects = super_cache_scan;
 	s->s_shrink.count_objects = super_cache_count;
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 6794490f25b2..d8f3fc833e6e 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,10 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+#ifdef CONFIG_MEMCG_SHRINKER
+	/* ID in shrinker_idr */
+	int id;
+#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/init/Kconfig b/init/Kconfig
index 1706d963766b..09e201c2ada9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -680,6 +680,11 @@ config MEMCG_SWAP_ENABLED
 	  select this option (if, for some reason, they need to disable it
 	  then swapaccount=0 does the trick).
 
+config MEMCG_SHRINKER
+	bool
+	depends on MEMCG && !SLOB
+	default y
+
 config BLK_CGROUP
 	bool "IO controller"
 	depends on BLOCK
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 10c8a38c5eef..d691beac1048 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,47 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#ifdef CONFIG_MEMCG_SHRINKER
+static DEFINE_IDR(shrinker_idr);
+
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id, ret;
+
+	down_write(&shrinker_rwsem);
+	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto unlock;
+	shrinker->id = id;
+	ret = 0;
+unlock:
+	up_write(&shrinker_rwsem);
+	return ret;
+}
+
+static void del_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	if (id < 0)
+		return;
+
+	down_write(&shrinker_rwsem);
+	idr_remove(&shrinker_idr, id);
+	up_write(&shrinker_rwsem);
+	shrinker->id = -1;
+}
+#else /* CONFIG_MEMCG_SHRINKER */
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void del_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG_SHRINKER */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -306,6 +347,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 int prealloc_shrinker(struct shrinker *shrinker)
 {
 	size_t size = sizeof(*shrinker->nr_deferred);
+	int ret;
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
@@ -313,11 +355,26 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		ret = prealloc_memcg_shrinker(shrinker);
+		if (ret)
+			goto free_deferred;
+	}
+
 	return 0;
+
+free_deferred:
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		del_memcg_shrinker(shrinker);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -347,6 +404,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		del_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
