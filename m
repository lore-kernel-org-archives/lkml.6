Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCFCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299B42184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aaszYhEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfBZA3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:29:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45206 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBZA3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:29:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1Q0TC4A067132;
        Tue, 26 Feb 2019 00:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YvExDddq4M/SVqwop6GFX1tVTd5CG7BGv3x/6RAwRNI=;
 b=aaszYhEUFFCSiV8WNnygJKWiyhPP2VG+uKFjpZaxiRPlro75d4rg7zh4tJVsK1ekmXUi
 Z600cPI2yxMDWaYBZF4i5enjfRLqHUl2QodzDk8VjOyOVU7eci3Xj75DEafP45zBpzDg
 wwkFAdpuGg1AJLP7yOR3SulOHnYRwpyVOEI77IwsT+pBSjKS1rtWnXqG8Mq7qYJ3Epkh
 0qhgqQtLDKmI7Tt98ejelfVEfR5nEXM60u1pvqslnv1mx+QDdUz9ZLailLoxh+BDIlpy
 86zviocBbjcEeu0TzPeESYp/l/Y7NoJaZhCkkGwxkAYsofs17wnYF1mij23Ptxp44Z8h Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qtxtrhhvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 00:29:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1Q0T6PJ016173
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 00:29:06 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1Q0T5tq011329;
        Tue, 26 Feb 2019 00:29:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 16:29:05 -0800
Date:   Mon, 25 Feb 2019 16:29:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
Message-ID: <20190226002904.GE6474@magnolia>
References: <20190221222123.GC6474@magnolia>
 <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
 <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
 <alpine.LSU.2.11.1902251214220.8973@eggly.anvils>
 <CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com>
 <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com>
 <86649ee4-9794-77a3-502c-f4cd10019c36@lca.pw>
 <CAHk-=wggjLsi-1BmDHqWAJPzBvTD_-MQNo5qQ9WCuncnyWPROg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggjLsi-1BmDHqWAJPzBvTD_-MQNo5qQ9WCuncnyWPROg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:07:12PM -0800, Linus Torvalds wrote:
> On Mon, Feb 25, 2019 at 4:03 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > Of course, that's just gcc. I have no idea what llvm ends up doing.
> >
> > Clang 7.0:
> >
> > # clang  -O2 -S -Wall /tmp/test.c
> > /tmp/test.c:46:6: warning: variable 'ret' is used uninitialized whenever 'if'
> > condition is false [-Wsometimes-uninitialized]
> 
> Ok, good.
> 
> Do we have any clang builds in any of the zero-day robot
> infrastructure or something? Should we?
> 
> And maybe this was how Dan noticed the problem in the first place? Or
> is it just because of his eagle-eyes?

He didn't say specifically how he found it, but I would guess he was
running smatch...?

--D

>                   Linus
