Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BFBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E4621479
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIeAx4XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfABVAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:00:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfABVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M4IGlqEQFNqwliRsSyTfnKKOspsRl2QEciHUCHKHBN0=; b=mIeAx4XVHfAq1tTMDZX8ChgGK
        kAxwG2LXSgH6Wm6fsEETnxI6IlDSIePpmkA7ns1A8K823CvsVsHYSxnUB8QfOrqgIBqJM4KVFslHk
        nwJ+Vt30zxTIv3iZU27h7W75GbjIGoqKl3XksGTd0xd6alAOyb+Yaj1p7L46p/96fXy14n8yY5ElO
        SKqBGLBv3j71+qDvoBOVHjrXfCnj/wTGscOhZ3LKCEnbPdMeD+L2K8/fpY1AWddSKfnqPv62015sO
        tGsuHjrT9OC5VUqRPd+Yhq3Zs6aRBwjs50rKDQctY9vWrxWUtFRdliQs4CdjjfyF10lhV2nwKl6z9
        a5qqLWuJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gencm-0005xD-EQ; Wed, 02 Jan 2019 21:00:24 +0000
Date:   Wed, 2 Jan 2019 13:00:24 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
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
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Message-ID: <20190102210024.GJ6310@bombadil.infradead.org>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-4-mst@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 03:57:58PM -0500, Michael S. Tsirkin wrote:
> @@ -875,6 +893,8 @@ to the CPU containing it.  See the section on "Multicopy atomicity"
>  for more information.
>  
>  
> +
> +
>  In summary:
>  
>    (*) Control dependencies can order prior loads against later stores.

Was this hunk intentional?
