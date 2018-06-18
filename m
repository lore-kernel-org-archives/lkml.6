Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED59C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F56C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gdEI4aRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F56C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965511AbeFRJqC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:46:02 -0400
Received: from mail-eopbgr30111.outbound.protection.outlook.com ([40.107.3.111]:14982
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965343AbeFRJp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cpyamzKJzTpP42p71B+m7Dssy8doT43wwml4xPuo3o=;
 b=gdEI4aRfMhPzdQACkv2UpRbOzPEnr2rzlvU3tB6eAtdKSim9x+t0MrMl1+4FvbVMk8N7q3hSrsNSKBql9TS47v40zQ8FsXw7Ve4t8skz1BpzVkGkUEOzNjb0faShou7PGqAj2y+cpV3qP4S+flODvSeHYQNjkHV87W7J0E7jupg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.14; Mon, 18 Jun
 2018 09:45:51 +0000
Subject: [PATCH v7 REBASED 06/17] mm: Refactoring in workingset_init()
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:45:47 +0300
Message-ID: <152931514789.28457.4737374354831959330.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR08CA0074.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::45) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a58480ec-c7d6-45a4-aeb5-08d5d5004865
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:EUtI7Uy5DZ1DLz1SUi78JhY+P91vVkNnMml/i37AGPDA8+9MWFbNrWyEK1jaIqBGejZOPI3Cdf7cuOStc7sPhl3eqjctjrp18GAxWR4cHIVJfmYclbDDLkUFjh5TUwELlt+1+ByP7N0rzpGn2JDmgGN2A2QLX93yeWiotUPqB1O1AGDt4ZGMbh1AiOaXBfbBkz34+7ivf8iZLx1JQBeERpFOQhwluP8idb9JnEOMtXtnGaMPDOuDfWgZQp69Ie8j;25:YF7tVR3H1uvg06y8DqIvNUC27aFX5PyE0fRFNL5siUorheRdbdQO/6chVJukggsRNDJxk7dFOerWc1wGmbiShbedI+N1sQyGGjlcFaZgIvtl37QYwgq0qhbCoizk3Tb9EAg7PG4ItrmKbixc1fsI2DUSXQoZJ6FLNuQR/HYXftquVXHAKWq1RPQyHzRa11DqnCEVRdKOH6yG7/rhRfec6+j6WtJJQ6h/+9QHBRz0/BHWHOPz5wReNZM7dJwZzqmRDuVrak1J3qSxWwmwzMrZ8qOdYaNxl85L+qvonn6NZVBflkw7ipdqD1ZG0OGC8RIH3IedvhODk5AqGVdlsRCn/A==;31:cGUyfh+Uw44OpSwTdfmzZOye1gbtgQcj9VaUDSVmXcX/9zfLTGkvpPuQuTIscmaAJHZmOeLvYS2bDGOvD53iInJiH38c8XkxcyShb2tw+ZOeBevHEqL8g6SyftsGfZUBagkWhjsj8OI3xDcOSKHRngndwmQHbrsKUn+2HBf+Toc9+jU38QIBMZgpd3qyALbVEqmNtbxk5A2HI6NkvCQY3rNzUtkwxSXpAs5WNPITLtM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:NcVAtHkgVNeU7C0WOv6fQSF/fsXRXZiT9Y9AQCbrTtNQ8LjZ4X/YkfiAQIfrm9ttn5GVlVWgWUuwTZQV7KEgL7bnp9PB66f9d1JnQ3Sot/y5qs7lF6KU9tNkHRq36KZl9NiVnNxDWuw28Uu6OWc0BzNPmdQ0HWY5hdrPgzxqV8G6TF8U/yCRKhiRETmp2vWoeuUzDTpCovGZatGZxWqP+cyVE1xwBNDdmMdIkbPR8oqilzWRnKuT4Qbwe6dFitzZga2cI1sdnbXEWRkFeBDRcGTKBTJ2bIqLT3KnkRf7yDKlCC2H+pwaKx6r9jgHKuxzNkYkz686SHj3MvHdhSwOYoKw30uWeV+RjdnMt0tevr9gZ9uYUvjK8j4aa7d8MrRCZiG+w2HYAmR6sb80uT/0AMD/oJqzph2B6AhGcYvXXBAf6siRqzwd5Q96SFBwt15us/KjuajmXYfWSsIKSwa3dcniKI0D6ucUNDLMFQDoWpfYE98S5b3K9kWD73XTCntB;4:SW7Gtivtk+kyYPFFGEVQmcSZNZQTpbhHiWq3rn1Zhcm0pT3EYl+AfEz+Zwp5svn3nhtDMpKg4iZYusn/0oEslS6PWNr4rdFs63GXd+P8Je+mj/H1dKyBMV85Tl0lJ8Z+CbcnLJcjhVXUTzKB1dZ0uIT6E6luOb8jJClCqn1p6+BcmBHJLqMy/JjxSpXvUCvVzzEX9oCKSUwEPyMRuyDeePmoofBb6uXkL4SjAAxqab63synOPkfRA7HlvDMdsHy+3ZqYPummRL81cqcQFYAfO1h5y4mPEmDxEcWY0GLjGo6RuJrB0KLonIH4D/XA7u88gMGb6YvEf1NV/4nJlj5da1XOXw5tmJeI0MMGIpt22y0NTfPoLV9HoJO0b0DKnpOh
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134143DF4B3B1C3B1FC209FBCD710@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(396003)(39840400004)(366004)(346002)(189003)(199004)(2906002)(6116002)(3846002)(11346002)(956004)(6636002)(478600001)(486006)(5660300001)(86362001)(61506002)(81166006)(25786009)(6666003)(39060400002)(446003)(97736004)(476003)(53936002)(81156014)(106356001)(105586002)(9686003)(8676002)(230700001)(6506007)(386003)(8936002)(59450400001)(50466002)(47776003)(7416002)(55016002)(316002)(16526019)(68736007)(58126008)(26005)(186003)(23676004)(305945005)(66066001)(55236004)(2486003)(103116003)(7736002)(7696005)(52116002)(76176011)(33896004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6VUpwc0ZpM0tvNzVPcXZ5VHdJOTE5L0o5?=
 =?utf-8?B?NHFQT0xKbHZJOGhlSHNoVWk4Vnd6K1UwZXJNaUQ4VVZjRWJlVUtVZW5aVXEz?=
 =?utf-8?B?UmJCQWE4VkpKdHNmb3BzcE90Rk5GR0JaVEJwQnZRZVNSZFlxYWxSalgwZTQ0?=
 =?utf-8?B?ekI0V3dwanpWbTZYS2ZSdGRqb3B4bittbk1sNEFqMXVxWk5TNHNnOVJJemdU?=
 =?utf-8?B?T3ZWSzhYTVNJdlE1bzBISEdXYmtCNTBaK21nY0VYK2JvMXVwaWpqam1IZzdB?=
 =?utf-8?B?TGw0U1BTMjcxNko4QUlVM2hkVHNrZDJtemlvajMzVnlOWFhrQTB0NEgwem12?=
 =?utf-8?B?ZFV2bk8vL21vTnRXNDdYYkVQZWg1YkFiZ0d1VWlUNnpDUXd2V3hVcW51eExi?=
 =?utf-8?B?RG9WcXVNcUMwY3VnU24rL1JVdkZVaXAyMHhsd0hFL0JReWZwaUFsK0NxMExQ?=
 =?utf-8?B?L1YzbEVkL05mTzRhNlZZWlA0Ny8wZ2xQNUZ3VVZRbEMvTXM5V1orWnFzN1l2?=
 =?utf-8?B?ZURac3RJRW9Wejk2WGRjNDBpSjFXQXBucDZtWDJNeUkyQmZxcExKQlZ5MHlQ?=
 =?utf-8?B?NXFGUTgyYy92OFJ4MnpSdm5OejVobE5RSVFrbnJYeHhrenphUDJXdHhnRms4?=
 =?utf-8?B?WUxUbXI4TzZrd1pHMlF5NEgxcFF2RkZTWkJ0QXlraUw1NlBpTWNCeWVtS3RE?=
 =?utf-8?B?K2ExYjdUOGF0L0lVMXV3NjZNL243cXQ2VllBNlZUUUNid3BmdnlXcGl6bEZN?=
 =?utf-8?B?Z2k0bkdWRWNldGJqY0RVcDlzYTA0c25zVmwzK0xmemxzRjB3UVN4ZUxTbm1G?=
 =?utf-8?B?MmkwYVVwSjZOaGlhOWdPYTYwSElzNmc5VDZtUlQzUnBFWG8remZRL1J0RDhw?=
 =?utf-8?B?VHRhaVc0ZlN5VEhNanNKUzc3YXl6Z21kVHJTU0ZROEtUNUNlWVpFZHYwT0pL?=
 =?utf-8?B?R0k1blI0eEtQbkZyUlYxZWpDc1k5aDllcitjQXE2bS8zSXkzV2xRenh0S0hk?=
 =?utf-8?B?VE9lWVEzVHJWUmpVdWEwNVBTR08xL29lUnhEeHBmQUEvRVlZeVhrTjk4V1V0?=
 =?utf-8?B?dDlMY3BmdkFVNXdsblo3cHdVN2diKzNiTHBpMVBoWjlBR2ozOUZGK2s5TGhG?=
 =?utf-8?B?N2s5eTRIWTVBanNTVDgxLy85WVZNNGxYYWFmdlRwaHFrZG1haVhkdnVaUXhR?=
 =?utf-8?B?U2pMYU82ZnZMdWdaMXRmbXpZYmxHRDUrbmdKVnlPZXZsbE9udzhrdDlBeUYv?=
 =?utf-8?B?Y0ozbENtcjdFa3J0L0U4OEJ0Y0kvWHNwc0FZeEFOVXo0VmJFa2d3YkJHeVpX?=
 =?utf-8?B?d0xnSDVreFVWM04rbjE1YlE1QmxMenIzT1VKWEEzQUFpSnlBaDIwNG1kSjB3?=
 =?utf-8?B?NlBDa2RaLzN1cXBtUFVkMU5adnFFeml1c0xSVGMwWk5KRFpJSmxjYVhhenNj?=
 =?utf-8?B?d2RDWkJpTHlrSzZsMTU1bjNpL3lJTFRMZ2pGTC93RHpBTWJwWmIxY3pXSjFS?=
 =?utf-8?B?MDJmUFc3NndBVHR5LzJ5NDdOeVlhbFRPNWY2U0lWcHRBZ2YweW13UjdnV2or?=
 =?utf-8?B?Vm5ZcS95WFN2T3NtTGNGdnBQY1Y1V0dvNlZLdEpVVi9rZWlvK2NOVTFuNkNY?=
 =?utf-8?B?T0lTaEhQei9yNVVETGFKU0dJTE1Lb2N1cEszU1RqcDl0cm00b3QwblBvVzd6?=
 =?utf-8?B?c3JvdGpydFYxOTB5dXZZQWt4T1I5U2R0VjZqUEdyMUwvYlN6Ym5CTFdicWFG?=
 =?utf-8?B?ZTd0cUFLYTRJMEZYSjZCNVZOOXY5c2NsS0phMFFLUStjZzdjMnB2UzZIa1hn?=
 =?utf-8?B?a3RFak9tVnFvUHBNblBRaElwc21LK3luMTdhWjl4MHpQNTFTQT09?=
X-Microsoft-Antispam-Message-Info: HM+vcrxJp4KP3ILuFpCNAAAeJ/IOhfnwUeZkM8cHqrSQSCr0xeaQ+nGOxcV9njJR08MZFzpQ9D+5WCzms0cJKAa41ZZ2wMRUQuU5qe0Ns1wCAVkUIg5LYCudeSr92tdYLcQ2z1R6o9HuWZ4D6FoebI0843eik1GN1yGH3bhqlxKs6W5+Kil5Y07BBKDZA6Ubx313FsdZToSjVzjixyakNJBCcrrTj8b+MlkzK5hmHg4JWP4go/BSOiA8JPYBCTGRjbNY2PaU7PSgkmvp4IInZXh1cP0v+sXB6180lYLcl/I1hL9kQFRkU/lBf50QGsFvydYZAgM4KeX76kBNnM06yA==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:Cz0VP2pXaOhV7XFFYldzShqKQL2x6Gmb1sPcaZitdSZ2Rj8JwiU4KInL52EZX8/DUyJhuN6gtYKDBGdtbZ0a6tcN1qoVl0/ah1SjtfcO7xYahbLxhOfyNiz5DHt8QRESKUfkh3woiDDRFYO5wwr5XuYZ3oIwhgNb7UHt5pglu/GhxM1t1gSnfxZgia1EgcxGkqjNuRj0D9brbfMqg5pB3XmtHGfagFD7K1H4eE7TFpXiS1hb1RG+Oey3ZiwRr2H8GltJQ3XwgznHEJf8dOn/mHSxMdAqBaAfx6TN4D15b393k/lQkEcyRERUSTCrSEbG7OB5eExhmnoeEU/PJQYTMEG3+77fSDY1mNoSmxEcJOXQarM6QWMWL//KmEApcxUHpf7Qat2UxghkTCWvuDVDsNf9eb3imTBAaHdX++jWRyepZqVybQhxXgDtL4KUfJYdmUEn4IW2KFT64nYPKRJSow==;5:LAvbTRsYkzlXQp05QYr/lSIcaIg7iWhUSdILRp9+fDOYF28Ql0gZZ9pf83y9ad88Zt3FE9MDaeAl/O8quXpmjms/+4Bl31gBhrqJf3hUlsarXeh3ZVPkP8XN5nO78Ay4AakRgaq+xjSCoCUWuvSStxbExFWKTzrz+FZ84jUD45o=;24:tP5fk+RABSOn6czsBLEAqkzK/RZxyhLGScKk44ogJyphxVdsBiQktvdVC8RsWzL7uiRR1skoFReXJ3MH4KO5D1VTDZVhmqDqxgLImdXkECU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:I34JOXzqrZdgKVRHpxziP+mPvwS/12TDUsXYdl+Lct0cW7iEyGL2JXBS+STA9f585oUMmJYSzOioJ4eDP4Xvj43K6JKEuRbIQETextJM3coByIxFwz+j3NbAXTI521IW2Nf6GWzlcZbHSu6SQDhhzNInb9JbPwu0pfsbkfqHDBegPLyC790J4K/tOHWITbB2lCQ+wNdW//RPVTjSoYhgZIqGYSGeS7DNHnkEvMARDaId871QlUgSYKAjxdY51pQ5;20:Y7Xe61kQIZBJG4EkZTCWcarPeId4m7X55vmmt39DnC4C33cyBNSVkKjUlwbpPf+lC5JLic0OnDYSs8TNzIUkGfYQdNs8JtILernufalnzW5OIY/P0gTelnN05THFVl2RTMciZREWYr8XpFn70zUiL+SXjWwoMUPLMRH1KTeXw6I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:45:51.3145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58480ec-c7d6-45a4-aeb5-08d5d5004865
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use prealloc_shrinker()/register_shrinker_prepared()
instead of register_shrinker(). This will be used
in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/workingset.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c83978..c3a4fe145bb7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -528,15 +528,16 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	list_lru_destroy(&shadow_nodes);
+	free_prealloced_shrinker(&workingset_shadow_shrinker);
 err:
 	return ret;
 }

