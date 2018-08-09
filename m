Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19946C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B7920C01
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cIMENDdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B7920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeHJBaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:30:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40191 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeHJBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:30:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so3165451plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=7qHkOxVlVyaGLDdR6zs2X8MRVLljmE/NXWuhsozuKV4=;
        b=cIMENDdAIES0knWIOW8JvUVYlVVfDbRL+WI+Jtxw3aOz4UsaU1K2U68jGtwfxsbg3u
         viwEY4qRnxVQyfKQ4tTlSgJ/N2f3ComlqwoYbHjPuiRlZV91ROWWBlC8p9aMw0I5hzBC
         9h8NJVPfgpRHRJUnsRWdaBsVGIw2Qz5IdbbL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=7qHkOxVlVyaGLDdR6zs2X8MRVLljmE/NXWuhsozuKV4=;
        b=nHxH7ExbO97HwMFvMkka0iZIvm9uxUHRswRiNgxP01uQNjWoeMwkaAlOw950rBSpWU
         uVZPtyeX+jxxcQV7REBn9JF9oWW6f8TlIZFnFpWvwPtDKSJNiEnS6Kb4FZnmpZH2ZHtO
         +js0jPHyCk8ka+9Hsl0qaSCScc+9cXpNAqBu19t5mI0vGewHT4HUqwDi22g5a2xtoXE6
         dWyQlGEJBpW8F8zD5j9p01saGJN4eEEoHLU9UNEPZ8dG+sXH6yfRank6NyW9wf8OeKSV
         dUeDHwMN6ijF6dGI7SqgxegSsNABARMZjvmkB2pBOY0lrFEcdstkA+o0/o+gF0ckBCxb
         ym4Q==
X-Gm-Message-State: AOUpUlEF+I82DMdQS5aC8jc0wwqi3bZ1181sCZQdE2xmdSLDetoNxg1A
        ZtCHmvuYCPQRNT1OeV7LHNvv9Q==
X-Google-Smtp-Source: AA+uWPyxdGnedLp2YeS53CAnmqzhpEhBFafh4hAuAWzPSPOXux8YYtseWOjmbMu3EEvd8u9TimC5Ng==
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr3669498plx.73.1533855799965;
        Thu, 09 Aug 2018 16:03:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 16-v6sm12422038pfp.6.2018.08.09.16.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:03:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julius Werner <jwerner@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAODwPW8eg2WOh9-Raeb8Q65E-5D7RDheDU8e+H68FHGa0MS37A@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-8-swboyd@chromium.org>
 <CAODwPW8eg2WOh9-Raeb8Q65E-5D7RDheDU8e+H68FHGa0MS37A@mail.gmail.com>
Message-ID: <153385579866.220756.16086660810932774163@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 7/7] firmware: coreboot: Request table region for exclusive
 access
Date:   Thu, 09 Aug 2018 16:03:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2018-08-09 14:07:31)
> On Thu, Aug 9, 2018 at 10:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Call request_mem_region() on the entire coreboot table to make sure
> > other devices don't attempt to map the coreboot table in their drivers.
> > If drivers need that support, it would be better to provide bus APIs
> > they can use to do that through the mapping created in this file.
> >
> =

> Does this prevent userspace from mapping this region via /dev/mem? If
> so, let's please not do it to not break compatibility with existing
> tools.

No it doesn't break. I can still read the memory here with /dev/mem (and
cbmem). But that seems to be because of a couple reasons. First, I have
CONFIG_STRICT_DEVMEM=3Dy but CONFIG_IO_STRICT_DEVMEM=3Dn. This allows me to
map memory that isn't system ram. If CONFIG_IO_STRICT_DEVMEM=3Dy then
mapping this I/O region through /dev/mem here would be denied .
Furthermore, I see that my system RAM excludes this coreboot table so it
doesn't fall into the bucket that CONFIG_STRICT_DEVMEM would find.

> (I guess an alternative would be to rewrite 'cbmem' to use
> /sys/bus/coreboot/devices if available to get its coreboot table
> information. But we'd still need to maintain the old path for
> backwards compatibility anyway, so that would really just make it more
> complicated.)

This sounds like a good idea. Userspace reaching into /dev/mem is not
good from a kernel hardening perspective. That's why those strict devmem
configs exist. Can cbmem be updated to query information from device
drivers instead, so that we can enable CONFIG_IO_STRICT_DEVMEM as well?

