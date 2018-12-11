Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88149C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5607E20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5607E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeLKOTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:19:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45885 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeLKOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:19:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so16470757qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61TCe1fK6sylidA87eq9i8nHVHyclUkO4Sk83IWCg78=;
        b=CD5zd2S1YS8OH+jWKouiyLaXQ5oKG+w/Yjkj2W37HB4gqgIB0q7WJOqK9fZIGxF1W0
         gQB/5oDD9vuXnN42uSR3LpRRwEbjA42EHH66zO5QzJNCUS/cB9u0EoKaEud6FyXkbMlq
         ISG/djSDd5idZQh6nfnRjcKiXb4XX7/vqw4Aj+w1gRjXRtGvOWae3WiJUKvQSCNXShwy
         grD9kwx7Ci811pi0CVgHb0UE6fh+bhamY0UTWtZEvFKPAeYRsep9YddQ8MUyDJdnS0F5
         OYRw/bhzGkFy7Zmlf+O/BjwOMLuphCcS00DCEatw7yatvthN8Q6KcHWsfOUgjSsvorMz
         GhcA==
X-Gm-Message-State: AA+aEWYMV59Dc9sKARTmjA++Jvz7SbOD3Dse8Uk0TYQqfi9Q32XmyklX
        20uE0hR19oP2xfNKpp5jwEm5R+eLrByIFgLlgXQ=
X-Google-Smtp-Source: AFSGD/Xpz9/k7qrun1tRMkSVNVXR/7unQ2BB0XXxnlq1ayBR5m70DpFsHf9Yl2STJ6f8VfmLLh3JWWrWwB/km0/bjI4=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr15296962qvk.40.1544537940648;
 Tue, 11 Dec 2018 06:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20181210211231.4084251-1-arnd@arndb.de> <20181211100728.GC3116@kadam>
 <64c0fef108dc3bdb137c84714644d770f2008ac5.camel@suse.de>
In-Reply-To: <64c0fef108dc3bdb137c84714644d770f2008ac5.camel@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 15:18:42 +0100
Message-ID: <CAK8P3a2ztF4miKwco1DTR3T=DxncV5sBOoLgrqPCVF2Nn-KFWw@mail.gmail.com>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
To:     nsaenzjulienne@suse.de
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        gregkh <gregkh@linuxfoundation.org>, tn@fastmail.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:31 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2018-12-11 at 13:07 +0300, Dan Carpenter wrote:
> > On Mon, Dec 10, 2018 at 10:11:58PM +0100, Arnd Bergmann wrote:
> > > Note that I'm changing it back to 'killable' after the previous
> > > patch
> > > changed 'killable' to 'interruptible', apparently based on a
> > > misunderstanding
> > > of the subtle down_interruptible() macro override in
> > > vchiq_killable.h.
> >
> > Oh wow...  The non standard down_interruptible() macro is ugly.
> >
>
> Same reaction here, *_*. I wasn't even aware of it.
>
> Arnd, as long as it you're not doing it already. I'll prepare some
> extra fixes for the rest of completions and get rid of that file
> altogether.

Ok, please do that, and add me to Cc. I think there is one
counting semaphore left (g_free_fragments_sema), which could
just use the plain down_killable() before you remove the wrapper.

I actually have another (longer) patch series that is not entirely
ready to convert all counting semaphores into a new
'struct counting_semaphore' to split them away from the
semaphores that can be converted into mutexes, completions
or other replacements.

       Arnd
