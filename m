Date: Mon, 30 Apr 2018 05:00:24 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sebastian Reichel <sre@kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20180430120024.GA11906@kroah.com>
References: <20180423130444.0672fb80@canb.auug.org.au>
 <20180430113410.6bb4d6ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430113410.6bb4d6ea@canb.auug.org.au>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:34:10AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 23 Apr 2018 13:04:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the usb tree got a conflict in:
> > 
> >   drivers/usb/core/hcd.c
> > 
> > between commit:
> > 
> >   63cb03f5c11e ("usb: core: split usb_phy_roothub_{init,alloc}")
> > 
> > from the usb.current tree and commit:
> > 
> >   bc40f5341741 ("USB: core: hcd: drop support for legacy phys")
> > 
> > from the usb tree.
> > 
> > I fixed it up (see below - though I am not sure what happens to the
> > phy_roothub allocation when usb_phy_roothub_init fails) and can carry
> > the fix as necessary. This is now fixed as far as linux-next is
> > concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the
> > conflicting tree to minimise any particularly complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc drivers/usb/core/hcd.c
> > index 0a42c5df3c0f,ac5bcf449d7d..000000000000
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@@ -2742,35 -2740,11 +2743,15 @@@ int usb_add_hcd(struct usb_hcd *hcd
> >   	int retval;
> >   	struct usb_device *rhdev;
> >   
> > - 	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->skip_phy_initialization) {
> > - 		struct usb_phy *phy = usb_get_phy_dev(hcd->self.sysdev, 0);
> > - 
> > - 		if (IS_ERR(phy)) {
> > - 			retval = PTR_ERR(phy);
> > - 			if (retval == -EPROBE_DEFER)
> > - 				return retval;
> > - 		} else {
> > - 			retval = usb_phy_init(phy);
> > - 			if (retval) {
> > - 				usb_put_phy(phy);
> > - 				return retval;
> > - 			}
> > - 			hcd->usb_phy = phy;
> > - 			hcd->remove_phy = 1;
> > - 		}
> > - 	}
> > - 
> >   	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
> >  -		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
> >  +		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
> > - 		if (IS_ERR(hcd->phy_roothub)) {
> > - 			retval = PTR_ERR(hcd->phy_roothub);
> > - 			goto err_phy_roothub_alloc;
> > - 		}
> > + 		if (IS_ERR(hcd->phy_roothub))
> > + 			return PTR_ERR(hcd->phy_roothub);
> >   
> >  +		retval = usb_phy_roothub_init(hcd->phy_roothub);
> >  +		if (retval)
> > - 			goto err_phy_roothub_alloc;
> > ++			return retval;
> >  +
> >   		retval = usb_phy_roothub_power_on(hcd->phy_roothub);
> >   		if (retval)
> >   			goto err_usb_phy_roothub_power_on;
> 
> This is now a conflict between the battery tree (since it merged the
> usb tree) and Linus' tree (since it merged the usb.current tree).

I have resolved the merge conflict in my tree.  If the battery tree
wants to pull again from my tree to resolve this for them, they are
welcome to :)

thanks,

greg k-h
