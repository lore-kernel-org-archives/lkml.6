Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D1C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F04620835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="oeKbk5rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F04620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeJLXas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:30:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35176 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeJLXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:30:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id y19-v6so11942744edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6B/W6S7lp/KkShEF8EInSfRIxF/7fDhINOjhFYSKgBk=;
        b=oeKbk5rEbO0wRuqyuDVnV1R4AJvOs6PgDFL1REshtQqYIwibBv7dBFd1DuOrr6/4jT
         4XpiTAaroqC6orqcihYNuLDMiA7v+GSgyA6rU1thzRlROKTloBpyK7uorpBDuAs+LFyS
         zkjzr0cK9WicByv4QjMzcgb+rjlcP79eoR5BhYuO6PU0FlgGVJ4KPmqhDVa5kOB5MheL
         beetSc/y1iBKYPNJrmMntEfqHdhQ81ieN0WkBYE6USLInCLn/zkYYb2VGl2Ka9H64pdb
         l/O34OOsFTFTkLyMuxp25j9/flJSIwjUbjMkOSHYGI3MyuMt5CdBkTZi24bm9n437mM6
         AFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6B/W6S7lp/KkShEF8EInSfRIxF/7fDhINOjhFYSKgBk=;
        b=O0itlg6esZ2xWiLMyU7Gbv+vtBaLC5KYKPx0rSAvX+gLxnckwfBlzBPi5S+SjgoseF
         aTxdkEEt9efRSDyi2d1LqXUG4RFqSWgyqwnCHbWarLwvPhXjzFbLCFhQopgo8sSXw7sl
         +8ODNJDTR9iF+4MwP4W0TpN++GiDfXMTr3h/K+YJ4bedDYxWjNswNmUOzGDtYHQ5x1gG
         ULmRNCYj6Vkd90ZaOSmBYR9iaL4DvLzmvJEIrtznksDCzLnML4043lEnKAxRfBhUZfCg
         5x+Dh1Fqc0Cx/S2PJaj4lmhxvh697ThhH9g8+ZIPK8s+LaRREy+XPBM9iUMIx/c1Gq4K
         OKeQ==
X-Gm-Message-State: ABuFfogu7WTPrQTpDJnRqJ3sagob6jcauwcz0KDQKEl89DrNwt3w1kT4
        wGzii3F3KReYJyDgGlNmtK2X6f/rlZM=
X-Google-Smtp-Source: ACcGV60hiRKjMssgCgZq5fJKZ+QtKhfPfD4locb5qLCaLd+rdjEvs6Pcqtu0XyVJ0cW8aAZfYf6gTg==
X-Received: by 2002:a50:90d8:: with SMTP id d24-v6mr10137182eda.228.1539359859027;
        Fri, 12 Oct 2018 08:57:39 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y8-v6sm1041337edd.43.2018.10.12.08.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:57:38 -0700 (PDT)
Message-ID: <1539359857.2706.23.camel@arista.com>
Subject: Re: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
From:   Dmitry Safonov <dima@arista.com>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 12 Oct 2018 16:57:37 +0100
In-Reply-To: <CAHD1Q_xv4PSsJ3AcKd5i+QZ8On9jqPZsa+p46bCiKubhzVJerQ@mail.gmail.com>
References: <8c61fd04-969a-cb09-6595-7ee23d214ab1@canonical.com>
         <99f1353a-e1a0-5ade-4aad-3eb62ea42a66@canonical.com>
         <1538515983.4348.93.camel@arista.com>
         <CAHD1Q_xv4PSsJ3AcKd5i+QZ8On9jqPZsa+p46bCiKubhzVJerQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme,

Just to let you know - I've done with more urgent issues now,
so I'll be back on this patch on Monday, installing qemu-system-hppa
and debugging the root case.

Thanks,
Dmitry

On Wed, 2018-10-03 at 07:46 -0300, Guilherme Piccoli wrote:
> On Tue, Oct 2, 2018 at 6:33 PM Dmitry Safonov <dima@arista.com>
> wrote:
> > [...]
> > Well, v5 passes 0day, so all previous reports are fixed.
> > But there is a new one about reboot on parisc platform which takes
> > ~3
> > mins after the patch with ldisc locked on tty_reopen().
> > 
> > I believe it's related to holding read side for too long..
> > So, the patches still need another fix, heh.
> > 
> > Unfortunately, I was a bit busy with other bugs hitting more in
> > Arista.
> 
> Hi Dmitry, thank you! Yeah, I saw that reading the whole thread after
> sending this email heheh
> That's a bummer =/
> 
> Unfortunately, I don't have a reproducer to exercise your patch. Do
> you
> have some recipe on how to reproduce it easily?
> I'll try more, in order I can validate the reboot behavior here.
> 
> 
> > > > I'd like to ask you if you did respin the patch with Greg's
> > > > suggestion
> > > > for the tag - I couldn't find it in LKML heheh
> > > > 
> > > > Oh, if you can CC me in future spins of this patch (in case
> > > > there
> > > > any),
> > > > I'd really be glad.
> > 
> > Sure, will enlarge Cc list ;)
> > 
> 
> Thanks again!
> Cheers,
> 
> 
> Guilherme
