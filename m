Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E630C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3040A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3040A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLKSJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:09:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeLKSJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:09:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3613889AC5;
        Tue, 11 Dec 2018 18:09:19 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEE5F1057069;
        Tue, 11 Dec 2018 18:09:17 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kent.overstreet@gmail.com
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
References: <20181128183531.5139-1-willy@infradead.org>
        <x49va46e1p0.fsf@segfault.boston.devel.redhat.com>
        <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com>
        <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
        <20181211175156.GF6830@bombadil.infradead.org>
        <x495zw0lz68.fsf@segfault.boston.devel.redhat.com>
        <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 11 Dec 2018 13:09:17 -0500
In-Reply-To: <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk> (Jens Axboe's
        message of "Tue, 11 Dec 2018 11:05:12 -0700")
Message-ID: <x49y38wkkaa.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 11 Dec 2018 18:09:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 12/11/18 11:02 AM, Jeff Moyer wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>>> On Tue, Dec 11, 2018 at 12:21:52PM -0500, Jeff Moyer wrote:
>>>> I'm going to submit this version formally.  If you're interested in
>>>> converting the ioctx_table to xarray, you can do that separately from a
>>>> security fix.  I would include a performance analysis with that patch,
>>>> though.  The idea of using a radix tree for the ioctx table was
>>>> discarded due to performance reasons--see commit db446a08c23d5 ("aio:
>>>> convert the ioctx list to table lookup v3").  I suspect using the xarray
>>>> will perform similarly.
>>>
>>> There's a big difference between Octavian's patch and mine.  That patch
>>> indexed into the radix tree by 'ctx_id' directly, which was pretty
>>> much guaranteed to exhibit some close-to-worst-case behaviour from the
>>> radix tree due to IDs being sparsely assigned.  My patch uses the ring
>>> ID which _we_ assigned, and so is nicely behaved, being usually a very
>>> small integer.
>> 
>> OK, good to know.  I obviously didn't look too closely at the two.
>> 
>>> What performance analysis would you find compelling?  Octavian's original
>>> fio script:
>>>
>>>> rw=randrw; size=256k ;directory=/mnt/fio; ioengine=libaio; iodepth=1
>>>> blocksize=1024; numjobs=512; thread; loops=100
>>>>
>>>> on an EXT2 filesystem mounted on top of a ramdisk
>>>
>>> or something else?
>> 
>> I think the most common use case is a small number of ioctx-s, so I'd
>> like to see that use case not regress (that should be easy, right?).

Bah, I meant a small number of threads doing submit/getevents.

>> Kent, what were the tests you were using when doing this work?  Jens,
>> since you're doing performance work in this area now, are there any
>> particular test cases you care about?
>
> I can give it a spin, ioctx lookup is in the fast path, and for "classic"
> aio we do it twice for each IO...

Thanks!

-Jeff
