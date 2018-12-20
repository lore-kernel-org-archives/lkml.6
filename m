Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDCCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B8E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FasCUNV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbeLTS2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:28:54 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34550 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389045AbeLTS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:28:54 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so1705370vsi.1;
        Thu, 20 Dec 2018 10:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mftgWIqwkA74Fb2eAeGMl9cRoZ47cfNRVpnzIE2W/Jo=;
        b=FasCUNV2moymoleoBh+7LFxCpNC0170iHFrO4mG+vAwI7aIMUOqvsvlLIRTU6DrMGw
         I80do9WSKwmsGtwJTu2QOM/NTNpCbrUycbE8/Hf7kaYbnVj7ldXc9cdHtKQIMfidj/W6
         vDNq0UbLWLbVCj9HAHDJAnQX7TGB1LKiHtlzSe8BM9eOVX0EoRxeCtYEH/6FUQ+O42sY
         g4BUkIxFoWuzHlxyT2zVYJSZGzoKWkJsZ994ZeXFO0x0gPhmCjTtxvZuzc9zKOISs2YY
         ux57clVFghImPdPEaIyFwCDb3lnxRJ4427glY2MqCb+QnIDNTG0zqCSC+4aHKcf9oiHg
         Mjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mftgWIqwkA74Fb2eAeGMl9cRoZ47cfNRVpnzIE2W/Jo=;
        b=YxrHcA5senmHk+gHle4L1r2GC0eg9vCkXMTVkx63hKK2GWtm/lHa2ZlYmDOrZhVK4V
         afmto6FAjl6tc0Igz4itQTsPt5CjBHPWwGOPLR2tDooA18lY2krNQNLHR3ksjCi7sCMe
         yKQWu9oxz4rB05bgkfqZ9/ZCtuIPq3Ya1d5iQpmsbufQ4sOqFluRG0+ZDNasT1RE9TBc
         21nYD7bChZEqgoYrPUlIb1zSzWYm9pgeyTQm9CiTzv6c951JIkHRDo4+H/UEaSkdc980
         y2NcAbSKXmknXVnND9kKjOnXZEZPcsSl7WnoEvnev75bN46FCCqYqMOd28IPEn59jNLN
         w7SA==
X-Gm-Message-State: AA+aEWbSj16z/c2i5fNLITzppgwkmx83nCb9oXcG/UzGqvrmsdnh8J56
        HfvwqQ8bY/oowzdQnuk8UhJ4kRZGdOyYpdn0rM4=
X-Google-Smtp-Source: AFSGD/UxrqgJw57yTM9Yug9Rv0ez4L4E5wq4sxj1jZgr3hNLmP0jQthXjapNgSfRhQgccktDgkDXbARSvF8h62AsfsI=
X-Received: by 2002:a67:e242:: with SMTP id w2mr6146882vse.134.1545330532690;
 Thu, 20 Dec 2018 10:28:52 -0800 (PST)
MIME-Version: 1.0
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
In-Reply-To: <1545238252-79630-1-git-send-email-darcari@redhat.com>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Thu, 20 Dec 2018 13:28:39 -0500
Message-ID: <CABo9ajAVFkasgAhpQFX4-__q0TRdWBfb1_Mdk9-RhCwO9MDO8Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
To:     David Arcari <darcari@redhat.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 1:33 PM David Arcari <darcari@redhat.com> wrote:
>
> From: Lenny Szubowicz <lszubowi@redhat.com>
>
> In __ghes_panic() clear the block status in the APEI generic
> error status block for that generic hardware error source before
> calling panic() to prevent a second panic() in the crash kernel
> for exactly the same fatal error.
>
> Otherwise ghes_probe(), running in the crash kernel, would see
> an unhandled error in the APEI generic error status block and
> panic again, thereby precluding any crash dump.
>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> Signed-off-by: David Arcari <darcari@redhat.com>

Good catch!

Tested-by: Tyler Baicar <baicar.tyler@gmail.com>
