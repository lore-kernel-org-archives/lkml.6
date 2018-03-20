Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCTPYH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:24:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46832 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:24:05 -0400
X-Google-Smtp-Source: AG47ELvqOekICeeO1kRY01idekjtQ5u1tmGEsxzP22G91yHA2VkrnaA6Xfz/NWo6ACEMh8iJzj3p8w==
Date: Tue, 20 Mar 2018 09:23:59 -0600
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
Message-ID: <20180320152359.GL19744@ziepe.ca>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-2-git-send-email-okaya@codeaurora.org>
 <20180320144801.GE19744@ziepe.ca>
 <d31c062b-5629-62b8-c291-c656e23c6f82@codeaurora.org>
 <3e6cfa25-6b9f-24ff-499a-6df2740b658b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6cfa25-6b9f-24ff-499a-6df2740b658b@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:08:16AM -0500, Sinan Kaya wrote:

> Never mind, it will break some architectures. I'll only change the first one.
> 
>  (1) On some systems, I/O stores are not strongly ordered across all CPUs, and
>      so for _all_ general drivers locks should be used and mmiowb() must be
>      issued prior to unlocking the critical section.

I think the kernel could do well to have a spin_unlock_mmiowb()
function. We have this patern quite a bit.

Arches like x86 can just make it == spin_unlock, while PPC and ARM can
add their extra barriers.

Then we can safely and efficiently use _realxed within such a
spinlock region.

Jason
