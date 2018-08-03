Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973BCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1AB21707
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GxznxDWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1AB21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeHCNAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:00:45 -0400
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:36919
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeHCNAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYthdZ4Zqxt3VqaCjhjjJ0QffjUfYSZ8hJ4iUsPEEZE=;
 b=GxznxDWHXp/nslFO4p8MQZngaP4dztHG+LaZEWzMxvw8Ndxmb7vy0wHNU1/UREeDpLwXS16H5+mPnuE48eVX28V98aDYkOnzuxGuxB32XR2N9RzgmLqP29Mjjdj5uPlFGG5NAIGSIlnPglFh0h+UBTHoQ8jE5TQ7Nb8ZroaG+4M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2024.eurprd08.prod.outlook.com (2603:10a6:4:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Fri, 3 Aug 2018 11:04:45 +0000
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to
 do_shrink_slab()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, willy@infradead.org,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org
References: <47c34fad-5d11-53b0-4386-61be890163c5@virtuozzo.com>
 <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
 <20180802134723.ecdd540c7c9338f98ee1a2c6@linux-foundation.org>
 <8347.1533292272@warthog.procyon.org.uk>
 <5250d5c0-0d26-260e-dc39-227b8e355a1b@virtuozzo.com>
Message-ID: <190b28da-aca8-1c72-0933-94de08a48019@virtuozzo.com>
Date:   Fri, 3 Aug 2018 14:04:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5250d5c0-0d26-260e-dc39-227b8e355a1b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0007.eurprd07.prod.outlook.com
 (2603:10a6:203:51::17) To DB6PR0801MB2024.eurprd08.prod.outlook.com
 (2603:10a6:4:76::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87496ae-a4e6-4646-1375-08d5f930ecaa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2024;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;3:nv7sxbtY4jNawauzyxIAHREOYBp7ornzTsHDQzQVmQfwUiKFXnA4IAb9CEXk/lqfrufP/+iihk4SJmUuikJLNqw4FvQztzA2OpQaRLuiWdN8KggTLpaaBC5Dtm0K9pj/t9YjcfRfZk1++1gbnnPJkTYoVch75fT5lM/M+lNBcgmTHGNynLlHVOpQ3K0QaPCQqLBSDZBHCZWJKYVShZE0SoBjKhLKwFrO9QA5Z7HeeisWUdYaDJfL1QXR22UCTfFV;25:x+if32J8iqsFpxgYTS7nGYTiU2YedWFouRF2XVsAe7xpxHSOf/BKZbhu422hLCtf2U8FU9qpGzo/ZmAqgPpxJ2h5W8GP1u1KtTuA40RQc7TL5kpKLR+H4CT92cLOukGNLUqAuDlcfsROHH9wBwWIVekv6y1kmtCZD4lTAXkQ2TCdw3Ew8u9irNw6WTGDjnmz+Wpxjf1uYaocPPFRU3/jRRI2BFJW9h49N1cwFG7tyfDPz1cByGu+CKmLQP8YcSzwqh1rPQPOIaESuHK0EqAqcCIEq/baj2J3wOdArjGz68AfFvRNQturuVJoBv+w4DAbOTFIwmTW9m0RI25cdT4SzQ==;31:D1aHksOP5i/MDSEP3Fb0+X3oSb76kT8v+RBVQhAkhl/XZiWBdZ9Z+jf3HmI+dIlmI1aWxaYpSqC8iN2+ud8oq/KGgmsqsYdktfHMlhkRfnzdFgmGKDVN+IJhuzmwQgaAbBKla8jwGzs+ctQsN3NSUJatrcCwfdYRzFYacO3XDD9350pJkbkWKN+nMBGFVOXX4pTpmzvQkPgGEOWlA9GeUJX0F5STXGBmWceAh/JXyCs=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2024:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:ArNWwORkWyq23zsl+0rykowv/MTcgNNKutGdbovDHDorRhLNB1sMxna8sMu9auE0WrW1Zfw7ZmOmTeBkrDI73rZWk1/mqpvfru+OIpibgnZMciiBn9I090DA5k0hJjM0M3U8x3i04uEOf8Owmf7sl4mr/w0qNl/KHDQK/9m2DvnjjQmQFuDCxdgQdH5Ogo+6Jb/57L08Bzoj1I4y4pJW/iJdbvsQ+8wtg/9S0eJZPk4nGH9aDJPIMor28VUCpy4mlFnxurQRBYfzoQTokyxcYN80ZcaRjm5D7YMbiJQDVHF2zvEJSdZr1byAsP5nln0fwB+G5QI/7OfNSIKF1xgjoBHH84HdaUXRK+gaaaUi/K2+xtS6ckt95m6M+qXzOVpxDB/a4vlZwTyreRy/mNI64LRw3aguPQFicv0CPz0s5bpALk3Uz1nYz0bhGi51qL+KkTPi1p4pr8MLOvZnkTXyCrskqTzcaoBEOVxb1V/aECQilXO5K0F1RZsUGU5/IIBx;4:Wu1GBGkOi5wzXOL/kYLfw3s/LXeZsq0hog4zp+SyNAInZ+j8+v/ONG2CcHX0t97N4Z/4ohV4eh4AaN4dQBR3wkIek/s/8Lz/u1jRCTtrqUFEmLk/rvnfOqFemtz+lmOm/vGBfpdStkE8ENZUynlp3WjNgVSq3lS/Tmf/GvLIoRA0hZJWvrD2u9EN9oMKocevy1/ktsdby6YkONd3l1WAdq57E9RJlSmgQc9nB5wRq4nJhtVFbVhfPrr0/Z/LNhRDgggFfH64J2PLBTzfjxX0nESEDjhZX7/uhZkHFEjYstJ6+LubC2ZYvEGNryTjqPhGo9HQFhhqI+wxUePskx+HyhVAdzvVZysl1wGPcoj4GbA=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2024B04CF0207D1AC34C19CACD230@DB6PR0801MB2024.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2024;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2024;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(81156014)(386003)(36756003)(76176011)(476003)(52116002)(23676004)(52146003)(81166006)(2486003)(6246003)(58126008)(16576012)(53546011)(53936002)(2616005)(956004)(486006)(11346002)(446003)(186003)(316002)(16526019)(77096007)(50466002)(26005)(97736004)(93886005)(39060400002)(5660300001)(4326008)(478600001)(8676002)(7416002)(106356001)(66066001)(8936002)(7736002)(230700001)(47776003)(65956001)(64126003)(65806001)(68736007)(2906002)(14444005)(86362001)(5024004)(31696002)(6486002)(3846002)(6916009)(305945005)(105586002)(25786009)(6666003)(31686004)(229853002)(6116002)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2024;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjQ7MjM6cVBLd2RlN21FUDhvMEYvS0ZFZzFvNFRz?=
 =?utf-8?B?bXkvczJkY0JKMGU3Q1ovOWQyb1cyWXV5cUt2KzF4S1FrYkdNYnM5QnNkNWxu?=
 =?utf-8?B?NjdBbUlYandjZVlQRGYxU0dEZXlRM0pURS9hS1lJeGpqbEZHVTFHd2tCd0k4?=
 =?utf-8?B?dG1WUTYxeHFuU1l6em01OWsrODVZd0s5YmVQMWVHWnJxZGw2RnFndXl6R2lI?=
 =?utf-8?B?Q292Zm9EME5DYytWbmxrVVlPUHRXNkJ3OU5qTWNmYUNEN2NrbUFhays0aE96?=
 =?utf-8?B?Ri9KSTd5Sm8rME1vdDJpSzJ6K21ac2NsQXc1SEFFa1ErS0ZTdVFHVjFaL0Qy?=
 =?utf-8?B?aGVKRjRxbGlldDgrcjA3dnpUUlZ4eGtId29ydjJIbFV1azc3TUQ3UUtHZkFI?=
 =?utf-8?B?L0FodndaUjU2cGJBanRuMWRmTXg1ekgzVHEyTVltMkhnMFA2K25mR1RBS0hq?=
 =?utf-8?B?S1cvVjRrRm5hckZwTXlEcmJEWklHZ1N5dGV5MW96dStoL1ByQlhFaGJEMTJr?=
 =?utf-8?B?NzMxeE9VRDJCU0wxYTd5Y0EyWnBGZEtWVHBrckFSS1VHWlBCbVNBaUUwc1Ni?=
 =?utf-8?B?eDhGOWRjNEtWQVQvSjhGUTh5MndCVVZ3OEhTRlhLL2h6WlVlU1p0RDk5UkNo?=
 =?utf-8?B?SmNydzEzY0RGL2x1VnYxZ3RBaGw2UTVIN2dORnZTTjZSK2RBdklYS3BuTTZJ?=
 =?utf-8?B?ZHNydE1aQzVNOFhZU0xycUNnamNQUUhZeDh6c25NOVZpTWJIMnV2ckYyQ1NP?=
 =?utf-8?B?Nk1yQ2RhSHlxc3BsR3NyT0NQc3B1WURNSUMxTytEd0tOdFd0cGZ6UG5RNjRF?=
 =?utf-8?B?dzduMGtFK2JHK2hVMzE1eU00TTlmRFEvSjdQVlRZTVNTYnhoaVJoeGRXNkhw?=
 =?utf-8?B?eGFxa3VtaFloQk42OGhaNTRnakNpZHhFdzVzbGxObkJlMWRxV1pkSi8vcjR0?=
 =?utf-8?B?QzFlQkY3SWNsTU43SDdMVktVbzBZbXpEVWY3WXA0WDdOdVVIUDdRc0FnMncz?=
 =?utf-8?B?ZVAxU1MrVU5XbVVzeGRNajRoM2pZSHgvOHFvQVNVNFJZbVNsT2dRNlc3anlM?=
 =?utf-8?B?TjRUd2RjZTB3YUtXL0ZQVGJpYUdBTTJkZWtIcDBNMGtMMy9KUkNvOTQwSTgx?=
 =?utf-8?B?YnlKcmtMNEE3S3ppbDJDdlZYemhrVkVrTWZLejQxZkJVenhrbDMzREhEWFZV?=
 =?utf-8?B?bTdSb05HRkQ2SDdRSUxYTmpIL0t0QlczVHArNnJTTTRjcmpkV3duYjMwdTFr?=
 =?utf-8?B?amxaQ2xJa005L2crRkgyN0F0Z3JOWlVBUUVRQmJwTXB2bHVwN2tQL3p1dVZZ?=
 =?utf-8?B?aHVGSzZONzRaODNRWThaNzRVbkQ2WkJYY1pSQU4xOEpLdk42Z0xKMXhZVHor?=
 =?utf-8?B?MzdEdzdBWUdzc3dEcHpzSWtRcUhCNzFBQnpDdWRaNm5nMmx1dUJYZjhaaS9K?=
 =?utf-8?B?YXBuT2RleWdIa3VFeWdoU0YwWWNRU2Q3MG1HbUREN3doS1l2bEZFY0tiZ3NB?=
 =?utf-8?B?ODRkYkZNSFJpQzNpSDU5SnpUZ0NwWmFIQ2VhSTlzWm5Jd3pMUjFRUmtsZTlN?=
 =?utf-8?B?S0xLcmcxYUJ6YUZ2ejdPamoxaFdiN21tajhrbmUyeHFmKzlDSzkzZTdwbDdp?=
 =?utf-8?B?R2hxLzFYODNsK2hHY0pRblo4bXRCaHh0UkpSbXJhNGMrRXQ5d0pOblFaam9Z?=
 =?utf-8?B?Tm9VclJocFFtV2R1VGtSUnk0WWhSWm4vc1JzZFlhM0hIUGxDUXpOc1hKQlJE?=
 =?utf-8?B?VVUxOEhJRWVqMVF4SnFOcUZOOU96cUpQWUJyN25MRmNJckJ6a3lzQ3J4TnRO?=
 =?utf-8?B?Qm5nb3lsVDZxbVhiWVJqa2RsMkg0SlF6SWNHd2ZtUWNXclc4NGNrOEZSRDhO?=
 =?utf-8?B?SWtMaDJVWU5DOFlpMlhmY1QwcmFSSTN6SXZFdnFTZ0FlazA0dnlvUDZCSTB4?=
 =?utf-8?B?bEU5bjhXaUFGWEw4NW53ekx0bUUyQVo2d3Mrc2hDY0RoUVFJVmVncmdrOEtz?=
 =?utf-8?B?MS90MWYyYWdScnJYMHg2NmNjRlRCMmNuS3dmaXpXYjRLTUpQTGpBeksvbU40?=
 =?utf-8?Q?/SzbUo=3D?=
X-Microsoft-Antispam-Message-Info: kp3lislG4U10WGs9kX5rUnrpkaFKX6VGA5An9aIbDP8WdgYs68M8Z0skmkkqyJ+4zuDLaEx47mGoPD8lCT+N1SGMESD53Bsxu60cE+3AnQRazU2RuTX+P+xkHMJRCcE001b7i+fTLPPXf0zUArKeAFZWvJHfw0RnvrJT0+iVm4L5t097eLC5iay9UR+UN9b3YBBcosGb682NWyLqAE0Wmvze8IDTpBTEHi4mIb7H2prBYz8ILXb2/eA8JuSh262LyuRuZo7aLuTTVk8Q2/kE0jvAGPmRlYm5vHSS16h0zFhZf4nQzA5/GZlWdCX5CBibvcaFIxUPSFG9aDBNySx/RqDrKtfQde2QQhxR82oUl9Y=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;6:o7HQ7V3kmrrfU+WfIhKFNbNe/aC5HIGK/pfv7dJQGB4cbzM7Xm9CnH9XzsRe9r3Cxr6OLv97hHAdyEDzZSWRARa7OTK/bGBYsr2kNh0ySDp4onXwLTXzw2WwkG4UGZB5MjIhOxLTfysDhKwzLZMkAaB7ew9Jd/P8+ULcVPg5vLjvexpmyx/vQpJclgxHXwIHT72Jp98KVb9QPZh9GFGuISueuaT2rfRlb9E1dOO5G0K6Fywae/rtzqUY2IP50HyqBJFsq6gZn5GfqVbxVaed1fKXeOBFRTDVMH00OX008WHv/O6Tp3/bkPUq53lH0+Wg9PsH2U9673/cV/S/Tuta7u7I05OoVMYO4VyhiyzBYCcWHEsu1Oc1E8vQEP8xcFFqq6xlaEyHddJuov9Kw9kZJYyWQlG5xToHErxQuYRsukWpBR5jeKf/TTx7+lTazWBe5uqIDfV0+dCrVNb27rHWwA==;5:KMUNfk7sQT1YBhumUhdTs2mF0sL34rYfeuccm96D3yPJhdyWPst5Ae9hFWR4MFj/HsbQ7FhJH/RbGHzlFCGtYE2FW35dYJzhSk0Z6GU9CZ/OL+x5g6+GT7pvB9Vs4WfP5FJzYemVL8Dk6/+srD92Y3dqKmY0D+/gYwGYlud8+PA=;7:W4oHEWfG4FZKntYQIDLq5jGauNGUBLSphvvzsBUBQV/1pmrEXWOpArPpY39voKr7kD9AQ6y2v+FbFc0y5tQpZlq3kVzEVFGzmaUh0S7CZ4z7N6K3Gn6lEcqCoVVFxuUv5UxblSR6ovh9gvTWEmCwGAwIW91b7C0vuHd62AjkFK4GJA/x5aVD2lj9a8NVNuqoKurSw/8vOpgZxCAYxc5aNMnEhz8sNeJFqPcUKv5OFR0c7GIz9idLDnkcOwve/Aaz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:c/AhSmdhluuftyZgXKI0X7EjKnYMOZoxwocIb32OxD6yE0bxEXBPoFvJ9kf60VBEol2A4RoNDOEeANDLsUim+G+ENaKmYqDP/WGwomWyrekHTCrY2ZcLkZfvCQcnFf9SPJVmUWgaauTbCoP3jVEPMgJKu+0UALedCuTfLbH5xSY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 11:04:45.7820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87496ae-a4e6-4646-1375-08d5f930ecaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2018 13:59, Kirill Tkhai wrote:
> On 03.08.2018 13:31, David Howells wrote:
>> The reproducer can be reduced to:
>>
>> 	#define _GNU_SOURCE
>> 	#include <endian.h>
>> 	#include <stdint.h>
>> 	#include <string.h>
>> 	#include <stdio.h>
>> 	#include <sys/syscall.h>
>> 	#include <sys/stat.h>
>> 	#include <sys/mount.h>
>> 	#include <unistd.h>
>> 	#include <fcntl.h>
>>
>> 	const char path[] = "./file0";
>>
>> 	int main()
>> 	{
>> 		mkdir(path, 0);
>> 		mount(path, path, "cgroup2", 0, 0);
>> 		chroot(path);
>> 		umount2(path, 0);
>> 		return 0;
>> 	}
>>
>> and I've found two bugs (see attached patch).  The issue is that
>> do_remount_sb() is called with fc == NULL from umount(), but both
>> cgroup_reconfigure() and do_remount_sb() dereference fc unconditionally.
>>
>> But!  I'm not sure why the reproducer works at all because the umount2() call
>> is *after* the chroot, so should fail on ENOENT before it even gets that far.
>> In fact, umount2() can be called multiple times, apparently successfully, and
>> doesn't actually unmount anything.
> 
> Before I also try to check why it works; just reporting you that the patch
> works the problem in my environment. Thanks, David.

patch *fixes* the problem

> 
>> ---
>> diff --git a/fs/super.c b/fs/super.c
>> index 3fe5d12b7697..321fbc244570 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -978,7 +978,10 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
>>  	    sb->s_op->remount_fs) {
>>  		if (sb->s_op->reconfigure) {
>>  			retval = sb->s_op->reconfigure(sb, fc);
>> -			sb_flags = fc->sb_flags;
>> +			if (fc)
>> +				sb_flags = fc->sb_flags;
>> +			else
>> +				sb_flags = sb->s_flags;
>>  			if (retval == 0)
>>  				security_sb_reconfigure(fc);
>>  		} else {
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index f3238f38d152..48275fdce053 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -1796,9 +1796,11 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
>>  
>>  static int cgroup_reconfigure(struct kernfs_root *kf_root, struct fs_context *fc)
>>  {
>> -	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
>> +	if (fc) {
>> +		struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
>>  
>> -	apply_cgroup_root_flags(ctx->flags);
>> +		apply_cgroup_root_flags(ctx->flags);
>> +	}
>>  	return 0;
>>  }
>>  
>>
