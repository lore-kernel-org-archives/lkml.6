Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27025C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EAF241A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c1xtV7H7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EAF241A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeGDANO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:13:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57538 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeGDANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:13:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6409YTn050565;
        Wed, 4 Jul 2018 00:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=BzukadhQ04gKih7+1oXr4gyvyNAPAJV4svfMhMses1I=;
 b=c1xtV7H75wCMioenvvjCM51ZaHSBKz33KIqYRuo7i9ibX+u7eG57u8ehoKMU94Hflmav
 CPoTMFPDZzItgxrUSI3ZJ41J/6RLyzOzI8+iq7kyFCOMZMGWRYdrKXS+RPYJMo+9SiO2
 +MWurMP5NBAtbBHswqVRlao+QIsBuV2lLjEF6JDefHMAx0olDvCwqvZvbATb8ghfMven
 tLeJRKBgS4BPuMKRMdKwevtuwM0t/IKLucAe85EuLemCGgHfolOgQ8S8sKkWZcplBPXs
 /DFPGVRLFwTrSFRsqnhOcFDCqIqwOZVTNs8IK0Ghjwtu9unVkZEIP/bWbi/NVV9ESLfW DQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k0dnjgudc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jul 2018 00:12:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w640CakU030323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jul 2018 00:12:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w640CXEv028002;
        Wed, 4 Jul 2018 00:12:33 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 17:12:33 -0700
Date:   Tue, 3 Jul 2018 17:12:35 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -mm -v4 08/21] mm, THP, swap: Support to read a huge swap
 cluster for swapin a THP
Message-ID: <20180704001235.w7xexi3jp6ostas5@ca-dmjordan1.us.oracle.com>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180622035151.6676-9-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622035151.6676-9-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807040000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:51:38AM +0800, Huang, Ying wrote:
> @@ -411,14 +414,32 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
...
> +			if (thp_swap_supported() && huge_cluster) {
> +				gfp_t gfp = alloc_hugepage_direct_gfpmask(vma);
> +
> +				new_page = alloc_hugepage_vma(gfp, vma,
> +						addr, HPAGE_PMD_ORDER);

When allocating a huge page, we ignore the gfp_mask argument.

That doesn't matter right now since AFAICT we're not losing any flags: gfp_mask
from existing callers of __read_swap_cache_async seems to always be a subset of
GFP_HIGHUSER_MOVABLE and alloc_hugepage_direct_gfpmask always returns a
superset of that.

But maybe we should warn here in case we end up violating a restriction from a
future caller.  Something like this?:

> +				gfp_t gfp = alloc_hugepage_direct_gfpmask(vma);
                                VM_WARN_ONCE((gfp | gfp_mask) != gfp,
					     "ignoring gfp_mask bits");
