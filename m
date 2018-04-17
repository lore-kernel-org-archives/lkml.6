Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49GvvQ53s6zbmJaz1epX/+sKWcgyTnek3w/AT3cWfNOMpBnj8znJ4xxwgbfYA6kdXLL7zLj
ARC-Seal: i=1; a=rsa-sha256; t=1523980471; cv=none;
        d=google.com; s=arc-20160816;
        b=SQFdajfruEm3dec11ho8vJ9mbasT6PQtI8woUTVXvjeK2Nw0NsMXLZSoqvk7rudC6e
         K9XWo74opprsTajGsszKQGU+mBuA4DxETffeIoR6nUPXHFv/LDhQ6wEBw+LJxu/0Ng43
         VBy6M+/BVIhWn+oUX7+oflatgMVKT0KYhy0cAvqZIYZ4Z8I4CDbI9kfwCDzSezgmHVou
         2EPLeVy9pCScRggHar9Rt483NT9mXJFaTwH4n3vGrclaESdvpGy/s+O5XKP4yM0rtcZ+
         qs6TzhXrUKqfzplL/HwtMLXVdQpfPVh8mLQyTnFZdRxuodslzgYvdA+m8x4YqLVM8QBH
         Or8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=gYJk9GlTnT4ztiui8wqRNk2VpDU6MG7btK9SWXHYvxw=;
        b=bNVhUZOY0teKfbrkUsYTSoo0k8AE7W1oDFNsXgDvlKaGZMKT1aOZzGASfH1JZyMFP/
         1EMSJKL5K/Tt+5KWKw63YGqnWmGQ7txXVIFfBsDuDpmkbRBeywxlfT4nR/mdRst2r9jz
         QFyWRQD+r+hNlffFvkb7Jdkvl/f6D7u54f+UGqlhykTEUxIE83Qrzk/b9TK+hKrnIYby
         s9c4plLijEG2w/kCLvHR9ELaa3d/8yVkPkIRociZktlKZqeSr+O8Nqv6ziCOVhKokB4g
         uf91TPQMjOT/JdKr+OXSge2c24NciC4hB5zi8WNDsASmJMqDkvo2jOGmHY5x3+mm6U1y
         nSXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HB1BvP9y;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HB1BvP9y;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v2 08/12] list_lru: Pass lru argument to
 memcg_drain_list_lru_node()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
Date: Tue, 17 Apr 2018 21:54:16 +0300
Message-ID: <152399125678.3456.3006876924386799577.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0004.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::14) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:cnQ7UbZ+A2vYV+20f8Hbz6HWeMfMQJEHr6eddEiS3dV885vScFguC9pUFGkhR0Xk6chluE0oBRf9gXbs0tfNLsMUQ3itQhblivWryWBs13j4mukHF6RiqQmPby/nvg0DcS7ELEUIjjzMaITVRkrnxR62KHubQDK5CifmVB72QPxslO9IRiRqmdotJDm6uWPULMztE97YJjioWdbS5dYQRNSdWDBdoGUhD+LjjZb8hExf6YKYfRdtNd+XuyVL/tKs;25:REkWZBIXo3bUzH8B/4SgdZHEXo5Twjdri2ydLyKwjQuK2YsyQ4WPLwG5OPKqxNiycUfL9wQCtXN/De6TyDj7cEGBH8CkQI/ZscR9M/xbjaMlb99mMUtHh3mOZ138iyHcW6UIlM5WZqfQSKe+sux5EHYaFaxrJnG1ri51OAcrcgYXDA7cC4LGcEkJTWP/n6FnQKapSzJPrLBygqiHe3PIUsWK8Jhlq/urFlJTHpb6x7CFdZ7sTOuAytXpqhFnRtxXo/sSS3HzDnW8KSvbodk6nct5mqcbn03KlXmJEbMBRlPPMR20Zp2kdcZfT5u+AqdRYUtHzrmYGcQb3OvH4k2OQw==;31:WZBPWpvSL7zykOEYufnbSmMbK/JjB7fttONY3GLHgTocunK+UmdRsTkWS7RM140DLtuLj5qm8MtAS2nNS1xuJsgywOvg6zZj97bRFCXpwJy4ptCdS31pn7Kv56TUZID6r7syWA2KZbOa3ul+hJ9vf7PJozMaCROldyNogpej5Qj+u5uNsieUKpXnRiamNeMSBNAmcAElr/U9LlvfLycmmyAONF4UUjHxYHbRZp0Blkk=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:fN34n1Gp/CcUEn0fnpEGvW1KinG7OKd25yMZCsbZLAhOIHXWAksZqPqvGpiPIAWWuWQeJclE8hiQeb1RLOySfel1ja2Jc2C4MmO6Th1T2NUACZO4afa/ZT0WD+1UFnhXzlqZLpQoT9peLU1R7I9LR7IyS/BfbkYZ3ZOs7BTYD3DZ29Fgh33Opf55eTxpUB8DNb2aGLcyMFNruqXASdlM9IGCbga5Jf9CpTEb2ABCBds4kvazOoOjcRyffomfXmeKx/hwIlw2In7MONm7R/svGLRY3FQEPtmCYi4pOXtrkeTCnc3zdTHdvzUJi7ErvMJ6AZIMXl1T+1eMxmWBErq3D2aXtKSoPC3SOA+MKRW/sfHyDQk6E6JF/Vteo1Y1rP3+8ximjliuSCMeRZQ336Eyk2McgYttmKdfCZHGUdvTmFs3DA6MWB8NlnZy6pkHOwEuWgUp/OxdV2dORSnUXCrFweox0T6nG5x/wRda5c57575Ccus3W9ew8UdYhIKQO3SQ;4:z5c5srGkEPL0NHcWV8RPp1xz5EwIFRBAbQNPkzY43OpYGXR6XMZhZGzuoKQgWFYftQTo2rOSnEfQXUHEoOPdARiQHcMSxfIjN4CL8JcTsY/DynS4coveaJw6gyPPi9cusHHe1LCiMhe9H9nKQxeA9cT7gXXlpZJqBCxCnKyAgpOnvS6CFWdNh9T8voE8twXuaXnbdiufquPKOLqYXrswpnDpw8EAWAA2vRQvqFQOvaLoIuCHe+qtk+ryb5X91yeaJ99jcsHA7mjXBoZVV5y7MA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332624075D138C0244D6011CDB70@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(39850400004)(376002)(396003)(366004)(189003)(199004)(25786009)(230700001)(103116003)(478600001)(6666003)(6636002)(106356001)(105586002)(305945005)(7736002)(5660300001)(61506002)(97736004)(7416002)(50466002)(9686003)(53936002)(55016002)(68736007)(81156014)(81166006)(8676002)(2486003)(55236004)(11346002)(47776003)(956004)(476003)(58126008)(486006)(26005)(39060400002)(23676004)(66066001)(186003)(76176011)(16526019)(52116002)(575784001)(316002)(59450400001)(386003)(33896004)(6506007)(446003)(86362001)(2906002)(3846002)(6116002)(8936002)(7696005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6TS8vdzRXVno4UHZqQWhlV3QzTHZ5Q3o0?=
 =?utf-8?B?OEp1NG5GNllPQmVRSWIvVFJkTXZyOHdiczdhc3BiWmxPbFoyREhYZUtkejEy?=
 =?utf-8?B?WE9MZGRTSExpZkNrcVpQSE5zWWJDelUvMlBVcDdBdXdSeVA0emFPdk5VTTZ0?=
 =?utf-8?B?TUh2ajNyc0RxWkozdmV0K0FkOHNncEllNVVwR0xEdWtPcHh3Sm5EZlRPQ0RP?=
 =?utf-8?B?bytLaExHQWluVkk3ZFg3dDY5a1ErcFg1ai9VS3BzcE9qUWduVUZMSmNldVpX?=
 =?utf-8?B?NVAwSnc0V2tha0lyZldEK2svSWhrSTU4VE5Zdnh3K1dpUnQ3dkdhZEtyckNY?=
 =?utf-8?B?ZFlLMjl5SWxtYjA4QWxnY3RDTEw5aUkzaE50ZFdSaVpNK1F5QkRjR3RBNXI2?=
 =?utf-8?B?VVlEYUovOWZWQWVEb1JGU2hobFVkMUtSR0lBVkpWemhwMjArdnFYUEYycEU5?=
 =?utf-8?B?Q2RFQ2gxVWVFcWU3SWRmbktrMjdrWUVnWkJvejJuMjR1QW9KMUJDeVVVcko2?=
 =?utf-8?B?N1hKVG9CRWNHdWFwKzZLOVpyakQwenlCaExMeUNoSVN5S0taMkxaamJQTXQv?=
 =?utf-8?B?VFdoQ3RpbXZBTFM0THJkQnRaU0JJTXBQT2RxVGlRNWdoWFg0VGJSd3NtZjRP?=
 =?utf-8?B?QlR2bFZFWjJCcldnN1hyL1ErVHZhRDZkS294K1NDckMxUEg1WE9pb0RPdFNx?=
 =?utf-8?B?aWJJbnprenNLdmd6WlZyZG9xdSs3cW5QOHAwOFh2L2xIM1d1K0pMTTdYaXh5?=
 =?utf-8?B?UkpIVTgxSkJWc1Z2K01NY0V3ZEtYU1Z1d29sYy9CUmpzdGoranpjd3hsRG1B?=
 =?utf-8?B?UWZuMTNQTzdQZlpqa0VJRWUyTE1UZERIR2tuZW8zSExWeXFjcW5kRDdzUHd2?=
 =?utf-8?B?a09KN3NhRFJVazRXUGlLZnIyUGdnbWcxNTJWbVNCWkZZOVZwdE1iZHlzUjV0?=
 =?utf-8?B?cnFVU3ViWGxwZzA5TG43VHpxek1vSnNJdHg5aWYyZDR0OUpTaEhRU0R6THNk?=
 =?utf-8?B?UDhycEFXVStBcU1wUUl2dVhGTFk0SHB2NXpLYnB3RXBLaXZFakV6RXNmRHpU?=
 =?utf-8?B?Q2RTQmJ5WDA0UlNZcVlMaTBCY3lFZ0U0NUU5RVJPZkNqSnB1Wlc4ZCtWbms4?=
 =?utf-8?B?WjBZUkRWOHN4S0x4K1Z2VUVpZWxUQ29ISFRFVExiK0Z5RlA0MjVabmJLOUY5?=
 =?utf-8?B?MURQSnJ4elBCa242WURxT09iRDRuZVd4VXBYektmSWl3bVFXQVJsQTFQSkZz?=
 =?utf-8?B?akxMRnkzWmplbkVmT3cxeURJUWNDeFBQdDF4UjdmYU1VMjlKSUsrYlN1QzMw?=
 =?utf-8?B?TGUxYkdvcFRBVkx5MnN3Nk02RGo4OW44ckFRRHJQRTArNGNrdlRWTVl4bjVC?=
 =?utf-8?B?NHZXK1lDaGNqc2xESFNiU0tZQkNNTm1SRUQzTXlOSlVOcExGZzErTVIxOEVn?=
 =?utf-8?B?K0ZqeWJLMTd0ZFl6eTBDYXB3VldkaW5UdldwSUVlZ0NhY05WR1dETHlVOVpz?=
 =?utf-8?B?QUxSK016ek9jVGFBSXQ4N0oxM09zSU9oaFRYMVVWVHY5ME42Qml0Tmo5YmVm?=
 =?utf-8?B?dkJyT0IwaUtPRkJaUW9pVXRXTHhHVHZBUmYrUkh6dUtzQXZGQ3l0MEJYNlZR?=
 =?utf-8?B?S01QL3FPeUtlVGtuTitYL0F2cVpvNk1OcGxKUmlwcUJlOTN6NkxPVStwQnBR?=
 =?utf-8?B?KzJPbm5nVGdnL2s3dlJmZkRUbHk3MGQ4czNXemEwTWk1bUY1cW00dksyOGx3?=
 =?utf-8?B?cUVvbTVTaHZlcHhaNm8ybEwrYWYwUkRKdmRIUzlyNXhOTG05TjJKVUFGRlhB?=
 =?utf-8?B?MitvcERVdDRZSWx3SFpYL283Y1d6V3NYNVRrc0ljd3VEbXRsZUVmQ2RyNExY?=
 =?utf-8?Q?5J09JpqqESpJQ=3D?=
X-Microsoft-Antispam-Message-Info: RnZkTdw1UqdMtIgSEgi67LMOkLTfLkuYcbStEXOTXmNDA4O1UlAd37bn7Fq81+9qXHzXXB1S0oyhiOrAnsoTgxKKI8hhDtliND552ishGNWTTsBJ4QCjoa2hZztn2VkvjeET+KkfDuEgpmveH7bhn4R6OqEgdufPNJllmvwt5s+BU5WHhA2ZZ6ND0ATs1ep3
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:grQ70PRqbOa/8c9ro1/YHOOBT2HaDTFvMGSJD8x3K/RSE59DRjKA3aejH0mPS6oCC2LujClHAeZpM8K46GG8ruuFOAZKZTlxOYKeMa20AK8/CHeKxxypL76hW5yUymgnLBHhe+shPuUB78ix+n61oTcOc1NMgAK+dFeqtu94l+guzuxWJOC+dYz+oFp1QVWdUhAdenT6Maxov06eiCCXe009+jZ9vS/nsm3Lf6uhkgH57Sx3p1Tsz1L5x+n3Vn0Ul6DlspB5v2IsbjvREvb3UJ4WEFHxsua9TeKzzhPLA+kFmRLesxP6Sv3D3LyGPBafqc6n5E2/+NXbEWtEN/3NMVco0fuKL6Y+FVge+blfOI4+cLe8wM6BuyOFhraQ6NUKDJtzZ5SxbiuDiuHt0RTJWth39XjZCTIAyM85t6hHlzmUu01UUDx5t2g+Jp/6ywSZb4Lvj1DI36ncCAXAgrhXOQ==;5:sB1jWNX0nJo0m6a2f+IomkwibijqK11h0If5Fd0TglmjrSkW/jr++5eiTnvxJl99sTBNXBvp8UM6MBmqEkwys4K3pMazkJhmjFsdOj0hGJ/gTTPl4NOjrQODd1dKqK49jflevfvAajAQPIwnAnYMNUA7udR6NIAZeBcQNP5QUL0=;24:asV2Qij5NNfbI6hfYb/9wyF6eUodJuXu2hJqbr4mZdbL3yHX6egVY5EkHqz1jXE6d7tfEx69okj4kQehURc7XVEePqpu6XLUSPVmq2ozOuI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:Gy3RZJKAAT2j2YKeQfDzGQuZ0rRdyiieYCF3NN9IDRlMZZD+ASA2cvTp3vOrFr6/zrvoDW6NsL0YpYIuVKCXJ3+WN39nxUMlGiReoO7XP+Kxc4TJg1Ew7a6BF0cguqIaIBQXNlfv9pfri9aNGto4J6sSX71KBjyXrR6andEyVJKTWzkgaKp/O6BS0lo2G6t3e0yO2J12dfMnK+6iOYHyRu5GYyHRpajhdvEUf8RioFKKwSg8BOfJDwz0086urdct;20:mE1ISf3sfymC1W5oxTZPlUMgdb9v3aNuH1kwfrl5qh3Y5A0bBOOVofTwAthFz9tHeE/POel3So+uEciWb2YaeW8Wy8Zz/M/DBzCWWLdK9WBEvFqdYtuLG2SE5jaolXAdPPUjILCgPOjF9jMx8Xb3bltg35x0F5yOETxwKl45S0o=
X-MS-Office365-Filtering-Correlation-Id: b45eea6d-019f-487f-fcfe-08d5a47b7fda
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:54:25.8097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45eea6d-019f-487f-fcfe-08d5a47b7fda
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009346429337226?=
X-GMAIL-MSGID: =?utf-8?q?1598009346429337226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a92850bc209f..ed0f97b0c087 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -516,9 +516,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -547,7 +548,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
