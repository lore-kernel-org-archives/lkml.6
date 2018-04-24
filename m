Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpt43wj6OS4DwuvvIkPuNkuJyKmfx54Qlj9L9hKXbDcDUPnNuahOk7f3uR9POMjXHNHBDQj
ARC-Seal: i=1; a=rsa-sha256; t=1524572009; cv=none;
        d=google.com; s=arc-20160816;
        b=0w5vxOF+NdZ/0v/zArOd4zaVItMN3vAc13dINHC+iQ0MmwEzl/pXxVathaoI4rESzp
         WQt8VWaaB8dUFAyendv5oQFeDLy1U6DPG2TwZHjltZhmchinwWsGvKSJP4oogiWBB0Kq
         8wZOog0xA0KpRjNkNRplICUvDY2j+sSKu1GRVSFiWtkoz0CfqK/NKI9sf6Q2QGpXxFIX
         Q1V09JqDjsT+pzsnYefpsVJ4iPF/TtiQXYD1wZ8g8pJYVonL6qz0e3tpKaHXcUoH0v+W
         IhyGlxA9P+HcmYh3W/3qQ8YfpQjpnIiPXQUgV84NadTpls+VuBrMBbs6a3AwvdVTx7gz
         DGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=TtLpdzodt4Axq3H+Vm1SDOprH0akPoNa42kKtMwjpL4=;
        b=khcXumDvWi1+9ipY8cbsw9RCtlMZkEIMZ1Yl7H27M4OgWmAiyYqCPGAR36wbHOQNtQ
         hopZXYjMPfydVVE3L3Vr1LHimAZOZLnMbeRYDn/kRbQwCPIyCEXMGqYhgwleg30vYj38
         Rpb8OduImazD53kcfTZrdu79ovBWya+15WZZtuSzey257CqHm2VI9Znujp2Jg/74Gqsd
         mGxmh84FNzhDaC81gAAgRr6icBsKMCDrvP4BEr5pz+L0ofnsG5EiIH5maZ3+whbNdnRA
         f4rdh7zBjRzzsKj9prkK5QBH1seyQLIhMOUI+YdK2Ut127BmlIXDX4cjcbs5DbKrAoLO
         HguQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OxxAkzTy;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.131 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OxxAkzTy;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.131 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 08/14] list_lru: Add memcg argument to
 list_lru_from_kmem()
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
Date: Tue, 24 Apr 2018 15:13:19 +0300
Message-ID: <152457199938.22533.2889251947413281354.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0197.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::21) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:s/hOAOrNbUlvQsWXVREuX47Ke4rNcLR+hVtUsNY2NMmCQbkOcoi6C2iwE0B45v4ePltUxCuD8CXeI+t4Rwv6W3oAr8zXCXp664MAwIUhkfr/BjTxMialhYz8bb7yFVUdIbF9APab6QjrmiKNdylZ4ip+BaVK2mwKjj+It9XMCKLxyl8zDRUNmAAWsgbBcnHWbvMxMl5zivPBcbPFAcYrzAkfJbFPOxIgSUsYOJgxIVmtV0CBsExkEDnySwpEyOFm;25:ga5THsfDEiOVS9RgYNjZfI12BC+kId7W0/qUT7hEXWBhEfGG+fLd+P9vIgE+acZQw1ydLFxQqxdScu485PV61jKOxNO/jqpAf6k80+chB8r59R8WhsbvbZGT750Home1aoAF2QX3qpiZp3xdwbc6/NNYUkBWqELB8Q7Bl1thABeAB8bqWZk+YOh50rIGxIvMXRCWpVZ1y5Gdp/cn/MNRa7CGyGsq2k7A36ys16b5PwachO1xvlMlJ0Nbd/RYny5RQ4WMLahbuWWacnG679XCtx3zpx0XWf3Zj64E/JpnQRiv1h8dgV8wQ5zK26m9bVUS5t699GpwzI5JmsZdnvWOYw==;31:ptQ7F6QXRqMQOkC3IOSjZCW82P14WEd2++tImVL/kFfy/RnA5v1pCciBbPJGuQhsBWsOf4bZI60pFFMoVPwrmedwY8s11pGplrTXp13hfNYoqoUgebMEmsJiDGPcS3Y1rrnGv+6j2xdBvY9+qo52o4ETg2yRekNbEq1A5KLh0wqfbnn7uxwC7FnfXjWtKocSoqcl96OFNef5jgDL1D6sVGWHji1BYPzmSDAMsRzo7Ak=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:PuUfQ02y273o89UI5qrnGL+cwWt2nZTcdIBDLFJuBmXfToeB6bOSHnIS+IHV31Mi+bQsfvorxg32+mBLjBk2MtIWUwQTgjG3P7qfgBtskf3b/sjA310tIp5C9st27332pKG/3SLUfbYX8LjfKOhogus+TfqiE1FEfhJ1xeUVnsiPdShRQ7UI4b2UYb+zxezF4+eTumVIsypcepJGXnBG3bkVOQaeXkKqxAoe0O/yHq803CAZRZypdCWB9Ln2Gq+Dln0o83RflSt2dPLaGF+96NROkwT2QITYNwehIqWgaJqOZBioEV6Fq5opoHxleAi4m7P91pv6zdaTOx/BvRYPHckOwmzbti7/nKurpozcUFq0ZkLXpWOEf/cuGRIPfEPsftPAqJtUc2ByOUVJsQxbi9t1wEc/dUHiimTdrpGoPo09mMTU8I9Trgzr+F59KuRo9C+2zHL+zBv4nxThS2VefyLWew1MDz5o/BZFfSMNui5pC2gOUrOWnUBA8quk1nEr;4:ARPpKfLE1vWGjXpV00nPzDYn8ZlQzLpL297+ZtVZ+iyoiDXjnNF2drEwA7EpSr4S3gnWBeXQcOwydH8mIuvLVOTDGeEXz8kEUe5jkJawvO33HFtMv/0rHXRbSONj1AOryp2Gzb7ryZCKiw1ZaDLQZF/y2sjmldDhMfO5qscpfsW3TsR+U1WRn15ixxG4rCAU5s4RTlVzL6LQGYY3tGyjE8q5aDt3hy50jX/Nj6ZFgT/RU41Vny0INhGBRZrm7xIb8XKfroeUCz/fnQizsBQVtg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13380ED59D0F3087AD38E275CD880@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(346002)(39850400004)(376002)(366004)(199004)(189003)(2486003)(59450400001)(103116003)(47776003)(478600001)(68736007)(386003)(39060400002)(6506007)(66066001)(58126008)(316002)(7416002)(9686003)(76176011)(52116002)(7696005)(2906002)(55016002)(53936002)(33896004)(25786009)(97736004)(81156014)(8936002)(8676002)(86362001)(106356001)(55236004)(5660300001)(61506002)(105586002)(305945005)(7736002)(81166006)(6116002)(230700001)(3846002)(11346002)(26005)(16526019)(486006)(50466002)(956004)(6636002)(6666003)(476003)(23676004)(186003)(446003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6amc2eWtiSVpVc05TRmJnNDIvbHpvZ2Z5?=
 =?utf-8?B?Z3BIbjRtMXJ2bGJqMmwzeXFLbkswc3RNQ1AvYjVjYlpIMmJETGxrL1dxNEVY?=
 =?utf-8?B?aVVlLytFYXZxSGhXakFkbmVHQzlyWmY3OXZ2OE82VnRtMFB2VVd5QXNtU20v?=
 =?utf-8?B?YXpENWJWdjcxUVMxS1llZHBLNWJkS1NhY0hEeGdPeXN5WlB4OHBPMk9nSHRw?=
 =?utf-8?B?bFd3Nk5JWkl4V1dZam9sUzhnUHFESVdjRWlwbmh0MHRqakREMTRTTTIzQVpQ?=
 =?utf-8?B?Y2pDSk1Bbks4dFZGdE5Od3R2cDQvdjRNZnpGcVdJY0taUmxLTXpJSEdwcVFC?=
 =?utf-8?B?Z2k3c0lmSHFuQkZzcktUNUtnR3g1Tnpjd3JuS1NIQURIdERJVXZ0UXZZczhy?=
 =?utf-8?B?Q2xqMC90a1RnRG1KWk02VkluanVCaGwraCswS2hTcGRyNTdSZkxMT1drT29L?=
 =?utf-8?B?MkV6cGg5SllpT1BDTWJGUzhVVGNKSzJMU1AyeVhYYmNYdWxzWktTN3kvRW9X?=
 =?utf-8?B?WEkrYTVhUmlRK2J1K3Vxci96dlExNlgyUWVXZDR5eHpna2JmRlVkN29Xa0tu?=
 =?utf-8?B?aUlyK1FOQ2tiMDlzWWN2MlZxSmJDcHFLckRtbkRvSmJMamNrbnJ0ejBwelVo?=
 =?utf-8?B?UmxSYmJiaE82LzlOYnhIb3BqSjdnV0VxRkN3cXAyUmhqYkRBMTBUOFJvbHZn?=
 =?utf-8?B?ZXpmOVBaSE13ZEowTEt5MlRzcG1VWnl0aFdXUCtFcXVsYzdsQk1NUVd5UUJS?=
 =?utf-8?B?anYvQlQ1L2l0emF2WnI5Ni9tUmYrREJGWmhhNERBeGRrREdYTGFLTDlseTBH?=
 =?utf-8?B?OHFwZnBjTThMYURxUU91NzdtTTN3dlJqaURhUWxkOXV1VDMveEVXM0JXYUF2?=
 =?utf-8?B?UFRDY2RHcitlYVJTMW1DL1lMR1ZPd2s2cUNZUjNPUTBReG0rU0JRNzFRVDN4?=
 =?utf-8?B?S2FCZ1YvUW5hSDV4b2FDLy9UOTFjbUJRbHczYlFTOG9BalJGZ0R2b2xEWG1m?=
 =?utf-8?B?Sm1VWEt6aSsvYy95VEpoQ2I1OHMyWHVCdktocC9VT0FNdnBnKy9sbXdqS1Jz?=
 =?utf-8?B?eG9laUYwODRkRGpBWnNzV0FHUE9GeXdBNmZwdzl4b1VlelVTR3NUdFNKM1Za?=
 =?utf-8?B?bW9rVGJ1VEs1ZW5ORkdXcmdGNWhqd1pldkhkRjAyZ1lmb0NrcnNETXlOc0R6?=
 =?utf-8?B?aVRoOG1PMnpKR0lNNWk1OEZMS05OM0g1RXd0T3BrMi9MMTkzbUt0RDI0R281?=
 =?utf-8?B?T1dwTm9kcXYvalVRQnl3MzdnSDl6bllyWEJWZUdEWUR4R0M4bzc5anJCU0ZD?=
 =?utf-8?B?Vm9sL3BtSnhaaW5WdXF2dVR3WEVTWkhweUhqLzF0YlJabEhOa3gvaFhBWk5J?=
 =?utf-8?B?d0lUeWt6cXNFRUdlNS9xUXpYVCtpYzlHeldkNklTMnU5ampnb1IvV0VQamFG?=
 =?utf-8?B?RDFBcklHOEM4TFFkQUs1V2VWWHIwdS9TVThCa0g2Zmh4YnMxNnJyVVFQU0Fu?=
 =?utf-8?B?UDRXdTZKOHZLQ2xnWTNnenRCWldxdk5uMFlVaU1Bcm12YXpqY2c0NGhaSnR6?=
 =?utf-8?B?dWVUMzJIeTRhb1JDMy9ZSjI3N045RGUxTVRRSmw2TnBrK1RjUDNqZm1rd3dB?=
 =?utf-8?B?SkdwL1U2SDFGTWtEcG0wdHdLSGEzQnhmZHZwNjVMNTMyVE0xNmtmTktncVh6?=
 =?utf-8?B?SG5iQ1BLZVhTWVZ4Z1YzMUZIZ0ZoYUx0UC9BVnllMHF1VXQ5aGtkMm80K21P?=
 =?utf-8?B?Mk1uTytkaGtweW5UZklDakpMVXJHcEdnK1BUbmcvZExTdGhkbnlNVFhoWndj?=
 =?utf-8?B?V2FUTE9UOFoyb0Q1UFRyUlo4cXFJTVQ4dTg1R01ZTitGQ2V0Zz09?=
X-Microsoft-Antispam-Message-Info: leNsMN62Y83J9PdwS189w7m/wOhHrfMB2hJhbP1LQNmoVZFYitavG+ZAhpvk6zvHHvqhOx0zpZ13yJ7T+YYsVfJKXREVwTnFrF/H3/7udgV9hqKGnPy1PmGbB/hTu8q3UF97PZsPeV5yRonXu9wTVukyiJRutG04WvDnz2aLuRrEC0Rn7WRHD/0zBglL0zYR
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:2AoFYc5pCmZZu5gNBx8a2dYMPFjuuQ3ROwcvSkt3dgkDxUbLjYkFuQBGeO0NftLJyGOCoE87+6bguY6g7sRNjur8hol6RmDWSLNaXL/iWPTFd2IB4TWh4TXgbaDA1hy3irY49Bzb2vWC928eeDi+QI7imYJhVCFbMw23b0puwEuvWVmfCipysWv3B3A2MLLxdx9KzHwesy1UcOcimq+TXROPTMOKSYNyPXaHYTeVA6M2TPkwb+uX+m5sMTWLUx2ECtRaWYSI7zDyJRXosFtbGl+WxC/Ip0fuJUYrqzZeFMmuIZrS2MaoCtXoic7Iu0xsCFWNjTqSNLN5vv2C1lntTJozVagNAegtr81vy3dWaq2QRH6r0scpBYI7W/WoUoDWbqDYOZConKrTvLT65CDvgOmKxr8f0yRdLji14Q2IdSPik/sgu42G7pngoKyxzpu0eYWc0teKR2XF+dTHd60Bsw==;5:sv2pApI/uMV30o15PVBu7kPX9Yqli+V7rqWcztKgW+iZsCe+80GDQjMIt23LfGdXW059HwNPDzSSRRoIgiJXuJChD6irJCEmIcU0NMTMaQaMTgM3gSiGm0BdQa6RtreCe6jiKHLuf6bCZbW3nHDLqcMOlmS9a3ZBCXHwgGxkCy4=;24:m2pCfsjnDANTj3YITenlJEZXfDHx5sd1y9F+1c4YvlEpxMSyay7KrVlc3XDjUfIMwolp0FaP5a1AUN3o99sDmQhVla3SIw45kWUXWZhZ3XY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:e6hVX26vbQ+HxJtW11PNNy9jCHE2NAKOkDktvkar38AP03ACVS+gJ073mabv7JyuiDiPtnMxsb0uQF46BemKPu4hKNMekQfrj0Epn8OjmTQtj6ciI5HFkkKUMfLVim5mFeHUbAUrbinbExUVwX75NYolBObTNfKSMpA116EID3XP1xPbueNQSfsGXiilzQxfXFO0nVrSlOz51oSceWH4fVyWrubuTPe8wrTXq0SXbA2Nb8CYgbwvmPfTvasDqtuv;20:8YAc2uHXYV3oNO9YUDLma5UoL0OnKntKSmpWhylGPfbl9fbR1r+OfwzHr94sHb4FSGWNvstr3+yRezF3CNEyrgZ9MxkT+wp9MBYlOXNuy8v6WCtiZwPrv9NNr5KLC3nIsqswKDLGQ9wEV6WJv7p3Z5KUSs2f0XR+kKCK7TUCEsY=
X-MS-Office365-Filtering-Correlation-Id: e8b74770-8031-49b3-8501-08d5a9dcc660
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:13:22.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b74770-8031-49b3-8501-08d5a9dcc660
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629619649042318?=
X-GMAIL-MSGID: =?utf-8?q?1598629619649042318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 2a4d29491947..437f854eac44 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -76,18 +76,24 @@ static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
-	struct mem_cgroup *memcg;
+	struct list_lru_one *l = &nlru->lru;
+	struct mem_cgroup *memcg = NULL;
 
 	if (!nlru->memcg_lrus)
-		return &nlru->lru;
+		goto out;
 
 	memcg = mem_cgroup_from_kmem(ptr);
 	if (!memcg)
-		return &nlru->lru;
+		goto out;
 
-	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+out:
+	if (memcg_ptr)
+		*memcg_ptr = memcg;
+	return l;
 }
 #else
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
@@ -102,8 +108,11 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
+	if (memcg_ptr)
+		*memcg_ptr = NULL;
 	return &nlru->lru;
 }
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
@@ -116,7 +125,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_add_tail(item, &l->list);
 		l->nr_items++;
 		nlru->nr_items++;
@@ -142,7 +151,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
