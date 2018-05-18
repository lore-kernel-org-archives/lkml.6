Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZr28E2AfJ3X+BAfvbp+jlHtjJ7TcxdkOt/vHHVRirORKfo7qKGqhmvWesxe6LKW4A7Rzfd9
ARC-Seal: i=1; a=rsa-sha256; t=1526633062; cv=none;
        d=google.com; s=arc-20160816;
        b=iXCseoE2KN36nVmjnLUdcqIaakNy8915nwyEt+77EIXafMiVRGkbStQ8oxXfaJKDav
         Z/TBgxSTZYN5CCxcZOc7wL0pa20KmIrK3g4UlgpX0mu8wH28rJJ99IAm8BRZPzqclt3x
         DrR83nlSrGi2zxW/i20ExOSQ6zGGTYj+5hjxGT8aniH3xwJnXflco58McWfppH38zMZT
         8N/H4tGEzrLBM7PU9QuZz+VeYRTeqYPc2ztmWCQDj9wGYdAajmQQ64WVkp/xvIP6w1kH
         k7RUlHrdQpOvAn4nFYXTMiqFub2yjcfuw1GIFvcKsMoVSy8A/OWYjGWd5YFbbCnsvVns
         6w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=5ph2yXX7x8Q7d1qnUfzwvWD/X9Mq0MObtjdmrodZ3YY=;
        b=f+6uB3HolI9lfw0vvcplNFHoYOZCYqOK7ch6kHyEXQy4aVQuSJnNa5/537bAQ25A4p
         zRXqkNpMjJMVE3SdztE/wvldAFO64jkNyIuvd8ozKExEka97XEXOD1E219gfITP4qOgY
         EdkzWUqOSmCbVSbZ+zp0cJa3Q3yoXYtgR93ZC571XI77tSG4FzITNOHqXUjeb2OJjNIq
         Nj3PGB5utHPh2hU0gFnWRnkQdgiT6+z5V/71nujNI7BtiY8YyeT6io/xBmKs4f2vLEMo
         /YNPknmhpc8YaamAKT1N4hsCdoialTgrVlX+UY5IQ4x3AsTBDrDK6ATPpdqNQaidBHF/
         b8Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aywkgK78;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aywkgK78;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 15/17] mm: Generalize shrink_slab() calls in shrink_node()
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
Date: Fri, 18 May 2018 11:44:11 +0300
Message-ID: <152663305153.5308.14479673190611499656.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::26) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:nbMLuTed+eNp90g1gfD5px8jGDAi+hEjGBZr6McnK5/ilicH9a2pWYh5kkIJADnSYhzxYRLei/EuHmi55+zQF61BQHIRZFDAH03B7JlbBNCDxEv52GODaU1+JlJLMllh9AMqmARYEUbubVR6H3n91eRzRii8270vlnjrAdAK/jTUs0CkAv/Mb9Ojcp7e6by+F5cTwbcA1xqXmdzL2BtRpiQ8U1wz/5TFR2hplUwuV5h/cGwr7EXDFrAMp9AvrhWS;25:SYzW3WVfdw4Wj+pVF15WMcsdFlBpzdBEuxosNbdzzm21PRT0Pl0Uy/YKK/H21nmc4T5SLu11aSgOZt+6k3oUghhqMSDw9miRGKYlmXfDH7jPOuOqz7fQm4VnipEHfxR0otq5AedaIdxxaNH6+N24wpm5u/HFWeWJGPxlj0NCWACvLE4lzvA8Mu6ecYWVpY++9jPoOkYlzjVCU2WWwrJx7QHYBwu2o5+AHFNlZI1PY5D4oEkonhOiq6ahcbRgRh3dg9jHhmGW0Q3MeSqzr2zuP+kqd4cXfe60N2iLpb91fK2rusieFfEBTj26crHuMa6BuF69nb/GRlTeFGR3ZmuSsw==;31:PwHODIpDf0bC8fBwg/TRu0R7mNWKidd/kt+o6Kk3Q4LQMxVsgV5o+Q0NyZaSbR3oFk1CiiAkFsUbwS81uenUew40pe0veB+QgR6U8Z1ziytrHU1bwrXQO9ciT+qsYo1vDFNdJQ0E6RFvStb1sh9GU+P4NmBvCcVLQADgfH+e2qB1RB21EulUkP6DgSDvmXXaYkFqVRgfQVwpWArYOEZcNm/sHW81Db+8ljogr+7gqaU=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:WidgSgaU9vw1mCJIOFMaGmzcwVvWTr40F2CojjwgGIldNaiRGk8um6Pks0ZhZinI1Xwj0kD2iXKGmn/3Bfnuhlv1+47y7jU0x5tZBWTV6PnAVEJ8HFM9rQibO5KOVcXuJsMJQKuVGL9NRCFMlNQRDJny6Rh9UPX97X0Bk6BPAYlERgGZmVc0JQwLgjGMFwkt/w8uBkTGpyEqVrDe5Q0cBe6KK3Fv/0Tu5CX22UJALzegoBI5Wxegwts1fCVgreLYUIKEF++0c/vl1Fdg3Em/GyHnAWdPkfvzzdiL+iI+j8/fdCQbgdPwqcO1DC+YlnqhzensiP28/oAJQumzrKbNlCjc8P39Jz30CME5FTHaQ6t+Va4mwMfpf4Ay9mObNEM+d2EndE7ckYx3gVlvGBQPlt+Rm6Tsgz6PvfLJPRuMa+CBPrCd4FpHJWeGbON6N8l7JWiTwnc0VU4fHtpXtmuh4aA+cH6hxew2S5gj/NhQT9QWY6I+SfJQ60XRNsSKxUYV;4:PoVSa9i3Ktd2/ShmKoKItoUGHtx/W78bTNZEB+C3b2P3kohLzcQ6KVzbe+fh5rXaSoQitrKe3DXoLSB4aKYKYBooQ8rZE3s2Su7r1tj/vgUWVMYUOYvRxLidiF4kp8KXczUxCMkFQH6t/jWpn3vWuvI6SyoSyEmorNDpuqJBGknq+llNpVW8zUP8UFNqTm2ZGhfhbWs0KRnGFYPtolTEIe2wX1omIy/vCosIidSoP8O+KkkxoUbM7Q29Jsh19D0gfsVdipM9tZuRp90JZoCYngIukHzit9OeKCaFDbSzviKD/vp8i+CwtUSWM1R6auDA
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13432126487EB530E54E0AD4CD900@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(396003)(39380400002)(366004)(39850400004)(199004)(189003)(6636002)(6666003)(81166006)(11346002)(476003)(446003)(956004)(47776003)(50466002)(103116003)(106356001)(66066001)(2906002)(81156014)(105586002)(486006)(7416002)(5660300001)(61506002)(7736002)(305945005)(8676002)(8936002)(39060400002)(23676004)(16526019)(478600001)(2486003)(186003)(26005)(7696005)(76176011)(230700001)(6116002)(25786009)(33896004)(3846002)(86362001)(97736004)(316002)(55016002)(9686003)(52116002)(55236004)(68736007)(53936002)(58126008)(6506007)(386003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6eUhQdmsrVTdMYTRsTGRRZTlzWVFKNGJI?=
 =?utf-8?B?SWZhcC92cmpJcDBpRlZVeWsrUUx2Nm8za1BOclppdFBISllCUGVwZGRZaUVN?=
 =?utf-8?B?M0szUXgwL1k4YS9OT2FQdFdJRzkzajVsUVg5dGtFOThPNzNRSGV5REZhRDNl?=
 =?utf-8?B?cVVxcWo3U081eG0zbGIvckx3bTFRME9QY2xUSXFmbXJYM3BwV1FFc25PSWt4?=
 =?utf-8?B?UU85VTBtUWdKcDgzNFhNMUQrczBSTmlVM2U4NUU0a01wamI1d3NIekQrTzlx?=
 =?utf-8?B?Q1lXd2UxY2wvUGp5R3JtejdQUU9PWDBDdml6MHJvWjB4bHd1QnhIVE1mazhK?=
 =?utf-8?B?c01rYVA1YlNhWlVhbmlpSCt2eTN0OC94NzhhUmRFVVM2NllJcDg3ZzlRN0Yv?=
 =?utf-8?B?MTJ3a0NSa3FhRVBSSVhUcWQrQmZvS2hhUm5McDFtV1grd2ZPMzNXM3FIbE51?=
 =?utf-8?B?Rmh0Umc1cXFwbXh1dnF2eCtoSlJES1ppc0hxQXlPeG92cGlIZkdKcGkvRTU3?=
 =?utf-8?B?aDc2TVYwZlZWNmhDR09OWE1MaFRRb3hLZU9Jd0Y1S29aeDNFWlgxeXlQdDNx?=
 =?utf-8?B?SzZoSmFaMFVVYjlCYVJ6dXV3MFVpcm5SWlh0OXFwaUQyWW4wd0gzY0xaMEtr?=
 =?utf-8?B?ZVFpTlFGSXFZdlF4VWI4eW1kdzBqdzhxT2ROUlpUbCtLZk1Uc1cvOU5WVjla?=
 =?utf-8?B?Nk00Y1BQeGdvaE9PeVpDRmFnM3lwck5JTTNLWGo0bHc2cXk0aU5IUnhCd3ZR?=
 =?utf-8?B?ZGZJRWxSMHFXNkpBWEI4YTFZWjJTR0s4dTlVM1RPSkZGWDE1aFNZaitZZ2U1?=
 =?utf-8?B?c1l4Yk9lZWhLTTk0UXNWWTk3RSt4NkJvWHI1N3czQXAwUEVHblF4Y1g3WXJM?=
 =?utf-8?B?OWZUU1ZQTWdpR0RPeGV4YVZHSUtub2w0UU1GK0dVekNDbW1tbjE4YWYrN1VE?=
 =?utf-8?B?MEpsZjRrODZZVnBTUEljQlhFZVNneGdXaXFHR3JBbmNIbVQ0UUhJYzQrbU5H?=
 =?utf-8?B?QmUrQ042aHBJVDJxU1Z0WnNRcEZHY1k2UGtQcnZCa0pOSmdjQ2UzcUpOZENI?=
 =?utf-8?B?cDBsdVpMMHBUZml0c2lLSko2cTU5cnhMWitZM3VyREd5SkZiWkV6cTM5Q1Aw?=
 =?utf-8?B?K1VQLzRqL2dYVmc2UWxlajdFcG9HVzFucWUrcFJvMzNFZkt3VElRTUN2bTlB?=
 =?utf-8?B?SWQwNDc3djB2VXRreS9hY04rdlREdmNBYWgyWm04VlhlZHdjUGc3am81alVB?=
 =?utf-8?B?RDZiUlUwei9tMEE2dkVSYWFNZ0dDM1ZLNmdVdmJCc2x3MFI1ZHFxRXlvdEZD?=
 =?utf-8?B?eDBCNGF3bEtsLy9kSXQ0QkdPMWpUZFdJRHpwR2dWMzVzOGU1QzMybnBzWnRJ?=
 =?utf-8?B?UjEyN1pISlhOQWtxSGwyeW5BaWFLa2k4ZWFTMXM2TlhicFdQOXp0cjJmKzZh?=
 =?utf-8?B?TlN0WWpVSlpwYlZ6N29adjlncU5qWndQbFF0WXdac21mR1ArQXp3R0tOSG85?=
 =?utf-8?B?T3o5Ny9vb0k0V0ZkM3ZWb3BBWi9ZVURBMStYUEFPY0RDcnYrVmNPSHVEYmpY?=
 =?utf-8?B?TmwzUks3VHJHaG9YMFA3cW05ZWdSTmFzUFE4UE9nNGhjSU8yckttM2lPQkZB?=
 =?utf-8?B?cDFuamZTZExWbGRUMm1ZdmlxdmhUR0JoNHRMeFU3ekFYYkQ5elJ0ZnpMV1Vz?=
 =?utf-8?B?WCt1NmRWcGduV3pRc0h2cklqK2Fpc0Mwd0dZVVNQNVZ2elprb0toclFLeXdQ?=
 =?utf-8?B?bU5kK3RyVTg2QzlnVzNrajVFRnNKcWk4SXdYekVMNCtpQ3Q4UDhNdE1TbGZs?=
 =?utf-8?Q?lgv68fRtOjyWlhF?=
X-Microsoft-Antispam-Message-Info: Rb9N6DWgEIPmH4ve5P4K5jYIseMrekgtvXQB1412wd1hNiKkctx/9iWiF9kDv+FHMonLiji70/wWVWl530Bg6XATaKyS6a9SSAlP0eoAuF30aI0eB63Y++Mg2H80TrH+YWixMyQUwoXuutt51Ti8AAC7IJDjZylGOxqTCBqgShyXyS6QM9Lb5tgbhwgeB4Z+
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:Y5CyKthfSiIf6ZlAKlIJBBL2ZGysNzE9P31RfkTY2JhCz8FbmnuxgVgd5avwlQd27hmQ6FCOj0EMdFLLvPGm9oyD9v3ujzL+Ggq98MgKtYeO3XPIERDiaXmQxxJOb71xYXZfHPzTregMXQ0P/iEaXxw7wpI544mxCXfd6C49JzRaxpKOzOycd40/8n75iPk1N7hUYn95sWK93PlUwdlCXy16KfO0pdw+bOFOtulXH5L90/AV/e7C7X/VK7AtiE/uJ7omYEKwLEdIRy0hJHN6lboOOEKkabb1qB1euXQPPa8YiUGvdz57UYMh6fa3FHlbTNWD89bgfqbgHfeWUaQVuOkKX3N7EGj4wwK+/J3i/W5ngMbrIxPacszR4IU4MMdZ5or7Bsm2Vl4Jru8Q8NYzze751LmO0nwqOzbSwBl+xOnTAewaiQv6z2KDHACrslitrL25gfPofR4Y42ekiWgUCA==;5:7Bb9LDNvDWL+v081zUk6kRz4+pjYAEdlQQsVhCtBe+UbEP3yM2lZtQ1KxT/JJerKoQNbcOrUOd2dqMEIAn/U1W/VRE050QW5JSF9XkEusdwdgzsgfny7GjIyLWJaJrsvoGPpxBRFaWY19/HBVwKywTBGmccqnWWRSAmZt9L1cv8=;24:TqZ98bVBwAhwMXHOrJXKVFazJ9ZTP55kBxpRZ0/92D8e5v6CkBRYkR7KQGzKUY9TUUrHhKR5BAAGB8/HHEtIxcPVwiQitg+eT0zLYN+H/Go=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:7hk6gysHr513Rezn0qSbATxKiexNN3mHE0jemk/kC9pcsBrw8fvpnDFxW719gam3TOw6nH48WSsexWLkkbtdJYiD5T5RWOF9MyvDFXOpA2WjmYZcQ90j/P1T9kGf2tKWJWrJqGVRGC3OzjWFI2Ne1f8Ago46ietMTepWrGubujmFNi1S7LOnJTRdbHKGNOnlpyew/THhtZ/CkYLP4CrcdgWokp+iSx3KcOhLVrtlcQXzX+LUr+poTSoUF/7/Hge9;20:LsCttxcs3puCX2zwRdNuTuuId9O+lQu5823gmofDazBh0yVTwhee+M4Mknx2RdBbZ31vmI5SflYi8O7myJ3xozx0Gg80M2NdO4a81pCajYh9CE2By01M6FQ24SvQ+S9Ao1p5q9TX7LqpVZ/AsfLsyTxfKKNqDHbaHoWRUdKh+F0=
X-MS-Office365-Filtering-Correlation-Id: b1b5555a-e8d3-4ed3-52cf-08d5bc9b8a33
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:44:14.7520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b5555a-e8d3-4ed3-52cf-08d5bc9b8a33
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790790376098452?=
X-GMAIL-MSGID: =?utf-8?q?1600790790376098452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vladimir Davydov <vdavydov.dev@gmail.com>

The patch makes shrink_slab() be called for root_mem_cgroup
in the same way as it's called for the rest of cgroups.
This simplifies the logic and improves the readability.

Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
ktkhai: Description written.
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2fbf3b476601..f1d23e2df988 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -661,9 +661,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-			continue;
-
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
@@ -693,6 +690,7 @@ void drop_slab_node(int nid)
 		struct mem_cgroup *memcg = NULL;
 
 		freed = 0;
+		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
 			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
@@ -2712,9 +2710,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
 			node_lru_pages += lru_pages;
 
-			if (memcg)
-				shrink_slab(sc->gfp_mask, pgdat->node_id,
-					    memcg, sc->priority);
+			shrink_slab(sc->gfp_mask, pgdat->node_id,
+				    memcg, sc->priority);
 
 			/* Record the group's reclaim efficiency */
 			vmpressure(sc->gfp_mask, memcg, false,
@@ -2738,10 +2735,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			}
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
-		if (global_reclaim(sc))
-			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
-				    sc->priority);
-
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
