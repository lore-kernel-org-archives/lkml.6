Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECCC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5A021479
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqzmT66u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5A021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeLBXSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:18:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36325 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLBXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:18:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so5469144plo.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 15:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P2g/iOJ2yw0tiT4S8bVNniIoflE3iGqOlA6JW1Y0pqg=;
        b=MqzmT66uJWHhS1jJPIO7lxCyaQcafYhFgrJCsiSAGoFxwk8wz7vlFhMezGHzgegdl6
         lpnfowlMfrKUDkGY7MgCyjuFzRwkPZlMJJsoTEVXXr+yTAO8Owey1z5AiKV3mbSPJgfp
         QltrpujgL7ZFKYhE03d/6Ex7VDpAKN1uJlpg9K+SuJo75o0cSTz4NcimgDak3L/78EPQ
         gXHbbb+u8j12qwr2Y3jbwEisCRlVNpHdJzEowUNocZQpVXRjM/aw40LeVCh8zRV+rxnQ
         asB7Eb/jK3UJhYcUxwkAau8KkSFz9wvFLaZ8HLhBSfb3qYHjFdd6X2xEx75RfPzYJG/J
         wsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P2g/iOJ2yw0tiT4S8bVNniIoflE3iGqOlA6JW1Y0pqg=;
        b=R/V3vgWJKHcMaF/NS813y8NKRWs6DSL1zD3BT9z1y9uJxZ15hPrQqZlaZ8z5J0tsJY
         NFgAmzBcJi62i3P34r/jifFhDso1bnONHRWjkUlkebakI8L8WgpvvkIPFRrZYPi+qqib
         yKDXIERn/Rni4VEjxeO3FpxzRwyJZ/1VQnIN5ROghY5f532R75jwdLen5yTeLEV8DudP
         dC8SfkwQml+sBIaNePmF1+SRmYaNErmLL5v1LPHEqXriQwXnmdv2jPKNKzBaleILeRw1
         45d5Ygl86OSfubMbVlTFKTMAhYcrGrp0rheSefbNKEfRJEN7DyoS9tc31KmAHasOZ2Vi
         w4WQ==
X-Gm-Message-State: AA+aEWZBfnsxIZepalwJEQLHL4tsybMtkldHW0YN3Wxv8HjQ5zE+7GxU
        zOeJaYyfaaodveIrNSzjb98=
X-Google-Smtp-Source: AFSGD/U90Q573qluPEkmdNVGWoCUkvGToki4R6Zk611PdYAuxvWARshZUvFzz8RGrRcLWwEzJ9EAjQ==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11mr13436215plp.121.1543792714258;
        Sun, 02 Dec 2018 15:18:34 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id r83sm21439668pfc.115.2018.12.02.15.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 15:18:33 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:18:29 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: writeback throttle
Message-ID: <20181202231829.GA21560@google.com>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-8-minchan@kernel.org>
 <20181129022358.GA6379@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129022358.GA6379@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:23:58AM +0900, Sergey Senozhatsky wrote:
> On (11/27/18 14:54), Minchan Kim wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
> > index 65fc33b2f53b..9d2339a485c8 100644
> > --- a/Documentation/ABI/testing/sysfs-block-zram
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
> > index 906df97527a7..64b61925e475 100644
> > --- a/Documentation/blockdev/zram.txt
> > +++ b/Documentation/blockdev/zram.txt
> > @@ -164,6 +164,8 @@ reset             WO    trigger device reset
> >  mem_used_max      WO    reset the `mem_used_max' counter (see later)
> >  mem_limit         WO    specifies the maximum amount of memory ZRAM can use
> >                          to store the compressed data
> > +writeback_limit   WO    specifies the maximum amount of write IO zram can
> > +			write out to backing device as 4KB unit
> 						       ^^^^
> 						page size units?

Per andrew's comment:
https://lkml.org/lkml/2018/11/27/156

I need to fix it to represent 4K always.
