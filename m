Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZp77jn+zgJE8Zz6eYZX4mMps+fbTJYVdteT4xpQ+dMLDGGfoHIGnqZqujUFDCjtCv1jYYuU
ARC-Seal: i=1; a=rsa-sha256; t=1526633037; cv=none;
        d=google.com; s=arc-20160816;
        b=BATo+wIZrqUiXv2gHgALEBsKyHQ12g18ZEfEe4RFpkK3nqB6oiEHOaqBnhosigv8si
         T2nckKoEHXhjjqx1vc0aGSXvzu6LRBKnKObDuw0k7VLwgXammFXDVx6USAzHHZiJM3rS
         h7vFQfBkudaJoAFLxnC79fqAn2vJDuea/xn+0rQYpw/CphzO8vT9SggMBBakQRhf/ad6
         3NQ9WfHTbc/im0DbuQfGh7traiJJF2y7kSepElGzaHyNmuzoRnLzQklnr+SeA6PV0bVF
         4MmP3EMAoDHhrIw8asIHo8Q+0Mq3JvfiS0XC2IsXJxKilmeUsxatyJoeAMPpwg/jT7GW
         Rv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=uxM+MuKsncHLvMgjLIDaE3C6FBknMx7nO0q2o3vjlYc=;
        b=yf5BXDbA7w6/9h5oOPA7WOglAbq2qEe5XMxqtETYHJb4YcHI6nBemcNNp7bDg0WJ5y
         7CKKYe7TZW8wmScxiDce77logwdMPP9LX9Nx7TQuwpIfWuszUUsKLuUZyFdrSMnGHFbT
         nN9awQVkc7lbPZTNHd+QUh3cZJ2vXVGW/5Hh5G0r+xndGMuSQvbIFmdc1RS9u1IQtl0n
         acFXL/LmrZhWb5kJRcTunB2aTlv1RWyJC3T1wEmTyJ3P18jYjkX+g4H2AkZT4mdiCLn9
         oj6lmtWSLZtLeR8veQWySWm8mEIquAoIZ8U51AXhINF9ISJ+8BPK4KFINr5VQ6jK13Lm
         jnLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HRyv12PY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HRyv12PY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v6 13/17] mm: Export mem_cgroup_is_root()
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
Date: Fri, 18 May 2018 11:43:53 +0300
Message-ID: <152663303322.5308.13190345531934617119.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0023.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::33) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:bkqhaNYQRN+Lmo8YpwBHT6D3mjwg16yF2egGKbfBwZY/9tfNZvvumtua0ep8xWYFBNd8GnMNSYYEfy9RfiPY1A5B07rSgBZvOAokLdv8nMiQBjJfg5GuKHWHtVxPeTswOmS/QgsA9ELH6r4EmY6tjkRzhSOUo17+b422NzaG9mfi3KFf4QPlFWYOQPN0bvMZ7PffGzXFViHuAmLVvBj1cueDF3fWvoJ5AUuUbBZpXsCzrf3ufSQ07h1n2FEtwfVs;25:qKYyyTtT76zPwcrP2ngJHxGM7HDsjxx1fJlxuKzUV1XqjqFpFqTP6jTsj9x9MPYTYmyjZAUT4HHozWrrQLOrpm69TlzKHU67rw68+NdPqN8lPIIG0x7cyRHR5YelVgdPghvxLUl8q1vGb+5YJUVinlkP7f6pquTmcyA4gixhMez9ogVeCJvOFZqDYjlbhAx+Awz65gvyOh2z/jaZX0/zuUR2HHW9LrxUo2uOuzPBdN9uXtuZcJUPGfzM0Lgl3T42oDIm/Ij0QDOSPk/FwqBBg+/7aipM/ufXmx2IL/rh616/6K4BS4IbUgvdlO3rZg7ZSkM64bnBmO3fFskcxDHL7w==;31:zN1ZGJ9iXKucCosoAzKIIq67aaQL3VsXYbAf6ACv9wW0CyyZKXdci0D9mI+g7Eo4Cn4Fa00J98y/QlXoVHZcOZlGsZBTBcwU8g4icozA2igRqkquKqWO0GT1ZdVpDdiVTS0A/mbRU9mKcqLg1ZUCm6Sw1D9p/FgcN/vUDrOXA32KnF7MC197Qr1jqSlR/Kol8o3g/9KSEQHSrH4n1C8HQsev3JZRAxNNTd9MMQoxFJY=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:h0UvoQV5dAEeZ5l3gqhZxjFZk9jljx8azMcY0x8fAG0H+Il1345eTJ2EzrcyfkwYfVAdqtPOMkHK/qPd8v/UXNOAcncNx9q5fMU2PpUd7MKP2+GcL/P/RMYXBOxY1T75tywfCvzgUV4x/4MFShPz29Ldnr4NKEk3BnpKh2hP/yL+fF3C6IsHzy7cvMDDqLEbM61xjGNinzFpQt4LbUyLu0vbAtdguvtuLg3J6K/yN8Ec+6ctJQDhDZlewZIsGDmf1Yu4sqXwOoi5id6hJPEQLVwmZ8tgPFn/ylAFyb1P/q7ynXbh0o7mYl2Qx1KkuSgKCuzDo9BASj+ohvOiv3nmbT0KYAgSZQ4+WJgsGuifbwhjpsF+zE1UTrrQK3a1sN/Um9kMifhWKMgvGOvWuZ3qQuHBXqVgm6aRvUB0c3W2jJU0253hhTz6ghUERjln2FDLGtgDxjnj8ChL5M3ZACq1rLzKn1J9X2KgBQQD7do20kdwcxBkTtc5Sv6iXMdpuZw7;4:tTECdSkztBIPOpKZlNf0kybWtNMXmAApyafO3I0NvsTWLKA6BiRwzS1xkAW3SxjnXeOec7YsDyvI8uoFnwwzNmuKJIXYjhcqDqpxTwbQ8PT877L6lLEFZ8EeBs0OtZgL9EffM5pIJwVUz6HqgG6JR3VGZzkfBcAD8/khvdOxWTFzKwb4hhtdYiS918BCh0NdUfQNdbqJT77IGZEzYHKAq8rp71IZvc/UeileUJQ/tjb1DWoyzxLRLMhgULGHJQ3ANcbOQ5szkYcvzcoO7Y8Itw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13390D5C9979104FECEA3038CD900@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(39850400004)(396003)(39380400002)(189003)(199004)(230700001)(97736004)(386003)(6636002)(6506007)(316002)(58126008)(16526019)(103116003)(7416002)(5660300001)(186003)(105586002)(106356001)(52116002)(7696005)(2906002)(55236004)(8676002)(81166006)(81156014)(68736007)(47776003)(575784001)(53936002)(8936002)(86362001)(76176011)(59450400001)(39060400002)(25786009)(23676004)(33896004)(7736002)(26005)(478600001)(66066001)(2486003)(956004)(446003)(476003)(50466002)(486006)(55016002)(305945005)(61506002)(3846002)(6116002)(9686003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6NXNSZlNEcmY5SUpvbG5TR3dzWXFCS1R4?=
 =?utf-8?B?dDB5ZnlOUUttcHNpa3A0V1dCLzBLdkJOUkQ0MktDT25rSGgveGIwdTAyR3I1?=
 =?utf-8?B?OFRpalU1bnl2eG5ka2x0aUFPdWlOWVpOeG9UUXJjUktvL1V3ekVla2FQZUF2?=
 =?utf-8?B?UCtJck9aaG1uemRjZ05qcDFMOWlyNHJ2SHhDVHkvemxIY3NUMXFJQzF3TVpq?=
 =?utf-8?B?S1hrYytSVEVCOExPSmdEcXNSaWtiRUprRmp0dy93RDhKbUJ6V21na2pSZG9t?=
 =?utf-8?B?NXFLL1NaYXhrbTQ5UXdOOURNcER6ajBrdVhXVEI0TXpEVjU2RGZqUXhnZDZN?=
 =?utf-8?B?Z1plbG5lOXNOdEhvODdWZVJMdTZJaEhJdjBGaWlZeDNuYTZzbWdSWFlnWWs0?=
 =?utf-8?B?QnQvcHNUV3R4VWJOMm9wTmNTbDZZWHA1eG80Y0hOQTFYcUpTU29Vd3F0eG9i?=
 =?utf-8?B?S0tLTWhBQWNGL3ZDU0F1cy9MZWtNWk1YYnAvVktaeTRUZXNZK29lYnBGRUZx?=
 =?utf-8?B?TnNlOWNJbTlueUhQWjZsTU40b1RNblFqTDhrVnI2SXo4TGtQSWdZekJBRVlJ?=
 =?utf-8?B?RFEwQm40emtjRS8yb1VlSVRTaTB2U0ZJeEhCZis5a1lzV0ZnbVVzdFJhbWF5?=
 =?utf-8?B?ald6QUtMMEdFenVTV05hNC9XektxdUxya3I5dWYySHNPQ2lTMDExM3F0VXNz?=
 =?utf-8?B?Z3BUUk9ZaE5ZdW5oTXp4OHRQaU9hanY0WlU5OHQ3K0N1OUF4bVd3MS9pdHdm?=
 =?utf-8?B?aGJwMnNWdFBrWTRWWVNUNm1wWGVvWjFCQWl6YkNEYnJpTzZNTDJLUmxZZVIx?=
 =?utf-8?B?TVNya1BxNmdNMXovTHpzYUNKUGdpOW11VVBqQmhIMW1DNTFjRkdXQjlad0JD?=
 =?utf-8?B?VDhXcGhHUnZTZmQyQjJiK01DOWp5MEhPQU5za1JacklrUjBJLzFsY2ZQVDV4?=
 =?utf-8?B?Wk1BR0gwWDhjeTZzRCtBQmxWY2NvRjQrUkZvelBPUkNteVczVWwxVEUrZWpr?=
 =?utf-8?B?WitJeEJMVU8vR2xHRXlzdnZrR1A5YlBjR3d5dTgwNjM4VEFtTGZCVmxJU0Nr?=
 =?utf-8?B?ekhadkVYZzZwR3B5RzJadm1FY0o1VTIvWTZkbjJMeStXMTgvaDdOVkg1dnN2?=
 =?utf-8?B?S0hSMm16anBPS1Y5UGh2RTBmK1VZRHF3d1VKUlh0OEJtTG14K3l1MWJKVlRT?=
 =?utf-8?B?V1NIeldvUWFvbFJpWUQwWWgxZWczNitsMDZSYUZFbk9yMFJudUo5QXhuM1pu?=
 =?utf-8?B?OU9XZXJOSVlaL2IyZzlEalgyVzVZdTBFRnRYR3ZPbnBkUk1BYkhvcEZDSmdq?=
 =?utf-8?B?eHF3WHJPTk1iTW5oZTQ1SkNZcFMyUjl1R0w3QlRjNVFjWVdBUHBJOHNoYnQv?=
 =?utf-8?B?VHRYTmRHN2lmdjZpZ3pOY0NpYTdzN2xaSkNZeTRwaGJwM0puVXJwWnh2WHdy?=
 =?utf-8?B?dXJsNzcwTWhlTGlnVkVmVGJudENrTGgwK2JuK01JQmV2Q0ZBYTBJU2xQWWtH?=
 =?utf-8?B?ZWhEa0JLVzZLUFR0VHd0NllYMmt2cmRhSWtISmR3UFhpVWIycnlJeGtEdFZj?=
 =?utf-8?B?K3N6bmtjZlJsaVpQZTg0amo5VnF4OS81VkMxMzZDd3JESERSK0ZOTGpsd0Vh?=
 =?utf-8?B?WGg3eVRqL2dSdEtsdmRlNGdiWVA3KytYWUFSNjk0SWVpRWcxMy9VTnNFemJk?=
 =?utf-8?B?SC8rMDVlb2Q2bkNTWkN6NVVmeHNUNFZ1T0o1VEE1NXRmRjkwNTRxa0pNN2lq?=
 =?utf-8?B?ZEo0QXdibUo0WUltYnBHVlNBeDlDV1lwUHRubGVkdXd3UENnT0xDdkM1bEZa?=
 =?utf-8?B?Yk9PVEdVbDd4Nmt1TS9nVVdSVTZLejdXSUVRbmRQYWwyRDk1QT09?=
X-Microsoft-Antispam-Message-Info: /XfvuF4RQEG1XcAvQEFGFg0taTGSG+kSPUjsSoIwvy3b32vEVfgPsic6hdT8xmNQPm5/Tys40sfdaRz7GKXkxPN9QApIOpMf4myANmr8pjhAZfiRqE3IU4ZL8kp9zrn0jEG2iz+GQrChiTcdBhYi9Vv/tdIexZTLN5YTw58PxbzUG/dxr5PXJ/CQH+kCziLg
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:nkNt07XMxFcoxOfLi9zsKYG2XdcueVBDtvrEuevYQ5kNkfaIitBxfj6L+MBe7Es24cgzv914u5I/5Q5LMW8iHErYA4UpsJfsptn6O+atICgA3fhppA6RcUoikPOZvc0i7Xx6ABc4mfJx+4H+MNtLBW2UMBwKIEb9aukDiq3nKJKzYZ6k6j7t9xrCTnROGF2EhvzFYILEWdwAw+R6PCyLilprhlEFrQgDmSK6pjM9mUIwWzERISc+gsrNDcGywVfNeL6HzoplPEMY1UlbjWZa2NgDA07mabU7XXQKqTxUB4bcDU9DjFr9xi122/z+JsiMvttkeHMzD95lmz0Lq7aJPaODUVoyZ1Yg3isRCGi8HmDLFWbyaJmK5RrHNby9GEMwja3i3HacBnwhWUX2qXUngELE7wYsHy6Elg52aPzYCi8ra1f99wg+oFR3HGZuens1gRFmBpDxIHduML1nHbopDw==;5:ofIyU+RBGoWtzDeBzCwcPylI6CjlfWoc2d1Ps695GqkCOJidu8BCCz+Pbw8Ty2REox9PVVdPvrO/jGVSBZygWFteUTOQSW4HaHttt23w86GvuiX/7aJDO2yrQ9HSqotdcOtAbWumzzEROeoHza7f6SWhnUlfYPxhbO+TeAd6fEs=;24:LlaganAsmYO36FKJdOvLTNx9n+MtE21OR9f5tA27pUoN4DIpMtgMNeEmQQm/diDg7fZs/406ukq3WREkh3jOBR8NdtSFpiAk6XLRcjmDZrg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:XJ9jJCCTUZ7X6JuoT475JV0L/n+ilLg4GQPcqVDSlWnwhIhmU21Y/eqVp7wbZDA/q8t5nCTkvm/HEGkZoQlX0veoiCgfvLKV762Vn+7lTyRjXzIclRWrMNjaogE9CFBY91FFJU346qL684iFEsoOMvYmX83JSXD6BKG+cCxk6jZ+4iILlfKpdAnEcGnuRVUQeJarrUSoN/YbGGF2sF0lRUNmLSlpxAjzVuu2XT8uP3BksO4/bvbT2MaL1GWX1sEV;20:anKdVEqXqxlVBPr9yQ7t1FbA026ziv+8OP8CC7QO6bDyw0zoQNUWyzyCKhMbiJAc/PKfj/MZalvHL91By/Mn4/witL7o7nYUXrCIob7QZ/QYwP/e87LKKJKvqVDf/CO6fdbh9B42uksR/xifFfMZVKh3fZXCdYxErlB5LuNZWWM=
X-MS-Office365-Filtering-Correlation-Id: 8b4e9ada-99b7-4d6c-8558-08d5bc9b7ddc
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:43:55.1912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4e9ada-99b7-4d6c-8558-08d5bc9b7ddc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790764385859486?=
X-GMAIL-MSGID: =?utf-8?q?1600790764385859486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will be used in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   10 ++++++++++
 mm/memcontrol.c            |    5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7ae1b94becf3..cd44c1fac22b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -311,6 +311,11 @@ struct mem_cgroup {
 
 extern struct mem_cgroup *root_mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return (memcg == root_mem_cgroup);
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
@@ -780,6 +785,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 
 struct mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8afabac77b86..bbcb3d2c0a50 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,11 +261,6 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
-static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
-{
-	return (memcg == root_mem_cgroup);
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
