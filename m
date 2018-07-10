Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED27C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920D1208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YtmgbPpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920D1208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbeGJSVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:21:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45244 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbeGJSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:21:04 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so21246914ioh.12;
        Tue, 10 Jul 2018 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrZ35V2nfWKRv1jDHeHF/gQSl/AN8Josc8jeyNBgv7M=;
        b=YtmgbPpAS0NvS+jJTxPonY6fOx7SFJzmiHxTSeXKagvaMZA2qqHwf9nFAtkxs3Ph49
         fybFJDE0oJ23QRMzedD4hNKF1Rm4yAEmlUYy7JVWT1qRyz2i0viEqd1/C0xf6tPe6Gcr
         dbLoFkPkzd2Vj8tKCBiMYLpOrGrwOvzBXuYg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrZ35V2nfWKRv1jDHeHF/gQSl/AN8Josc8jeyNBgv7M=;
        b=pan7y92WB40IyuCh8G6Becf4qqKdaQO+SpAugUmqsVK+YAUQAuLYKSYN0ePaiSnYmV
         wmQuoQ1lXCIaum+kaLCqCno4r5TwlhKE15uvG3d7w/4gpfNZJJetnY1CyYaP1yAOUFzR
         +gydbD2hEM7/X7nX2xKoAJM5WvUu07fRGuYHRY1UFsFoXnVnvAhh6wCcGqzbZSUnsPul
         H/+5/l2JvQbWnwA85KYJ5bu2Wjyj760p+g72mnsRuybAYXeJ3Y7m8Reg6Cjk1OR0Iocd
         4LcRlAz2Mv7sNCSmm6gyq19XyYX7RrJp9tY2xXl1of7Z8nIu+hgRbkCeLqhhUTLk/YXG
         odDQ==
X-Gm-Message-State: APt69E14IoYZUJWEHESQZlAJ1F7t6ivIjvDHNlXDk6o0dmRMeAfLvr/o
        rj5dApmv7xGm5lEank16qxwnAgSrEPVsFACU5CdcIA==
X-Google-Smtp-Source: AAOMgpfFVG1paCCn7B9HcCmN4LUFXSxaf/JcaY1yDS9wgL+/A8Ot81F/wNbDCrcx85xEPVihald5mp9/kUMo6hnIYss=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr6474896iom.238.1531243999382;
 Tue, 10 Jul 2018 10:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com> <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 10:33:08 -0700
Message-ID: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
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

NAK.

On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
>
> +
> +       buf_page = list_first_entry_or_null(pages, struct page, lru);
> +       if (!buf_page)
> +               return -EINVAL;
> +       buf = (__le64 *)page_address(buf_page);

Stop this garbage.

Why the hell would you pass in some crazy "liost of pages" that uses
that lru list?

That's just insane shit.

Just pass in a an array to fill in. No idiotic games like this with
odd list entries (what's the locking?) and crazy casting to

So if you want an array of page addresses, pass that in as such. If
you want to do it in a page, do it with

    u64 *array = page_address(page);
    int nr = PAGE_SIZE / sizeof(u64);

and now you pass that array in to the thing. None of this completely
insane crazy crap interfaces.

Plus, I still haven't heard an explanation for why you want so many
pages in the first place, and why you want anything but MAX_ORDER-1.

So no. This kind of unnecessarily complex code with completely insane
calling interfaces does not make it into the VM layer.

Maybe that crazy "let's pass a chain of pages that uses the lru list"
makes sense to the virtio-balloon code. But you need to understand
that it makes ZERO conceptual sense to anybody else. And the core VM
code is about a million times more important than the balloon code in
this case, so you had better make the interface make sense to *it*.

               Linus
