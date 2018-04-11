Date: Wed, 11 Apr 2018 14:11:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>,
	davem@davemloft.net, johannes.berg@intel.com, jikos@kernel.org,
	stephen@networkplumber.org, Jiri Slaby <JSlaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: ipwireless: Replace GFP_ATOMIC with GFP_KERNEL in
 ipwireless_network_create
Message-ID: <20180411121103.GA2394@kroah.com>
References: <1523349106-29584-1-git-send-email-baijiaju1990@gmail.com>
 <20180411110945.GA21272@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411110945.GA21272@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 01:09:45PM +0200, David Sterba wrote:
> On Tue, Apr 10, 2018 at 04:31:46PM +0800, Jia-Ju Bai wrote:
> > ipwireless_network_create() is never called in atomic context.
> > 
> > The call chain ending up at ipwireless_network_create() is:
> > [1] ipwireless_network_create() <- config_ipwireless() <- 
> > 	ipwireless_attach()
> > ipwireless_attach() is only set as ".probe" in struct pcmcia_driver.
> > 
> > Despite never getting called from atomic context,
> > ipwireless_network_create() calls kzalloc() with GFP_ATOMIC,
> > which does not sleep for allocation.
> > GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> > which can sleep and improve the possibility of sucessful allocation.
> > 
> > This is found by a static analysis tool named DCNS written by myself.
> > And I also manually check it.
> > 
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
> We don't have any other patches queued for this driver so it would be
> best if this patch goes via net or Greg's tree.

I can take it, after 4.17-rc1 is out, thanks!

greg k-h
