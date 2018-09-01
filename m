Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8649DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222982077C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U8rXc9Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222982077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeIAVkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:40:33 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:37968 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeIAVkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:40:33 -0400
Received: by mail-io0-f174.google.com with SMTP id y3-v6so12890505ioc.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyhfrD3N4GyWMZGeUE19ZxMHb/p/v3MdWJ2DiB0Nn68=;
        b=U8rXc9Z604dkSmQ72uePHxutI5qBMgxtVWNy0uOIYbK7LwvRz6qExDLqnRjndZUpHB
         dvzQz8sajBAOa/N8n0IlmrOqR2sV6RSgWCtvSKSmU67wK+El7BtHULxdai6/6+avL/4C
         bG7aTlSEk+PMHLNUazFPcOWzEfl//wjA0D1c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyhfrD3N4GyWMZGeUE19ZxMHb/p/v3MdWJ2DiB0Nn68=;
        b=fR6cbdAicZT2WRa40CFgwxk5pAq+FRtU/wnlBdQtNb5MQtETwiG/Rf4q8E2p0bXTKY
         kYD+NWAgRykWBuRxt1IuPiTMuEyqSxh5KhWdaDrCa6GMyRnfmnP/x5kLfLfx46ym14dl
         kR57RfaImmVIifhzgOQxpb8R0dID3ObS/IPVIvEPHZdD4Wvy6ELrZcZK6i/7wn5l5eAY
         HN0eBG6sw2Ejzqe1CaVV1amBFM6ah6r3jYibS+7RWX95IGekKc+TLoHQlMX3WJS3GI/C
         ZfrZQcNA6RaL5QFII9O6FXuXqgLBGjqNELVIMQVv4m17hfuXte0Z2CT4fBPlHXigycQ9
         0OXA==
X-Gm-Message-State: APzg51CmEZIugmYzuwNdPcWOed0HTca2J+OgftzZrQtoE8Qbm2iPsrc6
        msI33XmCcCIUK+ZDPrIoRQ/8fyuZdSQImQO31pw=
X-Google-Smtp-Source: ANB0VdaqX7bkesv2vRNB1mJiBDJg5RPY7r0ZZaU6G0OQWPijRDrF6w15DabD5/aLvvyjfyXL48lffKfLNgHJSouZU8c=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr16293783ioh.203.1535822871023;
 Sat, 01 Sep 2018 10:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com> <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm>
In-Reply-To: <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Sep 2018 10:27:39 -0700
Message-ID: <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
Subject: Re: Access to non-RAM pages
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 2:18 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> If noone has any clever idea how to work this around (I don't), I am
> afraid we'd have to ditch the whole DCACHE_WORD_ACCESS optimization, as
> it's silently dangerous.

No way in hell will I apply such a stupid patch.

It is NOT dangerous.

If you have a machine with RAM that touches IO, you need to disable
the last page, exactly the same way we disable and marked reserved the
first page at zero.

I thought we already did that.

I suspect this is a Xen bug, where the fake BIOS sets up a garbage
description of the hardware that is simply not realistic. I don't
think I've ever seen a machine that didn't have some reserved memory
at the top, but hey, if we don't expressly mark the last page reserved
already, doing so should be trivial.

No way do we disable the word accesses just because of some crazy
corner case that doesn't matter and doesn't happen in reality.

               Linus
