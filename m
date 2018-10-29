Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC8C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C6E20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+covjRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C6E20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJ3GfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:35:08 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40366 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeJ3GfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:35:08 -0400
Received: by mail-yb1-f196.google.com with SMTP id g9-v6so4130072ybh.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k7r2seG3z5i3YUNJYrz1D08/h9fMWVFy8SAfuBQfh7o=;
        b=F+covjRaRi1r61cpKOWIdpkpxFCfAHnoViBO5JMnm3xA+d+vxEkzrj2KVbdMXrqdcI
         do0eq9qtAo2gU2vZthTaoCt8IV0QpbUIJpfqAgFl6b1kQuc9yEVAZm2go2Px5Ot/+DUM
         gX+jx1bYpp3e1oQPptbUfs9YpEc3UXFIE1dQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k7r2seG3z5i3YUNJYrz1D08/h9fMWVFy8SAfuBQfh7o=;
        b=kgSyro5VbrUitfpcHr8GsjFa3YyydmX3+KVYzxsBpRIULC74yZPPVC/w3pvzdb0rSX
         RMwV+60MtAVxLOI9UrcC+YY3NMTsGZGtfmnSXFutraeeYEGV2nDVkhKVvMiSMbqxOlkv
         1ElFgrweVSsbZu+kJW6hSgzsBCKDx9FO4iG9wMx4k3euXUKojPtvDo8h2Zjky1/sk+81
         ThYlWEM5cGC3+rp6w7olzK3dcvqxljLuGTJtcTJRTwV8rWCkmbJpbV97ufzz2j+iv1PI
         V0nMmFEv6TnC1e1ySltG/wnr2bXWf8hEMRussBQ0Pghnq9lQqfUdsveGl3qXoCAiOx8M
         1NRw==
X-Gm-Message-State: AGRZ1gKACV0j9TW4HB5CqAumM/2AidqKB+bIrXZrKehSBS0PJ+/bq7Yu
        Lt9XG6lNt3FUH/+VDFgHkeLkYofmpu8=
X-Google-Smtp-Source: AJdET5fcG9qciJ2h5/ae5HxOj/WDJZ40BgntiKWm9tQ2XOeSOAGQxoziUvmnuMSB2ms0KYuG6W2/Dg==
X-Received: by 2002:a25:a2d0:: with SMTP id c16-v6mr15281711ybn.97.1540849474687;
        Mon, 29 Oct 2018 14:44:34 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id w6-v6sm6348295ywl.30.2018.10.29.14.44.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 14:44:31 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j9-v6so4132916ybj.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:44:30 -0700 (PDT)
X-Received: by 2002:a25:8409:: with SMTP id u9-v6mr15889330ybk.421.1540849470122;
 Mon, 29 Oct 2018 14:44:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 14:44:29
 -0700 (PDT)
In-Reply-To: <20181029145818.4bqmy25itjnqhodg@brauner.io>
References: <20181016223322.16844-1-christian@brauner.io> <20181029145818.4bqmy25itjnqhodg@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 29 Oct 2018 14:44:29 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJwSRQ3dOgNW_X0Fk+8gT+ACiBZPJ79g-aCfqiWsm=ewg@mail.gmail.com>
Message-ID: <CAGXu5jJwSRQ3dOgNW_X0Fk+8gT+ACiBZPJ79g-aCfqiWsm=ewg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sysctl: handle overflow for file-max
To:     Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 7:58 AM, Christian Brauner <christian@brauner.io> wrote:
> On Wed, Oct 17, 2018 at 12:33:20AM +0200, Christian Brauner wrote:
>> Hey,
>>
>> Here is v3 of this patchset. Changelogs are in the individual commits.
>>
>> Currently, when writing
>>
>> echo 18446744073709551616 > /proc/sys/fs/file-max
>>
>> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
>> crashes the system.
>>
>> The first version of this patch intended to detect the overflow and cap
>> at ULONG_MAX. However, we should not do this and rather return EINVAL on
>> overflow. The reasons are:
>> - this aligns with other sysctl handlers that simply reject overflows
>>   (cf. [1], [2], and a bunch of others)
>> - we already do a partial fail on overflow right now
>>   Namely, when the TMPBUFLEN is exceeded. So we already reject values
>>   such as 184467440737095516160 (21 chars) but accept values such as
>>   18446744073709551616 (20 chars) but both are overflows. So we should
>>   just always reject 64bit overflows and not special-case this based on
>>   the number of chars.
>>
>> (This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)
>
> Just so that we don't forget, can we make sure that this gets picked
> into linux-next? :)

I was hoping akpm would take this? Andrew, does the v3 look okay to you?

-Kees

-- 
Kees Cook
