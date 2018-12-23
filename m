Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1449C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 17:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF7D217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 17:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="K71QSFlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbeLWRRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 12:17:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45089 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeLWRRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 12:17:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so9814059wrr.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHFlYZh+RD7eeX+J1vaQ19LAH5hxt+Ph84xS6mFffz0=;
        b=K71QSFlpbfrfcxu0by3jjDgVbsQZ0y/sJnGyhb0DWxEXks8zaTGMZROkWvwQgvLGIH
         lqlKqreZPuiDm2S4RPlNnmkxcbIjB4EyckyqO8iWz75riV0KntfT0DUTpr3PpNOmZ17Y
         p+lSn6ecMGK0+uh/vCGeN8sx1oUNhUcX8muIej/0uqhih2PHsHrLsC8oF20FWQaBuQtG
         wNOLqMrUm337jMjpOjt+j3Y0pg7tZkfBBtIwiKyYnSqT49I7QjiH1yMj17wend9s1+lp
         7bePUc0/rzwJDF4FOprxZHbc8EbqUGrK2LQV5xxwNzl+xgzhm6r3HnximM4eUuDir+Of
         x7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHFlYZh+RD7eeX+J1vaQ19LAH5hxt+Ph84xS6mFffz0=;
        b=XfjKbWlJGQy+E5MNBLkwvOAZbRauivp96NI5os6ggxnqbRCupATWhjiBp9rK/heJEm
         tSw4+jrK6+AzHifDDGurE3V+JeDmsvDzMhlfoBCu2ZO/MiifLN/akhqifrbU+lj5oseY
         /Hx+fAzbp+j/CR4LofahJ3xvdD+6FI9F4iilVUNhODTmQkYvW3/MhICe9HwiAea+LDoc
         171xhu+8WFCnD6LXqLip+P3btF2ytr5MwUg9Ye9/tyH696RgXAKbvLh7kqCwMBRpq9op
         XLsKUJeMqJKccHtzQiDVtg8d7xMgbxxeDKXGXrAmbec4DQtQiA1G59iT7aCWlx2b/LxF
         MpjQ==
X-Gm-Message-State: AJcUukcL6h2t3Ab7hKp+86LQkCgPaUhCAw2t/ijJNjD4Pi1bkfo14Mc/
        2o6dsL6kgINepd5Eiv/jbjh0kQ==
X-Google-Smtp-Source: ALg8bN75Ee5iJSch7NcIBnw5ICfCl2T+a9QQDuy2jWeaEZDANihaQDPLjN6TCarjD5EM1zMq6VYR3w==
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr9006700wrw.135.1545585428075;
        Sun, 23 Dec 2018 09:17:08 -0800 (PST)
Received: from brauner.io (p5B12DA88.dip0.t-ipconnect.de. [91.18.218.136])
        by smtp.gmail.com with ESMTPSA id o82sm16533998wmo.29.2018.12.23.09.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 09:17:07 -0800 (PST)
Date:   Sun, 23 Dec 2018 18:17:04 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Marcus Meissner <christian.brauner@canonical.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181223171703.s7jm6fkyosnsf33z@brauner.io>
References: <20181223164954.hib4lbchftspidsd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181223164954.hib4lbchftspidsd@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> Hi,
> 
> I am the maintainer of libmtp and libgphoto2
> 
> Some months ago I was made aware of this bug:
> 	https://bugs.kde.org/show_bug.cgi?id=387454
> 
> This was fallout identified to come from this kernel commit:
> 
> 	commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> 	Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 	Date:   Wed Jul 19 17:24:30 2017 -0700

Fwiw, the addition of {un}bind events has caused issues for
systemd-udevd as well and is tracked here:
https://github.com/systemd/systemd/issues/7587
I haven't been aware of this until yesterday and it seems that so far
this hasn't been brought up on lkml until you did now.

> 
> If distributions would be using libmtp and libgphoto2 udev rules
> that just triggered on "add" events, and not the new "bind" events,
> the missing "attribute tagging" of the "bind" events would confused the
> KDE Solid device detection and make the devices no longer detected.
> 
> This did not affect distributions that rely on the newer "hwdb"
> device detection method.
> 
> I have released fixed libmtp and libgphoto2 versions in November, so
> this is under control, but wanted to bring this up as a "kernel caused
> userland breakage".
> 
> Ciao, Marcus
