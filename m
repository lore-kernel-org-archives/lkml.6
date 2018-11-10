Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32350C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF48720883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rDtwYt9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF48720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeKJLca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:32:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43674 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeKJLca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:32:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so1586765pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 17:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0lDTTnRz1Cu4Oscn2W4VK8h2tsMFzMBklznMjhc0CXQ=;
        b=rDtwYt9ehQgvItQ/LiK74/hRP8chNZBRF3SpmOayofveXOF8JaFtiXHLpkvXJxTp64
         J5V83W3uA8rdZnCUoAhrRkhp9IlCliF2XODQuH1jDptCQd0QxzdJrOig1tzGPq8Y/yMl
         DeuJkq8aV1maJgeoTxOIc2PNHV3VTXINmdFC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lDTTnRz1Cu4Oscn2W4VK8h2tsMFzMBklznMjhc0CXQ=;
        b=bwmHtfTDDCRTiqusSTmnu7eYs1Ga1zQo6j32mj2jDDq9h/I/ZqTW/qLQPWLgXuGP2C
         OybtJJfxPIXtUn99cga7epEfib0RadFTgSGkfYYAs2WZH13GmgDqqr4Q8/OCe/41LsNo
         yKok6l8LfEuS8JVyS9Kys33JCJxEObZxdvaz9Yp0Jw7TQEN20JyQpLAg/qNl2P/3RAbC
         9HDDoMHsJqhZ3g548h7ErqmPzykvdHF3WIghVo26DPWIIqW1Hfr4MtjQl7hM5gZYrImM
         oJ6sMB2AAFT38dGHQ6RUA2s48TAnaF/1y2z4h68XMtzwoqwMPjRok7rChYm3Wi1U0GTI
         o6bA==
X-Gm-Message-State: AGRZ1gJpcnkO3drlBZD3mTL2GjxjRdltVFaD0hMq8xwCvyHoUVMRVPii
        oQ6tjr6drYxy2enM6o9VDdqRjg==
X-Google-Smtp-Source: AJdET5cmyKTfptWA6ot2HmexprXKlThW4f3K6SMKRvltVzfTgnCfzRtFDf0mdfPCG2CbpQ44dMbzFQ==
X-Received: by 2002:a62:114c:: with SMTP id z73-v6mr11048963pfi.192.1541814554993;
        Fri, 09 Nov 2018 17:49:14 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id o1sm10335882pgn.63.2018.11.09.17.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 17:49:14 -0800 (PST)
Date:   Fri, 9 Nov 2018 17:49:13 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michael Tirado <mtirado418@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, jreck@google.com,
        john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        dancol@google.com, bfields@fieldses.org, jlayton@kernel.org,
        khalid.aziz@oracle.com, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, marcandre.lureau@redhat.com,
        mike.kravetz@oracle.com, minchan@kernel.org, shuah@kernel.org,
        valdis.kletnieks@vt.edu, hughd@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to
 memfd
Message-ID: <20181110014913.GA202500@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
 <A7EC46BC-441A-4A06-9E2F-A26DA88B5320@amacapital.net>
 <CAMkWEXOLJ=ymbVjQfA2MD8XA7Y9Lu3ByJYUY-JvpnYKJ5gkY1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkWEXOLJ=ymbVjQfA2MD8XA7Y9Lu3ByJYUY-JvpnYKJ5gkY1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:02:14PM +0000, Michael Tirado wrote:
[...]
> > > That aside: I wonder whether a better API would be something that
> > > allows you to create a new readonly file descriptor, instead of
> > > fiddling with the writability of an existing fd.
> >
> > Every now and then I try to write a patch to prevent using proc to reopen
> > a file with greater permission than the original open.
> >
> > I like your idea to have a clean way to reopen a a memfd with reduced
> > permissions. But I would make it a syscall instead and maybe make it only
> > work for memfd at first.  And the proc issue would need to be fixed, too.
> 
> IMO the best solution would handle the issue at memfd creation time by
> removing the race condition.

I agree, this is another idea I'm exploring. We could add a new .open
callback to shmem_file_operations and check for seals there.

thanks,

 - Joel
