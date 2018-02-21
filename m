Date: Wed, 21 Feb 2018 14:42:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux- stable <stable@vger.kernel.org>,
	"yinbo.zhu" <yinbo.zhu@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4.9 77/77] mmc: sdhci-of-esdhc: fix the mmc error after
 sleep on ls1046ardb
Message-ID: <20180221134244.GA22041@kroah.com>
References: <20180221124432.172390020@linuxfoundation.org>
 <20180221124435.417056678@linuxfoundation.org>
 <CA+G9fYtrPk=yQ_bdRJDAPh7=DYDkRZ774u9oHNk-GuZXj97DUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtrPk=yQ_bdRJDAPh7=DYDkRZ774u9oHNk-GuZXj97DUQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 06:51:07PM +0530, Naresh Kamboju wrote:
> On 21 February 2018 at 18:19, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: yinbo.zhu <yinbo.zhu@nxp.com>
> >
> > commit f2bc600008bd6f7f5d0b6b56238d14f95cd454d2 upstream.
> >
> > When system wakes up from sleep on ls1046ardb, the SD operation fails
> > with mmc error messages since ESDHC_TB_EN bit couldn't be cleaned by
> > eSDHC_SYSCTL[RSTA]. It's proper to clean this bit in esdhc_reset()
> > rather than in probe.
> >
> > Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> > Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > ---
> >  drivers/mmc/host/sdhci-of-esdhc.c |   12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -489,10 +489,18 @@ static void esdhc_pltfm_set_bus_width(st
> >
> >  static void esdhc_reset(struct sdhci_host *host, u8 mask)
> >  {
> > +       u32 val;
> > +
> >         sdhci_reset(host, mask);
> >
> >         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> >         sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +
> > +       if (mask & SDHCI_RESET_ALL) {
> > +               val = sdhci_readl(host, ESDHC_TBCTL);
> > +               val &= ~ESDHC_TB_EN;
> > +               sdhci_writel(host, val, ESDHC_TBCTL);
> > +       }
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > @@ -584,10 +592,6 @@ static void esdhc_init(struct platform_d
> >         pltfm_host = sdhci_priv(host);
> >         esdhc = sdhci_pltfm_priv(pltfm_host);
> >
> > -       val = sdhci_readl(host, ESDHC_TBCTL);
> > -       val &= ~ESDHC_TB_EN;
> > -       sdhci_writel(host, val, ESDHC_TBCTL);
> > -
> >         host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
> >         esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
> >                              SDHCI_VENDOR_VER_SHIFT;
> >
> >
> 
> Found build failure on 4.9
> Please take a look
> 
>   CC      net/sunrpc/svcauth.o
> drivers/mmc/host/sdhci-of-esdhc.c: In function 'esdhc_reset':
> drivers/mmc/host/sdhci-of-esdhc.c:500:27: error: 'ESDHC_TBCTL'
> undeclared (first use in this function)
>    val = sdhci_readl(host, ESDHC_TBCTL);
>                            ^~~~~~~~~~~
> drivers/mmc/host/sdhci-of-esdhc.c:500:27: note: each undeclared
> identifier is reported only once for each function it appears in
> drivers/mmc/host/sdhci-of-esdhc.c:501:11: error: 'ESDHC_TB_EN'
> undeclared (first use in this function)
>    val &= ~ESDHC_TB_EN;
>            ^~~~~~~~~~~
> scripts/Makefile.build:293: recipe for target
> 'drivers/mmc/host/sdhci-of-esdhc.o' failed
> make[5]: *** [drivers/mmc/host/sdhci-of-esdhc.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
>   CC      net/sunrpc/svcauth_unix.o
>   CC      drivers/pci/host-bridge.o
>   CC      net/sunrpc/addr.o
>   CC      net/compat.o
>   CC      drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.o
> scripts/Makefile.build:544: recipe for target 'drivers/mmc/host' failed
> make[4]: *** [drivers/mmc/host] Error 2
> scripts/Makefile.build:544: recipe for target 'drivers/mmc' failed
> make[3]: *** [drivers/mmc] Error 2
> make[3]: *** Waiting for unfinished jobs....

Ugh, you are right, I wonder how this passed my build tests...

Anyway, this and the next mmc patch are now dropped from the 4.9.y tree,
thanks.

greg k-h
