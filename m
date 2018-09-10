Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74107C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E0320866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzzjCqMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E0320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeIKA2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:28:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35296 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeIKA2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:28:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so10985909pgf.2;
        Mon, 10 Sep 2018 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tG3BOUC4G+pUOfDcvD9E3iSEGX+icyihwASV9TTf7MU=;
        b=nzzjCqMeOvn2KkNZk0dqUbrtwPiYHSDHssYLRifoPJGEN5cr0fN2XBSpfu4vefjuFn
         WZSF3VFYC62AojVjU9LqWcWLFrPTKOS2HC8ubkB5isQyY6L7JqdyFk9XBGpi/jDA/xYn
         4sUFHs/ctILb1mXfe4HKHozjAZC0N6fJBiUheMLXd5TPGB6HMASFoCmuzmkeo6vpyu6D
         +g4RaxZwpAFFjo40xH+LMmb2XY+/ibkFAUuvOzhyaJsRRbehvXuF4SN1jTJVm3EGUJ8s
         ZPbsFSPRt7JaWj18fwiNzSlnU9d7BO4jX11a+9/UQy/uD93enznoMDNFV4+VntKVgCqm
         GK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tG3BOUC4G+pUOfDcvD9E3iSEGX+icyihwASV9TTf7MU=;
        b=nD26GSqkh40fV5+SeHSpKnjEe1X0tzokJxPfGXcNNhaQSSaVUaYtioBHRkc6yerFB4
         d2rD8jV34oDKQci8rhrs1wWIghKDcN7L+CjZM0i24thTkczHJiz/gm3M1nw0A82fn0rK
         F7FzBsSj0bLyMzCgbYAFJ/C2zd6vsFBupaKTNw4qHcHRCjgRQA2P/YBgkal51XvX2CpS
         8GrpwWRvYOy0q8cv0NEbXsyi3hHLyULacUxrWGYE7YCAe+x6aA517gn57XhuIOAgbSlf
         A4OLwwToOzjlJbE5ABiwBekmp8/T25cpxl9w72OsWYIUqSIS/V78JVAAnVTexFzrbWgf
         +lJg==
X-Gm-Message-State: APzg51AgZdNB1Aalu7Bce+38ZWdigDH/U4WxbzSu+R+lAKpt+csGFd+q
        OYBZOTKCaGGU/APyrq4RTg27gLEG
X-Google-Smtp-Source: ANB0VdZgOQKx2yWdymVp5XYa+S3ZdTlXMjumf6DEkexYB9dh+O/ZJpyPv9KAKpTVwF9Bi3eeJLviiA==
X-Received: by 2002:aa7:850b:: with SMTP id v11-v6mr25558217pfn.165.1536607958445;
        Mon, 10 Sep 2018 12:32:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e190-v6sm33154945pfc.81.2018.09.10.12.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 12:32:37 -0700 (PDT)
Date:   Mon, 10 Sep 2018 12:32:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression in next with filesystem context concept
Message-ID: <20180910193235.GA8769@roeck-us.net>
References: <20180907161023.GF5662@atomide.com>
 <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <11959.1536420266@warthog.procyon.org.uk>
 <20180910160836.GT5662@atomide.com>
 <20180910183146.GA17726@roeck-us.net>
 <20180910192658.GX5662@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910192658.GX5662@atomide.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:26:58PM -0700, Tony Lindgren wrote:
> * Guenter Roeck <linux@roeck-us.net> [180910 18:35]:
> > On Mon, Sep 10, 2018 at 09:08:36AM -0700, Tony Lindgren wrote:
> > > OK thanks for tracking that down, next-20180910 boots again
> > > for me.
> > > 
> > 
> > Did you try to shutdown and/or reboot ?
> > 
> > You might see something like the attached if you try.
> 
> Hmm not seeing that here with next-20180910 on ARM at least.
> 

Correct, the problem doesn't happen on arm. That is the one
and only exception as far as I can see.

On arm, the only boot failure is witherspoon-bmc with
aspeed_g5_defconfig, but that doesn't crash but simply hang
during boot.

arm64 still fails to build, so I don't have any data there.

Guenter
