Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A327C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91932173F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VL9qFctI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91932173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbeHGRwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:52:40 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com ([40.107.0.103]:23228
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388677AbeHGRwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHFDjKdL6Buzx5I7OUG4LnsCYKjp0S409y16pw5PmLQ=;
 b=VL9qFctIsGB312rFR76hG8lkdfQsaFe30R/A2YNXom+arhp/VfLtioRslmLk6Z6TVmauGxVOjRm95pwkcamPXR/arRraUQYBxYlZjy4Fs7FaZE4jlgo/itf1OBXcAF/2NqBeSIOCN3i5TWM4RedIaaLB//2PQD0VbLvpP44iBnA=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.17; Tue, 7 Aug 2018 15:37:39 +0000
Subject: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
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
Date:   Tue, 07 Aug 2018 18:37:36 +0300
Message-ID: <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0062.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::30) To HE1PR0801MB2025.eurprd08.prod.outlook.com
 (2603:10a6:3:50::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c85a468-862a-4fa9-3baf-08d5fc7bb60d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2025;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;3:N3+QQcOPo3UoJ2bz+ZpDWjELIk8tEgZ//wGaiEaK0sIOTSoP/cXKg6PLfrKux7Yy8lkEXTRhyvNeg+Bv5O8CTS4VSgKk6T+A2JMpuBqejHXV/CCjCZ+CLIfglP6S5W529h82A35BQByMTuXGztB3iPSiZYdybQpJIKwR6UGDcJtCOPejfcG4AkW8fdATXlVOFYhKLbpBEqc0AOffTTFXTE0lyNS99DyLg0DXirp1VszrNKl8JcRUZFmho0omALXC;25:BdPCUy4ijZzlT4gSDP0ICAgh+LdG80zwla2Mr5ENjEBcdH6uBt4bSAJrkREReEbpVTYAN1UmShcgUiUfkUh5IefWZWacuoC2R8ikc6HZXuhW9cZLsN8ilBCQt/O/VqiCFqDigsJy5FMeNRHE0SYjqwFWN0pCPlkaO/TH9LmrM+aESRHwBstpeyee0e64z53dTcK5H1Ha4xRumjLo+FKKSefpitpHZGvT246/5HlVX5F5/McEwJQ0AETn0ctPhyuDq7zEPk9ulYzbVvosgG3rr2PhJfsiPw5G/PDblrwF8gGCiXIKeB/YRyzgt6FLAi1urhB6Kre8HMqzyl689VQtdg==;31:l30VJS8EUu3XdUiLfKgROzNru5i1uVtJiMJB5wIEpu9I9B3R2m+V2uujy5EwcJh4DXkM7D8xhvpo75W26NkWTvs7GQi8uQ0b9XV1PRcm7X9FQMTfs4JenxmKE0zUXcmZfTvYGR77OeaEh5Qff5t1gS9RIpiToGYsDpo2GIgX52FesB8Z4VqSYjHp0RsWIIEjX3ZRgc4/hm0l5TX6ab1B4E9IF6PQBcxsWEYy6JSwNQo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2025:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:07Vc/jlEVWSE9q0oY1cqhoMpBZX45iU/BA82Yf43NcDuuN6m9rHGy/AMuMAZLf5W9YnK11J8uAkNp+DfUlvkpYqg1mRGzRlGaKYeouBpG7zNkuzCRgEbR0do2MZrkPn26lN4qfYDHL4dlmJ+hVWRZIFV8PcUUXttOe+rkau8fuJQ8K5TJA+MFK4+RHjwh8FwixO06nscI+5WV2PfzJo7JJseDeZH15p+suTNmLxTnVE0MrDcxYmZble6ydqRSO0JzJalx/41nBPu5ISAabd3QC4mKn102e8+oDrCVXRjZLDONal0kMR9sES0WDI4t23hcoewE/NBFtEKPEM5y28D9u5xhhxpWPfOlCocwRCUSpFuwzAF3wBOr30D5emrXeigbRQMRWKwiVfE0cO+xSZj+PPw9izJvhSbalWIOQE8R/dkx43oTjFiNFtw1HHhKUfoZRdym7PTlsDckyWo9Vk95LldZf15sZ3RYf1JoOl8Gl+u6H/Ac+DANq0oeNGb18CS;4:1g73q+z4zUdX9AH5/BFGuStBpRELK0DhgAoEOuvwUJg3zJLsj+gkwPiknMTFYnziYz42Om09S3cSJ9RVjcvRNSVn3mKZBxE3oO2ojprLgx98JqETOC7nB3nLiFMSWI3LUi1B/0jEIA/I0XMBXKSU0iPqN7IgY+uhzXT4WvPvpMl8PaI7g2QPd05i/Mhhpr6i9w6/3t9O3MdIrF2a2JRpRoWwZfj0U7wYRMY5S+yFDjexxD5+Kv+ZWmjaycAYeSxAZFo3lqpGyp8qXIZ0VK9Zow==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20259F09DD77F823ED58DD6CCD270@HE1PR0801MB2025.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2025;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(39850400004)(396003)(366004)(346002)(376002)(199004)(189003)(8936002)(305945005)(81166006)(316002)(97736004)(8676002)(81156014)(66066001)(7406005)(7416002)(11346002)(446003)(7736002)(47776003)(61506002)(2906002)(217873002)(14444005)(478600001)(486006)(956004)(476003)(58126008)(6666003)(68736007)(575784001)(50466002)(86362001)(16526019)(7696005)(23676004)(2486003)(106356001)(39060400002)(6116002)(3846002)(76176011)(186003)(26005)(9686003)(103116003)(33896004)(25786009)(386003)(105586002)(52116002)(55016002)(6506007)(53936002)(5660300001)(230700001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2025;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjU7MjM6SXlpRG8zbEk3RFVheWRGZG43cG5tME1N?=
 =?utf-8?B?SWJ5cTE3U2duVUF5b0pwMkVXMUNHM1hHNkhzSEROcmkxUFB2dGw3eWVSQTV6?=
 =?utf-8?B?RFFJRzVEMEY3bG5nRnpIdm1JdEtmZTZjWGF6RG5BQnRyaUpTeU85c2UvaWxz?=
 =?utf-8?B?MVhUK09RTWYybzNMbm9YM1ZPVjNFOWNxWWZKUjdjcDlKNkpZTmdOUEx6aFN5?=
 =?utf-8?B?VTREMmpzQklsWkJ4MU5ueGhZZjJvQnZycWRrbTY2eEpqMEZtV1ZYQytFLytx?=
 =?utf-8?B?VzNCZFNWcDhlenpValhmdXl3NnBIOGJrSTVya3h3OVM0SG42TmxBMXJxZTlx?=
 =?utf-8?B?dTlEMkFOUGxYbm41dlZVSXk2TUJVUGlmNnpGL054SkluMkkvVHMrWi9zZWxC?=
 =?utf-8?B?bUVGSlRXeHk5bXBXWUd1L3NzaXBNTk1DWHpBcjRnWVdWazMvVEhTOHdKNWNz?=
 =?utf-8?B?VSs2ZnpZbkJjN3l3U1NmMm13c0lwK2p5enhVekxzQlU3dENiZTlTL2tkOVEv?=
 =?utf-8?B?ZGdVT0JPTnNPb1QwWmM0UUZGS0N4djJCQ3NOQlNiWWNJcVJ3N0lkZFY2My9p?=
 =?utf-8?B?dkJGQlNqeGR2SnNxK3R2dk95RmsvQlhqclJtb3lvWjJScHFQTk9aZjN3NVVG?=
 =?utf-8?B?N3NFd1BoREZqRGZsaFhDTW1ZTVRtQm1NN28xTFVSYS84UzdhV0hGYzJaZW9o?=
 =?utf-8?B?VGpjdHZBa0NBYjdUdkh4ZmZ6OWZpS2JnRnFkMHh4ZmNhK0JyckVsWmN0ODZR?=
 =?utf-8?B?Ukh1NDVZN1VoUFY5R3pRV0pJZ21USHpTMnd2QTNXM0NBREVGSUtVdGFyOWNW?=
 =?utf-8?B?QWhlME1ZZlh5dXcxNlRHSjdHZkg1RHVmZzRobm1pdFRFb1NoVFhzUHdDWTVm?=
 =?utf-8?B?OFZQaUVLa2NlUnpYdzlQVFdTNlowcnRFYjNRYVFNM2Jubm1SdkRiSi9hd3Yy?=
 =?utf-8?B?RG5mL2ViVEpFdzFsSDBaejMydUlCZ05TWmpkOXhRQVZFZWxVT3J2YzB5cVNL?=
 =?utf-8?B?Y2l0U2JCakRBa2J6WVlESXNYcDhNNFkvUDBTVks0emZGa1BONHloOEluM3VX?=
 =?utf-8?B?eWx3TEUvL1VYRCtHUkx4Mnk4ZDFncVJhNzl4NGlLTHdlWnVhMkRvM1pUb21Z?=
 =?utf-8?B?Zmw1OVExSExMVzhSdHdEeGIwL2J1QzJ6OUcyR0pLaDlHRU51WUtrbG5ncFRT?=
 =?utf-8?B?MldnRXlNZjBET1BWeGhmMllhcHp3VnpObU9vQkxzRkVXdzZNaEZmbzRnN3pq?=
 =?utf-8?B?UG11MktMalZTTXBKSG9nbDNZd252azhhUkhVTWhHNW5teHdLNW9xenpBM1Iw?=
 =?utf-8?B?VXZickhUckZUbVM2cERVTUtTbE9tUFN3S29QWDcvcWF4bHhTSGR1dlc3RTlE?=
 =?utf-8?B?Q0V5U2FVTjFSUHpXUGVWTzZPUUpGdURkYStBYjQwM1p3YlErSHVydWRpeWRQ?=
 =?utf-8?B?RFkvRW9nYy8xQjI0Z2RuYm5NazJOUmVvR1psRVloZkFoZWVnOXlqQ3A5bmRP?=
 =?utf-8?B?RXkrU3BzbmFXMnltdlQ2OERmcjFmQ2V5UnpSM0d1c0RlVVlWQ2xWbEVJeXhj?=
 =?utf-8?B?dVFLSWMvdXY3QUNLRGUxaTZFWnVWN0hON0NsMVVLck1mK0EwV1U4ai84LzRZ?=
 =?utf-8?B?R2M4KzlrZHQwdzRzRTE0V2pSa0pCekFIeks3TWdSTThpdFdEYWVtRUl2amRO?=
 =?utf-8?B?YklsOTZxYnhyVkcxQmpsdVRVakRkWGcySURidENvc2dkNW1VYjZqYWNjNnVs?=
 =?utf-8?B?WFRSRFFHNlJMRU9DTmFQL1lmMlBWUW1GTGR6aTJHT1p4Z3A2b0xkUWI4TUV6?=
 =?utf-8?B?c3VzSXQ2S1JGbUE5V1p5b2llejhLWm1BNGVSQnpuS2MzSks0QT09?=
X-Microsoft-Antispam-Message-Info: 5V3vihL9KNDw8z4WVWCVOs5WZN26Kx08dszku8iTyXgG/OBsElDPxbjPq6oL3VbRYA/cbM3X7PHRKAslnlfqVZNVB6v3/XKQkKCLsvlpYIP3LLdv/QOvp+217ENvrWMEVYCDvnp6LMKglKC9VrJuA2kEctDOer3wuzMiNBa1fI52F9anAO7kAnniR8njVwb64rFiIV8+nIU9uZtuPyxBmCCttPoEI4Rn8ti092vpDONDbIWn1EGuMgb/hLfHYitrjIyuWaZAoXFhl+6pyjUQJ7PmEfgeRNERH/ydwrt3O0Xr6cJmpxrO0+AJ23NND5RwKrPYo1S8ZOgBLENOQlWyVm7gaPII3EHNNsBhPXTR4pM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;6:/YeQQbCPP3/M+uqAkVbi4rarISb7yqmY5DXV9v6ijtgLe+s2+Jfn2MaE2ri/TvgtCHBpc/0mhqsG3z01CgPCWm2vStT/X3XysAwvnCJlJ+r40E928mbpXcNPdIYyMgp8wez10Gr0LtewqmkUmo0LiqaqG5JD6de0t0n+khsAayjOfDNmjAzvVkcES9V/sKCnY5lgNdU+/Bu/y98kZXeLeGKIhYdRz9afOZ6CbpGReceaudQxD/WlQ8Yt2S2GKR0wIWuE/JeQ8+7XTgGSE3GWBdNw6BaMCZQADMQEzs15nronU09/1nZWtBQoLZgPzFD4NEFA/sG9v8VJi1T4CPFa3CARK5NPwL0WuDO8/lCGd1feMhRLdgqAaKNt9XfT7l1b0jzEvTPPJzukU9uteYfRlg70I6iwj8v3nVxblGkJcSvImqXSJ9ea7acaqsNpa4iEHzG1SECGDBS61mdP+STZSw==;5:xJ5U6di23IC9bg+jQyWnjuIXrzu4LsFzcx7Aw9/wOz9kQqhA2ooGgX5AEaBGacB4erODuG8DSUPQL85bj77dX6ggRCQ/WzdmGC06l7KVc88+RKX97dibUKCIMWGNn1Jt4lAy4McbsysY6Pzdwe2uwus/9n2MwF4q3bU86MAPZT4=;7:+oID8+rvhdLp1IaKPKWzPptwKF8mO79GwAE9E1gkZBDZ61ottGm3GiQSsXfnfca/d7eubMHw0IJoPQ4/oI9RXiGR3Aij1tWUec84e+YpYKJ0DldePoEfaKAP3IPwL+xrfxq/30x1HIxTUimNVDot42bn0XSjDrj40ewsQRKn8BRPKLAXFAvoN4o6Bcj0uYQhA0plVdR5y1hKuLx2z1b0epb+6ibjaTmzkcq9MccOOQlDf2FDc6dx+/Pze/Az3TEk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:hI7OJJ+sqyjQUP2vyRFowQAb3Ku5bPqVOwqRNfEB6VeztthF2XwDBg2hIDQiqvhclKvA0J67wOlphpXILb4mtQyQSMOG2Lx5vrc038amE1YCV/ERAwcYQersNvyNwQ6abkJtqDp2ZzGBcOEg3pVVHlQOljfoHM+EJvwD5obK3vc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:37:39.0065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c85a468-862a-4fa9-3baf-08d5fc7bb60d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills all CONFIG_SRCU defines and
the code under !CONFIG_SRCU.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 drivers/base/core.c                                |   42 --------------------
 include/linux/device.h                             |    2 -
 include/linux/rcutiny.h                            |    4 --
 include/linux/srcu.h                               |    5 --
 kernel/notifier.c                                  |    3 -
 kernel/rcu/Kconfig                                 |   12 +-----
 kernel/rcu/tree.h                                  |    5 --
 kernel/rcu/update.c                                |    4 --
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |    5 --
 9 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..8483da53c88f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,7 +44,6 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 
 /* Device links support. */
 
-#ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
 
@@ -67,30 +66,6 @@ void device_links_read_unlock(int idx)
 {
 	srcu_read_unlock(&device_links_srcu, idx);
 }
-#else /* !CONFIG_SRCU */
-static DECLARE_RWSEM(device_links_lock);
-
-static inline void device_links_write_lock(void)
-{
-	down_write(&device_links_lock);
-}
-
-static inline void device_links_write_unlock(void)
-{
-	up_write(&device_links_lock);
-}
-
-int device_links_read_lock(void)
-{
-	down_read(&device_links_lock);
-	return 0;
-}
-
-void device_links_read_unlock(int not_used)
-{
-	up_read(&device_links_lock);
-}
-#endif /* !CONFIG_SRCU */
 
 /**
  * device_is_dependent - Check if one device depends on another one
@@ -317,7 +292,6 @@ static void device_link_free(struct device_link *link)
 	kfree(link);
 }
 
-#ifdef CONFIG_SRCU
 static void __device_link_free_srcu(struct rcu_head *rhead)
 {
 	device_link_free(container_of(rhead, struct device_link, rcu_head));
@@ -337,22 +311,6 @@ static void __device_link_del(struct kref *kref)
 	list_del_rcu(&link->c_node);
 	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
 }
-#else /* !CONFIG_SRCU */
-static void __device_link_del(struct kref *kref)
-{
-	struct device_link *link = container_of(kref, struct device_link, kref);
-
-	dev_info(link->consumer, "Dropping the link to %s\n",
-		 dev_name(link->supplier));
-
-	if (link->flags & DL_FLAG_PM_RUNTIME)
-		pm_runtime_drop_link(link->consumer);
-
-	list_del(&link->s_node);
-	list_del(&link->c_node);
-	device_link_free(link);
-}
-#endif /* !CONFIG_SRCU */
 
 /**
  * device_link_del - Delete a link between two devices.
diff --git a/include/linux/device.h b/include/linux/device.h
index 8f882549edee..524dc17d67be 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -827,9 +827,7 @@ struct device_link {
 	u32 flags;
 	bool rpm_active;
 	struct kref kref;
-#ifdef CONFIG_SRCU
 	struct rcu_head rcu_head;
-#endif
 };
 
 /**
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8d9a0ea8f0b5..63e2b6f2e94a 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -115,11 +115,7 @@ static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void exit_rcu(void) { }
-#ifdef CONFIG_SRCU
 void rcu_scheduler_starting(void);
-#else /* #ifndef CONFIG_SRCU */
-static inline void rcu_scheduler_starting(void) { }
-#endif /* #else #ifndef CONFIG_SRCU */
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_is_watching(void) { return true; }
 
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 3e72a291c401..27238223a78e 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -60,11 +60,8 @@ int init_srcu_struct(struct srcu_struct *sp);
 #include <linux/srcutiny.h>
 #elif defined(CONFIG_TREE_SRCU)
 #include <linux/srcutree.h>
-#elif defined(CONFIG_SRCU)
-#error "Unknown SRCU implementation specified to kernel configuration"
 #else
-/* Dummy definition for things like notifiers.  Actual use gets link error. */
-struct srcu_struct { };
+#error "Unknown SRCU implementation specified to kernel configuration"
 #endif
 
 void call_srcu(struct srcu_struct *sp, struct rcu_head *head,
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 6196af8a8223..6e4b55e74736 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -402,7 +402,6 @@ int raw_notifier_call_chain(struct raw_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
 
-#ifdef CONFIG_SRCU
 /*
  *	SRCU notifier chain routines.    Registration and unregistration
  *	use a mutex, and call_chain is synchronized by SRCU (no locks).
@@ -529,8 +528,6 @@ void srcu_init_notifier_head(struct srcu_notifier_head *nh)
 }
 EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
 
-#endif /* CONFIG_SRCU */
-
 static ATOMIC_NOTIFIER_HEAD(die_chain);
 
 int notrace notify_die(enum die_val val, const char *str,
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 9210379c0353..f52e55e33f0a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -49,28 +49,20 @@ config RCU_EXPERT
 
 	  Say N if you are unsure.
 
-config SRCU
-	bool
-	help
-	  This option selects the sleepable version of RCU. This version
-	  permits arbitrary sleeping or blocking within RCU read-side critical
-	  sections.
-
 config TINY_SRCU
 	bool
-	default y if SRCU && TINY_RCU
+	default y if TINY_RCU
 	help
 	  This option selects the single-CPU non-preemptible version of SRCU.
 
 config TREE_SRCU
 	bool
-	default y if SRCU && !TINY_RCU
+	default y if !TINY_RCU
 	help
 	  This option selects the full-fledged version of SRCU.
 
 config TASKS_RCU
 	def_bool PREEMPT
-	select SRCU
 	help
 	  This option enables a task-based RCU implementation that uses
 	  only voluntary context switch (not preemption!), idle, and
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4e74df768c57..b7f76400a45e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -489,12 +489,7 @@ static bool rcu_nohz_full_cpu(struct rcu_state *rsp);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
 
-#ifdef CONFIG_SRCU
 void srcu_online_cpu(unsigned int cpu);
 void srcu_offline_cpu(unsigned int cpu);
-#else /* #ifdef CONFIG_SRCU */
-void srcu_online_cpu(unsigned int cpu) { }
-void srcu_offline_cpu(unsigned int cpu) { }
-#endif /* #else #ifdef CONFIG_SRCU */
 
 #endif /* #ifndef RCU_TREE_NONCORE */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39cb23d22109..90de81c98524 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -210,8 +210,6 @@ void rcu_test_sync_prims(void)
 	synchronize_sched_expedited();
 }
 
-#if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU)
-
 /*
  * Switch to run-time mode once RCU has fully initialized.
  */
@@ -224,8 +222,6 @@ static int __init rcu_set_runtime_mode(void)
 }
 core_initcall(rcu_set_runtime_mode);
 
-#endif /* #if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU) */
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key rcu_lock_key;
 struct lockdep_map rcu_lock_map =
diff --git a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
index af6fca03602f..b4f015c3244a 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -73,9 +73,4 @@ CONFIG_TASKS_RCU
 
 	These are controlled by CONFIG_PREEMPT and/or CONFIG_SMP.
 
-CONFIG_SRCU
-
-	Selected by CONFIG_RCU_TORTURE_TEST, so cannot disable.
-
-
 boot parameters ignored: TBD

