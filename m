Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4448BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1402C2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbeLOKW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:22:27 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:41464 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:22:26 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2018 05:22:25 EST
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id DB8961819E5FF;
        Sat, 15 Dec 2018 11:13:45 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        Richard Weinberger <richard@nod.at>, stable@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] jffs2: Fix retry handling jffs2_listxattr
Date:   Sat, 15 Dec 2018 11:13:29 +0100
Message-Id: <20181215101329.16246-1-richard@nod.at>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When jffs2 has to retry reading xattrs we need to reset
the buffer pointer. Otherwise we return old xattrs from the
previous iteration which leads to a inconsistency between
the number of bytes we return and the real list size.

Cc: <stable@vger.kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Fixes: 764a5c6b1fa4 ("xattr handlers: Simplify list operation")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
Andreas,

since you maintain the attr package too, I report it right here. :-)
This jffs2 bug lead to a crash in attr_list().

for() will loop to crash when there is no trailing \0 in the
list of xattrs.

for (l =3D lbuf; l !=3D lbuf + length; l =3D strchr(l, '\0') + 1) {
	if (api_unconvert(name, l, flags))
		continue;

...
}

I suggest changing the loop condition to something like l < lbuf + length=
.

Thanks,
//richard
---
 fs/jffs2/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..0cb322eb9516 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -967,6 +967,7 @@ ssize_t jffs2_listxattr(struct dentry *dentry, char *=
buffer, size_t size)
 	struct jffs2_xattr_ref *ref, **pref;
 	struct jffs2_xattr_datum *xd;
 	const struct xattr_handler *xhandle;
+	char *orig_buffer =3D buffer;
 	const char *prefix;
 	ssize_t prefix_len, len, rc;
 	int retry =3D 0;
@@ -977,6 +978,7 @@ ssize_t jffs2_listxattr(struct dentry *dentry, char *=
buffer, size_t size)
=20
 	down_read(&c->xattr_sem);
  retry:
+	buffer =3D orig_buffer;
 	len =3D 0;
 	for (ref=3Dic->xref, pref=3D&ic->xref; ref; pref=3D&ref->next, ref=3Dre=
f->next) {
 		BUG_ON(ref->ic !=3D ic);
--=20
2.20.0

