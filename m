Date: Fri, 6 Apr 2018 10:26:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Raghu Vatsavayi <rvatsavayi@caviumnetworks.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 4.4 10/43] net: cavium: liquidio: Avoid dma_unmap_single
 on uninitialized ndata
Message-ID: <20180406082650.GB12342@kroah.com>
References: <20170501212559.546911128@linuxfoundation.org>
 <20170501212559.952803810@linuxfoundation.org>
 <1494430234.3965.37.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494430234.3965.37.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 10, 2017 at 04:30:34PM +0100, Ben Hutchings wrote:
> On Mon, 2017-05-01 at 14:27 -0700, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > commit 8e6ce7ebeb34f0992f56de078c3744fb383657fa upstream.
> > 
> > The label lio_xmit_failed is used 3 times through liquidio_xmit() but it
> > always makes a call to dma_unmap_single() using potentially
> > uninitialized variables from "ndata" variable. Out of the 3 gotos, 2 run
> > after ndata has been initialized, and had a prior dma_map_single() call.
> > 
> > Fix this by adding a new error label: lio_xmit_dma_failed which does
> > this dma_unmap_single() and then processed with the lio_xmit_failed
> > fallthrough.
> > 
> > Fixes: f21fb3ed364bb ("Add support of Cavium Liquidio ethernet adapters")
> > Reported-by: coverity (CID 1309740)
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This is not a complete fix:
> 
> > ---
> >  drivers/net/ethernet/cavium/liquidio/lio_main.c |    9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > @@ -2823,7 +2823,7 @@ static int liquidio_xmit(struct sk_buff
> >  		if (!g) {
> >  			netif_info(lio, tx_err, lio->netdev,
> >  				   "Transmit scatter gather: glist null!\n");
> > -			goto lio_xmit_failed;
> > +			goto lio_xmit_dma_failed;
> >  		}
> >  
> >  		cmdsetup.s.gather = 1;
> [...]
> 
> This goto should not have been changed, as no DMA mapping has been
> attempted at this point in the function.
> 
> This seems to have been fixed upstream by commit 6a885b60dad2 "liquidio:
> Introduce new octeon2/3 header".  I leave it to you to work out how it
> should be fixed in 4.4-stable.

I've fixed this up "by hand" now, thanks for the review.

greg k-h
