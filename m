Date: Sat, 19 May 2018 09:04:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbip: vhci_sysfs: fix potential Spectre v1
Message-ID: <20180519070407.GA2943@kroah.com>
References: <20180517201628.GA6090@embeddedor.com>
 <20180518134701.GA15598@kroah.com>
 <a6e9c635-5749-6fa0-7d1d-c1390d7f61ff@kernel.org>
 <3a169862-d723-88fb-05d6-f1ec80c8f7ab@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a169862-d723-88fb-05d6-f1ec80c8f7ab@embeddedor.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 05:27:22PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 05/18/2018 11:06 AM, Shuah Khan wrote:
> > On 05/18/2018 07:47 AM, Greg Kroah-Hartman wrote:
> > > On Thu, May 17, 2018 at 03:16:28PM -0500, Gustavo A. R. Silva wrote:
> > > > pdev_nr and rhport can be controlled by user-space, hence leading to
> > > > a potential exploitation of the Spectre variant 1 vulnerability.
> > > > 
> > > > This issue was detected with the help of Smatch:
> > > > drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
> > > > drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
> > > > drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
> > > > drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'
> > > > 
> > > > Fix this by sanitizing pdev_nr and rhport before using them to index
> > > > vhcis and vhci->vhci_hcd_ss->vdev respectively.
> > > > 
> > > > Notice that given that speculation windows are large, the policy is
> > > > to kill the speculation on the first load and not worry if it can be
> > > > completed with a dependent load/store [1].
> > > > 
> > > > [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Place the barriers into valid_port.
> > attach_store() doesn't call valid_port() - can you make the change to
> > have attach_store() call valid_port() to protect that code path.
> > 
> > > 
> > > Thanks for the change.  I'll wait for Shuah's ack/review before queueing
> > > this up just as she knows that codebase much better than anyone else.
> > > > 
> > 
> 
> Greg,
> 
> I've been talking with Dan Williams (intel) about this kind of issues [1]
> and it seems my original assumptions are correct. Hence, this patch is not
> useful and, in order to actually prevent speculation here we would need to
> pass the address of pdev_nr and rhport into valid_port, otherwise there may
> be speculation at drivers/usb/usbip/vhci_sysfs.c:235:
> 
>         if (!valid_port(pdev_nr, rhport))
>                 return -EINVAL;
> 
>         hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);

Ah, yes, sorry, you do need to pass the address through, my mistake
completely.  But the location for the checking is still the right place
to do it, so I was half-right :)

thanks

greg k-h
