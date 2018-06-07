Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wWMYC0zEGVs5UwAAmS7hNA
	; Thu, 07 Jun 2018 23:49:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C5736074D; Thu,  7 Jun 2018 23:49:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XX+IO9XN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C56C860115;
	Thu,  7 Jun 2018 23:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C56C860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeFGXtc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:49:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeFGXta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/V08lhPDDKvVq6ZCsqsKMRFLSvpEHDl8iFWD2zSE5aU=; b=XX+IO9XN/ZgaJMFIoo6syg5mL
        kZsgO4QgM0p0OFX99ZQa8dAJjNP/pxgMszoidya9ZB6skunho5BJbQpmg9iPn+ycg9duSABsGmX3B
        qycnCF1kB3fMpfJjWlXlSjvADPrH1jSoDfxvlJ61s9UhHlrAVcIjP+0qDOmMnRk8JWvCVKV8FMfBX
        K4TWhS5j9ykiIvYLYNfNWSTV5PW1z0GW8sAgP6EgusSfZProPmAiCEqPpYTdVkAIhWLWbVgebIKGi
        +1rgTJmWsQtKXPxpbH6av+dsEyghFO+0QNTo7MR4rSpbgAk8OWLNzN6XyWolH2Cf2lndzK8vtJbZC
        5nAhE9kew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fR4ek-0006gk-DO; Thu, 07 Jun 2018 23:49:26 +0000
Date: Thu, 7 Jun 2018 16:49:26 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] IB/mad: Use IDR instead of per-port list
Message-ID: <20180607234926.GA8260@bombadil.infradead.org>
References: <20180607190832.GA24370@bombadil.infradead.org>
 <20180607222646.GX14597@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607222646.GX14597@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 04:26:46PM -0600, Jason Gunthorpe wrote:
> On Thu, Jun 07, 2018 at 12:08:32PM -0700, Matthew Wilcox wrote:
> > 
> > Hans reports a bug where the mlx4 driver uses the MSB of the agent number
> > to store slave number, meaning we can only use agent numbers up to 2^24.
> > Fix this by using an IDR to assign the agent numbers and also look up the
> > agent when a MSD packet is received.
> > 
> > I've changed the locking substantially, so this may well have a
> > performance issue.  There are a few different possibilities for fixing
> > that, including moving to an RCU-based lookup.
> 
> I do like this better than the last series..
> 
> This are is somewhat performance sensitive and it would be nice to
> avoid this global lock.

OK, I wasn't sure whether it was worth it.

> What about using a read/write spinlock instead of the IDR internal
> lock? Then all the per-port reading threads calling find_mad_agent can
> run concurrently..

It'd be better to switch to RCU ... the IDR is RCU-safe, but the
version/class/method or OUI match isn't.  Do you have any feeling on
the relative frequency of the two types of "routing"?

Actually, I think we can use the radix tree data structure for the
version/class/method too ... that's going to take a little more work.
