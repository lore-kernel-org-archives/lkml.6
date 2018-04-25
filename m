Date: Wed, 25 Apr 2018 10:48:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180425084819.GA13295@kroah.com>
References: <20180424163458.11947-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 06:34:51PM +0200, Johan Hovold wrote:
> This series adds a new subsystem for GNSS receivers (e.g. GPS
> receivers).

YEAH!!!!

Thanks so much for doing this, great work!

> While GNSS receivers are typically accessed using a UART interface they
> often also support other I/O interfaces such as I2C, SPI and USB, while
> yet other devices use iomem or even some form of remote-processor
> messaging (rpmsg).
>     
> The new GNSS subsystem abstracts the underlying interface and provides a
> new "gnss" class type, which exposes a character-device interface (e.g.
> /dev/gnss0) to user space. This allows GNSS receivers to have a
> representation in the Linux device model, something which is important
> not least for power management purposes and which also allows for easy
> detection and (eventually) identification of GNSS devices.
> 
> Note that the character-device interface provides raw access to whatever
> protocol the receiver is (currently) using, such as NMEA 0183, UBX or
> SiRF Binary. These protocols are expected to be continued to be handled
> by user space for the time being, even if some hybrid solutions are also
> conceivable (e.g. to have kernel drivers issue management commands).
> 
> This will still allow for better platform integration by allowing GNSS
> devices and their resources (e.g. regulators and enable-gpios) to be
> described by firmware and managed by kernel drivers rather than
> platform-specific scripts and services.
>     
> While the current interface is kept minimal, it could be extended using
> IOCTLs, sysfs or uevents as needs and proper abstraction levels are
> identified and determined (e.g. for device and feature identification).
> 
> Another possible extension is to add generic 1PPS support.
> 
> I decided to go with a custom character-device interface rather than
> pretend that these abstract GNSS devices are still TTY devices (e.g.
> /dev/ttyGNSS0). Obviously, modifying line settings or reading modem
> control signals does not make any sense for a device using, say, a
> USB (not USB-serial) or iomem interface. This also means, however, that
> user space would no longer be able to set the line speed to match a new
> port configuration that can be set using the various GNSS protocols when
> the underlying interface is indeed a UART; instead this would need to be
> taken care of by the driver.
> 
> Also note that writes are always synchronous instead of requiring user
> space to call tcdrain() after every command.
> 
> This all seems to work well-enough (e.g. with gpsd), but please let me
> know if I've overlooked something which would indeed require a TTY
> interface instead.
> 
> As proof-of-concept I have implemented drivers for receivers based on
> two common GNSS chipsets (SiRFstar and u-blox), but due to lack of
> hardware these have so far only been tested using mockup devices and a
> USB-serial-based GPS device (using out-of-tree code). [ Let me know if
> you've got any evalutation kits to spare. ]
> 
> Finally, note that documentation (including kerneldoc) remains to be
> written, but hopefully this will not hinder review given that the
> current interfaces are fairly self-describing.

Is this just a RFC, or a "here's a first cut at submitting this, review
it please!" submission?  I'm glad to review if you think it's worth it
at this point.

thanks,

greg k-h
