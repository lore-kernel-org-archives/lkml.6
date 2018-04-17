Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49XO6oVW3lTey9MOty2LEqA1KGRHQcvQotJE80s8ai/npVjXOqkdgbdBOy5ZPBC0Y+n7DsQ
ARC-Seal: i=1; a=rsa-sha256; t=1523980441; cv=none;
        d=google.com; s=arc-20160816;
        b=GgBfadsCg/x6ID6qgLboVQ5vIDBnLpIMrfYvYYU7pjsJi2phnT7sXjJXlTd4+S2VtA
         ShuY61FlUqZBzxXLMcKt9qcwU8KAFjf9PXNkiaPzE490t+F5Awjl9rGdvC2SS1y0PREo
         KfirvHgUZflH5cjdZRseZbB3jcXiqOX0Vr9Q9ZksMxNvvIXqBAgyO5586nbCeqVySh3C
         iX32kYAFG2BvpMbybg2kL3KjEGmMreAN22C8rX+AeTGGDGQJwq0Af+AQ9fz3i/4v8/4e
         4GOH3GDX69hAZsyIbvL1UitUl/z4FicAW+lClQlc+4FgJHHy1OTG46WR7BS6lkbznW5f
         Yyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=jugilo5jN6YuiAkkqCvIrlMx1hzlEBMn1FYEw9YufUw=;
        b=zoIYw8QskCcGsPSO2Gvea3zlLUaB4vkxTPubhd6owzLTuyYzowwMHO9A0iLL52y0BK
         TQABmIBh/D49cWGHh9e4KZZWxA+hYLB8GjXdBFelTp5aJ0QkaJHWsIxuFJLNK+hIkaej
         c4qYdmk7fP9OVIw5ZGOJwhHdXCqlmn5+fGLDUPxrfcQwrRAKwZkodwoZKQkuDn/e7QEn
         f4lIzdP/syLCF7NmquKWzI1tp4q+kDuEs9qlntTAAG3I/nJ8A3lxrPgriUsQ0Wxzo+Z7
         /G67V8yILcDZjFXXe/7TzVNzk9GeqaEvYjGfH6B2RxMTlxIP072+M4sSWje1bTXBadQH
         8Lkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=EopDPAjx;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.127 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=EopDPAjx;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.127 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v2 05/12] fs: Propagate shrinker::id to list_lru
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
Date: Tue, 17 Apr 2018 21:53:47 +0300
Message-ID: <152399122780.3456.1111065927024895559.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::11) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:9qqPS4qTYN5W+gs6l+Sx3XnOZzC1IurkL51BOLxscbhtvabY2wndWtUqJsmIvyGzrWGRJ2cwMucKqUC/jG/a/MYboTDHHLiADDF7I8LYRpUCFbPqhEKy41ZB99gSnkv72Pvl/y9GrcuNMS4SsU1a7Nll1uo2FZ+TsxI1GaOfA8iMFN4uye1RAfT39YaRx4cf/W0BHaZHDALHbz7BCqlYHS/8uvy9EXI3I75w5Q3Iohm3XdelI7WPA7gpMvxwlPUz;25:jCoN85JA7+Kqxkiadz41Jibp2dcYCVYOqHJAd2F4pztgjvKkdQKpZd0cf5KifDz3ljqraYBsxUzMp7CqW6kfstT1JIu/KfVIdj296ucSDbpBgmmALvFvTznutgoYsdSxX8rsju8BurGr8aaWNwlOP+0/yyJDyrPZciR2HHIzIphglI0YD8QOklyB/sb9htWdll2qv1RMXBpSpdpWeZUlNX8RxlQbgzkEENaM6Q0NZA2pv6/w63rOBWS2vg5hlIhwaGRNdYCzmpmrJZvDWkVZXTZlRj14svswj5owFPGmqyNsCd6zuUjRH6DoZZTtLepph02aTos/YyWtLXXZLIonqw==;31:Hq/2VGiBKhOavdDwEzQXqp8AaDjBEEjJPSTzyOYTx5LiiL+kgBFmDxS3k/GBj7i7oNJjiBsX5kpuAZpRcxzGZYVRuP3u69neCnwadPYnK/xMdayZDFy1Pa5kT0UlTuvWEMbW1DD56LftsjGScgl+GN4hTA5gy+MDFl8MZ4hSQ97eCmpjDkfsL2cHgIeuea7JKuc53lpAL3BbsSsrCAwiiEmkC2HU8QMdiikVbFAnZ2g=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:Q/q9BGne/nafDsEMv9J/gtu3flWrD5wjwKn1MRZefsZ5WlNPOSujiAANKkPZC5YdzLH361/NdwbwBQJWdbHVQn7R5zmRlOEUjcYx0D6gHtWqJF9H+J986j0zWTqLfJXWPITkLclUIoSv7de+DPo8CXOwge+q5l8nU7a4wEvAAGJl1rpVNB/xm/CvCmf5DLA5a4z4a3CGm/h31zCP5zlHdM7kIJC3SJ8w5mCtpTzcPsnBbwQhOLn5cFq13WnJui/4l9bYVvTx4PoySH7xa2fpsHZZPDZilyvpVTIZr2Z7mXASknVL8Skbp1yhj/LwLmhVivyGD75GbV/Zcvkb+waCfC8CBVlslU9eif6WqXnwuCipCcBTSVGmWudJ8H62ZqM3hjtR9nLuFXjBXSmhHJwZmyW3Vi+5o+jgq8RZvifuEwZcPFqG4gB9ukjo2xZAdeR8cjDl40fnSKPuxcPlkSnOpLwPcLd0VAdCr43g85/kXyAW3FOKQoJ155HMI+kMpXH2;4:aR4wsvG83tyhxhkgL//XV9FFc1BB/O9MSOAo5SSFGzDw309+l2xVlVq7QtG7NSABfh3Zh4Yq/MjRZr2ResedSFJlbRh4h98bVB0ihxQDY6HhhbM3dy4uowenoGEvYiPEBOyYeJg09/za3oB9wDRUHfLU/R8r16+Sfl3+LrhymT/hIRJ3e+y5Rn2nEsysECx5kEkzeU17+5fY0/nlXbE+fTqAtnz5NGUjqhNdsJPUIxaOat9jUqAOHmYRTsu1IVr9fPi/YKNLX/lXmpgVoxayEA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13407926FF1F5E1E6C864003CDB70@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39850400004)(376002)(39380400002)(346002)(396003)(199004)(189003)(6116002)(66066001)(386003)(59450400001)(68736007)(7736002)(16526019)(478600001)(486006)(58126008)(7416002)(956004)(53936002)(305945005)(86362001)(55236004)(316002)(47776003)(476003)(97736004)(55016002)(33896004)(11346002)(8936002)(103116003)(5660300001)(76176011)(52116002)(7696005)(81166006)(105586002)(81156014)(8676002)(61506002)(446003)(23676004)(2486003)(3846002)(9686003)(230700001)(39060400002)(6636002)(25786009)(6666003)(186003)(26005)(50466002)(2906002)(6506007)(106356001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6UUt2c2w3MHNQL2JmNXNqNzgxUWZNWk9L?=
 =?utf-8?B?Y3cvTmNuOVNOWkJqVkpoUjluMjZ1SGtKR2sycVp0N2NHOWdkWVk3Tkk5UDZH?=
 =?utf-8?B?MllKN3pkY2pFKzRFaHJ5T3EvRUpkL3o3ay8za1NTeVJneGxtTlBPdmpBb2kv?=
 =?utf-8?B?M1Q1c3hkM093QWZSQWRYSmZnZjc5Q3ZEMFJ4VEdOL21BR05UdnBuVkxWWWNV?=
 =?utf-8?B?ZTF4SUFsRXIyT0ZnQjlFMHFNdE1wbFppYlYrV000QVdkYmlGTFZoWFNiRHJt?=
 =?utf-8?B?UXRFcXZzeXV5TXRuY3gvaEJZM0N2WEtIR0tVdW4yOGJHNmpKeDJPWmtjWUFw?=
 =?utf-8?B?aCtSbFRRL1lvZ0ZiM0RKUXhwTjdkVWFCakN1T2ZvS21NMGRORDhiMnliMW45?=
 =?utf-8?B?dVJGSTZ5czRRcks0NlNFQ0FrV0lhd0ZsRmF3QmE0RUJVcGVvWHdGbml0c3VI?=
 =?utf-8?B?cytheVlVaTE5YjUyeVRnWXYweU5OOTYrQVJEQ1FjR3NzUC9RK3ltV0ZHU0RF?=
 =?utf-8?B?Z2FLTnlRbWorcTZmb2xhMFlVbTRWSGJpVE1IazgvQkdnK0FiWmptOTFiN2R0?=
 =?utf-8?B?Y2ZQc0syNXZxeVlyUHF4aUVLaHNoM0Ftemd0Zmx0dU5IQkRoZGV0blVUSnlK?=
 =?utf-8?B?ZytwdUZpUDM5OHhoUmJPQ25MOHlHWHVOWmE1eWRzWThCejVQSVA1TEQ4eHlx?=
 =?utf-8?B?a1RJTk9KMTJYRkN5K2o1YkRoZFNsdzBWUE04OUdyMGVtL1VSdVdjaVdHbjdp?=
 =?utf-8?B?Z1pDenBiK0MycENuT0wrQXJYaVZsUWh4SnBMSEoxVm1MeUFvVHFIcFRnU0Z4?=
 =?utf-8?B?b3ZGQUNaMldzT20zY05LelRxdDliMG80MXgvQW15djcxSHlxbW5LSGFOOFRI?=
 =?utf-8?B?TktnUlFsR0JQcXVpYndyUFNDSHlURUFDTzFKRjFPWVZ5MmVvRDZFT2M1Q2Rr?=
 =?utf-8?B?OVRTNWNLN2NkTFBmR3U4WEd4QjFvSzdaVWdCQmxxcDhEMDBTRkFnOG0ybmVG?=
 =?utf-8?B?OFRPZ2pyeWlLMGFmSjBHQzJSSGlNZGE2MXl3YVpwT2MvUXJpSk1qWE9UOUZq?=
 =?utf-8?B?STl3ZERaSmt6RmpXWkp2UUU1NXc4clVpeGlGK3RtWE9wMWtLT1pPWWsxdWhs?=
 =?utf-8?B?SElvY01CWS9VMjhnV2g1S0FMbCtINlJIYytZTjBsVlVHMUZYN1hhWERabitW?=
 =?utf-8?B?cmlhQllxYjQyVzJ4dkdTNHlLcU01UE5SL2FyVFNEQmxmQ2VDMmRZWTFpdkYz?=
 =?utf-8?B?MXlJTUNoK2tFRnc4OTQ4cjJNSS96RHV0cTJCRWpXUmVRSnBwSW9Fd1dFT0xR?=
 =?utf-8?B?bGwyakR1K0UwWWlFUlBXSklMcER4a3owbkJTVkhSUlBXMGp2OW1VQ0tJa3Aw?=
 =?utf-8?B?L3RBNDZKbG9SNS9lQU5nQ0RHTTQ5NmtrRFRpWk41MCtDdzBKYkY0bk9vZW5Y?=
 =?utf-8?B?N1dHQ3FBYlhrdlAzNUlBZlRqbnNiZkZjcVZMdHQ1YkRmWW9id01uWkVjWmh0?=
 =?utf-8?B?NmRWUEFHdUROTHRhOTJ3OW96R01USng1UmFqcE41cjRlUnNibEJiUDV3cm1q?=
 =?utf-8?B?Z3h3UDcwOHd2OUFjbnlaVmVoNkJabCtuSk5FaDhnME9EYS9naTdieEROTzNw?=
 =?utf-8?B?QXRwYnFXOUFyajl5elA5QWU3aDMrczZOZUowVFFQZ25ZL1JMQTV3ZDcvTkVs?=
 =?utf-8?B?MmxJeFVJSWJVOTJqYnVpdDZSdFhjK1l5ZGEyWkIyWDZtbjNOVWNWRE0vYUxq?=
 =?utf-8?B?U3o4Yms0aHFIY0pCRWJiU2hqOXlFNm9FWUZXSnFYQXZXamxubmgxNWlaUEJj?=
 =?utf-8?B?WXIrNHdweGhLYTVXdEdxdW5ieTcrTXhRL0kvRkxoSDRybTZaUT09?=
X-Microsoft-Antispam-Message-Info: UMVhdTX6EZ6qxWvVElKSLzZqcNbw71ThgT4jpGwA9TN4qoMAL/vam9UaFwV4W804LEfZizxCXazaUCG/CjkUSzbeU5uLhXc5gz7zKHteIEDaRbFqDUxeNqvQHrT5zT1A/fQQWaJnrC1frAHBb7KhX8kL6t3tNEv8EgWw+xuFQfFlCQPr1G6WMdjMQmM2Y5iu
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:7QE6bRnIHIk2sio/EvsettcQtExEkUM80sddU8Xq9EH9QPe7lca/3gkJbvxpxgo6HJfDLtER4nBjtD7s+dcQOSwVxcP14WIhfNxeq/Fht2kaAK9Z2fcoWMa66KWsbAbkb/HeivhNsmUcMEG1REPUEMGax0NVwGYLOXpmNeJGylRK4oGgzh9qMhmTjZAXuMIGkxVEvxTASshIx1mmJ9/P/yarjSB6rvwLbpBTrvTaR5QB0Ro77ioeTbEAfaytDcO7YFaxZS5xCssLkB52jYZx11L5K7XGgw+cxUITXyNMmyYnDdwXVESRF+arD1mqJtRgJNh0EXpol7nIf6KxZdSePccGNwmkJXB6nqbmr+ASbMQshwIvrB8IoYzKCZLXHzCSy80MkZck3I2bi0dEg6CIyS7LwXUDdQW33CKwiMMmjxXaj1Cx3rYTAttZE3o+EKqaARCi+pNUcaJnz3MQ+Hnw/Q==;5:rxYXNohQZPeT4pGyDNN5toYUCY093VwyFK4YzvcDZlO3k0yAbl/vnEq3F7m3kAVu+tpfB0N+n6XcTb1VkOfaoPOetjLMbdJFZdIT19LkJds4B+VzZ/plTP5Xplc5Pt+y6RLH2X98dkersvGYLscRhKXA0pFlXBj6NW9M/2m3O7U=;24:aKEdZ1qDfkdrJgSoNlC/v79y+/+qw+Bn+2TSQ/HzJWU8pCyBJR8sIzts/fkV+ZFAcINMdH8/q/gll+1H21Gy+glBUIKe6OfyF/pNcQl73qA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:rp6AiXbjeTPlEojaNNFJ2ynjdAz4k50YyU/cjk6dUFgACGAxtkHp6wCvKlbV3+s++E79on8Wfb5Pdj03uvxV3psfzEzQj/t7ZlencUS5zLRoKXgSBsS9tOYI7nV5ApGI76A9Rr5Npijzt6fWjnQXiRQVmcYNwirJBn+AZ9KC+HsI8Jj2r606cbC6hTddoO+7kk9VvxDMDWWYAjT1pSpyICb3AHJB47+ARGFk8GDSHEIlKwVO6LrnkLWPVKpAefQw;20:YrpWWLIZPT282J3z1PMFAET2k7SMS6YEBtf4IX5dSThxjW1l420dCRzWLwWnpCFxycWOWgH0/IYhR9x4AQiBvSM6jDD3YcviFzx6iThlB2Zh535a8kaVN8SxILA9rAjzQqVQtlD5dKZSfhndmgno5VGVNZtTjZX8esJ6HVt5C/Y=
X-MS-Office365-Filtering-Correlation-Id: 58c9b72f-56a7-4b49-0f13-08d5a47b6df2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:53:56.6868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c9b72f-56a7-4b49-0f13-08d5a47b6df2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009315192285775?=
X-GMAIL-MSGID: =?utf-8?q?1598009315192285775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    4 +++-
 include/linux/list_lru.h |    1 +
 include/linux/shrinker.h |    8 +++++++-
 mm/list_lru.c            |    6 ++++++
 mm/vmscan.c              |   15 ++++++++++-----
 mm/workingset.c          |    3 ++-
 6 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 5fa9a8d8d865..9bc5698c8c3c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -518,7 +518,9 @@ struct super_block *sget_userns(struct file_system_type *type,
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	err = register_shrinker(&s->s_shrink);
+	err = register_shrinker_args(&s->s_shrink, 2,
+				     &s->s_dentry_lru.shrinker_id,
+				     &s->s_inode_lru.shrinker_id);
 	if (err) {
 		deactivate_locked_super(s);
 		s = ERR_PTR(err);
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 96def9d15b1b..f5b6bb7a8670 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,6 +53,7 @@ struct list_lru {
 	struct list_lru_node	*node;
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 86b651fa2846..22ee2996c480 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -77,6 +77,12 @@ struct shrinker {
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
 
-extern __must_check int register_shrinker(struct shrinker *);
+extern __must_check int __register_shrinker(struct shrinker *, int, ...);
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#define register_shrinker_args(...) __register_shrinker(__VA_ARGS__)
+#else
+#define register_shrinker_args(shrinker,...) __register_shrinker(shrinker, 0)
+#endif
+#define register_shrinker(shrinker) register_shrinker_args(shrinker, 0)
 extern void unregister_shrinker(struct shrinker *);
 #endif
diff --git a/mm/list_lru.c b/mm/list_lru.c
index d9c84c5bda1d..2a4d29491947 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -567,6 +567,9 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -609,6 +612,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f63eb5596c35..34cd1d9b8b22 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -188,7 +188,7 @@ static int expand_shrinker_id(int id)
 	return 0;
 }
 
-static int add_memcg_shrinker(struct shrinker *shrinker)
+static int add_memcg_shrinker(struct shrinker *shrinker, int nr, va_list va_ids)
 {
 	int id, ret;
 
@@ -202,6 +202,8 @@ static int add_memcg_shrinker(struct shrinker *shrinker)
 		goto unlock;
 	}
 	shrinker->id = id;
+	while (nr-- > 0)
+		*va_arg(va_ids, int *) = id;
 	ret = 0;
 unlock:
 	up_write(&shrinker_rwsem);
@@ -217,7 +219,7 @@ static void del_memcg_shrinker(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 #else /* CONFIG_MEMCG && !CONFIG_SLOB */
-static int add_memcg_shrinker(struct shrinker *shrinker)
+static int add_memcg_shrinker(struct shrinker *shrinker, int nr, va_list args)
 {
 	return 0;
 }
@@ -361,9 +363,10 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 /*
  * Add a shrinker callback to be called from the vm.
  */
-int register_shrinker(struct shrinker *shrinker)
+int __register_shrinker(struct shrinker *shrinker, int nr, ...)
 {
 	size_t size = sizeof(*shrinker->nr_deferred);
+	va_list args;
 	int ret;
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
@@ -374,7 +377,9 @@ int register_shrinker(struct shrinker *shrinker)
 		return -ENOMEM;
 
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		ret = add_memcg_shrinker(shrinker);
+		va_start(args, nr);
+		ret = add_memcg_shrinker(shrinker, nr, args);
+		va_end(args);
 		if (ret)
 			goto free_deferred;
 	}
@@ -389,7 +394,7 @@ int register_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = NULL;
 	return -ENOMEM;
 }
-EXPORT_SYMBOL(register_shrinker);
+EXPORT_SYMBOL(__register_shrinker);
 
 /*
  * Remove one
diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c83978..2e2555649d13 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -531,7 +531,8 @@ static int __init workingset_init(void)
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	ret = register_shrinker_args(&workingset_shadow_shrinker,
+				     1, &shadow_nodes.shrinker_id);
 	if (ret)
 		goto err_list_lru;
 	return 0;
