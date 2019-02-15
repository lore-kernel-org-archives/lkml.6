Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD36F21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wv6bEB26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390590AbfBOUjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:39:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfBOUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:39:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1FKdGJ7062143;
        Fri, 15 Feb 2019 20:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=rNtnO7rrhauRz+civhMrk0zTJ+CPDxwnD/u/os2j5wE=;
 b=wv6bEB26lL2CSNHY6O6O/J5Yb4U9YrV7plIBrbZAIALvEiingOLKroZ2Pn4BtR49u8Kn
 8BCIpW3j8o6263qqbqQ6OKZw74WuH3Hm7W8TQ35zIRUA5voJ5hP6YYfKRTg8SluMnKJd
 bD7vxsMseRLf+z6QknR3QN7m/zLs5KHKrro0mfvALFl6D+Ii6qUgsc8+aDQYsW3r/yTC
 3DKVBUyKeNoEtw73kpb/o7RKXd/ZmnyROx7pdLg4EllbJdtdFeekuhLQw9yOMQOMEBrF
 xJeQomlaC+BR+xm2V/Bqi5Ytld1f/nv3kDYcVgDcR3B0XYJrEZ/AlUi77GGD5Xltp3Ji 2w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhreeg05s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 20:39:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1FKd7Wa005035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 20:39:07 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1FKd6pF008310;
        Fri, 15 Feb 2019 20:39:06 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 20:39:05 +0000
Date:   Fri, 15 Feb 2019 15:39:27 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: Generalize putback scan functions
Message-ID: <20190215203926.ldpfniqwpn7rtqif@ca-dmjordan1.us.oracle.com>
References: <155014039859.28944.1726860521114076369.stgit@localhost.localdomain>
 <155014053725.28944.7960592286711533914.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155014053725.28944.7960592286711533914.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=851 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:35:37PM +0300, Kirill Tkhai wrote:
> +static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> +						     struct list_head *list)
>  {
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
> +	struct page *page;
> +	enum lru_list lru;
>  
> -	/*
> -	 * Put back any unfreeable pages.
> -	 */
> -	while (!list_empty(page_list)) {
> -		struct page *page = lru_to_page(page_list);
> -		int lru;
> -
> +	while (!list_empty(list)) {
> +		page = lru_to_page(list);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> -		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> +			list_del_init(&page->lru);

Why change to list_del_init?  It's more special than list_del but doesn't seem
needed since the page is list_add()ed later.

That postprocess script from patch 1 seems kinda broken before this series, and
still is.  Not that it should block this change.  Out of curiosity did you get
it to run?
