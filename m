Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AAFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F282152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F282152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeITQ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:27:47 -0400
Received: from ozlabs.org ([203.11.71.1]:50301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeITQ1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:27:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GCzR6H8Dz9sBj;
        Thu, 20 Sep 2018 20:44:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
In-Reply-To: <15925.1537309041@warthog.procyon.org.uk>
References: <20180919073826.02370812@canb.auug.org.au> <20180910133525.28c5dd20@canb.auug.org.au> <15925.1537309041@warthog.procyon.org.uk>
Date:   Thu, 20 Sep 2018 20:44:51 +1000
Message-ID: <878t3wjvmk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> > After merging the vfs tree, today's linux-next build (powerpc
>> > allyesconfig) failed like this:
>> > 
>> > samples/vfs/test-fsinfo.c: In function 'fsinfo':
>> > samples/vfs/test-fsinfo.c:37:17: error: '__NR_fsinfo' undeclared (first use in this function); did you mean 'fsinfo'?
>
> I think the problem is that I haven't allocated system call numbers for any
> arches other than x86 - even the x86 syscall numbers are provisional until the
> patchset is taken upstream.  I'm not sure of the best way to deal with this -
> make the samples dependent on the X86 arch?
>
>> > samples/vfs/test-fsinfo.c:180:30: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
>> >   printf("\tmax file size: %llx\n", f->max_file_size);
>
> Sigh.  On powerpc __u64 is unsigned long, but on x86_64 it's unsigned long
> long.  Is it possible to shift all arches to use unsigned long long for __u64?

You can #define SANE_USERSPACE_TYPES to get ll64 for powerpc.

cheers
