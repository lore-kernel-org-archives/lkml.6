Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeESLj0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:39:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752129AbeESLjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:39:24 -0400
Date: Sat, 19 May 2018 13:39:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] procfs: fix mmap() for /proc/vmcore
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
 <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
 <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
 <CA+55aFwxEiiAC+dMMVqQ4igqb7rmn23Bq=BM8fqU=MFRWF1JSw@mail.gmail.com>
 <20180519034338.GV30522@ZenIV.linux.org.uk>
 <CA+55aFyHLFnGv8yFJs7-vGVe6tDeDAbSJ6=09iTqsegRZN_nGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyHLFnGv8yFJs7-vGVe6tDeDAbSJ6=09iTqsegRZN_nGw@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 18051911-0008-0000-0000-000004F83B63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051911-0009-0000-0000-00001E8CBCAD
Message-Id: <your-ad-here.call-01526729953-ext-6746@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805190112
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:12:56PM -0700, Linus Torvalds wrote:
> On Fri, May 18, 2018 at 8:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Not quite.  The things like
> >          if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
> >                  return 0;
> >          iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
> > protect most of the regular files (see mm/filemap.c).  And for devices
> (which is
> > where the majority of crap ->read()/->write() is) it's obviously not
> applicable -
> > ->s_maxbytes of *what*?
> 
> Yeah that "s_maxbytes of what" is I think the real issue. We should never
> have made s_maxbytes be super-block specific: we should have made it be
> per-inode, and then have inode_init_always() initialize it using something
> like the file_mmap_size_max() logic.
> 
> (So we'd still have a "sb_maxbytes" that filesystems would fill in, but it
> would only be used as a "fill in inode value for regular files for this
> superblock").
> 
> Then we could actually protect read/write properly, because many of the
> nasty bugs have been in character device drivers.
> 
> Oh well. It would still be a good thing to do some day, I suspect, but it's
> clearly not the case now, and so s_maxbytes actually has much less coverage
> than I was hoping for.
> 
> (And thus also the problems with /proc/vmcore - it never saw s_maxbytes
> limits before).
> 
> Oh, well. The lack of any meaningful s_maxbytes coverage for proc obviously
> means that my objections against Vasily's patch are mostly invalid. Even if
> /proc does use "generic_file_llseek()" a lot and that should limit things
> to 4G offsets, you can just use pread64/pwrite64 to see if you can screw up
> the offset.
> 
> I'd still prefer to limit the damage to just "vmcore".
> 
> Something like the below COMPLETELY UNTESTED patch? Vasily?

Would work, but file_mmap_size_max first checks
	if (S_ISREG(inode->i_mode))
		return inode->i_sb->s_maxbytes;
before
	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
		return 0;
so, as it is this patch does not fix the issue.

>              Linus
>
>  fs/proc/vmcore.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index a45f0af22a60..83278c547127 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -491,7 +491,15 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
>  }
>  #endif
>  
> +/* Mark vmcore as being able and willing to do 64-bit mmaps */
> +static int vmcore_open(struct inode *inode, struct file *file)
> +{
> +	file->f_mode |= FMODE_UNSIGNED_OFFSET;
> +	return 0;
> +}
> +
>  static const struct file_operations proc_vmcore_operations = {
> +	.open		= vmcore_open,
>  	.read		= read_vmcore,
>  	.llseek		= default_llseek,
>  	.mmap		= mmap_vmcore,
