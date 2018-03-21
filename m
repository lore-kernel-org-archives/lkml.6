Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtkCKjXQYMY//qh8XWnViiVbYyEHyYcaN2lOkSwAmngwQ56tetSxQIjOrzKJXDDJiZntYA7
ARC-Seal: i=1; a=rsa-sha256; t=1521638521; cv=none;
        d=google.com; s=arc-20160816;
        b=PGCw0Tti4Tj9S1saiVQAUus1P00Kdv4rQ5r+jxpKKrIqfGfH7D2a4IdQqUsoRm4vP5
         /6NUKybQ2TmgGfUiYDOHkKdgvVpHlOZND+39wAYkRNfvElpAQJusyaxRsWC/R4wbNb09
         NmFpnVTdwCWvpK+hRuRJxTyJxFp4cCQSPTI4gEm0oCdyJit4s/TTBF9Kvapp2b+CMmoy
         nJXj+js/9BZxGAT0LAHVLPnjI1kaTTU9Y0j9O720BrAsv6b8+FIOmVlgpQXdCEAtxZFz
         l90Fzm4qBdww/AoTjdxEchDv7lbSyRh4oxA337TN9mBE1e1fGF6GpXHNYMyopMaudubh
         ERWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=544OG9XUxC7qA8WOo+tg5JHxS6NSTTVeRWR3hE7haZU=;
        b=Tt4qlS56hl0tFxr2cc9W58w9cTp5odoXd+VgmPDZlR5ylTNmCKN7aQmJaJfQBxmPF5
         EPYqlLgh8+IqnzKIKOK4BWvhxyDxN9EifWB2+nARbeWESw2Ugm15h5HHDUZbXPE0c8O2
         0mY5aZSLAMTuVdBzdL6+qQGj0YTq193NHoNYUW2+GOKbePVb1p7wLrt81GGJAatCEp8f
         j3roVH0BHf8dzlE9e6kfsXnWRBLhp7ktlm1VM2oIpf3HxdDXp8aRK9hi2D0llNy2PVDz
         mFutHs5yWuwZca2YPQr5HTr3I6ZuQS9SRWMEKdOD8yefSZEq5gPWZTAunjzNiOSoeapH
         x8oA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aL9+hzJA;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.108 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aL9+hzJA;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.108 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH 04/10] fs: Propagate shrinker::id to list_lru
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
Date: Wed, 21 Mar 2018 16:21:51 +0300
Message-ID: <152163851112.21546.11559231484397320114.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::17) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 259d318f-4081-4602-99f8-08d58f2eb843
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:ugV7+Pbe+0jejHesTEdRBhqeq9uyeUYOGbf1UaoVtlMtmLeSCfksuoGExQad5YgNQ89HSx3k1lOrXg2gy5DUvy6HVBTF7YCGPVolCP6IerEhsmF6jx5UmZRcPF2QT79RD2Izz3igQ8s8aGo7EdOA4oMwMm9aFn6WC+57R3ai6+sXmscUOP0jlBsb7aTV/S0D2RE11Q0/vVGlioKyVZpfqBGytZe0izt78G8/W5rJ7PQdjPkpl3cVl3BfLsUf5L3R;25:ljhW1nW6OixYTgXGX6OFU7bviWVTVn7b3Ar/+g9Z7d9UDgN2WcF9OhO5QWztyHU2yTQNY9SPCliyRP3j6iC9xTW8rGxrzQmIK2Tf9DLfuTi9N4TcqRp9uAzUO/H/sVZKdoe1XvhLrROjW7pPGzqo9Ow7K/4t4r6ZhccW02Icxym8LPqVAzfE2HeY4Mef42Ws7X177zx/w7RcPF+dh7Rd9XtCfIbOyggmOONvVgI8AU6kd6mQ7Vid36Q5kifJXiAPUMd5iJk4kslqXfRC6gm5tNqctmxCZ/HXPFQXeNxR/lA8Ewiw1jSozhoDMzBvjP1YVNfdTotN0oGzSHqkzvSV0g==;31:+ofqPK2DruCYH9gcfh+XbGFOoCZpT9MLqsX3pjSxhHPMjClRlHvu1s+sqVaedWzwb3e5Y6t+SiAMHWkh2k577YLEjOtKUNntXX54ElN6P/aLy6Oa8IAV8BW5i277S2YZp+YNQ2/iGlTXJLakLI/Ey+0tV08PJi4EHl3McrtRIVAa/2r40X4u4na8CQwWJk9zcnFWEPg6+vuUy50RuIfvt1mI5x8jmqOd5gSG3X/wGo8=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:JayGzDDkszoX3OhgiH9Egy9hfD+qjEoj+ePgBibskQULYnakapWdmQpS6lF95eLucBMz2fCQ+rloid1xRbSwptGLHNu0Kdtns78Pd1KRRV7phkjJMfg5ais7kae8fq/iGYgAkuYrjFb6Dk4VOIKozZPpy+y9pVW76Tx7mUyOUTXWG6lGwANTZANMPxqozgm08KYC8TyTWd2gcG2Y1KmrhKgxPiY5CvGe6SsXbF+K8LokaRto66+3/GDuqDXL42pXnMNYVPn+RNGSk3j1/JdO6dYKM0A6rqFrxZP2pVxCd7a2xyLbrvyTMRiN+g76um1ADSDR7aXXA/8O6ppBhuITqTlhmTgMQZjAEcHIYNeYYQDccp3+fbR4Bams9RncMAISmtLtmnxNAhBsO7BkbL0uMnRd+c5PCm+gW4Cmrg10QU41qztkRNVbBE6NCtzI9EBsYA4pc4ORnrtlImIH8KSlixclo01qfRYfPHGzDQ4h1L0gRKzaJySje0TZxBQ4q77t;4:K7+sCyjqjRGP8Lle52+ake4V5ciSbaDlAFPtKHMYolJltBoblHTcTH51rxtFt6X38XhJtGxOesKzgmQ/2MnfOtHbzTJHCM5OGdyyR/sfvGwhMQN3dgBmx45RTBvN06/TiQu9MKpHxX21ajcHzNbGdG4g5MV1tMl0lBXyyvi/A3O19o+JBFiviryvl7u9HiavNu1dRv14SUZDUFDPFjv+eDKrVO7xTbVe2W1/bhY1pUfRNRqU6Q6w/JIc/hdSj56MlEV+yEBoSaa6YgjWZoId1Q==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13397F347EE28CB90A0E2B5ECDAA0@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501323)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(346002)(376002)(366004)(39850400004)(39380400002)(199004)(189003)(76176011)(7416002)(2950100002)(386003)(186003)(59450400001)(6666003)(2486003)(23676004)(58126008)(16526019)(55016002)(66066001)(9686003)(106356001)(47776003)(61506002)(6506007)(68736007)(26005)(33896004)(7696005)(52116002)(53936002)(6116002)(3846002)(103116003)(8936002)(97736004)(81166006)(81156014)(8676002)(25786009)(50466002)(55236004)(316002)(230700001)(478600001)(39060400002)(86362001)(2906002)(5660300001)(7736002)(305945005)(105586002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6ZTBtc0E2ZjNYZ2JOelRPMVA3YXRpRCtm?=
 =?utf-8?B?cFpYVEhDNm1jeWxhaUIrWFJ1QjEwZHNxQ0V6Umt4VHUxUjJnaGN2Z1pzSEdG?=
 =?utf-8?B?eE51V0dUQjBkNHJpZlM2S25jWUFzZHhOek1uZjgzN3IxYkpSVW42czdRcWcw?=
 =?utf-8?B?Wkk5c1lsNllsTFl6SkZ3dXl3bkRaZkU4Qkd6bHZzTXNhVnAxaytzQUZTT1hk?=
 =?utf-8?B?WFFKQ3BoSmdHUG1LRytJYVdPSTZxQzY2VDRrNndyYVUzMUdzMEllQUhWMzZn?=
 =?utf-8?B?TE9ISVY0MVFCM2JMWkc0N05jYUhhbFYvTmR3OW9FY1cvMGhMTWgrajgxcU4y?=
 =?utf-8?B?QzloMzhhNmZGZW9UU2lrUzhXelZlZmxCeWhKYnJHMldKMFNWaCsrc0Q2dExV?=
 =?utf-8?B?Rmw5SHhQZmo3VmdRajd1VDM2ZEZ3WGxJSDc0cit5KzhrQU5ZN3lxNHJ4WlBS?=
 =?utf-8?B?RHd3VnI1VDdwdmI3MzZMWE9MYlpZNXlCaEh4NyttenpydHduWEFneHFPeGUr?=
 =?utf-8?B?NE9PMkRLclZPU08xb3U0OUZIWSsyZXkyVTVqdFRSdjRLOU1rUFNrOUEyWVV5?=
 =?utf-8?B?QStDM3NEK3c2ZmhCWjliT0gvbUE3b2dOaFlxQzlCUnpYQkNuYmxsUG5kUWhQ?=
 =?utf-8?B?YTRKRUdzWjRacExhWmtXdktnWVFoMjEyS1krUTlYWndSd0QzK0xTWHdhWlo1?=
 =?utf-8?B?RnVkM2RDellrS2dqWm5TamdwMTNHVmFzWEFTV1dEUUZkUExvNUszb2N0NTVP?=
 =?utf-8?B?UWR3M1JjbHR3eWVKeUxnTk02a0wzdjE3U0V3bFNEa0dSaHUwNWs4OXlsVXZv?=
 =?utf-8?B?L0h0cmpPSVBpbWE0QWhVU3kyR3Z1SGlVajEwbDBUNnJCVHpCa0VRb3J0YnFl?=
 =?utf-8?B?Q0pMenRQNkRwaWRFeVg0cXcrQVVqTGJXYmNid2hobjl3TVNLVENsbGRaZ1hG?=
 =?utf-8?B?Wk1ndDhrUHNJQVA4WFBSeXloNVpRQzBKSUk5S1UvN0xyR0I5NkQwVHlpaEJS?=
 =?utf-8?B?MjVxUzh4NmxsOGxDVjlZcGkvdlBsM25PbERUbDRPR2FMVGFNTkpRRCtEUUxo?=
 =?utf-8?B?eUUzN3I3NG41cWNZWVRrY2ZJRXlWcXBBSENTdkNDZFdwK3BDVFJ4amRZUW9z?=
 =?utf-8?B?R0J3bVBrZCtUYTN6V29UZGxjRlE1T2laTXc2RFN1VTZZdUdqSUdLUm1Rb3Jt?=
 =?utf-8?B?L0FPVzZYMGVRams2WVdVUE9UTHgxZkNOaU5jM0pEY2VScVYzeWljc1cyS1BC?=
 =?utf-8?B?d2YwODNDRkhzOVhOUnMzVlVJWitvYVdYY3ZoNzNYeW5HYU1wMlN5ZHRHT3Z6?=
 =?utf-8?B?ais4cFZnendjNXFPRExuM0VITStGQzNxRGlEaHZ6MjZqUTRaWHFoVDdScW8r?=
 =?utf-8?B?aXBsNThRSVp4aXAxZ0RHK3NtSXhNMzZ3c215clozWEJwalV4amRzRnFNbGV5?=
 =?utf-8?B?dDAzZTRoTEFUbjVnbk9BMnY2c0dUNFlVOHI3SGdqT3BlTkZCUDlFL3NHS2Z3?=
 =?utf-8?B?aXRJSjNHK1lOOGlZdXZham9zYy9GcjBtbGVoQlBQYTBicTVrMzh5blp3bG9F?=
 =?utf-8?B?dXIzQXNNUWlyVHl2UFJKbFFLM0xqeDJYZlNpRDVKMXI2RVkxZWFqb2tYYWpy?=
 =?utf-8?B?eStmRTRNNnJoTmo3K1hsUkRocWQxM3B5bkVkMWZkUGthNGJjRzRWU3JZRVBG?=
 =?utf-8?Q?1z6mcN7whzpilJnM6UKG4DbK5lg+doB4r7fdPTHVa?=
X-Microsoft-Antispam-Message-Info: JggkVYVI31GMCiGX8UZuXAbAGOarTfHuZ8xWi7/jSixIHw4kojIoyylPe2K15uIlH0HY6oepL8c95WscSOKhuNly2UOgDrew7vXuYFpMarINTDIEO95AwN4630JFGj/rj0mX/2LQycMKQFzOasC2O5xnERfZQNwPj6WJ1+ITsp3D3jbXTVD050blS0G/PWN5
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:YTvHyYdN5l1REiC4XosYDHwskLYc1im54QB13eEx7mYXhmvsEhNc+XyOvlhSz+ILDMLaGNhiMqD1i2Z9foG/sarCayQR4cu1H927zzWIBSskpFLSupY4+Ito2aYr41GNP2dq2c8Zk+Kqg8opu0uM0ZnEFim69jFHyE9CiT21EtNykcg9BHqKYmq73/o1cIloos/4mg62b+pvM/WyWdasFDHKR1yDbN38pU+mBWkTwt5S+UYyVyZc6x6+3+dy52Upix9p1bgN61IfwlEXat1/AWrgAEMpTPXJWERnbhEYO6grdNlX8fHkBylcuTCgsc+4Bf6gCY8zqFg1nBpCza9bvviNX+2P31VaPLdPoMpCecA=;5:Djcp3cAP2QKTrXUSDeTb8w1RlKCVsrnKK8J6lestp5hJFBk2UxmzPctKmWcrX2+hcpUCrpBnFB5TEp+c5eiXEV4Vegn+WUEMww8pXaWlKUan2EJaXMOPQQoPJfS5rGXRtUmJj3ttPya3b25lwo3mA5QhcsLTkrPN42fSZOxxNKw=;24:BG+E+TVktMFcjLL/QEm+z05mgjSEPwAZqGWndqbaJUoEeT0GxcIkkKJAMlWJh8bqEtVR5qZpr62bIvgPNqFU11I/qwnZprgL1L2Q0Fin/w4=;7:e4SfrCodveWt32ucHLIAj59HxHaeXekuQoVbkEbZjt+dRCL6pOpAIz3j4y5qabNxvjgJgJqk7+gLClIcd9WQer+KMYu1oimLbrKIZTZgACLL2fE1rYA40/uJEH2Qez0tE8/JRekTiSSYrre9YBe6XEHUx2zQvySIA6RJrOjSLDXboLqHvGjF0dA2+9AE680kUtnObP0Smxu4sA6jR26gFED0xlpilpB2yeSOY/Tus5IiwRAPNngt32jyLWupnX1C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:/UckeahzE51ALehDxtSAt4ztybFVy8242eLpngHshRg9oXs/tAe7PF/ZCmQKT5hstxIlEBeQrXd8uBP5C7rL7pbOucB3SLt23GXbacgszElCiUx2HMBS5CtcGdj4rlP0+KPNtXar/bitWMQgjcoQFHCPhSUR+9HA1AHvVbChSHQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:21:54.4404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259d318f-4081-4602-99f8-08d58f2eb843
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553635124492604?=
X-GMAIL-MSGID: =?utf-8?q?1595553635124492604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch adds list_lru::shrk_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    5 +++++
 include/linux/list_lru.h |    1 +
 mm/list_lru.c            |    7 ++++++-
 mm/workingset.c          |    3 +++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 0660083427fa..1f3dc4eab409 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -521,6 +521,11 @@ struct super_block *sget_userns(struct file_system_type *type,
 	if (err) {
 		deactivate_locked_super(s);
 		s = ERR_PTR(err);
+	} else {
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+		s->s_dentry_lru.shrk_id = s->s_shrink.id;
+		s->s_inode_lru.shrk_id = s->s_shrink.id;
+#endif
 	}
 	return s;
 }
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 96def9d15b1b..ce1d010cd3fa 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,6 +53,7 @@ struct list_lru {
 	struct list_lru_node	*node;
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 	struct list_head	list;
+	int			shrk_id;
 #endif
 };
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index d9c84c5bda1d..013bf04a9eb9 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -567,6 +567,9 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrk_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -608,7 +611,9 @@ void list_lru_destroy(struct list_lru *lru)
 	memcg_destroy_list_lru(lru);
 	kfree(lru->node);
 	lru->node = NULL;
-
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrk_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index b7d616a3bbbe..62c9eb000c4f 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -534,6 +534,9 @@ static int __init workingset_init(void)
 	ret = register_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	shadow_nodes.shrk_id = workingset_shadow_shrinker.id;
+#endif
 	return 0;
 err_list_lru:
 	list_lru_destroy(&shadow_nodes);
