Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED0BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA46222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qsArAo4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfBOWNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:13:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfBOWNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:13:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1FMCRp6126565;
        Fri, 15 Feb 2019 22:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=o+Le5xqB8mfOGViqpY9sITB2QN9I9Wu1PwGPQLk7yIg=;
 b=qsArAo4B7Rj+kDj8eFEmCJGgFYwRModtDjazZ6Tt805grVDzAJ9Oof4kU455phrQ4+ir
 bX3+AcLybQYtXmOQoHYy2egyPP+0OGCTE+KuKO7DU97UDiTDj7yi6gp+qhdxozG8s1Qc
 bwLYx8LeiseOq+CiJBBR8A23nD7p/CCCoTHDZnL5ml+K3VJ6PZPdjobLsuRBR98CcplH
 8hAHz6Purt59SGnB1STJG3FVOBAYKd0QPICcZoMx9UFanVLZoDGr8Yh3qTkZDStMuoJZ
 aYnJPYtTK7VeW8ME8rGRmnS2eJxc7ppFCyQRpbtYqozCrPT/c8/DBkZSS3pavvngTJs0 Tw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrem09xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 22:13:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1FMDFlJ000547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 22:13:15 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1FMDFL7028907;
        Fri, 15 Feb 2019 22:13:15 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 22:13:14 +0000
Date:   Fri, 15 Feb 2019 17:13:36 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] mm: Generalize putback scan functions
Message-ID: <20190215221335.32zqxhwtcr2kmgku@ca-dmjordan1.us.oracle.com>
References: <155014039859.28944.1726860521114076369.stgit@localhost.localdomain>
 <155014053725.28944.7960592286711533914.stgit@localhost.localdomain>
 <20190215203926.ldpfniqwpn7rtqif@ca-dmjordan1.us.oracle.com>
 <b2fcd214-52a5-6284-81b9-8a09de27fbea@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fcd214-52a5-6284-81b9-8a09de27fbea@virtuozzo.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:01:05PM +0000, Kirill Tkhai wrote:
> On 15.02.2019 23:39, Daniel Jordan wrote:
> > On Thu, Feb 14, 2019 at 01:35:37PM +0300, Kirill Tkhai wrote:
> >> +static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >> +						     struct list_head *list)
> >>  {
> >>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> >> +	int nr_pages, nr_moved = 0;
> >>  	LIST_HEAD(pages_to_free);
> >> +	struct page *page;
> >> +	enum lru_list lru;
> >>  
> >> -	/*
> >> -	 * Put back any unfreeable pages.
> >> -	 */
> >> -	while (!list_empty(page_list)) {
> >> -		struct page *page = lru_to_page(page_list);
> >> -		int lru;
> >> -
> >> +	while (!list_empty(list)) {
> >> +		page = lru_to_page(list);
> >>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> >> -		list_del(&page->lru);
> >>  		if (unlikely(!page_evictable(page))) {
> >> +			list_del_init(&page->lru);
> > 
> > Why change to list_del_init?  It's more special than list_del but doesn't seem
> > needed since the page is list_add()ed later.
> 
> Not something special is here, I'll remove this _init.
>  
> > That postprocess script from patch 1 seems kinda broken before this series, and
> > still is.  Not that it should block this change.  Out of curiosity did you get
> > it to run?
> 
> I fixed all new warnings, which come with my changes, so the patch does not make
> the script worse.
> 
> If you change all already existing warnings by renaming variables in appropriate
> places, the script will work in some way. But I'm not sure this is enough to get
> results correct, and I have no a big wish to dive into perl to fix warnings
> introduced by another people, so I don't plan to do with this script something else.

Ok, was asking in case I was doing something wrong.

With the above change, for the series, you can add

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
