Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEVMwO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:52:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbeEVMwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:52:12 -0400
Date: Tue, 22 May 2018 14:52:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Message-ID: <20180522145208.310143ea.cohuck@redhat.com>
In-Reply-To: <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <20180509154822.23510-3-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 15:32:48 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/05/2018 18:10, Cornelia Huck wrote:
> > On Fri, 11 May 2018 11:33:35 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 09/05/2018 17:48, Cornelia Huck wrote:  

> >>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >>>    
> >>>    	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
> >>>    
> >>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> >>> +	/*
> >>> +	 * Start processing with the clear function, then halt, then start.
> >>> +	 * We may still be start pending when the caller wants to clean
> >>> +	 * up things via halt/clear.
> >>> +	 */  
> >> hum. The scsw here does not reflect the hardware state but the
> >> command passed from the user interface.
> >> Can we and should we authorize multiple commands in one call?
> >>
> >> If not, the comment is not appropriate and a switch on cmd.fctl
> >> would be a clearer.  
> > There may be multiple functions specified, but we need to process them
> > in precedence order (and clear wins over the others, so to speak).
> > Would adding a sentence like "we always process just one function" help?  
> 
> Why should we allow multiple commands in a single call ?
> It brings no added value.
> Is there a use case?
> Currently QEMU does not do this and since we only have the SCSH there
> is no difference having the bit set alone or not alone.

I found this to be a very easy way to implement halt/clear. This still
holds true if we switch to some kind of capabilities for this (did not
have time to look at this further, though).

As we have the fctl field anyway, I'm in favour of processing this all
in one function.
