Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB615C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9914620827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fyKei1FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9914620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbeKGTcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:32:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40117 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeKGTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:32:46 -0500
Received: by mail-io1-f68.google.com with SMTP id a23-v6so11483863iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kw3I7EGQTmPKXZQK+S2Uf6SBkCcBvCph0lYiD6RjiSQ=;
        b=fyKei1FQv0vMdER0iyoH0SQaMhpHjKLKUE0Ti2GH9qogDzh11Uo52jSq7pQplqjKyK
         1piIUKcBMWIyn1V0Y6m1foV/LeO3wX5k96YwVpHgQgb7tlrSAxtaHDjIJeL86Z3Ffgxz
         BsTS/GoGxboyvtfNtjyq3l2m7cvEq345USWco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kw3I7EGQTmPKXZQK+S2Uf6SBkCcBvCph0lYiD6RjiSQ=;
        b=KnbXQ0HDy++iV4uZNqA3KBJRLSNY4FadIT6/y6HkbAXkrTHzkBoaUE3O1gHAeGxjkg
         lAfnm+Et/XCSyQpHprNmSit8betjZtflXmqjw70FXsPCozjknGncp2yhqQJgHt/zk1Zd
         Z70lMFpdvExN+Uxl2dP7ka8epsYIRsZL7G1IlYoaP+lR/sdDfM6CqzMcfeEpYuNoLrIx
         Wiq6+iT0Sp2zJ9FHT5Jx7PHEWT2BsUuX1JYvU2LfQHhJJgoaJpvKPNnY5N+oAXLd95dA
         fnbYXPUOLdPP7efQ8f9zYYFgx70xn8hZEcyGrQJtdowCQmYLCfvDXpxRR5fcBArW/zKn
         TRbQ==
X-Gm-Message-State: AGRZ1gLcV2ATU2PSvoYw4kLNzH6A61TTXqr+tjA7+RsWguQRKM0dSohF
        jGVBPGcgcUPYynEJXLbT4esfu5o0TZashpmFD86M6w==
X-Google-Smtp-Source: AJdET5eB5My8CgAHrIg6a53St5XQ3+I8bJcqyIephoWmJOM99JLVGpBeN2LIUqPNpbSelvpezmpQ9LG6XvPK2qouPmc=
X-Received: by 2002:a5e:8b42:: with SMTP id z2-v6mr745406iom.144.1541584987760;
 Wed, 07 Nov 2018 02:03:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 02:03:06 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
References: <20181029192521.23059-1-dave@stgolabs.net> <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
 <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 11:03:06 +0100
Message-ID: <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 12:48 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 29 Oct 2018 23:04:45 +0000 Daniel Colascione <dancol@google.com> wrote:
>
>> On Mon, Oct 29, 2018 at 7:25 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
>> > This patch introduces a new /proc/stat2 file that is identical to the
>> > regular 'stat' except that it zeroes all hard irq statistics. The new
>> > file is a drop in replacement to stat for users that need performance.
>>
>> For a while now, I've been thinking over ways to improve the
>> performance of collecting various bits of kernel information. I don't
>> think that a proliferation of special-purpose named bag-of-fields file
>> variants is the right answer, because even if you add a few info-file
>> variants, you're still left with a situation where a given file
>> provides a particular caller with too little or too much information.
>> I'd much rather move to a model in which userspace *explicitly* tells
>> the kernel which fields it wants, with the kernel replying with just
>> those particular fields, maybe in their raw binary representations.
>> The ASCII-text bag-of-everything files would remain available for
>> ad-hoc and non-performance critical use, but programs that cared about
>> performance would have an efficient bypass. One concrete approach is
>> to let users open up today's proc files and, instead of read(2)ing a
>> text blob, use an ioctl to retrieve specified and targeted information
>> of the sort that would normally be encoded in the text blob. Because
>> callers would open the same file when using either the text or binary
>> interfaces, little would have to change, and it'd be easy to implement
>> fallbacks when a particular system doesn't support a particular
>> fast-path ioctl.

Please.   Sysfs, with the one value per file rule, was created exactly
for the purpose of eliminating these sort of problems with procfs.  So
instead of inventing special purpose interfaces for proc, just make
the info available in sysfs, if not already available.

Thanks,
Miklos
