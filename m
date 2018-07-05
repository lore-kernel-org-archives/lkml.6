Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B619523FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fLhqUOwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B619523FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeGESdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:33:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeGESdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:33:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w65ITTH3006912;
        Thu, 5 Jul 2018 18:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=LOAd6i1mtA6nLYTSEQwVjoZS/vScMO7HFCSBMYNzhlo=;
 b=fLhqUOwKRFlU0av8ISChzxh+4Wkk8tM1tfvE+WAyFcCakUWIjWqN+8rsNiDpFSL+TxCx
 mbP8aoUH5t4ZoPFBoyY4RU5/LnNM7AZhYcL735Zrq7RP6qVFrrxh78auAwTdaIe55gCB
 wK8Z79IoQUSF8epn4dpE8LQVZcdUGx+gpzR+9FEZ4kUESnOjUv1sdTvaVP7drnjfxKRr
 vvAuxnH1rKUO2aOPdH8ZMXr9AOpF20nYzsGqppUarm5P03571iObQ9IKowmylZSFN7vY
 wFnpbvcdMN2WxX/Cs2B3PZbtbNNP3pMDOaduIdfY6jthVwTxJ9WSTxIb2QQ8mHLjigRM ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2k0dnjq2mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 18:33:19 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w65IXHGs001474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 18:33:18 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w65IXFQu024030;
        Thu, 5 Jul 2018 18:33:15 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 11:33:15 -0700
Date:   Thu, 5 Jul 2018 11:33:18 -0700
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
Subject: Re: [PATCH -mm -v4 05/21] mm, THP, swap: Support PMD swap mapping in
 free_swap_and_cache()/swap_free()
Message-ID: <20180705183318.je4gd32awgh2tnb5@ca-dmjordan1.us.oracle.com>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180622035151.6676-6-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622035151.6676-6-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8945 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:51:35AM +0800, Huang, Ying wrote:
> +static unsigned char swap_free_cluster(struct swap_info_struct *si,
> +				       swp_entry_t entry)
...
> +	/* Cluster has been split, free each swap entries in cluster */
> +	if (!cluster_is_huge(ci)) {
> +		unlock_cluster(ci);
> +		for (i = 0; i < SWAPFILE_CLUSTER; i++, entry.val++) {
> +			if (!__swap_entry_free(si, entry, 1)) {
> +				free_entries++;
> +				free_swap_slot(entry);
> +			}
> +		}

Is is better on average to use __swap_entry_free_locked instead of
__swap_entry_free here?  I'm not sure myself, just asking.

As it's written, if the cluster's been split, we always take and drop the
cluster lock 512 times, but if we don't expect to call free_swap_slot that
often, then we could just drop and retake the cluster lock inside the innermost
'if' against the possibility that free_swap_slot eventually makes us take the
cluster lock again.

...
> +		return !(free_entries == SWAPFILE_CLUSTER);

                return free_entries != SWAPFILE_CLUSTER;
