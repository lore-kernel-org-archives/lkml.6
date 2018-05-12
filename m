Date: Sat, 12 May 2018 21:44:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4.4 15/50] s390/alternative: use a copy of the facility
 bit mask
Message-ID: <20180512194436.GA22201@kroah.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.637526548@linuxfoundation.org>
 <ded98294-4341-2c96-7ed7-115721af8164@suse.cz>
 <20180504221808.GB24813@kroah.com>
 <20180507080707.2a41ae28@mschwideX1>
 <20180508072055.GD17166@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508072055.GD17166@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 09:20:55AM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 07, 2018 at 08:07:07AM +0200, Martin Schwidefsky wrote:
> > On Fri, 4 May 2018 15:18:08 -0700
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Fri, May 04, 2018 at 09:37:20AM +0200, Jiri Slaby wrote:
> > > > On 04/27/2018, 03:58 PM, Greg Kroah-Hartman wrote:  
> > > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > 
> > > > > 
> > > > > [ Upstream commit cf1489984641369611556bf00c48f945c77bcf02 ]
> > > > > 
> > > > > To be able to switch off specific CPU alternatives with kernel parameters
> > > > > make a copy of the facility bit mask provided by STFLE and use the copy
> > > > > for the decision to apply an alternative.  
> > > > ...  
> > > > > --- a/arch/s390/include/asm/facility.h
> > > > > +++ b/arch/s390/include/asm/facility.h
> > > > > @@ -13,6 +13,24 @@
> > > > >  
> > > > >  #define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */  
> > > > 
> > > > I wonder if the below (plus __test_facility) is correct in 4.4, given
> > > > MAX_FACILITY_BIT is defined as such and not as sizeof(stfle_fac_list *
> > > > 8) as in upstream?  
> > > 
> > > I'm going to defer to Marin here, as he did the backport...
> > > Martin?
> > 
> > Good catch. With MAX_FACILITY_BIT == 2048 and the patch applied the result
> > for a test_facility/__test_facility call with a facility number >= 1024
> > would give an incorrect result. Fortunately there are no such calls in
> > the current 4.4 kernel source. And there are no facilities defined with
> > bit numbers this large, so even out-of-tree code would not do this if
> > it is sane.
> > 
> > To correct this the MAX_FACILITY_BIT define needs to be reduced to 1024
> > which would require the patch pointed out be Heiko:
> > 
> > commit 6f5165e864d240d15675cc2fb5a369d57e1f60d0
> > Author: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Date:   Mon Mar 20 14:29:50 2017 +0100
> > 
> >     s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT
> > 
> > I would say yes, it *does* make sense to include this patch even if it
> > does not fix anything.
> 
> Ok, I've now queued this up for 4.4.y and 4.9.y, thanks!

It breaks the build on 4.4.y, so I'm dropping it :(

If you think it's needed there, a working version would be nice :)

thanks,

greg k-h
