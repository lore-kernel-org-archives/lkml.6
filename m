Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEFAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E421904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xS5/nDQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391339AbfBMTNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:13:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56142 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbfBMTNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:13:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DJ8eAo065506;
        Wed, 13 Feb 2019 19:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SVzrTYMXSEVBrO+ckDrkMcCbukCBiTGAwPndsX9SVvQ=;
 b=xS5/nDQIE6IsR36HV54ROP/TKiJNh/q/lYy++yP4NECWOcDRSsGl1e055VqzMvfD3ND+
 DCrevzsyJwWOJPcvPqKenldvEzn10cD/2yKO68SljPVnLWz+NHk9XfMGl63VMtWmp6yM
 GvZRNz6Qkx/fL8xQ5D/KwOQMmLJkZJVh+/3+EjXg6RPHxQ2nmMSwH3yQlGx7fUsA/d33
 xVmng7ZXZ29IoatPUpsWkeZcMvkTdK0PtvJjL+Jiv0MrxFZWLpyUjDl+wmQGtV/Ggay4
 p8YS7z5ZNSrXwayWpVSGVjpoCwSQE8RuXDUoJ9sowePQSNE7qWOdvZezoYUbvY7PNKxl WA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qhree3yx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 19:13:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1DJDTYj019118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 19:13:30 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1DJDRhh027449;
        Wed, 13 Feb 2019 19:13:28 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 11:13:27 -0800
Date:   Wed, 13 Feb 2019 14:13:48 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: Move nr_deactivate accounting to
 shrink_active_list()
Message-ID: <20190213191348.tpwwu3m7o3cmg7ma@ca-dmjordan1.us.oracle.com>
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
 <154998444590.18704.9387109537711017589.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154998444590.18704.9387109537711017589.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:14:05PM +0300, Kirill Tkhai wrote:
> We know, which LRU is not active.

s/,//

> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/vmscan.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 84542004a277..8d7d55e71511 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2040,12 +2040,6 @@ static unsigned move_active_pages_to_lru(struct lruvec *lruvec,
>  		}
>  	}
>  
> -	if (!is_active_lru(lru)) {
> -		__count_vm_events(PGDEACTIVATE, nr_moved);
> -		count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
> -				   nr_moved);
> -	}
> -
>  	return nr_moved;
>  }
>  
> @@ -2137,6 +2131,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  
>  	nr_activate = move_active_pages_to_lru(lruvec, &l_active, &l_hold, lru);
>  	nr_deactivate = move_active_pages_to_lru(lruvec, &l_inactive, &l_hold, lru - LRU_ACTIVE);
> +
> +	__count_vm_events(PGDEACTIVATE, nr_deactivate);
> +	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);

Nice, you're using the irq-unsafe one since irqs are already disabled.  I guess
this was missed in c3cc39118c361.  Do you want to insert a patch before this
one that converts all instances of this pattern in vmscan.c over?

There's a similar oversight in lru_lazyfree_fn with count_memcg_page_event, but
that'd mean __count_memcg_page_event which is probably overkill.
