Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206BFC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9598216EE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ehEpoLAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9598216EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbeHGRyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:54:11 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com ([40.107.8.114]:45240
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387578AbeHGRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoweZLAYp3KgFZo2uGoPuYqg3viLGocWgESzGgqHXy4=;
 b=ehEpoLACvT4MSoIHIof2+EnXIgtOW0VGWaEzFeJR2z4akYSCS3lGlHBQNA9ghHD3vCpGm/GZOCq8KQXRjpgVNE5aR6R9WJfJcWbahEu2jKJOKaZlnMguX3slyF+QpRr5Rgzg471MrO0tUMo/1xDf7wTgclClBwOoeHOOTZPe2zg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2029.eurprd08.prod.outlook.com (2603:10a6:800:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 15:39:07 +0000
Subject: [PATCH RFC 08/10] xfs: Introduce xfs_fs_destroy_super()
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
Date:   Tue, 07 Aug 2018 18:39:05 +0300
Message-ID: <153365634503.19074.14972123229522734895.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0034.eurprd02.prod.outlook.com
 (2603:10a6:803:14::47) To VI1PR0801MB2029.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8580e0cb-9690-4303-228a-08d5fc7beb38
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2029;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;3:bKv/zYxfBTC32Bt4PdjDxkMDGkiEuoixu3UgMGspvfJD4FrUXQDu1xUrr3OJGRXSXbcHczsJr0Hwpp3S85XUayOJQXdYsKy4/K0utLj3STlyQqksli7EGOdOD528dq4AOXVmfr+vGs8Ago30Xvy0PntPO3jS8Ex5JOIckZeJ5TpOvZJW7ion+aSvfxJZfw09qqOpeaEdi3EajEOzkAPtnMFyL6Wkfpr6SR7N9vVy9onuYFGUJRt/IG8AAqLBTKzl;25:oh1uESEP+TeKoUJiAfGC8rRuibEGj883mXYMzfpELkdGlWi9Z0Dm3LBsuzZP2H6wbHCx+lIZCYMm5VFg0morORuwUt3BXTscJ1oiHZZDM+Ael/q9TOi3RQrOwpC0/sIMcBivLxzoWRBOycrU6UZVrO/E1IUs0ktp1NiHe5+f9s1igadTHQcQz2fiiDgUDxeXM6VxlfQ1s7aTuBhBWOyiKPqrUTQVarZJGAC8UaP+nZ3qYw5VLovPihDuZKiRXVXLKxJtCej0cO0HpXeTkICC90D9Fwcs4CmKFKmCjOa8OLNTBvjL4yFqKA1efctKMP4Dc90Lo0lEZmAAjpXjeDNCbg==;31:M+9qfR0v+acrgyS0gDl0xoSH0Qo6AE0SYqYoyn+6AWQ7F5XexYeqgFgYflLwzt2rUuOY5Hs9aAZUevzmtLTN7j/q+LEjBjziy0XxzJ/GKwb0+bG7nXgG4sc/oa348jH9Qcf4iXsj1PT9YFpcBwGLszYWMyVXpr59ZI/Yy0szjrVOpZ6cZLYgHY0vvZcTckX0tMgJH3rLPGQr+qM+vYqyJCjZbEFptxy3GqLAPgXYNc4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2029:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:/KxN6nDpJ9D7HcSDxivgBG7qq+VQnec4koKteA5b6giytfIsDSaCe9yo/ngKVl9Le99DyPKqHkoHvS1LCjBw2IEgw/ApVLrTjy4uegGpFXHitdUjsKz+jzEhAu2dIrZ3/sNEtJWG9FIeMrW+H6fV7NKb8vgcDwS0BdWH06tsJ1/B9P4a9kfV9qY2GPVvR3O/NF/FFxUshTdJ1M/haybfMORsHtLHkpF77sUWwdvk/u5L1cbrs6o+LeTN+BvK836wQdei2MzbkQmOQDreUnIKE0FJ4dZZQ9d533TSA9BbtAwN1xSYxHAri+3nHVIjR6tdIYXF1BWST2WpiJ7a3lfwGq04K8CVndbXYyaJZtP/rEDieoLrnPIIKv5kmz2IDF7/3cJUg0IeNQsU/E1CVtvHGFuqrNudf146OBj+8e97VZNxFXtlVEPcuskTmiHwZyWjxNMWKVkR5PDy5jkERLOhRtdDBhZ4fsg9cXSPKSHBKJYVcI6kJOywr4sxKKB3SjlO;4:fo3mvZA5p8bXyVx+BwDz9KJ5RokYwm26xEuW9P8xol1kPPyuCgsEquT1xZiOa6SWlcIiDVH41WSJBpSZljicUMbQWhtrJPDLTrN7UcRZTZyinVOAEfeJbksMLhEcG3nYDk9YYfJJEAhNJt93R+ZBRwdGSL/1Yzj2g/JSjZUHb23Q62rauVHysTfN8mVDMk6vYATlB6MgWvFsyFMsBVJozZQg7E65GA056NdFvXyZpOXzQKFz1arIXO19vGTGqOZ6m5YgLW0H/bP2leDxnZJbpQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB20298CDD97AD727AEA04D65FCD270@VI1PR0801MB2029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2029;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2029;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(486006)(230700001)(53936002)(86362001)(11346002)(956004)(2906002)(5660300001)(476003)(446003)(14444005)(7406005)(7416002)(16526019)(186003)(26005)(55016002)(217873002)(3846002)(9686003)(386003)(6116002)(6506007)(8936002)(50466002)(478600001)(23676004)(47776003)(81156014)(8676002)(81166006)(103116003)(68736007)(58126008)(316002)(66066001)(7736002)(105586002)(52116002)(76176011)(305945005)(7696005)(2486003)(33896004)(97736004)(106356001)(61506002)(39060400002)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2029;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMjk7MjM6dExzcHZwZzcyNWZybm9venUramNoVHZ3?=
 =?utf-8?B?bjVJaFdlekFSeTJEUUFXWCtEaE1MVUFCV0JnOXFqUnFMUEw1cTBtN01jdmIw?=
 =?utf-8?B?dXRRUlFWRVFuZkNMcW5VeFhGbmprRlNwcUZRU016bmlqNzBCYUVsTERwZGtO?=
 =?utf-8?B?R0F5eml6N200NjRSYmt2TThhaU5hOU4zc0NKRUpGV2FCYzZuMTNkWnNYWFcy?=
 =?utf-8?B?dXg0Z1NVSUljcjNMTm5Va1pXRHF4VUlRaFp1ZVVCbFl5M1Bpalhpdm1jbEhk?=
 =?utf-8?B?Nk9jWXJ1cXVWVEwxcW5xYlR2enA2UG5HeXdCUWU2VE13QXQ2RHkrYVo4ckhU?=
 =?utf-8?B?b2t4VnBMWGJVbHE2eG9yMEpUNVh5VGI3SXI1bGlPbVlLTGJqbGtqTUFsM3N3?=
 =?utf-8?B?cUVnRTR0aUE0OW1hRTg3QzJwb2plRTFRSWI5NGw2V2htL0U1NWs3UVhQSlhl?=
 =?utf-8?B?dkhUQ2N2WDZJbHUxT05aSDB4OEdUbHhDY0thWlp6eFhCT0YvWXBOUzkraWdl?=
 =?utf-8?B?NGk4UGFuUlVuV0xNNGsrbDBvS0dNazZ6UmxnbXpBTVdaUXVCZ2FFak1PNUc2?=
 =?utf-8?B?cTFUM1Y3dUNRRHl5dXVpZ1FIdExxSzZoNm5HR2JXV0ZkWEVibmp3RWNyVEw5?=
 =?utf-8?B?OGF0bzMxNHcxejByOUx0bEVWalRlYWxkWVdhemg1K3NiVXkxRWRZRWpoSzAr?=
 =?utf-8?B?NVU3aXdJSW1hdjRMZldocG0rRmhPNTZyaDlIdWFVZmtSWFpEMWtSUnZGRkhK?=
 =?utf-8?B?bmRTRExzcWV0cXZYY1BMWmpOUlhIQmlldUhiV3RhYmJiNVc5YXJrM3FjVEZn?=
 =?utf-8?B?Y29FS1I3K0JObUZUUXMvRWNrZWsvOFdaZ05UTTdFRTN0SWhLQUticHhFZnpl?=
 =?utf-8?B?bkh2cndlTVBDVmZGTDE4ek9SZU14eVgwKzNORHpFYlZqRjc5Q2d5VG4yeVRw?=
 =?utf-8?B?ZW42N09naHJGVjBrbmoyWWZmQUxwMjkwY1g0TmFVZTRjT0MwYmQwV2IzVndM?=
 =?utf-8?B?S1dZVC9CR1I2Z0k1KzdFbDFQd29ySEI4UVQrSUVCTVJIOHhVVmxOYkt0YmRt?=
 =?utf-8?B?bzBMZUYxNW4wSmc5SVFPeUlFYWNmM0ZZSjVrSFBna3c4UmQyY3k5Q1NBYSs5?=
 =?utf-8?B?SkhOUEI1alJxbUozaEd4RHdpaHRvbHdDWlYzQlpVdVRmMDdyVnA1WHNxczZo?=
 =?utf-8?B?OFo4dU5iczdvYjRTYzEzaGZIaXp2UVhvUEpZY0VmL1dFYTZNYzVsQ2crYit5?=
 =?utf-8?B?QkFmMmJvaTN5UVBGWGNkblVYaSsva3ltTExFcUp6c2o4OFRNd2VoaUtwRk9S?=
 =?utf-8?B?dmdLZ1BKUXh1RmNBM3RFZTJ3bEt2aUQyS0FjRUtkenBmSXdJRmtSelZSbW1r?=
 =?utf-8?B?Yk1JVzZBUEtqOTRTOU15OFZ5dkpGSkV6Zy9OdHJQendZSjMzNFRDa2lpSUY1?=
 =?utf-8?B?S1BncDVCcFIzenh4eWxQWXFyd3dYQzFkVkV3bUluaTU4bFdKTzBPTDJLUSto?=
 =?utf-8?B?U28zV3U0aWRpVTU3ZHkzV2prK2ZSWFVLQ3FpMjJDNDFpSHdxT2pQNmRqRGI5?=
 =?utf-8?B?V3pNZmRXTTNjcUxGeUthY0FyelF2Umttc0tLdHl3WFJuME4rOFZKd3RHUEFx?=
 =?utf-8?B?cHIrcmQydjFGMXpFbHFyQ0hBRlZVbjMzZkxuU29XZncyWCt5ZnJDTG1RWVha?=
 =?utf-8?B?c0lVVGdSL3ZVQUp3OFV4TW5nTCtwOWp1SURXSUVxTDVwUXF2azZiaDZjc1Nl?=
 =?utf-8?Q?Em1CyPLVF+tZ8Xe7v/DeYXW8jzdjbqj44GEFT+8=3D?=
X-Microsoft-Antispam-Message-Info: 5u6ECJ19daG8JD17g/PrPmLMdx31ONpY3zxRyBMNN9CeqlNXLVrBBnKxsake8WoQgLzctiKb2XG2+LC3wKpiNGe69fSGDKVDS2+/MC2bexbWnK9RkqCgEWhLYFV1G6H0eZ5duttR63Vbrmvc7DQ2DCGOTWbUAoHR2iXZIlVA7kJiRTRII+A/gHfpckMzMEVXRvNa7NkkH0JZx6ll0PyVMS9TlfYJ4TLXbe39LCLdaiJODwE5yTxKYJ6qUrsHryQbUdhVtFD+2S6WoaOtNpCieqbjD32G+LfAjK5ol/Rgnsdbe07ppViKZw3Ay4E6iTScOCRYLV02b+383wBtooCRKVvfNpG95p9fA3ENYuHyQw8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;6:E8N+2uZfhW8SjIh6lH1ZjVZJbhlQEJeYfn+atDy5EHTYW0Bl3gg3f9HlMBisLfvcvGOT+pfi5G+r8915hy0iEJEnzTkMO/uJKPnffEeHR6igwfPMffBwyPwuHmn/lasf4dkG43nkEVpKTcPyMfPgINh25m5ULAx4F2m6IARHm9EBeU3Tg+Qi1HI9zoNaZLgC3FoQYpj0iCi+z6ObQR5eT3wBCoKjEiMe9+R6yKs0o2RBIbUKbDkf+wVrxdlj1z1Btg9E8V1JGxdAAyp2/O/9vf0FXSLfUX01xN0IMbr2golq2MeeBEAH1BswUkMJAeO9QgXJ+VvilWoqc5inECF+nEn5MS9hUG/W+eCnsGPYbRCseviPBxB7oGXvp6QQS2ysBvoDCyvBSFQeRocoR2xNaSUNujIsud0qPOswdsp/hQPR82abZyiy3VOmT0bReBwNMS7bCwx9beXXPR33DHiX0A==;5:1OeBnTehfk/k7s9bClNF8qSP2Jk8w+w8J9v7DD5VVVXzOlOMFWpypdUc1xLvNkEtz3fOif/PPNosKC4waNoFayZc5iLh2H+TS5Vfe7SpWtv+st6LrFoXq1iPYYGs9pA8tQZ/WZ4+2Tgt4DpE+qukACg2hHY92lQs/HCaaOHFinU=;7:/F2DbzJW7NW5lx0pErAqcWWQTC8LmiWciQZUBFW1eeL2vU/aLLfnb7Zx+ZK7wxquRfY/hR8x/Y4yQrf0bXDsI4xGMqaD4I/z448N/GV9sPxiq0fMuQXH7cxcP7gJXuxBb3XnE3ioxfVWgiYUjAZ39rSPaUAEQT1hBXUnC7GLUmcjCW4NKMZfOH0IbntvAz4I7TIINrFrgr3C6xw2ig8RPwtIP4kEi/U97Mlat3G2GaIOY8c+M2Nfm7KJ0vcr06Sp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:wzUR5MiLoJ2LdUk+9fVYX4n+qfuvA4cgzDcC7Sjtjo+CMtqqSC9P6Y+QP1MyrxGYFbjS7sgEEWnQuL31k1L2VdqI5z3MltTn/hZeREMTUZNeD832GAm+x426hJ2s/r/hviy8OHid2h/VA/CX/IkjKj23YxsvdRlH2P8gg9UKBXE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:39:07.7794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8580e0cb-9690-4303-228a-08d5fc7beb38
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_fs_nr_cached_objects() touches sb->s_fs_info,
and this patch makes it to be destructed later.

After this patch xfs_fs_nr_cached_objects() is safe
for splitting unregister_shrinker(): mp->m_perag_tree
is stable till destroy_super_work(), while iteration
over it is already RCU-protected by internal XFS
business.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/xfs/xfs_super.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 9e2ce4cd98e1..c1e00dd06893 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1774,11 +1774,20 @@ xfs_fs_put_super(
 	xfs_destroy_mount_workqueues(mp);
 	xfs_close_devices(mp);
 
-	sb->s_fs_info = NULL;
 	xfs_free_fsname(mp);
-	kfree(mp);
 }
 
+STATIC void
+xfs_fs_destroy_super(
+	struct super_block	*sb)
+{
+	if (sb->s_fs_info) {
+		kfree(sb->s_fs_info);
+		sb->s_fs_info = NULL;
+	}
+}
+
+
 STATIC struct dentry *
 xfs_fs_mount(
 	struct file_system_type	*fs_type,
@@ -1816,6 +1825,7 @@ static const struct super_operations xfs_super_operations = {
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
 	.put_super		= xfs_fs_put_super,
+	.destroy_super		= xfs_fs_destroy_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
 	.unfreeze_fs		= xfs_fs_unfreeze,

