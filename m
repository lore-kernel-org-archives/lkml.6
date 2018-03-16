Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeCPWOF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:14:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39182 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeCPWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:14:02 -0400
X-Google-Smtp-Source: AG47ELvWfdXFK27VHWvA3NDcM9gRS3zqPrauMkeXuzQ/uxxEPCBVVys8cyCTwlbkwYdKkXrLuHAnMA==
Date: Fri, 16 Mar 2018 16:13:47 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steve Wise <swise@opengridcomputing.com>
Cc: "'Sinan Kaya'" <okaya@codeaurora.org>, netdev@vger.kernel.org,
        timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "'Steve Wise'" <swise@chelsio.com>,
        "'Doug Ledford'" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, "'Michael Werner'" <werner@chelsio.com>,
        "'Casey Leedom'" <leedom@chelsio.com>
Subject: Re: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
Message-ID: <20180316221347.GA958@ziepe.ca>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-19-git-send-email-okaya@codeaurora.org>
 <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 04:05:10PM -0500, Steve Wise wrote:
> > Code includes wmb() followed by writel(). writel() already has a barrier
> on
> > some architectures like arm64.
> > 
> > This ends up CPU observing two barriers back to back before executing the
> > register write.
> > 
> > Since code already has an explicit barrier call, changing writel() to
> > writel_relaxed().
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> NAK - This isn't correct for PowerPC.  For PowerPC, writeX_relaxed() is just
> writeX().  

?? Why is changing writex() to writeX() a NAK then?

> I was just looking at this with Chelsio developers, and they said the
> writeX() should be replaced with __raw_writeX(), not writeX_relaxed(), to
> get rid of the extra barrier for all architectures.

That doesn't seem semanticaly sane.

__raw_writeX() should not appear in driver code, IMHO. Only the arch
code can know what the exact semantics of that accessor are..

If ppc can't use writel_relaxed to optimize then we probably need yet
another io accessor semantic defined :(

Jason
