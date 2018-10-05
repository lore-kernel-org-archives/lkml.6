Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1684C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5A82098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5A82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeJEOj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:39:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47020 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeJEOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:39:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id o21so11523580otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97/kGLrdnBlyFhgI04CyxK7uBCCHJshpKqXLUVCfu1w=;
        b=Tkzm6+kIO1uAFSClqsGPhn26aG76PvHT/vCl/6bB7N2AI+cmyyg4Cv9pG0n+EbOuvq
         mVSmyehQlPrHXYIcOvFtOe9TauvnYoXpLaWtPL87M3goWmV3GJDomVJkN/F8RstcHTOy
         R8z3GZM7LrOfiFjr5JgmCZaOvInZEbqDaJR+kzEhBt4+zI0L2Fjq7GbWGOtI1klm3dsP
         OoRW2t8mq/PWomRIOvh8nmChX0TC3vQzsOpYwOQuvFAHgUB0bXLSPa8lOdGNitgCG7z0
         D0Op2wVFoMpMfTYseReg9Exz3zvZZZHOwcilVdOIRyh2V9DBzYxUdyAycamvAZklk9Py
         U8Lg==
X-Gm-Message-State: ABuFfoicgxPsm/CUaKZpK0Y8M0X2OPCaSvSyJo9fISeDpL+Qa2Hi6FuG
        UcZYd8evaIbbNmb0xPqMJkf2SnWEIVSeremeQHAu1A==
X-Google-Smtp-Source: ACcGV62jaghBzJVsrDIeRoAP/yPZOcy4/Ih7OzVftCdUCdi1k4aXDKkt1mkdP+a4MQLBkykcIiNhyJZRe2tEvWjKO5s=
X-Received: by 2002:a9d:2af:: with SMTP id 44-v6mr5459517otl.244.1538725317664;
 Fri, 05 Oct 2018 00:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181004143750.30880-1-jani.nikula@intel.com> <CAJZ5v0iOR=PLHWtuJDVSsjpeTp_BLsheRM_dR_AL00hN-6bUhQ@mail.gmail.com>
 <87lg7cq1z6.fsf@intel.com>
In-Reply-To: <87lg7cq1z6.fsf@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Oct 2018 09:41:46 +0200
Message-ID: <CAJZ5v0j_UEWxN5GzeL-1Ju6sw0pYmepWAu6xN5vANTkq3NgtXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sysfs: constify sysfs create/remove files harder
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 9:36 AM Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Fri, 05 Oct 2018, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > On Thu, Oct 4, 2018 at 4:38 PM Jani Nikula <jani.nikula@intel.com> wrote:
> >>
> >> Let the passed in array be const (and thus placed in rodata) instead of
> >> a mutable array of const pointers.
> >
> > I'm not sure if the changes guarantee what you want.  If I'm not
> > mistaken, they just mean that the function itself cannot modify either
> > the pointer passed to it, or the contents of the array pointed to by
> > that pointer.  They don't imply the location of the array itself,
> > though.
>
> I mean, this change allows the caller to add the appropriate const
> qualifiers to the array definition, allowing the placement in
> rodata. Can't do that withouth the extra const in the function.

I figured that out, but the changelog is a bit unclear.  If you said
"Allow ..." instead of "Let ...", it would be somewhat clearer IMO.
:-)
