Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49Nf+kh7Ido649Qjfg5HsAiUCFB5F9vn0DgWCEaVYLwyDIBTOKe5OUs23yxWW8NQkJI3Umz
ARC-Seal: i=1; a=rsa-sha256; t=1523980418; cv=none;
        d=google.com; s=arc-20160816;
        b=QLbTD4vB/AhwttV+znMZLJuO0rgi0AKOUfRhJLkLXPi+fbXy6QERgISYtKqPd/139V
         K6rbBO8N5a8ZzTF70pTdcdTMl0UXmmDSE81496/f9PwJptz9lXyqfbwyI2W9PoCkXczo
         Z42YxP9hmmRQVH4fE7IG8DPvrgZKsdVhwkrqtmyZZvRjTloGuERQoTi+lHg2LSyY/udB
         8V1vvsFqKKApW4mkBl5gS3KK3h3skBG7CXYUXBPnApEhpUE3bNF6PUX4RPufs9T04LDo
         bs7ekMTFRHN9pLobkrR1F0wkiKAxaS1MrMlcoPgHLFOnQImucazNYpThfTLvuCPv+5ZR
         DjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=UmS8+vd+6uY+aFGydnJA8fDH1f0obAe6fT0S5BLF9n8=;
        b=PRzISIk1XrZu4J9HW+ZCU8y/qmmlg9i8MzfHfCD4IacYMEfXt++L2NH8le9TbgDJcB
         7B5x3XDwFItvNX+xnO5u/5qyzNM27j8ZvdHcbBzOR51t8kozgyinn6rp5qcMXbyTpX8a
         ZfgFU+adGCbLKHjBopUNtJfN7XEJZF30qG3/24G56u972P9J4Ahq5sgl3tmUUdn8sgh7
         ZDcCCrbnxfLLCw389jFn8UGGcqmIMalSUxZ9RWMchCqqcJKVDkSUOJem2PENvfK4Julv
         0E2pyR4Wk2jZuXitaqOd+cuWW4R8QAT8wj4DmZhSem/tArH7QsHkoJS1i6K4P588oPmX
         r48g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=TD+pUH2z;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=TD+pUH2z;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v2 03/12] memcg: Refactoring in
 alloc_mem_cgroup_per_node_info()
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
Date: Tue, 17 Apr 2018 21:53:21 +0300
Message-ID: <152399120185.3456.1990374174129524641.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:7:67::30) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:SXleErfAXDawe5n7dTHw7lTqcVaUYKd9arJU9e35ieZXbg33L98BYSAhrDJbNiQc05O4D08/Hu1AZbxtoFjpRp12QdteiqYlr1BiTNsYhHIkEQY/WzZRbqhx4QueulPzjSpoq0v90OVyaDHPA1nPr0V6wkMMn7VaNg8JSzruKbafKBJ5YXp4aFQ0/M9yXzGsyc/zVNnsZTRAmIMmKtOa2xglN7h7yMEAQJc502iipOW46pyNXha0LYhcrgyIpArJ;25:WJOnPfnm/v/ZszUQ9qkhs8Q+tf5PEWqQF0GZbGUpUaTGSo28CsBxI55tQFtlwaiguWBisEQkThMo7IqACVpiP1t06bzbHR6tysDcyajjgsdkMkfWY4f72sZbsoo+Y0xNM6QvPhK1aI70XJXKwZy3/dZy189F59pv7FbwdkXp6K5EWCAhC71MNHpU+Sn5jdSVAU4yKS6fXQSY5QGuRgMINfIEiHFjXbEdi+a6wQ960j55qlbMiiYtdFnOwFNw8kIufZPMvTLq4A8By3uDlwWzjIiez8ol0MyOw13gWoFJjHmhFceO6kOsAUgtCgL/4rzj1q1DJHZ0og/gpMMWHf5hPQ==;31:hAjCnFnKTYBImDNrgm/wK8cEYGnenbMxVxoDFbv5UFxxqHlGPtbetMCdgH+9a9BDT3RuedUQeVoxdCl9H+8V3Ff+BVg3ZnP0qoFE/CvHpyD53qM3Vp6ZmGnVDGXwGPMdj9bKNjIUGqpCuptRHqmcd9gdT+X6zzVcZOaZAEA2ovnEokyHCqwAkjutvmhPKQhSvCBGMNxbTPUe/tRJ/fnKzNy6KyCgPbbN+QhRTfe1BoI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:1fT3x/TFwRqCTxCusqdew4lrohRdsUdYaqpT11k3TorbNLEEIuk4Lyux/ycxe/OJ8jnT+r3m5LIimsskVacquocSo/22S8Z/3jvKv0eMPp1qsNIv+jFU0XcKZSU5rwFb5pIJZhvDh3ynPiB4faBba5SoB5Q+gn50V0fcjdfbR8yilydFyR+ERMCvQKSW77mIwaVCxngODzxrZAgXREmtef59JbVjaEYTsgAfGajOYaNcSHVVHl751mfhfUkcx4LmKhwEp6m2s0IVBnpKPcArM9Lgpd+DBQy4lXufhxIeeLwkDaEkh0vZN07abZwXFaZFpqA0wOQhChbXKNNhK8UFbz1d3fAMJc8KcQ+klf//yG3EGABx6YzOyO38Onflx52ZcWJLzKE8095htaUJp6HBvAnUruf4fMQNr4KEUTyJ72e6cTbHnpL9sQN/PxTUlGCka31FJPYw1mMj/UpO1xZhLcvS5Bv36HSv4FyYcGAq8GQdijHDAliEJlsnuS4eXtKf;4:1KCHf+fS0GghiDKdnGbJ1Wm7DnEk/rwkRJBi7uFx9CRGm9tJ3LPgBeCGmX2ecixIIPo5lAQBl9+o2yqqdzFyD7bUFE1zC+xw983D/hjOfrVWbegiMcNKomyHw8Op344uRb6uh+lwzBHXWNJv0mUDLlfVL0qxYqojiIcDvCV9GguxBSAGYd4hKR13tJNFXdb8lLqJhmfoF1W9Y9cwljpYm2v0uWlyf0nrq2AFAtPEvevzIkt6fEVJ4DH+KwtciDlDfG8LzLlucnnaZ7G59Rh1UA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13406E14124A7EB2EDAFD178CDB70@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39850400004)(376002)(39380400002)(346002)(396003)(199004)(189003)(6116002)(66066001)(386003)(68736007)(7736002)(16526019)(478600001)(486006)(58126008)(7416002)(956004)(53936002)(305945005)(86362001)(55236004)(316002)(47776003)(476003)(97736004)(55016002)(33896004)(11346002)(8936002)(103116003)(5660300001)(76176011)(52116002)(7696005)(81166006)(105586002)(81156014)(8676002)(61506002)(446003)(23676004)(2486003)(3846002)(9686003)(230700001)(39060400002)(6636002)(25786009)(6666003)(186003)(26005)(50466002)(2906002)(6506007)(106356001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6RDFUWjlwbGxmVis4WXRwdmlJb25seURt?=
 =?utf-8?B?RXB1VVMwUm5qUWhPclN5OEpNblRidGk5WDR5bE84U2txclc1UllRdjFMdk1M?=
 =?utf-8?B?bkdaWGtUY0s0a3ZMMWlRZ1crTU1aZ3hwK2xuQTJXaHNXWFR4YzNDWmNsM296?=
 =?utf-8?B?ZFhPNzJiUGtmS3Nmb20zMTg5dFFlNGgxQit1Q1k1a0ZzWUNuUHZ0eVgzdGJO?=
 =?utf-8?B?dGtHR0RhZ3VTNFdXQnIrR1NWTXlGVUJRU3g5cjhhQlRaQmVJalFUSEdkUTVl?=
 =?utf-8?B?UFZVdjUvMk9YWlhCUnR5a3VCTnRxNzNjNUdzbVdpNktBeFVRYUQ5RzVSVkY4?=
 =?utf-8?B?RzZOekkweS84MDZpOFlESmZPMmlYUHFVRXM2bmd4OTlNTkgyTmtIUlZ3Z3cx?=
 =?utf-8?B?MUZqemtodUtkQ2tYN3VQd2tLMXMxTUxxK2ZXdDdxeTYzMll4MlJsWEt1Y3BM?=
 =?utf-8?B?bmVTaUx4bFV6RXdkNmpTcDZ2eDZpaVJjTUJCdlRyUG91QzZWT3NmWVR5bU9I?=
 =?utf-8?B?WHlCSGt2QTJPbkhtdEZBTy9EMmtaK1BtbXo3VUFIWFhvclNhTEtkaXRPOTZW?=
 =?utf-8?B?Z1FFblNOengveUYrR3YxNGt4NElSRDFGeGlSRUhhNWErYThLYTQxNWYxRTJ0?=
 =?utf-8?B?NktKZ3YrQm5qTlZ0U2tsUUNYcHFjV1JJUlNsRkVqNXlpVWxZZHJ4c1hLSW1S?=
 =?utf-8?B?TTl2cDk0SUoxTzV3S3d1ZmN1T3hrSjRZRGoyVlRxdEZ5MGYrdlZ0QXNISC9T?=
 =?utf-8?B?czJ3MHhzTCtjV0FuWml5VVF3cVF0WXhzOWprQkg4QXVEUnh1ZUFvQSsvNUpP?=
 =?utf-8?B?dXBGeEdaMXJOa2NwdDVZVVk2b0E1bEpRbGd3U3ZOUWgrT1RVa3NmMTVTM3JP?=
 =?utf-8?B?eWVrVm44b2JKWUo2Qjl2SlZJZEZGWnVLTVlpTWVQSUJwNDF6djA4MG0rWHhK?=
 =?utf-8?B?dDI5VE03NGpwNGlsbVJSWERMeGQ4N1QvRmpLL05BTGVNcDFyczBwVmlRaHZz?=
 =?utf-8?B?ZkxUTUZYRUpOR1laaHo1RFZPNFQ5ZUUxejdXaVB6d2Q5MGJzLzBDclk5bVZO?=
 =?utf-8?B?dEppc1VmTWlnb3VvbzhmemJ2WndRc05FZFRMV0FSMVVNQ0IzL1hIK1Fyb2Q0?=
 =?utf-8?B?T2gydmZIVEc0dmN4ZVJjSjNHaWJvbUpNNlZlMEwxVEhJUFd4bHdZaU14RUF5?=
 =?utf-8?B?S2VjL3NGaEU1SitLSHBDS0RJNlZnUys5SGlCM2k0UThEQnV3cXFoMnIwRlh5?=
 =?utf-8?B?YU5PY1J5UlRCVEV3a0E4dGpXbjlodUs1N2crSDU3eVVFQ1FjblFoUUxJZnNF?=
 =?utf-8?B?MGlZelhLY0lBOTFrMFN4MmZJKzNhVHZCeFEwMmFlMUl1TS8wTmJ5eVdhdmk3?=
 =?utf-8?B?eVlOQkNEajhwa0FSRzVKZVgxYzZSYXZvNjFaVUNYZ2U2YWtLZlNTOVhvRTJB?=
 =?utf-8?B?SXVXbklFMWRKM2lNcytBK3ltZ2lEM09hZFc4Z1BRQzFVaGJlUFBwR0FwUGRM?=
 =?utf-8?B?d0pOelg0UWluRHNBaU1CckxPZ0E2QmRSWEljamZCaW5VaUN6Z1c0R0txMW1h?=
 =?utf-8?B?VXpwd3FORHlQOEpsZDVwanhkVUtpK1JCTjRMTmtlK1VOcjM3aVR4Q2Zod3cy?=
 =?utf-8?B?ZGppOFpFK0VETlRPYWhyMmt1TUtIVk9VQzJ6d0h1eFVjMFdINVNSZG5BeEsr?=
 =?utf-8?B?SDltRVFSOUZzeWMwMlh1UFB2TEZQZ3JOTTdiSmQzRDhvV3hoOTZzUDlCaU1u?=
 =?utf-8?B?bGpCbVV3VWF4MDF6N0V0bThjeWZ0L1hmWTJKOFB4NGJkMUx4OWlmQU1Zb1VP?=
 =?utf-8?Q?MTZ9ZAaf8vszK9X?=
X-Microsoft-Antispam-Message-Info: hxIDrvl3fApmyYhQbFHXEEaTRk0mrnhMxLmQgqXcQMZXvxuBZbHtMXZ8Tg/0hej8+AuUL23VYBBc/ptBZ89iDa+4loqCVQNcPb7esK5MWTqaV+32YPgfIKqCEDxKTb9DuMi2v/ifXiciuxPeCBlFchLMY6v/ZA5tIbYtl/r6ks3fdyBlGw1wvU/5g+yF5NlH
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:xohbLa83cDpfSZMTm95+u8wBClvwnGIUiD/WTDhnUmHAX6KSdvN0Psr3PcBDHdgOo/fHBZ/ofDff9RZyLYFM6OYgY0PCMMYGcGeevd9DYCe3EX7lLYe49Nx9EoXpwc4fLIHDtoM1RgDGDLyAZaExrr4QWkC+DrhPGTrye9/FROftqp1WRuGLtJ0ncd4gX11RXVokyjzJho9Z8jd+SzDpSRe5r5GQ6sxdH9aCgx0mHvlAWjvX1T2BfL7x6MzTyT7gYCNExzNoNdc3mb0sTDmrvPoH9V8cOF7Rh9CO8bGVOgA9tpXlHJHuC3cw2Jt7zR3DTMYclq+AxEgs/BapUjJp+pxCW3tvmj4BlYjzCqpUK2dvmcXeMLyMX6jgdd+/BXvhYBcQyD5m6spX7zTXbZm1Z4bBAufE0Zr3yegaXRBnXpOH5G5LFe/RYSZrWsqDfHUBlVNW6Z0Vk/3Pbi/MVziCyQ==;5:e5EDcXiL2p5ISePixvk12bDP+p3aByjYxZqtWjleFbAW0yrfX2/e+XCR9yonnnYtlJKvJutdC1T2bdb/K5hPQFNEOss2q5tQXwtY+Zves0/Zn4DsACC8rvyBH1TbEx4RwHFC55sKFCZqi443WWbFIo/kIUfITSEkJbWPyrPcY3c=;24:X1PhfrZA/6pJRUer0jTw9fbTohvONeCR+z3/JysfMRf8nbIkw98Ti4T8MPGvJt85HCqStri5MuVPwcydXjSHVNLk7xNdPqbIY3kt8yUQE+I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:gU+WpsA2fGGl/LpSENVV2rssBWtL+TMp1MR6MS47UdGzwC7dh654NtfGdYymgPKWzPiDqUWv5ApOYBJEvmjtnX28zziiTi38dK/+TYK0jC5ymb0zIpqjRDJ2+dM6HdjYcorTmGxZ03K0KVTeuSelrCoYiyhNGDE8k7t/Iy1D4SmKR5axC2tWD/Nirm4Mu34RQ4jTchfs06ENjCkBXDR7we73FKIshaUu16hxViJ3Z8vruruMvMz+DHK1FZOzai+4;20:ZAiMilcOuqvsGFcS+mJhpzOpnon20k+cerFSj8v5p7jlA+T3rY2XfyOE6OfCdF7uam0yiDeOnwjkZNSzYp6vD++Aiyu3BhBNRlCxXS9V/gQByJvAqUH8zw+nP/xnF0zMvsnfjlpTDBHo3l3x/18bdfYnPpHL8PcSKFb3bFWeT+g=
X-MS-Office365-Filtering-Correlation-Id: bf5d5ac6-ca72-46fa-f9fb-08d5a47b5f2e
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:53:31.9202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5d5ac6-ca72-46fa-f9fb-08d5a47b5f2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009291621683802?=
X-GMAIL-MSGID: =?utf-8?q?1598009291621683802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Organize the function in "if () goto err" style,
since next patch will add more "if" branches.

Also assign and clear memcg->nodeinfo[node]
earlier for the same reason.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d99ea5680ffe..2959a454a072 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4327,20 +4327,22 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
 	if (!pn)
 		return 1;
+	memcg->nodeinfo[node] = pn;
 
 	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
-	if (!pn->lruvec_stat_cpu) {
-		kfree(pn);
-		return 1;
-	}
+	if (!pn->lruvec_stat_cpu)
+		goto err_pcpu;
 
 	lruvec_init(&pn->lruvec);
 	pn->usage_in_excess = 0;
 	pn->on_tree = false;
 	pn->memcg = memcg;
-
-	memcg->nodeinfo[node] = pn;
 	return 0;
+
+err_pcpu:
+	memcg->nodeinfo[node] = NULL;
+	kfree(pn);
+	return 1;
 }
 
 static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
