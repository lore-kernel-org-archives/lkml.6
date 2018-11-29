Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1BDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFB220832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khbhpzqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFB220832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeK2Msp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:48:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46021 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeK2Msp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:48:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so155666plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXQUdjr8mIMk9bhk9tG9P0f+M4XEdIih2ulCHESQpac=;
        b=khbhpzqvajd9ieD09Y15wYFJl/5FotZya/FVHwo3z6fH/trrTJtBKwjoly9DHjSXS3
         7NpR9rXQYhFzHOXeDGzEbowsobPDGHOZRlnte1OtaWDkMDaZ/n7PW8iIm28SPpMB5+wT
         c3xTttljxBiv+9UpO8/SY69RUvoPeVM5gt6gswzAsP1rLyL/Rf4jxwLPjaFNVZjYgybw
         x/krHppOGCiBDnlOwj21iIBNN9zFixXrarWIrPPIrFGGbnh9BpuI988NvAQg0Y4m1UkT
         7y5Jn184rlW5o2AIxdeJ/4NAwrAwGC09U3P1tyzU6V9AkmO9nZ7gRftWAp7RnUcqQ3eB
         c7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXQUdjr8mIMk9bhk9tG9P0f+M4XEdIih2ulCHESQpac=;
        b=Te/9NyHPowThr6SvOPZ3301I2/NqQeXR0aGeyy6JuIhMaYkTVh1PpTs4vZ5c3WBUHU
         tqBYQHCW5swevycB4A1FzzqvAwS77G9vOf7Izw5DhVg0uVyY6BGjGlboP3AV0awDzGdK
         eEip+d4sukbz98j7hQw3RqPREwXj/qyiDGMsnPNE8I6QsCYQKt7zVW9bRGfM3mjfKrAo
         mbKPMnpaUWO2Rrr2NzFDkDrbc44/NWRBlI383DI15QMXxFowZ7l/JayfzUXAcEeJ+jZ9
         y1tUBwGaZla2nTDvRx4fJwC+ye3uyDVgPBh/c/u/LJmHkJQ/rzvH4KtAk3drEYbyLeLZ
         5+oQ==
X-Gm-Message-State: AA+aEWbWfMVng4NieKj+O5byqD2gnAW+1ek4IwNq2mMUrGIYYqqDJDif
        J31dhXQ7WdIyylNpiNwbJSg=
X-Google-Smtp-Source: AFSGD/UJ9uX6D8xchdwRCbqiF9MO4/UIHlRjU5Jp3TVzGwhGeiFYaZrNenJvqkkelUmliB9IxNW7Gw==
X-Received: by 2002:a17:902:4c08:: with SMTP id a8mr39764498ple.74.1543455907415;
        Wed, 28 Nov 2018 17:45:07 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id m9sm231144pgd.32.2018.11.28.17.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 17:45:06 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:45:02 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 6/7] zram: add bd_stat statistics
Message-ID: <20181129014502.GB77327@google.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-7-minchan@kernel.org>
 <20181126125833.e95a21088ae60ccc6fd55022@linux-foundation.org>
 <20181127020754.GB237537@google.com>
 <20181128153021.3f125ed82df68a29e25ce428@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128153021.3f125ed82df68a29e25ce428@linux-foundation.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:30:21PM -0800, Andrew Morton wrote:
> On Tue, 27 Nov 2018 11:07:54 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > On Mon, Nov 26, 2018 at 12:58:33PM -0800, Andrew Morton wrote:
> > > On Mon, 26 Nov 2018 17:28:12 +0900 Minchan Kim <minchan@kernel.org> wrote:
> > > 
> > > > +File /sys/block/zram<id>/bd_stat
> > > > +
> > > > +The stat file represents device's backing device statistics. It consists of
> > > > +a single line of text and contains the following stats separated by whitespace:
> > > > + bd_count	size of data written in backing device.
> > > > +		Unit: pages
> > > > + bd_reads	the number of reads from backing device
> > > > +		Unit: pages
> > > > + bd_writes	the number of writes to backing device
> > > > +		Unit: pages
> > > 
> > > Using `pages' is a bad choice.  And I assume this means that
> > > writeback_limit is in pages as well, which is worse.
> > > 
> > > Page sizes are not constant!  We want userspace which was developed on
> > > 4k pagesize to work the same on 64k pagesize.
> > > 
> > > Arguably, we could require that well-written userspace remember to use
> > > getpagesize().  However we have traditionally tried to avoid that by
> > > performing the pagesize normalization within the kernel.
> > 
> > zram works based on page so I used that term but I agree it's rather
> > vague. If there is no objection, I will use (Unit: 4K) instead of
> > (Unit: pages).
> 
> Is that still true if PAGE_SIZE=64k?

Oops, it will fix.
