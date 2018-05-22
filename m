Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbeEVRIL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbeEVRIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:08:09 -0400
Date: Tue, 22 May 2018 18:08:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/9] docs: Add Generic Counter interface
 documentation
Message-ID: <20180522180805.2b61f0ed@archlinux>
In-Reply-To: <20180521134729.GB5723@sophia>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
        <aa4d62315bb11ddc66d0e1a685c81b1721ffe624.1526487615.git.vilhelm.gray@gmail.com>
        <20180520163109.22b11af8@archlinux>
        <20180521134729.GB5723@sophia>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> >> +
> >> +COUNT
> >> +-----
> >> +A Count represents the count data for a set of Signals. The Generic
> >> +Counter interface provides the following available count data types:
> >> +
> >> +* COUNT_POSITION_UNSIGNED:
> >> +  Unsigned integer value representing position.
> >> +
> >> +* COUNT_POSITION_SIGNED:
> >> +  Signed integer value representing position.  
> >
> >Just a thought: As the '0' position is effectively arbitrary is there any
> >actual difference between signed and unsigned? If we defined all counters
> >to be unsigned and just offset any signed ones so the range still fitted
> >would we end up with a simpler interface - there would be no real loss
> >of meaning that I can see..  I suppose it might not be what people expect
> >though when they see their counters start at a large positive value...  
> 
> This is something I've been on the fence about for a while. I would
> actually prefer the interface to have simply a COUNT_POSITION data type
> to represent position and leave it as unsigned; distinguishing between
> signed and unsigned position seems ultimately arbitrary given that it's
> mathematically just an offset as you have pointed out.
> 
> If we were to go down this route, then we'd have a count value that may
> always be represented using an unsigned data type, with an offset value
> that may always be represented using a signed data type -- the
> relationship being such: position = count + offset. Is that correct?

Given the positions are all arbitrary (such as limits etc) there is no
real need to have 0 as in anyway special.  So you could just apply an
offset to everything then don't make them visible to userspace at all.

> 
> My reason for giving the option for either signed or unsigned position
> was to help minimize the work userspace would have to do in order to get
> the value in which they're actually interested. I suppose it was a
> question of how abstract I want to make the interface -- although,
> making it simpler for userspace put more of a burden on the kernel side.
> 
> However, the "offset" value route may actually be more robust in the end
> because userspace would have to know whether they want a signed or
> unsigned position regardless in order to parse, so with count and offet
> defined we know they will always be unsigned and signed respectively.

Hmm. It's not obvious to me which is the best option.

> 
> >
> >
> >
> >  
> >> +
> >> +A Count has a count function mode which represents the update behavior
> >> +for the count data. The Generic Counter interface provides the following
> >> +available count function modes:
> >> +
> >> +* Increase:
> >> +  Accumulated count is incremented.
> >> +
> >> +* Decrease:
> >> +  Accumulated count is decremented.
> >> +
> >> +* Pulse-Direction:
> >> +  Rising edges on quadrature pair signal A updates the respective count.
> >> +  The input level of quadrature pair signal B determines direction.
> >> +  
> >Perhaps group the quadrature modes for the point of view of this document?
> >Might be slightly easier to read?  
> >
> >* Quadrature Modes
> >
> >  - x1 A: etc.
> >  
> >> +* Quadrature x1 A:
> >> +  If direction is forward, rising edges on quadrature pair signal A
> >> +  updates the respective count; if the direction is backward, falling
> >> +  edges on quadrature pair signal A updates the respective count.
> >> +  Quadrature encoding determines the direction.
> >> +
> >> +* Quadrature x1 B:
> >> +  If direction is forward, rising edges on quadrature pair signal B
> >> +  updates the respective count; if the direction is backward, falling
> >> +  edges on quadrature pair signal B updates the respective count.
> >> +  Quadrature encoding determines the direction.
> >> +
> >> +* Quadrature x2 A:
> >> +  Any state transition on quadrature pair signal A updates the
> >> +  respective count. Quadrature encoding determines the direction.
> >> +
> >> +* Quadrature x2 B:
> >> +  Any state transition on quadrature pair signal B updates the
> >> +  respective count. Quadrature encoding determines the direction.
> >> +
> >> +* Quadrature x2 Rising:
> >> +  Rising edges on either quadrature pair signals updates the respective
> >> +  count. Quadrature encoding determines the direction.  
> >
> >This one I've never met.  Really? There are devices who do this form
> >of crazy? It gives really uneven counting and I'm failing to see when
> >it would ever make sense...  References for these odd corner cases
> >would be good.
> >
> >
> >__|---|____|-----|____
> >____|----|____|-----|____
> >
> >001122222223334444444  
> 
> That's the same reaction I had when I discovered this -- in fact the
> STM32 LP Timer is the first time I've come across such a quadrature
> mode. I'm not sure of the use case for this mode, because positioning
> wouldn't be precise as you've pointed out. Perhaps Fabrice or Benjamin
> can probe the ST guys responsible for this design choice to figure out
> the rationale.

Hmm.  My inclination would be to not support it unless someone can up
with a meaningful use.  We are adding ABI (be it not much) for a case
that to us makes no sense.

Looks rather like the sort of thing that is a side effect of the
implementation rather than deliberate.

> 
> I'm leaving in these modes for now, as they do exist in the STM32 LP
> Timer, but it does make me curious what the intentions for them were
> (perhaps use cases outside of traditional quadrature encoder
> positioning).
> 

Sure if there is a usecase then fair enough.

Jonathan
