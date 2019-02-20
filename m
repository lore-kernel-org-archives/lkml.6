Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D740A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAvIOGZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBTXbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:31:23 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34763 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTXbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:31:22 -0500
Received: by mail-vk1-f193.google.com with SMTP id k64so470845vke.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Geu6kIrLpNT7LHalwzVTG5ZGD8OIATzIgsMLCJNtbM=;
        b=dAvIOGZI7j8SE4aR7yOduckZGBNNEqTv+i+KAt0XfRFWDa+lt0RBaW2VNX77WzJf24
         ZAImDouNJVsVrAyEyOt+geyw8qmpuRfbEX/Y+VScoKjFLjspEjh6MKsXITs8dkadwZ5E
         wa0BbhXPm7OIsxAKy19GZ2Gi05Sbu/KKLokcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Geu6kIrLpNT7LHalwzVTG5ZGD8OIATzIgsMLCJNtbM=;
        b=O9o27sUK++tCpZsEmwU6+/ebTVLIS3sRekfVwYNZS8/WHe6ozM5tC9dAxLmPiTasDw
         Eao0lMRVukF0t5itS/KN2AmBzq8Xqhk7Y0VMC9V7sgkoozJ3FFHjVpDH/EXaxi7ZslKD
         pbLQ6h35UjiQTALcPF1zYmYAeFIHVYnHZkUrh6E5k6e62ND5d3gFmvc5bxMp42YXIPTO
         ZUCIwrZhS83XTCk2gLDaG5p6jF1a+bb1q/0+1U73FVk21RwWyE1kJwdig2znmDHPScqg
         QTd6HlSLjltWLr6JBjM27MlGifJesImhKhj+lSC9TqoTU5ovgms+RF0Atmj54jWYF10R
         gKTw==
X-Gm-Message-State: AHQUAuZzXli17+XPpOyIyWVCVecDrPye4m6lPHWOnpZVgYgyUtiaWSIm
        e6/NJZ+yhVv/y7eGqAFeXqLNZoNBbbw=
X-Google-Smtp-Source: AHgI3Ia4CI3stm9lRFlSsqNOZH9nlixz0AckBOtfp8qS3WQD2r3K9IX5/xbeuiMnuJqaCusSxnvpkg==
X-Received: by 2002:a1f:fc0e:: with SMTP id a14mr20117972vki.91.1550705481617;
        Wed, 20 Feb 2019 15:31:21 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id z70sm3395838vsc.15.2019.02.20.15.31.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 15:31:21 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id b6so4826373vkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:31:20 -0800 (PST)
X-Received: by 2002:a1f:998d:: with SMTP id b135mr20648842vke.44.1550705478925;
 Wed, 20 Feb 2019 15:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-1-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 15:31:07 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+gHMCjxMr3k0UNBcsT6DYuALtpROxazf7YVX=SUja_cQ@mail.gmail.com>
Message-ID: <CAGXu5j+gHMCjxMr3k0UNBcsT6DYuALtpROxazf7YVX=SUja_cQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] lib: Add safe string funtions
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
> During your talk at LCA you mentioned that we could do with a couple
> more safe string functions.  One to zero the tail of the destination
> buffer after call to strscpy() and also the self explanatory
> strscpy_from_user().

Thanks for jumping in with this! :)

> I couldn't work out if this is a false positive or not?  Does the new
> config option CONFIG_TEST_STRING need more documentation?  I don't see
> where extra docs should be added and it seems self explanatory as is.

Usually this just means the help string in Kconfig is "too short".
Sometimes this is a false positive -- really up to you if you think it
needs more. :)

On to individual patches...

-- 
Kees Cook
