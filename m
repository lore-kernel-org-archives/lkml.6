Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FFFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53FB21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqG3zCCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391834AbeLUUFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:05:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34416 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeLUUFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:05:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so4749784lfc.1;
        Fri, 21 Dec 2018 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHVi8H9/6KagMWPzw8Fwg0KqblmVuLDJSo4G/Y5UnRg=;
        b=RqG3zCCV/5fTVva/jkuNUUogx6+7AVH10TiOC+nqzfoBZCUPqfUpx9fuq0z4nLsx1j
         H0QFDvnSWLriCxvRint9FAEGBs5DQS/4TxTdnajv2R0DZQJZBD637U07Vg4HQr0Sg/so
         2puI7L55yRSqE8kSTdUSwhAAWSwIZZoniKHeDwlil7vBdhfTSheCH2zd+W5fu/Q9EuNM
         AKVo6ubO2ik6PGcvkE0/BQHfbDL6ur6iNtDhmjudr7/cQIwPEDUVbrqnWCgrJ8eOJubF
         CCuSOWP1Cgm1yHP33+0Iz8GKLxR8fsZl17u8W4wk+cofLJ6PN5XgXY4wvUrMOYwKTYDM
         salw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHVi8H9/6KagMWPzw8Fwg0KqblmVuLDJSo4G/Y5UnRg=;
        b=NjHeNf+HrfWhFKxMRFBUE+urmEzkIn+uNbmg+xMqTRKSYTIBv1ylejIg8L2sjBeZqB
         dbvtZbifuWDQIsjov7qkJcAeNXfAm9QlvIWEi111YEBdG2Z6zy0wWbQYlsJ7wu1Wn3E8
         Wh17G34VCRjZ8VldeiaMJu094pfqATD3hRv4Y0EO0D8kDOImy3ORP/xX1RkP7FInhE9M
         PGxqOLUPvNr8z/FNWrBp3GC5EqyPSxLlgwc0IM/84q3uwext1W71pBfepicvRb0CRepV
         NaBcEOrvxjWCJiKdUKUPRfk36HgYq4ATYWICOLablwbB185cFcG8YWGCYOIIm4fhtpB9
         VCDA==
X-Gm-Message-State: AA+aEWbtXt5uVRv9GGw4Vvei50NqP+rZGO4q3duAzhD7yOz4jUhh+YM4
        zW1FQblkcQRMT3isJelnPqs=
X-Google-Smtp-Source: AFSGD/WAmFVc4ztVoLUg/8Vga6SBqmuJBJfiN8Xn7xRffH9c070QivE/NjWjyIJ409E69snrtTiQWw==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr2257605lfb.72.1545422747896;
        Fri, 21 Dec 2018 12:05:47 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id t9-v6sm4792831ljj.87.2018.12.21.12.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 12:05:47 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 878F8460769; Fri, 21 Dec 2018 23:05:46 +0300 (MSK)
Date:   Fri, 21 Dec 2018 23:05:46 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] x86_64: memset_user()
Message-ID: <20181221200546.GA8441@uranus>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-2-igor.stoppa@huawei.com>
 <20181221182515.GF10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221182515.GF10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:25:16AM -0800, Matthew Wilcox wrote:
> On Fri, Dec 21, 2018 at 08:14:12PM +0200, Igor Stoppa wrote:
> > +unsigned long __memset_user(void __user *addr, int c, unsigned long size)
> > +{
> > +	long __d0;
> > +	unsigned long  pattern = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < 8; i++)
> > +		pattern = (pattern << 8) | (0xFF & c);
> 
> That's inefficient.
> 
> 	pattern = (unsigned char)c;
> 	pattern |= pattern << 8;
> 	pattern |= pattern << 16;
> 	pattern |= pattern << 32;

Won't

	pattern = 0x0101010101010101 * c;

do the same but faster?
