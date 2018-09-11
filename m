Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C6EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44820833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ghEsHE6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A44820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeIKRxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:53:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46545 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:53:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so19125884edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JH9R72BpdbC+YFzP6QfB2OWaJNzQfdimLRrJZhUgl0=;
        b=ghEsHE6oAVGUoeCrs6NcT3YFoFECdNhyv3qN53HNmZrSklq4cAO9Yo23rcaiKaZSgZ
         HpgJbEfkJ6nWX9gLOw8l567kEoUq3/JWl2WQXVBsYn+ub3EYinX8JsG6sPznzfXCG13g
         CuGJ6sh99KKoLEWd9v2viyaImc5dIGIM6j3b6LPe69f3CDR0BGWdpG3DX58rxnqc4wU7
         CYntKBLYJPY3bVXdCyciDhVLd8JaXz852CursQxxI5u/q3TsrhaMzE6DYV/lbKj84udx
         6GAN6qWy5PAmewEb1LVg3jIRskgcbqqMV0VGey4rZhwlmQVKP0a4qwMbX+JtkzMuqGRd
         keFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JH9R72BpdbC+YFzP6QfB2OWaJNzQfdimLRrJZhUgl0=;
        b=gyn4VX0Z94YwxnU91J6liGhR4rbh43MXhsV1K4uUSRksiMP/gJdW83xgy0h4amDK/B
         ShIIbt7mnAPmDy+fnK9L7FuBvUt5ZSbIxcySUA3qEVO5pbdweiJdCCYw4FP3Te6u4S8W
         VHvej4NgHs3SGpcCK1btEj84QZwT3q9m5U8eLDRwaAoqtzu03KDqq4eFWhN5bI+N1naV
         M5mbFYzZbPWRs/II36mltLCPNRr5vUoBSYLfwEO6hkAuUkcrI9wJv98w9+6apPL6dVNC
         ni1/ia7FtMayR1dmdJfSQUGX7d9d41ZnyRibyTam7b97DK9YC5EPrdNiw3qIDcsg0CuM
         phwA==
X-Gm-Message-State: APzg51Btg2I77cyfsOpEw7eyVFYahauUi08iEG3SCiOV05zZyvrEuhn9
        /p8ndqas6xFeG7mkWcbs5R6rVg==
X-Google-Smtp-Source: ANB0VdaPbWjeNvdtyQ8qVbA+N+PSvnPeXoQODG4s54aRXySuOQxkGPcVAoK4vcjNK6FC0vQgTQbFIw==
X-Received: by 2002:a50:8b65:: with SMTP id l92-v6mr28516377edl.44.1536670426784;
        Tue, 11 Sep 2018 05:53:46 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x32-v6sm13445908eda.81.2018.09.11.05.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:53:46 -0700 (PDT)
Message-ID: <1536670424.2710.22.camel@arista.com>
Subject: Re: [PATCHv3 4/6] tty/lockdep: Add ldisc_sem asserts
From:   Dmitry Safonov <dima@arista.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Date:   Tue, 11 Sep 2018 13:53:44 +0100
In-Reply-To: <20180911120153.GB19234@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
         <20180911014821.26286-5-dima@arista.com>
         <20180911120153.GB19234@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-11 at 14:01 +0200, Peter Zijlstra wrote:
> On Tue, Sep 11, 2018 at 02:48:19AM +0100, Dmitry Safonov wrote:
> > Make sure under CONFIG_LOCKDEP that each change to line discipline
> > is done with held write semaphor.
> 
> But you don't do that. You just assert it is held, not for writing.
> 
> > Otherwise potential reader will have a good time dereferencing
> > incomplete/uninitialized ldisc.
> > 
> > Exception here is tty_ldisc_open(), as it's called without
> > ldisc_sem
> > locked by tty_init_dev() for the tty->link.
> 
> You fail to explain how that is not broken...

I'll add the explanation to the next version.

> 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >  drivers/tty/tty_ldisc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> > index fc4c97cae01e..202cb645582f 100644
> > --- a/drivers/tty/tty_ldisc.c
> > +++ b/drivers/tty/tty_ldisc.c
> > @@ -471,6 +471,7 @@ static int tty_ldisc_open(struct tty_struct
> > *tty, struct tty_ldisc *ld)
> >  
> >  static void tty_ldisc_close(struct tty_struct *tty, struct
> > tty_ldisc *ld)
> >  {
> > +	lockdep_assert_held(&tty->ldisc_sem);
> 
> Did you want:
> 
> 	lockdep_assert_held_exclusive(&tty->ldisc_sem);
> 
> ?

Oh, yes, thanks.

> 
> >  	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
> >  	clear_bit(TTY_LDISC_OPEN, &tty->flags);
> >  	if (ld->ops->close)

-- 
Thanks,
             Dmitry
