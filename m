Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeCTPUw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:20:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55821 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeCTPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:20:50 -0400
X-Google-Smtp-Source: AG47ELupszTaZcbBnV6b/V0lKnx+L8YfSY8l0xp/4+f2paib0fIBSwiP4GPufD29+UbiXxtV0DLksA==
Date: Tue, 20 Mar 2018 09:20:43 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] RDMA/bnxt_re: Eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <20180320152043.GK19744@ziepe.ca>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-2-git-send-email-okaya@codeaurora.org>
 <20180320144801.GE19744@ziepe.ca>
 <d31c062b-5629-62b8-c291-c656e23c6f82@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31c062b-5629-62b8-c291-c656e23c6f82@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:00:49AM -0500, Sinan Kaya wrote:
> On 3/20/2018 9:48 AM, Jason Gunthorpe wrote:
> > On Mon, Mar 19, 2018 at 10:47:43PM -0400, Sinan Kaya wrote:
> >> Code includes wmb() followed by writel(). writel() already has a barrier on
> >> some architectures like arm64.
> >>
> >> This ends up CPU observing two barriers back to back before executing the
> >> register write.
> >>
> >> Since code already has an explicit barrier call, changing writel() to
> >> writel_relaxed().
> >>
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> >> index 8329ec6..4a6b981 100644
> >> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> >> @@ -181,10 +181,10 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
> >>  
> >>  	/* ring CMDQ DB */
> >>  	wmb();
> >> -	writel(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
> >> -	       rcfw->cmdq_bar_reg_prod_off);
> >> -	writel(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
> >> -	       rcfw->cmdq_bar_reg_trig_off);
> >> +	writel_relaxed(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
> >> +		       rcfw->cmdq_bar_reg_prod_off);
> >> +	writel_relaxed(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
> >> +		       rcfw->cmdq_bar_reg_trig_off);
> > 
> > Woah, this may not be safe..
> > 
> > The definition of writel_relaxed() is that it is fully unordered, so
> > the above two writes may change order now. Broadcom guys would have to
> > ack if that it is OK or not for their hardware.
> > 
> > In general this is not an OK approach for a mechanical
> > conversion.. Only the first writel can be convereted.
> > 
> > You need to check all your patches to make sure there are no
> > subsequent writel's in the places touched.
> 
> I paid special attention to this one and went to check the barriers
> document. According to the document, writes (whether it is relaxed or not)
> are always observed by the HW inorder with respect to each other.

Oh interesting, that document got revised to make writel_relaxed less
relaxed a few years ago, didn't know that. Thanks.

However, this is still not OK, the full code is:

        /* ring CMDQ DB */
        wmb();
        writel(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
               rcfw->cmdq_bar_reg_prod_off);
        writel(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
               rcfw->cmdq_bar_reg_trig_off);
done:
        spin_unlock_irqrestore(&cmdq->lock, flags);


And the definition of _relaxed allows the writes to order outside the
spinlock region, which is very likely to be wrong in this driver.

I'm not sure adding a mmiowb() just to use a writel_relaxed is any
sort of win though?

Jason
