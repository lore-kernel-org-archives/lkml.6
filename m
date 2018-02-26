Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeBZWS0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:18:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:60989 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeBZWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:18:25 -0500
Date: Mon, 26 Feb 2018 16:17:48 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 06/21] powerpc: Avoid comparison of unsigned long >= 0 in __access_ok
Message-ID: <20180226221747.GV21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-7-malat@debian.org> <8862c1e1-d161-3410-1b2a-502ad06cef57@c-s.fr> <6cba215c-127e-f3eb-b525-773b6aed0eb7@c-s.fr> <CA+7wUswNE1ydgeESpG8Dqtz4SGFjZZJJiPp+SHN8Z1qtBtPLLQ@mail.gmail.com> <CA+7wUsx047shRJ92PJ+cvg24HNhMnYzM0t5zUdEOaSE00sXkSg@mail.gmail.com> <4ddba8bc-b1e5-24a0-602e-672e7b51b203@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ddba8bc-b1e5-24a0-602e-672e7b51b203@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 09:00:09PM +0100, christophe leroy wrote:
> Le 26/02/2018 à 18:50, Mathieu Malaterre a écrit :
> >On Mon, Feb 26, 2018 at 8:44 AM, Mathieu Malaterre <malat@debian.org> 
> >wrote:
> >>On Mon, Feb 26, 2018 at 7:50 AM, Christophe LEROY
> >><christophe.leroy@c-s.fr> wrote:
> >>>Note that I already try to submit a fix for this warning 3 years ago
> >>>(https://patchwork.ozlabs.org/patch/418075/) and it was rejected with the
> >>>following comment:
> >
> >Tested again today with gcc 6.3.0 and gcc is still producing the
> >original warning (treated as error).
> 
> That's right, it seems that recent versions of gcc are not happy anymore 
> with that change.
> 
> Maybe Segher has a suggestion for that one ?

Your patch:

 #define __access_ok(addr, size, segment)	\
 	(((addr) <= (segment).seg) &&		\
-	 (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
+	 (((size) <= 1) || (((size) - 1) <= ((segment).seg - (addr)))))

Is there any reason to write this as a macro?  Let's make this more
readable:

static inline int __access_ok(unsigned long addr, unsigned long size,
			      mm_segment_t seg)
{
	if (addr > seg.seg)
		return 0;
	return (size == 0 || size - 1 <= seg.seg - addr);
}

and I think we are done already, or will this warn for any input?


Segher
