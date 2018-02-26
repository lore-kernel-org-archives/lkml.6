Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeBZIqi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:46:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:35801 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeBZIqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:46:37 -0500
Date: Mon, 26 Feb 2018 02:46:02 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
Message-ID: <20180226084602.GR21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-6-malat@debian.org> <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 07:32:03AM +0100, Christophe LEROY wrote:
> Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
> >-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < 
> >max_mapnr)
> >+#define pfn_valid(pfn) \
> >+		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
> 
> What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than 
> ARCH_PFN_OFFSET ?

It will work fine.

Say you are asking for  a <= x < b  so (in actual integers, no overflow)
that is  0 <= x-a < b-a  and you also assume x-a overflows, so that we
are actually comparing  x-a+M < b-a  with M = 2**32 or such (the maximum
value in the unsigned integer type plus one).  This comparison is
obviously always false.

(It also works if b < a btw).


Segher
