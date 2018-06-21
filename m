Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6379C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F47B214D5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPe9wNOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F47B214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933437AbeFUQGd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:06:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37520 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:06:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6-v6so3782954wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krnGUbTSKXu864nvwIVEF2Iymwh+i/DyinwiEftxfjc=;
        b=ZPe9wNOkrCS8XYhqs2lJ2GD7yKtp7W6YcMHuPXGD6HalOiaFiiYrY6IH7orCSDedNE
         mURXfAz/F7c36Z/hL7NxS2zyA63Ro7s9suCC7ASFjkpJoKm+9AJ63VJnl04bLmZcO0eh
         sbyHuysa2U5jB7uHcvklB7a7bYgBzlBilQ81pZGJqah4oPsTLFpzds1OUSd7u7lLHoBe
         7T3+x0WbE3dzgREUBHnB6WwOoQa9n9K/dnEtF9rIkpMRs+8wx+9BwcaInwCHQ8Vj72ts
         rQ+xkgHH1ROUsaB16fAMQjEZO4no+/x03w90Cw+lhuiwlPbZALNv58gz0MNcWmjWUvrT
         VfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=krnGUbTSKXu864nvwIVEF2Iymwh+i/DyinwiEftxfjc=;
        b=CBtOi8c8jyC07ZzyFlbxV1+qN81C7HXmyCudpy4puwRLY+iSluNwgSJE8ezSEt5W7O
         qkat5+FN6zbM4ymNzJ6XLwYxyvEGANDXVonHLifXObBW9X57PiCKpZ3/hmnPeUfDHyeL
         4CA39+h6vMirQ5AiYIpEQyXwgffF2oX/20r3IG63Pj2LJy/oOEOQcqxxnhNvoD/WpKO8
         kesa701I9uaA+z2bI3rQKj8nEHX4y1c2bgq5rKkrhHadM894Wrsk7eRgXtphBhiQ1EMQ
         3amvF7aS1PU3otaS1BKpHTt+ruvvHVLoArMNKbk9AiO5ouy5wooeZYKr+3FNiDbrY0GA
         tszA==
X-Gm-Message-State: APt69E0ld+LrXiGqxHhMNCjtaIB3DPtjDR4jVZ7MI1G1eJ8VBSroiITG
        qzO1Ah3p1ju6BUXRxFLxJg8=
X-Google-Smtp-Source: ADUXVKKl/twf22OO5YAVBF/FRWlkI2eaOAeXrpwZ7ajocAElDuGPkqrNn32XrmV+HXULYgkQLX4iUA==
X-Received: by 2002:adf:d4c5:: with SMTP id w5-v6mr21498665wrk.185.1529597191055;
        Thu, 21 Jun 2018 09:06:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b16-v6sm8504998wrm.15.2018.06.21.09.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 09:06:30 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:06:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Exclude 'top_pgtable' from
 relocation
Message-ID: <20180621160628.GA7222@gmail.com>
References: <20180502160816.35986-1-kirill.shutemov@linux.intel.com>
 <alpine.LSU.2.11.1805022001080.3096@eggly.anvils>
 <20180503083849.j42uzp6jjpauk475@kshutemo-mobl1>
 <20180503105205.qmosbbbbp5jssehj@black.fi.intel.com>
 <alpine.LSU.2.11.1805031017420.1259@eggly.anvils>
 <20180621151805.GA27636@gmail.com>
 <20180621152725.oewogsv2alkicy6s@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621152725.oewogsv2alkicy6s@black.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> > Kirill: mind (re-)sending a series of any resulting patches that you have pending?
> 
> The root cause of the bug was fixed in v4.17 by
> 
>   5c9b0b1c4988 ("x86/boot/compressed/64: Set up GOT for paging_prepare() and cleanup_trampoline()").

Ok, cool!

> The only pending patch I have at the moment is
> 
> http://lkml.kernel.org/r/20180612103657.18041-1-kirill.shutemov@linux.intel.com
> 
> Do you want me to resend it again?

No need, I think Thomas is handling that one.

Thanks,

	Ingo
