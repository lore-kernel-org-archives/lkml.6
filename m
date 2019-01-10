Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4801C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8432620879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XjxK1ipu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfAJNmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:42:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39750 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbfAJNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:42:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0ADcjFd193867;
        Thu, 10 Jan 2019 13:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UfXZEiC++YYzx6hQjwXCQSKZEfHaOn/f3XquOBw4btk=;
 b=XjxK1ipuhd7W1votCS6aLJuAxXo9I6T5cw+eEoZ18nuL7FZ4tvrjnfryZ/dUaGUoR1e8
 3Rx4dodWrvjhYN9xlKxc0h2WR0yDM+Yq8afrgd7E6XhZOluJxEVWGLthYcjZHm6SGNUn
 jGo0G9ZmiW63MHPy63agwxQfHfdt/yR7ogEYSf+CM+AUtVdzFS7Q/ircz4TokiPyjBib
 D7+rBRNdc2M/VFrYSEqBzxWstlhvhMicurfZjKaIak0yGBflNamOsUlmfGmzM1O60Wv5
 bSbtqQ9xracjNHJsumf0UAUDvNcPmvZMZa5VooimpZYSS2Sfmrsj6BhKeHwr0LRSwR2r PA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3e7dxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 13:42:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ADg6me025459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 13:42:06 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0ADg0Wu013477;
        Thu, 10 Jan 2019 13:42:00 GMT
Received: from kadam (/197.157.0.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 05:42:00 -0800
Date:   Thu, 10 Jan 2019 16:41:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org,
        Eric Christopher <echristo@google.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Message-ID: <20190110134139.GE1743@kadam>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
 <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
 <20190109213543-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109213543-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 09:36:41PM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 09, 2019 at 11:35:52AM +0100, Miguel Ojeda wrote:
> > On Tue, Jan 8, 2019 at 6:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Also for more context, see:
> > > commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
> > > dead store elimination")
> > 
> > By the way, shouldn't that barrier_data() be directly in compiler.h
> > too, since it is for both gcc & clang?
> > 
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > + Miguel
> > > Miguel, would you mind taking this into your compiler-attributes tree?
> > 
> > Sure, at least we get quickly some linux-next time.
> 
> 
> BTW why linux-next? shouldn't this go into 5.0 and stable? It's a bugfix after all.
> 

It doesn't hurt to put things in linux-next for a week and then 5.0 and
-stable.  Not a lot of testing happens on linux-next, but some does.

regards,
dan carpenter

