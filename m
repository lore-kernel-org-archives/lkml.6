Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D11C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D563220871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRLGhVBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D563220871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeFTKwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:52:12 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38709 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:52:11 -0400
Received: by mail-pl0-f68.google.com with SMTP id d10-v6so1565759plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l569RuhWYVP20wPDF9XmbADynhofXNMx1ZIxGdE2ai0=;
        b=FRLGhVBB6+MsZUvkIK2cQ5LHglMe4SfK5t9Yjhl7ism1b/TbixenvCQkeyx5hLxUyY
         cuSnGBnfe6Y9Ev27XiZS0izOa6wnjKjMDplD3Xf1ZWyH18XdfnD1JInj3DLpfKFR+vVG
         XIo8qCJinzWQnqSB6yKMf1T9m3CfVoFBHxhQ5wS21YsUl0i6npRb7/OVwiyAzX4ReuU2
         kbgMH5z7HF20OvY8quGtoQspb1LkEnwzcBYQnKdCbbFwGX1CK8NIeTY/HKd3u1x0zc6G
         x3COj4I9sGcK6PnftGI5NkVt3IJnY2B6Fdtm8zBGtj8eSBK+/pSbDT2h63xxaxxtrmf3
         wIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l569RuhWYVP20wPDF9XmbADynhofXNMx1ZIxGdE2ai0=;
        b=CdpcnLk9FjRvV6D0x2pPRKVette03g9nVQsDbHHIAJytiF005b0sIgyLDhiZtIttY3
         ivDqlHSJe55YtnNt0WceZ/UVr+xUU/2TVUCu7x6RrtJJMHW2sCAnW3GSSoqBJyWU6wBw
         syWufSoJNY3yPBJ6m22B84UUpvv2BPloud1DWY+PVKhQKWnr3wWKrvhf7+3e6ATP65fU
         MIHzJJDmmzrzIz0jjJ8lcLt+3PKQ9DD2d5ApH4DHOuL/Hd7lIq/T11UQ2iQbxMuqeTEo
         usbFEmk4nz0u0622MtrPq1KpP2dM3l1rPF6CRw8jEVy3TCtab49QOhtgbP+ZEthSs9+j
         JBFw==
X-Gm-Message-State: APt69E2Lt5YPklkAtaUMUZ3j+ALAVxHyKoxfkerMaaz50sxDDec4XvW0
        qmJBw143Mk9+Gfs49CGA1sU=
X-Google-Smtp-Source: ADUXVKLCA+1a8r1TydzuoUKnLtQMyDnspVlVjAsDWwV96BTsCtEZOpuY+eXGABz0ZcdnVqhBLktzIQ==
X-Received: by 2002:a17:902:8685:: with SMTP id g5-v6mr23100470plo.180.1529491930959;
        Wed, 20 Jun 2018 03:52:10 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id h78-v6sm4565055pfh.141.2018.06.20.03.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 03:52:09 -0700 (PDT)
Date:   Wed, 20 Jun 2018 19:52:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180620105206.GC444@jagdpanzerIV>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
 <20180618061550.GA27996@jagdpanzerIV>
 <20180618062306.GA29683@jagdpanzerIV>
 <20180619093244.ehj34uhpnpv6447f@pathway.suse.cz>
 <20180619094953.GB2631@jagdpanzerIV>
 <20180619092629.55146df7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619092629.55146df7@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 09:26), Steven Rostedt wrote:
> > 
> > But when I set /sys/module/printk/parameters/ignore_loglevel I naturally
> > expect it to take an immediate action. Without waiting for the consoles
> > to catch up and to discard N messages [if the consoles were behind the
> > logbuf head].
> >
> It's not that critical to have that change take immediate effect. It's
> not a common operation, and I doubt anyone (but perhaps you ;-) will
> even notice any difference.

Quite possibly.

	In the background (what I didn't post) I thought that
console_verbose() sets ignore_loglevel. So we could have a race
condition - when console drags behind, something sets ignore_loglevel
but it takes a while before "all" messages actually start to appear
on the console.

	In the foreground (what I posted) I thought that the whole
reason the patch exists was "In SMP printk can work asynchronously,
logs can be missed on console because it checks current log level at
time of console_unlock, not at time of storing logs" So console_sem may
be scheduled out, or simply slow. Once again, it may take some time for
ignore_loglevel to take any effect.

But probably it's fine to have this new behaviour.

	-ss
