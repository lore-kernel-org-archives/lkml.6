Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD6C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406E42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JHLzLm2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406E42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeJXWQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:16:09 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:43549 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeJXWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:16:09 -0400
Received: by mail-lf1-f47.google.com with SMTP id p34-v6so4008111lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KcIfq/XdpOpP2rGZXfyG1mLfwb+oE6V4BmLTdiZnFI=;
        b=JHLzLm2HOD6etnXMtgKfBXDYElWqGyeNalYJZyh1BgrhpwTmA3MfQBB96oAuqfX2sR
         QplHS5olEfcLEXWDyW8Q165t6Hawys+3zLYCWtBopmKPm/gKB66VY23UvYDLQiOihtzs
         7+Kwk+/cBnhvd7DVRATaME6XFJS4kVOnYL1+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KcIfq/XdpOpP2rGZXfyG1mLfwb+oE6V4BmLTdiZnFI=;
        b=cmplW7fO154VZIrdZdgIpedYPujK5fBjIlkVJwpM74mM6Hp8ub9aQbl2CYYi1VHoL7
         CiE58gYd9vdRanQauJe2WByS/aUP5rueulqD3Ga/7H1UkOWAGUBpS+ElAv1cZSCwbFOd
         rFYapX6T7Zu2J+QbpVitzXpukY7X16NDN0E1sUYS/si7X0tOlcPgLMlfGXFZ5bpB1IHF
         P1JArdc+OTn2ucnVRgcLVcEkb7vL6GIPT0cflEosnd+eR6IBEsbHAB2HDpoYOhQ7poMa
         QNpZhpAGoSelDI74wc0kW10PhY3xhoJfbP5fzcZiL43wRkfrXEGrhbWRWWE1wjtMCrG6
         veLA==
X-Gm-Message-State: ABuFfojd3rVhEDJqKLfkeWHKm3G5j1BSPMmuP+5Vn1Lfr9u7xGjOxH+3
        kiJZMBzlGc9HDNv62ihNTFZdgFb0jol87Xcr
X-Google-Smtp-Source: ACcGV61w//zqRx6xttldg6exaYBKHs1hrMFq3esOGKo2HxgK9y+8rxMd56iEuTIh2zqToU92ZISJhA==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr5913613lfj.126.1540388875992;
        Wed, 24 Oct 2018 06:47:55 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b25sm702896lfa.96.2018.10.24.06.47.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:47:55 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c16so4014246lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:47:55 -0700 (PDT)
X-Received: by 2002:a19:1cc3:: with SMTP id c186-v6mr14229556lfc.16.1540388874612;
 Wed, 24 Oct 2018 06:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181023040758.GT32577@ZenIV.linux.org.uk>
In-Reply-To: <20181023040758.GT32577@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 14:47:38 +0100
X-Gmail-Original-Message-ID: <CAHk-=whxB-k9B9By5eQkj6HvRB7qRrBHZb943i979tqTmq6BJA@mail.gmail.com>
Message-ID: <CAHk-=whxB-k9B9By5eQkj6HvRB7qRrBHZb943i979tqTmq6BJA@mail.gmail.com>
Subject: Re: [git pull] tty ioctl cleanups and fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 5:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         compat_ioctl work related to tty ioctls.

Pulled,

                Linus
