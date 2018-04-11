Date: Wed, 11 Apr 2018 12:04:15 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Zhang, Ning A" <ning.a.zhang@intel.com>
Cc: "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 3 version of MKDEV: kernel, uapi, libc, why?
Message-ID: <20180411100415.GA26356@kroah.com>
References: <1523436662.1414.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523436662.1414.12.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 08:51:03AM +0000, Zhang, Ning A wrote:
> Hi, Greg, Thomas
> 
> I find 3 version of MKDEV (actually 2 + makedev)
> 
> in include/linux/kdev_t.h
> 
>     #define MINORBITS    	    20
>     #define MKDEV(ma,mi)    	    (((ma) << MINORBITS) | (mi))
> 
> in inlcude/uapi/linux/kdev_t.h
> 
>     #define MKDEV(ma,mi)    	    ((ma)<<8 | (mi))

Isn't history grand :)
Those are different because we increased the size way back in the 2.5
kernel (I think), so we had to do so in a way that did not break
userspace.

> in Android bionic
> 
>     #define makedev(__major, __minor) \
>       ( \
>         (((__major) & 0xfffff000ULL) << 32) | (((__major) & 0xfffULL) <<
>     8) | \
>         (((__minor) & 0xffffff00ULL) << 12) | (((__minor) & 0xffULL)) \
>       )

Fun stuff :)

> if I use mknod("renderD128", S_IFCHR|0666, MKDEV(226, 128));
> I get wrong device:
> crw-rw-rw- 1 root graphics 0, 57984 2011-11-11 11:20 renderD128
> 
> 
> if I use ("renderD128",S_IFCHR|0666, makedev(226, 128));
> I get right device.
> 
> but, when I use: mknod("card0", S_IFCHR|0666, MKDEV(226, 0));
> I can get right device.

Why are you calling 'mknod' at all?  The kernel does this automagically
for you already, in devtmpfs.  You should not have to do this on your
own ever.

Unless you are using a crazy Android system that doesn't use that
filesystem.  And if you are, go complain to those developers about it,
not much we can do from within the kernel.

And the answer is yes, use the right macro, for when you want to really
do this.  Your libc should provide the correct one, trust it.

good luck!

greg k-h
