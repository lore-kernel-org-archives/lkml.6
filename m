Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AG47ELvYCnWBIAPL3Z3tWmML/m3zqjYbvgpFzEl1Bwj3V8t1WOSmjp4cwT5iaQT+67TI9zb7knr7
ARC-Seal: i=1; a=rsa-sha256; t=1521204927; cv=none;
        d=google.com; s=arc-20160816;
        b=jqPsFZKI9z/qRjmH8LOXL54itO1lAGV0ZBU8ZeqbZlUeXSPTmQ7AAtQuWuKgxaYyYX
         r4HnyBVQcj2DGC/r4fbY12wm9/0dX+JDm2rKGIvAFVVxolW1YkMWygIjLNReIk4vYjFw
         3IDyWyU6TrhGtljXJTogfrtaxeQCOdynbCdsOimgLhN8pPqhPXhmXD+Q0wbnTtHMqb0Y
         jxf2Zd8lyaOtsLsUvA4i8BqoSNp8CLg3Z9fKxNTS7jUnvp2oraTdAromkp5Ev5UYc45b
         ZjqqdOGEecNctlyf1aqCMHmZw/umskk4qCa8hLY4yH9VrOn9yRL/GhdXb/O473uDK4Wu
         sePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XHY5yATwqD73MmndA4tQtiNUx0QH8/LoHNRnvJdeTVw=;
        b=Pfkv5cGDpCFLTBahSsUr13RoP9R/V+ASEKR2Q9m0FfDj87A1ROkDYpWfDQxs/4n1Uf
         4SfaEeBB2Sp2QP+qw7qIhMzOd0yKhJiFqATL6ediuJmHuGJXRDs5wFmVCpM7+aBQIR8w
         Dttz+9DdRgiv456T4G3BuhkSpZUrMJz+CmUxr7hK5QNRx665TXXkXArhQm3OIiVHLqqQ
         Rn0EXqwKwoyUUNngUla0dMeeJn1xV/swhOM8o5m7TBLJXs+9d2rRaCg05Q20IpLUFEd1
         mY690emVQt8y2dXXzXCfv2T2FdHw5Tiv8UT75j7w+tbK0ijJfZt2K+RvG4L31Mr1ojPz
         gsyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Date: Fri, 16 Mar 2018 13:55:24 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180316125523.GA30728@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-6-niklas.cassel@axis.com>
 <20180315132213.GA8629@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315132213.GA8629@kroah.com>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376627258900258?=
X-GMAIL-MSGID: =?utf-8?q?1595098977689604474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:22:13PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 08, 2018 at 02:33:30PM +0100, Niklas Cassel wrote:
> > A 64-bit BAR consists of a BAR pair, where the second BAR has the
> > upper bits, so we cannot simply call pci_ioremap_bar() on every single
> > BAR index.
> > 
> > The second BAR in a BAR pair will not have the IORESOURCE_MEM resource
> > flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
> > resource flag set.
> > 
> > pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> > pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> > pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR1
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR3
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR5
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> Where are the 4 other patches in this series?  I can't just only apply
> the last one, right?

http://patchwork.ozlabs.org/project/linux-pci/list/?series=32658

I'm expecting all patches to go via Lorenzo's pci tree.

> 
> Please be careful when sending patches to properly notify everyone...

I'm using scripts from Joe Perches that run get_maintainer.pl,
these scripts are then used as --to-cmd and --cc-cmd for git send-email:
https://lkml.org/lkml/2016/9/14/482

(I did have to modify them so they handle rerolled patch series.)
BTW. Joe, do you have updated versions of your scripts?


Greg, I'm assuming that you wouldn't want to be cc'd on all patches in the
series, since all except the last one are pci related.
However, perhaps it would be nice to add all those who are cc'd in the
individual patches, as cc to the cover letter, that way it might be easier
to figure out what tree will most likely merge a certain patch series.



Kind regards,
Niklas
