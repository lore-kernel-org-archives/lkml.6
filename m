Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA972C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78705218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Eu9dS9Qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfBKUtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:49:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfBKUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:49:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so112430pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PlofGPK1avjEsw/QmRNa8WCLcUE+7hBOnwTBt8jUCMw=;
        b=Eu9dS9QiH1mXijZ57nvyRLxXafPNQSUpE7A0KIWhVaD+0nVWDSJ5cRh6pntdBS25Mn
         ncuoRg637h9CDi94ozsiHQTU3r2IVpRskYTkXUtdRRAzvRo9CbKBEFSl5cUQSdM25YMk
         z414PObGbCTzSJ4dSf84jTlmJm1Q/G66C75pVMaYT5vaP+q8dESUpzF61VuzYS6W1df6
         /tyH9w4OTKPOT1k3H1QlCPSY/dqCdhMfM0NAvUEeMiwYiHNOS2fjwRGQKaRYzIm07Jdy
         6TXET+YjOF0a9uCkaWCLEG3rJJjq/W9jlQvqf1HpVn5iToEh+W3Zxwr31YZwiwu2CAnq
         vo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlofGPK1avjEsw/QmRNa8WCLcUE+7hBOnwTBt8jUCMw=;
        b=YaqG3/ZcD0a24ROi8o2zFvpFgGqyUvjvXB8//sESs79jEMo22xDzyoG1gZFLFGLPJu
         z2ExANjgdnhJCd06bBSdXiRnlNG4qaSnxxvce6/zx9+2GtfzK/oQUe7hGjIKflZE/uwM
         Dd/giaiczZuevLnSkJARokhIr27QkX/WVxB3GH7mVMH8F7u1w0aP6cvZO9C5g+ZGeT3X
         HTIlmtDqyUU/o090rHUmigKosWACjznQztzE/cC4Dlq6pNqepe1PlErA5x+mtO29dlLk
         Cw3fy/Lb+ctZU6+jbqyrC16OzTgsv4mOHVEqEnFhXHiOl+t1OuPcpFTAW5Z4Cty2O2nI
         y0lg==
X-Gm-Message-State: AHQUAuYPy7zmrmQWV/Rbb6BNatLmYo5L9spFXu/IJ0cL8z4K7gs/byUX
        pPC1M23tjqMhJjrdnAmt2t5EHSDFGxg=
X-Google-Smtp-Source: AHgI3IYfH06fT0ipXPMLWvSPQM928HXuTRSOXaSVyTRK0UlGdqpTooa3WUDvBDPtleSKIBtF+3HNfA==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr139735pfq.61.1549918187431;
        Mon, 11 Feb 2019 12:49:47 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t12sm11124722pgq.68.2019.02.11.12.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:49:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtIWP-0000or-RX; Mon, 11 Feb 2019 13:49:45 -0700
Date:   Mon, 11 Feb 2019 13:49:45 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190211204945.GF24692@ziepe.ca>
References: <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <20190211182649.GD24692@ziepe.ca>
 <20190211184040.GF12668@bombadil.infradead.org>
 <CAPcyv4j71WZiXWjMPtDJidAqQiBcHUbcX=+aw11eEQ5C6sA8hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j71WZiXWjMPtDJidAqQiBcHUbcX=+aw11eEQ5C6sA8hQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:58:47AM -0800, Dan Williams wrote:
> On Mon, Feb 11, 2019 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Feb 11, 2019 at 11:26:49AM -0700, Jason Gunthorpe wrote:
> > > On Mon, Feb 11, 2019 at 10:19:22AM -0800, Ira Weiny wrote:
> > > > What if user space then writes to the end of the file with a regular write?
> > > > Does that write end up at the point they truncated to or off the end of the
> > > > mmaped area (old length)?
> > >
> > > IIRC it depends how the user does the write..
> > >
> > > pwrite() with a given offset will write to that offset, re-extending
> > > the file if needed
> > >
> > > A file opened with O_APPEND and a write done with write() should
> > > append to the new end
> > >
> > > A normal file with a normal write should write to the FD's current
> > > seek pointer.
> > >
> > > I'm not sure what happens if you write via mmap/msync.
> > >
> > > RDMA is similar to pwrite() and mmap.
> >
> > A pertinent point that you didn't mention is that ftruncate() does not change
> > the file offset.  So there's no user-visible change in behaviour.
> 
> ...but there is. The blocks you thought you freed, especially if the
> system was under -ENOSPC pressure, won't actually be free after the
> successful ftruncate().

They won't be free after something dirties the existing mmap either.

Blocks also won't be free if you unlink a file that is currently still
open.

This isn't really new behavior for a FS.

Jason
