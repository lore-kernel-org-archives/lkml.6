Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZql0CLmEXZJL1ZH1TgxMWKYUQlZdWPlXEIExnFFEDEEuAEb7A2aUoo3MMMNU+q633zqGSVi
ARC-Seal: i=1; a=rsa-sha256; t=1525867107; cv=none;
        d=google.com; s=arc-20160816;
        b=UHYQmMhxI2mdbuXD3uPkuMdCC6YXe7XSQ6ishzZ4MJa9GX/ytwdUL6PYZb5WP0VaEg
         T37i615LwTX893lgy+nQXEmZMpFm55Tal/ODhizaMLXWcaVtej4fpVUJd2i+2MlD9UCq
         MGoQDnt2qxSf+dxVz21/jEXDtJ1SX7zLwxZEytCgAItvac6AnU4dLqGvuNwTW0Lz+vJW
         0oI4jnwqMsKlVl832jUmaTeMGQPUyYrfIgpFvp0taMDazTcahkO8+QsDTnCtc19ZS3E7
         0rwZYWHsmXHjOGuEfZTKeaK+oxVUpRZPjwkOLh8iUJk4i93kCeUEU3eujtckHfR16T/t
         TeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=gYJk9GlTnT4ztiui8wqRNk2VpDU6MG7btK9SWXHYvxw=;
        b=oz9ScwVcrYwAkjmMcLDBpaJ18DvzR1u32kyTP7wkaRztslWoWfceERsGFmG8j2PDRF
         C3BRI2133BW+BMvMw7EYboZjlSSR6g0JXhLRH2nTWB8U+9167s1mgJ6xvUZV5pLhlDIs
         WKAWG2pl8mn9U831wrEFVgJkansLL7E8w1xfyvUwvOgx5UW0jBbPYQ1qvAYlpQAma+iL
         TqpKWDUNS7mrUJ/6VFA1yrULZwOiQ6fiwxv/LUD39zSBeGLyhAyTRA8RUqpZhbl1aDqs
         0bj3aIM1akEsxL1wGJQ4ZOVVgBAoJo5d5gQrrKOCHeBzM0mpO35/HbNY+UdxBUp2MewN
         CzzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YdNJhO/+;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YdNJhO/+;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 09/13] list_lru: Pass lru argument to
 memcg_drain_list_lru_node()
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
Date: Wed, 09 May 2018 14:58:18 +0300
Message-ID: <152586709816.3048.15189884684148941380.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0106.eurprd02.prod.outlook.com
 (2603:10a6:7:29::35) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:pHNS/wa3b6QqqUwnpc37YLqrzzntrSETXIQhH63kGEMAXDAdX6X3l0WV5/gnRB3cXN58FA8s8Y40vIWYmhs0Wr2uZHzCcBDg7Aq3tFgARU9sVC+v2QOUw/WNKngJ3bDvGMC3Tyl+gvJwXHC8NHESXdv90WdqdJJXq75asNxtsdzBQSSvhx+eSOmXBW/eW+7zNF6e0/JwtjJrC+b7DhGQdzDlpAfLOfRD9fXLp3L3PGmXr1qL9c0gdSyGv0CEfLQy;25:3kIQQ0DXpAthCdgKEhAG62Hf19DxuqPA1p4+Th/6X06/VgV7UQMKyL3oOurbnHI8YmBpAjvQZEXPiA/PLwg80ST8flG5+R9Hu0t6mgavsRiMFYPua0UxH6pEkBt36ExiveS20rij13/cUjFU3NjZ31VD9322uPGkB6mQBoU4K6CAtPu4Xe8X4WWL1odSWvcKcxC9xJMUE7LxmgOmDkMsd92Kyh0LdJfa491TKmQAbatDU1SY8iu3xfdB+YUylws6YZAxU6jr9vfynKnBfYrmFHG1GqHUqiFhwwLeLcxg0dZz9xtdTYua71f2ovQL3SrYsAKfDtdu2r6bE4mpCp9yMA==;31:GRoZo1JERqd45j0JGSvKWAzc3pdzlliisho0NRHopjRVmCW7q1SClaUGzL14FStLiWhoqhF/D7IJC2snKVr1P3W4nacBZhXfzEk09J6CH6DGRreTM0DUd49xVeu8n9aHHks/ldeojCLZWQhPq9N1e+SfNsWKLXMiqQIjt+N49j319BAiGMhLWOATUpLO5Q4whL8EwrzX0PWvR0ttotL6YnQyoqE3xYCwh/hbm0+f68U=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:3TDJHHGsQru3d+MiIbTndIFgFXHxKRLpJScyuX6ByGN6WJfcZmQYzJbNRXSH4bGmozn43RwPONw2I86CexpR8GTyWntriG1sBdMjr/mJuGzCYqNu6FnroOXRURr/g/v8LrIavVGlN0sIOLpF6Xhe5RintbXtq45mrUaUutp2zaUpEHJIreZOEjMHjV+E8rZkFjMBePKrg7Tls2ifjEiM+jdytKkD3JuzJPYLu3VONHUErHUIPZonxx5j9PiPihD3GbciGK/NCUWIqojYjrTtsYtpMkC94ackYNwgWVvDydEV9On78si2kpAwKmEPoUsT0v7Ili2upS9JZXVW7G8noK8JqHVp7c0MKA5pVakB1i0uTr73dpvDwsXDPOl7dyAN18xqlcNY4jlqjmw5bOWd1SSeEfEJciGVL2DOtRrrpn3Ho4NwxqZCjfG0LEBzTxBcDf1bDxsuCB1g+6YKeBqnZDcjZHXC6ggOdDIFnq7ie8Cq8OVNWnA0FTQgauKNPJs5;4:dOkxuABSKyL+Km8a704OFQuP1yqq/BkUf7LfjcsFGrfIba9fMgyL6wc3KR9BaAQQGiIDJ3lrLNT6Z6YqnUYvbXR2S//hXibr/Aj0BPV5evCj4jzKIMUCA5O5nrD6fUR04ouH7IikUrmGc8sta60U9coI4ZMrjJN0u6+1cULRGUHEG7STIF//EiLwZdA5HOhaIolkZo2VrtkQW+IAxqyX8jTCNaWcVJA0f5+JeQLpLCD+DGfNAtxa+iD/dc76OWZNJIxjdetrtvM2uunEYumLQg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13294CB483C5851E03437119CD990@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(39850400004)(346002)(39380400002)(376002)(189003)(199004)(97736004)(47776003)(478600001)(81156014)(8936002)(575784001)(66066001)(81166006)(316002)(53936002)(7416002)(8676002)(3846002)(61506002)(6116002)(230700001)(50466002)(58126008)(39060400002)(86362001)(52116002)(59450400001)(386003)(11346002)(105586002)(55236004)(476003)(76176011)(956004)(6506007)(33896004)(9686003)(2906002)(186003)(103116003)(23676004)(486006)(25786009)(7696005)(2486003)(5660300001)(7736002)(68736007)(26005)(305945005)(16526019)(6666003)(6636002)(446003)(55016002)(106356001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6M2RYbThPczFQSUZMZEtXZVF4aEM4c3Na?=
 =?utf-8?B?ZzVnRDNJUXZCeFFYRytGYzJMQzBhY05rb1N1SUFSNllQbThtME9NT3lTaHRZ?=
 =?utf-8?B?Mm1FUm9LSjdBNHdEbDRpZHdzakUzcGwvQ0tqOVZCVFFyM3ZyOGcvSUNQbmpk?=
 =?utf-8?B?MjVIQWlkbFIya1ZuNm13ajJ1SWJHNnpaWkM1bldzOGJsK29NKzV2LzRaL3Z6?=
 =?utf-8?B?bXR6OThxbWVaNEI4T0FabjdNWkdjdVFhNXI3dTVZVk9uU2RodUtqNnVZWEN2?=
 =?utf-8?B?enV4MjV5MXNBT0FZWVBsa3JxaFFoZStMNGVOMzlFYXYxUHJVNFFYVUdXeWox?=
 =?utf-8?B?TE9EMVRPdVJrbTV0N0xuMkEybGtWZGlKWklzZ3BoU0tXNVVwWnRZU3lsb3lC?=
 =?utf-8?B?Szl4ejZwMDZ2c2srR3BrZXc3ZTlSeFp0MVBPMGJ6NHloa2NqSUZaQWFVVlZo?=
 =?utf-8?B?eE5GTE85b0N2dmFFZVVuT3VjeVdUVm0vSkgwS0hrWE5ROWQzdzhCd3krdnRX?=
 =?utf-8?B?N2NNZUhHY2ZkS1UwT1Nud2ZHT0R3bU8xYWF0ekF6bUZESzZVTSs0dDJkTDNo?=
 =?utf-8?B?Zm1xK1FuSnROdFlOTFlXQWs0M0hpVVBvcDF1QkVaSXlaR1kwSUtLTURMbWV4?=
 =?utf-8?B?OWh6Z1ZKcnZjdnpFbmEzdkNLbUNtMm4vTjZaUG5mZjE2OThpZWhCMzcwUDR5?=
 =?utf-8?B?VVMvd1BIRlBuekF0NHNKTzNhV3FWek1GTnI3NFliUnVQWVAwb3FOWmNGakJV?=
 =?utf-8?B?NG1jWS80V1BNMzQ2T2RnbmFxdUVFb09ZbDBMbEJtdmtKV0dPSGFZeE9PSlFh?=
 =?utf-8?B?dkREQVVHU1JvY0RZZzBPWHlrUjRwWUpuR3F0c2wwMWUwZXZoQ1VZNzA2a2xp?=
 =?utf-8?B?V3UrV2o4SUVja2tnakhGZWxBRnB3QWN3SEx3TkpCQlZNWDNlVXk0UFZ6RXFC?=
 =?utf-8?B?S2RpVzU0Znc5K2RCbXNnZFlGWnRMbWhmZ203VGVQbHF4ZjNNWkYzUEk1elRy?=
 =?utf-8?B?WHlPR0xqZkw2QjUyckpVVzZKdFhXM1JrWVJOUmgvb2FxZmh2WEtBZWcyYk1X?=
 =?utf-8?B?R0VrYTZmZWNhcXNEemQwTGRidGpBazRndlpWczV3ZVRhVnZPVEhlYmJpUncv?=
 =?utf-8?B?aXpaTHovWVlRRGlMWGJOWVoxVU5jYmdMQ0RFaERybm9WWkNOQmFWSGY5Nzdl?=
 =?utf-8?B?RmMxRzZoQld2c2IvOGg0WUJhaW91aUp5dktuU29vUW8vRXo0aTJTWUpzUkdm?=
 =?utf-8?B?V2R3eVhVR1B6eU1YOXE0T1dQZVEvTUNCcnp4cHVBMFNLd3hQb1ZTYUFFdXkv?=
 =?utf-8?B?ZzNHd3ZENUsydW92cDRsV2swTHBKc1I3TGQxVDZJdW01SWlvSkhHaFdkYkZh?=
 =?utf-8?B?Zy9WeU1sYTlpYWN3Ulk0aVEwMjFwVGtkeWtFZG1EMWJaNFI3TjBqWTU0azI1?=
 =?utf-8?B?RFYxR0VjTVpDM09tZjJjNXVkaml0eE16aS9mcjY1Uk9wbDZxRStEcFBPR3RU?=
 =?utf-8?B?OUdWQUExVVF3VXUrTGxldDFNYlRLRE10aDM2Si9sMGdPUklnTUdqSG9SeVVx?=
 =?utf-8?B?K3NnQmZReDg4V0Y1cjhZMWtWZ2g0RHpWbjNmbE1vV2JNMmdQQVQrWW43a2J4?=
 =?utf-8?B?QjJJWUprRkV5WkZtUlgyY3gzQUdGQlgyZU9teHRjTGxSM3RlMU1HRHk3U3ZX?=
 =?utf-8?B?SzdMRG83dHVRRmgvRkt2L296UFNoREkvbElQbUlVTHo2VGlYSWVPdHI5dlBH?=
 =?utf-8?B?RytUNUEyNWpxeE1IbExtcFE1bGdacTk1bjIyVDVnUXZGOFcrTEJOOFB6S1Yw?=
 =?utf-8?B?cFZJN3kwSnNTc1lhQlNYRHBVSUZySlpmRlYySnpPR0pHR0VyV1RRWkRldVNJ?=
 =?utf-8?Q?P93j7HqRHhx+E=3D?=
X-Microsoft-Antispam-Message-Info: Jca/uYvpq7B+VsrAvgBRAA12KyCWe7aFeX9MxbRMaYTSyo6S2V2wfiFamwIV3wbl/RRegkOI/ZReay6n9J8g14rocDKSs7YIg7h/KAsE5j6KudOpeI95dH2bGfpPvJ4aQgCu++fztJvPOf+VTXimk4WWpnB/6JsgjejuiQGsULSjbq/pBPDNZOXPMjUs2zWD
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:Om+8iZhzknd7wPBmOXttw0sAfw3d3ciR8W9to92M+DeEdzNg9Zqpcgh0FvjovUItRRxD7q50LTZLVxx0mpKrcN00lBZ4kiM5lM++2Cbv+f+ZKvbYmfzoZHjyA07VFXv+cftrO4C9Y63rvgW/lBMFebuVxu/IHq+ZrSuxmS4K/WMlzbTYjVtZs/Yttde+ZRWZQtcVE0+yubCnckKi3d0k/ffYfCBaATyb6paRXyxYYjZaGqokL683cMsI1O4MlD+U9LblDkdPc0a5/JWWH4UpZHqLrWy1RzI748eDcXNC0YPA59zEEEgkpna88dfEJ4XSiXjaerW7re1hLboxiw/bAQS0mUAN8VIFa/9OOLo4tQ4ZCgz4TLa2m5r6dKG7IkeXORlmz+lLmEyWU2sGxuTLV/lk9maRYlIm5957nBBXQfePNVPup7zveMgc2j0M3hecgFYkZviCJnXuXTbMRBJ3Ow==;5:ptiOZt1GPUpormduaGqEDqINqB18ftAvfb1GMzGCe9YzuXrXKk53bW/voC6XBqHM9hg7nz8C/4pwRv24/+7Yx2QAc389GZhz1qm+vTHPER3dCpSDt1dYyEdlH8sBYGi0fp/JYQYxiZVHVd8Siraajp6gdI8SemlSb2FUgzwmV5c=;24:YG1upQSEJSS91gEASuTKkwF9BgPPG51kPPfnXRwfo3trTwJmLw4+Z82vmBc8DoHhwH2Sg+W0RSjvG7kYvOo9iGc1BVsbqgiymn46CigBSu8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:x9pz9IFqS0YE3ICX2MVk3V179u509Ht3ZQyIlhJXCMvPj3PLyLQLLPCwsCNulGnExVn5CfndmOCHPcAvaBTsslCkB1gyUBnDtlH6w2UvNG2FiRwZkLMr+JV2mttBaEM40puKCl8wPvVb5Wf1o+YK/w+I/GrGgCpZgzscHwuaDIyg4LKv25ZA/5odbXxeMj+dtIokuYjUVzvRGnemE4+c8BVuyZrvEe9RsiZfB2tAS7BAff/rafOKxN1vIwwDXPyP;20:72g1FenURELJSOyQQw9gGvU96hiwVi8zvXJ3ByCHlp2vBS9NB75YRjqCTdNZoOebXfXu4FgpNS8Ig+q++5ZoAQMYZ/lXrFW7JmWifPxukNnDEpL2tLkaJlUtvRlYCnPZAXWI5gDexZ5xuQOoYsTp582Gt3ovofSxJyKHLNfcZx4=
X-MS-Office365-Filtering-Correlation-Id: 00a69136-2feb-4189-9407-08d5b5a42a21
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:58:21.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a69136-2feb-4189-9407-08d5b5a42a21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987628616829927?=
X-GMAIL-MSGID: =?utf-8?q?1599987628616829927?=
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
