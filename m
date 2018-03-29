Date: Thu, 29 Mar 2018 18:39:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] virt: vbox: Use __get_free_pages instead of kmalloc
 for DMA32 memory
Message-ID: <20180329163936.GA4579@kroah.com>
References: <20180329112116.26488-1-hdegoede@redhat.com>
 <20180329112116.26488-2-hdegoede@redhat.com>
 <20180329115831.GD6734@kroah.com>
 <435d7f8e-9247-4523-5ab4-7c91cfa54475@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435d7f8e-9247-4523-5ab4-7c91cfa54475@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:42:59PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 29-03-18 13:58, Greg Kroah-Hartman wrote:
> > On Thu, Mar 29, 2018 at 01:21:15PM +0200, Hans de Goede wrote:
> > > It is not possible to get DMA32 zone memory through kmalloc,
> > 
> > Why can't we just fix that issue here instead?
> 
> AFAIK that would go against the design of the whole slab
> allocator, it creates buckets (kmem_cache objects) for
> differently sized allocs out of the normal memzone,
> you cannot select what memzone you want with kmalloc,
> if you need to specify a memzone you need to use either
> dma specific malloc functions such as the dmapool.h
> functions, or directly call alloc_pages / get_free_pages.
> 
> A quick grep on the drivers dir shows 50 files using
> GFP_DMA32 and almost all are passing it to alloc_page
> or __get_page.

If there are 50 users of such an api, why is the mm core not handling
this for drivers automatically?  It seems harsh that they all have to do
this type of allocation on their own.

> I do actually see 2 drivers which are passing it to
> kmalloc, which as said will not work I will mail the
> maintainers of those about this.

If they haven't noticed that their hardware isn't working, perhaps they
don't need to set that flag?  :)

thanks,

greg k-h
