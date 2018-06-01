Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeFAJZn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:25:43 -0400
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:10269 "EHLO
        mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeFAJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:25:40 -0400
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
To: "'tj@kernel.org'" <tj@kernel.org>
CC: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: RE: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Topic: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Index: AdP2gtQcFftKX6rKRguW2o+iRXsAXgAm4bKAAJr88AA=
Date: Fri, 1 Jun 2018 09:25:32 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B65779C@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
 <20180529162627.GH1351649@devbig577.frc2.facebook.com>
In-Reply-To: <20180529162627.GH1351649@devbig577.frc2.facebook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: 9b3207184fab408395c5922b35759b0d
x-originating-ip: [10.124.89.120]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of 'tj@kernel.org'
> Sent: Wednesday, May 30, 2018 1:26 AM
> To: Hatayama, Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>; Okajima,
> Toshiyuki <toshi.okajima@jp.fujitsu.com>;
> linux-kernel@vger.kernel.org; 'ebiederm@aristanetworks.com'
> <ebiederm@aristanetworks.com>
> Subject: Re: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
> 
> Hello,
> 
> On Mon, May 28, 2018 at 12:54:03PM +0000, Hatayama, Daisuke wrote:
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 89d1dc1..3aeeb7a 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1621,8 +1621,10 @@ static int kernfs_dir_fop_release(struct inode *inode,
> struct file *filp)
> >  static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
> >  	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
> >  {
> > +	struct kernfs_node *orig = pos;
> > +
> >  	pos = kernfs_dir_pos(ns, parent, ino, pos);
> > -	if (pos) {
> > +	if (pos && kernfs_sd_compare(pos, orig) <= 0) {
> 
> Hmm... the code seems a bit unintuitive to me and I wonder whether
> it's because there are two identical skipping loops in
> kernfs_dir_pos() and kernfs_dir_next_pos() and we're now trying to
> selectively disable one of them.  Wouldn't it make more sense to get
> rid of it from kernfs_dir_pos() and skip explicitly only when
> necessary?
> 

kernfs_dir_pos() checks if a kernfs_node object given as one of its
arguments is still active and if so returns it, or returns a
kernfs_node object that is most equal (possibly smaller and larger) to
the given object.

kernfs_dir_next_pos() returns a kernfs_node object that is next to the
object given by kernfs_dir_pos().

Two functions does different things and both need to skip inactive
nodes. I don't think it natural to remove the skip only from
kernfs_dir_pos().

OTOH, throughout getdents(), there is no case that the kernfs_node
object given to kernfs_dir_pos() is used afterwards in the
processing. So, is it enough to provide kernfs_dir_next_pos() only?
Then, the skip code is now not duplicated.

The patch below is my thought. How do you think?

But note that this patch has some bug so that system boot get hang
without detecting root filesystem disk :) I'm debugging this now.

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc1..140706f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1584,9 +1584,11 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
        return 0;
 }

-static struct kernfs_node *kernfs_dir_pos(const void *ns,
+static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
        struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
 {
+       struct kernfs_node *orig = pos;
+
        if (pos) {
                int valid = kernfs_active(pos) &&
                        pos->parent == parent && hash == pos->hash;
@@ -1608,7 +1610,9 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
                }
        }
        /* Skip over entries which are dying/dead or in the wrong namespace */
-       while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
+       while (pos && (!kernfs_active(pos) ||
+                      (!orig || kernfs_sd_compare(pos, orig) <= 0) ||
+                      pos->ns != ns)) {
                struct rb_node *node = rb_next(&pos->rb);
                if (!node)
                        pos = NULL;
@@ -1618,22 +1622,6 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
        return pos;
 }

-static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
-       struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
-{
-       pos = kernfs_dir_pos(ns, parent, ino, pos);
-       if (pos) {
-               do {
-                       struct rb_node *node = rb_next(&pos->rb);
-                       if (!node)
-                               pos = NULL;
-                       else
-                               pos = rb_to_kn(node);
-               } while (pos && (!kernfs_active(pos) || pos->ns != ns));
-       }
-       return pos;
-}
-
 static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 {
        struct dentry *dentry = file->f_path.dentry;
@@ -1648,7 +1636,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
        if (kernfs_ns_enabled(parent))
                ns = kernfs_info(dentry->d_sb)->ns;

-       for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
+       for (pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos);
             pos;
             pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
                const char *name = pos->name;

Thanks.
HATAYAMA, Daisuke
