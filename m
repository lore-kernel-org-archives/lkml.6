Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB1218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UeDKl0Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfBFSwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:52:39 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46324 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfBFSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:52:35 -0500
Received: by mail-pl1-f172.google.com with SMTP id o6so3480865pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 10:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7kkFe7VdBrYTS6xqWBGiPDeMMQbpDhl/VS6LUReyUBQ=;
        b=UeDKl0KcK9Kh84HZYa+Kne8AvZDEZqJjKRI+db+e6qNigCbKK9k11LicvJ+v6NwMTL
         ikRkpAlhvpX+VwaJ5A5gEjhJJXGFoq3jYEi61RKLq4bHORjLX84v80uvJkRxuk3lIuPg
         qFRlyaK6OFtCH5ONOXEE/30mb9WgiDfve0J3SRETcJD0rNpKRgy1TX2J5tsyhLk0h0VD
         E7PqtsWopoi/2QtU/oSqwAPBSJKr25LnINrMPtLfGvojjf3wUW76x/pbiHk+Ro2ikOTW
         J5/jh+VVhlV11sOMR+jf+9CM9/YgCQWiKt4POuKeRh6GzUWk0/q9DXC6VSo2sjfDS0zZ
         pBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7kkFe7VdBrYTS6xqWBGiPDeMMQbpDhl/VS6LUReyUBQ=;
        b=N5HIG14gh+zabYPWL+n0zZuWhCkP9d21oF2C59VT7QwWlC6w11xKkDSdN91J37kh+G
         9qkW2kjxKcmTcE6+Yi482cOhg85LQv3fK2QPiqz6eOs0voiqXHgauqNSMaNatWAM2zkC
         zaByZfKuaeV+4JCGQG9migRqPDTaoHD5CAq8UQ1NjSy6+vhrskJwNanQllV6ypeGd5a8
         bM2VjrmCMCaiQsNQPWXE7drQQ9ciCYHk+jllGM2Pci8ksVfk1ps2WASFSSmZ+i5ds1tK
         6GbKsz7pYHQVGIvG7gnwsg2Oj9UoHIVE6i/8v1EQheGE/smjVB3Dxp2bkFBUd/qXaswk
         Mk5A==
X-Gm-Message-State: AHQUAuYdMgnbqPzn0haltYxkZJA5HvazCdu51oM/4qUI16yj9mEYxEwH
        uR7k3l0eQatcAvT1g9SNu9tiAm0XCDg=
X-Google-Smtp-Source: AHgI3IatX2FVUNy8ZnyYH2Fw5fpeSFfpCk+VVQB6B+D6cnVwuZwhknf53tZzWm/cIRrvMjAPeVeTaw==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr12071867plo.64.1549479155012;
        Wed, 06 Feb 2019 10:52:35 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 64sm9553472pff.101.2019.02.06.10.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:52:34 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grSJF-0004c2-Pk; Wed, 06 Feb 2019 11:52:33 -0700
Date:   Wed, 6 Feb 2019 11:52:33 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206185233.GE12227@ziepe.ca>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <20190206183503.GO21860@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206183503.GO21860@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:35:04AM -0800, Matthew Wilcox wrote:

> > Admittedly, I'm coming in late to this conversation, but did I miss the
> > portion where that alternative was ruled out?
> 
> That's my preferred option too, but the preponderance of opinion leans
> towards "We can't give people a way to make files un-truncatable".

I haven't heard an explanation why blocking ftruncate is worse than
giving people a way to break RDMA using process by calling ftruncate??

Isn't it exactly the same argument the other way?

Jason
