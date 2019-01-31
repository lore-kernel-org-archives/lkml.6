Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06135C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE50218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p0V3MkQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfAaQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:52:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57662 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfAaQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:52:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0VGmwv4134823;
        Thu, 31 Jan 2019 16:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=96Zby0oLN4dn4XccAslysCBwFxo0rNHCR3wOe7W9OgQ=;
 b=p0V3MkQww/jirHzgdFHt5ZjfM4+HCLEnjHmE9DvM+MsgfjgErWjI/eJHoi4xSxF1gSg1
 DBonrh8dbPnsjX9/NfQ7bCxWv8+ixe3bwVyiDKyi4pgZAcHbyEyFEsrn9sKSHkREUYY6
 MUo82dRpAvROLQIXykNkqxJdws+v5rMElE5z5vMcCMIcDl/IRx9vEMxuW882qcAZJm3f
 /vLdQl+rJ30w6YIEgsNrvm9gcIG5ABFThw3kbQ67gIuN5wEhwLRKXOR8sG13OO7wdW4s
 w2Ijset2uTBr+1kMGBRFenbY0ZEngEGe8X+IWO/09uFoXtgYEHjcrYNwfX6ASPAW3zQo YA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6rhvjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 16:52:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0VGpxWm010269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 16:52:00 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0VGpuTi020831;
        Thu, 31 Jan 2019 16:51:56 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Jan 2019 08:51:56 -0800
Date:   Thu, 31 Jan 2019 11:52:15 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Do not allocate duplicate stack variables in
 shrink_page_list()
Message-ID: <20190131165215.i3iotkg64iz5ithp@ca-dmjordan1.us.oracle.com>
References: <154894900030.5211.12104993874109647641.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154894900030.5211.12104993874109647641.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:37:02PM +0300, Kirill Tkhai wrote:
> On path shrink_inactive_list() ---> shrink_page_list()
> we allocate stack variables for the statistics twice.
> This is completely useless, and this just consumes stack
> much more, then we really need.
> 
> The patch kills duplicate stack variables from shrink_page_list(),
> and this reduce stack usage and object file size significantly:
> 
> Stack usage:
> Before: vmscan.c:1122:22:shrink_page_list	648	static
> After:  vmscan.c:1122:22:shrink_page_list	616	static
> 
> Size of vmscan.o:
>          text	   data	    bss	    dec	    hex	filename
> Before: 56866	   4720	    128	  61714	   f112	mm/vmscan.o
> After:  56770	   4720	    128	  61618	   f0b2	mm/vmscan.o
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/vmscan.c |   44 ++++++++++++++------------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)


> @@ -1534,6 +1517,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  		.priority = DEF_PRIORITY,
>  		.may_unmap = 1,
>  	};
> +	struct reclaim_stat dummy_stat;
>  	unsigned long ret;
>  	struct page *page, *next;
>  	LIST_HEAD(clean_pages);
> @@ -1547,7 +1531,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  	}
>  
>  	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
> -			TTU_IGNORE_ACCESS, NULL, true);
> +			TTU_IGNORE_ACCESS, &dummy_stat, true);
>  	list_splice(&clean_pages, page_list);
>  	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
>  	return ret;

Stack usage stays the same coming from reclaim_clean_pages_from_list, with a
dummy variable added back after many were taken away in 3c710c1ad11b ("mm,
vmscan: extract shrink_page_list...").

But overall seems like a win to me.  You can add

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
