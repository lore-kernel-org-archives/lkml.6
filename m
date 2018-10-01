Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA47C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40832089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ucECLyhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40832089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeJBAA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:00:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42176 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJBAA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:00:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w91HIodp026258;
        Mon, 1 Oct 2018 17:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3DTICWIhX0nyUPI3gXGrZ/Au13Pls9x8RN6kOABT+nc=;
 b=ucECLyhKU5PbWOZ0g9VvDcrOrpsB+huFDuQzhLQcbpEs6ZPxHhk6xJX8Msev02C7m9i5
 lAveQvvPhembFyFAWyx7exO3tHQKr/C8OrJEvoHQzyp+3Yy9sxIhr2QeWnSwsxdhkuTc
 vyHvxAbNZoTTx+YQLfqM0ZPZQ7pO/k1FoembNYqW6V9bMaZI1IgD2VoC5EdizN1Y8yQJ
 Z7bZ8AW/4oHEAUjjbYcBM5JEiwe3bpzTZzhprMDMUTFFIhmxw++9s0NxxIcrz/0TpIJi
 WAyMWMMjsbdkdzTCS5DCdAdYrlRpOEr0E0EiRh7HdDUWLxC8HxbrhTlCQtEp+y1j2GoL Bg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mt1bprsum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 17:21:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w91HLJ2p011764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 17:21:19 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w91HLGHK031677;
        Mon, 1 Oct 2018 17:21:16 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Oct 2018 10:21:16 -0700
Date:   Mon, 1 Oct 2018 10:21:18 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V5 RESEND 03/21] swap: Support PMD swap mapping in
 swap_duplicate()
Message-ID: <20181001172118.5kutcg33v7ipje2q@ca-dmjordan1.us.oracle.com>
References: <20180925071348.31458-1-ying.huang@intel.com>
 <20180925071348.31458-4-ying.huang@intel.com>
 <20180925191953.4ped5ki7u3ymafmd@ca-dmjordan1.us.oracle.com>
 <874lecifj4.fsf@yhuang-dev.intel.com>
 <20180926145145.6xp2kxpngyd54f6i@ca-dmjordan1.us.oracle.com>
 <87r2hfhger.fsf@yhuang-dev.intel.com>
 <20180927211238.ly3e7cyvfu3rswcv@ca-dmjordan1.us.oracle.com>
 <87lg7mf30o.fsf@yhuang-dev.intel.com>
 <20180928213224.tjff2rtfmxmnz5nq@ca-dmjordan1.us.oracle.com>
 <877ej5f7oq.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ej5f7oq.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9033 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 08:50:29AM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > The error handling in __swap_duplicate (before this series) still leaves
> > something to be desired IMHO.  Why all the different returns when callers
> > ignore them or only specifically check for -ENOMEM or -EEXIST?  Could maybe
> > stand a cleanup, but outside this series.
> 
> Yes.  Maybe.  I guess you will work on this?

Sure, I'll see how it turns out.
