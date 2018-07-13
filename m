Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6580B208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gMObtUTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6580B208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbeGMUfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:35:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeGMUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:35:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DKE3hL002723;
        Fri, 13 Jul 2018 20:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=r2eGcLvxJyfHUzq88PzJSxb6V39QilnnaGbczdofsc4=;
 b=gMObtUTFRgwqLEK/J4/jemQyUfEjFxIUaXMhjrfi0E0RFXKw5tHqzo4XrSLKeqDS2S3c
 g/6M3vhDzOyxCW5YwDWMBdjGFw7T3QL8mZBr4nzPj1VjmSVzPizucVwyNHTFJEC9aV4p
 1ZbYyWbnlbuEv8uXALfM74zaoxkkM38FV8pDCoPtXzrZ1o2+8K0KMJn3tJRRGolwebGx
 EfrQdDFL5fWH0DXTGNMb99C1fOhYeH+Fvb7ceHSeprNgk40sEYNLcjiA24rXIp7zVZsP
 FfmadHKF20s1VxaPOhyp5KuVenhOdO106h4yniR3C0/VGmbZL+7lUmQiVcqx1i/1AOJV eg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k2p7e9782-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 20:18:56 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6DKItXC008407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 20:18:55 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6DKIsam020880;
        Fri, 13 Jul 2018 20:18:54 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 13:18:54 -0700
Date:   Fri, 13 Jul 2018 13:18:58 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 6/6] swap, put_swap_page: Share more between huge/normal
 code path
Message-ID: <20180713201858.zj43xzsnxqk3ozks@ca-dmjordan1.us.oracle.com>
References: <20180712233636.20629-1-ying.huang@intel.com>
 <20180712233636.20629-7-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712233636.20629-7-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8953 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=702
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 07:36:36AM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> In this patch, locking related code is shared between huge/normal code
> path in put_swap_page() to reduce code duplication.  And `free_entries
> == 0` case is merged into more general `free_entries !=
> SWAPFILE_CLUSTER` case, because the new locking method makes it easy.

Might be a bit easier to think about the two changes if they were split up.

Agree with Dave's comment from patch 1, but otherwise the series looks ok to
me.  I like the nr_swap_entries macro, that's clever.
