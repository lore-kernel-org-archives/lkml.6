Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E295C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359E420879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfAKBlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:41:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbfAKBlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:41:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E79858E664;
        Fri, 11 Jan 2019 01:41:54 +0000 (UTC)
Received: from x1.home (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1121001F45;
        Fri, 11 Jan 2019 01:41:54 +0000 (UTC)
Date:   Thu, 10 Jan 2019 18:41:53 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kvm@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio_pci: set TRACE_INCLUDE_PATH to fix the build error
Message-ID: <20190110184153.224baf5a@x1.home>
In-Reply-To: <9b1c9668-98cb-2a30-2fb0-b797b47aa9b6@ozlabs.ru>
References: <1546916883-25911-1-git-send-email-yamada.masahiro@socionext.com>
        <20190110144701.ah3hmedqmyqf5uzt@home.goodmis.org>
        <9b1c9668-98cb-2a30-2fb0-b797b47aa9b6@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 11 Jan 2019 01:41:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 12:13:35 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 11/01/2019 01:47, Steven Rostedt wrote:
> > On Tue, Jan 08, 2019 at 12:08:03PM +0900, Masahiro Yamada wrote:  
> >> ---
> >>
> >>  drivers/vfio/pci/trace.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
> >> index 228ccdb..4d13e51 100644
> >> --- a/drivers/vfio/pci/trace.h
> >> +++ b/drivers/vfio/pci/trace.h
> >> @@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
> >>  #endif /* _TRACE_VFIO_PCI_H */
> >>  
> >>  #undef TRACE_INCLUDE_PATH
> >> -#define TRACE_INCLUDE_PATH .
> >> +#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci  
> > 
> > Note, the reason why I did not show this method in the samples/trace_events/
> > is that there's one "gotcha" that you need to be careful about. It may not be
> > an issue here, but please be aware of it.
> > 
> > The words in TRACE_INCLUDE_PATH can be updated by C preprocessor defines. For
> > example, if for some reason you had:
> > 
> > #define pci special_pci
> > 
> > The above would turn into:
> > 
> >  ../../drivers/vfio/special_pci
> > 
> > and it wont build, and you will be left scratching your head wondering why.  

Thanks for the info Steve, that'd definitely be a head scratcher, but
it also seems really unlikely for this path.

> Lovely :) imho it is +1 for
> CFLAGS_vfio_pci_nvlink2.o += -I$(src)
> and a comment.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d1fc1176c055c9ec9c6ec4d113a284e0bad9d09a

Obviously we can still refine further, but I don't see this new piece
of information making a meaningful difference in the choice.  Thanks,

Alex
