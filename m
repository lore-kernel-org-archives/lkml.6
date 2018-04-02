Return-Path: <nks@flawful.org>
X-Google-Smtp-Source: AIpwx4/2OVRFcGrwaAnXTtmpOv0hWEAbmqA+Kv5R2bZ39qOgbNkE8kCpv21L/UQA4EvlGf61U9u7
ARC-Seal: i=1; a=rsa-sha256; t=1522697973; cv=none;
        d=google.com; s=arc-20160816;
        b=uHGsVZPCVewM4CCAQ0HrcXOHDQWhdx8LubM77dlI4Q+YDi/YuWovfOJ8B5l4G2QQ5A
         EL4yRb72yF91KBFR/pRh5r/Oj6Nr6n7g+84KF/JZsC1XmxpGqIsdrEjEk+7P8MwAYMtl
         IsF7qXFBGPSLn6rFMJei6g7ZAl1Vq+iseOz2eAI7A1aX756TzfAxSfNjsNQ+9dBjCKHN
         3CVcAZXct5kUKXa74aT2LuPpsBNHUhcfRwnPwIgdkyXxBBS5gwDxyLpliJPq7Wgvy/L3
         nzVKdTzmlsbxOgakI0nxQXf77Zum193UuJNuc2UlCoV+HH8AcsEaguVGMWLtR9HDJ9Nc
         O6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=FC7pSP8EI0qVd4DFpodBHvXBI+lKoeRdKaQvfZBuOh0=;
        b=Yvn27OWvWrltaATMFXYCshM3vR5TFlutroMGFQQSaQufz5wAwVLsm3mO1ByHomedaT
         RSGij0yIZ5S9KAloHDnvX3ghEJ2uhEDqKRoKuuTfu1zm7ORFjrO1bclqDNuzsbqSkYrx
         jiq27bxlNYeuItDqhmUYagZuB1/tTUfWc2CefWDAc9oL90du7doFd2WgOU7dHl5xVYVJ
         k/Zb0NDWWC3Qd9bfLu0UL15K/twcXZAB3+YKC6vU8g0u5o7McjT4ti1hCy2D2J3cPxGh
         9iNPdfaa762NVnGtseFgUdrA59rhyVtsMIb8a12W8PT3llJlWAxWi+yfjjt27HT732wm
         /mGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@flawful.org header.s=mail header.b=dhw5R/+h;
       spf=softfail (google.com: domain of transitioning nks@flawful.org does not designate 79.136.2.42 as permitted sender) smtp.mailfrom=nks@flawful.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@flawful.org header.s=mail header.b=dhw5R/+h;
       spf=softfail (google.com: domain of transitioning nks@flawful.org does not designate 79.136.2.42 as permitted sender) smtp.mailfrom=nks@flawful.org
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=flawful.org
Date: Mon, 2 Apr 2018 21:39:21 +0200
From: Niklas Cassel <nks@flawful.org>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>, "kishon@ti.com" <kishon@ti.com>,
	"cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Douglas <adouglas@cadence.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Niklas Cassel <niklass@axis.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/12] PCI endpoint 64-bit BAR fixes
Message-ID: <20180402193920.GC23587@flawful.org>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <e2fb68a0-c860-71cc-1983-2ecf30d5a2aa@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fb68a0-c860-71cc-1983-2ecf30d5a2aa@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596182050655819288?=
X-GMAIL-MSGID: =?utf-8?q?1596664550231849397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 02:52:56PM +0100, Gustavo Pimentel wrote:
> Hi Niklas,
> 
> On 28/03/2018 12:50, Niklas Cassel wrote:
> > PCI endpoint fixes to improve the way 64-bit BARs are handled.
> > 
> > 
> > There are still future improvements that could be made:
> > 
> > pci-epf-test.c always allocates space for
> > 6 BARs, even when using 64-bit BARs (which
> > really only requires us to allocate 3 BARs).
> > 
> > pcitest.sh will print "NOT OKAY" for BAR1,
> > BAR3, and BAR5 when using 64-bit BARs.
> > This could probably be improved to say
> > something like "N/A (64-bit BAR)".
> > 
> > Niklas Cassel (12):
> >   PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
> >   PCI: endpoint: Simplify epc->ops->set_bar()/pci_epc_set_bar()
> >   PCI: endpoint: Setting BAR_5 to 64-bits wide is invalid
> >   PCI: endpoint: Setting 64-bit/prefetch bit is invalid when IO is set
> >   PCI: endpoint: Setting a BAR size > 4 GB is invalid if 64-bit flag is
> >     not set
> >   PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs
> >     properly
> >   PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64 if a 64-bit BAR was
> >     set-up
> >   PCI: endpoint: Handle 64-bit BARs properly
> >   PCI: endpoint: Make epc->ops->clear_bar()/pci_epc_clear_bar() take
> >     struct *epf_bar
> >   PCI: endpoint: Make sure that BAR_5 does not have 64-bit flag set when
> >     clearing
> >   PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs
> >     properly
> >   misc: pci_endpoint_test: Handle 64-bit BARs properly
> > 
> >  drivers/misc/pci_endpoint_test.c              | 12 +++++----
> >  drivers/pci/cadence/pcie-cadence-ep.c         | 15 ++++++++---
> >  drivers/pci/dwc/pcie-designware-ep.c          | 36 +++++++++++++++++++++------
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 28 +++++++++++++--------
> >  drivers/pci/endpoint/pci-epc-core.c           | 32 +++++++++++++++---------
> >  drivers/pci/endpoint/pci-epf-core.c           |  4 +++
> >  include/linux/pci-epc.h                       | 11 ++++----
> >  include/linux/pci-epf.h                       |  2 ++
> >  8 files changed, 95 insertions(+), 45 deletions(-)
> > 
> 
> For the whole series:
> 
> Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Hello Gustavo,

Thanks a lot for testing!

Kind regards,
Niklas
