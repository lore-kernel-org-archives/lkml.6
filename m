Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iisMDFAAHVt3EwAAmS7hNA
	; Sun, 10 Jun 2018 10:43:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3ABB060850; Sun, 10 Jun 2018 10:43:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+FZDv6W"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AF1C76074D;
	Sun, 10 Jun 2018 10:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF1C76074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeFJKnP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 06:43:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeFJKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 06:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eepF24QiBLgDmsEEzfuNY9KDl9wNPo0v7GnpGJZtkIE=; b=p+FZDv6WgZHxc0VhD5rP+nJ59
        PhKLiddSf/ysM56l4RNsqLGWprD3JiowzrsdBFKdI/eL+GEH+q74a7SC/cLAYh4LW4xk5StwOrN9f
        RV+6N4CNzGQB25qDGxmILif/HcTPO4pz4wQha5tstJZLSjdhjvKeZCLqQzQJnfnqgAN72Jj5cOuRF
        HNbIGT0CpmZFXH9jC8XuO42KcrDxUFZEfh7BSWgL7Jy4+NTybumur7xpBvc0LLyisdk88ZFXcbxbB
        2pvInqyH5sJIIV54FR9Tl6MnqtFyM8QTZiGr1T9F/mPR1MeB1ahDS83xSEKEexQJJrP4sXMqUqgAE
        q7LMOzBIg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRxoQ-00052f-4a; Sun, 10 Jun 2018 10:43:06 +0000
Date: Sun, 10 Jun 2018 03:43:05 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180610104305.GA9284@bombadil.infradead.org>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180610063028.GH12407@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610063028.GH12407@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 09:30:28AM +0300, Leon Romanovsky wrote:
> 1. IBTA spec doesn't talk at all about the size of TransactionID, more
> on that in section "13.4.6.4 TRANSACTION ID USAGE", the specification
> says: "The contents of the TransactionID (TID) field are implementation-
> dependent. So let's don't call it mlx4 bug.

I was loosely paraphrasing the original bug report; suggested rewording
of the comments gratefully accepted.

> 2. The current implementation means that in mlx5-only network we will
> still have upto (1 << 24) TIDs. I don't know if it is really important,
> but worth to mention.

Actually, the TIDs will be up to 2^56.  We're limited to 2^24 clients,
each of which can send up to 2^32 messages.
