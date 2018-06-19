Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB747C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8577D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCer9yoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8577D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030433AbeFSTNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:13:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40539 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966747AbeFSTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:13:34 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so1158806lfc.7;
        Tue, 19 Jun 2018 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=zCtK+JkSG+cTIrkFrHIL64C4uwCKUPQIef8Rjl5eJS0=;
        b=DCer9yoC1RdVL27OroGInPlo+kjaF0/JcVJZA02CeO7XKkcLlaxWl3tN2dPyyRTPGi
         8GFLiEiE3ZRjAv+Gwvd6hVegmV0/6tw+GxTaPZLOQ/xtgdTMCBnNaQavI1RgEYuBeQP/
         FmeIB2xwvv7eDxMf1C73CP6aWCyPqPcxcpq0gtf+vBjZWLd0PGPebxqdqa3HpdAUnqKu
         hJqGnon2SVACWQfV2hY/dJmgHpkOnsHrBL/kl0OMctC+NrPQQGpUnGu8q+6xRrGnBnwO
         YqDEVhGGJRxJTXWn896pClZLzPXB+ISNRXJWaIGoPodqv0memJr1M7WsMEwwjI/7+nBC
         UmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=zCtK+JkSG+cTIrkFrHIL64C4uwCKUPQIef8Rjl5eJS0=;
        b=fjhc/NeKsT5UxBs2hsJIf9vU9mI4DD1LsmDpx3U+LhlFZkqE6irwl9B8sNDOmy2Eb4
         gehTkdaeq1fRh0KWV9Im5g4+Lz90rAco1sVoAmnaEujsVphIVeYltEG4FaEjbs9LlnCZ
         fk1Yb1sLSs88t911UzAJ0+WaL5gqn2wWduLa6vWqrddxBLUUdL+kgfRTSJcwyZ2ViY2D
         BL8AlXZoLYuRKo1q148ScY4AJoSjoauXvHkFSInnJw7mnBEDmZXYPUxN3HYmPUThjrNb
         bHAPSdkpgwnz6Xa/amZHVOz0AqF2MwcqlDwEh4YTpiFONChH2H/Tr7BityDpVgowFVmu
         zPTw==
X-Gm-Message-State: APt69E05I5sXHBWDn7MYgRG9Y/Whc4cwJYdERW7j7y9olU6mmdYHcCis
        7ezRN4Jvfp0m80gl5hDKdk1vkHvtYcglq4hc7Ew=
X-Google-Smtp-Source: ADUXVKIvXVKmVD7zfdSf2DFuMxwwtO0zfirKecjjpMfBL2eDk3I7m4/uqcc7KCOaMLubN9D7XcdtiM2Q8tY/DEqSxig=
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr11849320ljg.22.1529435613047;
 Tue, 19 Jun 2018 12:13:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 12:13:32
 -0700 (PDT)
In-Reply-To: <20180619165633.acyxrweiedyhvre7@cs.cmu.edu>
References: <20180619153822.3638475-1-arnd@arndb.de> <20180619165633.acyxrweiedyhvre7@cs.cmu.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 21:13:32 +0200
X-Google-Sender-Auth: xiLRCNSXTnteL3IXXLCBKWMy-Vo
Message-ID: <CAK8P3a1L5srfOR1vXQX5PM5FTXN4ZM+qAtqDthppiX=f1osFbQ@mail.gmail.com>
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

On Tue, Jun 19, 2018 at 6:56 PM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Tue, Jun 19, 2018 at 05:37:35PM +0200, Arnd Bergmann wrote:
>> Unfortunately, this breaks the layout of the coda_vattr structure, so
>> we need to redefine that in terms of something that does not change.
>> I'm introducing a new 'struct vtimespec' structure here that keeps
>> the existing layout, and the same change has to be done in the coda
>> user space copy of linux/coda.h before anyone can use that on a 32-bit
>> architecture with 64-bit time_t.
>
> This looks good to me.
>
>> An open question is what should happen to actual times past y2038,
>> as they are now truncated to the last valid date when sent to user
>
> That is definitely quite a hard problem because this propagates all the
> way back to the Coda file servers and how they store metadata.
> In fact the existing client-server protocol only uses 32-bit time in
> seconds, so we already lose the nanosecond resolution and 64-bit systems
> don't actually benefit from having the extra bits in their struct timespec.
>
> Not exposing an internal kernel datatype is definitely an improvement,
> so this is an ACK for me.

Thanks,
