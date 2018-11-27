Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F89C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472D220664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adf12+kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472D220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeK0NEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:04:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36201 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0NEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:04:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so2327639plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=As1qRHlSzGV0HQiwzdFbfPRf16QGYU3mLf/xOPgRwv8=;
        b=Adf12+khdK2B0O3mDBuvCeTM4JtMinOSB2sdSRwo6CjBCzG8n3JjiD2ECsG0himTix
         l1ZJIfblD4yBBO/leN9L6dZhvngWRwZbMzjMo/Ajf9Wy+N8+PwkWJu6s0jowcXL2Ot11
         /PDpVQaUl9HWh4DW2iVJr2tGPnSWbtCPopga3Qs9l3U9B4g44sUfgWPKwE/0WUiV8hGs
         RyTG41QliEX7HouPfvSNfSx+CL358obvGvb4N81YXf1CODDNwnaS4ouGjOXinZLh/rrG
         4oZcWTZFdzdcGFs2x4IeDlP5pqmlGfzeeCh1RDl3gx02WEDh0JOXnhNWV5SW3x3A3k4w
         hbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=As1qRHlSzGV0HQiwzdFbfPRf16QGYU3mLf/xOPgRwv8=;
        b=gwzblsgXxrBrocfhwZQI54Va8gdz0b20TGUmlyp9aGnOxBcHo17GQrUCgD2HhZqghf
         y6wGkUEm8Nf8JD74nUKD3xj76ZqsXZcRNok5oFlFBIs8pczSzAfRS9bM4M/+MdVZ/xrw
         634Zo/VY8agdiP9eguD8Wgm7TCba7/4KHQfryDbU60VgH8W2oaMhyNrsKqK6UCbtJEX5
         vEczO0jJmjWNZ2uBFZW7eV8ro4XOH2zNbao/gSASiU0PqMGGQWTW1AY7kIDk1TUeN+Lz
         waD5pYacOEAAD6ZdB9YAzwLdBpSnJD316Gw4GjBNMCV3TpvFZfbgGUO++ZoqpVTcnNSn
         xBDA==
X-Gm-Message-State: AA+aEWZ95zqarjPiB0L3m6W5GYz0iWdwYEncwgjGoQNTQ8hXS1qMglQJ
        /Y5v6ykB5HNbHUKweNX8w+6wExVmSp0=
X-Google-Smtp-Source: AFSGD/Vg0abDbB/2sEq8oCD/dcOU/0kt+ws8pFf8d/jGageQ0DhDfqdwGEHi2qIak8DbGlab69791A==
X-Received: by 2002:a17:902:2cc1:: with SMTP id n59-v6mr30770703plb.26.1543284516694;
        Mon, 26 Nov 2018 18:08:36 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 85sm2258675pfw.17.2018.11.26.18.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:08:35 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:08:32 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 7/7] zram: writeback throttle
Message-ID: <20181127020832.GC237537@google.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-8-minchan@kernel.org>
 <20181126125446.562aca37cc7c0dd8456c3a25@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126125446.562aca37cc7c0dd8456c3a25@linux-foundation.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:54:46PM -0800, Andrew Morton wrote:
> On Mon, 26 Nov 2018 17:28:13 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > On small memory system, there are lots of write IO so if we use
> > flash device as swap, there would be serious flash wearout.
> > To overcome the problem, system developers need to design write
> > limitation strategy to guarantee flash health for entire product life.
> > 
> > This patch creates a new konb "writeback_limit" on zram. With that,
> > if current writeback IO count(/sys/block/zramX/io_stat) excceds
> > the limitation, zram stops further writeback until admin can reset
> > the limit.
> > 
> > +++ b/Documentation/ABI/testing/sysfs-block-zram
> > @@ -121,3 +121,12 @@ Contact:	Minchan Kim <minchan@kernel.org>
> >  		The bd_stat file is read-only and represents backing device's
> >  		statistics (bd_count, bd_reads, bd_writes) in a format
> >  		similar to block layer statistics file format.
> > +
> > +What:		/sys/block/zram<id>/writeback_limit
> > +Date:		November 2018
> > +Contact:	Minchan Kim <minchan@kernel.org>
> > +Description:
> > +		The writeback_limit file is read-write and specifies the maximum
> > +		amount of writeback ZRAM can do. The limit could be changed
> > +		in run time and "0" means disable the limit.
> > +		No limit is the initial state.
> > diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
> > index 550bca77d322..41748d52712d 100644
> > --- a/Documentation/blockdev/zram.txt
> > +++ b/Documentation/blockdev/zram.txt
> > @@ -164,6 +164,8 @@ reset             WO    trigger device reset
> >  mem_used_max      WO    reset the `mem_used_max' counter (see later)
> >  mem_limit         WO    specifies the maximum amount of memory ZRAM can use
> >                          to store the compressed data
> > +writeback_limit	  WO	specifies the maximum amount of write IO zram can
> > +			write out to backing device
> 
> Neither the changelog nor the Documentation specify the units of
> writeback_limit.  Bytes?  Pages?  Blocks?
> 
> This gets so confusing that in many /proc/sys/vm files we actually put
> the units into the filenames.
> 

I will use unit as 4K.

Thanks.
