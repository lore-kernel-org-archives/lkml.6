Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E232CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1090222AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OH6iGjT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfBKTHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:07:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732057AbfBKTHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:07:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BJ4E2e093492;
        Mon, 11 Feb 2019 19:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1byxMH4cS5DA8jf3Vc8nsnHQYzCL4Eu4MKOQbBwKaQA=;
 b=OH6iGjT02b6/sqHMTKcJDBzQT4lRUfMvpdAE4yTmcBYmg6JDX6kzAyCh6yi/bhMvTvz+
 EZkNZW5nHkfFFrK0i9jWl06MAr/dTk8xbndOKqJBxETuBv2piWoc8SAwh+K8su1I3JfG
 h1KvmwVgAQMwEHdI1mwehooCsqH8CPZfbx7Y1O87wJpV42KSbutbbc8E1kp27qoRSiwu
 N5o6Pf0cxHeEzr5YQT3DCA67eG99QUBlFNYaKKI3kvTEmHdUJn5XLnLWSzpwQdPFRcR9
 Zh2IziawY916WZ5eebEABc+7Gt4lhELKgmZDTUl0mUlVdWUIviQKAObD8LIYGVC9lNKs Dw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qhredqpq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 19:06:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1BJ6SeF031440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 19:06:28 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1BJ6QlV020484;
        Mon, 11 Feb 2019 19:06:26 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 11:06:26 -0800
Date:   Mon, 11 Feb 2019 14:06:46 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
Message-ID: <20190211190646.j6pdxqirc56inbbe@ca-dmjordan1.us.oracle.com>
References: <20190211083846.18888-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211083846.18888-1-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=764 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:38:46PM +0800, Huang, Ying wrote:
> +struct swap_info_struct *get_swap_device(swp_entry_t entry)
> +{
> +	struct swap_info_struct *si;
> +	unsigned long type, offset;
> +
> +	if (!entry.val)
> +		goto out;

> +	type = swp_type(entry);
> +	si = swap_type_to_swap_info(type);

These lines can be collapsed into swp_swap_info if you want.

> +	if (!si)
> +		goto bad_nofile;
> +
> +	preempt_disable();
> +	if (!(si->flags & SWP_VALID))
> +		goto unlock_out;

After Hugh alluded to barriers, it seems the read of SWP_VALID could be
reordered with the write in preempt_disable at runtime.  Without smp_mb()
between the two, couldn't this happen, however unlikely a race it is?

CPU0                                CPU1

__swap_duplicate()
    get_swap_device()
        // sees SWP_VALID set
                                   swapoff
                                       p->flags &= ~SWP_VALID;
                                       spin_unlock(&p->lock); // pair w/ smp_mb
                                       ...
                                       stop_machine(...)
                                       p->swap_map = NULL;
        preempt_disable()
    read NULL p->swap_map
