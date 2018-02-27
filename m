Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeB0Vu3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbeB0Vu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:50:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E4321784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Tue, 27 Feb 2018 13:50:27 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pvcalls-front: 64-bit align flags
In-Reply-To: <b5a80b70-30b4-2fe3-5fc2-347ce58573f1@oracle.com>
Message-ID: <alpine.DEB.2.10.1802271349280.4239@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1802271150020.4239@sstabellini-ThinkPad-X260> <b7ec592a-bbd1-48d3-1a1f-92a8ed4a1e48@oracle.com> <alpine.DEB.2.10.1802271328140.4239@sstabellini-ThinkPad-X260> <b5a80b70-30b4-2fe3-5fc2-347ce58573f1@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018, Boris Ostrovsky wrote:
> On 02/27/2018 04:32 PM, Stefano Stabellini wrote:
> > On Tue, 27 Feb 2018, Boris Ostrovsky wrote:
> >> On 02/27/2018 02:54 PM, Stefano Stabellini wrote:
> >>> We are using test_and_* operations on the status and flag fields of
> >>> struct sock_mapping. However, these functions require the operand to be
> >>> 64-bit aligned on arm64. Currently, only status is 64-bit aligned.
> >>>
> >>> Make flags 64-bit aligned by introducing an explicit padding field.
> >>>
> >>> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> >>>
> >>> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> >>> index ca5b773..aa07b2a 100644
> >>> --- a/drivers/xen/pvcalls-front.c
> >>> +++ b/drivers/xen/pvcalls-front.c
> >>> @@ -78,6 +78,7 @@ struct sock_mapping {
> >>>  #define PVCALLS_STATUS_BIND          1
> >>>  #define PVCALLS_STATUS_LISTEN        2
> >>>  			uint8_t status;
> >>> +			uint8_t pad[7];
> >> Does this guarantee alignment (for either status or flag)?
> > Yes: status is part of a struct and a union. Unions and structs have the
> > alignment of their most aligned type. In this case they are 64-bit
> > aligned, as some of the fields are pointers.
> >
> > The padding makes sure that flags is 1+7 bytes from it.
> 
> OK.
> 
> What about adding  __attribute__((aligned(8))) to both (with a comment
> explaining reasoning)?

That's fine by me


> >
> >  
> >>>  		/*
> >>>  		 * Internal state-machine flags.
> >>>  		 * Only one accept operation can be inflight for a socket.
> 
