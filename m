Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E466C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF51208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b8lX+hGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF51208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965452AbeFRJpu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:45:50 -0400
Received: from mail-db5eur01on0129.outbound.protection.outlook.com ([104.47.2.129]:26506
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965343AbeFRJpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y5sfJ/QaL+x8vGX7W70MN1TQaB+eCXDtCFWbXxuV6w=;
 b=b8lX+hGvaM5FiGOjdAfKe3BuHGwo/fLHzAOtPNj09DSn/Luw2Ci5IaNu0wtHns4sLcGepnJBbcbJ0Fx/qreYSYE1jGzxjxeWXyH57ewNTcO3MsMlWfypxyEDTVE0EGfNi05wMCiOZGF+Mw50SXoOad/+C7dEDEae/gtQdRpGNVk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Mon, 18 Jun
 2018 09:45:40 +0000
Subject: [PATCH v7 REBASED 05/17] mm: Assign memcg-aware shrinkers bitmap to
 memcg
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
Date:   Mon, 18 Jun 2018 12:45:36 +0300
Message-ID: <152931513692.28457.6486869034912069546.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR08CA0050.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::21) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9efae2b-5278-4da2-1f6f-08d5d50041f2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:dH1suN64Q+TKoqjPlVBgy0m6yYJh7F/58070/faJYLkANtkZCYxIrjDXiQjoMMIHOLKGiCOsThiqUiUwJmtpF4UnVBwyZcYnrgMbOQ4YloatKuGK+lYq3wWAZC4EDS14ISbkfc/IwXisNtg8f7tvHmFk4xU1MOhnnnxWvUIP3Rv0ZAW2sFO6G/DcNd4+xReIdmIPkXSe5Bfg6puYfCKPt8GRQ1gp85Plp4kvELmO58+VzlGd/03VS1qqlxRHqCgv;25:i43sVAtOzdocNJeR1loFG/JoF1qtTXEGxxYxXqP5FDLOGxPyBEDtM1OAqgXT8IeAcSF1Tt9HBtTeyqJCjJmeKhuUs8nnxrtQHwwRKxEuaSewMX3j+LsmN0fHFKPUB1sPuY57aJGMPF1CDg6Gqf1L7APcxcSuRDarw7TktuodB5dA60Afr6f/s2YdNBtqQKS+bvuBduAuuIJ7dCX9wMqv7fYU8xr2FmVCwZWqzVyw5N+O0kqr5WQnD83OA/EOkzYN627kidy/BNPq4lRrWSL+0+H3cFByQmcHxXHEtxjK/EelApwyjvrnbepRTei18bpFe4c133NvH7b5LCJVPzQPLw==;31:bNdfmInt+KjVHJolgTDzpVw+Sh/Ski7P4W3FyGj0nTP4zqLnV96WfevMj5VfgYatrcZ8/SNCy2u56Yy3kXg3QbCU5eW1ZlQjdptlwNaTrwUexeVhWib1S4ZtqA7c+nQ6SpEhCS+cWvUna+27ACzvn6D+AjBodVq4ZpNsjHLR/FyrRKWaoO7YFUk8Mh7/kbKukhi12EaXQ1wYsfNACltJERcJVmT+CBS02PTXQUiz2/k=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:rawNKGcP3Y1/0dmb9CsG4CovmOXuePw7/W+IXuOhhTE9+Pd1rEvQvROHmxaIxIdZ7s1oEEUFdGxpUe0I6M2r5ri2sMkzl7yAcr8VhES+awPE6h8ZQrof/9DnpEsK2C/aaTfVNktE7b5WNat+oKSizIHG/pEa9EuqtYrL2BEiSHWi5p3EHnTG3xp5hkDQqqZMMkaRYG9c2sDqQxzHvaTgbOd5JpuCarU2q9lsStwthmJ/DTMxOME9g/ScpTGgbNP9r6Joc0C9ZGniZDrkc35buofUJ0TAnSc3H/ustNMfqlhXYfHA1fZB9ShgxV2V8KF2KRkNzUCKP2fLqAb1vDI6dxdl9DMzPvvg1LFkG8cBXrH9VlyCVS5M5E9lY0dxUbFkwbmx6FJd3PqApY0lrVWwnJVPvBwPcobrhPpzKxAWNRXtZ0r+n6Jpj4aEDkUDIg48fOJIcaJdFs2pdTNk7YlKF00VqUaKgAnt0gWbkuxw2AGvr1LULhyap6LOUY4uzeiv
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329E9C820BC292FA9ED7FEACD710@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;4:pTDWdgH0s9PPtAHPUVZXqHRKzU8/1zUcc+0h/vSDJi6L5yW0l3/a3vz6GiCqsluFYM77j7R5QG4sAdWj4lHPICFVwduZzKpo9lwZoODkCOkuUEgaQHg+Y0xGAF2PLl5sKOg3P8/XdH5+ISLkb3YeDAvo/ity2RPMBjcA0/cmbvdStstLaCS+RIL4IY4qVxzg45xvo2uNYuVca0DqBpfl46zNfvsdene3ujjG7f1iKXJ+zOoeyhB7nPZUe0pHxG+wbbSnvtApvEORp47aq3CL6RbUZJdF/pN0YEWqqL80lEapboTQ/6Vq1dfHjjAE7MvVob4JkOMGoHB7uP9msmJ6Rqvabt0+mcc19S/9Fer+dpX6+SU/tpbUwzD2X1FnAUpC7rEHvR2/P3Q6Icair09YQz8d/8BFdN2YtfLZIGPR8KEiCYONrR/xiB8gkPi8TTEmaxjshsDBLqPwmn1+xicGZg==
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(396003)(346002)(39380400002)(376002)(366004)(189003)(199004)(6636002)(6666003)(61506002)(316002)(58126008)(68736007)(106356001)(105586002)(230700001)(47776003)(305945005)(2906002)(7736002)(7416002)(55236004)(66066001)(5660300001)(33896004)(11346002)(476003)(6506007)(956004)(386003)(103116003)(59450400001)(3846002)(6116002)(53936002)(97736004)(186003)(26005)(39060400002)(9686003)(52116002)(478600001)(446003)(8676002)(86362001)(81156014)(81166006)(8936002)(50466002)(25786009)(23676004)(7696005)(2486003)(76176011)(16526019)(486006)(55016002)(575784001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6RVpxOXEzTHlEU1E3Tlp1OWs4blRSZ0hC?=
 =?utf-8?B?dGhpbS9GK3dKdEVXUWZBMUoreDNvRWEvRFladm10NVJpdUNZdjFtR2hWVnlj?=
 =?utf-8?B?SytGUjlYM0liNXJmYUMvODFONC9CUHptQmoraUdUN2dGN25odXJGMXZMajFn?=
 =?utf-8?B?ejBYUXNScEhBTS9TT0MvZFMwZXo0ZklsQThGMmcydUtpM0s4eE4vdERoUGtB?=
 =?utf-8?B?WURtdHFSUy9FTVdKa1RLZ3d5ZnhCYU4rY2tneWRReVdKRTRYSUI4clZIeG1D?=
 =?utf-8?B?VTY5cng5aGtLWEIzYTBLNWQvS3ovYzVwWTVoVG5jalZrazNNVkI5SmxHUTZ5?=
 =?utf-8?B?MUxna1FxUXE4K1ZscXM5ei9HaUIvbTNQTWIwc2dCT1FwVjY4WU0vZE4zemt3?=
 =?utf-8?B?RTdGZ2Q2MTRjb2ZnQSt0WVUzWFh4MkViZjBOZVlqVURYOEVLWWkrY2pBcmdF?=
 =?utf-8?B?aEwxWC9QRVdzMDhiSU1GZE8raXUwQ2lrYURmZjhZYzRLY2VvUzg3UFE1ajU3?=
 =?utf-8?B?WFc2QVI5QXJWa0YvcW1XMm1pMDdzOXl1d2EwVEpsWVpkVUJBT2xTUElVM0pL?=
 =?utf-8?B?SWF3L01IM0ZTU1hNWEJGL1YxWFRCUkhFSCtibnVaTExYakR6SE5TYXlVVVNW?=
 =?utf-8?B?ZDR5ZndvYUl1YzJ0R1FLT2pPa0hELzFMMG9HS0pFM3RCMGpNbFdmQ25pZEJv?=
 =?utf-8?B?VXdQMzZjN1RhZ0Y2UC95cS9lR0dTSW9BUUJORC8zQXBiQW5yb01YSTdaU2pY?=
 =?utf-8?B?ckVmT0pWcWxtWWxYK0U5UjlGeExKQmVzK1ExUmZaYUJtLzVQNUoyM2c3VWNL?=
 =?utf-8?B?Q2NLdU4wY0hvRXJmUnRZWnVSWnVsN1hYai9sTjNlcWZsQlQ3b01ESGpVQUFm?=
 =?utf-8?B?aW9KRXRLa0hhZ25HTzA2djltY3dhMG8zNXlLZWFjLys2Qmd5MVprZGowcGNu?=
 =?utf-8?B?eUQ0T3lpaS8va0xqRytaOG4rRmF1Y2F1UExKcW9IQk9HUEVEVlBBZGRBRW5t?=
 =?utf-8?B?UVFKT254bjc0SHZ2NDRXakJyOFpxcmEwaUh5MjNjUld6UEp4aDN5cHJIVVRR?=
 =?utf-8?B?TzZ6cHZKWVpwUzRGZXArSG5pWVlvZkRMRC9FRVdxYllPUVNTTU9KUFZncDBI?=
 =?utf-8?B?NHh0NkZQclIyMGFBbnVDM3JBbXlsTVdWUWlyQ2ZJSU1LcitEZVpELy9jS2tp?=
 =?utf-8?B?bmE2R2xNZzBuWWp1NzkybTMzcjdHV1pqZmdmdVI1QVZEekVoWkprTHljT2h0?=
 =?utf-8?B?bkJlZ3VYQ29Pc3lVSFlHeUQ5ZDQ4TWthTkhQeGdkL0FKNlRDNXpkNkx5dE5D?=
 =?utf-8?B?WjBYSHQyRzQ4TThTRVpSWTBHblFjQ0hHdGxTUk5tNkhQWmNhRkhtTkhPSkxG?=
 =?utf-8?B?Q2pFWHo1RUM2dDdpMlhQYU9RNkgrRlVvYUU4bVhTamw4cFR5M2l2ZC9VeHNn?=
 =?utf-8?B?ZmxKQkVrb0JsMVhqSERYYW8vMFY3MFNBQ0hHV1Qrd1pEQjlvamV2WXhkWFV2?=
 =?utf-8?B?b3NybHBMYU43dTVhR1hoSHg5Z3FPY1NMUHZaMVM1N0tPRXNRQ2xsNjZEQXZQ?=
 =?utf-8?B?eDA4LzVMU0d2K2I0YVBpMFljelF0ZTVvbEQvTE1tS1Bzd3htdVQ0cXRLZzU4?=
 =?utf-8?B?aGtGcVVjc21HQjlWMmw0OGJuZmZYNHVqOVdqUTJRUVpFVGtDalYyaUludUYv?=
 =?utf-8?B?M25VbkgyaFB5WDB4bHUybnpkdkZvL2ttS3BRZ0dhWS9CZGROS2xwaEttOXZp?=
 =?utf-8?B?MFJzTmhZanI3eWE4dklmeDl1cHZUUnFPRGQ1dUZsWE9DOHJsYnFwY2YwR3FU?=
 =?utf-8?B?T3d2eVhHZmpyTXlHQXVSRjN6MmFHS0tmNUdRd1FGUGJPV0o4Y3ZWWXdiRVVy?=
 =?utf-8?Q?Vjux2P+unYodQ=3D?=
X-Microsoft-Antispam-Message-Info: 357CcutTJMEdpbnn590j2ec6nOiddTT9cODgr0wkBrBenBTrcnyVlo/szFRmqFDbSj3L5pQ3vVKQzEjqUSk5RLs30dzPlRE/QYAUzvr3SttRKdlqkAE4DBep2dsO1Qq8ZHrJfxUKPZos7AUXqB+9X6+HT4CbwC2BVWqa35rngk8C0RUZA3Km2qytzixZCkiJ
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:RHNPUI8Cxh92LH1zXw/4WvKohlxiqVSvBO2KrQPFTMXlaxO3L19TUbzBUq371XrXFg6ECnz/UM/NnYlnikRNentVJUVhnumeC/iFu7Dq8fPFfdX4UkhyF3EqHWaK3hlfkYQAcYsvkzIjZB1oWr5k7mmWLbwuRAsn7vcr+AabPayZPyqzuspFkgyPQDsfHcqWHeFy6N+GYXzgJ5Ifi30aiC80XTRolZFUctGcSK53QxX0/JsJrF2WWq9JwEF4jjvyqknSo4ZiAjIOItLGvCsXj4QaYMEQZisJ0PnSRFsc8bdWyVVFp8OwTZZs99IozIHay+5GXq8LoYXBhFEwXaQa1dh8GTc4EqubmXWEbbmuZcgQqTVU/GHaV8Ttbqs+dR8FLzkFhPLHYrCZ4GSBRnH/y2aumoujFJIHAdZ7Le9sVmhyQ29ECj4B7y0jOPVZXn8ryjxsAHbvsl4zWJA1AoX7Jg==;5:C3R15KTO65oMppxXT8JJNTxSUpEYOPzUWoPTVbuq4RRE8eOAwYnJhE3o6pkhycc58y6nMtOibcHb7tweLt6dss2MTRWcSzfJRE0Cf81+HIohqIWXO9EQe4/Z0vE0FBDAiiY/e+kn6TYuu/+orUvZmfrB7VeFf/nitx0aGUKVyIg=;24:cgFb6Qo/F+HJKXNR7UNPovj1grdKmztyLicSPVDeA8IZa8v11DAw0GN7xZq1nraBdn7x78a8uJEq9Fy6Y8eO1FYFAtsk1WtUNNp2Dpkc2uA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:QMo0dcqX0IpYw0AZ6hysASqq/uc1AVrcqVjSlmaXJriJ33JkpbPQbzlWJfQftsmHdR0RMT2Q6Sp4nT5IxcGE3JnEhWNa/MiAg+SzdoAUly6jl62iSNSjJXqvjXJo4eRy6BQ8UW6bkchOP/R5k5ht0L59JCm8QENchMjRhElimraqkhhzsX4kgC9ZQvLj3XEzegZ1HDIccgQ9VT9C6yBxSTdvDk6VM4q4vOsgxUkxFkkIz8xA/BzQ25gIyerSD16k;20:Ls1xW6F2olvFnd7K279UgceYYZaFEfXW2oLGaz3XI8TXOqr8CSXABOTSbgIcnm3xwooN7Ddw5dat1YB/N+mcCNxrB/+v05OItuxgwKUyev/THF8cPTRcYf/Wy7CVGuwd94OpuHzvOHJVLsVZC72Vc1tB4H67gyslAqWlqC+HZuc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:45:40.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9efae2b-5278-4da2-1f6f-08d5d50041f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, every container has 10 mounts,
and 10 cgroups. All container tasks don't touch foreign
containers mounts. If there is intensive pages write,
and global reclaim happens, a writing task has to iterate
over all memcgs to shrink slab, before it's able to go
to shrink_page_list().

Iteration over all the memcg slabs is very expensive:
the task has to visit 200 * 10 = 2000 shrinkers
for every memcg, and since there are 2000 memcgs,
the total calls are 2000 * 2000 = 4000000.

So, the shrinker makes 4 million do_shrink_slab() calls
just to try to isolate SWAP_CLUSTER_MAX pages in one
of the actively writing memcg via shrink_page_list().
I've observed a node spending almost 100% in kernel,
making useless iteration over already shrinked slab.

This patch adds bitmap of memcg-aware shrinkers to memcg.
The size of the bitmap depends on bitmap_nr_ids, and during
memcg life it's maintained to be enough to fit bitmap_nr_ids
shrinkers. Every bit in the map is related to corresponding
shrinker id.

Next patches will maintain set bit only for really charged
memcg. This will allow shrink_slab() to increase its
performance in significant way. See the last patch for
the numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |   14 +++++
 mm/memcontrol.c            |  120 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |    5 ++
 3 files changed, 139 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d9e38a7c0c05..40401a73000e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -111,6 +111,15 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+/*
+ * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
+ * which have elements charged to this memcg.
+ */
+struct memcg_shrinker_map {
+	struct rcu_head rcu;
+	unsigned long map[0];
+};
+
 /*
  * per-zone information in memory controller.
  */
@@ -124,6 +133,9 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
 
+#ifdef CONFIG_MEMCG_KMEM
+	struct memcg_shrinker_map __rcu	*shrinker_map;
+#endif
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
@@ -1225,6 +1237,8 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+extern int memcg_expand_shrinker_maps(int new_id);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b36229bc2df8..f80a2d1cd880 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,6 +320,120 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
+static int memcg_shrinker_map_size;
+static DEFINE_MUTEX(memcg_shrinker_map_mutex);
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
+					 int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+	int nid;
+
+	lockdep_assert_held(&memcg_shrinker_map_mutex);
+
+	for_each_node(nid) {
+		old = rcu_dereference_protected(
+			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
+		/* Not yet online memcg */
+		if (!old)
+			return 0;
+
+		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		if (old)
+			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *pn;
+	struct memcg_shrinker_map *map;
+	int nid;
+
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	for_each_node(nid) {
+		pn = mem_cgroup_nodeinfo(memcg, nid);
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		if (map)
+			kvfree(map);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
+	}
+}
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct memcg_shrinker_map *map;
+	int nid, size, ret = 0;
+
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	size = memcg_shrinker_map_size;
+	for_each_node(nid) {
+		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
+		if (!map) {
+			memcg_free_shrinker_maps(memcg);
+			ret = -ENOMEM;
+			break;
+		}
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
+	}
+	mutex_unlock(&memcg_shrinker_map_mutex);
+
+	return ret;
+}
+
+int memcg_expand_shrinker_maps(int new_id)
+{
+	int size, old_size, ret = 0;
+	struct mem_cgroup *memcg;
+
+	size = DIV_ROUND_UP(new_id + 1, BITS_PER_BYTE);
+	old_size = memcg_shrinker_map_size;
+	if (size <= old_size)
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	if (!root_mem_cgroup)
+		goto unlock;
+
+	for_each_mem_cgroup(memcg) {
+		if (mem_cgroup_is_root(memcg))
+			continue;
+		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
+		if (ret)
+			goto unlock;
+	}
+unlock:
+	if (!ret)
+		memcg_shrinker_map_size = size;
+	mutex_unlock(&memcg_shrinker_map_mutex);
+	return ret;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 /**
@@ -4253,6 +4367,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_alloc_shrinker_maps(memcg)) {
+		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		return -ENOMEM;
+	}
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -4305,6 +4424,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
+	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f9fe0915d71c..51c3d1a0fc91 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -182,6 +182,11 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (id < 0)
 		goto unlock;
 
+	if (memcg_expand_shrinker_maps(id)) {
+		idr_remove(&shrinker_idr, id);
+		goto unlock;
+	}
+
 	if (id >= shrinker_nr_max)
 		shrinker_nr_max = id + 1;
 	shrinker->id = id;

