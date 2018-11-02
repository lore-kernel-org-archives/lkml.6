Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C743E20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFnXYr3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C743E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeKCERi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:17:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37789 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCERh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:17:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id 131so4761736qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9ROH/ITGDSHqjQQPyvecu6ZEjxW5e/H4RNvsI77RxHI=;
        b=gFnXYr3zqGTGXGPBEEOR4pcVPc3k1Ep5tHrGlDfKoxgXeEMs/eb3yMBVj1dISqL6db
         TOyQ5JAGnoKc+PkTrbE1MiwHq1FF0y5s+bP204/2ZqVYTwxemJTJd1aNLlOeEgylQUiy
         BmcW3N91K8EXq+mel/VkNsy3wI84VptySIPSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9ROH/ITGDSHqjQQPyvecu6ZEjxW5e/H4RNvsI77RxHI=;
        b=J4Jh1W0GbPg/e2Y5tnJZz95QnqQ9wvJiLuJFj//MFy5DY9/nf3m+s2wUVAVe1FefVj
         sZ1fBvWQCluLQYWLi9sk/kH2YLKlIlY0ZCokbIaXHOb8Kv2D0BpYfGWPOb4BcY2VbqTs
         hTjq5cxsu5EloO+IApjj//EbCWPri9suskjgzbMWmR5U1s4E83HHZXftuURxrH2xREPN
         aZLdbv3nWiWufHJmGpcnTI83iVQvve+1N2dGh07wtZYDq8Nvn4QtvBLLid/BsafBYwI7
         EE9I0H3MXt7NjFD6i2ainR9AWf31fzVQAQO+oeCVCD3tM4XuGq/fXXSdhFXlmo2DAaUU
         tt9A==
X-Gm-Message-State: AGRZ1gLJmw9ZKZlDJ0QXdFk1Pj17S3gKUzWbrDVTuwCkv5V8r+wYGizu
        FO5WQr3SD8/pW3eI7n9oDaYdRg==
X-Google-Smtp-Source: AJdET5dmWagBZDokJWlicaSPRqlZ04/IwFVEgxQ9akN3IoCxWFaG0t4HJehBzT50A0JOaAmeXwEnkg==
X-Received: by 2002:a37:18e5:: with SMTP id 98mr12055006qky.333.1541185756492;
        Fri, 02 Nov 2018 12:09:16 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id j89sm15430503qkh.34.2018.11.02.12.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 12:09:15 -0700 (PDT)
Date:   Fri, 2 Nov 2018 15:09:14 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>
cc:     Dave Mielke <Dave@mielke.cc>, Adam Borowski <kilobyte@angband.pl>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: fix broken display when running aptitude
In-Reply-To: <nycvar.YSQ.7.76.1810231139460.1498@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1811021447200.1498@knanqh.ubzr>
References: <alpine.LRH.2.02.1810231126100.20699@file01.intranet.prod.int.rdu2.redhat.com> <nycvar.YSQ.7.76.1810231139460.1498@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, are you picking up this patch?

Would be nice to have in v4.19.1.

On Tue, 23 Oct 2018, Nicolas Pitre wrote:

> On Tue, 23 Oct 2018, Mikulas Patocka wrote:
> 
> > If you run aptitude on framebuffer console, the display is corrupted. The 
> > corruption is caused by the commit d8ae7242. The patch adds "offset" to 
> > "start" when calling scr_memsetw, but it forgets to do the same addition 
> > on a subsequent call to do_update_region.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Fixes: d8ae72427187 ("vt: preserve unicode values corresponding to screen characters")
> > Cc: stable@vger.kernel.org	# 4.19
> 
> Good catch.
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
> 
> > ---
> >  drivers/tty/vt/vt.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/tty/vt/vt.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/tty/vt/vt.c	2018-10-23 16:15:08.000000000 +0200
> > +++ linux-2.6/drivers/tty/vt/vt.c	2018-10-23 16:29:20.000000000 +0200
> > @@ -1551,7 +1551,7 @@ static void csi_K(struct vc_data *vc, in
> >  	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
> >  	vc->vc_need_wrap = 0;
> >  	if (con_should_update(vc))
> > -		do_update_region(vc, (unsigned long) start, count);
> > +		do_update_region(vc, (unsigned long)(start + offset), count);
> >  }
> >  
> >  static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar positions */
> > 
> 
