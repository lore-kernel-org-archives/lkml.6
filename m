Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqxuUvbr1JkE3wbW8ffMF5gEJ95OCfLGI6h41eEEvNh33Is1dD0Xau7RXVFGcbOwlkGMPKU
ARC-Seal: i=1; a=rsa-sha256; t=1526632987; cv=none;
        d=google.com; s=arc-20160816;
        b=g/D3BtnzfM+wFESXQ/ykTWCxMaKI0l3W/qtVvBBrgl4Bg/nrtILkECmGtWaSccTGL7
         2sP7sMDaX8/p182+zIGhsKNXkh6fpkqPC2u90NfKZw0iyO51xl1D/t+cgGu5jHTUlKrO
         N1vXZF4WcKjWTkWWGlXwlKI2wBmij/bcXMxDy99W/8QYDtIK7DfueVeLKnpdnCdoqQjh
         Hz1DmRxHRVmWmbxSfHy+zqJ9E4N5o7GVly2jAnOuyr1I7drl9+Fu3WmMKc08BwPo92br
         dg48TMYp3AA4+ks6j6i2QnUjp6BdirlK9FHTXZIiUqfKgvbLhRHhVAtecnWupQga2SqY
         9L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=b9UPD/IfIGGbOr+M4Lq691D/JgW5ZmeR0yu8brP/nJU=;
        b=fktMIjeHfSSd/oqC2unoDK2D3p3OgrVvEoxfh1fFbSt9Q7JyJoVPJN188pxjNjODF7
         MEatyoA8R6Ds/is710I59YUSQ7dZ6oy3MM8z70aSJzVsaTAQjT12DV+09adWUPYW+oYz
         1BVZFxS0QOMIQY4NpKB/1H4Nqej6P9WbdgvBN/AoMQpLr0lVZpC1UDgQDuBY4XU+h9YN
         3pr7sze91N5jtgzFqDJS+M/rr8cpb8bV893NCVn5SiJYgooqtIOGWpaySI+QTX8ieVDv
         wxDrptmMEqJuaJNFLoL/x1BNAQBEPK7tOWmxxjIeJU8FRWCPhZsl/92BKamuGgH9GfFy
         I2qQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=eRXAPltb;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=eRXAPltb;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 07/17] fs: Refactoring in alloc_super()
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
Date: Fri, 18 May 2018 11:42:55 +0300
Message-ID: <152663297580.5308.11314227717473130012.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0501CA0032.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::42) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:P8FdrBSpb6Rruu3A2kxyUGEEoEKm0kT+8IRqXzOR/NmlDU8bK9fAmzooh5S+f5aLNmVfMMO2orStUWzgUuIONW7RentR/WuFRfsolzOt4h6QMISwEiD7B4I/5KEiq9WvFbnyRexZsrnXlLBu3oq2iuuxvLulUK1gojkQrXAuaMytvCQegRj4dbu72orQOB/yZscLsFkLKkepHvcdMq8/cXD62Zf3SExbrOLSjE/1LW8YlGCkkX07d6taz3XnJyNd;25:jG40VS8GxQdYBoQ2Ukvc9BGC4A8GgHPvcmD3Ke2o8l11rdOTNmo8y5b7oKvHLdGlRhYoSai8+c7VhIhd0eTze5fQd8st4Zxr02wSUdsAZ8uvauWUUaireY2r3nf3RclpVIil2PuDCRVqhuvguozg4mIr+iN8KT8y/3yLLOQvdFZRPSX6TqcU5LKGTJOK0VCu1aCKiYgNONASuJWAQSqcuE5tSxYyRIg14CxYhYgiUgj7tkLT2MBND7LQC7kT02S2uAgF7q+kbII8VRk4ct/mNB/LBgqE4vXodtCVwQenB8pTdO1JOs9Zo1omLkggFScWSyG7nvhoOWeFVzATItZAsw==;31:cm3OlLcr8vgON8uAlUc5yC/DFARukuZwZpysFdR/a1f4E1mOCSsiYGS+NGXDHOfjyYS0gEv1I2sO9cXNPaIwF8Nz6iQEG2B33cNsfOnNn8k7/rKQlun1UHlZeAPPv8LoqQAVDusf1QbBBsfAlqFwASWdSqnhf2Ic6ndx4khGoAXjWqXrKvE6cardI932sRk+MDkVS4AmNO8AnLdQTvdVh6e0xIG7SjjsmHEHE+P3ZMo=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:/heoGT4oNFRyPAzbeMQnAVwmZ8nxf473Hue2wqpSnr2wPhIYicDtyMi/SumdJ+/pCRWasPlWunVcGneYlezrcrNufJHFAOW/xhsoHgqnJNi7n/eb1RiQYt7eNa2IJfmvCvgqeSNurXNuMFmkiiVlyaqR+gAlIydCmbPRD7zUY++HrLS3GQ+uq+tNNgotbXe2rhcFaqmIURZhD1SMpPqh0VeUQfGv9MJmje4XBQcVX9krEnsyk8SeN1lvo0BLNkSRjMslbjgSVGXeMKjvgcU43g33SAATvChiE3h5IGMftiIe0z7hPXwREkuiuXNLMF1031M5L6VJ3JhR0eyYjskFUTPRLP4nk8RgwumUZbtytC/gqNY6hqYnRwXluplDY7NBBwWANxB6CDk2VTEnQHmR2/trSXWR77S1Bhk9iyaKsqWOeUuYHiCf05J65e6pvgdu3UehMOzNDfHy10EvRMoTHkUn6t/Omr2g2D1LNaMT7V6IZ9X8HX2TsrgaCPRKc57X;4:SY9RfApNRFgmWDEoDUnq4P1zwfQHwZyqdrP9EU9CHO/10l3NWBf/LxXWM/LDA4rcjU+I6QhQmORW9Pm9m0sNt+HX3mQbm+NJ9t2UYM5/BhIro7Z7SxZBMg4yFBtAYgo5kw/XMs5pvrbmZizVE/l9jYwE60ngly4YXgZ3x3O5Yhe2Fl4rRy5U9yStHmCN9adjXp+MPDIdcrUI7LCh5r7eODg3GVhPFA1Id7sckmqBKIG0gFjTQKw4XcN5cPD81vc7VqmD63OoWOl5VTRxtchsug==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333EE0E54CCF8A0B0D5519CCD900@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(346002)(396003)(376002)(39380400002)(366004)(189003)(199004)(23676004)(2486003)(7696005)(305945005)(316002)(58126008)(47776003)(76176011)(2906002)(68736007)(52116002)(446003)(11346002)(97736004)(3846002)(6666003)(33896004)(25786009)(7736002)(486006)(476003)(6636002)(61506002)(956004)(6116002)(478600001)(8936002)(7416002)(5660300001)(16526019)(230700001)(103116003)(59450400001)(8676002)(386003)(66066001)(9686003)(6506007)(105586002)(186003)(55016002)(106356001)(53936002)(55236004)(81156014)(81166006)(86362001)(39060400002)(50466002)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6VGFaTFMya1dUcTlrUGpmaVQ5VS93Q0xZ?=
 =?utf-8?B?UXV5ajNXU0Nkcis4V1FpRy94WjZCNHRCbnJnMXQzUnMvYlo4R0JxZTVBVzJD?=
 =?utf-8?B?TVU4ZVd1cldZR0MzaFVZTHlkK0FwRXNWaGdpTW5BSW5yZmM0RERhTEJuVlkw?=
 =?utf-8?B?ajJSaHpUUll5UTlJUGpnQzBmY09iNXB0THZ5blAzVnVqVHFSdnZtL1dzUnFN?=
 =?utf-8?B?VFhCeVF6c204YlhKMEo2ekZ2cHkrcHVIcFRaYStHVmdIUzBYUWtXNE9FNDlK?=
 =?utf-8?B?dHZxRzBNYk91RW1DUUVJTmI2M3ZsTWhLSHp5TExuQURKUFhRWTFtNkhvZ3Nz?=
 =?utf-8?B?cnFGUlhGVjZrakVYUG8zTUEzTVRQTUxqMVBJVkRZbTl1YkxoeTlva2NEaGlZ?=
 =?utf-8?B?Zmt4OS9yTSszVkI4dHNHRVNma0FMOUVrQS9XeHFrUTFYaXVYL3lKNDZlaHQv?=
 =?utf-8?B?UXQ3cmFBU2RHRGw4SVpRNnNlWDhjNUdYQWtCcDJvcVp0Zko4WXFHbENuTzQ5?=
 =?utf-8?B?N0F1TS9YV2ZUK1E3SzhtSXYrWXUzSnFnSzFzOUl1U0JoVVBFRXhhSDRTZXZH?=
 =?utf-8?B?bVdaVTY4NmdBUnN3cGRRbVgydWllUkJJQlFoc3Z5K0xxY2UxU01yOGgrdGVx?=
 =?utf-8?B?NnpvYlNURGhWRW5LdlBrNEVxS05xdjgzWTFweDM0ZExvZ3BEK3F1dUVORm53?=
 =?utf-8?B?cnEydGlSM054bGNYUE8yQi9aWUhkQkxnOWgvSVZvZmd3VnZjcUs2VFYxV1lq?=
 =?utf-8?B?ZVdvRHIvdFFpcWhDeEF0bnYwVWZOOUpaUWd6TERLb3JNMlM5V2xLNkFyVUZQ?=
 =?utf-8?B?SUhWODdwODFBVW1oVmRNbkk4dmEzaDhoRXRyU2ZqdFJTTXJEQ3NLZ2l5OHg2?=
 =?utf-8?B?Y1dDeWlpNkgxWmJnZE8rcFpLZWpkVmQyVWJMQTZSZzhra2QvRGxwNGV1c0Uz?=
 =?utf-8?B?bEh2REF4ZmFZUm9IbGN6TWZoNklWQTNDNnBGYXpzM2NJSjVCM1ZERGc0Vm5R?=
 =?utf-8?B?WjNGdkRRWFJkVkZla1FvT2lrREFyVCtWSGJOdThXZGRyVXhKRzk4cUJHQ2Q5?=
 =?utf-8?B?djZjU2d5VUsxLzZldUhBaXB2VkJhd2dVb3M3YldtNkEzdm9hNlJ6akhiM0Rn?=
 =?utf-8?B?enJTdElNS3phNjhaOG9pWmpFYjR6SjR1OHBLODlDS3ViRTlxaEIxSkZTOS9i?=
 =?utf-8?B?bk8rT0MrN3NzcVRKems4TkUzMmhSOUpsQkJWL2hac0VGWDhTV3VlMjRFMzcz?=
 =?utf-8?B?ZVdSR055aWw5TWxEUU1zWDlvQ2l4Y2J2MSs4RWM4bUZRZWhHOXN5cUZYQ3Vw?=
 =?utf-8?B?enhuYzBwaXFUS2NJM2l2WUs3eTJ4NG5XTjRhemkwQVJ6NTd0a2VNTFFqaEd3?=
 =?utf-8?B?SW93OXdRbloyQllkbmg1Z0pWSFdpL0gzM0RXL2hlMU5YUHNSMEVYc1puaERh?=
 =?utf-8?B?OUs4dUxkZDZRcnZyOGQwNG04L29Gdzg2K2lwaGtPNlc0a0lNbzk1R1RJQXNO?=
 =?utf-8?B?anovYVFQQWt4Rjk5SkdyL0NlUW43a0I0N3JqVGtCN2lUQ0ZWK09ORW42ZUxj?=
 =?utf-8?B?aEZIVDRzbjg3eVhLS3FNOWUycFF6WUFqbDVjYWFFOERTWkNpR0dsNHVJb0tk?=
 =?utf-8?B?SzRsbno1U0J2ekx1aFBHc0w1eC9WS3J6OStUMUFIZys0ZEdZTXlKZlpBUTk5?=
 =?utf-8?B?QVhDeHBuS2FjblV1a2hQWFJSUFhxSVZYczhVUVF4WUs5TVhPWnl1TnhPUzVJ?=
 =?utf-8?B?N0tGcURrTExlNzB5NTRqbU1WbHZZRk41NHNqRER2R0JDbkt4ZlF5S0dpRURV?=
 =?utf-8?B?bnlKSmRTc1RUVXlDOW5WcDUzKzlaRlRMV29nLzZESmpBMWxIdz09?=
X-Microsoft-Antispam-Message-Info: QhnnIYIZh979o/dZmCECfBn+CVOWIm/kcVEzqJRFBJRDsD+zlVYUioGlIz8Ei3LmbbrnPvQHAAkE+Ocv0cH5HIczOxbLpKV2Ln9lbxbvpCnD/YQdYSwtd4BwXprgn2ZTLdfPGAeYOKwZwgIV12FT5EAqTesr0GEvSuWneDNFVcVUOmTs58tDeBToaGAcBvJZ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:36u56njA53QuoheUSrCMXvMAdtfKvxODiVbsvLJhkRN2JtWawf8xbkqWQbnD2LKi3lTjlVkmdYq5yE6tcSd/4+p2ZlW+39Ua4htFM6tBPvuwkkI2Kc/MWNM5OEmwwDbVk1Qd9AwZ85hTgPI/hB3O0cmJtSP1PpM0G+RSOrk//ZTqWgFke7RGHuNwU5mjMomZDrUh4+tGNCXhaVBqfktqB9+7MuqSlC4bF5+io8t3h0ervG5bhanoIAEAM760CfMuaUwItCuKDYdcib5AoIRHc9ldKJUrzFP4OR4Oizp7vs1zv7l8CnqCzX8YS7gRAUFoiMYex+Daz9f1ZdpmEkYAxd1VQwGjd1aUfzlTT+UvIGGfCxPPLzhn1nLGhZDDJeNPymP04T4E2anIDnDtRAyK+abNb9vNFtUR7s4xnTD2sqChOZ9kC5gDxvWAHdcfn87GEjfEzLeaxQHLJerTv1oQBw==;5:jETL5RInMm03RFhTxREqaoq+j1kjkrYtuJKnMmbkt+czhBQ/jztw/0BDPekM5Q4UybgzMhqlrV5366wqNillghqKVz94GuJxDObylQSjnO3M2d9a3utatxgfmvBsvO7nm54xo3MJy0Qm0HNtKKWtNG7ZDhYqZZiZX09WMUdvf8Y=;24:Fmnu3LaUNElr2Y1rT88Shr06Pq4h/qYQZIJao2+Z/vel9HMoCZKVx9D6VW4pZx4nPwcd6joWog+DDBj+OJegIQ0gzW7raPu/8C3zYPXuTdo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:Km4IspWr/XUrpeQJhekLXg/NaxRqDQvcqVzT7CSa9MMFpzS4qcy4ryD7imZQi1hqm4ycZWMwzv7SWm8YojhPVOO8tRAKFRW4IJ5VRxuHOx8BRLxNWFGKdschLoHY0N9oxftrERkIXkpl1WmcK47D50RHad0N5fopt6Bvv82qXS73mhYoRRZ7cp+HkVovldaB8PAnaRLw5t8FGf9lgHatjOMZRZd62GPgV69hWaXWBtEfYkchK3SiC49iIwAHl1G3;20:JRKesy9vyRrVa0+6E/LmWJ9gb38PJ3tXDjM4GNlZWBu8Bj1A1S8GcnVXAWQBqbPvQmHLRVJHbkMlsowA3nhoFfHujKZjV7YxqQBD5H0erO24Pbx1oIAztJMu1XRVbEm6M9AvXzIL+xRKHHjBWCqP+k+jDIoctO1LPBkznerbPeA=
X-MS-Office365-Filtering-Correlation-Id: dd6c8c97-773f-42e9-14a3-08d5bc9b5d61
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:42:59.4294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6c8c97-773f-42e9-14a3-08d5bc9b5d61
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790711170374876?=
X-GMAIL-MSGID: =?utf-8?q?1600790711170374876?=
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
index 50728d9c1a05..78227c4ddb21 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -244,10 +244,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -265,6 +261,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:
