Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+8vXjGypJfyNl7O2tl+xwSWLr0QFqDNDEUVJiUKQwGlXwadpeQd8DWi2k8b6co3BKlQKjR
ARC-Seal: i=1; a=rsa-sha256; t=1523980463; cv=none;
        d=google.com; s=arc-20160816;
        b=Y02sHfXI7FsQAO1Zd9pkXfBvYwOZyVmrANKWC4lwSu9ZC21n2UXxam+5F5eDtvvc5I
         H1L2iDquymrFyupeCosLRMhyRkDFSIL1C/9oSOerwC+LUdvydEB7hoF5yJBlzq+oU9c7
         iEmtgyEz/21HKmz4QbZIA0nYNwJRtORS7dioHHQVXH1wAX+aeRWt40kNF/2KH8nhs7gP
         +mJZ0PqFWuIfDNNo3UrC6owafQeaYzD1cmhcCFVzs0GGRdARPQt4C/LiyzCtPrpnFoT0
         +B2q+36L2UBgNHD04EqBG05IMugOtMYKMQhxr3d674Hret4BYjWCxeBcVjroWhkNAZ6q
         eiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=ruSD0UuDyOdambKv7oX8WxQIAvH/zaqcOxiB1s/gliE=;
        b=cdvXnE8y56Z/Vw6BU+qU/a2MwDacFXC1DlFXvNZk2OYKv1iEplswYdn2ZewnQmI53P
         je9pUTatVaaAE1jy2gVNqw0Ji3MkXlkxW1yQUAMu78jjiz53bgcaqYL8M+RaCdUcbLDz
         8W8u297RW8rlkbcxuHzDbhFN4Dg4flkNARbMLO1bSRSMHJvY4jgiuZfHngRQQzpuNTYb
         EHi11EIhfcXwWTfFZLgjp5j7T5a3FmBI3TchdcV4Gnnsh6ICZ4DkFxVdQ9fYgJTxtTt2
         +oP3BUZqQrrZJjMYE0JF1VvZzz3RNKZfEBZwL5RKEH479CcmaztdDsUCRHDjA2R9+GBF
         7+LA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WtkBSuIH;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WtkBSuIH;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v2 07/12] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
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
Date: Tue, 17 Apr 2018 21:54:06 +0300
Message-ID: <152399124671.3456.4156323309583190460.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0003.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::13) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:pDk4aiwbAawWv8D93eBXWZoBG7PgUC7RRs1AA2wcEN8nmcBHzaUGZ9rl22qauIwM6ZX/wyuoN/FVQsZl1LNmSbZhFGgeaGkDPWbEj7AzC//0KZL5WAoYEtQsOUAQhE1fDV4kuDuyoznWpqtAO5gR+H9YhG/2QYqB1T/JnuwYKw8Jv+/UY6tuBbfb0fb0VLxYqsUpUNc8YLIn/YaBce+hGDadNgzfwJhTbS0qVVf11nVnnYuMuMlNdX2BPM1wC03B;25:z59tJEcOv8HsxqPBThJPTi9Jp1H8ijVocDxbObqkNNhzwglPCP5sXOw/CUkDuqzUSLvJr3oRIVKhp80JlfdjSxIxo/ENNgKi93Drmj+xvPrR/1jO0bnFKEDj//6OdyXWh61OmeXTI8BJD9j6+F4BpQCuL673CdIZ0Tbh52POTcGTiyPdEFWmxCZNzd/4FUmj2YNuysCon9tph1CmGjLIh8ca0WmSULsgYjJRBBnTqQdigGnQGHsAtpWYGLgMJsSM1ZzMWmUhNHGxu87vyrMy4uPKW0GiGHF/i9qFA1XPiHX8SPM2IdErFfUebpcWipo6eYQdp8E4PI24f20uB5KdWg==;31:3RkzkUqrg35WatFBp05j1pOHwWKGwUa4MYOin+5g5bkDn4HOYecYdqORPmsKFWk3KN6Yi8QPUKO9I1ZB+bozniD3K2AGDShpxtBtubafm4CekgRzb5hJ7X7jxKJHdbbfnkV0u230WKjeOBIe3RfEY7eDXyM6PeHejdrrTgI7iJ7MXditYJ8zfslV9idwOP4TuonR+nmI4pKH4izJtR0fdu72+/2dmcKdpktPWpTAuo0=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:tJ4Hais/kdJrzwsYH6UQFmD1QT9uZm3lpq3GxSxBAHdUK1MVU2kYeGjeMcl9iYPC7Jvs+wxggT5IzzegxkTXNKA0QvZKyzv6zAdCvbH9C2rzF9OKipP4lQcVbcfde45Jgkh5iz4SvPvgHagi2bszTLMNaVioVE1OalTg+Ps6gYx7reUpwBHQyGO2rjwL6iTUbreVchgc9ZpLC1aiqpTkHSkrwU6EkOv0iyk1U1TZfIBpvQk7UAO8cpLuyh0FqeK//SW5Z9xkGFM1SuL9LH4+Gud8EEbJa8V9vb5S37DhGhpwDH5qVJXE9zjZ62/sEdFKE5ipp+/w2Vki5CXEW5PvpzaNPXL4kBKn5UKzq0pfCmrduGvQyUS3Do8jRqwhWWH4SESS1oZq0M69ZTYXUuAj0VMDV5HB+nMVr9whp8cdCgTlr6GUDx+rK6bKI5bzmiOcLINBNzN1ydut5IH9L3mJe50JrTRlCd2Ba6wykKIlk/CKTvPuFotuFG3AIEkKNQ2X;4:fqx+qwjZ4QKjnWlmRPhRxY4/hLwgbOlLxPaBWG1TjuhDqAhxIUxsKz2VkIC6wKhCJTqiavsocXKKldgsq71lGVBc8/HD/8YbhdZNqHNFvyP/WR0IKABpjR3Z0PhWt14X6mCKe5mQfNBn1MjsCPJHkM/G+ZNl5MqFnGU9n1u3QnkDV6/VntbFVSeP1gBnkVK9bZOzFatxpyxN/Ah/usHHJG6sAQWD7AktISG4yxn6s6tVEzXovHAU+SYmcUqTvftjEjR8GHTAz5ZAXpdB8si2Ng==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1334FE8196D00D881E2D5622CDB70@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(346002)(376002)(39380400002)(366004)(189003)(199004)(25786009)(50466002)(956004)(11346002)(8936002)(7416002)(486006)(230700001)(186003)(3846002)(26005)(16526019)(6116002)(386003)(6506007)(446003)(86362001)(316002)(476003)(59450400001)(6636002)(58126008)(81166006)(6666003)(97736004)(478600001)(81156014)(2906002)(61506002)(105586002)(305945005)(68736007)(52116002)(7696005)(2486003)(8676002)(33896004)(76176011)(106356001)(7736002)(53936002)(9686003)(39060400002)(55016002)(23676004)(5660300001)(103116003)(55236004)(47776003)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6b2NpMEhXZEw0bXZBZUlrZ3orUlJndVk1?=
 =?utf-8?B?a005c2RGRXFmZjBCcVRUZmgxZXJVOFZiZllpaDhLK25Rck0rTnZ2SGNDMHo1?=
 =?utf-8?B?TGpBR0hxektWbFk0NFJiNGo0M0JTanQ3ckpzcVdzazNVd1FFY3dIQ2w2UWtR?=
 =?utf-8?B?UCtPbEp1a3dzWHJkM1F5ek81SzdPd1BJaWpSQlFDY3ZnNUJabHZMNnU5N0J1?=
 =?utf-8?B?NmkrTGxxNjhpWkZiVHFYYTYzeTQ2ZnFOL29MM2FWWHVVZGFFTDdtdHpQT2I3?=
 =?utf-8?B?R2Q1bDNTbVF6eFlpTy9Lc2sydjlzYWZGTzhaTllOejBsb2JvUnlZVnZSVEdW?=
 =?utf-8?B?UlBSZHp2T2VweSt3b1JuTUVZbEg4MEZ5dGp0UWVKWGlDdm1Cd3lnRFN6UFdT?=
 =?utf-8?B?TU9zT3FSZi9ESEJIcHlMc2xlUlpJZ0N6UHFiUml2TlVKRE11ODVwcitGTUV4?=
 =?utf-8?B?Qjl5NFRlNDJaMWZXbDN0RFhXUi9YWkt3bDJSSGF0M2crSEZlVi84ckJ2WDZz?=
 =?utf-8?B?eERNekE3aDVJMUxEMitNWmdKQ2ZUaGFGM1J0STRGM1hrVXQvQ0JBVGgwblhH?=
 =?utf-8?B?NFdVY0RGYkFvUGg0NFNMWEpNY0loSld0QWhsQTRUMHdMaGlUbGpEcTBuK0JS?=
 =?utf-8?B?a1htTjVxTUNaWXVtakxBUVc2bkdmbERBTHBkSDlOTVFOam1RS0xUcjhyY21q?=
 =?utf-8?B?aWFoZVd5VE9DYW5QcElKV0RuMzdZdU1uM2tWMlo5ZWg1VGNML3pzWHhqRHhC?=
 =?utf-8?B?SkdWMWxrYlNtalZxdXlSTFgxLzNJUWxJN0lVU0RpMy9VZEZQc3hMTW9UaklI?=
 =?utf-8?B?Z0hEeFcrQnB3eWJBM3lWbUlnT1hTSW5VeFpWY3c4ZnlCZk1pZVRsWndxNVBj?=
 =?utf-8?B?TGlYUDlMN09FZW5mNVdTU3Q4aEE1clh2UHFaQmhTVW50dmtDSG1LdW8vSE5h?=
 =?utf-8?B?SFl4aW9qMk9vemExMDZ2WTFRSlZCSUIzcXozWDgwc3lDUnhJVlB1NG83cmpO?=
 =?utf-8?B?VXc3ckhnMmVFTE1QUUp3ZTljTGgxRlRzYVZRZ0tKa0xZbUZNdkFOSUFHYmJ0?=
 =?utf-8?B?ZmpxTUF0TTVnKzhFNVZRM05sT2NKZVpyNEdLTVh4V24vWFVpZGFEcjdlSXM0?=
 =?utf-8?B?NTQ3MjhlRHV2TEZXRmUrUEpmYmZQUWx6RUp3ZkV6S2M2WWxOai9tYUhPRDBQ?=
 =?utf-8?B?c1NZampVaENNRmlEaVMyc0R2Tk9Kd3hPUUNFa25TOTBiSXFEZENpMyt3WTZ3?=
 =?utf-8?B?Y1BtdTBNWEsxa2Y1QThBbGRuTEp4c2xjQjMvS2QwbVZIQ1NOWWR4OW9IVUxT?=
 =?utf-8?B?Zk9qWEROZzJZYS9kL3JtSUZ3OWIxaFVXSXkrWCtDbGRIVnAreDd3eGxYMm9Z?=
 =?utf-8?B?UUNkWGRhZ3pDUFNuclQ3L1Y4cmdvRy9oZnZhQUcxaEd1Z1FBckFRTFphM1Z6?=
 =?utf-8?B?aVVaWDIzTFpzK0VLV3hJdTRjYlFDZ3A1WWwzLzVHZmhTMUZGbXlWOWRwVjZq?=
 =?utf-8?B?WS9kcm12YXNQOXc5RTRPVk0wY1JLM0dVRE1scEJwTGhlbGZvS1pBRkNvR2tR?=
 =?utf-8?B?c2ROREd6cXFYRmFnV2NHWTBVejhEd1BHS2dRVXJjaWNhNjNudTVseS9ZN1J4?=
 =?utf-8?B?bWFEZTg2MTJJOUpwUHVUTlFiNWxMNFJUbkdvcHVGREpUdHd0SFVCK0lLYnlP?=
 =?utf-8?B?bmpZSmY1eDJLN3Z6ckVXRXBQMUlFZWh6Nll2SGp4VjlGSCtrc3ptSWt0MWpa?=
 =?utf-8?B?c0RwaHByWXZnK1lCYmhPZkNKZlNxTWdxTTFDN29nSzdjVWxnNVIzcy9la2hp?=
 =?utf-8?B?NGE5eHIzU1JJM3hmaWZCSTJyQUVrbUZzRkF5ZlBWSEFMRmhiUT09?=
X-Microsoft-Antispam-Message-Info: s0m34W4K3dSR6sFONm8gNvVmr1i0F+ZvVT5j1OntQ8cqaLcbyPkiJuLysCxL+09nrbfghoM9jTEakJdU30u3ivfvsqA62IE1CzDG31z3sR0RgLfAb8Yh1pgRAmI1pCB7Jny3oZoNxhbQwMSfm+bU+3yKmbIB8o34Qc3+2KzDd0yhHnAYj6XRYtbcZro/xzcj
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:/8HzSvM0L+nTGFPPEB8CCIW/N1gKqBRAOdaLmMkMuWQm9SIv9dprGu6+ktrOGv1tAGkcHHjIxTXaC2Q6mHIUAs5SLr1S5JGAUaILDf7weww1BaPMSqSj3hYDwAnbsiPUD0Bjo23G6rPdgbhasi929Z4Rj2GVypu0M+atwmJ1GCqxfBsfIucdlPUOj+WE2oNc30sehX3KZJ6iGIdthLzcvqLqE13/0QISR/yj6FIFp7VksRRSHAv03ghIK0yJF3FuITOQDQc3HeAZ7U7NyAkIjWssH+9wQLUs3oluBNebB9/SB500EgXeHhW9eXb83Ot4A5rXCcDO3ql22vF/gA7L5DQA67357TVfDTY99MXI2Z9YhVrf4ESbRkJmuDca7Pjqp/5dm94ObMlK+c7oeQ9x+rpIex2Vy67DDTsNnDD4hZrqqjapsV0U23W/pFbbZRPcyT+RMC/bRm5p1zC6hvbdSA==;5:rqtXRVO0Hk83vwkoqclcHuqqU0ZVgmXlC/8Uh2EiMXxKIj6MwLBB0Fd8O9BIn3miZ95A0+NRxZhW9EK/0Jt8gvLzbyCxi5+xOuDWtbfLgpy+QKtXha14XcBtJkz0K/IVo64I4G7uxAyMKvYAAQYGGcXlLSds2klK397TdMIM0GM=;24:NI/5BOI878SY+YSys7Gl/FiFEg8YFS8eDJuntr2dHvCxt5gFVRd1pLi9mRd1zs85uHJiLiX9ekIUBPhBm28JLKHlIl76tT08+6PInJr5xoI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:FA4qDpZbHgPIs0a8OytbdtowcImztZBW+Ku6P313k4owe68zYhTo8SVXGF21eDZDZwaEG4IyIOtrHEy6vGOjxi+pYQooxRW8UFQFAPcadZkxT2Yn/mazxMWW0MiEkJueM+grozutMjb5N68eZnlPjgdrmNe6Y/s8scpjrr1k7WgRWlsCdYBQQgnh/MSmlsmRcnri1SA0JV2zEXoJzG8K6WRR71z8RvfKuBV6ES416+1fc5+Q9F6QEUva3+PzR47Z;20:cbnAQh8QLDx5mlwr/Gqbd3RvLd+eQZqpe8SWfVErdo+SCWtDxZdsl/OOuwmI/qTnIK4HXtkb3oOl/6oeNp4vlELFO8685zRFl7u1uaDyzngWAAqLg4CvePyu3XYZV5CnZK0ALDSDk3vkcRBGfQF5iSYwnAN5AD4I4amY0AdHBSc=
X-MS-Office365-Filtering-Correlation-Id: ba71257b-9bec-4a21-c433-08d5a47b7a2e
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:54:15.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba71257b-9bec-4a21-c433-08d5a47b7a2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009339122823563?=
X-GMAIL-MSGID: =?utf-8?q?1598009339122823563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
dst_memcg pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/list_lru.h |    2 +-
 mm/list_lru.c            |   11 ++++++-----
 mm/memcontrol.c          |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index f5b6bb7a8670..5c7db0022ce6 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -66,7 +66,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 #define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 437f854eac44..a92850bc209f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -517,8 +517,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -538,7 +539,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -546,16 +547,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_idx);
+		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx)
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_idx);
+		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 562dfb1be9ef..ffbe65d43a15 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3182,7 +3182,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
