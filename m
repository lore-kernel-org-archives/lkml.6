Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D60ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60ED2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c8y1+kuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60ED2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbeGMTL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:11:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:11:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DIs4qU104584;
        Fri, 13 Jul 2018 18:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PE1fJjDp7o6NJu9qkCXbSvGzhvKes83GkLeN19ktyNo=;
 b=c8y1+kuSIdUn8MQ81Hkqmp6pKgSiZPZfEq11IRd8CLOa6f7qrlE7ygs5CLFAz5vIOkSk
 j9svQfaQA8YrtP3wWIJzhlRpvHLIqNHME8PTiA6bNpTwglSOIHOXbJr0kJ4xdjetcyxY
 nQUJmYA7djdGMD1ho+1DE0JeazFocGU0ru1lkThAgqhQLS8n8gDt9Q+kpfV/1q980fp3
 TtZfdCnUbNghbXtHW8U9qqJ/lxmPBtjFp0eBUuTHl/VHsuCiPUU37rjr+zI7ILLpICQ5
 f6OAco5NTH7vbgYMSOZYdxhYoNBUE6JfWXnjmm7csfutzTCox7PUpZdM5vb8Pmirjt4o Ig== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k2p7vrx96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 18:55:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DItgLQ006608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 18:55:42 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6DItf9R001871;
        Fri, 13 Jul 2018 18:55:41 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 11:55:41 -0700
Date:   Fri, 13 Jul 2018 11:55:45 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/6] mm/swapfile.c: Replace some #ifdef with IS_ENABLED()
Message-ID: <20180713185545.q6bixqbhsdwn3ulr@ca-dmjordan1.us.oracle.com>
References: <20180712233636.20629-1-ying.huang@intel.com>
 <20180712233636.20629-3-ying.huang@intel.com>
 <20180713183819.rszd4ybjfjemlaib@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713183819.rszd4ybjfjemlaib@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8953 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:38:19AM -0700, Daniel Jordan wrote:
> On Fri, Jul 13, 2018 at 07:36:32AM +0800, Huang, Ying wrote:
> > @@ -1260,7 +1257,6 @@ static void swapcache_free(swp_entry_t entry)
> >  	}
> >  }
> >  
> > -#ifdef CONFIG_THP_SWAP
> >  static void swapcache_free_cluster(swp_entry_t entry)
> >  {
> >  	unsigned long offset = swp_offset(entry);
> > @@ -1271,6 +1267,9 @@ static void swapcache_free_cluster(swp_entry_t entry)
> >  	unsigned int i, free_entries = 0;
> >  	unsigned char val;
> >  
> > +	if (!IS_ENABLED(CONFIG_THP_SWAP))
> > +		return;
> > +
> 
> VM_WARN_ON_ONCE(1) here too?

Nevermind, this branch goes away later in the series.
