Date: Thu, 8 Mar 2018 06:01:57 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] USB: serial: Add boundry check for read_urbs
 array access
Message-ID: <20180308140157.GA28178@kroah.com>
References: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20180307205840.GA6242@kroah.com>
 <0055f93b-8497-5dfc-4233-9cc72bf690fc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0055f93b-8497-5dfc-4233-9cc72bf690fc@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 01:41:51PM -0800, sathyanarayanan kuppuswamy wrote:
> 
> 
> On 03/07/2018 12:58 PM, Greg KH wrote:
> > On Wed, Mar 07, 2018 at 12:23:56PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > In usb_serial_generic_submit_read_urb() function we are accessing the
> > > port->read_urbs array without any boundry checks. This might lead to
> > > kernel panic when index value goes above array length.
> > > 
> > > One posible call path for this issue is,
> > > 
> > > usb_serial_generic_read_bulk_callback()
> > > {
> > >   ...
> > >   if (!port->throttled) {
> > > 	usb_serial_generic_submit_read_urb(port, i, GFP_ATOMIC);
> > >   ...
> > > }
> > How does i ever get to be greater than the array size here in this
> > function?  It directly came from looking in that array in the first
> > place :)
> > 
> > So I don't see why your check is needed, what other code path would ever
> > call this function in a way that the bounds check would be needed?
> void usb_serial_generic_read_bulk_callback(struct urb *urb)
> 
> 385         for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i) {
> 386                 if (urb == port->read_urbs[i])
> 387                         break;
> 388         }
> 
> In here, after this for loop is done (without any matching urb),

How is it possible to not have any matching urbs here?  If that ever
happens, we have much worse problems happening in the USB stack :)

thanks,

greg k-h
