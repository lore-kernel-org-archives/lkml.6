Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41269C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D552087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZofeQTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfADVwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:52:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32770 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfADVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:52:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so18023894pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 13:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Pi2FCQo4e9COFo81i20fIGeuIPKgFtmcVSb3Cro5GM=;
        b=lZofeQTUb9DMPtRnVLVlt0Yy1dWoj1Ubg4q4s+MJ3tlydHM7z0mRlw5Eqq+myyB4i+
         eA1A2HXPd1TAbqmAzxLZ92HUL6xP/o2TJ5PvMJ5yaLtEA3ANrHX0NhGPsRJ5p84KwLyD
         WO+XG+5sma14KPFM16D2XHHre8ptpsO4HvcwnGRMGLj9e6a6WAUWs8Cvw3aVBGTA3T+O
         BT1OTc5ZoSj8VTUAEPJSgnFZgdfPDEgxfP3Y68UmEPGVziR7yH9ddm4A6Q8F8aLf/+Qf
         zYRPvIUc+8MZaWvzfXNy+Q4i65RzkY4xNaiTLKDb5lchpPZLvn2hDZvOvVU26Oh6ZuMb
         Z1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Pi2FCQo4e9COFo81i20fIGeuIPKgFtmcVSb3Cro5GM=;
        b=IKTh64tDOrfebDiuchqBsOYSCWv3ITBR7buZQN3Wg+fAq2YLijbq6wBJF6LxIDmoUP
         oLOOnbW2PWQD3bThvE+8TODs2mtD0qa0AEC+dAqi4TDrxPFR1bi1zHfvHHSu5E3ZzL84
         Fr9CTfuBFesbI0AARe4C91p2zshPuSPTNuthLG6NGukYApz3FH4xhUEM8i7EFBrYjcLS
         Qg8WhEQ5MZJ72LQrUNgPagCrUd6om8fM3puRGo9w0U6uL8BlH+PPl7NWGyRc1x9JFh4d
         y/oMq7Fdsllq4b23LUJviHzQxXfzj68I8ZkaBXyVEivs7PZKyFot0n6E950Q1TwylyzL
         LlIQ==
X-Gm-Message-State: AJcUukcdPVqbw1OrAR3mOe3+KKRM5cEz7gKDL0dY9e/3TG2U5P1hfT1V
        cVwCWaCSaP1AeUqyEJelXmS33T2b
X-Google-Smtp-Source: ALg8bN78VLsjzTJ64qgySrzYq8reZkH1gROGAKoa6lO3TgB24MYfw9HE9CnkVxN/Ayn6a/YcrRuZDg==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr2936597pgk.21.1546638772155;
        Fri, 04 Jan 2019 13:52:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186sm114120499pga.36.2019.01.04.13.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 13:52:51 -0800 (PST)
Date:   Fri, 4 Jan 2019 13:52:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
Message-ID: <20190104215250.GB18732@roeck-us.net>
References: <20190104174242.GA9173@roeck-us.net>
 <CAHk-=whBbxN6+h0gOEX6tAQDqM1kMfTJfoOWF+OpBD4r6swsdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whBbxN6+h0gOEX6tAQDqM1kMfTJfoOWF+OpBD4r6swsdA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 10:03:42AM -0800, Linus Torvalds wrote:
> On Fri, Jan 4, 2019 at 9:42 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > ... and this is just the very first build I happened to try this morning.
> 
> It will fail for all sparc32 builds. And unlike the powerpc case, I
> hadn't even noticed this one.
> 
> Trivial fix for powerpc/sparc32 pushed out. Hopefully that was all of it.
> 

Confirmed. The only build breakages as of right now are imx_v6_v7_defconfig
and all h8300 builds, as before. Patches are pending for both.

Guenter
