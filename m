Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AB8JxZoG72qew3ai15Nx1Yc1/4T6OvE75lXF9/5pZlBa2xz+YEw1ja7qMQgZ26Ju3WQhkXKwP2ah
ARC-Seal: i=1; a=rsa-sha256; t=1525651041; cv=none;
        d=google.com; s=arc-20160816;
        b=Qpk7g6wprn5vzBzrdZ5kpi/mRbwHPBxJVF8tTyZn52YwTQVhwJayEZyhoG5mJ5akDn
         3Poq2VeGkhhllgHw0PM8pxK9rXa77153FAF53plr4npOfU2IkLURbkfdck9rvZUpP2OA
         UuZHbqkYU5H3ddimn0IcaLGCSBPiEk3DV/bEeN1JYXYsct7R8uAE2PnlfdzUGos1TBxZ
         xvIfhkJKfxrOBrbAiKLQcktTl5WlEgt8YD0/uNIEnOxR4cA5IKPEMaJ80+/BSdvGqTVt
         FRbwlzCGddriTIdZe2sU5WzONEgvas6R+47lXtSVhdwDtht3APgikIEpxmmXeOwV7KvL
         4NOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:arc-authentication-results;
        bh=904Zf7hCKvMeI6wbDgOpcSqLW4QRIHYKT9N6f18rm5E=;
        b=xDyHtU6urYVKCtKUINhrLPPSLORBX+G/6BuTqPaWC2eyqrRm+xXGZEcyHOau+EiZ/A
         C4mmLP3MkTcPKguhcPiWoTFT+1YZIZiO2yMC8hg2Z9S/WioTCD3w1jROQBD/5Y1rqEaB
         pGCVM/FwIJLTpD1MuXond7wU/QHamvNsoeTzEWdAFsncXaSebIQXZYxe4nearRG7zfHv
         kHEWg85yv0mrL5uGt8aLyjF4NRM+ZSYxAvPFDbU2xwevAl4X8Yyw69An5YijzHkheT69
         ZFxWTw6b1fbZAdNHWB7/i42wxpK3x1YiwMb3f+WjWHTMpP/fdJRmSOL+ALwpVmilDlEK
         EeZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Date: Mon, 7 May 2018 09:57:22 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Unconditionally register bus type
In-Reply-To: <20180506202018.GC8924@kroah.com>
Message-ID: <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com> <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet> <20180506202018.GC8924@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599761065975770741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 6 May 2018, Greg Kroah-Hartman wrote:

> > > Why not just have an "bus is registered" flag in your driver 
> > > register function that refuses to let drivers register with the 
> > > driver core if it isn't set?
> > 
> > Perhaps that should happen in the core driver_register() function. 
> > BUG_ON is frowned upon, after all. Would that be acceptable?
> 
> I don't understand what you mean here, perhaps make a patch to show it?
> 

As an alternative to your suggestion (add flag to avoid the BUG_ON):

--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,10 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p) {
+		WARN_ONCE(1, "Cannot register driver with invalid bus\n");
+		return -EPROBE_DEFER;
+	}
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||

I'm not actually proposing this change; just responding to your question.

For the bug at hand, I still prefer the patch at the beginning of this 
thread, because it seems to follow the conventional pattern.

> > I found a few drivers that set a flag the way you describe, which 
> > could then be simplified.
> > 
> > But that pattern is rare. Most buses use the postcore_initcall() 
> > pattern, and so my patch took the conventional approach.
> 
> It all depends on link order, not necessarily the postcore stuff.
> 
> > > And then fix your linking error, the bus should come first in link 
> > > order, before your drivers :)
> > > 
> > 
> > I didn't encounter any errors. How shall I reproduce this?
> 
> If you have not seen this error, then why change the code at all if it 
> is working properly?

I never saw the link error you mentioned.

Please see this thread for one example of how to hit the BUG_ON.
https://marc.info/?l=linux-m68k&m=152522162801182&w=2

Another way to trigger the BUG_ON is to set,
CONFIG_ATARI=y
CONFIG_MAC=y
CONFIG_NUBUS=y
CONFIG_MAC8390=y
and try to boot the result on aranym.

-- 

> Most busses do not need this as they have their link order set up 
> correctly, no need to mess with stuff that is not broken :)
> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
