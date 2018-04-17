Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49g7TsYKbVljxpoTD736GeZq469xua4RPUEurAan1Go4ypYUQs5R89nrwmp38t7j8kyEQAy
ARC-Seal: i=1; a=rsa-sha256; t=1523980454; cv=none;
        d=google.com; s=arc-20160816;
        b=C/fSNAA0Ad4PYNfBk/EDRlK4m00KR6vU6jKoDOuPMJt8BJ817OSHng2y7Vjaow2Fyk
         CGLIOxV7xrPADyodEn3BCV76j7K2Cuu496CQbLD69G+dbNuNIpEFEv3qj/Ner/Tu1OGz
         z/7unZFCt8hiaCJrpKwkUcpgu1x2K0mlAtZvOxk3cVAZxEbHnb2cmuGnIfVZWUi+tLKo
         fgzbsNcNySdKx+/qN5be5UiLAKaDNofoYAqH0qIMRqMPlcczTI5DoEg/HxL9CkqWAfp/
         o0IOJLMD9p4CLZVMVUOcRwykyCHZ2y5eWEFAX2pHbRxP8TuAJXkMLKetqEhzbqol40Ew
         2OVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=TtLpdzodt4Axq3H+Vm1SDOprH0akPoNa42kKtMwjpL4=;
        b=KsVms4BgveXZ457ta9EmiUdLmtEldTWKqSTU94ZHsZgiThpFa9fsuzaVL8QLUHeQpp
         TyX2UZv7TL0L7uvl+eW8hZNN2m0cagD/hiQ4YO7XD5mzMyaN/ci2KIp15wdZW3bvy2J7
         o5ud9rR3qKHV4NWu5kIp9jQtbTYSiwYFgny0aJO0BlO3lSnf0Lzo908m2kMK0mvUwUOY
         TyFxu+uGRlrQqnEw1ecWWA3gCQ/JN5SLSUs3fxnlZ+aqL2vMN919rK0dZQ3OuB5gLwZ/
         aVcDPA9EWUuEoZAOiFftQwWh3t5i6hISsaKgvXcyK+4XrHplZNoRc1VzkB72bTbUHvfi
         9xBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LIfqdxiU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.115 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LIfqdxiU;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.115 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2 06/12] list_lru: Add memcg argument to
 list_lru_from_kmem()
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
Date: Tue, 17 Apr 2018 21:53:56 +0300
Message-ID: <152399123632.3456.2611169207870543630.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0053.eurprd09.prod.outlook.com
 (2603:10a6:7:15::42) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:Yb+zxKtFwkXOZyLiVaQUcJDLaPss56ar+H+JEamVwREnnxCD/567DJERG0icnFsj0J2Fx0UV4Cq+fCAIzE1fhwGQTD2VaZpsKO10GKUAZXRtQfbhVpFI5Uuf5VnMYZWyDBsyfS19mpTnSjBIRQC+fcvoqUwRLzEFkJTD1l5DS2LVLCuIN+j0TZDPuXfwM9RXDZrxQBVGd2tHnxbZVeWHGnUQUck++oOke06OP6VpYd+R5JzK6/lCdyhiBfemO++1;25:u24nMxtXZrUvve/2SbRU3KceDfZsWLPoJEi2IosDC6DwOFL77171bUk5XfZOuitGdRSul8ovfilqonB6UrCdiSLJpTIYJ99lfn2zMLMO6piDMY6FKyAs76RcPC9AWHsefcsmF/sse38bVDpSVjfGfJK34XSOPw/4wpQ0ZxP1PpZxiWOH+A+jH0RQPe+ATWy+8RKx6Wg9/KFNv+/hNSlG9cu9poY0qJUkvV37ac1645FkwQ4pNNm0ywxYHPoWLIzQeQA4wfhmRzQNWRZ5pCFrqYUGLBOvIB009QtrWn9M6ewKbdBSRzITZ0yTFR1QtQLNqqzi0342+hU6bnDBkqI/MQ==;31:0fbX0iLCGlR+Vk3gPojUM4s3nxhCBgz8ggXvaBO2LiFDsdMPXoreycfOs9MmyVufnp3CwcW6VXxwt9uTosxulN/f3ploOHESNxwNji9E8+Sa0O657GQWo9MdxK1N1VEYQE6GHzW2qAy2uAhPrLn57dlF5zbJZxlAslkaMmf5rMQKUqrUqZiHVmDqNoYlOnYOAlwkju0VRz1xUE9OlsLLc9s9aLUxcfyB2aZhp4W/WZI=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:7DsAPVbdtIZIHUGdFmLWJnxSGemjfANW+zAV6yoWr72R4ZjvkmcOWo0GQBtez/M44uhKSo0yWt5ee2jmX58jGrFOJzcDNs+/TyQXNGHDxJaDqh5tHrw6GibMKBsDXWEFhCaonBBwCVHqf3WnPvJfC8cBStfVx7VBLzsFw2gwaPUxS3kvnMNidWoYfdPpjY6ZcwfAY9cgqtgvs5Dlox8dMqWo7vll08+LM59t8huRe0cSaNaq8R9PSitDW/r3WAultWbm+PcJI7+hgQaVOB8Ccg24wwbScLJRxG0/S8Ty7FDcLHNyb1FjycKXl0OafAkRrcjBAt8y1meAw8ZFT/Wv/VY5x5HUZ0X3zz/UDggsJ/mwwXRUHPSQmfwUhlMYZ8wHI1rrR8GnKYq/BxIO7KT3YFC7OKIKOcsr+cildUCyaRSEKKYZS/JVXXFbxfv9VRAV5qgdBF3gUUkH6oz7DDBajj91BUPEERY1VaO544A5jx4G991j6cq434I12epXt7yX;4:vGFlW0m98uU1gmoSB/8qcSi0UGnD69RhDUaXLPHNVy7G73lnngQCSIHwA96ah2iWyO3y16lhpiLQVQdcY7thP21rITxfKDdr4HtoX6NMPgwCyrR/cK5fsRLtFM7j4oH3pQ9QcxiGldXTywqfsxKYeuIj025VJCfMrLV17NPXXbeBa7L8oH2adGmmvY4mQAV03akQMBDavIQO4OjG114bz5MC17L3TPvQjRvixDqd3woRBG6lHc67G4FqpmCBS9OudkQHrtcBvMIqCxI4+vUWTw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13350377FEBEA6DABB046F9ACDB70@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(376002)(346002)(396003)(39850400004)(39380400002)(189003)(199004)(50466002)(103116003)(7416002)(5660300001)(305945005)(7736002)(478600001)(105586002)(2906002)(106356001)(55016002)(39060400002)(9686003)(53936002)(25786009)(8676002)(68736007)(6666003)(81166006)(97736004)(81156014)(6636002)(7696005)(55236004)(230700001)(8936002)(66066001)(61506002)(47776003)(52116002)(186003)(59450400001)(26005)(386003)(33896004)(6506007)(76176011)(16526019)(86362001)(2486003)(23676004)(446003)(11346002)(476003)(316002)(486006)(3846002)(956004)(58126008)(6116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6cDRDL0FSQ21mYlRPYTQ4NXJWQnRucTdi?=
 =?utf-8?B?blg0MlFNZy9BUUZXQjBrdHFBN2ZuYTBCZUdrZkpDcG8yU0tEYXZoc1QvZUox?=
 =?utf-8?B?bW1rT3ZEZTBjSmlvelczZW4vMjN0c3g0UWhJNE83ZFM3amQ5RG9jRjdZMlZs?=
 =?utf-8?B?WDU4dmM5aEp4OUQ0OGFjTjVxSVQ0ZkIyejI1eHJJV1BWNFZmRkNnUVg4Z1Fo?=
 =?utf-8?B?cWtTUUR1dUJRS29HZDJMVitFbHdPZlNXajFMY0JJUnlxUXFmOEh1bWcyeXg1?=
 =?utf-8?B?MFRLQUFUbEpRWFFsUGc0cmZMckJ6VzVrKzNMc2ZtOE9vUXB6L3Rxc3BCazhR?=
 =?utf-8?B?d0VvL0NiV0tuWjR3TWR4SnpMSFlpNVh4Z0xIQ0R2aGllWUVmWDhhejNlTVJi?=
 =?utf-8?B?cG5KR3B1UGJQNHRPYkc5SUluam1nTWhpVjZzMElzdGVMMHVSa0srMzhtbTFj?=
 =?utf-8?B?VzgvSTRFZnNwVFdjZTJZZ2RHeVQ3ZEFta2lnSStlalRudWhXd2cxWm5ha016?=
 =?utf-8?B?NlpGTTE3bkpmRFFmSWF2aE1sdzcwMm53Nk4xamhVVDlaZjA0dmtWVS9zWG9F?=
 =?utf-8?B?R2NDaE80dlpkR0dwU1Z5eG5Cb1RjODlyblM4Z2RPRS9GREhudDJqKzlYMTRE?=
 =?utf-8?B?TGEwaU1pYktWZmtWTCtrS2M2Q3ZGTXpzU3RvNzhJTEpueFovZVovQTVZRmJm?=
 =?utf-8?B?ZkFudVZ1UXQrSDF2MVNWRkpjMDVBalkvREtLZUFCcVp3M1RzRFQ3Q2wxd0ZJ?=
 =?utf-8?B?a2h3RHV2SUxjYTllcldtU1JKR3RRSWNjb2xkZGhjT2ZoeVF5a0JHVVBqc2Rr?=
 =?utf-8?B?SEF1ZTM1WUMxalYwb05GQWxITlhzRVVjY1AxZ3NadDIxVE1RVEduZkZ4OGdT?=
 =?utf-8?B?anBjN0VCV3MzUzJsWUVUbGhIblhCYnZwYWVkRTJpMjFkOWVnTHJHRis4d3ZK?=
 =?utf-8?B?QklLbzBqNzRDMnU5SmpEY1dRZ0h2RitvME5lTlJLdTJkNXdJUTNsSGUwRlVv?=
 =?utf-8?B?STk4YlBrdlBYdmxmNlpFNk5EOWpKYXo0WUJhSVc1aHhuSDNNVXR0UFVXR25G?=
 =?utf-8?B?UEVVOWxKTnluT05wTzNieVowR0xuVEQ5S0ZhVkRrVE8yV1F3bXJGS0dlMExJ?=
 =?utf-8?B?U1lxa3NMNlNlUjE4ZENGMUtUTDNpdWdhVmNucnpuZFdJQU9MemRuV2V0d1ox?=
 =?utf-8?B?S29YL1FZRitrSi9DQ1NWZE5Vd2dSeGtzZ3V6aGpGSHNrSm96b2Z6Z0gvWHp1?=
 =?utf-8?B?QnBWKzE5aFJJV2dOTzVxd2EyQXRzUTlxZnB2aUMyNnhJVDgrTWRBSVJLR1Fo?=
 =?utf-8?B?WVBQcXFQK0IzaHVpTHk4YXlEdWREaTdaRGYzRnpWYmdXSjBrMjdnbnNYajlP?=
 =?utf-8?B?VlFDRFlDYkpXMitZOGJ4eDhnZW45NGErV2lDbEEyWlZ0cjd3dkhBeWdncFYv?=
 =?utf-8?B?UkQzbFRkVUNWVThnd21LK1FMOHcvakVjV2t2bHNENStZNjk5dXRRZFYvYW41?=
 =?utf-8?B?KzBsR1BhV2YzTnNjV2hYd21GbTZYM0xmdDVQN2UzNnlidW5lelBZK1d5bkxx?=
 =?utf-8?B?TmE4M1IrRnpOb1lQVUpKQnhjaXZEb0hXMDI1WmxFTUh6eUNXUER4dFZ5K21J?=
 =?utf-8?B?RWJScTVoaWZHc2Z3Wk12NHZjdUUraTJBNng0RG5ja1YvVm5lVTA3dVBKeU82?=
 =?utf-8?B?Y0tkcTRQVjV5TUxncHUyTlRlcXR6ZjI1UHE3d3RmMUtHWVFnODZPWGsybG13?=
 =?utf-8?B?eml5UHhCdkpNQjZNT2QrK1VzUWE5TmNYMUNRWUl6SjlGWlh5RnFFdUYwcFlr?=
 =?utf-8?B?Wks3MFNPL1BhMjFVN3RLQVUwMnZ2MzJjS2N0YXRqOVZxeGtoUT09?=
X-Microsoft-Antispam-Message-Info: ad1GPFrNIqnN7Vvy6b5FEYyPuLiod38bbzQB0fZEMcUW13ANKqgH7Ed1DKfb9KynK/kjqO29oYSb+UtKOKbXW5+QdJ6bfwn+agnPQKuj/nGaVbFWrfiH4jO+y/7z0vCPHUYeGc4mfxVEbQYCO3n9DInHzbFMr9t6h0QFctX3kxSObVgKcjeONiaV93+MbAna
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:VZijOk732vbmTzjVBFiIVq1JUr4Jeq3A7GBGIbCVNVV4pqah6J/mFZ7FcNfBE7hkAYfarrezrivQr1Lyi+H2dRKVLk87ARVlvW4X/1UVMZkP5ULApcAfDNuQOyJenPSYkTxUOCuu1ZKVlR4r4dtvxWyV0EW8Ra7ZTw+KZxouqfoqYU0E+yBNUWvg3IypdUE2ABUa/U/NMaJ7Om92iOpjFbALgoMfM7bJAmpRl+bZ0H69zyxKXXDwILyJj4suXlMJrzG8SgOuH46jiVmnQkCGSLXmcc2WJgcYWo4df1q29SX+Znm03+OrSi7LbCWqVWu+UXGwFkgIWsa4ZdcwBq5wZ+opXtybVySeCaivObkS3lBBPxcCfJfHspYq19Rzh8GBXWl9PqG5WDWv/uAa/ESdIirsewBTbtOR+47ycJ/SDXmsx1CVeBqOuk4D7nxpb1Pag4+jCH//CD4EzqRFsakBcg==;5:q0VQlhHf5Hv5459Zo+OTol4ZljyiTIG6SvqdKJhLmkTSkRUI1mvABhVvHWmaXrkfQiR3dh+q1JJSSVoCCrUzkWPqy7Bp9MBacJN+fylBgrhRV6i/GySyD9iC1J5xus2h95GcgJShicMGsm1z8mg7z+ztxS6vJUFEvxVmuHUB8Ig=;24:a0p39UVSfTTniA5kucnRfG7WB+3cCLGWkgmRcboScFrkQZsfpZg9B1VEwQN7BHhXNlQOKFNzko9ZTB6oP+AKbK0kVxiffYHU0aiE5Frz99c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:WL2TGwAR2ERIYCxl+IoXo00ugUisIm5nFjGAdD75ByOmDPy86f+6oyCoKMxjgb3R7O7Tywk9oD0RgV9rzuHCwrFP+OEb4RWL2/VRatywIfD2dZBXI/wM24G05rPpyemmf2MsX866fTWFHW+uNJamjMVjy7qtPoL8rHitXv13XJZEVCLoHnllH/ZJsfOkJSICPQTgbB5S+zJDvrOMjIKR6IF20Q6JqU/ohTiitqloFdYecxXq0l0zHFTmDApT94RD;20:Pdkoq53b/0V+maGO9ZS/0fBSn6J7aIfIYrwfA+83pNcAgXKY2c5g04WDedFWNtPdKQZc8Rq0KLhpfB+LtNnAhsA/uZQekiVmrDyOLZ14eUB3nL9UPAVJPI/2jcZLY1zeyQgFCc2sdENcDj0Hsi+DaV+guy04GOpd/kiZKGOkAmE=
X-MS-Office365-Filtering-Correlation-Id: 07ef197a-ce35-4a62-4e44-08d5a47b7422
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:54:05.6314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ef197a-ce35-4a62-4e44-08d5a47b7422
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009329142664409?=
X-GMAIL-MSGID: =?utf-8?q?1598009329142664409?=
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
