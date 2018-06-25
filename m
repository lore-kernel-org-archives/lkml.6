Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B403C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A4E26116
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XUcBGu6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A4E26116
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeFYVBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:01:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44915 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbeFYVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:01:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so13390535wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=26PjOELIio5WeNRsiGoAf6Y3T2ZsCa//PtVnwBIEr9k=;
        b=XUcBGu6mwbuHFPPvI5e2zzKRITcH7b6102pNui9QX+hoXj3W5/09mWaWKya8E5ekK8
         9kbac1ju6Lf6A6bcQt0eudhSv+HeOlncdB03BYWYIvnMxg0PXZrL0LoYuEwiz1h31lO+
         CzTAYsUYEca3wRiz0fv6QgrjHNKdYbPaRF9gWI/hbJgIt5NLd4wOyJfxKP5y49m0tD8X
         w/Xh4IsmsBI8D5vYxnI4cnBieLYkqPtwxltX8qgvCICbTUR5O7y2dKqy7XKP14WGVRfZ
         XcUsUD9rTcrMIW+l5Vu68WjbwQNdK5Wrp93lPoJUovXBUuHScBkBD24wCt+bPasJdb3Q
         RJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=26PjOELIio5WeNRsiGoAf6Y3T2ZsCa//PtVnwBIEr9k=;
        b=PgwZdSMMqPcc6q1NxwSnKu3WmEM3kvUwOLAax50nsauhrydcHktxP7xDJi0sVdovew
         elN4JLfeV1WnmvmSEohPxAZwCUbN0IZziBC/8SezL1qjx8SJXszsAUm4LMHmXExaE8Vv
         Jayif3YVpmOnbeNC9UbQ3o2lFAhqK3sxLvkHTIUUN8Gmp7GH2ij/I38WVkFbAOU7831W
         ItQUJcHHdNzuCDJXCqXMI5sCoAOm7glrxt7T2fRmSGAkl1WM49bK2Vquk2XsTeKhjyVJ
         k2tnortv6LadBAHW76BJHlpG8IbpmYIGE7uRL8L3UqbCuIX+jQbIT9lW3vRw/MkwoCR/
         iY3g==
X-Gm-Message-State: APt69E12e3FXvmQAgbP3FcbYG9r3xPjunrhKIDR8pfTvqtw7QFczdO33
        oS/3RtSLZRo/vj/1wVpQ9ob5yA==
X-Google-Smtp-Source: AAOMgpezDiAau2EHreRSoKcnB7tLIDf17I9LQ2vlIpDp2YczLlU08hXI+OzjAQqk88Os+KJWKXYMBQ==
X-Received: by 2002:adf:8806:: with SMTP id d6-v6mr5167697wrd.41.1529960497263;
        Mon, 25 Jun 2018 14:01:37 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 12-v6sm323845wmt.19.2018.06.25.14.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 14:01:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fXYc8-0007Bn-MF; Mon, 25 Jun 2018 15:01:32 -0600
Date:   Mon, 25 Jun 2018 15:01:32 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Message-ID: <20180625210132.GB5381@ziepe.ca>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-3-longli@linuxonhyperv.com>
 <67b8afe7-f5e0-b36a-fcc1-87f1ae08eaa4@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b8afe7-f5e0-b36a-fcc1-87f1ae08eaa4@talpey.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 09:50:20PM -0400, Tom Talpey wrote:
> On 5/30/2018 3:47 PM, Long Li wrote:
> >From: Long Li <longli@microsoft.com>
> >
> >Add a function to allocate rdata without allocating pages for data
> >transfer. This gives the caller an option to pass a number of pages
> >that point to the data buffer.
> >
> >rdata is still reponsible for free those pages after it's done.
> 
> "Caller" is still responsible? Or is the rdata somehow freeing itself
> via another mechanism?
> 
> >
> >Signed-off-by: Long Li <longli@microsoft.com>
> >  fs/cifs/cifsglob.h |  2 +-
> >  fs/cifs/file.c     | 23 ++++++++++++++++++++---
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> >
> >diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> >index 8d16c3e..56864a87 100644
> >+++ b/fs/cifs/cifsglob.h
> >@@ -1179,7 +1179,7 @@ struct cifs_readdata {
> >  	unsigned int			tailsz;
> >  	unsigned int			credits;
> >  	unsigned int			nr_pages;
> >-	struct page			*pages[];
> >+	struct page			**pages;
> 
> Technically speaking, these are syntactically equivalent. It may not
> be worth changing this historic definition.

[] is a C99 'flex array', it has a different allocation behavior than
** and is not interchangeable..

Jason
