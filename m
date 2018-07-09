Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CDC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F34B20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QklFFGf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F34B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932686AbeGIIkH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:40:07 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:45728
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932634AbeGIIkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyMqznrFOa4ZW7d5NOC/Ifw/OpgPEN+F6pf+mLkhRsc=;
 b=QklFFGf1k2yrZJsyVBmkZymHOmIYqmu1sKglLX36ak1tr0ZFskeugfuulL272SMma9ADK/uBoI5GMJyyOGnatRr2tVjmAYjvfRFXnTjmfJeL6mSxcQlGnciLz+OsPb206LY7UjzVbEtAI0TvaKpqKWdJzuKcZ2pTEszcyrWQaOo=
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Mon, 9 Jul 2018 08:39:58 +0000
Subject: [PATCH v9 15/17] mm: Generalize shrink_slab() calls in shrink_node()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:39:55 +0300
Message-ID: <153112559593.4097.7399035563205590079.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:803:64::32) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4639d746-2347-4225-cce3-08d5e5778f4f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:2P+WSK4rZXyqm9C0PC0wdMb/7wGE9C2KDLKxbzISZwNJWIKClECWFspjGVx3R8tC3XJ+EGkLnkOQ/wkTqzv2LKlQymjHKqVvUimEN/zxzV91olLnC3QpascmU7N/NMB0E2GUp5D6EOsIa9FVXnrSuD2yQOO9Brz+UCUuxjXRjSBcOIoppE6eJ5ew0rKTpQBtRMC+dvsfa6XrenPdi09sGGY7/dKDwJNtf8qtzldFJal1Yum1QqN4u8bmHU4EjG5x;25:f3t5VMkJ6FEC1qHMxTODQJBVEeLQwUcPUUROWsnwBPCDsI5WJTt2nYzQgoiQedou0czGUEN5qUjYJedG3NjQ78HLMfT/9VTPOND9J0WPYCv5qDx/c3sVThzyJuw/TGUboBR2+3SF1Il9CViTrKj5Lg04EhxX4Q9DOFViTz+n1GEobcSTgjILs9WJaMrgbLYYQuY1LJjyJ44rvWEpksrEBGUyc7us+7tKC0k7F5wS2FwuLNJS+5rme5fo5xaO+oGPm15hh/octwlX/nnPubeKx0f0UpxwgZ4D1USEvtfr7TJNxWvF62f9LNlYGsp+UM6VS7zwdbtd0Bb2e+M7We/XRw==;31:4ztDX/t3Jm7BJ/EaYtNa9GMLLGboUnppyjUx+1rVZMyyFdllkt4wqweAl+Q1aYnjx0MH3BpyBfj4ZM3uDV6x/2lQ/SzzvFihuCbI+NNQfg2l/dNtD57arjkQkKPALn/QCJ/1FMfTmYdYj65CQ7AVpkbsqaLCQ3PUojF0Do8ngo7ot2jJoz6VUokOsiumyKLLfizU/yQtyUCW+yolBNUjZUe+kl/nPmw0sXVZFLP6134=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:3Hf25opEF6p9rG3LoOrWHe/JqYbp3QXSiqiklmainvGHvUGd6cMnuOLWaGIW/H0KbpIRUOzQ0t6rXP6JIPY3LFqEFZIF+zX4ws2puc95xrQ6JHxwzd0JgjE3vff1yzxo4Pje7nRcwa7t0eh+UHvrz9ubF4qqU+alMwJD/TCES09XZ19eHCatWy9wFoLpvnvxGewtg33qwRH+HEAEs6sS+NXC0ux2O8JQ5jVqniPzcifHEYvWVvR+70iDajtTP+0wMqtEdJr5G4FPMdz5FJMXGw9T+vJ5GHBBBCMtqPZIJDDAtgwHATiStLOjcoxa6JQ7VS+GoKrXkFtfLvfg1P5WNdD+E1Si1NPKCPCF23sfDCsVvpOcaemsswouRF5WGov6Pmt8iGsOQ5CV+ggQDurbhvSQlg93d+BUcCa6v3/7GS+DzlfUbsud1aRZKq09nvXZN2r5ToWpiZ/6jJRRdRin1m2SeLbbWEvowYmQcbGTPGB/J3de6j1xC+RliIJca5Sc;4:dxeYHdaDJSWB//TngCdpR9Uud/T/z5/yPfU2uHZBHXXoVlJZwJ9ZKGO4IPrvRugnzNCIa2fBY7ZDLChYk8wEqwyDE4Z39SAhnsNpv1ijnbe+UBu4zxCeYqcWh6skKtFutNrJsScEx0syC4p9viLJWhVFRE1a1mH69pGo2OrtpyYGtpspIE5i/jfchHneiNzLSphSJ0Pw0DHwB5A7eyY3scPiM8oF0l9Z7L+CV2ukqivDr6JA+IGffhvcHyp/kt42P+QloSgMgiH14v/mKJGqcjhV9CPhdSumI5HWlvGZNMO7/d0n2sHOgyxTojnNFme8pLdaTvx1nkU3jVcPjR7yPd7XsL1H0I0xRtml0aD25n6FcULmU9HrmYEfSpr8y0z4
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1334CC7D17C9A9692B77CFCFCD440@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(33896004)(81166006)(103116003)(316002)(2486003)(23676004)(66066001)(6116002)(3846002)(53936002)(68736007)(58126008)(97736004)(7696005)(52116002)(386003)(6506007)(8936002)(230700001)(106356001)(5660300001)(105586002)(14444005)(25786009)(47776003)(50466002)(76176011)(8676002)(7416002)(81156014)(26005)(7736002)(186003)(39060400002)(956004)(478600001)(476003)(61506002)(6666003)(446003)(2906002)(86362001)(9686003)(11346002)(16526019)(305945005)(55016002)(486006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6UXFZcWdLNUU3K3J1a09NU05kelUrRWY5?=
 =?utf-8?B?ZW40aDI5R2dUeUQ5cEVzNWF5cFJnZExHTHk2VlhQZUg4d3loaHJJN2pXWXlP?=
 =?utf-8?B?MnV5RHVsWWJ3UEptTDkxK2x0MUNURTlkZkRNczVoRWJ2YXhqMUpQZmZlZEU1?=
 =?utf-8?B?dVhEWmpzcW1oTnRUYlFyNXNORm9ycFRtY21wTGkyRnkyaG1xaDYrY00zVnYy?=
 =?utf-8?B?S09mOWk2NmRyc01mK1lNMlhmSWdGNHVtUGxFYzBWMDdlSGVGWE1mR1BoNmpI?=
 =?utf-8?B?eWVrOFpZTHAvN05xajFvUjd0MERXS0dxZ281MEFpZFJQWFQwRWROM0Fya2di?=
 =?utf-8?B?a1QwM3FWT0pkclhsRU9lU1F3dktNQ3AzS3VZcWJ4Q01hNFVaVWpkOEFvYmRw?=
 =?utf-8?B?MzdBVTRudUovbDgrOFcvY1RWWVRIeU1vbExHbWdGeHZuZDU0N0o1OXM1MU9l?=
 =?utf-8?B?NFlOU21Qc2svMi94c0d0OWxZS2h3cVZKc2dDZEUxclZ2azJ0VUtoMElDVlBs?=
 =?utf-8?B?YVE0R2lXYXdJLzNyZUtTNlQ0L3E2S0VGekt3QUlPSVFsdlNZL0dwWm5EQ0FL?=
 =?utf-8?B?dGttNldMcVBKc0N3NjBTMi8vZmdJbStMUHVLSWU4Tm45djNTQlNSZldlVnVp?=
 =?utf-8?B?UFJneWpjckpHRVdsVzVMMjhHL08zZldxM1RlOGJlMVBnMEdwR04xdUV3WFhq?=
 =?utf-8?B?RHV4SjZwWVVkOHJWVXhYVUdrcXgrVm1ZV2dwY0Naa1U1TzJCUFpsRzk3OGtw?=
 =?utf-8?B?NlM5cEp5bG1FckxPT3BPR1d4ZVIwM3hIcW13NENTWnpRU3dDb0MxdXZCVFFW?=
 =?utf-8?B?OWhKV2Vub1ZEd1ZOcXZiK2ZLTURHM0wxN2w1TENEbUViUStWYXJ2WGxhZ0Zo?=
 =?utf-8?B?K3pRVGV2TGlqWmRLUmgwQmlmZFFYN0M0eTE0dmZHanJvNHVzcEh5OVd0OWo3?=
 =?utf-8?B?VVpyL1pTcWFBcE4remthbC9seHl4cnpHSlFGUEFDbE5Ma0FOc2poRjMrZjYy?=
 =?utf-8?B?bnZ4VElrTjB2VVFXRit6a2hUNEdpeFpNUU1XMUtMUk5nRi9lQUg1eVA2RnB4?=
 =?utf-8?B?d0EvRnpTOGQvRm1CTTF3NGljWm54ZWp1WkZFZDRVQytUYnZVMTJ0aTBHUGhP?=
 =?utf-8?B?L1ZKSEc1RzJzbHd6U3M1WlkxY1IydnFNM25ENnU4U2JxN21SRGF4UnUzRllD?=
 =?utf-8?B?VnRWZFZVVFZpeTZ1K3pPZGlrc2oySjUrSnhlYWxTQmVmQkdweGkvMUV0bk91?=
 =?utf-8?B?ZW1LWWRjZkx6bStRUWlSQXZObkxpVkV2Y21UK0FXaERHMjN5cUJkbG1yTnhx?=
 =?utf-8?B?TnJXZnd6S3BRTTUvQ2Nyelc0UWR4bUx6WjZnZ0RzdmJUSkM1QzV2NVRhQjJI?=
 =?utf-8?B?Q3BQUktiUXdKOWNWeGpRZnRGNFhGRkZGTlJRd2tqZk1TRWhrVm00SHQzcTlF?=
 =?utf-8?B?SHZnSTFhWGs5ZmU3eU52UlpjTE1qTFJSdFdqNGl1bUoyTVNOaHJrM0JPZVRq?=
 =?utf-8?B?d1ZOcHRxVUFuenJOMXBiRVpkNjVSeUkxRW83dXgzUGthdU9yeksrMERBM0ox?=
 =?utf-8?B?SlpnclZqMkNIa3JzVUN0U1NsRUNGcVNZRHZoR0pQZlB1ajV3Y1ZNNzNObnFF?=
 =?utf-8?B?VWdOODZCM3hZekdsQWhGNnQ2b2JCVWgvMFVGTkVxeEx0TWREZXdvN3pUdlcw?=
 =?utf-8?B?dUQ0N20ycVVUU2dYZTh0c3NscVM4eE9objdoa3R2SWhqaWxIUDlWVGl0SUZL?=
 =?utf-8?B?UFd2eDhBSlMwZjgxdkswcENBPT0=?=
X-Microsoft-Antispam-Message-Info: xsECeOvMGInHRE95Bzvnu0r4F+if+NeSy5xUnlkWNLYX/S4Y6xFgFbcJuirc4D7Tn7wZzqLhl/GTHPSski0iJ+vh2W0nzcvcpvPzRUVAp+6CcxxUHTQGzGst2yd+fGnbOqHzBVM0eYoH+FR+Fe542l+LS4JMZ3jDT7jnfla8eyNl5Sat31mE15pmxruTuCbF6eB6HAFq4gbQgskda8lGt0tLjHmCvkdq5cXRXh9bqMFgA0h0yBxA9T3G1GvOdr+DAGog1V7txDRhMgzY1/U4AOtOgTLbN8j08rJ6B1AZYP3CxjYLoZLsA2lpyjAsT3tZU1jpu6qj4C0lnwfXXCaTlstL3qZiQe0B5FuYujLSMpg=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:mcZgaL3/APIT4g+gfX8zPiljRELjVfH78CEg+kLkw5bx7zCJUQocFxZLMrfUEBVfjLuK70Z5ApMuDz1nFoflCHtS8vYRobzy4wb4FyiMwLT9c5k1/2FKvgqQoBHs/gcAlpCQf4/KSgAYzf/uiz7LOrP4qa+rQgbk3UqNrYnRlqQN/XkOF6A3h0OXNqGsG0zxbR0W4bVw6PyVRdbwMo5N4XTqsnGymMDBK/LrGRBI4IW+VW+ieBea8lHxvm6/E2Uz9Oajrsz/W7TpbZ97jGMUhPYPgdg6zPYCwO98nJGKam4d2n1a7yiXq0ovND6pX2RgbO12Itgz4NWC8BXlMq426TykPslUAeJczJYQcml2RTA1mcOL4Zba6BgbS8p/5o8Nv+ZHpdy6V0o63f9BaegIjR30AIcM+uEKvnzc//nccdZ83R0SEe2VckTds19254oAhwdyJIcnpCzVvQmkCi5+AQ==;5:xVq/rFwiXAQuXdL9D9Ykzxb4dR+C45vA4oRd2+gU1BwkSTuGTvaqAo9hicTJyMwLxarermbZRyqCgCCZUkvVjmZMg5VEzsXi4WBIFvxBUBH3Y4tcMWI/3ZxeSzYzavJV5AXkMRQE4oMn7j6TXLG5KRFJvkn7buW9qDioQobnoYs=;24:PyGm6iTRofFKF4RikBk5HrPzZSp9Rdrn+dgtDi6toDDyPVEa+vZd2p8mqr6aKLX2QvWGTC5XDRkyM61w6O0eWM8L045FU0Fur/ZlQdwf/h4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:1PMUxVwqc8E7pXTzS3VEsYSlkA31X6n8XQmWYKfhm1QiKfX40QL88sgVPN9UDsL0bMsW+oLIPkAVuruloukrgyPNUUN4Eyjn4h+n4md0FBMtNmW8EN0CVNcmStSzmO2XBMIyQPdhFqfTl0r1Dq6ML4AvFnY72KsFSjYJaGCTRoM6TvBuutownEoPx+alx6hrHRj34XXwSyN0YwEtyDpP5rzcEJ1hfBkr3TVDzqQv4cdW/Ksw7VWNJfS4VYYxkrY6;20:ABTftAUFp2HA156DBu/GM1Acw4D9EnRxDVE5Mwxnnf1ZwCVytjxiK4sew9FsnEDgD17DjJ4BsN9TOUg2EGlQxY0ZN72LQK9rxjeghlwHX4wNnO9WSwd8BT9Un1D5F93uueV3scxzc/I1HUBdoLSIJrx1aFRiEJwvd5li1vsaAvY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:39:58.2980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4639d746-2347-4225-cce3-08d5e5778f4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Davydov <vdavydov.dev@gmail.com>

The patch makes shrink_slab() be called for root_mem_cgroup
in the same way as it's called for the rest of cgroups.
This simplifies the logic and improves the readability.

Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
ktkhai: Description written.
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d7a5b8566869..2aa3cb760189 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -627,10 +627,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
  * unaware shrinkers will receive a node id of 0 instead.
  *
- * @memcg specifies the memory cgroup to target. If it is not NULL,
- * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
- * objects from the memory cgroup specified. Otherwise, only unaware
- * shrinkers are called.
+ * @memcg specifies the memory cgroup to target. Unaware shrinkers
+ * are called only if it is the root cgroup.
  *
  * @priority is sc->priority, we take the number of objects and >> by priority
  * in order to get the scan target.
@@ -644,7 +642,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && !mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
@@ -657,9 +655,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-			continue;
-
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
@@ -689,6 +684,7 @@ void drop_slab_node(int nid)
 		struct mem_cgroup *memcg = NULL;
 
 		freed = 0;
+		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
 			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
@@ -2708,9 +2704,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
 			node_lru_pages += lru_pages;
 
-			if (memcg)
-				shrink_slab(sc->gfp_mask, pgdat->node_id,
-					    memcg, sc->priority);
+			shrink_slab(sc->gfp_mask, pgdat->node_id,
+				    memcg, sc->priority);
 
 			/* Record the group's reclaim efficiency */
 			vmpressure(sc->gfp_mask, memcg, false,
@@ -2734,10 +2729,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			}
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
-		if (global_reclaim(sc))
-			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
-				    sc->priority);
-
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;

