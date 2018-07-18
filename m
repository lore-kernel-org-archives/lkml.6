Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8C9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882182075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bA6TluEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882182075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeGRDaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:30:02 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43314 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbeGRDaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:30:02 -0400
Received: by mail-qk0-f194.google.com with SMTP id z74-v6so1661970qkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 19:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JUE43aCGdIvBQ3zJiGYOJqLCeUH9k/YrYqqRjecWfSQ=;
        b=bA6TluEr/cBsKQJg7YwhKngt98XnMDB0ed2pPyUGzDJm4Tpzwuoq3WYegklvJmZ3+5
         HrTGSHKT9+P00gtbUDB8/eaQVsd64vmTSEF22a0iG1EmG4jheimux9n0Gz9j1VGHniSA
         nw44IHZ1emDVZ69YrbDATdHvGRoybz1SrTw8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JUE43aCGdIvBQ3zJiGYOJqLCeUH9k/YrYqqRjecWfSQ=;
        b=kuj9CYm6OgyDUC+eF4XHsV3QZ2xI4WJK8FnPqDsgk3uOnELEhTMcHCjNrBFCehlHF6
         LKnqoAG4OI3Rdhs0eT0IunB+aGTr1+55v3HmKtgoH6osbioD/zcokW4Kmg5DvBWV63Qp
         jAkZXCBj+QV0K2k6GU5UbQzqetm0HY8GGMudrD0t710O7C1PY5eHh36Cd6AGWh/d0+hP
         g8FDXoKtMrrV9jhmWJI6uElfbFDzO9PPpyKDTbAqK+xs71VBaIBfhcJSQXobDNkigtR+
         esChreEEtrQAPOZ+HGcUnm2JzoitwZWeZHStZEbtRdMkad8h7xFh0et7d1baaTFE0bQO
         Ik7A==
X-Gm-Message-State: AOUpUlFRKVgPew29o/OUoB+gg/aTZ+JB+BHMdifL8kfzMlaSH/dRfXIG
        3tNepUD4mIwcpxGH77pLhNYBWA==
X-Google-Smtp-Source: AAOMgpfZnblOeqO5JmOG6A8O0HOQcWdp6egY/Z4mgaTx095cklNnve6MyP6X2i+lLc0NZimdFsjZ0g==
X-Received: by 2002:a37:16c3:: with SMTP id 64-v6mr3876513qkw.381.1531882465181;
        Tue, 17 Jul 2018 19:54:25 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id e21-v6sm1450716qtc.67.2018.07.17.19.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 19:54:24 -0700 (PDT)
Date:   Tue, 17 Jul 2018 22:54:23 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: Re: [PATCH 1/3] vt: avoid a VLA in the unicode screen scroll
 function
In-Reply-To: <20180718014813.ygcbgqxk4yo3ydbl@angband.pl>
Message-ID: <nycvar.YSQ.7.76.1807172155070.11681@knanqh.ubzr>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org> <20180718010242.5254-2-nicolas.pitre@linaro.org> <20180718014813.ygcbgqxk4yo3ydbl@angband.pl>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1964054974-1531882464=:11681"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1964054974-1531882464=:11681
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 18 Jul 2018, Adam Borowski wrote:

> On Tue, Jul 17, 2018 at 09:02:40PM -0400, Nicolas Pitre wrote:
> > The nr argument is typically small: most often nr == 1. However this
> > could be abused with a very large explicit scroll in a resized screen.
> > Make the code scroll lines one at a time in all cases to avoid the VLA.
> > Anything smarter is most likely not warranted here.
> 
> Even though nr can be 32767 at most, your new version is O(nr*nr) for no
> reason.  Instead of O(n) memory or O(n²) time, a variant of the original
> that copies values one at a time would be shorter and faster.

Well... even though nr _can_ be up to 32766 to be precise, it is most 
likely to be just 1 in 99.9% of the cases. So in that case, you'll 
execute the loop only once and the code is currently optimal with O(n).

If nr > 1 then the current cost is O(n*nr) where n is the height of the 
scroll window i.e. relatively small in practice (typically between 25 
and 60). There is no point optimizing for 32767 rows as that is rather 
silly. If we had then the best solution would be a linked list rather 
than an array.

But still, if nr > 2 that means you need a temporary storage because the 
destination memory has to be preserved before the source memory can be 
moved there, and that destination memory content cannot be stored in the 
vacated source memory until the source content is moved. Copying values 
one at a time cannot work because the destination memory, the source 
memory, and the area where the previous content from the destination 
memory will end up don't overlap most of the time.

That temporary storage was that VLA. We don't want VLAs. So how do we 
efficiently allocate and deallocate memory for, say, 25 words? Maybe 
that doesn't have to be efficient because that doesn't happen very often 
as we said, at which point we can just do it in a loop with a one-line 
increment instead, as this patch does.

If you still have a more clever way of doing this then please propose it 
in code form (I'm genuinely curious of what you have in mind). But let's 
get the baseline working in an obvious "correct" way first.

> > Requested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  drivers/tty/vt/vt.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 2d14bb195d..03e79f7787 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -433,20 +433,22 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> >  
> >  	if (uniscr) {
> >  		unsigned int s, d, rescue, clear;
> > -		char32_t *save[nr];
> >  
> >  		s = clear = t;
> > -		d = t + nr;
> > -		rescue = b - nr;
> > +		d = t + 1;
> > +		rescue = b - 1;
> >  		if (dir == SM_UP) {
> >  			swap(s, d);
> >  			swap(clear, rescue);
> >  		}
> > -		memcpy(save, uniscr->lines + rescue, nr * sizeof(*save));
> > -		memmove(uniscr->lines + d, uniscr->lines + s,
> > -			(b - t - nr) * sizeof(*uniscr->lines));
> > -		memcpy(uniscr->lines + clear, save, nr * sizeof(*save));
> > -		vc_uniscr_clear_lines(vc, clear, nr);
> > +		while (nr--) {
> > +			char32_t *tmp;
> > +			tmp = uniscr->lines[rescue];
> > +			memmove(uniscr->lines + d, uniscr->lines + s,
> > +				(b - t - 1) * sizeof(*uniscr->lines));
> > +			uniscr->lines[clear] = tmp;
> > +			vc_uniscr_clear_lines(vc, clear, 1);
> > +		}
> >  	}
> >  }
> 
> What the function does is rotating an array (slice [t..b) here), by nr if
> SM_DOWN or by -nr ie (b - t - nr) if SM_UP.  A nice problem that almost every
> "code interview questions" book includes :)
> 
> Please say if you don't have time for such games, I've just refreshed what's
> a good answer. :þ
> 
> 
> Meow.
> -- 
> // If you believe in so-called "intellectual property", please immediately
> // cease using counterfeit alphabets.  Instead, contact the nearest temple
> // of Amon, whose priests will provide you with scribal services for all
> // your writing needs, for Reasonable And Non-Discriminatory prices.
> 
--8323328-1964054974-1531882464=:11681--
