Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77614ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1140921525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Qa1C6b6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1140921525
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbeIUEpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:45:17 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:57006 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIUEpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=10615; q=dns/txt;
  s=iport; t=1537484366; x=1538693966;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=e/Q8UJlButeN7RH58xqvm4tsPy0hsmGXOKlVp8LDhAo=;
  b=Qa1C6b6/YEuXZyDRwsRXA+qwNUVmEB0ErdY3Am43v2J+qZ6dJL0u/qgG
   RVXe2TMcuT7gaP2i74cb8ljGx/lpD86xIby8dYVxoOKx/3iQtKPSGsKlF
   e1ZCojOh8cUD2gu7rsiXtkqEvlA8VPtsbvJ91eakGhaH40+vcwouJ4mjp
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AlAAD8JaRb/4gNJK1bGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUYIIZU0yKINziBWOGiWIaYRiiQOBegsjhEkCg0IhNBgBAwE?=
 =?us-ascii?q?BAgEBAm0cDEIOAYRnAQEBAQIBIwRFCgMQCw4KAgImAgJHEAYBEhuDB4F0BQg?=
 =?us-ascii?q?Pozp7M4oIBRR3iWQXgUE/gUWCX4MbBBiBECEWgwGCVwKIIiABEIYUjThPCYZ?=
 =?us-ascii?q?DiXgJAoE5h1WGCYhogwqJA4FCOIFVcBV4C1aBToIlF4NGinIfMAGGEoUwgkw?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.54,282,1534809600"; 
   d="scan'208";a="174539431"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 22:59:25 +0000
Received: from localhost ([10.154.176.47])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTP id w8KMxPBR023457;
        Thu, 20 Sep 2018 22:59:25 GMT
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
Cc:     selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
 <153741130781.7326.1773144725860636439@takondra-t460s>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
Message-ID: <153748436388.5590.1406237328277739821@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Thu, 20 Sep 2018 15:59:23 -0700
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.176.47, [10.154.176.47]
X-Outbound-Node: alln-core-3.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (2018-09-20 07:49:12)
> On 09/19/2018 10:41 PM, Taras Kondratiuk wrote:
> > Quoting Stephen Smalley (2018-09-19 12:00:33)
> >> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> >>> When files on NFSv4 server are not properly labeled (label doesn't ma=
tch
> >>> a policy on a client) they will end up with unlabeled_t type which is
> >>> too generic. We would like to be able to set a default context per
> >>> mount. 'defcontext' mount option looks like a nice solution, but it
> >>> doesn't seem to be fully implemented for native labeling. Default
> >>> context is stored, but is never used.
> >>>
> >>> The patch adds a fallback to a default context if a received context =
is
> >>> invalid. If the inode context is already initialized, then it is left
> >>> untouched to preserve a context set locally on a client.
> >>
> >> Can you explain the use case further?  Why are you exporting a
> >> filesystem with security labeling enabled to a client that doesn't
> >> understand all of the labels used within it?  Why wouldn't you just
> >> disable NFSv4 security labeling and/or use a regular context=3D mount =
to
> >> assign a single context to all files in the mount?
> > =

> > Client and server are two embedded devices. They are part of a bigger
> > modular system and normally run the same SW version, so they understand
> > each others NFSv4 SELinux labels. But during migration from one SW
> > version to another a client and a server may run different versions for
> > some time.
> > =

> > The immediate issue I'm trying to address is a migration between
> > releases with and without SELinux policy. A client (with policy) gets
> > initial SID labels from a server (without policy). Those labels are
> > considered invalid, so files remain unlabeled. This also causes lots of
> > errors from nfs_setsecurity() in dmesg.
> =

> Why are you enabling SELinux on the server without loading a policy? =

> Are you concerned about denials on the server? For that, you could =

> always run it permissive until you are confident you have a working polic=
y.
> =

> Why are you enabling security_label in exports before you have a policy =

> loaded?  It doesn't appear that will ever work, since nfsd asks the =

> security module for the labels, not the local filesystem directly.
> =

> I understand that this doesn't fully address your use case, but it seems =

> like you could avoid this particular situation altogether just by =

> loading a policy (at which point your server can return actual contexts) =

> or by removing security_label from your exports (at which point your =

> server won't try returning contexts and the client will just apply the =

> default for nfs) until you get to the point of loading a policy.

It wasn't intentional configuration. Server is running v4.4.x kernel
that had security labels enabled by default for NFS 4.2. This was a bug:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1406885
Commit that introduced security_label 32ddd944a056 ("nfsd: opt in to
labeled nfs per export") appeared in v4.11 only. =


We hit this bug during migration to newer releases with SELinux, but the
older release is already in the field and we need to handle it.

> =

> > Using 'context=3D' at mount point level is an option, but in a normal c=
ase
> > when both sides have a policy we need more granular labels. It is
> > possible to detect a case when a server doesn't have a policy and
> > remount with 'context=3D', but this special case handling looks a bit
> > ugly. Having something like 'defcontext' whould allow to avoid this
> > special case and unconditionally assign default context to the
> > mountpoint.
> > =

> > 'defcontext' may also help during migration between SELinux-enabled
> > releases if a new release introduces labels that are not recognized by
> > older release. In this case they can also fallback to defcontext.
> =

> This is the more interesting case.  And what would these defcontext =

> values be?  A context that is generally accessible to all domains on the =

> client?  Or one that is restricted to only unconfined domains?  Would it =

> be fundamentally different from unlabeled?  Will it really differ =

> per-mount, and if so, why?

Defcontext will be a restricted label. For example a part of confined
domains can access an exported flash disk, but they can't access
unlabeled_t. In one release the flash may have a coarse labels:
u:r:flash_t        .
u:r:flash_t        some.file
u:r:flash_t        licence.file
u:r:flash_secret_t secret_dir

In the next release licence.file may get a more granular label
(licence_t), but the older release still need to be able to read the
file via NFS. With defcontext=3Du:r:flash_t it will be able to do it.

In our case defcontext will usually match a label or export's root
directory, so it needs to be set per-mount.

> =

> > =

> >>
> >> To be clear, defcontext=3D doesn't work that way for local/FS_USE_XATTR
> >> filesystems. The context specified by it is only used for:
> >> 1) files that don't implement the xattr inode operations at all,
> >> 2) files that lack a security.selinux xattr,
> >> 3) the MLS portion of the context if it was missing (strictly as a
> >> legacy compatibility mechanism for RHEL4 which predated the enabling of
> >> the MLS field/logic).
> >>
> >> A file with a security.selinux xattr that is invalid under policy for
> >> any reason other than a missing MLS field will be handled as having the
> >> unlabeled context.
> > =

> > inode_doinit_with_dentry() invokes security_context_to_sid_default()
> > that invokes security_context_to_sid_core() with 'force' flag. Won't
> > sidtab_context_to_sid() in this case allocate a new SID for the invalid
> > xattr context instead of leaving it unlabeled?
> =

> It will be treated as having the unlabeled context for access control =

> purposes and that is what getxattr will return to userspace processes =

> unless they have CAP_MAC_ADMIN and SELinux mac_admin permission, but =

> internally SELinux will keep track of the original xattr context value =

> and will later retry to map it upon a policy reload, switching over to =

> using it for access control and getxattr if it becomes valid under a new =

> policy.  That support was added to support scenarios where a package =

> manager sets a file context before it has loaded the policy module that =

> defines it, or scenarios where one is generating a filesystem image for =

> another OS/release with different policy. That is likely something you =

> need/want for NFS as well if you want the client to start using the =

> context as soon as it becomes valid upon a policy update/reload and not =

> have to wait for the inode to be evicted.

So now handling of invalid labels is different for xattrs (labels are
preserved) and native (labels are discarded). Maybe it is worth to align
this behavior. It should make introduction of defcontext for native
easier.

> =

> > =

> >>
> >> So this would be a divergence in semantics for defcontext=3D between
> >> local/FS_USE_XATTR and NFS/FS_USE_NATIVE filesystems.
> > =

> > Yeah, I also didn't like this semantics mismatch. But from another point
> > defcontext allows to assign a context to files that would otherwise be
> > unlabeled. Something similar I'd like to achive for NFS.
> =

> Yes, I can see the appeal of it.  I guess the question is whether we =

> can/should do it via defcontext=3D or via some new option, and if we do i=
t =

> via defcontext=3D, can/should we change the semantics for local/xattr =

> filesystems to match?  Wondering how widely defcontext=3D is actually use=
d.

Is the current behavior of defcontext for xattrs intentional or it is a
side effect? Honestly it is a bit confusing. Without defcontext really
unlabeled files and files with invalid labels are treated as unlabeled.
Can a user without MAC_ADMIN even distinguish them? With defcontext only
really unlabeled files get default context, but invalid labels still
remain unlabeled.

IMO it would be more consistent if defcontext cover all "unlabeled"
groups. It seems unlikely to me that somebody who currently uses
defcontext can somehow rely on mapping invalid labels to unlabeled
instead of default context.

> =

> > =

> >>
> >>>
> >>> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> >>> ---
> >>>    security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
> >>>    1 file changed, 24 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>> index ad9a9b8e9979..f7debe798bf5 100644
> >>> --- a/security/selinux/hooks.c
> >>> +++ b/security/selinux/hooks.c
> >>> @@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(st=
ruct inode *inode)
> >>>     */
> >>>    static int selinux_inode_notifysecctx(struct inode *inode, void *c=
tx, u32 ctxlen)
> >>>    {
> >>> -     return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, c=
tx, ctxlen, 0);
> >>> +     struct superblock_security_struct *sbsec;
> >>> +     struct inode_security_struct *isec;
> >>> +     int rc;
> >>> +
> >>> +     rc =3D selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, c=
tx, ctxlen, 0);
> >>
> >> In this case, we likely don't gain much by reusing
> >> selinux_inode_setsecurity() here and could just inline the relevant
> >> portion of it if we were to make this change.  Logically they mean
> >> different things.
> >>
> >>> +
> >>> +     /*
> >>> +      * In case of Native labeling with defcontext mount option fall=
 back
> >>> +      * to a default SID if received context is invalid.
> >>> +      */
> >>> +     if (rc =3D=3D -EINVAL) {
> >>> +             sbsec =3D inode->i_sb->s_security;
> >>> +             if (sbsec->behavior =3D=3D SECURITY_FS_USE_NATIVE &&
> >>> +                 sbsec->flags & DEFCONTEXT_MNT) {
> >>> +                     isec =3D inode->i_security;
> >>> +                     if (!isec->initialized) {
> >>> +                             isec->sclass =3D inode_mode_to_security=
_class(inode->i_mode);
> >>> +                             isec->sid =3D sbsec->def_sid;
> >>> +                             isec->initialized =3D 1;
> >>> +                     }
> >>> +                     rc =3D 0;
> >>> +             }
> >>> +     }
> >>> +     return rc;
> >>>    }
> >>>    =

> >>>    /*
> >>>
> >>
>=20
