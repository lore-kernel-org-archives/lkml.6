Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeC2RC3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:02:29 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46772 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeC2RC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:02:27 -0400
To: James Smart <james.smart@broadcom.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-5-logang@deltatee.com>
 <15f4d135-7600-02b3-f50f-ed8deddd7b98@broadcom.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bd62c2e6-558c-e314-177f-c95cf842c741@deltatee.com>
Date: Thu, 29 Mar 2018 11:02:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <15f4d135-7600-02b3-f50f-ed8deddd7b98@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, james.smart@broadcom.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 4/4] nvmet-fc: Use new SGL alloc/free helper for requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/18 10:52 AM, James Smart wrote:
> overall - I'm a little concerned about the replacement.
> 
> I know the code depends on the null/zero checks in 
> nvmet_fc_free_tgt_pgs() as there are paths that can call them twice.  
> Your replacement in that routine is fine, but you've fully removed any 
> initialization to zero or setting to zero on free. Given the structure 
> containing the req structure is reused, I'd rather that that code was 
> left in some way... or that nvmet_req_free_sgl() or 
> nvmet_fc_free_tgt_pgs() was updated to set req->sg to null and (not sure 
> necessary if req->sg is null) set req->sg_cnt to 0.

Ok, I can ensure we zero and NULL those in nvmet_req_free_sgl().

> also - sg_cnt isn't referenced as there is an assumption that: transfer 
> length meant there would be (transfer length / PAGESIZE + 1 if partial 
> page) pages allocated and sg_cnt would always equal that page cnt  thus 
> the fcpreq->sgXXX setting behavior in nvmet_fc_transfer_fcp_data().   Is 
> that no longer valid ?   I may not have watched closely enough when the 
> sgl_alloc() common routine was introduced as it may have invalidated 
> these assumptions that were true before.

Per the bug in the previous patch, I don't think that was ever a valid
assumption. It doesn't have anything to do with the sgl_alloc change
either. The dma_map interface is allowed to merge SGLs and that's why it
can return fewer nents than it was passed. I'm not sure how many or
which DMA ops actually do this which is why it hasn't actually
manifested itself as a bug; but it is part of how the interface is
specified to work.

I think we need to store the sg_map_cnt separately and use it instead of
the calculation based on the transfer length. But this is really a fix
that should be rolled in with the previous patch. If you can point me to
where this needs to change I can update my patch, or if you want to fix
it yourself go ahead.

Thanks,

Logan
