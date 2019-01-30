Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FCFC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08802087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WvdhWaER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbfA3FNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:13:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfA3FNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:13:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0U58v4a001581;
        Wed, 30 Jan 2019 05:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=WItGHf9nOAdYHChIFTXl5rw6TmM3xVQC+SnZeHiHN4E=;
 b=WvdhWaER5z8dajm6zAc1/cm2TElGmyQxXLkyM4rFE1yCDW/K8gdRH+hSCpa5oAc8bJtM
 NyTf6JNjhJHrduy/N8k2kuchgJ6Eg3wnJ/HEBh8N8FsB/5NWSy3YfDH8olBMGRSfTvIH
 S65foOGebUjCbTIxCamv3MnLAwbkUe/bUwcL/inJ262NyB4pLdQtARoiom9EbnxrY92A
 fxWFOLeKTOFoCrt6gg7EDaMrmU6O3UAc5Fxwo1wgAq2F2bDUWUM1TeOSZCS7YekJe4l7
 47lZ509l36G3rKB0Q4FFgT+yvFF4QjRGi6AtBynPUjL35NvaY5xLCtBDBvHlIKWXRUiT dQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2q8g6r8a0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 05:13:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0U5D9hD025126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 05:13:09 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0U5D82w019150;
        Wed, 30 Jan 2019 05:13:08 GMT
Received: from kadam (/197.157.0.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jan 2019 21:13:07 -0800
Date:   Wed, 30 Jan 2019 08:12:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/7] binder: create userspace-to-binder-buffer copy
 function
Message-ID: <20190130051259.GO1795@kadam>
References: <20190129004934.85885-1-tkjos@google.com>
 <20190129004934.85885-2-tkjos@google.com>
 <20190129081218.GL1795@kadam>
 <CAHRSSEzjgtrouqJkhduaZt99RbmtA5a4Lc2xgyp_pt4cg7Vpmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHRSSEzjgtrouqJkhduaZt99RbmtA5a4Lc2xgyp_pt4cg7Vpmg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9151 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901300038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 04:32:09PM -0800, Todd Kjos wrote:
> On Tue, Jan 29, 2019 at 12:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Mon, Jan 28, 2019 at 04:49:28PM -0800, Todd Kjos wrote:
> > > +/**
> > > + * binder_alloc_copy_user_to_buffer() - copy src user to tgt user
> > > + * @alloc: binder_alloc for this proc
> > > + * @buffer: binder buffer to be accessed
> > > + * @buffer_offset: offset into @buffer data
> > > + * @from: userspace pointer to source buffer
> > > + * @bytes: bytes to copy
> > > + *
> > > + * Copy bytes from source userspace to target buffer.
> > > + *
> > > + * Return: bytes remaining to be copied
> > > + */
> > > +unsigned long
> > > +binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
> > > +                              struct binder_buffer *buffer,
> > > +                              binder_size_t buffer_offset,
> > > +                              const void __user *from,
> > > +                              size_t bytes)
> > > +{
> > > +     if (!check_buffer(alloc, buffer, buffer_offset, bytes))
> > > +             return bytes;
> > > +
> > > +     while (bytes) {
> > > +             unsigned long size;
> > > +             unsigned long ret;
> > > +             struct page *page;
> > > +             pgoff_t pgoff;
> > > +             void *kptr;
> > > +
> > > +             page = binder_alloc_get_page(alloc, buffer,
> > > +                                          buffer_offset, &pgoff);
> > > +             size = min(bytes, (size_t)(PAGE_SIZE - pgoff));
> >
> > This code has so much more casting than necessary.  To me casting says
> > that we haven't got the types correct or something.  I've just pulled
> > this function out as an example really, but none of the casts here are
> > required...  This could just be:
> >
> >                 size = min(bytes, PAGE_SIZE - pgoff);
> 
> Dan,
> 
> Thanks for the feedback.
> 
> The one above: "size = min(bytes, PAGE_SIZE - pgoff);", results in
> 32-bit compile warnings:
> 
> ./include/linux/kernel.h:846:29: warning: comparison of distinct
> pointer types lacks a cast
>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> [...]
> drivers/android/binder_alloc.c:1157:10: note: in expansion of macro ‘min’
>    size = min(bytes, PAGE_SIZE - pgoff);
> 
> so, I took your suggestion:
> 
>   size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
> 
> >
> > Btw, if you really need to do a cast inside a min() (you don't in this
> > cast) then use min_t().
> >
> > > +             kptr = (void *)((uintptr_t)kmap(page) + pgoff);
> >
> > This would be a lot cleaner as:
> >
> >                 kptr = kmap(page) + pgoff;
> 
> It definitely is cleaner, but the clean version is doing arithmetic on
> a void pointer which is generally not considered good practice (but is
> supported by gcc). Is this acceptable in the kernel? I don't see any
> statement on it in Documentation/process/coding-style.rst.

Yeah, it's a GCCism but to me it seems so nice.  We do it all the time.

We'd like to get Clang to compile the kernel, but we've done very little
work to make that happen.  Removing variable length arrays was really
done for other reasons...

regards,
dan carpenter

