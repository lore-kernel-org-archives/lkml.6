Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqYaO6jyplm+3Zv2FbAkra2V948i6BRbe/VfGMDDslW5G99JyVUhMbd5l3/SI+W/QqEc7nr
ARC-Seal: i=1; a=rsa-sha256; t=1526633033; cv=none;
        d=google.com; s=arc-20160816;
        b=ADjZsYqdH3H+d7h3S8ChkU9hKN3dnppxtsRjnCYl4SbCk9NFc0Pn3TSxw7tzfbLsYy
         oooO3HwdH+u6tYOjR1Z0ZeqfkaYe34fuKcb0vTNZpRZzF8kt20pfXCz1jfz77m+8URtw
         8Hkw1/z2QbsAmVzDYnpZrkULjyJ4At2ppGXUYOq/kJ9f8+8yQHCZEzZYZlDj8c1Wa0/A
         L/yGU2MTkRkzjBYj0HFZHACJK73DlFQkKHNfiUhATaqY6mk//nERdgPc4E+nOgcBlRdB
         xmOWIWvVl9XToK1UNK8jJL0590lw5bwAxOzZcYJNKpfCntZwLM6YlRxcdoJNvpVzcHmA
         w70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=HMwdRD3+7OdPBg0FuiXPYL/OV9rHb3ut7yPZXNSPW2s=;
        b=WvmbgLIsawgkzWs7aqln3AHmQWSedILWklamivP/fky1D77sCezBUJFGgCu3rnzJny
         wjV3KoukX6d/Wfz489xBbA0ctUe+J7ac0HtGJ2SE221h+mjYCk5uQSDNCZaFDYq047PE
         F/1Ck+9TmVvBMdx8b7TYz6UAcnG/gKMeAbGyF7NKDtJ5ubDkXOTCNAVaCE9LYxkXMVIL
         jtU+JCgJy11fqtYkXPs0TCM0ljpEZ6fXIU37THwlgGpeukMmJZimiUIikNaKL5bopDMp
         fcPJ57qI3jgzSLYH/v4O/0qOhU3vbXIBxJ9uHZxWpsJaTySZ0zav5iWLfMnTxWTFpc8f
         Ds8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=UpPy2lsY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.111 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=UpPy2lsY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.111 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 12/17] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
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
Date: Fri, 18 May 2018 11:43:42 +0300
Message-ID: <152663302275.5308.7476660277265020067.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:5cG6Cn6gfAi1xXL8PE3pa9s6Tkuv5GGOjsyUSYURydGUqUpeo9kHZd1ZMwtDdbU8PhTVt0AySKyJWq3u9lfoqfhHGXdPGgYEDl89WlJDMOdh2pvLlrUjDI1QnKvmbqqTzenYXEF4mYVHts8MpNSn7O+H9NL13QMvr+sBti8Trr0PfCSzLdi/cweIjfLi7HBV13xgMMm2kbsI73eVcV8OljnBM8HxxtpzpTMRjoMqbuf/hy0Cbbz9YkGctg9yKDCC;25:SX189sW+HraFvBY2oVCyemmUdaj5VD9T0PM5luKv1f9mLzbFF2XLs6miZrbU/dZ6oweehHBwxYW8UGIDozUUvaVAXVX+mSFNwhYwnHWCEffS3PCcP/zQVd2jMrrm7fIGaZk+GqKIhuqlkNYorHa1nm2GMaJW5xXW/iezPPARTRP4Kir2KQiuz61nkk0BTqNnZYf7ROIY5xPVYBvNvFS6e7ACuj7UOhekRfzi7y8YKcp/sACBXcDRKPtiULRY+I1AjlOCdrjgHe133BQsg3N3U3+xHMt4yfJy0z0yKwndobrdlEiHyPpiXs3QatkOIGT5ecJJx1JR4MoL+UOtEgkIgw==;31:pU9EbRg0B/35Wspax0s06UNGJEaGDnDlrbBFoAO+nyvYZKdcwkea99xtstHE6O/XC6w0ETY+pi+yyr9vs4ltDr7YCYR2/ewt4V/Tly9UBMpXobptPhFsXfQ8Yg9HSTM+mGijjiPESdkuyLy1LOogDjQPKcDGg9zJUgQHXfiviCfYy18cYf95Df/hevnJfRpeL13W8vThp3gztCGBkF9zaZEVKDNX8xeBcyc17nF8W9Q=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:VNx0mxPOIb1VYPd2rvEQDVtusfvXs/MzOM4jBbnSQylQDvw+X5f9QL7OMZf3YZ5FKuUqP0eR9TJtidiDWvC++v+mughCAqNkbTltt9qeKgCMKSLHYoxFo0iQFExhGTiwvPHlGJFnNS1xFmFOKfDolSVNRqPKOsnhuPH5ami9ntMVBvnnytHRqw3NGVwua6A6XGVn5D+pY58N1GDpecgXA2e8gUJBh+olgCNAjOPqksdLCmOClocfZWrHrpy51d2m37iZvMQQGe75+3Y3Oq49Xnesdu3cF10Y/e6Dwmv1kLTZ+vGoBwSJhN78/4KmY1X46IEWAqaWlQOdg7f8Cw/tlsElqgvKwiRE3100GtabgGsiYTCJPqur5Lldk3lUtPY6wPccSHwyt9jm830cUN238ggvv6yG4V2iYbwoQj4Fc5et+KOiU1iNSDjYCBfUtLDMoBXCt3WMH/ejG/SKGiULP6d5RnZR0O4NDDRniKnxQrw7q9lESzUsAe8GcCHYYvv8;4:1R952GqsdgL0HKZt2UV4dGPATUGkQRaK1zn0sQVKZiK6cfd//+0f2OWbf3lu4Xl0xRcpPY7bShgtOovjR2c2hRahHQ6GDGNK6BXu8q3Q0KTlUcHGCetO0PsUQi9BDZqnUT9Sx7IvMnHlID8uVlU899HRoIrRqKkvlyAeqpX56rsH9KPU8tWBrDHppmX55BL7PkEZDKvA8CzujPGP64CtmiSqc3CwfeanB/zHWukuA7E4Y9gZ670+RNEQ5E3PWg4VWijot2MN1FqhdEC6a4xROQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341BEB00832A748493F37B0CD900@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39850400004)(39380400002)(396003)(366004)(346002)(189003)(199004)(6116002)(25786009)(39060400002)(81166006)(81156014)(106356001)(8676002)(68736007)(486006)(55016002)(8936002)(66066001)(47776003)(11346002)(3846002)(446003)(476003)(478600001)(956004)(105586002)(16526019)(103116003)(186003)(59450400001)(58126008)(9686003)(26005)(50466002)(53936002)(2906002)(230700001)(7736002)(5660300001)(33896004)(316002)(7416002)(97736004)(55236004)(6666003)(6636002)(61506002)(86362001)(7696005)(575784001)(386003)(6506007)(2486003)(23676004)(76176011)(52116002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6bEFnVldjL0JhRnorNnBndnAyblF5Z2Rq?=
 =?utf-8?B?QXB1eEYrWWY3MEwxdTh4bE4wQ1NUa3NyMnd5VVdZMTJ6S1hIVStob0ozalhR?=
 =?utf-8?B?b0JrYkpwWjc1aWhNQ2ExMWpvR0RTUndtVFZOdWt1UkJpQnFYODZ5aDNtbHJZ?=
 =?utf-8?B?YmQ3L2FzekxCTXE5Q2NIYXAyRzg3SnpLS09GQWFkZlNnZlN4NXhQckd5cXNx?=
 =?utf-8?B?RFZELzlZWXYva1VNbUpBOFFCNTVFZ1RXSmRkMVpjVEpZdlJIUGcwV2RSWG5m?=
 =?utf-8?B?R0cxZm1xRVE1Vkg5QWRVek5ScnJnK3pkV01GV0h3NXdDa25LNmJkT0N0VitW?=
 =?utf-8?B?Wk1GYTZZSUpLSm9BLytLNFEydDlpakRmYjRmbldNT1hSU2luc3FZZmlRWUFU?=
 =?utf-8?B?UXo5WGVjNEc5WFIvMmdmUWNxR0dBL3ZBUWxXK3UwTi9JSUNpSmxhYm1waG4w?=
 =?utf-8?B?Mmt6RDZPSUxOLzFkUkpkZG5ZdGc0WmJrbXJMSnlzY0hNWTlWZ1phd2ViS21m?=
 =?utf-8?B?YmJsR1o5aUM3UzY5L3paalVyWGdmMnMzNHNZNmdXbWxpQzUyMGpFR0dxUFJP?=
 =?utf-8?B?d1RLMlQ1R2N2dTVMQkZITjREb1phOUNLRXh0TkZTanBKQ3NDYy9UWDlQT0FB?=
 =?utf-8?B?bDIrNUxrcUh5dzBibzQvWUM5cjduVUZ4UEdhYTMwR29VK2tXNnBicFArbVp2?=
 =?utf-8?B?VCtYQ09hZlJNYnBZOW8rcDdxUEdtMTdqbjhiMU5tanJ2MkZ6OENxd0lrcTA2?=
 =?utf-8?B?Mzd4UGJDTUxoS1RtWklFdTBqSXIrdFhnWjVLL3R5WlVPSTFabkVqN3VScWIw?=
 =?utf-8?B?Z1F3SXhCMDFmVGtTR2VGZHJYd2pjR3Nac1JoM0pySmZvZm9RSzhiK2x4bmVr?=
 =?utf-8?B?ckNTUHVuRk5PVXY2VVFrOGZZUEtjR2JlQ2VkK3JuTkc0S3Z4bHNNdWMxNE0v?=
 =?utf-8?B?bXlibUR3UmtNV3VhTjY5VFZJd1h6Q3oxNUtNanV4eTdHT3ptUFczNTRpUmlQ?=
 =?utf-8?B?VjZrN1lMRDlmUFVETGlRV2RaZDJvRlJJNkJIQmE2OE96NEw3d2tEUUlKY0d3?=
 =?utf-8?B?SUxadW0zcWtwVllrbis2ZGZUdmVkd01KOTdjZzhUT2lGelp0L2tZWkpJU3dx?=
 =?utf-8?B?a1BYakcxcTE2YzE1ZVdVTEREQ2lzTGV2MU1NNjJSMHpwK0JzVWhHSjhlcXFK?=
 =?utf-8?B?VEFKR0NXSXY1ek9MV2NSYS8rRFVTOEFRMkhOK3lCOWFNUVlYSk53OHFMRkRP?=
 =?utf-8?B?NGlJR0hidFNJdXZNNExyM085a0swTldTZ0tZZ0xxV2MrMUZvTlh0TWt3TDVF?=
 =?utf-8?B?STVsOFY4aW1mOW92azFNaEc2T2dCdlcrYWl5WkZTY0FGOEczaVJCNlgxc0Zh?=
 =?utf-8?B?RnFNWkFzMlU2a3NCVkZXNmFZWG50WVFIZjlvMm1kaGNTa3NpWk1mWVJaekha?=
 =?utf-8?B?ZXBMSHJ6bU4vcnU1NWxBVTJtMDhtSGJJa1I5bVFNeTJieTF6YS9UbGxiTzEr?=
 =?utf-8?B?anR4TGh6WnlqRUJPMmhQYm5RZ3E2KzBVdUFIdWIvejAvdGdFbkU1cFUzMk5z?=
 =?utf-8?B?ellQT2lVU1FieHgvQ24yMVdiNXBIVTBMNTJVNTd2UGxEbkhkLzlLUXZNYjN6?=
 =?utf-8?B?UG53ZHUvVHptQnIrVkhmUEV4Q3dlWWdsTWFKTjhnMExnREhKcnJ6Y3NyQ056?=
 =?utf-8?B?VFROKzcvWFIwZzFUa0JmMjdneFJpdzZPUlhvcnhSWUVtNnBYMTFOT2QxTnFt?=
 =?utf-8?B?SEFmZXRINTJWc25BSDh4YmdPeklVb3p6TzRaVm0rOTdSbUpYekhUcUs4Y0Fo?=
 =?utf-8?B?a2xnOThXN1oxVWJkVVpnOGN5UUpmY21PNExISTFHSWlXWXZuUFRybHhSb0Nv?=
 =?utf-8?Q?B0bF2w8oQ4yfI=3D?=
X-Microsoft-Antispam-Message-Info: 7TLQ4AjhtDiTLJw5SyHxXFuMvQF4Jf2hlWy15Sc4vnN09BZKqd/5eDVqmiVi6I/KfE3Tw8/RAvOpfAHwAsDgyVH/9Kikgb27gSIbPRNkDVKbEceTqXr31lg7boLt2zZVzH/8qOmB0wBf/gbSJSgR0MRe7QTfhv0MKu/yrkGGwcKn6iv8/0SFgmtHygcGzRGa
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:eOn9p+fy0Ry/eVq4WTJ1q9q0ASYC8ei7HO/rJxDiFMsbmR94zR5c3SyLn/Grrwaeg2UEF+WNaEqnAdvEQtxQvE91LFhaR58ps8dkDrmS3v8bhlHRzk737ZkE45b57rmqkZ3QY7ylBqKEZ1ExPVE72OUAnWeg2YXMqmbg6T5gAjTk0oluk6oohIPfJ1UFZVCbfT7j8uPackJ2Nlxip4mFD+0XlQzt0KUdX2WZJMkt+KGcjfY5T4AdF3B4sJqiibT1cim0lUpzrOZJ6jCE/0BCMwJXpI3C0CS+dzrx9lYBseAbWwrdR0DkK7YeaRtb3fZyCU7T83pH1RePdI8vbaJMiSE00y22uSnY1WaM5xEyB552o/gO0O1nIhCJ3dDGdTqVBxcQnVd+qd74joE0RIv/lMys+lktVtLTcY0DvVTfMpa4wXnv+mVIHQF/PsA8a7Uk67uqKLDKvQUxgiwQjgH7PQ==;5:3CGmvmVC3kkZapQrLhUYDezR4LP5TvePwjzQhZlcsABwzCpF1c86W3dLjLsK0+Z8LDCqT4WSZTgjFMAHtJYghWFBWEt47Ns3irhNKk69ljeOD9rS2z4atgyEiujbf0oq5ne4Gb2x3u+eZDXkz0Tj8liixFwwOtmhhzQgalKuNEU=;24:MwBe9MN3RPjRlJ+/P3bfsdcQseuGAxDt7WWWE47wEfzO4l/BilwBCKLVuGym0xZnRJM+2pBO3i6qyozbXgcwfbvL3PRmwog982ltg01HXzw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:W9lgfCXCV5wIq+lOGMPzNk/iyPy4YEmhkpAVmP4As93xJCPH2NNwSpzagKybDVcjqyZDMfXcVqEOPstUQskJ9lvCIQpN2rX6AvrXP5CBbbVqSF8z9DJkq4QqM+uPN/uOLI1CD5+yqRxpKYPmS4ty99gXuDpTFj1AKEyykfBMmzMPKvFRYdUZ9LAZuaMRt5oQ+esei7uUl+NEAlbexMq+wEeAU1dGbYDUb7AEb7SgfhMtX0DN80hfOBGdK67QXe1Q;20:XaJQ8TUgWcpUJBABttXQb3DpC1pqkdAaUncgFvZNRA6kyWZ0o2sWzVFxOohZpPi0hFGxKOmGjv6/1xsWDHNTtsB9wevCBq9pLnPXrksbyptPyn0jaB3CFgDdgSYfvNPR8Huc4oLKc8n8DkQj641n0zt+1KkSLgydy3EBHoB7Mfs=
X-MS-Office365-Filtering-Correlation-Id: f8fed029-6638-46ab-fe8c-08d5bc9b78ea
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:43:45.5067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fed029-6638-46ab-fe8c-08d5bc9b78ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790759092195262?=
X-GMAIL-MSGID: =?utf-8?q?1600790759092195262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   14 ++++++++++++++
 mm/list_lru.c              |   22 ++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e51c6e953d7a..7ae1b94becf3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1275,6 +1275,18 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 extern int memcg_expand_shrinker_maps(int new_id);
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id)
+{
+	if (shrinker_id >= 0 && memcg && memcg != root_mem_cgroup) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		set_bit(shrinker_id, map->map);
+		rcu_read_unlock();
+	}
+}
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1297,6 +1309,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index cab8fad7f7e2..7df71ab0de1c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -31,6 +31,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	mutex_unlock(&list_lrus_mutex);
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -94,6 +99,11 @@ static void list_lru_unregister(struct list_lru *lru)
 {
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;
@@ -119,13 +129,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			memcg_set_shrinker_bit(memcg, nid,
+					       lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -520,6 +534,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -531,7 +546,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);
