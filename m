Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELuuz9KnbWGDX4Johnj6krPcAEDDQtv3Aa5HEQ5oS7cMXwG5SyPa+4GiA7wBWtklEoSkeiXN
ARC-Seal: i=1; a=rsa-sha256; t=1521638581; cv=none;
        d=google.com; s=arc-20160816;
        b=yvkg57uwx5075WIS/RysFjF02JXEsO4mVun99K29g0MmajZkzPs2nr9mQ3s09QTbZk
         iDl1LvNIiJfTeDwgWyk19zovwd5bDdOGIKn1sK95KiZ0md9MwoOcE/qWZfvQdiJWbXAm
         5o1n9qWoRy3/dE9/D+8IrYz0/C5Vh97JtlKAl+iptud1KKlktZXO6Uzl866xIzDeEVSs
         CrholLdxpOKp9BLXoOd2xkxN6FAvezPbjL1/vBE2EfKYddLRWuciNvXYnEgXZtLmWKPs
         LWfugQoxn9IQtpYhUWpxtWRk7WXg+1ZKwKzqfcoP/YLVvOVg4iWpeN6PyfM/xLionKov
         BHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=m39+VRTOrZziE9JELzX01rN727UA8GFlMD3bn24VhjE=;
        b=jbOWMAiAT7T6TKOs3613PZexh90cAlq236HSV+Y1ABVxLnh8Du4MoUq2Xe4qyTTHu4
         oaashSJdxjLw04DPAT8K/mXBz8HpP4hNV7cv0zPw1HPzx/C7pRZ2IVM8cfIkvtVJMLLT
         Cml6W4NoKcp9out/LoPfULxXFoxhPO4WHdpqRGJPLYmZONVADKn8a/quqqgGhEBwke0F
         Km8/wFTAD/wcq5NB9E/XJZtqjeq40fy6depg4NeAXlBgiTkfQFGc0IT9KojqPHd4a9Gk
         5KbOBwqJ8fjeQr1NjiZyfyOvvpPRHczCEWDHjbPBMNdJCnHyrV3SsEgTcsy/9U95MFIL
         Jveg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ECHpKd6q;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ECHpKd6q;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 09/10] mm: Iterate only over charged shrinkers during memcg
 shrink_slab()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, ktkhai@virtuozzo.com, akpm@linux-foundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
Date: Wed, 21 Mar 2018 16:22:51 +0300
Message-ID: <152163857170.21546.16040899989532143840.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: CWXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::21) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b9a5bb-c17c-4e83-6d15-08d58f2edbdd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:vyW4zurbL/y+fGMjfmnnZhAdShLaJZ7e7giIVu7FHf4lHBQDM3/PH6V1Rp0QlN6R/b2FmL+3bs8AOmxeKJ3LjFJEMTwcg8sTlWt5Il5N1IAd4pPX3z146V6yfn9zK0pJkser9RUOsHeX+UFI+Uvo1KlKwvrectXM4rFFXr9AKuEwm8rUNxlEp1Zu5MM9EGz8XU06wpoXpgK091IIMzbetz4uwRcHLklh1LhBCsTf+0XT2AX2pUnUue3nWlGowZcm;25:750Xblb+bOd4+7ucRKGUYKWRc/Xp6t1ws/FD0Cx39HFVlP/Taj9Iz8dRR/HBuEIgaUOqEZobPFBu7ZuTAnnsoL45k8w8fF8OyPCuvfGSDB5SvV5t9kcTX/lesKvUcHYEu6Yieum7I1rcdVQLPGHhNWA1rw1R4zFf4oC0MRxZzABhPW4S3uB+hI5l6JnUZBfASUsLlriJOga6S78zNubSCc1/vu/M7MlaNHjf8ynzbixTzs3I0PgKrKFCgXCu5pPXWNbnYgTGBYpDHH3KMjYpwYhFwuZ6hvKmT2z2dfneHfaL6OyFpqp9w8Ed34qXO+86OkSYQY1PEchMOKOr64VRHw==;31:Qd+U0MuQvpegREsIgHdDfqX+Rdy7iWwRbHtvT5EQ+et7aKkVOEMScIPLNL2VXyZrdy0BeDGwcvV1Colgdjcp0BvGkZ3KV0UN5/xeOP+k28YYEP1sbEwq0uSCcBrZG1nTdf4AATrR7hH5IkLMRPRDLscuWYF7J+Rykdszl8168T8xkDzTZhjvareRcoZM2ano4QZNLS+c66Pywoxs4UVwPrBeO7N0V5/GCB4Pz6FcI9A=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:MidYl6RfpxTCN73kof+CxUdCOIHir0bMRPPC2zmaYmDrbFT15HUAEhJDLjJdDw/o3T/Y6c+CdYhDPn2yUAKsTFvgOcAJYkweMcSHhbtw2HtbzKI9vExNzOU1zlZF+RvnBwmo30om9oEF6ayj99WzfQIPfTqG7fI5ZuTdcRdnLcxfWIdIdo+pI92yQegpFLzygy6Ab8RRc8F5BWuMM6CX2aLyaBJCA46+BiNNqvc18vVu5h5NV/NnA0qnFMbLOhaLp8Eu3MnHQw4CUfJUoxZgG78o9jqHEDnE4J98rokbCtqt6U2kCY/ix0L2MVp7H8BcsXB5Fnrv8KhsEa0wvJ3x8Mn1KBJdkqu69cwstRUQR9mBPz3dI7MHWgjGfwpUFuqo88PumdAyY9FGy3KREAd3zFHdFLMJKH1zX2NoctYBY+7oNx6EV8cDXGQh3gIxY9qhk7+960CluU1rkyKMvYCNpf2utyrIyl0pHMBfO68Q80/xqpvu5dieOEHaGjptjPEA;4:YbiWEjct4btynr57v9uvkOBtDAhLOtFXeS+4/rgUO37Gx4lnfPDBh64mDpMAFwjG/7xB37QW395wWpEp/c12tRb00qlP4xcPJwSDVSy/6EGoMK886elkfqgWZeuSlGJg00TSUAyKo1IbnoEAB8t85xREY71MbZX9jfcHXcJbeYwy4HzXhbooLmlViPXjFSFs1mVFUa9UGMNluSpeH1BAq7oupzsaixonm6/ZydWq3ipAt84S9vpmH0wZd6EWfLO4/LUKNf2lY1zA6q9UPOguvg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329D04874658E8DF6C406D2CDAA0@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501323)(52105095)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(376002)(366004)(396003)(346002)(39380400002)(189003)(199004)(2486003)(52116002)(76176011)(7696005)(59450400001)(61506002)(7416002)(305945005)(33896004)(7736002)(55016002)(5660300001)(6666003)(2950100002)(66066001)(386003)(47776003)(230700001)(6506007)(23676004)(105586002)(53936002)(97736004)(39060400002)(86362001)(3846002)(81166006)(478600001)(8936002)(81156014)(8676002)(55236004)(68736007)(25786009)(6116002)(103116003)(106356001)(58126008)(16526019)(50466002)(9686003)(186003)(316002)(2906002)(26005)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6cUlRYmMvTnhtL3BPMnRkbjN4RldLcW8y?=
 =?utf-8?B?REdqNDc1OXd5VXp6dFJST0YzYlhRSmpoNWlwTlE2V1hUdEppWlhPOGNpbU1a?=
 =?utf-8?B?RlpUYXFPMWlmQnNvVllYUFhvVmlyY216QnpBblJLKzlzeFp5Z3cxSnpmWi81?=
 =?utf-8?B?ZTkraGcvaWhKUnhpOWswMGJOSFJKYWt5bGJhL3E2NnhYd1NQNzRDVE92YUhU?=
 =?utf-8?B?VllSRENQSmx2ZVZGbnZKNWdPMVczL2FqSjJha093VU5IcFdNdkRkRThaYmZx?=
 =?utf-8?B?WXFqTHNoV25ydlovcTQxOS8rNUtUQk9xRFJ2b1RreXcvSXpzWC9EcFl1WHMy?=
 =?utf-8?B?WXpCZWY3czJhV1FOVmxjT2ZnVTdXVkFmMFBCMHo5OWVYNGFFT2ZzSmJmZ2FN?=
 =?utf-8?B?NjcyblRsUlBFelZXaTV0dzMwNkF6RkV4QXZUeWNRY3A5SFA2cU9wazF2RXNs?=
 =?utf-8?B?NkE1dDBab3c5eFpDOVF1OTkyVitXNWpuQUYrM3J3VkRTeFNqbWlnMnUxcldO?=
 =?utf-8?B?RkZLd1dFcHZ4SElLMlZZUUd2cEhJZmd3TXNvRmZySHpXU3JUbTV1RVdIQW9z?=
 =?utf-8?B?UTlQc1hyR2FOSUhKSUVsNFVsVXF0VDVXYjlVL2ZWL2dqbmZYNDFOd0RHdFdi?=
 =?utf-8?B?aHkyTU02cy83cEt6cnEzQXlja2NJb1I0aW93VThzOFVwdnNoT1M0UWpGT1Q4?=
 =?utf-8?B?VkFIOGMrRHNyelFQNHRXZktVc2NLSUJwd2F0a1h3ZU82SEh0VFJFcmRzMHFp?=
 =?utf-8?B?L0NEY3RTeC9XcUY2S0U0S0l1WlBXRFRVYjFLc1hCRmpGQUI3bmVqSmFaL2lp?=
 =?utf-8?B?cEhDQkt4Nm9FVDNpSC9Ha1MwNnJCOTlabXl5U2JxcmxpQkRNMDJpNjdhOUdr?=
 =?utf-8?B?RXdWSHpzSENSU0U5WTdzTi9xYndaR1pwaHNobm9tY2tDRDIrSC9DNEJqRWo1?=
 =?utf-8?B?U2ZWSHBUYTEvRnA3Z1lhSHJUTlBUeEJPL01qbUJYeHV5VXBnVEZ5WEc4d3hG?=
 =?utf-8?B?VW56bk83VHkyUzQxU1FSSHBQdkl2a1BLNnFMbHFSYnhhQ0h2ZEtBR0kvNml5?=
 =?utf-8?B?Y0hseUtiZ0crcTg3YlRtbWNKaTV6Mnpqak1LT3kvb3hTNXdzN1I1eWZhU0l0?=
 =?utf-8?B?ek9vVU54Z2g4OXdEdjY3cDBaUm9lTHE1WEF5dGRYSFFyQUpZWVFSSlA4SUFD?=
 =?utf-8?B?UTNXS0xld0EvTElhbE9LNVBwNWZOWCtPOU5vV3pCT3NPd2tKQnd6ZXBGZkxj?=
 =?utf-8?B?Si9GK0hFcVZGWCs0clphR0J1bFZVQ1hnZGpXd1pFT2dReHZNWHMxUVFqYXkv?=
 =?utf-8?B?dU5GbFBnZFhhbW1valRRcC96eHI0ZmVUWXV2U0YrajhkbW9PU2NwQWpnT1ZC?=
 =?utf-8?B?Y1NNd2dBaTh4azNFVU9aY09PRkE2Vzk5R3dKSVBjcEFRYjM1Vlc4cld0MFJp?=
 =?utf-8?B?Rm9MMUdwcWE2amZDUENoWTJTa2ZrTFdUTSs4RlpiNUpyc1ZzMndGTml1bUpx?=
 =?utf-8?B?aUZFeGVzKzZqLzM3by9HeFdjOUZpa2RaODJJSkd0TzZqYlRUb1FnbFE2djZa?=
 =?utf-8?B?L0x6VWlzenRTcGpNenhPNlhQMkJ3dklGVkt0ZEtJa2Z3NVd3VHhkUUZQSnNJ?=
 =?utf-8?B?cVY5dVc4NndKZlp6ZlJ5cTZpVnQ4cVh0TFFaeW9rbXRyQktmV0hOUTY3RzJj?=
 =?utf-8?B?Q0N4Z2N5RHBFTldqUzBvRXBmeGkySGx0bktpMDNpQlpHSWVwRGx5Rkorcm8y?=
 =?utf-8?B?d3FVWGpDL2dScmRtU2JwdzVRPT0=?=
X-Microsoft-Antispam-Message-Info: nW6OMZybxBsSaoOac6jA3K4nXtlW4QkETrEGn+bSdDFnqmMzpSuape1lILC/87J0QuEV6db4m6zbYixBmNw64uB/hRV/AXvJPCYeuN0ATllSXDQ6kzIxCWFyPfvXdjKY7JqDm6YGIiiS1tYbWsSYl5lw0RpDGX6u/1LpgjEozr4zpz1gLHNOQES5FestGW6e
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:s0c0ILZou9oWPmUOORztOzL3QvOLvYA/fvYxKK7SepDNJcIrPZSDaW41S4LUZ5McGTSSfV9Viks4HCcYg9J7LAtMUH9lxD6ZqcWsWFtJvmFk/dpXCLhE/k2j8T87wzV9ZnZoheddbiRDdwlEpgPUYJq5cpKNxAAqB085mUthQQORX1JdeAfi2a+lQBzSEJNrVC5nlmNRmtCQAqpVN4TEQzf5kee6fweXVJ3GmwH0DgZKa71XrX/TuuSM9Q8jLC1DLrmI3ReqXxp+vkpPW/4brU6pbI85E178XZiSwzLDC2nfIj4cf0AXsL9sXjBAkjwuTU0fuB3/9i03OAGAK4DnVBTTI76aXi8HHlv5+ayMeMrucij6S5r+8GF407gJvocnLw0bagxWNT0+igIV4tLYqdQ1eLTSlW/7aUDbP/KU+M35Xcd0vb/GrFtvlMLYxJa96gQXbZ185GnjnYH2daw5hw==;5:EKw2HQbN4tf+Xbc2n3//aT1jFfKoFzPla/BMPhd2lWDSnyAma55AWiVC3IIJuaLopv40Wqbz/uDlJZYKQtMhVdkyy5mo48fq9H/sKys1qK80+Lij/TBbNKwZ4hgS2NejBHmmX4Gfw8BdcTj0GNjrgm8tCOxNX6dpEgwNigDb7Qo=;24:3daLQWqkjUujiapZeSQd0GT+czg5buWDkUbYUJdB+sib2irQqKaj0lJI181baFnihqqFDzblSh3QG6n7XdKWxJQ/S0I1XCVDntkw82Ib53U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:N/kCNEwSr/K3zOGA7ne2P+2QjUSske0sM3o2UnJztCMzcRTAwp3/+ACXf9ocBQAhRZWarsl+lQIOT64Vo34DQ4gSGajNw3ewOfOfZTTbRQLIhuqsbuolHsx/3jofzM7JUcQgGxvAIPLWQk34Xe5Y52K4EoxYQEfp+IaEQw1mNNdi7gROODJ6upwFevp6EHO/fbpCa2CjTgg/8t1h+sDhwMrL/oVNnD6D8ejpfAMI2HeSsZSoFwQIhdGRECbMG+12;20:FprGOeKZ6Dsxma/q0kAFELFtZ1yTxKjgTtD8vhu7tJQl7DEHKubNZOoqBTBGPM+4PdAA6brmnVErD+6OXRD1OmPA9Ljvz3XAtH0pDeR8u2Q4A1aLq0jed86y1sAIoc8mPR1o1BiUqHSxOzgoYbwULd/znCg1Qu0DyzfWV8ays14=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:22:54.3736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b9a5bb-c17c-4e83-6d15-08d58f2edbdd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553697180792132?=
X-GMAIL-MSGID: =?utf-8?q?1595553697180792132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using the preparations made in previous patches, in case of memcg
shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
bitmap. To do that, we separate iterations over memcg-aware and
!memcg-aware shrinkers, and memcg-aware shrinkers are chosen
via for_each_set_bit() from the bitmap. In case of big nodes,
having many isolated environments, this gives significant
performance growth. See next patch for the details.

Note, that the patch does not respect to empty memcg shrinkers,
since we never clear the bitmap bits after we set it once.
Their shrinkers will be called again, with no shrinked objects
as result. This functionality is provided by next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   54 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 265cf069b470..e1fd16bc7a9b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -327,6 +327,8 @@ static int alloc_shrinker_id(struct shrinker *shrinker)
 
 	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
 		return 0;
+	BUG_ON(!(shrinker->flags & SHRINKER_NUMA_AWARE));
+
 retry:
 	ida_pre_get(&bitmap_id_ida, GFP_KERNEL);
 	down_write(&bitmap_rwsem);
@@ -366,7 +368,8 @@ static void add_shrinker(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		mcg_shrinkers[shrinker->id] = shrinker;
-	list_add_tail(&shrinker->list, &shrinker_list);
+	else
+		list_add_tail(&shrinker->list, &shrinker_list);
 	up_write(&shrinker_rwsem);
 }
 
@@ -375,7 +378,8 @@ static void del_shrinker(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		mcg_shrinkers[shrinker->id] = NULL;
-	list_del(&shrinker->list);
+	else
+		list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
 }
 
@@ -701,6 +705,39 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	if (!memcg_kmem_enabled() || memcg) {
+		struct shrinkers_map *map;
+		int i;
+
+		map = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
+		if (map) {
+			for_each_set_bit(i, map->map[nid], bitmap_nr_ids) {
+				struct shrink_control sc = {
+					.gfp_mask = gfp_mask,
+					.nid = nid,
+					.memcg = memcg,
+				};
+
+				shrinker = mcg_shrinkers[i];
+				if (!shrinker) {
+					clear_bit(i, map->map[nid]);
+					continue;
+				}
+				freed += do_shrink_slab(&sc, shrinker, priority);
+
+				if (rwsem_is_contended(&shrinker_rwsem)) {
+					freed = freed ? : 1;
+					goto unlock;
+				}
+			}
+		}
+
+		if (memcg_kmem_enabled() && memcg)
+			goto unlock;
+	}
+#endif
+
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
@@ -708,15 +745,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-			continue;
-
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
@@ -728,10 +756,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		 */
 		if (rwsem_is_contended(&shrinker_rwsem)) {
 			freed = freed ? : 1;
-			break;
+			goto unlock;
 		}
 	}
-
+unlock:
 	up_read(&shrinker_rwsem);
 out:
 	cond_resched();
