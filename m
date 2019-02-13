Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583FFC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2D0222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xpvLh6vW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394177AbfBMTUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:20:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389113AbfBMTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:20:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DJ8pqS065606;
        Wed, 13 Feb 2019 19:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=HcY3F6GG2jLp6WPTaAp0m8PyF3UbgW15wL3YqdVa5sg=;
 b=xpvLh6vWHJRf2xA44b0va2eRiW4TBJ9RdXBFGivGbrjDr4VNyENkKKXFXbN3Aw2hTx4H
 OeFSTby08V4aBQelridQjNpRzw28pIfaPHJG8Wao9xntoMu4mAMXt3gid7XrEbl1qQNa
 2zUpbVuj+oDWo1qnYPohYlHlDvEJFRp/rtbduxiFMQw38qF84oKghct3OxM3q4H7cQEH
 19mlsErljaBFoKk+E9Wj52G9xPv6ylrIcNDxoodPoYSFRQ3VoGGprVfcdFeauLSJzhxg
 bWfbipna13cYCJG5tWJZMLeMUZcbl4Rp0YuGYdkSMezpQeCNrGNImaz6Q8UlkfE5UHat 1Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qhree40va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 19:19:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1DJJpIK005039
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 19:19:52 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1DJJoP9014197;
        Wed, 13 Feb 2019 19:19:51 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 19:19:50 +0000
Date:   Wed, 13 Feb 2019 14:20:11 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: Generalize putback scan functions
Message-ID: <20190213192011.62vmk5wyvxufcn4k@ca-dmjordan1.us.oracle.com>
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
 <154998445694.18704.16751838197928455484.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154998445694.18704.16751838197928455484.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:14:16PM +0300, Kirill Tkhai wrote:
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
> -		VM_BUG_ON_PAGE(PageLRU(page), page);
> -		list_del(&page->lru);
> +	while (!list_empty(list)) {
> +		page = lru_to_page(list);
>  		if (unlikely(!page_evictable(page))) {
> +			list_del_init(&page->lru);
>  			spin_unlock_irq(&pgdat->lru_lock);
>  			putback_lru_page(page);
>  			spin_lock_irq(&pgdat->lru_lock);
>  			continue;
>  		}
> -
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
> +		VM_BUG_ON_PAGE(PageLRU(page), page);

Nit, but moving the BUG down here weakens it a little bit since we miss
checking it if the page is unevictable.


Maybe worth pointing out in the changelog that the main difference from
combining these two functions is that we're now checking for !page_evictable
coming from shrink_active_list, which shouldn't change any behavior since that
path works with evictable pages only.
