Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE4CECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3AC2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AOFpM/8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3AC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJSEeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:34:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35064 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeJSEeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:34:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id y76-v6so12356313ywd.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lt+QqOFFE0bOaibvMge4BUmhXJ4CtZFSTWW3p6qt8Kg=;
        b=AOFpM/8lkyl+IRPGbW70F9S2w+TPbrMr0FC1Q2Iu3ykJI7K3j6lwxY3Sx0b7TtUjsf
         n2kYljcsQpRpB94g2/RneYI/NyOBVXU8doP7c7nWdzPiniyjX/bSUWB4B6YTxXLLCeDw
         bJ4YzfTlrFZGUKCyuMxVbmWPJSFeVxoN8j0yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lt+QqOFFE0bOaibvMge4BUmhXJ4CtZFSTWW3p6qt8Kg=;
        b=Zl9Qm7gETroiflSaiBhC7/RS5lQ+y5WLi1knYLHY1KqjKWQOgjKBrgECl4yi0g4+cQ
         dVzYCntqvYOF+vH6szZfD+6LxIfFezKhst/XI8QK6UCDm2AhWaJ6mUakCeQt6zLqj37u
         5VunsRl6FQnYdU+zfGyS+Vz5Xdgn0OikFvQy5+pE6w8hqJlIr4I0gtndf1AsvxmtlDaR
         VH498PLd8Kxe+pZR8jaCdAgrzb5hKsH/aBowpFbfsh9LiyNaQsAJbVTA7voHDJwO6/eA
         vsbErfsROmX4q3foE+lbGUKqI70TQHb36LrgkWSii883iwEJ2UbyEiJ/moFkkZO2c3tg
         BxoA==
X-Gm-Message-State: ABuFfojQX4h+6s6A7gm7YGKPXzXLdwg9XA/DIgnzePbJRb79eN6FmtWs
        VfyFR/CsaXs30IQ6ZMq6Qy8U1vOzLrc=
X-Google-Smtp-Source: ACcGV62RRi6nd7KUsPa5IvFyDIUDGH46QWyeqd/uwzeNC73fS02G0QDzeBh9AiVXfkFWoEGqZIMR6Q==
X-Received: by 2002:a81:af5a:: with SMTP id x26-v6mr2318336ywj.31.1539894678870;
        Thu, 18 Oct 2018 13:31:18 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id h13-v6sm7203577ywc.100.2018.10.18.13.31.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 13:31:17 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id e190-v6so12394698ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:31:17 -0700 (PDT)
X-Received: by 2002:a5b:acd:: with SMTP id a13-v6mr9137590ybr.421.1539894676722;
 Thu, 18 Oct 2018 13:31:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 13:31:15
 -0700 (PDT)
In-Reply-To: <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com> <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 13:31:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
Message-ID: <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>, zwisler@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 8:33 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> [ add Ross ]

Hi Ross! :)

> On Thu, Oct 18, 2018 at 12:15 AM Kees Cook <keescook@chromium.org> wrote:
>> As for nvdimm specifically, yes, I'd love to get pstore hooked up
>> correctly to nvdimm. How do the namespaces work? Right now pstore
>> depends one of platform driver data, device tree specification, or
>> manual module parameters.
>
> From the userspace side we have the ndctl utility to wrap
> personalities on top of namespaces. So for example, I envision we
> would be able to do:
>
>     ndctl create-namespace --mode=pstore --size=128M
>
> ...and create a small namespace that will register with the pstore sub-system.
>
> On the kernel side this would involve registering a 'pstore_dev' child
> / seed device under each region device. The 'seed-device' sysfs scheme
> is described in our documentation [1]. The short summary is ndctl
> finds a seed device assigns a namespace to it and then binding that
> device to a driver causes it to be initialized by the kernel.
>
> [1]: https://www.kernel.org/doc/Documentation/nvdimm/nvdimm.txt

Interesting!

Really, this would be a way to configure "ramoops" (the persistent RAM
backend to pstore), rather than pstore itself (pstore is just the
framework). From reading the ndctl man page it sounds like there isn't
a way to store configuration information beyond just size?

ramoops will auto-configure itself and fill available space using its
default parameters, but it might be nice to have a way to store that
somewhere (traditionally it's part of device tree or platform data).
ramoops could grow a "header", but normally the regions are very small
so I've avoided that.

I'm not sure I understand the right way to glue ramoops_probe() to the
"seed-device" stuff. (It needs to be probed VERY early to catch early
crashes -- ramoops uses postcore_initcall() normally.)

Thanks for the pointers!

-Kees

-- 
Kees Cook
Pixel Security
