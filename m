Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27781C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EEA21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EEA21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeITQbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:31:51 -0400
Received: from ozlabs.org ([203.11.71.1]:47267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeITQbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:31:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GD483Qt6z9sBy;
        Thu, 20 Sep 2018 20:48:56 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
In-Reply-To: <20180919163102.1a0adefb@canb.auug.org.au>
References: <20180919094847.2103082b@canb.auug.org.au> <20180919073826.02370812@canb.auug.org.au> <20180910133525.28c5dd20@canb.auug.org.au> <15925.1537309041@warthog.procyon.org.uk> <3565.1537336860@warthog.procyon.org.uk> <20180919163102.1a0adefb@canb.auug.org.au>
Date:   Thu, 20 Sep 2018 20:48:55 +1000
Message-ID: <875zz0jvfs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi David,
>
> On Wed, 19 Sep 2018 07:01:00 +0100 David Howells <dhowells@redhat.com> wrote:
>>
>> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> 
>> > > I think the problem is that I haven't allocated system call numbers for
>> > > any arches other than x86 - even the x86 syscall numbers are provisional
>> > > until the patchset is taken upstream.  I'm not sure of the best way to
>> > > deal with this - make the samples dependent on the X86 arch?  
>> > 
>> > But the sample programs are built with HOSTCC, so you can't depend on
>> > ARCH (since I, for one, am cross compiling).  Maybe SUBARCH.  Better
>> > would be to use either Kconfig's shell primitive or some make magic to
>> > figure out if the syscall number define's are defined.  
>> 
>> I meant put the dependency in the Kconfig.
>
> Yeah, sure.  Kconfig now has the ability for that dependency to be the
> result of an external program "$(shell ....)", so you could have a
> script or program that checked to see if the syscall numbers are
> defined and then have the Kconfig symbol(s) for the tests depend on that.

I realise these are in samples rather than selftests, but what most of
the selftests do is just #define the syscall number if it's not defined,
so that you're not dependent on getting the headers.

cheers
