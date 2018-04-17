Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ov2IXgJKLlZvwTN20jJ3Lg4huAItMV7/QkEuelbNZH8lEFpxpizvYjAzHsMlqjBu5Z8Fw
ARC-Seal: i=1; a=rsa-sha256; t=1523980902; cv=none;
        d=google.com; s=arc-20160816;
        b=L6lv+Dkt64kXFHOH5+OpdhtKrU0Q3YVN2PiWffA/2rZ2RdtORs9kmdCq/JJbr4jWo4
         4QgxeM//0EBkoeAJKz0u1uXScopOwE00k3DeXrvH7wPjkQkkO/nRiDq7VADe6lfFt/C0
         xW0YelkesOtiZTVcOUjpYcwC3wnxxUtrAuogpqu7J/y0aWRpx1fwb1r+hsU2Mb3RRRZG
         ZpFBIvwbhmW5nV9uZ2GZWR/eqwOYnlAFHOjYNH+pLMCV9AtexJm7huQf5Db34VvlrH+B
         Uk304kZyvrKa9WfJrftZw1tA3gwZHJm/bY9tcW1pLKgkKpxH87q7RVvy3+FnuHWHfqvh
         5SIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+MM7OvZ4LgEfhx319mmCmq9BHVcpABUmJbGTQKYfx2Y=;
        b=A8bNrQMTB21v4OPHAYAb4RVkQWKqjra3eRCIVDEzR/yPDZvQ4tdnK4iEnjTqqAEkBt
         ZwVArrzsNz8EEm1O6iG9WPYrBPe3iHs/7gPJcb6AWvKha9s8huHbrT+7of3a58b2SdT5
         UOGozev7gRZu1QFo62aVV31OUQxpUWiv8lgRlXNmS2EemVqZTgvqBzM0G0Xk3tSqCj+u
         6kZtGcVkEyer9azk+RDpuMck9V89O1ngaTGX25QtgI36tR8iIFMJaYsuHnfZIl1+Gn70
         WPbPbnKUX6SGzFprVSY3aD0UKoxoXWVK4pgOBtmhXzDzruNLXWkYQ6oR1StSZPULzorD
         Y1/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.16 45/68] ovl: fix lookup with middle layer opaque dir and absolute path redirects
Date: Tue, 17 Apr 2018 17:57:58 +0200
Message-Id: <20180417155751.169731940@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009799059325863?=
X-GMAIL-MSGID: =?utf-8?q?1598009799059325863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 3ec9b3fafcaf441cc4d46b9742cd6ec0c79f8df0 upstream.

As of now if we encounter an opaque dir while looking for a dentry, we set
d->last=true. This means that there is no need to look further in any of
the lower layers. This works fine as long as there are no redirets or
relative redircts. But what if there is an absolute redirect on the
children dentry of opaque directory. We still need to continue to look into
next lower layer. This patch fixes it.

Here is an example to demonstrate the issue. Say you have following setup.

upper:  /redirect (redirect=/a/b/c)
lower1: /a/[b]/c       ([b] is opaque) (c has absolute redirect=/a/b/d/)
lower0: /a/b/d/foo

Now "redirect" dir should merge with lower1:/a/b/c/ and lower0:/a/b/d.
Note, despite the fact lower1:/a/[b] is opaque, we need to continue to look
into lower0 because children c has an absolute redirect.

Following is a reproducer.

Watch me make foo disappear:

 $ mkdir lower middle upper work work2 merged
 $ mkdir lower/origin
 $ touch lower/origin/foo
 $ mount -t overlay none merged/ \
         -olowerdir=lower,upperdir=middle,workdir=work2
 $ mkdir merged/pure
 $ mv merged/origin merged/pure/redirect
 $ umount merged
 $ mount -t overlay none merged/ \
         -olowerdir=middle:lower,upperdir=upper,workdir=work
 $ mv merged/pure/redirect merged/redirect

Now you see foo inside a twice redirected merged dir:

 $ ls merged/redirect
 foo
 $ umount merged
 $ mount -t overlay none merged/ \
         -olowerdir=middle:lower,upperdir=upper,workdir=work

After mount cycle you don't see foo inside the same dir:

 $ ls merged/redirect

During middle layer lookup, the opaqueness of middle/pure is left in
the lookup state and then middle/pure/redirect is wrongly treated as
opaque.

Fixes: 02b69b284cd7 ("ovl: lookup redirects")
Cc: <stable@vger.kernel.org> #v4.10
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/namei.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -56,6 +56,15 @@ static int ovl_check_redirect(struct den
 			if (s == next)
 				goto invalid;
 		}
+		/*
+		 * One of the ancestor path elements in an absolute path
+		 * lookup in ovl_lookup_layer() could have been opaque and
+		 * that will stop further lookup in lower layers (d->stop=true)
+		 * But we have found an absolute redirect in decendant path
+		 * element and that should force continue lookup in lower
+		 * layers (reset d->stop).
+		 */
+		d->stop = false;
 	} else {
 		if (strchr(buf, '/') != NULL)
 			goto invalid;
