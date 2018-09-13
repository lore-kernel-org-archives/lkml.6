Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44579C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5403204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5403204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeIMXJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:09:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39522 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeIMXJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:09:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0Vt7-0000LX-Cf; Thu, 13 Sep 2018 17:58:45 +0000
Date:   Thu, 13 Sep 2018 18:58:45 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] iov_iter: Add new iters and use with AFS
Message-ID: <20180913175845.GS19965@ZenIV.linux.org.uk>
References: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 04:51:35PM +0100, David Howells wrote:
> 
> Hi Al,
> 
> Here's a set of patches that adds two new iov_iter types and then makes AFS
> use them to do I/O.  The iov_iter changes are:
> 
>  (1) Separate the type from the direction in the iov_iter struct and
>      provide accessor functions to wrap type checking.
> 
>  (2) Renumber the type constants to be contiguous small unsigned integers,
>      starting from 0 and then use switch-statements rather than if-else
>      chains using bit-testing.
> 
>      Note that the compiler can optimise this better by using CMP rather
>      than AND/TEST, say, as comparing integers requires fewer CMP
>      instructions or can use jump tables.
> 
>  (3) Change iov_offset from size_t to loff_t.  This allows iov_offset to be
>      then used as a byte offset with ITER_MAPPING and allows 4GiB and larger
>      reads and writes to be proposed.
> 
>      This makes no difference on a 64-bit system, but does make a 32-bit
>      compilation a bit larger.
> 
>  (4) Add an ITER_MAPPING iterator type.  This provides an iterator that
>      directly accesses an address_space, and assumes that the target pages
>      are in some way locked (eg. PG_lock or PG_writeback).
> 
>  (5) Add an ITER_DISCARD iterator type.  This provides an iterator that
>      simply discards anything written to it.  It cannot be used as a data
>      source.

Hmm...   I'll take a look in about an hour (need to finish the sodding tty-ioctl
stuff first), will post review then.  Sorry, I remember seeing it posted several
weeks ago, slipped through the cracks then ;-/
