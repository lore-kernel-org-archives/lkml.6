Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71108C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E01421A28
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cTBAz4hX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E01421A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbeHFS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:59:33 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33919 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbeHFS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:59:33 -0400
Received: by mail-io0-f173.google.com with SMTP id l7-v6so11612204ioj.1;
        Mon, 06 Aug 2018 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eKqIfkrpHsq7u3VSrp7q/25kt84IdzZyAUgLYIEoWU=;
        b=cTBAz4hXFudOyI0l8TXEF/Zw/bT6PB51Pv7MIyHqV4A+IppvjMf8OszG0sMs0O1XJV
         UAFXwrqv8M3lkVvyjQJQhcu5jVCsQ8JuYFhow5JGjM1BW6QpCXVjs4IYHMnhH66ta7YU
         5zmL978bBguEkAnTXiXTUFKAVGQK/AjAlyJSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eKqIfkrpHsq7u3VSrp7q/25kt84IdzZyAUgLYIEoWU=;
        b=XRvSrlQY5seCCITBC/3+/+kVDt2iz4c61MmZppampkgN/TeExnOSPrK20kB+5Wj4dp
         cynm9ZeE0gC7nULywNlcoQ5vLXh+pRYSgPdnQ5h4EAyjxPxxuSjiqpumMWQYbq3C11W6
         /qmX/Xy4Nu56ItRtPGpq+5veAI7Z0Y+kF6MjrNvQ9ySR3IjsY+Tt0ClEd3OgwUi0sZsa
         UEkuBltZ3R1gAuJLpPTfmWvn3A0HwyD5d89vzytJUZ5Sk+fvRVhgnAHngREyxmi6e5gv
         3pIZl0b4xuwCvQ1CNVzCuP2QHdy82A0+trNLk1vYTqeeSB1AKeufhx0ujZOAt/vZXBLH
         xhyg==
X-Gm-Message-State: AOUpUlEpsdotd0M8cfmM3zrDE6xuBMC9jiKo17r94MyprVWoT3iywePY
        lsRF7W29HK0Rl8iSELzIKZj5e49GYZxTumHF3eBZwA==
X-Google-Smtp-Source: AA+uWPyPK3KELWBwHmSH4ngK1ixA0uW8ishHOIod472CzXgh0JeIzZBCccgJvE9R3Pc/S2is/jxxhGwCnO5E4W1ysHM=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr16473397iom.238.1533574175920;
 Mon, 06 Aug 2018 09:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180806083058.14724-1-hch@lst.de>
In-Reply-To: <20180806083058.14724-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Aug 2018 09:49:24 -0700
Message-ID: <CA+55aFw84zP23hrQppCBLL++4kwAtgYHnQvrvanEKVScAc3DZA@mail.gmail.com>
Subject: Re: aio poll V22 (aka 2.0)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 1:31 AM Christoph Hellwig <hch@lst.de> wrote:
>
> As our dear leader didn't like the ->poll_mask method this tries to
> implement the behavior using plain old ->poll which is rather painful.

I'm not seeing what's painful for this. Looking at the patches, this
is *much* more straightforward than your previous patch,

It adds refcounting to aio_iocb, but that's *much* better than messing
up every other subsystem.

Or is there some follow-up patches that are pending but you didn't
post that are the painful part? Because the diffstat says that this
second version is *way* less painful, at about 200 lines of code in a
couple of files, mostly aio, vs ~700 lines of changes all over the
place, together with a performance regression.

                 Linus
