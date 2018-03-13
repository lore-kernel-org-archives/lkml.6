Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELszMydVaTKM7AfDVOM1zR26WhjhKOT6DR1cbEBCExdH4AK/xF/PohBAHU+20vq6tp6McN8r
ARC-Seal: i=1; a=rsa-sha256; t=1520954956; cv=none;
        d=google.com; s=arc-20160816;
        b=rEw51Nt+7gFaPQkMA/5BkRGFfWqzFC0nhoNIGQ1lNtZAtNK40FcST77DjNairGlzVF
         rJhsW2GkU4WvzegvqZvPy+NvpgmdcQKnCC2iOxAwnuyfgvAaubo+UX9Ftj2jUgDOsSPh
         oLhmbQojka+uzHeMw1L3sim1w2K9yNiljyY2xB97Sjkvy4qAnpZyyT2bym41uUWbjCnq
         1zT2QEmctLkKQIYF0BbYvLw++mo/uzB+Hy5gab4SY/1fS8DCrJLyT397IBMgbeXWBwXy
         Gc2WbKVtCJJHNB92VY47kNgsZpvCbk5kJXgGllVtxgY9mDrwiC1OnFsdXBWtP2w04nzO
         xtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0KASJQq3ughfwExoPbrLnwE76SElaDesH36gSt200SA=;
        b=jJaNuVWVb/VmDZW11BaRyl6B7dACAkUv1+vMQbucJty414fJ1KWQCBDkll7POCExr3
         8J315y7FcozY7rQnIN+6Unhqew+Wf0lbW2Nmo0avWR5MVTst9WwDWo8Od2aiRtf5xfKl
         Us5QZNtVHlUmpjHk2/9mK2sq+T1/9758SP99p4M4enRLOu2CMrxJGVfW969sZxcPeD8/
         uHJnvQmYydDquXYJJXypoO4gZVUMNvBliQkEfeXDiSbFgec4ISSOTd3MjfcBVV5aNfg8
         XMb8bPCAdk+I3iX0Oz9iK5ZnK7mO3RD6HTbJjsa3ueBVw5WHpvvnEKLo+X4DvbOV73Wh
         XAdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.15 039/146] ovl: redirect_dir=nofollow should not follow redirect for opaque lower
Date: Tue, 13 Mar 2018 16:23:26 +0100
Message-Id: <20180313152323.579717003@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836863914943271?=
X-GMAIL-MSGID: =?utf-8?q?1594836863914943271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivek Goyal <vgoyal@redhat.com>

commit d1fe96c0e4de78ba0cd336ea3df3b850d06b9b9a upstream.

redirect_dir=nofollow should not follow a redirect. But in a specific
configuration it can still follow it.  For example try this.

$ mkdir -p lower0 lower1/foo upper work merged
$ touch lower1/foo/lower-file.txt
$ setfattr -n "trusted.overlay.opaque" -v "y" lower1/foo
$ mount -t overlay -o lowerdir=lower1:lower0,workdir=work,upperdir=upper,redirect_dir=on none merged
$ cd merged
$ mv foo foo-renamed
$ umount merged

# mount again. This time with redirect_dir=nofollow
$ mount -t overlay -o lowerdir=lower1:lower0,workdir=work,upperdir=upper,redirect_dir=nofollow none merged
$ ls merged/foo-renamed/
# This lists lower-file.txt, while it should not have.

Basically, we are doing redirect check after we check for d.stop. And
if this is not last lower, and we find an opaque lower, d.stop will be
set.

ovl_lookup_single()
        if (!d->last && ovl_is_opaquedir(this)) {
                d->stop = d->opaque = true;
                goto out;
        }

To fix this, first check redirect is allowed. And after that check if
d.stop has been set or not.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Fixes: 438c84c2f0c7 ("ovl: don't follow redirects if redirect_dir=off")
Cc: <stable@vger.kernel.org> #v4.15
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/namei.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -678,9 +678,6 @@ struct dentry *ovl_lookup(struct inode *
 		stack[ctr].layer = lower.layer;
 		ctr++;
 
-		if (d.stop)
-			break;
-
 		/*
 		 * Following redirects can have security consequences: it's like
 		 * a symlink into the lower layer without the permission checks.
@@ -697,6 +694,9 @@ struct dentry *ovl_lookup(struct inode *
 			goto out_put;
 		}
 
+		if (d.stop)
+			break;
+
 		if (d.redirect && d.redirect[0] == '/' && poe != roe) {
 			poe = roe;
 
