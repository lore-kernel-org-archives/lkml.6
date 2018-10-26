Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F698ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5D820824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cl2dRMtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5D820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeJ0EsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:48:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45590 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJ0EsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:48:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id v6-v6so754246pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mCf0LNVayN601XqDnApH7l/ZthIM8O7U7fSOJAuzawI=;
        b=cl2dRMtcCpaB0VaUt4cj5nZ0mu1GyrC0+/GvxNd+V7F4L1EHZ06UXfDlZonZTTNZEs
         bq78hYx39kyvJl0FpNHguw9TbqqFC659ayAwBqe0CM9u0W67f8xI350mXttHvIQ21O89
         mgsEEOKODyHrDhCJgHiFi8jKWmjYV39hmItkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCf0LNVayN601XqDnApH7l/ZthIM8O7U7fSOJAuzawI=;
        b=Leuax4Hk/f1WSUTx2n9Xc3q2VqNQAPMqAFHRuPk7dNV+BaXV4vFwzocChVOuym2dT8
         mmoOclbWMMBi4RMiLEVy2e5fdebtSyOqEz7eDKjwslXFf7rIBWjcOno5ESAD76fKg+gO
         sfmmJiiLu+GcGrs2uPGCg3PKhdGZntvm41RB0fXBKlRXBfqQWQf7tjH2YSqygcxbySDO
         IHxi+EbmbyGb5vd4BULKljnWzBUY3C3RbKnpRThaWGpASb46c/cke1PIC8s6/xhQHUrE
         IL6f9WqrUyAgKkkd/iNvRA9aVoEDkW1CqWx94du87pG5lCwZx8MZAQtJw+hUHkfITfug
         sqaQ==
X-Gm-Message-State: AGRZ1gJgcvJQMeemEUJluWHJhjmIS2e0cCbG1l6skaSIp5PTX7HdH8oM
        7MLfPRuYr3TeUg4dztlIdkOEHQ==
X-Google-Smtp-Source: AJdET5fUZl4bwCrD0DDTOP7KnLFPuzInjJVzDQasYrgAybB9vayxPTNq05U0EFGDHgrnJzVW0g2gFw==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr4605613pgb.357.1540584582842;
        Fri, 26 Oct 2018 13:09:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id o29-v6sm5592138pgl.68.2018.10.26.13.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 13:09:41 -0700 (PDT)
Date:   Fri, 26 Oct 2018 13:09:40 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC 6/6] Revert "pstore/ram_core: Do not reset restored zone's
 position and size"
Message-ID: <20181026200940.GA129228@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <20181026180042.52199-6-joel@joelfernandes.org>
 <CAGXu5jLoMhBKuxhSqbgitfOYkO0gU34L4asn9iQEdHqJPxfDSA@mail.gmail.com>
 <20181026182218.GB187415@joelaf.mtv.corp.google.com>
 <CAGXu5j+w+3VPMPHWNQi8UbTCRgbP1YSpjP2xct8hJEdyXdKYRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+w+3VPMPHWNQi8UbTCRgbP1YSpjP2xct8hJEdyXdKYRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:42:12PM +0100, Kees Cook wrote:
> On Fri, Oct 26, 2018 at 7:22 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Fri, Oct 26, 2018 at 07:16:28PM +0100, Kees Cook wrote:
> >> On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
> >> <joel@joelfernandes.org> wrote:
> >> > This reverts commit 25b63da64708212985c06c7f8b089d356efdd9cf.
> >> >
> >> > Due to the commit which is being reverted here, it is not possible to
> >> > know if pstore's messages were from a previous boot, or from very old
> >> > boots. This creates an awkard situation where its unclear if crash or
> >> > other logs are from the previous boot or from very old boots. Also
> >> > typically we dump the pstore buffers after one reboot and are interested
> >> > in only the previous boot's crash so let us reset the buffer after we
> >> > save them.
> >> >
> >> > Lastly, if we don't zap them, then I think it is possible that part of
> >> > the buffer will be from this boot and the other parts will be from
> >> > previous boots. So this revert fixes all of this by calling
> >> > persistent_ram_zap always.
> >>
> >> I like the other patches (comments coming), but not this one: it's
> >> very intentional to keep all crashes around until they're explicitly
> >> unlinked from the pstore filesystem from userspace. Especially true
> >> for catching chains of kernel crashes, or a failed log collection,
> >> etc. Surviving multiple reboots is the expected behavior on Chrome OS
> >> too.
> >
> > Oh, ok. Hence the RFC tag ;-) We can drop this one then. I forgot that
> > unlinking was another way to clear the logs.
> 
> In another thread I discovered that the "single prz" ones actually
> _are_ zapped at boot. I didn't realize, but it explains why pmsg would
> vanish on me sometimes. ;) I always thought I was just doing something
> wrong with it. (And I wonder if it's actually a bug that pmsg is
> zapped -- console doesn't matter: it's overwritten every boot by
> design.)

Oh yeah they are. So seems like some are zapped on boot and some aren't then.
Hmm, I would think it makes sense not to boot-zap dmesg ever, since that's
crash logs someone may want to see after many reboots. But console and pmsg
should be since those just "what happened on the last boot". I guess it
should be made clear in some structure or something which types are zapped on
boot, and which ones aren't. That'll make it clear when adding a new type
about that behavior, instead of relying on the assumption that single prz are
zapped and multiple ones aren't. Like for ftrace, since the per-cpu
configuration was added, it will now be zapped on boot if it is using a
per-cpu configuration and not zapped on boot if it isn't right?  That would
seem a bit inconsistent.

thanks!
-Joel


