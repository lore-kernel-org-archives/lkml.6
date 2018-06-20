Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C3C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620FA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THFPexE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620FA20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeFTU1A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:27:00 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35843 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932570AbeFTU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:26:57 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so330442pgd.3;
        Wed, 20 Jun 2018 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=88JExTGe8PWAaz9rCdNWBzo9KJQgj/p/81X69LYxUYc=;
        b=THFPexE8KU2jWJXktvCVe/Sv22j6iE5DTXMHR/VDO+YoN6tCFZjxB5lho0REpCKhOJ
         Ds/5NkQteDmV8vLBH74EDlA8tofLLNEhYmEEa9IsCPLpfpL3q5cThuuCjvkWxq56EAX6
         QUodNztISpvpWh1+4LyBPY3WtGDHJG4MGob7EmmVURJIwKP9nBgnisjVm8+mTj1Xivy0
         ujh47Wj3MyaAPa+96AsGJ84L9/on5MoJvBTP3+pk8ytIOK7PSJZCG6OLr2JRobMIHieD
         XDUu1tM3VOpRnaevHQ0sgFQ2Nqt33xaHjNmvtjV0mtPPr02XEvf4f5RWQy9LvHcaYYVJ
         VdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=88JExTGe8PWAaz9rCdNWBzo9KJQgj/p/81X69LYxUYc=;
        b=nUsV55uJR4NwGueCVH55kHgNn6qrOEjIm5GDrFvtokdmA0XPqiVOBrzrguJ6Z6Vyzd
         Bh80WpvzifTcM4MNb8MrIrPbRvIBtPM6xE6NeA7JWMNxuzg2pEKbZ37YlvHUPHxhgqpF
         bD01QLSsxp28m6sJLUFw3gyTNh+kh0j7qa3xXW1Qq8XwpY4JQC8cTrQEVmViz12gdM08
         IVeaVQbKBnJrHf/7/BpcfiQrS7BvD3uvej/NBi6zTqiIyxAVlx8wEXCvdzcO6dU+nbbt
         OPkkt/0UoXToTGtGLN4lESDBocY5p41bQgrbIWgQ36t+ZxeNw4e1s8ezg5QSoP/Azaph
         xLnQ==
X-Gm-Message-State: APt69E0O59VH+QcKtEPbP/TjNrsXBl5L79MRlhHiwbqiCEpTjJnDMHr2
        5Z2EH/EqeRZcp+ancMXSNbA=
X-Google-Smtp-Source: ADUXVKK2YHnvypW2FGXFgye30MyQv5a7ueMtMW4DovPu/rhvB/CxCrQYSi0CXTsUY7O4f4GUnaK/Ag==
X-Received: by 2002:a63:383:: with SMTP id 125-v6mr458998pgd.421.1529526416317;
        Wed, 20 Jun 2018 13:26:56 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4714852pgq.33.2018.06.20.13.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 13:26:55 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:26:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
Message-ID: <20180620202653.GA75925@dtor-ws>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
 <20180615214231.GA371@yury-thinkpad>
 <20180619183316.GI71788@dtor-ws>
 <20180620081321.GB19364@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620081321.GB19364@yury-thinkpad>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:13:21AM +0300, Yury Norov wrote:
> On Tue, Jun 19, 2018 at 11:33:16AM -0700, Dmitry Torokhov wrote:
> > External Email
> > 
> > On Sat, Jun 16, 2018 at 12:42:31AM +0300, Yury Norov wrote:
> > > Hi Andy,
> > >
> > > On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
> > > > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > > > Besides that it returns pointer of bitmap type instead of opaque void *.
> > > >
> > > > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >  drivers/input/evdev.c | 16 +++++++---------
> > > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > > > index c81c79d01d93..370206f987f9 100644
> > > > --- a/drivers/input/evdev.c
> > > > +++ b/drivers/input/evdev.c
> > > > @@ -481,7 +481,7 @@ static int evdev_release(struct inode *inode, struct file *file)
> > > >         evdev_detach_client(evdev, client);
> > > >
> > > >         for (i = 0; i < EV_CNT; ++i)
> > > > -               kfree(client->evmasks[i]);
> > > > +               bitmap_free(client->evmasks[i]);
> > > >
> > > >         kvfree(client);
> > > >
> > > > @@ -925,17 +925,15 @@ static int evdev_handle_get_val(struct evdev_client *client,
> > > >  {
> > > >         int ret;
> > > >         unsigned long *mem;
> > > > -       size_t len;
> > > >
> > > > -       len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
> > > > -       mem = kmalloc(len, GFP_KERNEL);
> > > > +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
> > > >         if (!mem)
> > > >                 return -ENOMEM;
> > >
> > > But in commit message you say you switch to bitmap_zalloc(). IIUC
> > > bitmap_alloc() is OK here. But could you please update comment to
> > > avoid confusing.
> > >
> > > >
> > > >         spin_lock_irq(&dev->event_lock);
> > > >         spin_lock(&client->buffer_lock);
> > > >
> > > > -       memcpy(mem, bits, len);
> > > > +       bitmap_copy(mem, bits, maxbit);
> > > >
> > > >         spin_unlock(&dev->event_lock);
> > > >
> > > > @@ -947,7 +945,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
> > > >         if (ret < 0)
> > > >                 evdev_queue_syn_dropped(client);
> > > >
> > > > -       kfree(mem);
> > > > +       bitmap_free(mem);
> > > >
> > > >         return ret;
> > > >  }
> > > > @@ -1003,13 +1001,13 @@ static int evdev_set_mask(struct evdev_client *client,
> > > >         if (!cnt)
> > > >                 return 0;
> > > >
> > > > -       mask = kcalloc(sizeof(unsigned long), BITS_TO_LONGS(cnt), GFP_KERNEL);
> > > > +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
> > > >         if (!mask)
> > > >                 return -ENOMEM;
> > > >
> > > >         error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
> > >
> > > If my understanding of bits_from_user() correct, here you can also use
> > > bitmap_alloc(), true?
> > 
> > bits_from_user() copies as much as user supplied, we want to zero out
> > the tail to make sure there is no garbage, so we want to use
> > kcalloc/kzalloc/bitmap_zalloc here.
> 
> I don't understand that. Tail bits of bitmap (i.e. after last used bit
> till the end of last word) are always ignored by kernel code and there's
> no matter what was stored in that bits.

Users can supply as little as one long word worth of data (codes_size =
maxlen = 4). You really do not want the rest of the mask you will be
applying to contain random heap garbage.

> 
> (With the exception of copying bitmap from kernel to userspace. For this
> case we have bitmap_copy_clear_tail() to avoid unintended exposing kernel
> data to user.)
> 
> If you know any bitmap function that don't ignore tail bits, this is a
> bug and should be fixed.
> 
> By the way, bits_from_user() is bad-designed because it takes 2 size
> arguments - maxbit and maxlen, and should be reworked. There's a
> single user of this function, and I suspect, it can be switched to
> existing core API, like bitmap_from_arr32().

I'm afraid you suspect wrong, as (unfortunately, but it is ABI now) we
are not dealing with masks consisting of u32 or u64 elements, but
"unsigned long" elements, which change size depending on 32/64 bit
architecture and whether we are dealing with compat or native userspace.

It also needs both maxbit and maxlen, because one is kernel's limit
while the other is limit from userspace POV and you need to reconcile
both to make sure you do not overrun buffers on either side.

Thanks.

-- 
Dmitry
