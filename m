Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E319C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5B62186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMg8oNDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbeLTRit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:38:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35806 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbeLTRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:38:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so1211291plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FVNi92gM40tqWY5X2ukNQRQox/cgO8UytsTd33+nULQ=;
        b=PMg8oNDB1fEotyVjQ2ePPlYqP/m8Tempgc0MTtGzFLLFa3dRiCiGsf+Mqxfoo5SLH6
         VvlgVcopPPqyDydmBXTI0WhB7EKR3EOR5IxOixbOpQpkEBVt+VorEaGvLh+GI/rcwNoa
         CMXFMvzbEF5Rl6wRdIMLEfWTiXg0NFnnSzLnJq4AiYbZUyDbUQFLRFfAeusGHxNUK/6k
         3WE8+ghvCvRips/brZ71NJ25TGwLFBpxnmaHvt5gfyPHzfZa2IsSZXSGKIi0RSoTvfcm
         O3wIzRgXQ0NfgC4ueJwtNRDsVqUhiALmCPIKO2ozi8eZA7kCFJupz1ZDNfT5HMzKNFoV
         RpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FVNi92gM40tqWY5X2ukNQRQox/cgO8UytsTd33+nULQ=;
        b=sjwSWRPa5O0jd5hE2G4NrjTobosU8CCay+yo4Ihih6RgR1EyOUDjnhXYxxjnWgtr+p
         bLgOvEaBmlrttBuUHBPl9GT/SRWZU79eP/5/bNgt97/1g899NRSbypeKZs596szy2NPv
         rjQzVnSLU2soTtnDHsBHXEVzfcgpFFlEzlL7/ci63nnjmJSqrdG+OBGn+LMT3bXKaWnb
         ICGdAWBQRwDJYnwhUW2k5mq+NBgTuunYxpSZf4GdDd3xDSxYAX5IWORpf8aBoKIjlTSQ
         vKBsiY0Ex8mpVfRz/O0pymnr1JpN41wJR35l8/erYozcW8wBYXWeJIoeEIGGj/xB1nzF
         fr4w==
X-Gm-Message-State: AA+aEWZAacTufI0aJWkUUVgpxx6qFhLO/rX82swXaFRgKjk8Hw1yYt9p
        Pr+EQi0Iysp8cTGYpjYad60=
X-Google-Smtp-Source: AFSGD/VJ+1RJkfs4VwrDPpiPOUvJTErviEhjhgYx0Pl/GzYzwxTTcLK/1O1olgxPubjoLC397oY3aw==
X-Received: by 2002:a17:902:b83:: with SMTP id 3mr23794695plr.42.1545327527857;
        Thu, 20 Dec 2018 09:38:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w128sm29973956pfw.79.2018.12.20.09.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:38:46 -0800 (PST)
Date:   Thu, 20 Dec 2018 09:38:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181220173844.GA5838@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <20181220152111.GB17408@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220152111.GB17408@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 04:21:11PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 14, 2018 at 05:11:25PM -0800, Guenter Roeck wrote:
> > On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
> > > It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
> > > result in the inability for the kernel to have a valid console device,
> > > which can be seen with:
> > > 
> > > Warning: unable to open an initial console.
> > > 
> > > and then:
> > > 
> > > Run /init as init process
> > > Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> > > 
> > > Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
> > > really is no drawback to defaulting this config to the value of
> > > SERIAL_8250.
> > > 
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
> > defined where it was not previously. Example mpc85xx_defconfig. This in
> > turn results in boot failures for those configurations, with an error
> > message of
> > 
> > of_serial: probe of e0004500.serial failed with error -22
> > 
> > which wasn't seen before.
> > 
> > Not sure if replacing a potential problem with a real one is really an
> > improvement.`
> 
> What ever was the result of this long thread?  Should I revert
> something?  Or was a patch proposed?
> 
The problem still exists in next-20181220.

Unfortunately this is now just one failure of many in -next. I see more
than 90 boot failures (out of ~330) there, not counting the build failures.
And that is on a good day.

Guenter
