Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeBGNFf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:05:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753630AbeBGNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:05:33 -0500
Subject: Re: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag
 FS_IMA_NO_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Dongsu Park <dongsu@kinvolk.io>
Cc: linux-kernel@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>
Date: Wed, 07 Feb 2018 08:05:21 -0500
In-Reply-To: <CAJfpegtVz=Y2yxkq26S4zp76suWFy4DsLqqDOrUCuc+VQJ=VVw@mail.gmail.com>
References: <cover.1517314847.git.dongsu@kinvolk.io>
         <86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
         <CAJfpegtVz=Y2yxkq26S4zp76suWFy4DsLqqDOrUCuc+VQJ=VVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020713-0012-0000-0000-000005AC4E47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020713-0013-0000-0000-00001928058A
Message-Id: <1518008721.13312.44.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 10:21 +0100, Miklos Szeredi wrote:
> On Tue, Jan 30, 2018 at 7:06 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
> > From: Alban Crequy <alban@kinvolk.io>
> >
> > This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
> > re-appraised and re-audited each time. Cached integrity results should
> > not be used.
> >
> > It is useful in FUSE because the userspace FUSE process can change the
> > underlying files at any time without notifying the kernel.
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
> >         .owner          = THIS_MODULE,
> >         .name           = "fuse",
> > -       .fs_flags       = FS_HAS_SUBTYPE,
> > +       .fs_flags       = FS_HAS_SUBTYPE | FS_IMA_NO_CACHE,
> >         .mount          = fuse_mount,
> >         .kill_sb        = fuse_kill_sb_anon,
> >  };
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 511fbaab..ced841ba 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2075,6 +2075,7 @@ struct file_system_type {
> >  #define FS_BINARY_MOUNTDATA    2
> >  #define FS_HAS_SUBTYPE         4
> >  #define FS_USERNS_MOUNT                8       /* Can be mounted by userns root */
> > +#define FS_IMA_NO_CACHE                16      /* Force IMA to re-measure, re-appraise, re-audit files */
> 
> I think it would be more logical to change the order of the patches
> (i.e. first patch adds this constant and the code handling it, and
> second patch just adds it to fuse's .fs_flags).
> 
> Otherwise
> 
> Acked-by:   Miklos Szeredi <mszeredi@redhat.com>

Sure, thank you!

Mimi 
