Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B74C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840C620831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yhkoBaYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840C620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeKTBkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:40:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbeKTBkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:40:43 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6594E2089F;
        Mon, 19 Nov 2018 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542640609;
        bh=mEgiFOVPtM6jJpKny+rgLzi5GSySjLBhY/RKfK9aM5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yhkoBaYDV9t0TKpTLpgxGRmVvz/QE2r2qU5V4e47jn+s/TGcxIvfvHrHTLn9Qo1cs
         oCGgpro3H1HtdPEzaVh/HISwI+Tq1sdAbnJ/1AUtWxEx4sRuJ4N9JreCGMPUJYh8ks
         UBiJNwKz3TyYmjFegbtygmr9kn4Drh8EUbLmfOw8=
Received: by mail-qk1-f176.google.com with SMTP id n12so49062878qkh.11;
        Mon, 19 Nov 2018 07:16:49 -0800 (PST)
X-Gm-Message-State: AGRZ1gJlnVxr8Y0sALi2J6KOgqiBEtafjWDgBzh1FmUVZb3TCJXYuTDn
        sNrxWgwErjhoBv9voOo2WFTBDYYO8mWEa9EPxw==
X-Google-Smtp-Source: AJdET5c5e7RnuYKQqOLrNTp6PfBGC5FByUfT7Q9BVteFfiyRHHyePyvmVX1n2vyb296ixfKAlyKYs1Nw6BZl4JkzpLc=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr21629619qtf.26.1542640608630;
 Mon, 19 Nov 2018 07:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20181114150904.19653-1-johan@kernel.org>
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Nov 2018 09:16:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyTVsN1=YpeHNtTr+Tpw9Qmqd=mWfhg-d3WgzUX7DqKw@mail.gmail.com>
Message-ID: <CAL_JsqJyTVsN1=YpeHNtTr+Tpw9Qmqd=mWfhg-d3WgzUX7DqKw@mail.gmail.com>
Subject: Re: [PATCH 0/4] serdev: make serdev_device_write() more usable
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 9:10 AM Johan Hovold <johan@kernel.org> wrote:
>
> This series make the synchronous serdev_device_write() helper more
> usable by
>
>         1) allowing drivers to pass a zero timeout to indicate that they
>            want to wait forever;
>
>         2) returning the number of bytes actually written (buffered)
>            if the helper is interrupted;
>
>         3) make the helper use interruptible wait so that the helper can
>            be used on behalf of user space.
>
> Finally, the two write functions are documented using kernel-doc.
>
> Turns out I was using the wrong timeout for two gnss drivers that
> expected the helper to wait indefinitely. I've fixed up those separately
> (by using MAX_SCHEDULE_TIMEOUT for now), but for the helper to be usable
> when using flow control we really want it to be interruptible.
>
> Besides the two gnss drivers, there's currently only one other in-kernel
> user of this helper and that driver (rave-sp) uses a non-zero timeout
> and doesn't check the return value and therefore does not need to be
> updated.
>
> Note that this series depends on the two above mentioned GNSS fixes
> (submitted for v4.20-rc3).
>
> Johan
>
>
> Johan Hovold (4):
>   serdev: use zero to indicate infinite write timeout
>   serdev: make synchronous write return bytes written
>   serdev: make synchronous write helper interruptible
>   serdev: document the write functions using kernel-doc

Other than the one nit, for the series:

Reviewed-by: Rob Herring <robh@kernel.org>
