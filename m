Date: Fri, 6 Apr 2018 09:07:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 092/134] cpufreq: Fix governor module removal race
Message-ID: <20180406070727.GD8416@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171902.578082436@linuxfoundation.org>
 <1522616201.2654.79.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522616201.2654.79.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 01, 2018 at 09:56:41PM +0100, Ben Hutchings wrote:
> On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > 
> > 
> > [ Upstream commit a8b149d32b663c1a4105273295184b78f53d33cf ]
> [...]
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -551,6 +551,8 @@ static int cpufreq_parse_governor(char *
> >  			*governor = t;
> >  			err = 0;
> >  		}
> > +		if (t && !try_module_get(t->owner))
> > +			t = NULL;
> 
> This won't work because t is dead after this point.  The fix appears to
> depend on:
> 
> commit 045149e6a22119e5bf0d16a0b24a4173a2abb71d
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Thu Nov 23 01:23:16 2017 +0100
> 
>     cpufreq: Clean up cpufreq_parse_governor()
> 
> which moves the assignment to *governor further down.

Ick, this also didn't make it into 4.9.y so I'm just reverting it from
everywhere.

thanks for the review!

greg k-h
