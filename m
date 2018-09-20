Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E36ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE66721521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="OMSfoMB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE66721521
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeITIWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:22:49 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:8030 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeITIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5654; q=dns/txt; s=iport;
  t=1537411308; x=1538620908;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=v5hQPKHK13h9y2rYw2GmKS1vQH4c6R4lgd/2rGqqE4w=;
  b=OMSfoMB5IdFMdClSOBhuQBjjY84altAYsk6VtYPW3/OUJXOSZLLyrkHo
   E0hDvR3YsyoATlCJwibZ11msRd13H+Qkq1P/QpCuWrkq5BsP1Q+zR8ken
   LeiFpZ4zpaQFqzBSP1nkKFI+Gf+PgQewFyTIV77q6cMxTphfTP05z7iRu
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AwAACzB6Nb/49dJa1cGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYFQgV4qgWQog3OIFYwygWgliGmNZIF6C4RsAoM7ITQYAQMBAQI?=
 =?us-ascii?q?BAQJtKEIMAYRpAQEBAQIBIwRFCgMQCw4KAgImAgJHEAYBEhuEewUIpDh7M4o?=
 =?us-ascii?q?fFHeJYheBQT+BRYJfhEchFoMBglcCiB0hEIYSjXwJkDoJAo8PlHGBQjiBVXA?=
 =?us-ascii?q?VeAtWgU6CJRd6AQGNOx8wiE+CUYJMAQE?=
X-IronPort-AV: E=Sophos;i="5.53,396,1531785600"; 
   d="scan'208";a="173602672"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 02:41:47 +0000
Received: from localhost ([10.156.154.30])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id w8K2flTq001574;
        Thu, 20 Sep 2018 02:41:47 GMT
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
Cc:     selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
Message-ID: <153741130781.7326.1773144725860636439@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Wed, 19 Sep 2018 19:41:47 -0700
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.30, [10.156.154.30]
X-Outbound-Node: rcdn-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (2018-09-19 12:00:33)
> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> > When files on NFSv4 server are not properly labeled (label doesn't match
> > a policy on a client) they will end up with unlabeled_t type which is
> > too generic. We would like to be able to set a default context per
> > mount. 'defcontext' mount option looks like a nice solution, but it
> > doesn't seem to be fully implemented for native labeling. Default
> > context is stored, but is never used.
> > =

> > The patch adds a fallback to a default context if a received context is
> > invalid. If the inode context is already initialized, then it is left
> > untouched to preserve a context set locally on a client.
> =

> Can you explain the use case further?  Why are you exporting a =

> filesystem with security labeling enabled to a client that doesn't =

> understand all of the labels used within it?  Why wouldn't you just =

> disable NFSv4 security labeling and/or use a regular context=3D mount to =

> assign a single context to all files in the mount?

Client and server are two embedded devices. They are part of a bigger
modular system and normally run the same SW version, so they understand
each others NFSv4 SELinux labels. But during migration from one SW
version to another a client and a server may run different versions for
some time.

The immediate issue I'm trying to address is a migration between
releases with and without SELinux policy. A client (with policy) gets
initial SID labels from a server (without policy). Those labels are
considered invalid, so files remain unlabeled. This also causes lots of
errors from nfs_setsecurity() in dmesg.

Using 'context=3D' at mount point level is an option, but in a normal case
when both sides have a policy we need more granular labels. It is
possible to detect a case when a server doesn't have a policy and
remount with 'context=3D', but this special case handling looks a bit
ugly. Having something like 'defcontext' whould allow to avoid this
special case and unconditionally assign default context to the
mountpoint.

'defcontext' may also help during migration between SELinux-enabled
releases if a new release introduces labels that are not recognized by
older release. In this case they can also fallback to defcontext.

> =

> To be clear, defcontext=3D doesn't work that way for local/FS_USE_XATTR =

> filesystems. The context specified by it is only used for:
> 1) files that don't implement the xattr inode operations at all,
> 2) files that lack a security.selinux xattr,
> 3) the MLS portion of the context if it was missing (strictly as a =

> legacy compatibility mechanism for RHEL4 which predated the enabling of =

> the MLS field/logic).
> =

> A file with a security.selinux xattr that is invalid under policy for =

> any reason other than a missing MLS field will be handled as having the =

> unlabeled context.

inode_doinit_with_dentry() invokes security_context_to_sid_default()
that invokes security_context_to_sid_core() with 'force' flag. Won't
sidtab_context_to_sid() in this case allocate a new SID for the invalid
xattr context instead of leaving it unlabeled?

> =

> So this would be a divergence in semantics for defcontext=3D between =

> local/FS_USE_XATTR and NFS/FS_USE_NATIVE filesystems.

Yeah, I also didn't like this semantics mismatch. But from another point
defcontext allows to assign a context to files that would otherwise be
unlabeled. Something similar I'd like to achive for NFS.

> =

> > =

> > Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> > ---
> >   security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
> >   1 file changed, 24 insertions(+), 1 deletion(-)
> > =

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index ad9a9b8e9979..f7debe798bf5 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(stru=
ct inode *inode)
> >    */
> >   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx,=
 u32 ctxlen)
> >   {
> > -     return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx=
, ctxlen, 0);
> > +     struct superblock_security_struct *sbsec;
> > +     struct inode_security_struct *isec;
> > +     int rc;
> > +
> > +     rc =3D selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx=
, ctxlen, 0);
> =

> In this case, we likely don't gain much by reusing =

> selinux_inode_setsecurity() here and could just inline the relevant =

> portion of it if we were to make this change.  Logically they mean =

> different things.
> =

> > +
> > +     /*
> > +      * In case of Native labeling with defcontext mount option fall b=
ack
> > +      * to a default SID if received context is invalid.
> > +      */
> > +     if (rc =3D=3D -EINVAL) {
> > +             sbsec =3D inode->i_sb->s_security;
> > +             if (sbsec->behavior =3D=3D SECURITY_FS_USE_NATIVE &&
> > +                 sbsec->flags & DEFCONTEXT_MNT) {
> > +                     isec =3D inode->i_security;
> > +                     if (!isec->initialized) {
> > +                             isec->sclass =3D inode_mode_to_security_c=
lass(inode->i_mode);
> > +                             isec->sid =3D sbsec->def_sid;
> > +                             isec->initialized =3D 1;
> > +                     }
> > +                     rc =3D 0;
> > +             }
> > +     }
> > +     return rc;
> >   }
> >   =

> >   /*
> > =

>=20
