Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B168C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOsl4Exq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B168C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030352AbeFSTT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:19:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36701 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966263AbeFSTT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:19:26 -0400
Received: by mail-lf0-f67.google.com with SMTP id n24-v6so1212003lfh.3;
        Tue, 19 Jun 2018 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=Pd6a1z4ipWg0P576zimc6CBisKhAy0qZBmPYF9sjMSw=;
        b=tOsl4ExqhU6PP2sm0nJQkbh0sz9joyvl1XB8OsZV6+a3XEWkXmNg2AZXHn6g1/7hmO
         +2tnf8WU9wRpJxxGMhL+/SfPDySxNzUUcmY7m1cxfWzsp9OL8clDwMWO8DvtOBdZzGhf
         uLaI1TNwuyvEWoDnOto6hXLTD/7A9zUeXfG4wxwHT2fO3bSl9AD0Du7uL/qU39bnAfKR
         OH36L4uZH5QRmGsIAsPttmGkEWAbGaGYgnz2/3tL9i+/7JDpwq/43ash6bHQk5MREYeX
         2yEJRVj/wAYYe23kJjRYdsXtUsfx6VZh12YA72YQIgQ8sQJh6h0o0A+wqEpewOO2NRLe
         Kmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=Pd6a1z4ipWg0P576zimc6CBisKhAy0qZBmPYF9sjMSw=;
        b=bSDIJh8Xgr63s7bOnDtXRrIBbiHrs8r+8kXGbijh9w7Npnm1h9sToGeEdz32o0iB2S
         1OoXP6YV4bxl9IaHGILIwcjh6tB9LIly1DJ+Jbr5PF/WQcIbt+GJFeAM8J1ZWrLiQtih
         ec5Dp/KXXGhhz/9yyxHlSAQy4/xVHmW3Xc1owN8atvBgx1xjLqTEaYDP0Wm9d8U+20r8
         9NieBK8vnZXejtl52vXPXdoIZca8aNPtdaRMMEzLTEt58TW6NYO3pbYxOYfl1d5afPfr
         rwmqKoHOZGSUVChCGAOQtyohWa3RBQYzz8ifLgloPj5e02VSs9Reym9SQ/xizJgAqvSP
         EIBg==
X-Gm-Message-State: APt69E0ogZ46BEstFT/dZBFgzPRXQAyi7XvIdqdBgIaUjH0XAeJRsQET
        IgWhL/GjIRmwCC/rtMb4IuFLPXFlXQwYes6jozs=
X-Google-Smtp-Source: ADUXVKJUWB2iRAaRThrp0SXSUdnjviiwDKPlwlPKud0gmq+yMLf1qQI/R1tnZvUoDGQbb0DLhqZDvX3YxdWYKCMQFPA=
X-Received: by 2002:a2e:401b:: with SMTP id n27-v6mr12502574lja.6.1529435964603;
 Tue, 19 Jun 2018 12:19:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 12:19:23
 -0700 (PDT)
In-Reply-To: <CAK8P3a1L5srfOR1vXQX5PM5FTXN4ZM+qAtqDthppiX=f1osFbQ@mail.gmail.com>
References: <20180619153822.3638475-1-arnd@arndb.de> <20180619165633.acyxrweiedyhvre7@cs.cmu.edu>
 <CAK8P3a1L5srfOR1vXQX5PM5FTXN4ZM+qAtqDthppiX=f1osFbQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 21:19:23 +0200
X-Google-Sender-Auth: 5yMbSh2Lo677-M8YAIl07BAjgpg
Message-ID: <CAK8P3a1jeHCsn4JiJfbC5K+Y0znvrYZcoGTspy6gAdimfC_PXw@mail.gmail.com>
Subject: Re: [PATCH] coda: stop using 'struct timespec' in user API
To:     Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jun 19, 2018 at 6:56 PM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:

>>> An open question is what should happen to actual times past y2038,
>>> as they are now truncated to the last valid date when sent to user
>>
>> That is definitely quite a hard problem because this propagates all the
>> way back to the Coda file servers and how they store metadata.
>> In fact the existing client-server protocol only uses 32-bit time in
>> seconds, so we already lose the nanosecond resolution and 64-bit systems
>> don't actually benefit from having the extra bits in their struct timespec.

I couldn't find out enough background for this, maybe you can fill it
in: I see that there is a user space component and a server component,
but I'm not sure if there is exactly one of each, or if there are multiple
implementations that are written against the same interface.

If we only have one code base, it should be fairly straightforward to
make it deal with 'unsigned' timestamps consistently, which would
let the code work fine until 2106 rather than wrapping around from
2038 to 1902.

> > Not exposing an internal kernel datatype is definitely an improvement,
> > so this is an ACK for me.

To clarify: the problem isn't as much the internal kernel type, but the
glibc internal type that we know is going to change with future glibc
versions. This means it is important that the header file change makes
it into every user space program that uses the psdev interface.

    Arnd
