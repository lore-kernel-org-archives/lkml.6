Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbeDLPPt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:15:49 -0400
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:43114 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753779AbeDLPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:15:45 -0400
Date: Thu, 12 Apr 2018 10:15:42 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180412142718.GA20398@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804121011350.11710@nuc-kabylake>
References: <20180411060320.14458-1-willy@infradead.org> <20180411060320.14458-3-willy@infradead.org> <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake> <20180411192448.GD22494@bombadil.infradead.org> <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
 <20180411235652.GA28279@bombadil.infradead.org> <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake> <20180412142718.GA20398@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfPPhOUX2aBKr8PY8jtnOwbM+GgqVU5y0KO71dJqc8STjL24yOSIoht0v70WqNWFvdfxPXsMmmUor5ir8clG4F087in4usbRsTKPN07r43vLerMJ1GFOp
 lyRCGt5M2UzTnoFNpFqf13S0J+aLZsWFAPzKeFHmCf41c4LFZlPsO1jJli+dHD158c7R3GO/Litu0olHkjEBtXVqhPXf6D4b+TJFfiMFKlX7vSI9P3qXJ2Lf
 kU8d6rD9gJF897GOPP6WXIOCYgaC77vIaj08aM7esD12bwnGKcS2PkjNw+Zj186yVATOhgmk7qNj5iSF1ZumXbLzvI9JftcE98foUMJcDtoWPoDD2+wWnfjR
 LSlmzjy/ycsYLRN4INr9YOFq6Vu8oHswm0zBMDtdgI9mCimRo+LhRqwqXKqL2ytCZyezcJ/GRqAN2AYXz5g4L+ZjdMkExMYU4jFWXK02Y1KLkD+XU45DDi18
 04bTv1n5K3Ra76ti
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018, Matthew Wilcox wrote:

> > Thus the next invocation of the fastpath will find that c->freelist is
> > NULL and go to the slowpath. ...
>
> _ah_.  I hadn't figured out that c->page was always NULL in the debugging
> case too, so ___slab_alloc() always hits the 'new_slab' case.  Thanks!

Also note that you can have SLUB also do the build with all debugging on
without having to use a command like parameter (like SLAB). That requires
CONFIG_SLUB_DEBUG_ON to be set. CONFIG_SLUB_DEBUG is set by default for
all distro builds. It only includes the debug code but does not activate
them by default. Kernel command line parameters allow you to selectively
switch on debugging features for specific slab caches so that you can
limit the latency variations introduced by debugging into the production
kernel. Thus subtle races may be found.
