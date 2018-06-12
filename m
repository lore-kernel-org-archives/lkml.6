Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F3405C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F05A2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMeSsZ5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F05A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934618AbeFLWLX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:11:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33850 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934282AbeFLWLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:11:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CMAqKp127452;
        Tue, 12 Jun 2018 22:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=FlN9Swwmped8814KFwYcSbWvoiTF6BYWLpj1qeGHzR0=;
 b=hMeSsZ5KUtC6xCnMwBVDtFA38+o7nkcIdfaaF3+PwPuYtjV0kLgnb0zi/FS3RM6Lywks
 yVrX+lfiX7MM5tuAft10HSm6h4gJEpMVDCpcikFpe6ZStU0nqb90SjSBeJdglmt1aNX5
 8cfJzLsrLmxyrgSSVffbY5OSSKVL2ScNnRID+dG+41k0H7uLuCgb28yETqHGOnY48oRN
 Lbph62QncCYkOiI3k48mdH/0DGjaEfd7nT6ptIZc37U1qjvx5LsR+gsO7QzZqre4C3LI
 wzw/TRkyHKo1kX2XrliIyeJlDeHMjlMYa1Y/Uhe6GjB0peI9fMZl8yzADyxGqtlPO53P aA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jjp6br2jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 22:10:51 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CMAplA007590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 22:10:51 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CMAoWj025595;
        Tue, 12 Jun 2018 22:10:51 GMT
Received: from [10.132.91.87] (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 15:10:50 -0700
Subject: Re: [PATCH 1/5] sched: limit cpu search in select_idle_cpu
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
References: <20180612175002.31453-2-subhra.mazumdar@oracle.com>
 <201806130240.AQdYDV0h%fengguang.wu@intel.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <e128778b-c079-700b-ffad-4749e66d3bbb@oracle.com>
Date:   Tue, 12 Jun 2018 15:12:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201806130240.AQdYDV0h%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 01:33 PM, kbuild test robot wrote:
> Hi subhra,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on tip/sched/core]
> [also build test WARNING on v4.17 next-20180612]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/subhra-mazumdar/Improve-scheduler-scalability-for-fast-path/20180613-015158
> config: i386-randconfig-x070-201823 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>     kernel/sched/fair.c: In function 'select_idle_cpu':
>>> kernel/sched/fair.c:6396:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>        u64 span_avg = sd->span_weight * avg_idle;
>        ^~~
>
>
<snip>

I fixed this patch, please try the following

---8<---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05..7243146 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6372,7 +6372,7 @@ static int select_idle_cpu(struct task_struct *p, 
struct sched_domain *sd, int t
         u64 avg_cost, avg_idle;
         u64 time, cost;
         s64 delta;
-       int cpu, nr = INT_MAX;
+       int cpu, limit, floor, nr = INT_MAX;

         this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
         if (!this_sd)
@@ -6390,10 +6390,17 @@ static int select_idle_cpu(struct task_struct 
*p, struct sched_domain *sd, int t

         if (sched_feat(SIS_PROP)) {
                 u64 span_avg = sd->span_weight * avg_idle;
-               if (span_avg > 4*avg_cost)
+               floor = cpumask_weight(topology_sibling_cpumask(target));
+               if (floor < 2)
+                       floor = 2;
+               limit = 2*floor;
+               if (span_avg > floor*avg_cost) {
                         nr = div_u64(span_avg, avg_cost);
-               else
-                       nr = 4;
+                       if (nr > limit)
+                               nr = limit;
+               } else {
+                       nr = floor;
+               }
         }

         time = local_clock();

