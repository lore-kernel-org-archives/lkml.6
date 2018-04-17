Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/iwPSqbN871FdSIecYdvLlcIRc2BfXI0yg4MoaPzXPR130JA9TIHvoQG/MnR2jbjV6uSBR
ARC-Seal: i=1; a=rsa-sha256; t=1523980407; cv=none;
        d=google.com; s=arc-20160816;
        b=IOd9aI9c9J4sPdQXfMDKn87m7hEq9UooqBj21W2BoKKP9Kut27DyO33g2sM76DMM/V
         YE3KjBB1iOqi/ua6pUXa/d297fV2mhhB69ipB3ZMAOtkppRhJ0pn2UmqIo5KPahiu7QD
         Oty0E+ialA2o0kubSR+/ZUXn0nKembui10NtldF3lblxsGfAB0fUOaYHsOzv+8rrD+pE
         E/tZOGZZAD5DYNSlvE4MJ5Q7M9nLXpZMJbiJq8RMOVLC5bpFBRmG4JCUedNM2ON0JsuH
         28N4A5bu4VTjit2v31pcGIgr4/PxGvIsUJBwfpRpa2ee/MPr+B1M1/ncODgFtAI7/Va8
         eE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=o6WUavMMLUatrDLSAkC9oMKGUkC8bW5fSjvcvMbRVRQ=;
        b=l+xrq9U8y8HETnzMMr5xzZWrOudAliyv9wPshiweypGeSdiB8l1tHKNmOMZ5Oz7qM/
         JU6VvN3gqovDbSVMmZ59O7hg1tvf1taWPQeULW+VUUDf5pahn+1lNeLnxAojk7NZnim0
         7EWS10jytVt+wwGBqpxoHkxvTZNtCGcSMQcXN3Ur6f/rvWPw2ljoG7CY4j+6O+RupiNl
         KfC7INlU82hGcWgU4LdqmGzhM4PfRMNM7R5wulYijYJfwpe9LmkpMVRQB1uBcxDvJku9
         hhhN515b9HOoZ4l4LyEgEbkM2XxgHW+5TqKuNMrTdvc3oOPUT0c4s2XyOMxM4KAfVnLC
         WCsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=X0MmQw+w;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=X0MmQw+w;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v2 02/12] memcg: Refactoring in mem_cgroup_alloc()
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
Date: Tue, 17 Apr 2018 21:53:11 +0300
Message-ID: <152399119121.3456.11227643824792399905.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::43)
 To AM5PR0801MB1332.eurprd08.prod.outlook.com (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:nLKaqvEGDDfsSPKtnCuHxobXXfEX3Xrt0TLC1h6CtXzIBcb7yEgsSjOKlO8amISiHJVFBdVLeWXIS9RGZP9Fo/6iQmKMdZkcOOWJ8fWiawXa3rYHT/MzQPsTF0P5X/WSnzzhI9waL9vB2fgBUckKuwIe0FgJblAlKfkFZOQ/Gz+MLxGrC/k0JOPPaxNTlcN/WdVloa6stRw/wZ4e9YYtPl+5rrUVlTD5TO04o4au4loWgwvc05VlJLFoH2i4RCZp;25:oJabwgYadzTxb28RaoB++iNx7PS3P91V5j1rIp4Dz3UImNe/rZn2yOqZVxr9IdAxQSDX+N2RMl110IB4JbW5lFew1gsr7qf9QU7BdgD18nJ814N+Yy/1G8qSZYcFh2A50L8b3yZyxZIWuQbPgd77SeXDEYrfOLTGYkcsVr4b6hSb4idH1n+HEOPD7w20MEonFFATCx+ciLquI23sGULpNZKqF9FOLyW2UKIVy/b0AIJ6nlYNqNZRV4LhhdNe+eJzOVFfdayWvj9mp6dV51aftxCgx4ZxfMmc8hpbpXqrN1DeVyMVSq7zahtEi6e07cBYjADf00lGu29PpK14BiWEpQ==;31:KKdtvcjovIn6vf41KK6UXo9hlAgWxtObcTluFRQA/D0/WYTvtzSG9xXwa+2kRW3CuaA6If7ytI/KZ+9xzlSsuuOTS2R1jKF5e1hzNCItq2mLMADR2TSBLsYiAvHS8XT+YTXPIgPIkGH7oJtkD7yJD/otiDIyhJZyfxseYRCXtNT/Uw/Cb+DV8zH22Xt8FX9gqk08EJwi8EKGMEoLkfNoGLzZ/BqoQ0rLcrOlKVstu0A=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:NVmQGegpu/vOsyFNeddpIYL44CEsohkMjJDvqH2OjzrozwSff0BNDIp+DKADa3P5OC3BjyCnC41ST/NU/cD0d/al0driNExIW3Q9uwouHbJQlz8wZQMNVm17a0nP9tN0zLNRUANfJE2MXzIdPGa7VTUcPQbrlsYfn4+lN6pGiBY5egwiSt7Fh14cA0VEhxLvHWE/CJoBriohgFRN85CObdtacCHjdrH4nr0DdGZa1pdB6mm2j8HUtgslFXzOS7QcQKpRQSa4qrlFhZCiVqab14piL25NvVEs4RZpG1Tnm66SeodewcDbNw+IC1RH66mSrnSLg10vz7SvSwOXPjnQN7lD6EKseRMFVnk53eMucTrQfkTM0o85PKYWfnbIgrvhXoWOMTYlnFKE1kIAVXe2iSgNMlsHgwr0CjwhgjCTK0Gcj9DWB+vtxIm0St3VdF6o1mMFq4zQEWHk/5DDyYsj/q3lHF7qBA0MqWU2xgf3txER+1sVFbs2G09phwvxjlk7;4:rf+g/FHp9mnfUOdP0P2ykhtt8ewzxJdFQL/OF1IOGMAtCztLgOlovwGouWF+2yvB4DihStyN2bYgfvstlSraMtGtTZI5nkHbFkHq/zHpPm4t1sFVXiZJCNTMy0l4zF5pgPueiNHaDI1HvRYUgooyyn9+L28lhUB1qLboLXZQuQsuZpYWLx/4mhmTNF6mD0xK0pb+ITZgqn+kJsmqfyBfGQp4s2oUm7nW5LnvRc5TEA0shJNxYSdpCjwf7/rgfIsNbamYTltUHFqgq5M97mPdEg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332E793CE2756B9D567AE34CDB70@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(396003)(346002)(39380400002)(39850400004)(199004)(189003)(2486003)(81166006)(81156014)(8676002)(11346002)(47776003)(956004)(58126008)(476003)(55236004)(9686003)(50466002)(53936002)(55016002)(68736007)(2906002)(86362001)(446003)(8936002)(6116002)(7696005)(3846002)(76176011)(186003)(16526019)(26005)(486006)(39060400002)(23676004)(66066001)(316002)(33896004)(6506007)(59450400001)(386003)(52116002)(105586002)(6666003)(6636002)(106356001)(230700001)(25786009)(103116003)(478600001)(97736004)(7416002)(7736002)(5660300001)(305945005)(61506002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6RzFuNWZSK3VGN0tWNWFGeTNNRUY3cStG?=
 =?utf-8?B?a1p1M2hFeFo1SFQzWHZudXU5NGwyd3JEbjJzZFpXSzJXdTMyOE1ldG4wWDhU?=
 =?utf-8?B?czVJN3hvZXJCTEZYODZheUR4dGVBSVFhdlo3blAraDJ6TzcyR2ZuN0VMTU80?=
 =?utf-8?B?dGZUcUlQNGNGYzBiZkhFaEg2UlNOV0xjZ2xDaVEvV1YvRmJxNUpFK1ZvaWNa?=
 =?utf-8?B?eUt0TmdNNWxJYkREQTdiS0E1Z1J3N3BKZzlGTGx4MCtvV0UyMHBMNW9wT0Iz?=
 =?utf-8?B?ZDJaRFNyVGJSTE1ocXJyOWdhbEZOKzFZOTI1bzZNL0kzWkliS2ZWOSs0S0I4?=
 =?utf-8?B?TEF1eGpYd0pOdDJqSzcrRW9iSXp3NFh4ZXBSd0lPR1lBeVNweElXTkljK0Zr?=
 =?utf-8?B?Y1BKMjRFWkp6UDBkQnpDNzZNa0xLdVpzWG5JWm1aUUtVdVR5QU9zbWFpcDJL?=
 =?utf-8?B?OEwxMnRSNE9HdWpjNXA1ZGZXS0EySGpTUElnbGEwM0lieVl1T0lVSFYrQnlW?=
 =?utf-8?B?eHNxRGtETFFsMHR1cjJxankwc1FWSWtzWTB0NVRzcmVzVWtaRTRkR29VSHRO?=
 =?utf-8?B?SG52TnlDVnhxbmFRS2ZxcWRobVZpd3JRdlJka2ZVU0ZQN1h6UjlzMHV0N0tS?=
 =?utf-8?B?aGhLWVc1YS9NalhqdmtLcFUyNW9SNmVjcStueXNOazNSaWNIcEJ0YUJiRWd6?=
 =?utf-8?B?bU5aUEJtbHh6Y0N6OGJmdFR4elB2b3hHbXF2REh2YWRhL1E0VmJwQ1JCQzdN?=
 =?utf-8?B?b3dvV1dVbzM2aHRaTW01ZnB6azZLOHVNQmJJZERQMGhSOWpHQVdwRkF4MEVZ?=
 =?utf-8?B?WUFLc0VTeUM4Vk1BeGFwQWdUS3Rkbjk5aCsxWGt2bjQvVDV0d0oxeUlOQnM0?=
 =?utf-8?B?UkJ4NE84VUptcEo4cGRnRXdsK2lDbHo4bzlKMzZHMm8rbU96WnpJRXhyaWVU?=
 =?utf-8?B?VUNWTzlJN1ZsTXE5OW9NM0FZZEgxSG5PbU9QaVBlRlVMUjJwYS9mRlBJS1JU?=
 =?utf-8?B?TitVZmtMcVcxaC9MY1RUTkFsSEcvMHRZT25xTTBORm9ORGF0Rng4ZzBEUlU0?=
 =?utf-8?B?SCs5VVNPenpDTFdidVNrak1vdGZOZ2M0amNjanU1cG4zWTJwUWhYbk1VMWxq?=
 =?utf-8?B?VVp2SEVjUEFwQnhyZE5nSzJ4U05ReUk3OGVVNkU3amJqK01kRG83NmFNOUg3?=
 =?utf-8?B?TVB4bE56Tkp3enB6MkV0bjRkUjY5QU1ldm40Y21INlpJTnBUeWYvcUpYdU8v?=
 =?utf-8?B?VDNvcDd2RHJyQmdnWlg3cE1RS0Q1bTZhREZHSWxTNlBhUVhuaWZhTmVVRkV2?=
 =?utf-8?B?TXgzVGlkNmx4ZUNKNUFnb21keEgwQ1gzOFpBdVp1aVU4eEZlRm9NTHJvT3k5?=
 =?utf-8?B?L3U3VTBMRDkzZUliVW1rZmtDTWp0NHhidGZxMmRVa1Z6VVBUY2IrbTR1ZXdn?=
 =?utf-8?B?cUZjUlRmeFBXNGZldEMwOElBWEcyM2QwaHJlQ0dIbmtUQ01CSUJJUC81R3ZD?=
 =?utf-8?B?aGNEcWFBYk96dm4xNERXc0t4NjJNMDU5YlpMQnpPWU1HOUMvU1d6a1BFSkFC?=
 =?utf-8?B?QW8yMW5wSGlRR3Q4MlF2aUNOV1RIT3FWcitCK2dCamxFN0RyeS8xRHh4WGZO?=
 =?utf-8?B?Ry9sblo2bjdpSGNDQWFzcUFRRWlvQjhxSmc0Ymx1aXdleWVHOGQxUWpNc3Y5?=
 =?utf-8?B?eEFlOWZFRllJWklPS2xaNlM2S05rbTk3MEJzRmpDaDhRUmJ3bVozTHgwL05P?=
 =?utf-8?B?ZWRpYkJuVWp2TlFKMmQrOURGSGszMWJ1QVpucEJYeERmSmV2VG9XMFE0ZmlM?=
 =?utf-8?B?VGxTSWNuZmJNTTZzQ1pXeWRIVm9FeUR0TlVWMzRoTldZY2FvUT09?=
X-Microsoft-Antispam-Message-Info: +/VudCJmfNxcdlhDLml7ME6l1FajUT8CAzCLOaYbbxwZbTISXKozQBLYC8T6KpY/qy7gppMV1qkPMjYTn5l4Tnw1lfHL8/lTniikfAhJvvogGgSoC+tjilaNrzC4601v8qAP09YAbKpnKU7PgS3W6VlzCQMKF0eSDo/MMj3TOUaEpqf8WfIA68HOL/GvnvUa
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:x2zfrufLdHaukBL0lUbEvyeGdD21mxV0Ae2QjWo+umy+IZ3TYZ2MM6/685ET1tmofrBydsis1LP+cUqu7giEMaqKxqgd/+GwYxY5xXVesFaPyXxlDgKsYzSR+JgF1PeREX8niAIy7uUQ9/SQGtiXct/HpQK/T0M7eprP4/IYjWtgbO4Ay6a6wgy7bBMUIh6fnXwk9kGoVP8gW2AL/43n8RktDTe6gP6eF4kRuRvyuQkWSWm/hcvZPd5vGfHeAogp9zXC4q2Ef5ML5sbmw9NmaRSVP8DX+3wZZWuwUpf/XQjc05sevhB2ckC4eaFYZn+1a+/VWPrxdzysdV6ragrK+ATiox2uCy07SetfyZwX5aeLLlFVhcdlwyqp6mQmecS14r6tx6Wph2BcBkiDK3Ew+T5534mBUOrSdQ3JAH5jyiDEy3EI6YMjpgTciWp414Zi0DH03vzk7almeEKJ18MmUA==;5:nr+pw9zLIjDw8gtr9dsqEESgSE0ClOQMKZcm32SvYg4R66JP5aEh30mDipep1W5PHxnbs8vBQc/C0j3VHBt1IeKpAahJZtWEAARL0Qg2jrLANOeUpL3rGioKGkdhXO7zkvzha8FCfDIMaUKxOT5R405zmHNFVhdUM2HeaodaFrA=;24:iJG/frsO5ps4NlXSttohn/ZYWMCoIOlt5pRxmfViCt+8S0j3cH5pi50SwvA/BJOI1XdbKLGHn/DM/FO7McnU7XVdxmREnbrAu8rTMamk7lQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:3M9RsGxCIxOhYdYIlJFZB5riQgpaa+moE+d0Bw1AyGATLKIOxmOSG4CJIgnH0uTlweFFyCDfUfentF7XRuaTQk4EMA6rapEvlH3RwJ5cPjnoIVH8Pme/DrqvPLcgT6VTY5NweWX7gpR2acjFZjYaI5yVusAVb0CYr1p7JLREyh2Tu5yA66g1Nf75hjdEOcvKZhZh7jLsUcxMgDgndEwvfGSNaqYwUjjOHPDzLllA2+v5BKaV/2xtV3Vzt1WoRcTf;20:ouH5m9Y34Nw6/yzubbPZDdziigfAmMOqsynTosp+8jmvF4em9le2LHthsDpVcqT6OQ0WbMYtHlLUFUJB8u3/I6HN9MbQC19bNoxnHwBdxPwgOz2HH/yWuhdu54tgBQ+sPrR4MnqN/8i1LJxiOz3KoyI7fRPXXrGAoM09JugKH3I=
X-MS-Office365-Filtering-Correlation-Id: 9872b1af-9140-4177-4f79-08d5a47b5980
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:53:21.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9872b1af-9140-4177-4f79-08d5a47b5980
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009280028553845?=
X-GMAIL-MSGID: =?utf-8?q?1598009280028553845?=
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
index 448db08d97a0..d99ea5680ffe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4383,20 +4383,10 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
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
 
@@ -4415,7 +4405,16 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
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
