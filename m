Date: Wed, 23 May 2018 19:27:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
	vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
	jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 34/38] x86/intel_rdt: Create debugfs files for
 pseudo-locking testing
Message-ID: <20180523172725.GA15511@kroah.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
 <2da8730575c589eb7303c7b18a2721da40c446e2.1526987654.git.reinette.chatre@intel.com>
 <20180522194300.GA9656@kroah.com>
 <b32a1e6a-1675-0c96-69d3-75bc97a672b4@intel.com>
 <20180523080501.GA6822@kroah.com>
 <cf40175b-9068-650b-d1af-62762da8ad75@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf40175b-9068-650b-d1af-62762da8ad75@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:19:41AM -0700, Reinette Chatre wrote:
> Hi Greg,
> 
> On 5/23/2018 1:05 AM, Greg KH wrote:
> > On Tue, May 22, 2018 at 02:02:37PM -0700, Reinette Chatre wrote:
> >> On 5/22/2018 12:43 PM, Greg KH wrote:
> >>> On Tue, May 22, 2018 at 04:29:22AM -0700, Reinette Chatre wrote:
> >>>> +	ret = strtobool(buf, &bv);
> >>>> +	if (ret == 0 && bv) {
> >>>> +		ret = debugfs_file_get(file->f_path.dentry);
> >>>> +		if (unlikely(ret))
> >>>> +			return ret;
> >>>
> >>> Only ever use unlikely/likely if you can measure the performance
> >>> difference.  Hint, you can't do that here, it's not needed at all.
> >>
> >> Here my intention was to follow the current best practices and in the
> >> kernel source I am working with eight of the ten usages of
> >> debugfs_file_get() is followed by an unlikely(). My assumption was thus
> >> that this is a best practice. Thanks for catching this - I'll change it.
> > 
> > Really?  That's some horrible examples, any pointers to them?  I think I
> > need to do a massive sweep of the kernel tree and fix up all of this
> > crud so that people don't keep cut/paste the same bad code everywhere.
> 
> As you know debugfs_file_get() is a recent addition to the kernel,
> introduced in:
> commit e9117a5a4bf65d8e99f060d356a04d27a60b436d
> Author: Nicolai Stange <nicstange@gmail.com>
> Date:   Tue Oct 31 00:15:48 2017 +0100
> 
>     debugfs: implement per-file removal protection
> 
> Following this introduction, the same author modified the now obsolete
> calls of debugfs_use_file_start() to debugfs_file_get() in commits:
> 
> commit 7cda7b8f97da9382bb945d541a85cde58d5dac27
> Author: Nicolai Stange <nicstange@gmail.com>
> Date:   Tue Oct 31 00:15:51 2017 +0100
> 
>     IB/hfi1: convert to debugfs_file_get() and -put()
> 
> 
> commit 69d29f9e6a53559895e6f785f6cf72daa738f132
> Author: Nicolai Stange <nicstange@gmail.com>
> Date:   Tue Oct 31 00:15:50 2017 +0100
> 
>     debugfs: convert to debugfs_file_get() and -put()
> 
> 
> In the above two commits the usage of the new debugfs_file_get()
> primarily follows the pattern of:
> r = debugfs_file_get(d);
> if (unlikely(r))
> 
> Since the author of the new interface used the pattern above in the
> conversions I do not think it is unreasonable to find other developers
> following suit believing that it is a best practice.

Ah, that's where that pattern came from, thanks for finding it.  It was
a conversion of the "old" api in the IB code that was using likely(),
which in a way, did make sense to use (due to the way processors assume
0 is "true")

I'll work on cleaning all of these up on my next long plane ride, should
give me something to do :)

thanks,

greg k-h
