Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D20C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B40218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B1ABOnLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeLRU4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:56:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37364 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:56:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIKrecp121204;
        Tue, 18 Dec 2018 20:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=N/IOJ1sFw5HVHMCHpAkM3FubGcGiVeXrtmZfXObhmUw=;
 b=B1ABOnLQRA6Uqz0CrJ+hy/ZHPLuhCD59igmA8tIMCanaub/zB/LeeGT2m3egvW4ptfsc
 0pBfLPtosksYYAV+bsNYapZZr+6cTHjGYZRfTvDA9k07EOrqI1iQ5uu6tkEzzqx5PWJY
 QFVTDUDwoFar+lPAgViJKoljMot+vqzuMAYcJbIxI8BEaR7tyJLZ6CpJJf0dzy6CF5Qp
 Hi6lPTu/EWaPV5OvlodXUcUNbE2sKiACxsLAjMjcdF5lJi+b2DKnAR/lz6Q+69enTYqD
 x2Q6WmTQYDjhhWwYeeyY/rZadsPxEjWky86d45yfy86Zy3eE1G1sB8BRuaWzXwGlNr6x mg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pct8qwr8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 20:56:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBIKuR3i010391
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 20:56:27 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBIKuPaA014844;
        Tue, 18 Dec 2018 20:56:25 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 12:56:25 -0800
Date:   Tue, 18 Dec 2018 12:56:38 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -V9 10/21] swap: Swapin a THP in one piece
Message-ID: <20181218205638.zsoumw2ob6fxl6ub@ca-dmjordan1.us.oracle.com>
References: <20181214062754.13723-1-ying.huang@intel.com>
 <20181214062754.13723-11-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214062754.13723-11-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=864
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 02:27:43PM +0800, Huang Ying wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1cec1eec340e..644cb5d6b056 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -33,6 +33,8 @@
>  #include <linux/page_idle.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/oom.h>
> +#include <linux/delayacct.h>
> +#include <linux/swap.h>

swap.h is already #included in this file.
