Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF41C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D995720836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g99ot257"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D995720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964777AbeFRUJD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:09:03 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44933 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934783AbeFRUIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:08:55 -0400
Received: by mail-ot0-f196.google.com with SMTP id w13-v6so19948640ote.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+XBKmTXLtaRF9vo/WaIVatL3KN/nNPgi7+ii4lsUroE=;
        b=g99ot257ZefVpe8NRgD0WUeKpE3nq87G3QnJ2T8dg3FAzhD4mjQdK8VsVR7N51BN+H
         6RNUbykzpNYp7Vx+8RUqlfVqyQtrpFStr8MOEI/iNov4RfBf4Kl5l2W+/tDCybBEpqXB
         /a7AcIQrqkwnw0N4E5MWTJ8Wew31EYUp2Yq4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+XBKmTXLtaRF9vo/WaIVatL3KN/nNPgi7+ii4lsUroE=;
        b=cuGxlhz6EYNEO1iez208CVB41W1iGeNvfGcFZGJFwGBwP3d1uY7jmcrTaK8XWkGOMQ
         PWkUe8yE9bqJrPAkleb3RkwZDtylNIyzJLgaKyjbbKD/Pb9IYv3zHD8lj+3RLzvz4+rG
         1QZry6/It8QMDMeJx5eNf6bFLEIsPh7loeTM5KOQRoqOB1mC0mK3DDXSFnCRTfkaF6mn
         BMb/EhX1GTz3sylPsSfc/TWixH6AXTvliWIunptLQoQdG91UaMoEJ9GK5oSTA8HGbjbo
         ose6LmHz5Jc5+byTdG1o/s+GCAqC8fikqgFDv45Un0rD2TXMBZOSEf15l9sy5hxGHiNI
         CS8g==
X-Gm-Message-State: APt69E2o3TU7cv+dSwfIHGQ9JZr8YLOEXv2hy6oIIBmnO1C1Pnc1Laol
        +R/2DipSvTJQF5QcRl+F0Oous+arVzG9LsyW3GyAhQ==
X-Google-Smtp-Source: ADUXVKKQxMoM0nEsl1TNmQ+zomEFp4BFYV49xfRLGBSxb49e+q5XVJEAug7b4hk9367loB8akUfe4IgrVg1haqBlGxQ=
X-Received: by 2002:a9d:4c02:: with SMTP id l2-v6mr8198531otf.242.1529352535000;
 Mon, 18 Jun 2018 13:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:08:54
 -0700 (PDT)
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180606150905.GC9426@magnolia>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-2-mszeredi@redhat.com>
 <20180604084336.GA11333@infradead.org> <CAJfpegun8HyjODXguHstxYrGE2nuSoCCicaHT3yfYWMkxxmVWg@mail.gmail.com>
 <20180606150905.GC9426@magnolia>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jun 2018 22:08:54 +0200
Message-ID: <CAJfpeguMN4t80cUCxyTxeHW9_Hb61DzDRPzTa371dc2YQRHuZQ@mail.gmail.com>
Subject: Re: [PATCH 01/39] vfs: dedpue: return loff_t
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 5:09 PM, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Tue, Jun 05, 2018 at 10:33:22AM +0200, Miklos Szeredi wrote:
>> On Mon, Jun 4, 2018 at 10:43 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> > On Tue, May 29, 2018 at 04:43:01PM +0200, Miklos Szeredi wrote:
>> >> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
>> >> actual length deduped.  This breaks badly on 32bit archs since the returned
>> >> length will be truncated and possibly overflow into the sign bit (xfs and
>> >> ocfs2 are affected, btrfs limits actual length to 16MiB).
>> >
>> > Can we just make it return 0 vs errno?  The only time we return
>> > a different length than the one passed in is due to the btrfs cap.
>> >
>> > Given that this API started out on btrfs we should just do the cap
>> > everywhere to not confuse userspace.
>>
>> And that's a completely arbitrary cap; sure btrfs started out with
>> that, but there's no fundamental reason for that becoming the global
>> limit.  Xfs now added a different, larger limit, so based on what
>> reason should that limit be reduced?
>>
>> I don't care either way, but at this stage I'm not going to change
>> this patch, unless there's a very good reason to do so, because if I
>> do someone will come and suggest another improvement, ad-infinitum...
>
> I think we should hoist the MAX_RW_COUNT/2 limit to the VFS helpers
> since afaict we generally cap max IO per call at MAX_RW_COUNT.

I don't quite get it.   That MAX_RW_COUNT is to protect against
overflows in signed int.

Here we have a 64bit interface, so that's irrelevant, we can invent
any cap we want.  Lets choose our favorite bike shed size.  Mine is
1G.  But if that turns out too limiting it can be raised arbitrarily
later.

>  (I
> probably should've capped ocfs2 back when I did xfs, but forgot).  If
> btrfs wants to keep their lower (16M) limit then they're free to do so;
> the interface documentation allows for this.  One of the btrfs
> developers seems to be working on a patch series to raise the limit[1]
> anyway.

Yep, that got upstreamed now.  Which is good, we can just return zero
or error from ->dedupe_file_range() and be done with that.

Thanks,
Miklos
