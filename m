Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx490TPV7cCioiTAbdoTa4b2vBpzgH7RqXnTzwkMc4DKyhb2WAzExYhJJhQMSvj/gp+qDzUPC
ARC-Seal: i=1; a=rsa-sha256; t=1524571988; cv=none;
        d=google.com; s=arc-20160816;
        b=bMg1AzJvmaHzD43b+3Z0Dtbp0w/U4QD2sQ5JlmMzjxIJL7eNiOWFAyE/IbcCBzw1LX
         hN+dK616bRQXkveYFef8oMPKSO+chsoGyyjAkGYrWg9Gp8T+LLTrTnfo2SAuUMgpRQ0o
         zpKAGvjY4pDUyTvOj3j9/oU5277SkO4CgiyWpDNaxnVVgoWrxxe/BJStl9wTysfwdwx3
         xQE7ZxcrkQ/N++mBq1qESPKWKAbsxOC3rfKkuEsjSQo5O+foEXLkLV9iU/TWSNta5D1Y
         w/BUSL9wj7vBATSNDLxzug1m021hupYN5gC7/nbozPIi4t2Q/BkEfRHfOCigCEy3woOU
         kxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=V/kvH+irehEmPuj2/nwW3XE9Z85uAHg2skL11L+/yTw=;
        b=AOrqf9P2YTBFawwL1YVhsJAc/kfLE7UeApOb5Zhg567zoiz0IEfRpSP5eU6cChSF9X
         claYDEDu2VyO5T+x58Kknuv1m/frJ7X5fyCovtqnMu6I5nsM++TBgT8uaAGW9F7N715n
         DOWTEs/5bsAv6nhsn3Hh86XaawpbyHedu81tRkoD9qNc4JgqyBqYsFB4Zo8JISTHoM9A
         aqDXcPDib/7qpWkWcraM7BFQIHT3tftVQ4k9p+v3ZnQMXhpob7zyNw7nibvwMhD/47iJ
         +nYJcd0Tyzd+vwhAQfoxgFnr+LOyQRnRypbpkUvh3cibYyjJ6rm4rfvztvEhL6jqfbpO
         e45w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=a8R29k9M;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.129 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=a8R29k9M;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.129 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 06/14] fs: Refactoring in alloc_super()
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
Date: Tue, 24 Apr 2018 15:13:01 +0300
Message-ID: <152457198169.22533.5463813231801094118.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::11)
 To AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:4gk8ZvVApxE5XMlomevYEc4cgTHshkBPeGtwivzQ/V3WHzVpDzGTvlVqvenqNJNprrZ65QqjbewCyU2GgkH3bdXaMLB4IuahsiMKPmfD30bi4IHr9TI7oAz9VQ54BVj0cBIHUiBoY/EgQfOYa9ASn6nVjEB8KtBwv9dILhtjtDbD5lviOIi5itXPEY6aYj5F0lqiYyxLhW4Fs+SpK+ulhlc5kd8v3z/II+uWy9It07eZSpBghp+wjV6muVaBySb/;25:c7+gi0gZB77hGigUi956LrC8ab8pIrA9fu8angfbOrwjr1n+Qp8e2DM8ft2FYzQfV14nfT1r1V3UlvNVlaeqLng05BMwl/nZsGxW2iDbPeprx+HrwEKaYDjd0rvpICUlbjTLlscvJ2+VC+1eXY14kr/Va+5lJoXCCqGRicN/IRRrFAfPP0Rw6Z6AJYzGvC78cJR9PAaMEF7jKNMwRmM1CJVWxBAjkBZ0gNJ6JwcpM2SUIPKJ6shATtwTZRbkTpWagclhpZWgvklH/NDFLdhluSOq04tAa0j2AIQTEXxE7U9QK7Whds5t6GvmU5o3L/4aDwBU1fPF0FSqS6NjapDLxQ==;31:0BRscvZiSHNSfvRcL5Hh6rY8WcpxI0gGSbbm8M6aIzuFnSjKP+jCDn5V+F+lRlTYF3V417EtIRy8N+sL4/yntEfYdyjPgoPo6RAPracbkUs4c527gktFM1SlKPUlm7k7SqVMS1vPZwf5eubu1ypl5F/kGMpyy1IUranROzQHkFoOxTkBxgQ3S70AwQcbymwPoqmaEdyEaj9O/m9u7UdzgeTJGDYx/b7DISRN05C1bCw=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:CAf3vhuiKsHJbixN9Mb6UAL30Sup2zwMkML1b6YVoIw2coBEJDycXTg2Rg3J7UyKIIrhBlVaVnboMQut6Gjv6kCnKXGuDdaZcZSQ7sYni9Q4wynP+XIH66sqQfbABkWHUoRktV8YgLt5NvS6uC7pmk29v91tIIhYSzF8CfyTP8IGToRDTm9vF5YKmWaeJQJWddl5gFGszcB7SayXcqmDRNKEPjIelROUcPOAhd2wUXr0oQtDgYT9wjP7NWXvpDoqimliMaH5Q9rA/y8O0C8JjgW52+hdiX62FAicm5TMLMd17jrFyWL7/Asqn6q5IEBg2DRWirKT7TVO67Tfr/TPGkXUw4UwPfv2W8XZPZN2aEtH4oL+pn/GtF8dDaxrnRpx9fZFiaeZWtpZ8VMb6+6bPFc+n+XUo5S5X9PbwcAUxnkiEOGeQYwNImRTPERopE+bJzD5cRmQalqNgY07AyAkE25yK7cX64Z+mf3iHP2O9cC6nM9fQTDqz44w9e8kV/Lv;4:9+WSUB9mocAaV9SDAvz+g6aUoyw36oqTwqhxGiVUEMGDupFl1qTdSzIyN9sEaci/CsnYkcOyTsatE31LgDsO///Ap61dTbm609uZHvpoALM2Elawfhqj9egRCqq5xzGvZW7vEc/0CibqFJaRLpIlgsvtQb546h0KYzXnPq9BcaXaaUZqILCo7d/HR7u/RlMG4e4Vm+AEH/X4zBAnQ495U/1Zkxigu9CXBXTPzyNOIV91wgdeDBEjPUxE49eYKjlDVEB2Q1ArSk474M+yd8YGcQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329EED6D507B1B867AADA95CD880@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(396003)(39850400004)(39380400002)(376002)(346002)(366004)(189003)(199004)(97736004)(66066001)(58126008)(316002)(103116003)(47776003)(5660300001)(6636002)(486006)(26005)(106356001)(446003)(956004)(11346002)(61506002)(476003)(305945005)(33896004)(68736007)(9686003)(25786009)(23676004)(2486003)(16526019)(81156014)(81166006)(52116002)(105586002)(7416002)(86362001)(186003)(2906002)(7736002)(53936002)(7696005)(39060400002)(8676002)(76176011)(55016002)(50466002)(230700001)(386003)(55236004)(478600001)(6116002)(8936002)(59450400001)(3846002)(6506007)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6ZFR3UGQ5SEdWOXcyeTJrWjA3dFNkdU01?=
 =?utf-8?B?NzFBRFBBZVFYZC83UFh2ZHczcUpYdGhudnR6RlI3T1RLbmRPeVBiS3ZuU1ps?=
 =?utf-8?B?KzRnTkpyeS9JSExUeEFLSS9HQ2lGRFIvUzBQdFJwQXJndUQwMFpsTkR5ZEgv?=
 =?utf-8?B?L1c0Z3FTYjVPK2dDVmpxRlVSYnVqQVNFZVR5QUZIY1o3azlPVXVUL2hGa2l3?=
 =?utf-8?B?VjBUSCsyMFp6ci93M0tmNHdISUxtSkV5eGNzRXZCN0VRd2VlZUgwSEw3RkhC?=
 =?utf-8?B?NkVqK0hEZWVWTllDRXVOV051aUhjWmRQTUFiWDc4Sk9FVXdOdFZzZG40S1Ju?=
 =?utf-8?B?dzJrU3dBM3VvMDMvbVI3SVVwU1cyc2tTMGdXSlY5aEo5bnpuUERvUkkxcXMw?=
 =?utf-8?B?TmZRM3FQWmRZa3RDWGpqSFFMem9pTm9SQW9xSWlhUndKNlJ4UTFYWjJFOWhE?=
 =?utf-8?B?MnRPSXkwS24xbFY2dTVIdzhrbE4yaUUwaXp6RGtucXVFUUZPK3lxL0JrRFFq?=
 =?utf-8?B?cTdRWEx3QkpyU01JQnZZeXY2K3J6U2J3M1J1ZnpwUmlTQTR5ZXUzR2ZXMVJJ?=
 =?utf-8?B?MnRJSnpjcW5SbUJieGwyNGl4QmlTN2hMVEI3bENIN25ZVkJxRk16ck5valI4?=
 =?utf-8?B?YXpmd0F6WkxhckRuRFc3K0VZRnUvZjhMMWNGb1N5dzQxYUI5Lzh2TGlNQ2R4?=
 =?utf-8?B?aW9UT2xBVitGWVVZandNajEyU3FnSmgzZ2VzZjh4RTJCRmg3YXd5Slc1TXBi?=
 =?utf-8?B?cTNhZXMrNllhakZFTjI5Z3l0NHlvUXJjUDJORUp4Y1I4Mis4c0FQb3FKdUtT?=
 =?utf-8?B?WnZYanVXdGNONWNJQllMQURvWkNUbFd3Z0RXWFczQVlmVkhFRUd3TWJZWmVD?=
 =?utf-8?B?eVRuQWVLbm5xcDB1MjRkM0pVajRNK0crYmRqUURPTUFJdzJmRmc3dzZ2dVFJ?=
 =?utf-8?B?WmpVWmlqeThJYnhRMVhKU2t0Z05Hc2Q1dms0YTlSdkpjd2g4TEZxa1dqMjhJ?=
 =?utf-8?B?bStPb1g3OU1TaDBvL1o2Zm14NXU1OUtISGNyNFdMekhnY1kvcVRBQlh4YU01?=
 =?utf-8?B?NE9RaFhZTm90ZktuRGhKOXVFd1E2ekNKeHRNVk1KOXZhQ2FZUThWY0EyeWgv?=
 =?utf-8?B?UVFMUHRFSTAvRDlHa1JFU2RMS3RiOWhPZUI5T1F6WmI4WXVDeUZZRmsyUWR6?=
 =?utf-8?B?eVhmdk1Jd0VicXV2KzNSbUN4MnROZGk0RkFRaE1xTHJ4UFhJMnRoUGUwdmxC?=
 =?utf-8?B?YXRBWkR6Wldxa21IRndWcTFtUGM5MGxhS0RnRWQ0S0U0NnNhV0R0cloxZ2d0?=
 =?utf-8?B?UTExaUU5TWhXTXQrdkE4WUo3UFAxNHV1VkpzYUc1RFBBWVQ5eDgxT1l6cUlm?=
 =?utf-8?B?bTNjL2tPTjk0VWw3SUtacWgzMVdjVjZNTW5HSE1ORzBoQ20wdllNVThoUUhZ?=
 =?utf-8?B?c2p0U2ZRYTlmQVFqdlFydXZGUDF4RElOa0w1K2xJbkF2K0FURC9VWXpXbDZB?=
 =?utf-8?B?eDVqUmFVOXNJcml1Wk1FVEdvZTVtZFh2RjVHei9WSlhUUzVSUDZlSmZaMVJG?=
 =?utf-8?B?aWlmb3lWS09zY1hZcHUrVWduNEdLeWloWXBDVFlXREJHcU5sdXJFNHFTWVAr?=
 =?utf-8?B?RHRkTnBlK0UrYUNQS3ZxK0lZNzlsdUI4bEJYVjZIWGVKQnVGMlUrOW1OT3F5?=
 =?utf-8?B?UEFYRFR0aGVFYlIySE82NTBBUFlRa0E2TWpUZGdNcjFyUTNFMnp6cDNjOGhl?=
 =?utf-8?B?NXNmMzE5WDM2KzR5dVB2NU1nU3NOTVpQZGN1MzFzRUk5bENXbXZYZDcrSjdt?=
 =?utf-8?B?U29QRVg0MnNzSHRFYWpRSE1oWmlrU21acXNQSlhrMWwyZE5GcitoTXpBRkwv?=
 =?utf-8?B?SG1ndk9yTVNYUjhTdzdyVUxSS1FHR3Y3NVVsRHlXd3M0MEJYVy8vMDdmdFcv?=
 =?utf-8?B?OGozeVhuTFBnTEE9PQ==?=
X-Microsoft-Antispam-Message-Info: Gc0v0GeNQv4sB4Y6CZTp8KQP7s/vcEFwn/myKgB9pGHUJ6rPcSF5yjE8eH+uaqmp+5laLA1mhuIP9rfyBDsAbTf+u9EhTC4VdlUFvdzRI4H3DTGv3BDOqMtDfzftmPazYl+8ipQJiS+8slyTE49sHRmy3AUbK6UB49YORmZWcY5xl9U9vzt/M8STh91PuiwJ
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:orA3bKe4mK05im7uTJksCxVnK0J1XAOMRP6ldMUFbD3/Sh5apHa7HlDw+ks6xlvQLC5GXfvwe4mEJCsXq2q1SQmvCbxJGYUgfJ2hC6BF2Dy/YJZ9SkE/OfBUNVfywBCX2bBLmG6+wPJwwVFm5bRUCAcZeDdbMF39mCGiYPtdDa+vzv2M4y1vEz3u29srpkRjwYVcLeejiUPnj5IOy/XBaUP6z7OQ4JoU9+LUASogJ0R79wRQHAQisaG8ev+rOtu8vUwqj8WfyS0ILK3pq5Yr1emIOAWi/p3Aqb4OyDiD3mAKIQzOg2tG7d9ZCkhLYndaKwpeoiYKrfc2sDDFmv8DAwl4yyDSXuABIV5BHq8BjA1j9vaieF9bQWQ75dmo6nEhTpZJWZ4havEhG7QRhy8gYcLrzz39KY6k2MQmFu8CszAhxRNdU3f4h7Va7cLfjmOJmeexbgZEEAw5ZzqhYvtDFA==;5:holJfaAj9pdUKKutLLbU41MRZ3DDpdm8AydjIAfsQKSSoxFtugxVIWARbJDrUoV7nZ2ZLBlx9AF2ZBjRZi8VDzfVs+wxjsPUWvEaeZYaN56+oWcxHK/GOaYOcJpRstWxU4cH+TF8OVSA4u/1E69Ju6tF4wNjN2+hyeGWJnAr3UM=;24:lHx1Id4I+FpmKt4aPxgEAQHFDQ48BlEuwfxypEV2DEmjwSjOVlrzW7d2BizA3XowaxcjsccztaC+18CrOx6IE8E5EP53AUCopHLA4s+4KZk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:odPGPZYqIWeJpsYhbWmUtfKewLEwX3DY4LRgbi7/OoYvvFTJRVW032pESmAE40RVNDmZUyzfIO3mQWH1l7r4SpDHrI8Dl0vfnMPOimFf9yFJdkGLclyi2ksKoqyvgQGKeZKBJACPmdHBIZKlikORmjzDcbSYMIxE7MMQ71cHcgtQlWQ0kinWSRVyeAErPg8N1vPINcFkhaILr+ybZSKLBKnbgifcAZ1F+S/KC839VplCYgIPjsLX4I2fSDO5KRF6;20:Qejm4limEpjdU5hBXC67A9+g19yApKj4+yHegqOG/b3RSiGEq2627Ff4aX7NgYcrCIAkojsBPmmrT/2P1OuT5/n7MZZLLPnWelVXgmAEgqx+qgK5j3BrHC+bOBHEfHEiwqqB/TtZcOAMhI3GV49J453HBLZ8/5D9MGoZwUwuU+M=
X-MS-Office365-Filtering-Correlation-Id: fe191e12-ab5f-4659-9fe8-08d5a9dcbc10
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:13:03.9335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe191e12-ab5f-4659-9fe8-08d5a9dcbc10
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629597864849534?=
X-GMAIL-MSGID: =?utf-8?q?1598629597864849534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Do two list_lru_init_memcg() calls after prealloc_super().
destroy_unused_super() in fail path is OK with this.
Next patch needs such the order.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 036a5522f9d0..d95fa174edab 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -234,10 +234,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -258,6 +254,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:
