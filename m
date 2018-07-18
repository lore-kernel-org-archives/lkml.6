Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41852ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F38720657
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsK67wG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F38720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeGRDqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:46:09 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46166 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbeGRDqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:46:08 -0400
Received: by mail-qk0-f193.google.com with SMTP id o2-v6so1679549qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0njeVzpI+WBn7bnpgyaDKXzdgTRSqbdTxvAoehO9lj4=;
        b=BsK67wG0jrFg8wadTm2lBp+ETQRyTpd+gBuEMqnYkcFXTbyxWvk06lwqAmYTcmA8PW
         Zw6nmmoPY0IMUM8W61b78hHai00nVyiZsifrlA+C7Y0IKcSary2NIrmBM4gHPT9fr1pL
         5SOa/3YffRrNqzkf0VlkHHWK9wFyAcZZh9hnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0njeVzpI+WBn7bnpgyaDKXzdgTRSqbdTxvAoehO9lj4=;
        b=IOUzsJfcfZA8S1NGYTjD3wtmJ+HfkD63xhLYxFyTY/pO9SWDm28StAHpKGQYJGz4oS
         1Q6bNbkQq8NhI0g5rd4zFMRexpmim4BcpSYllmamnArwE/Y1lIIOlglAstxU11zrAtDj
         3NTGhf03I2YDdTcoiOCYucGY48DH7M4o4Y7vsgK380OdZmzRTRBURxMvD0/R6AThRAmt
         5vtnabJ3amEElrknJGNiASrLklqI+6UYVoSYnkCNoQUMYjylOfgE97BApjH8sX6RxkCy
         HdKGusYTzY72Bi/VPXMrj9eOVxCS5PPYulKH94VTYWL8W82OLz0w/DBRO/9w7hPlqRUP
         4bhA==
X-Gm-Message-State: AOUpUlEgsgmcPHIMRApovT1RhHQq9EjUUJeHeiRAVh+9qOnWVk/c72+X
        F8E2ly4sxsA3RfuRkHVDdREPLQ==
X-Google-Smtp-Source: AAOMgpciv9fCb1TXhKLhGO2IICQiTXwAEiMddgBtbiwmCLXteaAnWIjfqONeOT/1oBPEEbRfHcgkhQ==
X-Received: by 2002:a37:953:: with SMTP id 80-v6mr3947475qkj.331.1531883428887;
        Tue, 17 Jul 2018 20:10:28 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id w13-v6sm2182023qtc.88.2018.07.17.20.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 20:10:28 -0700 (PDT)
Date:   Tue, 17 Jul 2018 23:10:27 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-console@vger.kernel.org
Subject: Re: [PATCH 0/3] use unicode for vt mouse paste
In-Reply-To: <20180718020604.3u25omf5fxqvsy3q@angband.pl>
Message-ID: <nycvar.YSQ.7.76.1807172304250.11681@knanqh.ubzr>
References: <20180718020604.3u25omf5fxqvsy3q@angband.pl>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Adam Borowski wrote:

> Hi!
> Based on Nicolas' nice work (in tty-next), let's avoid corrupting characters
> that have been copy+pasted via mouse selection.  The uniscr array holds
> their original identity even if they got mangled by glyph conversion.
> The glyph conversion lossily turns similar-looking characters into a
> representation, and everyone else into a replacement character.
> 
> There's no proper handling for CJK (yet?) but anything of wcwidth()==1 will
> work fine.
> 
> The whole thing doesn't get enabled until something reads from /dev/vcsu for
> that console, but let's test this code first before enabling it widely.

Glad to see this. For the whole set you may add:

Acked-by: Nicolas Pitre <nico@linaro.org>


> Diffstat:
>  drivers/tty/vt/selection.c | 48 +++++++++++++++++++++++++++++-------------------
>  drivers/tty/vt/vt.c        | 10 ++++++++++
>  include/linux/selection.h  |  1 +
>  3 files changed, 40 insertions(+), 19 deletions(-)
> 
> 
> -- 
> // If you believe in so-called "intellectual property", please immediately
> // cease using counterfeit alphabets.  Instead, contact the nearest temple
> // of Amon, whose priests will provide you with scribal services for all
> // your writing needs, for Reasonable And Non-Discriminatory prices.
> 
