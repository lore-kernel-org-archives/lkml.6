Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeBBPeJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:34:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752064AbeBBPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:33:57 -0500
Subject: Re: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag
 FS_IMA_NO_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>, linux-kernel@vger.kernel.org
Date: Fri, 02 Feb 2018 10:33:44 -0500
In-Reply-To: <1517584816.3171.61.camel@linux.vnet.ibm.com>
References: <cover.1517314847.git.dongsu@kinvolk.io>
         <86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
         <1517584816.3171.61.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18020215-0016-0000-0000-0000051ED0DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020215-0017-0000-0000-0000285B79E9
Message-Id: <1517585624.3171.64.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 10:20 -0500, Mimi Zohar wrote:
> Hi Miklos,
> 
> On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
> > From: Alban Crequy <alban@kinvolk.io>
> > 
> > This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
> > re-appraised and re-audited each time. Cached integrity results should
> > not be used.
> > 
> > It is useful in FUSE because the userspace FUSE process can change the
> > underlying files at any time without notifying the kernel.
> 
> Both IMA-measurement and IMA-appraisal cache the integrity results and
> are dependent on the kernel to detect when a file changes in order to
> clear the cached info and force the file to be re-evaluated.  This
> detection was dependent on i_version changing.  For filesystems that
> do not support i_version, remote or fuse filesystems, where the kernel
> does not detect the file change, the file was measured and the
> signature evaluated just once.
> 
> With commit a2a2c3c8580a ("ima: Use i_version only when filesystem
> supports it"), which is being upstreamed in this open window,
> i_version is considered an optimization.  If i_version is not enabled,
> either because the local filesystem does not support it or the
> filesystem wasn't mounted with i_version, the file will now always be
> re-evaluated.
> 
> That patch does not address FUSE or remote filesystems, as the kernel
> does not detect the change.  Further, even if the kernel could detect
> the change, FUSE filesystems by definition are untrusted.
> 
> The original patches addressed FUSE filesystems, by defining a new IMA
> policy option, forcing the file to be re-evaluated based on the
> filesystem magic number.  All of the changes were in the IMA
> subsystem.  These patches are the result of Christoph's comment on the
> original patches saying, "ima has no business looking at either the
> name _or_ the magic number."
> 
> Your help in resolving this problem is much appreciated!

Meaning, can you ack the fuse flag addition so we can take the series
through the IMA tree?

thanks,

Mimi

> 
> > 
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Acked-by: "Serge E. Hallyn" <serge@hallyn.com>
> > Acked-by: Seth Forshee <seth.forshee@canonical.com>
> > Tested-by: Dongsu Park <dongsu@kinvolk.io>
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
> > ---
> >  fs/fuse/inode.c    | 2 +-
> >  include/linux/fs.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 624f18bb..0a9e5164 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1205,7 +1205,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
> >  static struct file_system_type fuse_fs_type = {
> >  	.owner		= THIS_MODULE,
> >  	.name		= "fuse",
> > -	.fs_flags	= FS_HAS_SUBTYPE,
> > +	.fs_flags	= FS_HAS_SUBTYPE | FS_IMA_NO_CACHE,
> >  	.mount		= fuse_mount,
> >  	.kill_sb	= fuse_kill_sb_anon,
> >  };
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 511fbaab..ced841ba 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2075,6 +2075,7 @@ struct file_system_type {
> >  #define FS_BINARY_MOUNTDATA	2
> >  #define FS_HAS_SUBTYPE		4
> >  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> > +#define FS_IMA_NO_CACHE		16	/* Force IMA to re-measure, re-appraise, re-audit files */
> >  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
> >  	struct dentry *(*mount) (struct file_system_type *, int,
> >  		       const char *, void *);
> 
