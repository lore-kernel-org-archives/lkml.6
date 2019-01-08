Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCB2218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAHIC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:02:29 -0500
Received: from ozlabs.org ([203.11.71.1]:39727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfAHIC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:02:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Yl9F5nTqz9sD9;
        Tue,  8 Jan 2019 19:02:25 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
In-Reply-To: <20190107131341.00581863@x1.home>
References: <20190104195714.30045-1-labbott@redhat.com> <874lakc09x.fsf@concordia.ellerman.id.au> <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com> <20190107120716.51d95854.cohuck@redhat.com> <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com> <20190107131341.00581863@x1.home>
Date:   Tue, 08 Jan 2019 19:02:23 +1100
Message-ID: <87pnt7tw4w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson <alex.williamson@redhat.com> writes:
...
>
> Numbering options for clarity:
>
> 1)
>> ccflags-y += -I$(src)
>> would add the header search path for all files in drivers/vfio/pci/
>> whereas only the drivers/vfio/pci/vfio_pci_nvlink2.c needs it.
>> 
>
> 2)
>> CFLAGS_vfio_pci_nvlink2.o += -I$(src)
>> is a bit better.
>> However, it is not obvious why this extra header search path is needed
>> until you find vfio_pci_nvlink2.c including trace.h
>> 
>
> 3)
>> #define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
>> clarifies the intention because the related code is all placed in trace.h
 
Good summary.

>> From the comment in include/trace/define_trace.h
>> TRACE_INCLUDE_PATH is relative to include/trace/define_trace.h
>
> In my scan of the tree, the most common solution seems to be 2) as this
> is essentially recommended in the sample file.  3) is well represented,
> with much fewer examples of 1), though it might depend how liberally
> we grep out or examine the use cases.

It seems to me that 1 and 2 is overwhelmingly used:

$ git grep -F "#define TRACE_INCLUDE_PATH" | wc -l
133

That counts all definitions of TRACE_INCLUDE_PATH.

$ git grep -F "#define TRACE_INCLUDE_PATH ." | wc -l
122

That's all files using '.', so only 11 locations use the relative path
method (3).


Which is unsurprising given that the sample uses '.'.

And people often look at existing code for an example, so they're also
going to tend to use '.'.


I agree with Masahiro that adding include paths to the Makefile for
this is a bit gross, and method 3 is much more preferable.

Fixing all the existing code to use method 3 would be a good beginner
project :)

cheers
