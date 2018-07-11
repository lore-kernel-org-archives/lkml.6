Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD0CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA432208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WlO9aQag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA432208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeGKBqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:46:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38019 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbeGKBqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:46:35 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so22171661iog.5;
        Tue, 10 Jul 2018 18:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vb/Nn9+Oshhoxx3/b+ldphWhaVo62+AMb6oVw8Bocd0=;
        b=WlO9aQagOSAJQGRQja2vLwzabuUejs4eEOhM16mDcrJXvQ/ot8qxKNGNkD1KsRk8Zu
         3c89D2mpCmCu0dXPh49PikA1WsR9Rjjry/ua6yy1SoEsH+yuUzYuqVZ2JZchqzcQRgWb
         1kY4rupvhNppxySCcF8V6aGpS2zzmf+ytsHuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vb/Nn9+Oshhoxx3/b+ldphWhaVo62+AMb6oVw8Bocd0=;
        b=IjLGkbP+/Wces1zqyQEjyNES04kRNEnkeewplyea01vGhyJz9vey7HvF2CBdsWXMnG
         jfsPcxeqbayz7DA8tQcSVK3CxkRpm91INwckVHogHERoC91CCAxb6vghKK7MaJtj2/1b
         QSBUr/jlvo5KSv8P2RZqtICwdzkTZ8oqZgKsZVKf8jlkT2MmqM1syYre2sBd1RkjyMYe
         S19YbB9vr1Onw/by3WP1nWRcexiQSPql5K7JyFjOMeXyhVvFnmKwjXTCY+S09Fs4ISkb
         BB/n33YGgSrPAx31zc1WWMF42TNvo/F2IjRMdHpUqPYJXBUYh3O0wfkpyCdo+4mGImRc
         O4gg==
X-Gm-Message-State: APt69E2NRn5yEZw/Gl3ThmBFwVAg6NtpuI5NzJuD27uUZxG7Ea0n7Pd/
        JeP0IMxM0vB7WpzR0tqqdWxheCiShHgJykVdebLR3g==
X-Google-Smtp-Source: AAOMgpdCFEiKOf/sR2QNSJxJ7O1qx0Dpcjj3ldxSq/u8p7FbHv9OzkZHo4/bXA9Pz88rpLXgXLXPHpBlY6jJcJ5S2nk=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr24206927iov.203.1531273485296;
 Tue, 10 Jul 2018 18:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
In-Reply-To: <5B455D50.90902@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 18:44:34 -0700
Message-ID: <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To:     wei.w.wang@intel.com
Cc:     virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 6:24 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
> We only get addresses of the "MAX_ORDER-1" blocks into the array. The
> max size of the array that could be allocated by kmalloc is
> KMALLOC_MAX_SIZE (i.e. 4MB on x86). With that max array, we could load
> "4MB / sizeof(u64)" addresses of "MAX_ORDER-1" blocks, that is, 2TB free
> memory at most. We thought about removing that 2TB limitation by passing
> in multiple such max arrays (a list of them).

No.

Stop this already./

You're doing everthing wrong.

If the array has to describe *all* memory you will ever free, then you
have already lost.

Just do it in chunks.

I don't want the VM code to even fill in that big of an array anyway -
this all happens under the zone lock, and you're walking a list that
is bad for caching anyway.

So plan on an interface that allows _incremental_ freeing, because any
plan that starts with "I worry that maybe two TERABYTES of memory
isn't big enough" is so broken that it's laughable.

That was what I tried to encourage with actually removing the pages
form the page list. That would be an _incremental_ interface. You can
remove MAX_ORDER-1 pages one by one (or a hundred at a time), and mark
them free for ballooning that way. And if you still feel you have tons
of free memory, just continue removing more pages from the free list.

Notice? Incremental. Not "I want to have a crazy array that is enough
to hold 2TB at one time".

So here's the rule:

 - make it a simple array interface

 - make the array *small*. Not megabytes. Kilobytes. Because if you're
filling in megabytes worth of free pointers while holding the zone
lock, you're doing something wrong.

 - design the interface so that you do not *need* to have this crazy
"all or nothing" approach.

See what I'm trying to push for. Think "low latency". Think "small
arrays". Think "simple and straightforward interfaces".

At no point should you ever worry about "2TB". Never.

           Linus
