Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B11ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061B420868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="btp8bTK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061B420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJ0EUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:20:35 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40977 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeJ0EUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:20:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id c126-v6so923115ywd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ng9i93fUhpkuixCmGenFW8bBzXhLYzEnmrhj4FKr//k=;
        b=btp8bTK6A9mJx7cXhZFUuBNkEW3+sSDUtS4csU7ziyTzHXeZ73LnuiFvMY3JJST3fi
         gYWLcC8XKjCNwS0NDnOLhkrIZVKMvlhGA/jirRS2wFkMPKY2mDxh7w348fnd/SgmPHYd
         g7bG0NLUV7Do5vm9mapRoRLgtqYY6dm4Qc1jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ng9i93fUhpkuixCmGenFW8bBzXhLYzEnmrhj4FKr//k=;
        b=Z8o/FN2ePmiPH9YGR5RPcn5w3SWPHEUrsY4EDhadrPtyjQ0MMV0EOdmVYwlbUFcZgM
         RvJfSyGV1iJZIyJBC6T3QSjbCi9luBW1ex1vnuORAcS7v63yskoJ9PQnpvJ/nXi87sZG
         YBIrom7PXWFZGfNto7Nso7UlS5CYjK/QFWgfowoUK4EnzG2i97EI4b+pInq/UL+Vdauy
         9DwcXlIDyI5V5YXdkfiDVIUGSMMim3b7qNJOWxPFyVB+7XTEuDsgIJn4KEMUDytdrH9/
         bgOE5b9M3I2iWT8kYwprwXLzAACrQxt+GpRcpY8LPHpXgSxtf2CR5VOHBLea+9iE0SH5
         21VA==
X-Gm-Message-State: AGRZ1gLrwdWC1jKDAkll8BYYhE8VozJR48utpLtTGItcrH/iu5Noz4ch
        kc/HV8bPT4XdETNUjYnbVU4KdKQn674Grw==
X-Google-Smtp-Source: AJdET5eyOiYDk1UIex4GDHAg+xosB0OgyOWY7eSLtbGbUN1opJpWJ/BJB875rbMGefyZkOn+hC+E3A==
X-Received: by 2002:a81:1153:: with SMTP id 80-v6mr5033780ywr.302.1540582935666;
        Fri, 26 Oct 2018 12:42:15 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id h68-v6sm2660808ywd.88.2018.10.26.12.42.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:42:14 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id f15-v6so454618ybq.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:42:14 -0700 (PDT)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr5163239ybi.141.1540582933453;
 Fri, 26 Oct 2018 12:42:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 12:42:12
 -0700 (PDT)
In-Reply-To: <20181026182218.GB187415@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <20181026180042.52199-6-joel@joelfernandes.org> <CAGXu5jLoMhBKuxhSqbgitfOYkO0gU34L4asn9iQEdHqJPxfDSA@mail.gmail.com>
 <20181026182218.GB187415@joelaf.mtv.corp.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 20:42:12 +0100
X-Gmail-Original-Message-ID: <CAGXu5j+w+3VPMPHWNQi8UbTCRgbP1YSpjP2xct8hJEdyXdKYRw@mail.gmail.com>
Message-ID: <CAGXu5j+w+3VPMPHWNQi8UbTCRgbP1YSpjP2xct8hJEdyXdKYRw@mail.gmail.com>
Subject: Re: [RFC 6/6] Revert "pstore/ram_core: Do not reset restored zone's
 position and size"
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 7:22 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 26, 2018 at 07:16:28PM +0100, Kees Cook wrote:
>> On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
>> <joel@joelfernandes.org> wrote:
>> > This reverts commit 25b63da64708212985c06c7f8b089d356efdd9cf.
>> >
>> > Due to the commit which is being reverted here, it is not possible to
>> > know if pstore's messages were from a previous boot, or from very old
>> > boots. This creates an awkard situation where its unclear if crash or
>> > other logs are from the previous boot or from very old boots. Also
>> > typically we dump the pstore buffers after one reboot and are interested
>> > in only the previous boot's crash so let us reset the buffer after we
>> > save them.
>> >
>> > Lastly, if we don't zap them, then I think it is possible that part of
>> > the buffer will be from this boot and the other parts will be from
>> > previous boots. So this revert fixes all of this by calling
>> > persistent_ram_zap always.
>>
>> I like the other patches (comments coming), but not this one: it's
>> very intentional to keep all crashes around until they're explicitly
>> unlinked from the pstore filesystem from userspace. Especially true
>> for catching chains of kernel crashes, or a failed log collection,
>> etc. Surviving multiple reboots is the expected behavior on Chrome OS
>> too.
>
> Oh, ok. Hence the RFC tag ;-) We can drop this one then. I forgot that
> unlinking was another way to clear the logs.

In another thread I discovered that the "single prz" ones actually
_are_ zapped at boot. I didn't realize, but it explains why pmsg would
vanish on me sometimes. ;) I always thought I was just doing something
wrong with it. (And I wonder if it's actually a bug that pmsg is
zapped -- console doesn't matter: it's overwritten every boot by
design.)

-- 
Kees Cook
