Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CA1C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E4620892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPLqYPgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E4620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeKHWDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:03:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeKHWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7j5d88Q/iIP3Vh0jE+BHQjAFVnGes3gX6JwGr4dy4Vo=; b=gPLqYPghJwIQMH3ovYWGP+v22
        XIqlMfpWb0LSguiXXvgdc0KmTNWVYZDlLx7Sc6VLvTnDp4RveEffe8c/HJthaGTM8NED9zkhWvWSr
        o23oIiCi4yCUXMBNjFxGLZ1FCreDZ8bbVbGulTMJ8I/lkgwdGT9PgXbGJbVYsAqUBpUZj6iAp0cWV
        oloYl2Vj8jXivd9/YBh1a8TMQx/qa1f9MKBjAkjeiGEywZTU8pd1zKvhu4s29ZiGm0OXzIbcnKc5i
        JVi3AFofC0tApI13ntGhdUWy/7Zy5FX3LRS11+rReKov5Gry8pSTFiHvRoaKjNUVALjqs0D2g3wKj
        T2JhgPVTg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKjPX-0007dc-W7; Thu, 08 Nov 2018 12:27:48 +0000
Date:   Thu, 8 Nov 2018 04:27:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Martin Steigerwald' <martin@lichtvoll.de>,
        Michal Hocko <mhocko@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181108122747.GM3074@bombadil.infradead.org>
References: <20181031150625.147369-1-dancol@google.com>
 <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
 <20181107160015.GI27423@dhcp22.suse.cz>
 <4536090.43ZsV6LvYe@merkaba>
 <0c5610f128fa49fb9d8f7859e6f61b90@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5610f128fa49fb9d8f7859e6f61b90@AcuMS.aculab.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 12:02:49PM +0000, David Laight wrote:
> From: Martin Steigerwald
> > Sent: 07 November 2018 17:05
> ...
> > Its not quite on-topic, but I am curious now: AFAIK PID limit is 16
> > bits. Right? Could it be raised to 32 bits? I bet it would be a major
> > change throughout different parts of the kernel.
> 
> It is probably 15 bits (since -ve pid numbers are used for process groups).
> 
> My guess is that userspace and the system call interface will handle 32bit
> (signed) pid numbers.
> (I don't remember 'linux emulation' being one of the emulations that
> would truncate 32bit pids when one of the BDSs went to 32bit pids.)
> The main problem will be that big numbers will mess up the alignment
> of printouts from ps and top (etc).
> This can be mitigated by only allocating 'big' numbers on systems
> that have a lot of pids.
> You also really want an O(1) allocator.

The allocator is O(log n) -- it's the IDR allocator, used in cyclic mode.
n in this case is the highest ID which is still in use.  The tree is
log_64(n) levels high.  It walks to the bottom of the tree and puts a
pointer into the tree.  If the cursor has wrapped to the beginning of
the tree, it may encounter a PID which is still in use; if it does,
it does a bitmap scan of that node, and will then walk up the tree,
doing a bitmap scan forward at each level until it finds a free PID.

So it's not exactly O(log(n)), but it's close enough for all practical
purposes.  And more importantly, it doesn't touch a lot of cachelines.
Two or three at each level of the tree that it accesses.  If we went
all the way to a 32-bit PID, the tree would grow to 6 levels deep,
and worst-case would touch 6 + 5 + 4 levels of the tree (starting with
trying to allocate PID 0xffffffff, failing, trying to allocate PID 300,
then having to walk all the way forward to find PID 0xe0000000), so
that's only 45 cachelines.

People care a little too much about O(1)/O(n) behaviour.  Cacheline
behaviour, and good average-case performance without falling off a cliff
in the worst case is much more important.
