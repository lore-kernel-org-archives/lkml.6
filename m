Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELuupI3goJaU1MRzg3IhMe9fBQQ1g7/yPNjntrqF9u0MJpKBbij56/bJTT93RFJ2XO+8KAFj
ARC-Seal: i=1; a=rsa-sha256; t=1521018187; cv=none;
        d=google.com; s=arc-20160816;
        b=xhEW98fvDfg5M4GB8yfiCcmjdJmVIZts6PNchAEBNFTUkVtvF9oAKyIfvcb++DnYic
         vM5hrN/K9UgMto2TmAm/1IeYCUXGRi6SjE2I+4Suc8Gn9HdjFAyIsBAzEiJmEMxNqLCT
         FJ28M1yR+KJ7iaDDlrAiUShjxQvf+rLEkvaIIEHIbHTi4MhEdNj4tQTOCr/G7jHWpEAp
         eAJeNZFapDzcDTqVKjCu+9W+BrrbSi6niKrU5zWVYSEASUNkusSz7KTbG6dzaVZlKvz8
         3wYzKF4houqYSZvGH6M4unkOYD1vNuO0h9Mdl6NxXa3m/CfruIgtq5SioX4Z3LNRCaRA
         gcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=fT1ZKgReRby6mVYTOBjuXOGVBdc3byjas+0xCP/Bl5w=;
        b=iAraOimPKAWddnTvY+weZil+hR/3GyjBP/ZgbQSJymXezXEAfaYYrj/nGBbE/hBsfg
         XTucKDgrnSE39DfuCD/EyaXbYABZOCSd/NxjkRDvlne2wS4iVAeaCNF0bYdLrtRNoGnr
         hmmQX0PNPozjzqygkwnhADjRs04FyTJ02hlZJvfu70bzVGwjop8KPOdUpGMo4x+CYGpl
         1d5Rr0pPSbcmUuwu/qX55iMAm1dJMUWaZkdy3Ny84JoGKlGTS15Oer6vlXTxxtFMUQPj
         Lla2VSJUsJy4VScRl1fxaSJYwb+8r6wZNB/sVB6JNQ6QSdixp1xwlYCeW/T2hrFOKwMi
         k/AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Wed, 14 Mar 2018 10:03:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"johan@kernel.org" <johan@kernel.org>,
	"msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180314090306.GF28983@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <20180313073448.GA32269@lst.de> <HE1PR0401MB242509FE2B60674CAF306A4AE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB242509FE2B60674CAF306A4AE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594903166389741401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Agree. There is no good point in duplicating the code.
> So this new API will be part of 'drivers/base/dma-mapping.c' file?

Yes.

> > As mention in my previous reply I think we don't even need a deconfigure
> > callback at this point - just remove the ACPI and OF wrappers and
> > clear the dma ops.
> > 
> > Also in this series we should replace the force_dma flag by use of the
> > proper method, e.g. give a force parameter to of_dma_configure and the
> > new dma_common_configure helper that the busses that want it can set.
> 
> I am more inclined to what Robin states in other mail to keep symmetry.
> i.e. to keep dma_configure() and dma_deconfigure() and call
> dev->bus->dma_configure from dma_configure(). Is this okay?

Sure.
