Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx4+PoDbj0TxojEDFvP5iaZ3p2vmFrH6TttGnUPhEFrsF8TQeF5/b/uyXmyG/pdJxF9v00/7P
ARC-Seal: i=1; a=rsa-sha256; t=1522947394; cv=none;
        d=google.com; s=arc-20160816;
        b=hZN5QKj/j4UsTpewN+AaSWOgdGpaaZdodcwrdOufmfaZ4HNHINtVX6bS2BKiBtaiR4
         TwIj7gn+ohaAgQNQCDrLiN7K+x84EImbkQ7F2xME3CpnfIxGDPokIrl4prxScMhVGW0K
         SThkGXOMEwhrrt9+3c3dwuJmZ4fJVmgQu3C0tlgxF+P7UDfUouA+AyLamgd9PUOnte8G
         uRSybXNzqrd2UtRRh520aQOQEgdOlj6cHy1sHKsAlAXvRFrBI3JoY9UN1W5vXoPeLFSv
         wHjxRNwIqzkX8EKytCPGmvBlPRGOw2whZVgguDhjs7Zn4c25R3nzO6i7QijESnDKQcU6
         vQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=77UbDCa23ng2yHtv+2ajmAyBk24pTStyWoGKOq9xm3w=;
        b=EwZ3ykbF+0n+jorGETheXafL5k+l83utLcmRsuEmMBkk+p7vif2hLZ09FnnPEIY+pj
         996RO9eKirQ27c0eBJNZLt9E3nKemy5SW0lEo1zQNQtgRYw3pGV4ZtVJZc3n9XuBU+Bg
         Bb+2I/DWiM7Vg8RYJbmJof5iICyglxRRdDxOMk38aLNr0BH7D2epsnatiemTgPGdp2BD
         D5WyVJbgieEy5WPsjbx3pNbNcXjYjSbDnOJZxMFR4ukrm5E+vd3Pt4rRZRCPxmJwAYg8
         1NadodMFBUFgqwA0fi9bzd9xzMSOkbdosOo924FMycTZNCYZOFZ+yFgstiiLBIEag6An
         2pTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=DOTA4kWs;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=DOTA4kWs;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Thu, 5 Apr 2018 18:56:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: gregkh <gregkh@linuxfoundation.org>
Cc: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180405165631.GB17495@lunn.ch>
References: <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
 <5AC5FAA8.80409@nxp.com>
 <20180405114736.GA12178@lunn.ch>
 <5AC61393.7090509@nxp.com>
 <20180405124810.GE12178@lunn.ch>
 <5AC63610.4000504@nxp.com>
 <20180405152348.GC32663@lunn.ch>
 <HE1PR0402MB2700E32234735AC12C18BB8F94BB0@HE1PR0402MB2700.eurprd04.prod.outlook.com>
 <20180405161214.GB9976@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405161214.GB9976@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596926086442044386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > Hi Andrew,
> > 
> > We're waiting for the DPIO driver (which we depend on) to be moved
> > out of staging first, it's currently under review:
> > https://lkml.org/lkml/2018/3/27/1086
> 
> That's stalled on my side right now as the merge window is open and I
> can't do any new stuff until after 4.17-rc1 is out.  So everyone please
> be patient a bit...

I took a quick look.

There are a few inline functions in .c files which is generally
frowned upon. Let the compiler decide.

e.g:

static inline struct dpaa2_io *service_select_by_cpu(struct dpaa2_io *d,	
                                                     int cpu)
static inline struct dpaa2_io *service_select(struct dpaa2_io *d)

dpaa2_io_down() seems to be too simple. dpaa2_io_create() sets up
interrupt triggers, notifications, and adds the new object to the
dpio_list. dpaa2_io_down() seems to just free the memory. Do
notifications need to be disabled, the object taken off the list?

dpaa2_io_store_create() allocates memory using kzalloc() and then uses
dma_map_single(,,DMA_FROM_DEVICE). The documentation says:

   DMA_FROM_DEVICE synchronisation must be done before the driver
   accesses data that may be changed by the device.  This memory
   should be treated as read-only by the driver.  If the driver needs
   to write to it at any point, it should be DMA_BIDIRECTIONAL (see
   below).

Since it has just been allocated, this seems questionable.

I'm also not sure where the correct call to
dma_map_single(,,DMA_FROM_DEVICE) is?  Should dpaa2_io_store_next()
doing this?

The DMA API usage might need a closer review.

    Andrew
