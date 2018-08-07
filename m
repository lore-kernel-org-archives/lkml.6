Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55295C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245C21470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SNitA1nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E245C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbeHGRxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:53:35 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com ([40.107.4.138]:42249
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387578AbeHGRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjLeLihaI+2XAryE8IBKttfF8XLlJtjoquTPBZciGHM=;
 b=SNitA1nHzY+fSEk9kgdqk7FWwpMkmXzOtEhwtAd0CcDs+sd9ztZR5m15PJSdfDU27KkAbnisvmN+ziOqepMIXj9iwYFbOavOKPcS9vub018J6Trn2+pZIYxfZhJrlvHMFZnGyn5uveZxzx2LhAuWG9eHoW2p3Ur8SzbsS7NCsoo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2030.eurprd08.prod.outlook.com (2603:10a6:800:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 15:38:27 +0000
Subject: [PATCH RFC 05/10] fs: Move list_lru_destroy() to
 destroy_super_work()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:38:23 +0300
Message-ID: <153365630328.19074.5326096793225967868.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::42) To VI1PR0801MB2030.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 535b2c34-803b-493e-31b8-08d5fc7bd3f8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2030;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;3:vP4s6+o13YMo+jE4eLKJudDTNTpU3qf5LPU0PDe2VBHt0aLjg0ojRu5/V7+QBsHK2PZIoEjOxAzzj7Gw5kGpgugYwL7L3GU9ortWVwNega/CD3XOC1T66o99jtBsXe+donK+VZmhdR+oTbURZdaZiDPwZsQRqaiGrjleUlTNd5z1pXKXPGQKpeOFPNAcEPflWysy4M1aK5LvOBmLdhmyI1Cf8jjowy0ziZ3djy1BlNf9h2NidAIOEYHZ5P1TFicF;25:8yKSQzcuV9rzdACbV4nlke5ULHDs+ZbX93ih+bUrOQz/dk+qBlL4akeSlT2/mrlcXW2lRk6dbnskGC3439r32lBBmuxcN04IYojhwBOxXBiU7Lcmebr77JJw3Cb5TCAe3CHzm+JcOMlIwQTa0w/PGau3/m/N4hV3St2A1Siu/koKSItPYCjNA4QopwswkR2ShkDo1plN5zb2Nv7dCHUc+20XtIlNd56OlabdqORChLMl4NGBBYedVK7pUrgckw2RsDGipOlyTvfRnafko7IL3aBCaYWAzJoeN43xUhZe0WkOdOjWxkghthyly1xK98QOx2W7y64RpfrQHTcgaUZjKQ==;31:/f3lgy4jc5cyd+4vrLuCoXT91qEaaX+Y+mlICZBXIG7UxgBuY/xEDeT7HvRzYMJ5yMRigfRd1usyIF6YBxu6uTshDqrLQVOTUhfPOIrzdoxH50WGUQeh4GpEY0OXjo3IysOylhwYUBPhQGYYLa4TmH0JKAivliCzS31Qn6Aufl/DjBpdobmAyv6w/1iShaTnUH/+1dwZ0+JMtrWERhXhKrPn2YtWVeE8YAHHjQDgmKo=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2030:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:Bdg5aKVsoEJoGqoyQfmkr5d0uJ6D+L7+6USasHsbsCHiSYliYDmrjXevwubxlPiHT49rHjQacchrsn77R+iNwfxCaI9hYSRsO4Cp2gerNJqd9RRu5sqbQ/zIDnzLLmuD9hDMmVHELHPUJrwnWEzH//DOZ7pCTQoqdRSSyZvWKAxj1I6FcEt8oYYAuVECulODhOXF5YDpcA26D7iKnHsk1lp7tk+Po5lBl4ZEh2eYVW/bL1a4Jsw6NU+YUNWnReUphVSEn/5tpAiNQ31kJox83zHJHdCb+ymOCqn7uiweZCyIaP0qNkElIrmdu7oUgwqNCCvw5JFpxXN0mMdt/lSIjiKqCVrA+KoM3z46qoemA41rWAJuYiHrr7oI7V/z/1vT1QAwD5Uv7OvKkldkn4M5onPp2JpDB6GFKZARurpqhrnjuSxviGgRCLZaxPXiVeFqUCXZ/8PKUBFnjiGCJa/dECWvP2TmH0w0MgaJh880KE5PCok5PiGq22/Fu9OI8kPQ;4:BqeWMkVFM7T0yae1tktwRqUBS9M3hV1bjU64hfWF0nqlnY9Vy1M9Sg4mxFkLvgYOsob1QkL4bHnqYHwLhnz9846qOiudwww0znBAA4bPqy7EMrfeAjhEUpBZUvtvufSIaKLlwLDHJUPqttYAbgKVYYd7YLJcISF4jN5Yxh955mlTXMBMPoG7Ifo/9vQMyzrQW1lUi7rGR60BMmlcshu2urCVURJ/WVB8VOc2AjRinHXSIrKkzPksnlvIkKS5ExJana6uwQw8hV816bI7nu6fDeeHzt6iyVeaVZMylGwJlqJKuLXUbnWYTd10MlxiB7dl
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2030D9858DC64C4B9E14AF73CD270@VI1PR0801MB2030.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2030;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2030;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6506007)(16526019)(386003)(6666003)(7406005)(7416002)(106356001)(105586002)(5660300001)(97736004)(47776003)(66066001)(61506002)(55016002)(9686003)(217873002)(26005)(14444005)(53936002)(39060400002)(956004)(486006)(2906002)(25786009)(11346002)(446003)(186003)(476003)(33896004)(478600001)(50466002)(305945005)(3846002)(6116002)(8936002)(7736002)(81156014)(8676002)(81166006)(230700001)(76176011)(7696005)(52116002)(86362001)(58126008)(316002)(103116003)(68736007)(2486003)(23676004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2030;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzA7MjM6T0NtUzM0aHp5dkJNZmFObFE0RURwQ21m?=
 =?utf-8?B?bEh2TGliaGJWYzVQazBLd0xPNjZnYjM5NXBxcjAzRDdzZjZsVXAwQTFCcUw5?=
 =?utf-8?B?cXdNbDlDRlZhTURETGZOaUxuV3UxVTFCa1NSK2xyZ0p6Y1c3N1BLaVZjek9J?=
 =?utf-8?B?ZlEyWGxsd3dycmpYRlRvU2kvL2QxVXdtcElkUG5SYTduR010dnhXS0FBL1BB?=
 =?utf-8?B?L2RZNVZHUzJka0xZR1k2K2hnZC9OamhsRFR2bU53YU9MRGlSQXJsdmJaZmJI?=
 =?utf-8?B?RHJGQzZkNGoyZE95VS9mdFNwK0UxSmdpdmNiU2FGRG41bmZWaGJYNEYveWRB?=
 =?utf-8?B?UW5YKzJDdllEa0FkOW5NQnpocFJ5TlVyZFVnS09hbVNCZ20wbmRLTXh2ZDJJ?=
 =?utf-8?B?bE9YZU1MQ0VjNTgyM01yeDFISzJkcm9SR3NDOFk4L2dBcDQybGxmT3I1Q1U1?=
 =?utf-8?B?TGZsNGZmWi9IUXF6ZVFhdkZLU0hmOEJLa3lzQ3NyZXNvMTlzRFVTQmkrYk9L?=
 =?utf-8?B?WGx1c2xJS2hGT0pjMkFKd1lMQnV4Zlg5NXJxY21xU21CejNxVis0Wm01RlhZ?=
 =?utf-8?B?YU5sMEZMYjhnVHMzNmdwazg1Z0FBeFhjWHIxdENDZ0V1SWNaSlhuM1pMcEhK?=
 =?utf-8?B?U3FqSDdvekhRZDBveHB0cEtvTDVNMGlHMXNJbzE0M0pDWHVzd1VoNjFCZU13?=
 =?utf-8?B?ZDlscHM0U1dqR1YxRmtheDBUblFXcHRKenQxZENWeGZNQmx6ejRES3Y2WldG?=
 =?utf-8?B?WE44ZllVQXE0YmplS2JmdHZzQlY0eHJGVmkvcTBGWEZHaExWOXVZMkNvL0VJ?=
 =?utf-8?B?Wk5BMlpVOW03bWZIc1pUMHJWNmJieFNBQUl4MG1pOElOdWhsUXR2MVRBU2lo?=
 =?utf-8?B?aHVuVUpoTFB2dmVQSzVKWnV2UHV6U2hQeHhBN2hFcVF6RlVOeEsybGFRM3VC?=
 =?utf-8?B?UDBkSWVkY21vU2EyNHpPZVlSbEFVc2FqWlhpc1YyYTJMSnhmWHpjOU1UWldq?=
 =?utf-8?B?cHY0ejQwM29kL0FCWjJGUHFOU2IrRi9wNVRhMnNvU0NJeVBOWG5hWXpyaWhF?=
 =?utf-8?B?M1JjUWNuRGN2Rms2K2tmNFBFK1IrQWZ2MGpLZ0g2c2x1d0RWYWJYUGM2SHRG?=
 =?utf-8?B?bWlaS21mNDIvdG1YYmtCckVWbEo0VFVqS3ZMZGpsVTZnRlVsd0xlaEtBbGRC?=
 =?utf-8?B?V0JwU1R2VGp3ek9IcUtaYlpnRWFKKzZEdHBmZ092SVhnc0xzZDMyTEdZQi82?=
 =?utf-8?B?cVhEN0xWWTBTYUk1UzlHVXFVd25aZEpuNTROMVFFT3oxdFltekgySlNtQW81?=
 =?utf-8?B?TlFYZVJxTUY3c2VnTENtcEtmdnk3UC9EUWVQc0xYVUN5TUt0UFNkQVRZbFdl?=
 =?utf-8?B?QlNkRUFxNkdnZ1hEcjdzTGIyRnJPRVhJcGhBeVQxUkZCUTFocGtkUklIZ3Jp?=
 =?utf-8?B?VGZIdCtnOXNwYWFXZnd4MmFrL1ZWaDVtOXR0aTdSWFEwUDB6SUxkOGZZamhU?=
 =?utf-8?B?TDNURGl1SHV5aWtIWU5GMTRqaTU4YmlKZWNDYXpHN1hiU3VXZVJiSnQraUZT?=
 =?utf-8?B?b0o5bm14NzhoREFaTGFNSmozUnpmNVBBOG93dEdOeTF0Mzd1Q1gzMFFFellQ?=
 =?utf-8?B?aFFCTDczaEdIaVNTdDRIZCtZMW0wMnVkZVlrTDJ4WXFndWZtWVhZd09KR3M5?=
 =?utf-8?B?Z2J2bGJ6eGF1QlVvS1hEeUVKOCtRSGZ2TDN6aHpEVGY3ZDhkVXJLd1N3M1dJ?=
 =?utf-8?B?bVJreHFBOGRrQ01oSE0rWGFKUHVTRTZ6dzlPTUZIdThYb3ZoNmRsQTdlWU5i?=
 =?utf-8?Q?1Op0gmcH2Ax0P9A?=
X-Microsoft-Antispam-Message-Info: RgxmoDmjw4NfngBWtKVQxW+6L3bCHVWF58NN89EhHZWDpNac9f95MO9zrTt7ZRoxzq5zexupMrj83raAtGfFwX+PTa+kAKYLk0wy11VvoU2fFrbzRvU2HlaI3tnLjYXyGKGgwE418VSmsl1AylPbVSts24rvW7nzrFxerc3XkKNLoUlQGG90YxbWFRvEQHBgZ2ynDmVpBwbmNy/3lxcuzpu1KlGCi+kYQYkvoL/k38/gEUt0Bidxnx38HO9rED0l+kROQeb3ql2slmn54v9vkYyboixlYAX4Ay+GHjq6tkUCPwHe1DgWc/zmhva3aUp1eFGfD+89hBjQ//J3PP4PrVBkPm2ZgS3iZSv/HYGLZCQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;6:o72oRoSssg1he9DqKt0I8PHv5vzUt329vdNDJhKWQahejeq98mp9R8/Z0hx0dJh+IZbqfnc7EcjGsSWlTs7WO4HtTPyscXGqWEfha84sU4YI+aCCr9kniKMET6bT9GwMTw542mBxxeZmiGItWozjoa7H/mMhfRq6KFN4t/stLHQw+cJhHRxpE92kyLxmBP4mIpsnvy7vTJf6uJPs6YYfV/hqQd54HwfkZfeTG1AB6EHggG1IWN6zijQYMMenwUvlKMCI9xHsq/fw+U5P3m1l+twkWcKzC45V3aQFBlmhecInBUAVa+AQS3I7YoE4gU9dFveTDNUyNCoqSpLlNfwV1ipJpdjHYUALltDerCoxqQ6NxBFO+5WQwkSV5Rpj1ZxEazz5ot+dULSHo8EQTwPVRseHM9j8zeCWcrXaws4xujHB03qdc2gpSm+Iu052Nohtn9qTpqFcM5mLYD2rR2FcCg==;5:EcvD8V62YPSOjIUgl+ndVl6VxLGwoespUDvfUxF8CuFUg+HD9IXT6vXiYlLoqqca7hbPyJmJioWj6Fgu+bYOnaHljae6ofPEwUg4pCl8dMuJQ+QWXvaeVmd5CaMUaAjxkBHBINf1bqxLw3BYd4hlRpUIjsvZRWFMCBmbqhiPJSs=;7:ZaX9nXvYn8rHdvLvK9FbHf/4jmEFhqneqFLncQ3usfoljbggv13H3QvjhXiZ6U3bIAjsv9ko6AIQHgqPfk49zV0I8YThx9a/3+NW6Rrz+lgbGZJ+DNuBvmMlNtqF0VFp1vya5B+XsfoNQhqMsogsPY+uPuRYHlVy571sWWxl3m9HUheGSOeGv1XxXyNHXFvSNZm+pRd/eVzn4EBSjAlpfZk6Lk3v7Sj3vYHvmIrUMH8Bi1nM62Rgyy4E2/1lzM+c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:O0SU6s1e7ZO+MbBKMYnyxB3kzr6KhN7aeCoKpGJjKE1I4g18pjnB9M9PuU/pO1Hp+qLXnrV791Ce8E1F1dr1pT7FXULxUvzqlNtG4fHtt2e90L9TyAnsszpa4LrUrcfToLDmzT5SQl9xJPhOSy8NfiMAiXMHGekFQIAwDBCSGz8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:38:27.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535b2c34-803b-493e-31b8-08d5fc7bd3f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch makes s_dentry_lru and s_inode_lru be destroyed
later from the workqueue. This is preparation to split
unregister_shrinker(super_block::s_shrink) in two stages,
and to call finalize stage from destroy_super_work().

Note, that generic filesystem shrinker unregistration
is safe to be splitted in two stages right after this
patch, since super_cache_count() and super_cache_scan()
have a deal with s_dentry_lru and s_inode_lru only.

But there are two exceptions: XFS and SHMEM, which
define .nr_cached_objects() and .free_cached_objects()
callbacks. These two do not allow us to do the splitting
right after this patch. They touch fs-specific data,
which is destroyed earlier, than destroy_super_work().
So, we can't call unregister_shrinker_delayed_finalize()
from destroy_super_work() because of them, and next
patches make preparations to make this possible.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 426161360af3..457834278e37 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -159,6 +159,11 @@ static void destroy_super_work(struct work_struct *work)
 							destroy_work);
 	int i;
 
+	WARN_ON(list_lru_count(&s->s_dentry_lru));
+	WARN_ON(list_lru_count(&s->s_inode_lru));
+	list_lru_destroy(&s->s_dentry_lru);
+	list_lru_destroy(&s->s_inode_lru);
+
 	for (i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
@@ -177,8 +182,6 @@ static void destroy_unused_super(struct super_block *s)
 	if (!s)
 		return;
 	up_write(&s->s_umount);
-	list_lru_destroy(&s->s_dentry_lru);
-	list_lru_destroy(&s->s_inode_lru);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
@@ -283,8 +286,6 @@ static void __put_super(struct super_block *s)
 {
 	if (!--s->s_count) {
 		list_del_init(&s->s_list);
-		WARN_ON(s->s_dentry_lru.node);
-		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
 		security_sb_free(s);
 		put_user_ns(s->s_user_ns);
@@ -327,14 +328,6 @@ void deactivate_locked_super(struct super_block *s)
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
 
-		/*
-		 * Since list_lru_destroy() may sleep, we cannot call it from
-		 * put_super(), where we hold the sb_lock. Therefore we destroy
-		 * the lru lists right now.
-		 */
-		list_lru_destroy(&s->s_dentry_lru);
-		list_lru_destroy(&s->s_inode_lru);
-
 		put_filesystem(fs);
 		put_super(s);
 	} else {

