Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7138A208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="U4I1qhbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7138A208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeIYX5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:57:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33016 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIYX5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:57:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id g26-v6so6952045edp.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dW6Z3tPoCmRuns3nBOd/KOLpwzZGNOM2TtEOQHse3bU=;
        b=U4I1qhbiSvtgDPWBNJ9PBjj2LDqdntomnuk+txI3m9qG2iK7SX1eOGGM9Sy0Q4rHKd
         ujoN09/jDEooXjY5P0t3Id3vUca7Llt/3KeCOZOU7ftVN4+MmUJexRprCs1cnd1DFNR3
         PUHRqVEP8F2vMzXhr7yRvF8fb76t7VODYGgjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dW6Z3tPoCmRuns3nBOd/KOLpwzZGNOM2TtEOQHse3bU=;
        b=rFAqJSjNoqpDupFkSGJ9Bz2Z4W5YEPW5WVpGpr/l+rVQgsluDJP0eaAJIxjQMvbjti
         rpsd1x2hG5DnwZlU0PvM84+Uc7GXVwa42x53MnNjWHy+U+i4Eb8j8CihkKrCFucfNe5A
         eiFDhEACB88mnkcGAhZl/SLsQGTUhAJDw1Zv3AOGnFmr0XM+veeUlO+N5wI5BVVVkVx1
         Qb9hAsctZ1kuxNFlq0bde00dGA/TzDSAjGbcBc8+xcKPuUr0e3KcOjCL1xOoxkqFPbDO
         Z+5WDOgd9qLzv+MKu7ex4S/FQS5mEz1j+RrcS8Jw7NoWoCLV3jeilWceogZaWB6f2EVY
         EPXQ==
X-Gm-Message-State: ABuFfoi3oFBaPN51yBZTIWW4br7pUaHXHIuaeESxQRg4MGmo6KAJ0wJr
        eI4Vir7h5JhIrFeE8cij5DarpQ==
X-Google-Smtp-Source: ACcGV63P4f5F99lixtcxVD+4jet7Ess+0eFkKLDWcL8uJIwmM42jlRVAEhCq0aLPV4fWMW8cjHo1dg==
X-Received: by 2002:a50:b045:: with SMTP id i63-v6mr3454270edd.18.1537897754596;
        Tue, 25 Sep 2018 10:49:14 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id m35-v6sm6852725ede.14.2018.09.25.10.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 10:49:13 -0700 (PDT)
Date:   Tue, 25 Sep 2018 19:49:06 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] riscv/bitops: Remove
 smp_mb__{before,after}_clear_bit()
Message-ID: <20180925174906.GA4372@andrea>
References: <20180925121225.9917-2-andrea.parri@amarulasolutions.com>
 <mhng-2c59d90d-9cf9-4462-bfb6-5c90ffa0c6d0@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-2c59d90d-9cf9-4462-bfb6-5c90ffa0c6d0@palmer-si-x1c4>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:19:24AM -0700, Palmer Dabbelt wrote:
> On Tue, 25 Sep 2018 05:12:24 PDT (-0700), andrea.parri@amarulasolutions.com wrote:
> > The barriers are unused; remove their definition.
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: <linux-riscv@lists.infradead.org>
> > ---
> >  arch/riscv/include/asm/bitops.h | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> > index f30daf26f08f4..01db98dfd0435 100644
> > --- a/arch/riscv/include/asm/bitops.h
> > +++ b/arch/riscv/include/asm/bitops.h
> > @@ -23,11 +23,6 @@
> >  #include <asm/barrier.h>
> >  #include <asm/bitsperlong.h>
> > 
> > -#ifndef smp_mb__before_clear_bit
> > -#define smp_mb__before_clear_bit()  smp_mb()
> > -#define smp_mb__after_clear_bit()   smp_mb()
> > -#endif /* smp_mb__before_clear_bit */
> > -
> >  #include <asm-generic/bitops/__ffs.h>
> >  #include <asm-generic/bitops/ffz.h>
> >  #include <asm-generic/bitops/fls.h>
> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thank you.


> 
> Do you want me to take this via the RISC-V tree?  I only ended up with patch
> 1/2 in my inbox, and I probably shouldn't take both.

I expected this to go via the RISC-V tree and 2/2 via the H8/300 tree,
but really no preference from me as long as they get upstreamed. ;-)

Thanks,
  Andrea


> 
> Thanks!
