Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A405C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842821A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DJhMwElZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842821A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933732AbeGCPNW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:13:22 -0400
Received: from mail-db5eur01on0122.outbound.protection.outlook.com ([104.47.2.122]:52768
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932693AbeGCPK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLOWrs0VGv0IenUkzoSttLkZoveSYYRT75RUexG2KNg=;
 b=DJhMwElZLc3PLrW7sfVRD1mJtp7jJR/5j9jiRLyboGELJHNXoYbg+nga470abmoVfTLW1+nNiIGC6n0KBycCYh4J03eoRsfX8zskvHs9YyZQRjfOgBFVt+4unZ78oCDtua8WDE+IuBOBMkVInRlbgsRO46UQPC3pGawYSK2esb4=
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Tue, 3 Jul 2018 15:10:23 +0000
Subject: [PATCH v8 10/17] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
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
Date:   Tue, 03 Jul 2018 18:10:21 +0300
Message-ID: <153063062118.1818.2761273817739499749.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0028.eurprd05.prod.outlook.com
 (2603:10a6:800:60::14) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b82ac58-213c-4393-caff-08d5e0f71b51
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:6i6srBGFR2xx5K6tMstXgFkqwXY6w6fiF3h57zkkwkjNO4z9nXjtvVtpWOZ3ugo2FfuDUQS1+j94bvXX/gjK9svX1olrR6L5e7ChgTuG1/8EnmquU7ovqhJ7exAb66SYykhbSQrrzyN95pB+grOh8LfcdjNrEB33/S03o8UquFGDMm2OJ8skF3uWoZLRvzQzOY8fPcu8SS9cMuRYEyLaZZ5P2etsgjS2UVshMTnYXNtGGmTsMthoVEgg4vsikyTm;25:pJEt6Xd+M/GfovNDCUFCjNWG1y0o3jOTsl2xbzZ16ZqvQN29WTI9JxONeB1/GOeALWUgUC02rnIylqjApytBYpYhjhZYoqvlT8qjZ0H085mAtYh4Cp7Lctw2ZwXmWu9Dn85kVwHmK7lFCqHxKhtfb0lyNrK8dpkjx5e0polz9mDAtQto+sGlwKmP9ZAtk+yTwpRjpKBmdBkR5mXzngqmj3elb6guix2aElxXw+MYCj1wpLIEF2z2fhue8ctKuj7qsDQLCHAqI/I0mbyAYbn1n9qgaC8TEgAbrfddKYF3KuCqtZfBDhR1KfmU4lEVkcYJR3F1CvcCCaUw2tttc9iogg==;31:cjRmabVwOHDXJCVTH7fD0o6Kgr7ICq39pgbCKHfC2Xpal99a5B6axJKBTwAcXomIVmBzwQmQAOf0lf1yPekyVvNd4u7RuANXxfBeIiVGK6k5SXne8fNn/8/fD2p8KmiOzWM1a+By3Bf3m26Z9tVwCQxGfPypppabR78ihljB+Ow3mbaDIqtteeiac5DYRHq6LZZKqy7ioVHIsdZCRxVD23bDgI7JWA1kUczbpNOebPw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:rTqvRE7A0LiUyfgKvzsvIQ6bwzfGFlM7Rs9nxrNzYwcnQFuXEXwO7x2P4lQ9PVr2l/Cqa+rgEkjShPRrcVygjvr105j/v0vRrSATpeTqwR3902R6bqXdpxxehtRlJihoGbZaeJ7NmCD95wfm/rgCulqw30rPOTAGKiU2ZVTKGqqb06MM791eY0UuxOsVkxMP82Tiol2qJjZsnBTJdm/BvO8Pgb5kljOa2D1DAzfPazcWEqahtwrHtq7n/BmPU+qikRj6iEAG4cGoq6BYAxrPAlPjsCyVcfYkvc5ZnPpQsmdkZlTdMabJYjiS3toDYbzuTUw3dWVd8qEF24A+y821r8iAD4RCWv3Tv9H/boijY8ZuxPqP8VlxEXdYnSBM2YnnWfcAWl3euMaxCRPvWuCzM9Pjz2ef3dVUlrfiOI6cy4A0y6q0Zn2rlw6w/6nT1Akj5vy0wak5nwl7QZcXRRm2FtdIQjBYgUJlJqwg7pzvqTVNGn//LnDOn2VmGZVdFlpF;4:wutVvZ2L97Oao1XQSaQ+XKXWVhNIiI4bZDxAb3xJK69T7VtIs5nwbZ7tYsuxQNUrEYT8uY9RT9oFSVK5iKU0hNADYEx6ZuPK+ehpO4LmhsJYLowfrwOhvEkeKx6gByyH396aSA/f36kp2mJSzi2shTz/qRB1HvLAK3wp/B2zMq4KjucSc1RFdeovbfx3T1rubWKSBueqJql+yzc5g5v8nVq5pAb/im5Yu5H7kimr+4Pp3NUmEKGxyJ4h0Nzuv+67puHEHEHkAtIP8Z9aAHnFzYTFIfHWqX9ywXwgv/S+alt4EbxHOeQCJB/3QFG125sZ6z1yNzbxe/+Y+r3DWxpRh3M+6WixsLtjg677oZjgu0GOsD8gguwrJtA3coUbdE3o
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13348AF91170185272D0135ACD420@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231280)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(376002)(366004)(396003)(39850400004)(346002)(189003)(199004)(53936002)(5660300001)(39060400002)(6116002)(3846002)(106356001)(23676004)(316002)(2486003)(86362001)(478600001)(33896004)(7696005)(105586002)(52116002)(76176011)(7736002)(50466002)(8936002)(305945005)(7416002)(81156014)(81166006)(230700001)(386003)(25786009)(2906002)(6506007)(8676002)(66066001)(103116003)(68736007)(97736004)(14444005)(486006)(26005)(186003)(956004)(58126008)(16526019)(9686003)(61506002)(47776003)(55016002)(446003)(476003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6Yis1eTJLemdwZkFjK2xjK3R5bzFPdjc0?=
 =?utf-8?B?RFh4QkpBUUhkbmlDNUVIZW1ya1o5MUxIbEZYRytLWjdydm12bndMK1QzcUZy?=
 =?utf-8?B?VitObW9FTjErTW9YNzdVWmpuS3htSHNWRnFMTUpVazY1anY1Sk1kMHhlbkQz?=
 =?utf-8?B?Q3dqdlkvOVI4dVFZVXR4Y05zcXc3b0F4bXg5VlcyekpLRjVmenJ5U1N1NFg2?=
 =?utf-8?B?cGs0QWxzaDE5eTlINnpEWTdSRUErUVBXaG5ITlBoRWlmKzlRVkY0SmJXaGxX?=
 =?utf-8?B?ZkNOR3lVY1V3QkcvY3dTU2F3K2pNQ283SEUzQUxZK2R5cWI4cFpsYTVhbFlN?=
 =?utf-8?B?cWpEZHhzUGVXeVRSdGUzTlUvaE9jeC9HMzlUZHVYWkorcUlUVGZmZ2sxVzNL?=
 =?utf-8?B?eW1wWDRHMThvSk5kWFZKRnI5bkx4aUtTNXkvZzlzNDZqY3hQREMyb2N3R3Vr?=
 =?utf-8?B?M2VGb09NUzJvUlV0TGpiR1drTjd3MFpMdFhKMGUrYUFOSkVBWFFGVXgzWEc1?=
 =?utf-8?B?Sy82b1JPVnExbzUwR2V0aGozNENzWVVyNnUxMENsNmQ1WDRnUTZOcm1KbEpv?=
 =?utf-8?B?WE82ZG9lWW1iRmtDdmFjenJMNUFHeThqdXRmU0dGT3RqdkRqMFF6Sy9Ddjk4?=
 =?utf-8?B?ZDRrNXpSWEtuelBtVnFvcDNoVCs0cDVmc0tRZURXclBsRlZncFhsbWh3K0F3?=
 =?utf-8?B?TWJTZ1F3Z3Y2d214WmxsWnpEdjFlR0dadkVIei84OXQwZ3hDbHFOdko1bXdu?=
 =?utf-8?B?RWxwSWFvc3BhckU0NkNueGY5NVQ2aWhodUEwZHFVbnZtSlJOaDJBTE44UVdY?=
 =?utf-8?B?OFNON0drUWY1TlVMdGw0ZzdQbUNFZzZRQmNEVi91cTEvZHdSVWpmNlNWQ2lt?=
 =?utf-8?B?V0ptcXBwU1N6dTRoUHRUa0RIQjNvZk1zZURteUlla3BlZHNrNmY4Zk1pK2hI?=
 =?utf-8?B?Vjd5dTRGTkR5ZktBZFVSaWRrUHl0WFFwZDU2RjhOTkFoSHZ5UVlDUWFzNVBa?=
 =?utf-8?B?a3oyVVliMVZFWVVKU21FTkdydDA3VzZXNVhEUWZmc3Z6V1JTdTNqMnRYM2Yr?=
 =?utf-8?B?b3BFaWREcVFJSjdOdFBTdVFJVDdRQllGOC82b0luQWl6QkFtM25iWmNIczNl?=
 =?utf-8?B?S3BxNi9WZHJMVUJPdUYyd09jelJZeDZrdUgrdExxZGk0TGJHaTVYRU1wdkVr?=
 =?utf-8?B?VXZxTDRsMmU3LzdFQWZVaENabVIyclpzeTdjOWlHS3JZY3Jqc0x5N0xPVmlI?=
 =?utf-8?B?eHBlQWg5bi9nTStJUXl0NTBVTURlZVNrYXRmSEpJWmhZVDFqbEUyd0I4NldG?=
 =?utf-8?B?TVgxeHJFTUllWUt5TlJXNkRuNnJEOEx5RmgwcXc1VHFvQmhHbEl0WHM5VDFH?=
 =?utf-8?B?cTFValRoMnN2M1F4OXRUbVZ5UzRNZFlBY0VFaXJ2T05NY1pYVUZzdEc5ZkFh?=
 =?utf-8?B?U3ZMdExaRjVYT1VoMGI4cXNPckdYdWluQ1o0TWZXOUpoWkwrbkQvNjM4bDlm?=
 =?utf-8?B?VzluWUJUd2xSVU96c21qL2FOcTNEU2JCS3JmNVU4YTJwdmdKNkZwMS9Fa3pD?=
 =?utf-8?B?bzdETVJyUFUrSjdNTXJCZnVMSzZPbE5YdnpOT01TajYvbitpL2JwL3VKaHNI?=
 =?utf-8?B?MlJLUjBMNE0yOW1HQjlFMHdVZGdBeFVFVkFXcDhJV2ZyUE1rOTdjQXpYaEdV?=
 =?utf-8?Q?p+tA0bRTl/nIP42zIXLZucnxigzx+HYkYWfgom7LP?=
X-Microsoft-Antispam-Message-Info: GkY+z5YDX3A6qI1AJHku6iHxGCtT5F1P5crbWgOZ7BkHuvkROOI+SxcAhNGlS72SMiVVwZoecgQTXCnev8KKkNDOBa7i/L1RuHvDTx9kpku/daFqRK5Du2GsDTh01SiocvUMdjKX1pDr3PuLAKN4Gy3+qDtFfLAbOE8lgfrXjeTSoR5ccEEgnXbuIuatqEHAu/c27vK5J1a7pLfMYfpo1OhhNTiqq1JM9R9Z4r9i1kySCVMS554qHBJBw9weySBXmCxY3hwpGZekEaIg2aa/DdsvxyTwH3+CwqqWw8WID4XNa5WltUkT7E4nBjEWBPzCozwq9u/bwhB0bxcrpVxXsRhdBXijFoAjBlk5wp/rXjM=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:5rSM+K8/ysQbI4D4zci2q9tWOQLSPHpOqXkwi+/jW2HUNvx3Xqfqw1myvz48s9fWpqWVq7QXyoZb9nvSt85BmzZxhmuB4aPrZPO8Ar8fNs84C/T9jyqlvYABjEu6X/3oXYOkbzEgdbLrJVquQ5HSahNwCwr8bY5r16U8qV0kL+2L2787lcmXOKToU63Q0UI/1ghtvICgF6pdGgkbmwkUvHi3vAZqZizGmedQb1MsHK+KSTXVuzkfiTF+NUKPNKXC4MZdD7AEyw7koVL0PHE5f1ziRh4gQaZNEnhBMF/BZE6tuZFWI0NyxkcDFNWd6oool/nq7aRCETBH+pM9DZghVFyvLKE4AcFkTyuxdP8yX1XttTYcs6MZ9UjiP8zmDm8nDiCiavmIKtq3OY51yks5Nd6SW16Llc35QJ6FgDE6EIaqK7qfSOE+iGBxo9dEzrsQlvnN44SCIbfQQvwnAjxoWQ==;5:9MVP6HMG8r3aKtALgRIvd74o1w9ywq7pQtmRIxCz5kraAFGp9d6sErqV4bdhJPpzIrLfwJIqfDWC7ByprWhtrbaeLxizUa/99AbOy8p7dr0HStJBIn/hX8W4pM7AaZZirdaxmevC9Nyk5j/ugZy24Ze2mEwU0TU6lSb/l5PnbIw=;24:JrYROb7KTyisnQGGGUtuRHJ8AWroUZFVKFxuXE3ltRxPnUYY4OTI2Tv6DdMs09dM4VBD9X6UIEhfoRqc3syyha95RwXmkCW8lk+D9BDglQU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:UIt4puEifb+PyO/xXiWLzzrddVujc3Y+qqe3ETQco5lkKPddG7WnWXcQnyLVBggd/heDWXKZpv8yu7u1pTliUSNcJuO5k754Zb9x0pNzhHViS9Tsck639wmSZc9EaUBYFmTZAdTdCzFLG9+/m4BGat9jfINtTpdYvV9Q9/cE5fjaLYr596+jjbyWy6fl/svJE8M1knSkFu9/EnbZxt9jtn/Bwr8MMJUpyynGBB9Cb4nUaXeHcVT6FFYDG7KI+TKZ;20:KMnlMxMAqwL3j/18gKHM6jj7OKCbDIHkFFE72E8rT6TlI8AnIgJWvfYme2wd6KZfgQP9ITInnNcyrlxZz68B2QeM4uw3zJ8FtXFgpuFUjeovdMZbnluf8xbsU4Jdw4pLOhNYxFZxWMnb0Kz7BatNMFYm+OaFeoCym2uELSJzPUI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:10:23.6190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b82ac58-213c-4393-caff-08d5e0f71b51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
dst_memcg pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/list_lru.h |    2 +-
 mm/list_lru.c            |   11 ++++++-----
 mm/memcontrol.c          |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index c4cdda4dffa0..144d6d70320c 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -70,7 +70,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware, bool lock_irq,
 	__list_lru_init((lru), true, false, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 016c7d3924e4..467820201e2f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -515,8 +515,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -536,7 +537,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -544,16 +545,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
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
index f81581e26667..510c435a15dd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3246,7 +3246,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }

