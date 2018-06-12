Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2A384C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFF0208C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="knq6XNSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFF0208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934518AbeFLVoj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:44:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51484 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933240AbeFLVog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:44:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CLfk6p175919;
        Tue, 12 Jun 2018 21:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2017-10-26;
 bh=snkJ+2z4jfxD8f73+zM+G809MNofqXyptkQiq4+DuIU=;
 b=knq6XNSBL2BIAUrSQCPHxaQg0dEFFQx1URXL8xi+e+UpdjkMTwzaUlEv1UQYnteq4eOC
 yngqTIF5f9qWwqR4H+6TNwtUksuB0E1lGXhAmg11YykKbZA4qKNBAZ1mEh0qP3usBOzE
 XjMPwqy0Vsawm89ejqjFZj3tOqumrJ4VG4z7liyKpCyrEiwBFEOe2iumD4TKcn4vwMpi
 SNL8PE4jOuo5coijJN5vfEr1cfVjRCgbgC9FFumgH1ADMqTisXzmbVuICPetoe/iSAlE
 r4bA3RqJuEqLbSmroGFB2EXrNb9g02tc7UmD2DByN5jVW3kGfoi+iOcmI9Es23Vb5j8Z DQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jjp6c80uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 21:44:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CLi4Vr007299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 21:44:05 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CLi24s003636;
        Tue, 12 Jun 2018 21:44:02 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 14:44:02 -0700
Date:   Tue, 12 Jun 2018 14:44:02 -0700
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
Subject: Re: [PATCH -mm -V3 03/21] mm, THP, swap: Support PMD swap mapping in
 swap_duplicate()
Message-ID: <20180612214402.cpjmcyjkkwtkgjyu@ca-dmjordan1.us.oracle.com>
References: <20180523082625.6897-1-ying.huang@intel.com>
 <20180523082625.6897-4-ying.huang@intel.com>
 <20180611204231.ojhlyrbmda6pouxb@ca-dmjordan1.us.oracle.com>
 <87o9ggpzlk.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9ggpzlk.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 09:23:19AM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> >> +#else
> >> +static inline int __swap_duplicate_cluster(swp_entry_t *entry,
> >
> > This doesn't need inline.
> 
> Why not?  This is just a one line stub.

Forgot to respond to this.  The compiler will likely choose to optimize out
calls to an empty function like this.  Checking, this is indeed what it does in
this case on my machine, with or without inline.


By the way, when building without CONFIG_THP_SWAP, we get

  linux/mm/swapfile.c:933:13: warning: ‘__swap_free_cluster’ defined but not used [-Wunused-function]
   static void __swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
               ^~~~~~~~~~~~~~~~~~~
