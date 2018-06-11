Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6FC2CC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0877C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XFrpOf4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0877C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934311AbeFKScz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:32:55 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:37195 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933493AbeFKScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:32:53 -0400
Received: by mail-io0-f169.google.com with SMTP id s26-v6so25061942ioj.4;
        Mon, 11 Jun 2018 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSM9RG9Q2LHQkZkDYRp4FpnKlCZpfnoMmtac9GpV+NA=;
        b=XFrpOf4CE5Qn6kWrOSA0ilYNmTASYh47I7HXlF+055MjckYt53a59VzqZwOKN2/lJ4
         ywF5Or6nDI1f1L8zHd8AVtM3XMIvZLUEnIsYqT//zwrIO6ETGVGkYLaO1PizDuOtWVBa
         DBRedBh2FcOElSWtRCGp6xibplxCFRcKQlXmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSM9RG9Q2LHQkZkDYRp4FpnKlCZpfnoMmtac9GpV+NA=;
        b=P2QYGp1pqILC58Xwr3E7/FAwS8pcpteNOfcvAmH548IiWpeFQMqFdTpnBEAMAo/+a2
         Xr1m0MxB32ATnQlVWPM9jMh1vL4x/nfqRrYrLN6Bl/X0VCpLRVz9GBLiSzDA7XU8PMws
         8FC8QaXafo85t+J/+H+Up7ywRbBVnVYumAqoTvDOZZHc982qetNyDpQAVJqe0fKOo1lM
         yu9LK9d15ffU8s9HIvWtihddWGwa7kBVQYjCODisYcb+EI+LiqRdCOtDd47bwXAdnPJE
         VTN1HyqugONG9l14On9OL4FP9MENgtuZS6QBSxNhX1qmwFQ5ZhVYbDjaXqubpM+BCsb4
         JYbQ==
X-Gm-Message-State: APt69E2ecHTVwXF+MbQguZlFOTpmgCIyoUqfjMzXAUtcvOEQL0OO0R2h
        /nJnfBY78voQ5U3J3zzHQy7KwzqGPFKc5XYSVhY=
X-Google-Smtp-Source: ADUXVKIqQugr8ei4anv8GcnZRq5ulSjqoP0hktllMGLmi05V4kaXvhWFKauAlHMHs9IQmwRWGGUHLnhBid42+pKoq6E=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr299096iov.203.1528741972988;
 Mon, 11 Jun 2018 11:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180611192353-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180611192353-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 11:32:41 -0700
Message-ID: <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 9:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>       virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT

Is this really a good idea?

Plus it seems entirely broken.

The report_pfn_range() callback is done under the zone lock, but
virtio_balloon_send_free_pages() (which is the only callback used that
I can find) does add_one_sg(), which does virtqueue_add_inbuf(vq, &sg,
1, vq, GFP_KERNEL);

So now we apparently do a GFP_KERNEL allocation insider the mm zone
lock, which is broken on just _so_ many levels.

Pulled and then unpulled again.

Either somebody needs to explain why I'm wrong and you can re-submit
this, or this kind of garbage needs to go away.

I do *not* want to be in the situation where I pull stuff from the
virtio people that adds completely broken core VM functionality.

Because if I'm in that situation, I will stop pulling from you guys.
Seriously. You have *no* place sending me broken shit that is outside
the virtio layer.

Subsystems that break code MM will get shunned. You just aren't
important enough to allow you breaking code VM.

                Linus
