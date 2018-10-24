Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65735ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CE5206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VVybK9i9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CE5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJYBy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:54:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYBy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:54:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9OHNaDW134765;
        Wed, 24 Oct 2018 17:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=V+QQ1gINRuopmXmxmRlFg26D/3JcGGO9uoGhQv/zvWU=;
 b=VVybK9i9X8YAQM06nkSmBUllAOTPj/SL21gOERxrsfwoeQghxOfprMQXIiLDistrxJaW
 8kHUKfjWwLiAyJD4P2EJOFQbS3SubN8ljIOHdYmHKl/8fcIHIeNX6cenv8G9juxYfDEs
 LptBVopgdnjo9JELzpcKxMHJ05G2hSbx0M3hqS0DN2pjhN8gGznyh6XkptJ8WGXi2Ix8
 aDY/I3SEZzqXJtn0+bMJZQh/L/mglS3H1efLmBtO57cVj8LPYhJy+0exvglQR4iVBFii
 TSKO0vtiLrF9QkPVSVo3BL5PrDPqEYjw+hoJmrt7b24JbwhI9V7n51OSF6bQYD/dakej aA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qvyjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 17:25:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9OHPiYv027563
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 17:25:44 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9OHPhkX018399;
        Wed, 24 Oct 2018 17:25:43 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 10:25:43 -0700
Date:   Wed, 24 Oct 2018 10:25:49 -0700
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
Subject: Re: [PATCH -V6 06/21] swap: Support PMD swap mapping when splitting
 huge PMD
Message-ID: <20181024172549.xyevip5kclq2ig33@ca-dmjordan1.us.oracle.com>
References: <20181010071924.18767-1-ying.huang@intel.com>
 <20181010071924.18767-7-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010071924.18767-7-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:19:09PM +0800, Huang Ying wrote:
> +#ifdef CONFIG_THP_SWAP
> +/*
> + * The corresponding page table shouldn't be changed under us, that
> + * is, the page table lock should be held.
> + */
> +int split_swap_cluster_map(swp_entry_t entry)
> +{
> +	struct swap_info_struct *si;
> +	struct swap_cluster_info *ci;
> +	unsigned long offset = swp_offset(entry);
> +
> +	VM_BUG_ON(!IS_ALIGNED(offset, SWAPFILE_CLUSTER));
> +	si = _swap_info_get(entry);
> +	if (!si)
> +		return -EBUSY;

I think this return value doesn't get used anywhere?
