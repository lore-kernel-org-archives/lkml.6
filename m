Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vZTMQlKs1cHecApLp/oLu3moDXxW5gO1aVHqc+E9IZpFKC84mTM+UNtwf0wf7gT1yW16g
ARC-Seal: i=1; a=rsa-sha256; t=1523981250; cv=none;
        d=google.com; s=arc-20160816;
        b=Ig+ju+zowsZLfQPUDQOAun4AteptaGJQSq3W1crt+9t//8v4Yu3q/2ChWRbvTog6NV
         K/nplhfU5JyM4nyWbkg4PDGw/WYvg/KrG3vZHVkV0fpf4gtf3+J4ufmfeFyTTEfozyKc
         v2o4LKliUn1dnzKNDBebr++w17IHl96oqumsKN60mtFpWZUQCsJ0jUpNbscXeUVStSIa
         ZVlJXFKlo85i0vebk9wyrd2RPJFd/vackou9g1RStFiXbpb6ClvM5kSZMTqas+dO4M4y
         34J4L7nAJzuxH4RGYddHc+B9uV1m4J9MLyxm8SyTlKjIPJm0w9cjn0Yl8QgKLhQGMU+g
         8b/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XQRWThXI/wQxAirEDiLMg7PGYDHuXEHHXd593KWpVAE=;
        b=0qEuUmHRTSoHslJAlgosEHeUyux9tMG7hrkaRYFVA1ooLec3BVNZn8W2QtSXAzSVlM
         sDnalp1FTXpmS03cRFOXa0bl7Cc0u/XKyMt19PZnqJK+YM4hU+t2DY6+oJ+27tQBxUiC
         S40yRWlUS5NfcyoeBRzqNKcbWp7jjl8BXAH6tu/k8ZnK92DWESEL8G0/cUhxmEOmsmEv
         LNgbJFD7wZvcIHCqWSW2gJ/UCU7HXH5wBIR+rNnUzNV5/E6PK0BPep5WD88DVM7aNvHg
         qSJEYmzHLLRS7D9nK91KhfCApIj+jg+kFWMACHzTeDZU5PZqc9v5SVtnbTBdFRVJiAvN
         E/ow==
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
Subject: [PATCH 4.14 46/49] ovl: fix lookup with middle layer opaque dir and absolute path redirects
Date: Tue, 17 Apr 2018 17:59:25 +0200
Message-Id: <20180417155717.228185033@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009799059325863?=
X-GMAIL-MSGID: =?utf-8?q?1598010164187874277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
