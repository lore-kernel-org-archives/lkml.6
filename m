Date: Thu, 22 Feb 2018 10:13:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: labbott@redhat.com, sumit.semwal@linaro.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] staging: android: ion: Avoid NULL point in error
 path
Message-ID: <20180222091359.GA13460@kroah.com>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
 <1518432194-41536-5-git-send-email-xieyisheng1@huawei.com>
 <20180216162732.GA18688@kroah.com>
 <844e0fa1-cd03-8e2e-4a3e-6021a79610b4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844e0fa1-cd03-8e2e-4a3e-6021a79610b4@huawei.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 04:59:27PM +0800, Yisheng Xie wrote:
> Hi Greg,
> 
> Sorry for late responds for I was on vacation.
> 
> On 2018/2/17 0:27, Greg KH wrote:
> > On Mon, Feb 12, 2018 at 06:43:09PM +0800, Yisheng Xie wrote:
> >> If we failed to create debugfs for ion at ion_device_create, the
> >> debug_root of ion_device will be NULL, and then when try to create debug
> >> file for shrinker of heap it will be create on the top of debugfs. If we
> >> also failed to create this the debug file, it call dentry_path to found
> >> the path of debug_root, then a NULL point will occur.
> >>
> >> Fix this by avoiding call dentry_path, but show the debug name only when
> >> failed to create debug file for shrinker.
> >>
> >> Acked-by: Laura Abbott <labbott@redhat.com>
> >> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> >> ---
> >>  drivers/staging/android/ion/ion.c | 10 +++-------
> >>  1 file changed, 3 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> >> index 57e0d80..4b69372 100644
> >> --- a/drivers/staging/android/ion/ion.c
> >> +++ b/drivers/staging/android/ion/ion.c
> >> @@ -564,13 +564,9 @@ void ion_device_add_heap(struct ion_heap *heap)
> >>  		debug_file = debugfs_create_file(debug_name,
> >>  						 0644, dev->debug_root, heap,
> >>  						 &debug_shrink_fops);
> >> -		if (!debug_file) {
> >> -			char buf[256], *path;
> >> -
> >> -			path = dentry_path(dev->debug_root, buf, 256);
> >> -			pr_err("Failed to create heap shrinker debugfs at %s/%s\n",
> >> -			       path, debug_name);
> >> -		}
> >> +		if (!debug_file)
> >> +			pr_err("Failed to create ion heap shrinker debugfs at %s\n",
> >> +			       debug_name);
> > 
> > Really we can just remove this, there's no need to check the return
> > value of this debugfs call at all, it doesn't matter.
> 
> Right, and I found that you have already patched this patch into next, should I send
> another version for the two patches your commented, or just send fix patches to fold?

Just send add-on patches, I can't "fold" anything as the commit is
already in the tree.

thanks,

greg k-h
