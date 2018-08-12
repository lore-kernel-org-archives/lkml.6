Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980CCC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E82219A4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jri0mRsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E82219A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeHLNJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:09:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeHLNJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=guxkt9C5JZnE8ExIp37Ab4vE9GUxxYJQPmkNQfvg21o=; b=Jri0mRsSasUVxrK4cRW5P24hO
        XM4MHhpaMguPgcavYTVN0yGucGiuc37wN96+KeTaSBut5k4K0Yby45E5s0x0xyfVZJ/2vO83udXkT
        I/oFqbmCutF+PCT+rYNSFyPoDSqbTBsyc10pr2/6z2ePCE76GFK4DSfnw1PN/mj/BuX/kqf8SQ2AS
        KevdiixXnBjOxezXdnlVdOoS6FpSfdwvzOWejsxF49DNHUsoJtLYP08D/G89IFhzIyzw7yoCWW8Nv
        bhipFwWznXLORJ5ziYVdgKvcqRRiurw0BFaNeutHK+iHA1enKpUHkw1i32qQNs2bzVQiGwh2pa8GC
        TwFhgOSSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fonen-0001Sb-Un; Sun, 12 Aug 2018 10:31:33 +0000
Date:   Sun, 12 Aug 2018 03:31:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: lspci: Display path to device
Message-ID: <20180812103133.GB2984@bombadil.infradead.org>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
 <mj+md-20180810.091549.51451.nikam@ucw.cz>
 <mj+md-20180810.103017.64385.nikam@ucw.cz>
 <20180810145655.GA16533@bombadil.infradead.org>
 <mj+md-20180812.092635.39872.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20180812.092635.39872.nikam@ucw.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 11:28:37AM +0200, Martin Mares wrote:
> Hello!
> 
> > One is that using -P and -s together doesn't work because we haven't
> > scanned the entire topology.
> 
> Fixed. When topology is required, we now scan all devices and apply the
> filters later.

Thanks!

> > The other is that even when not using -s, the topology isn't fully represented:
> > 
> > $ ./lspci-mm -PF tests/fujitsu-p8010.lspci |grep 3com
> > 00:1e.0/00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)
> 
> Ah well, it seems that the tree mode never worked with CardBus bridges. Fixed.

Haha!  I can't believe we never noticed that in the last twenty years!
And we're fixing it even though PCI CardBus bridges are now completely
obsolete (my current laptop has no slots of that form factor; my previous
laptop has an ExpressCard slot; I had to go back to my previous-previous
laptop from 2008 to find sample hardware to test CardBus).

> After some pondering, I changed the format of the paths to include bus numbers
> in all steps. I think it is more intuitive.

I agree it's more intuitive, but it's not the format that Logan's code
is expecting, so it's not as useful for my purposes.  How about this?

$ ./lspci -PF tests/fujitsu-p8010.lspci -s 1d:00.0
00:1e.0/03.0/00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)
$ ./lspci -PPF tests/fujitsu-p8010.lspci -s 1d:00.0
00:1e.0/1c:03.0/1d:00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)

I pondered asking Logan to change his parser to include the bus number
as a solution, but then I remembered the entire point of this is to make
specifying a device robust against bus number assignmnet changes.  I suppose
we could have the parser accept and ignore the bus number ...

diff --git a/lspci.c b/lspci.c
index 75cb5b9..3dabbde 100644
--- a/lspci.c
+++ b/lspci.c
@@ -50,7 +50,8 @@ static char help_msg[] =
 "-xxxx\t\tShow hex-dump of the 4096-byte extended config space (root only)\n"
 "-b\t\tBus-centric view (addresses and IRQ's as seen by the bus)\n"
 "-D\t\tAlways show domain numbers\n"
-"-P\t\tDisplay bus path in addition to bus and device number\n"
+"-P\t\tDisplay bridge path in addition to bus and device number\n"
+"-PP\t\tDisplay bus path in addition to bus and device number\n"
 "\n"
 "Resolving of device ID's to names:\n"
 "-n\t\tShow numeric ID's\n"
@@ -264,7 +265,10 @@ show_slot_path(struct device *d)
       if (br && br->br_dev)
 	{
 	  show_slot_path(br->br_dev);
-	  printf("/%02x:%02x.%d", p->bus, p->dev, p->func);
+	  if (opt_path > 1)
+	    printf("/%02x:%02x.%d", p->bus, p->dev, p->func);
+	  else
+	    printf("/%02x.%d", p->dev, p->func);
 	  return;
 	}
     }
diff --git a/lspci.man b/lspci.man
index 78b5c96..55fadb1 100644
--- a/lspci.man
+++ b/lspci.man
@@ -98,6 +98,10 @@ have only domain 0.
 .TP
 .B -P
 Identify PCI devices by path through each bridge, instead of by bus number.
+.TP
+.B -PP
+Identify PCI devices by path through each bridge, showing the bus number as
+well as the device number.
 
 .SS Options to control resolving ID's to names
 .TP
