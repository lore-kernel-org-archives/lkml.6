Date: Fri, 27 Apr 2018 13:47:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inode: debugfs_create_dir uses mode permission from
 parent
Message-ID: <20180427114704.GA19599@kroah.com>
References: <20180427080712.2380-1-tmricht@linux.ibm.com>
 <20180427082737.GA25242@kroah.com>
 <504bade7-7b06-c9d4-e4e2-736b9ee5a313@linux.ibm.com>
 <20180427100600.GB12941@kroah.com>
 <82a7c2a7-f8f4-0e59-a770-c3e191f9d3de@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82a7c2a7-f8f4-0e59-a770-c3e191f9d3de@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 01:30:53PM +0200, Thomas-Mich Richter wrote:
> On 04/27/2018 12:06 PM, Greg KH wrote:
> > On Fri, Apr 27, 2018 at 11:14:26AM +0200, Thomas-Mich Richter wrote:
> >> On 04/27/2018 10:27 AM, Greg KH wrote:
> >>> On Fri, Apr 27, 2018 at 10:07:12AM +0200, Thomas Richter wrote:
> >>>> Currently function debugfs_create_dir() creates a new
> >>>> directory in the debugfs (usually mounted /sys/kernel/debug)
> >>>> with permission rwxr-xr-x. This is hard coded.
> >>>>
> >>>> Change this to use the parent directory permission.
> >>>>
> >>>> Fixes: edac65eaf8d5c ("debugfs: take mode-dependent parts of debugfs_get_inode() into callers")
> >>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> ---
> >>>>  fs/debugfs/inode.c | 5 ++++-
> >>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> >>>> index 13b01351dd1c..80618330d86a 100644
> >>>> --- a/fs/debugfs/inode.c
> >>>> +++ b/fs/debugfs/inode.c
> >>>> @@ -512,7 +512,10 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
> >>>>  	if (unlikely(!inode))
> >>>>  		return failed_creating(dentry);
> >>>>  
> >>>> -	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> >>>> +	if(!parent)
> >>>> +		parent = debugfs_mount->mnt_root;
> >>>> +	inode->i_mode = S_IFDIR | (d_inode(parent)->i_mode
> >>>> +				   & (S_IRWXU | S_IRWXG));
> >>>>  	inode->i_op = &simple_dir_inode_operations;
> >>>>  	inode->i_fop = &simple_dir_operations;
> >>>>  
> >>>
> >>> This looks ok, but is it going to change the permissions of existing
> >>> stuff in ways that might breaks things, right?
> >>
> >> Right, but debugfs is usually mounted on /sys/kernel/debug with
> >> permissions rwx to root owner. It can be changed after the mount, of course.
> >> Unless this is done, the directory permissions for /sys/kernel/debug
> >> will stop any descend regardless  of the subdirectory permissions.
> >>
> >>>
> >>> Have you done a before/after comparison?
> >>
> >> I have tested this patch on my Linux 4.17.0rc2 kernel on s390.
> >> That worked well, I have not tested other systems.
> > 
> > What do you mean by "worked well"?  What were the full tree differences
> > between before and after?  You should be able to get this by using:
> > 	tree -dp /sys/kernel/debug/
> > and then doing a diff on the two files.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Ok, this is the tree output
> 
> Before the patch:
> root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/ 
> /sys/kernel/debug/
> ├── [drwxr-xr-x]  bdi
> ├── [drwxr-xr-x]  block
> ├── [drwxr-xr-x]  dasd
> ├── [drwxr-xr-x]  device_component
> ├── [drwxr-xr-x]  extfrag
> ├── [drwxr-xr-x]  hid
> ├── [drwxr-xr-x]  kprobes
> ├── [drwxr-xr-x]  kvm
> ├── [drwxr-xr-x]  memblock
> ├── [drwxr-xr-x]  pm_qos
> ├── [drwxr-xr-x]  qdio
> ├── [drwxr-xr-x]  s390
> ├── [drwxr-xr-x]  s390dbf
> └── [drwx------]  tracing
> 
> 14 directories
> 
> After the patch:
> [root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/
> sys/kernel/debug/
> ├── [drwx------]  bdi
> ├── [drwx------]  block
> ├── [drwx------]  dasd
> ├── [drwx------]  device_component
> ├── [drwx------]  extfrag
> ├── [drwx------]  hid
> ├── [drwx------]  kprobes
> ├── [drwx------]  kvm
> ├── [drwx------]  memblock
> ├── [drwx------]  pm_qos
> ├── [drwx------]  qdio
> ├── [drwx------]  s390
> ├── [drwx------]  s390dbf
> └── [drwx------]  tracing
> 
> 14 directories
> [root@s8360047 ~]#
> 
> I attached the diff of the full tree before and after the patch.

"diff -u" is your friend, this isn't the 1990's anymore :)

Anyway, why just look at the root directory here?  Your patch changes
more than just that, right?

Also, always run checkpatch.pl on your patches before a grumpy
maintainer tells you to run checkpatch.pl...

thanks,

greg k-h
