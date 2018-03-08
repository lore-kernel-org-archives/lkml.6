Date: Thu, 8 Mar 2018 15:43:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Oliver Neukum <oneukum@suse.com>, johan@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 1/1] USB: serial: Add boundry check for read_urbs
 array access
Message-ID: <20180308234306.GA22931@kroah.com>
References: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20180307205840.GA6242@kroah.com>
 <0055f93b-8497-5dfc-4233-9cc72bf690fc@linux.intel.com>
 <1520499297.2983.3.camel@suse.com>
 <df24d0e5-73b1-3300-79a5-3dd7329f8a57@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df24d0e5-73b1-3300-79a5-3dd7329f8a57@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 03:29:48PM -0800, sathyanarayanan kuppuswamy wrote:
> 
> 
> On 03/08/2018 12:54 AM, Oliver Neukum wrote:
> > Am Mittwoch, den 07.03.2018, 13:41 -0800 schrieb sathyanarayanan
> > kuppuswamy       :
> > > On 03/07/2018 12:58 PM, Greg KH wrote:
> > > > So I don't see why your check is needed, what other code path would ever
> > > > call this function in a way that the bounds check would be needed?
> > > void usb_serial_generic_read_bulk_callback(struct urb *urb)
> > > 
> > > 385         for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i) {
> > > 386                 if (urb == port->read_urbs[i])
> > > 387                         break;
> > > 388         }
> > > 
> > > In here, after this for loop is done (without any matching urb), i value
> > > will be equal to ARRAY_SIZE(port->read_urbs). So there is a possibility
> > > of usb_serial_generic_submit_read_urb() getting called with this invalid
> > > index.
> > If this happens the function was called for a stray URB.
> > Your check comes to late. We have called set_bit with an invalid index
> > and other shit.
> > We definitely do not just want to return an error in that case.
> In that case do you think we should use some WARN_ON() for invalid index in
> usb_serial_generic_read_bulk_callback()?

No, again, how could that ever happen?

Don't add pointless error checking for things that are impossible to
ever hit :)

thanks,

greg k-h
