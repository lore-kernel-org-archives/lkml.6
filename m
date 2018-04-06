Date: Fri, 6 Apr 2018 09:47:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 4.4 92/97] ip6_vti: adjust vti mtu according to mtu of
 lower device
Message-ID: <20180406074714.GA3127@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323094202.622913188@linuxfoundation.org>
 <1522800556.2654.158.camel@codethink.co.uk>
 <20180405173636.5765efcf@epycfail>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180405173636.5765efcf@epycfail>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 05:36:36PM +0200, Stefano Brivio wrote:
> On Wed, 04 Apr 2018 01:09:16 +0100
> Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> 
> > On Fri, 2018-03-23 at 10:55 +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Alexey Kodanev <alexey.kodanev@oracle.com>
> > > 
> > > 
> > > [ Upstream commit 53c81e95df1793933f87748d36070a721f6cb287 ]  
> > [...]
> > 
> > There are a couple of follow-ups to this:
> > 
> > c6741fbed6dc vti6: Properly adjust vti6 MTU from MTU of lower device
> > 7a67e69a339a vti6: Keep set MTU on link creation or change, validate it
> > 
> > The second of those will fail to build on branches older than 4.10
> > though.  It might be better to revert this one instead.
> 
> Thanks Ben for spotting this.
> 
> Actually,
>   53c81e95df17 ("ip6_vti: adjust vti mtu according to mtu of lower device")
> alone improves things already, despite being "fixed" by
>   c6741fbed6dc ("vti6: Properly adjust vti6 MTU from MTU of lower device")
> 
> With just 53c81e95df17 the MTU of a vti6 interface will be somewhat
> linked to the MTU of the lower layer, but will be underestimated.
> 
> With c6741fbed6dc the calculation of MTU from lower layer will be
> accurate instead.
> 
> However, without
>   7a67e69a339a ("vti6: Keep set MTU on link creation or change, validate it")
> but with
>   53c81e95df17 ("ip6_vti: adjust vti mtu according to mtu of lower device")
> assignment of MTU on link change is discarded, so this would actually
> introduce a bug.
> 
> Fixing
>   7a67e69a339a ("vti6: Keep set MTU on link creation or change, validate it")
> for 4.4 up to 4.9 is trivial, we simply need to adjust for the lack of
>   b96f9afee4eb ("ipv4/6: use core net MTU range checking")
> and reflect the change introduced by
>   f8a554b4aa96 ("vti6: Fix dev->max_mtu setting").
> 
> So, Greg, here comes the backport of
>   7a67e69a339a ("vti6: Keep set MTU on link creation or change, validate it")
> based on latest linux-4.4.y branch, in case you want to keep the existing
> change and add the follow-ups on top. Please let me know if I should submit
> it formally.

Ick, that's a mess.  How about I just revert this patch from the stable
trees, and then someone sends me either a list of git commits to apply,
or patches, for the different trees if it's really needed?

thanks,

greg k-h
