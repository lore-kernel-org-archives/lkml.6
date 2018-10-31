Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF923ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871F12081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRVrtdkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871F12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeKADkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:40:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40485 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbeKADkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:40:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id k12so12439068qtf.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JcE4FZ1eB9Wad0dck6vJotpK0giY0Mfs8oQHiLnSdUA=;
        b=bRVrtdkLZp1abdwEIzvVFoW/0UI1abuOr2yT/HX97a995lPLW4sFSKuz0nuHhBj6Op
         cbOKDl2dRZC+fklQCZRtDxRts06gGeZfe5TB5YUP7RmcZrCi5AWxVAuTDZ334TlaMi4I
         18cJMU56uxKWQ7vTAPApWoC5pf6ns5MtjrOIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JcE4FZ1eB9Wad0dck6vJotpK0giY0Mfs8oQHiLnSdUA=;
        b=WfoJBXgkNE1NKGf7+hzaJ7BXVo+8HaUVWMSgTNbhMZ/J13ftT7XTVt0JPAfTo61HpH
         bCkb9xOSo6FoY6v8xWcr8/pNYoZPZb1BdiUrJLXYlpDohBjSpxiSggtqBQLafFSxyjVp
         OE/H+6ukHR2dHBoAThFEBQPJgASoCY1r4Sni+39ah5tqXMjs47a6pwBvVARPPPontKm4
         zMyDDVUeChApyJKmYrLqRa9osjGv9vaBzAMMpPzGHM35wC46nTjsu5n2ozRk4E6KJfFb
         hjpmsYrSE5JNlffcltnfyVwG2eTCqdxkwqwzcZ7resKDu10VfjEVoAesNMu4P7A/+umW
         VlJQ==
X-Gm-Message-State: AGRZ1gIvB0xFDajyst+I4qKY2hEglq/jjqCWKb9LLCncx61SbHNAROm7
        0cn1LP8CxcmdKDax4f3/ldQlkQ==
X-Google-Smtp-Source: AJdET5egk96PyhJ0K4a+P5XgUVHI3EJ/u2sMQV/CYJgaCthkUnHUg15rwCzFDuvILtGS9+YJ2d56Yg==
X-Received: by 2002:ac8:4804:: with SMTP id g4-v6mr3793659qtq.66.1541011266535;
        Wed, 31 Oct 2018 11:41:06 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 67sm304275qku.60.2018.10.31.11.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 11:41:05 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:41:04 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        John Stultz <john.stultz@linaro.org>,
        Peter Anvin <hpa@zytor.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Riley <davidriley@chromium.org>,
        Colin Cross <ccross@android.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/9] time: Add SPDX identifiers and cleanup
 boilerplates
In-Reply-To: <20181031182107.726051323@linutronix.de>
Message-ID: <nycvar.YSQ.7.76.1810311439040.1498@knanqh.ubzr>
References: <20181031182107.726051323@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Thomas Gleixner wrote:

> Add SPDX identifiers to all files in kernel/time and remove the license
> boiler plates.
> 
> Aside of that use the chance to get rid of (stale) file references and tidy
> up the top of file comments as they are touched anyway by this work.
> 
> This work is based on a script and data from Philippe Ombredanne, Kate
> Stewart and myself. The data has been created with two independent license
> scanners and manual inspection.
> 
> Thanks,

Changes to posix-stubs.c (the only file I authored) look fine to me.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
