Date: Thu, 22 Mar 2018 23:39:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Darren Hart <dvhart@infradead.org>
Cc: Vadim Pasternak <vadimp@mellanox.com>, andy.shevchenko@gmail.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 2/4] platform/x86: mlx-platform: Add differed bus
 functionality
Message-ID: <20180322223932.GB17542@kroah.com>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
 <1518559776-188942-3-git-send-email-vadimp@mellanox.com>
 <20180321225818.GA23931@fury>
 <20180322090451.GA22313@kroah.com>
 <20180322221840.GC24138@fury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322221840.GC24138@fury>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 03:18:40PM -0700, Darren Hart wrote:
> On Thu, Mar 22, 2018 at 10:04:51AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 21, 2018 at 03:58:18PM -0700, Darren Hart wrote:
> > > On Tue, Feb 13, 2018 at 10:09:34PM +0000, Vadim Pasternak wrote:
> > > > Add deferred bus functionality in order to enforce probing flow execution
> > > > order. Driver mlx-platform activates platform driver i2c-mux-reg, which
> > > > creates busses infrastructure, after that it activates mlxreg-hotplug
> > > > driver, which uses these busses, for connecting devices. The possible
> > > > miss-ordering can happened, for example in case the probing routine of
> > > > mlxreg-hotplug is already started execution, while i2c-mux-reg probing
> > > > routine is not completed yet. In such situation the first one could
> > > > attempt to connect device to adapter number, which is not created yet.
> > > > And as a result this connection will fail. In order to ensure the order of
> > > > probing execution on mlxreg-hotplug probe routine will be deferred until
> > > > all the busses is not created by  probe routine of i2c-mux-reg.
> > > > In order to ensure the flow order, mlx-platform driver passes the highest
> > > > bus number to the mlxreg-hotplug platform data, which in their turn could
> > > > wait in the deferred state, until all the necessary buses topology is not
> > > > exist.
> > > 
> > > Vadim,
> > > 
> > > I've got part way through a review of this series several times, and keep
> > > running out of time trying to determine if the solution is appropriate
> > > for the problem.
> > > 
> > > The deferred probing waiting for the i2c bus to be available seems like
> > > something we might be able to handle more elegantly with:
> > > 
> > > 1) request_module() in the platform driver
> > > 2) careful use of init levels (subsys, device, late)
> > > 
> > > This isn't something I'm well versed in - so I'll reach out here for
> > > some advice from Greg and the i2c maintainer, Wolfram, and list (added
> > > to Cc).
> > 
> > deferred device probe?
> > 
> 
> This patch series adds the following, which I believe is what you're referring
> to Greg? :
> 
> +       /* Defer probing if the necessary adapter is not configured yet. */
> +       deferred_adap = i2c_get_adapter(pdata->deferred_nr);
> +       if (!deferred_adap)
> +               return -EPROBE_DEFER;
> 
> This is the preferred approach? Have the platform driver define the expected
> adapter number, and then defer until that becomes available?

Yes, that is what that interface is for, so it should work like this.

But someone should test of course :)

greg k-h
