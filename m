Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZoYFkN3mzZsTIPlSA71WJgOo3LwnWyVWXtw00rnqvkF8L6U14rFXPVA1L8H9jqooN/cecXM
ARC-Seal: i=1; a=rsa-sha256; t=1525915470; cv=none;
        d=google.com; s=arc-20160816;
        b=SqXHEoYFr4V4tRTdAF+XTiIH5pWUSNjI3v/sWqewornFW3dzIgstj+lGVuaK9rr16l
         ZuQWEgC+toddyhG5RBgZIrHhcOHoBx99FyxcaXOZJmRI6OtZ6bT0Q+G7Xgxzti0F8yx/
         1G3i7hn0Wa1BHT1TV5ZHsebdJ1zdFuF2GCDxv2QBUtPrlAtLPZuD5+7ZNoWOPUixkj75
         rA0xdk4JWBJcCq4o/tvDXl6gzHasO2cjGO50ZAAWH/FNimgBGvcushasUSRs0natAEPO
         ax/HSIlyw6LL03YOLDYi7fro8ORj/G/98wBWZ1ORItOqt/zaYHAObZnf379Ern0mJ72w
         /BPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Dd+X8/LkaRVxyLxe8vv2H/sdQH9uP5f9/jXtFzs8Ax0=;
        b=Xm81xcRec6ygbnAxVf4EI1f2/ea7sxhFa0MkBGrCzc0twYva1HsQvip4+LvdVGLsCW
         wJSWy9Ja5tztfyZmuJXsMpOTInhid+UciMEHduPafA67bKS0jeUUeyR1Hx4KPnvwbjHm
         w+4dAdV3u+jdmIKqrrQ6Vb4SdT/FDiozA7s2fs5kwBjbSl81cTgvXF/YX6tc3VyOz6Wa
         BvLAFlUcJiIhUb/y+fK64AQk+fjC7m+qB5dJsUKcdB0DKRxNjjbz/RsC/SQ3X1j7QNmb
         EM0wU7dOp1Y9mAXDTs9u9V7BtJ3PF/+tw6BbmViHjDK66zd78aoeW+raXGema/xB9/IU
         +0vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 01:24:26 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Message-ID: <20180510012426.GA27853@wotan.suse.de>
References: <20180428001526.22475-1-mcgrof@kernel.org>
 <CAMuHMdUpc6=j62E7Xrcid6tKU5FRUZsiSVK7J=KD09epQ=9xfA@mail.gmail.com>
 <20180502151113.GB27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502151113.GB27853@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1600038340720972460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 03:11:13PM +0000, Luis R. Rodriguez wrote:
> On Wed, May 02, 2018 at 12:08:57PM +0200, Geert Uytterhoeven wrote:
> > Hi Luis,
> > 
> > On Sat, Apr 28, 2018 at 2:15 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > Some architectures do not define PAGE_KERNEL_RO, best we can do
> > > for them is to provide a fallback onto PAGE_KERNEL. Remove the
> > > hack from the firmware loader and move it onto the asm-generic
> > > header, and document while at it the affected architectures
> > > which do not have a PAGE_KERNEL_RO:
> > >
> > >   o alpha
> > >   o ia64
> > >   o m68k
> > >   o mips
> > >   o sparc64
> > >   o sparc
> > >
> > > Blessed-by: 0-day
> > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > 
> > I believe the "best we can do" is to add the missing definitions for the
> > architectures where the hardware does support it?
> 
> True, but we cannot wait for every architecture to implement a feature to then
> such generics upstream, 

Come to think of it your point was the wording. I changed it to not be as misleading.

  Luis
