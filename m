Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9P8pBMwyDiybDeAU3CRQkgep8lYZ2My3Mq/KujUq+KD8ny23eVkuc0DzGuAszosJ5hOBe
ARC-Seal: i=1; a=rsa-sha256; t=1523980900; cv=none;
        d=google.com; s=arc-20160816;
        b=oshXtrb/XRjpKo1fRJlFzk9xG5xProk7CJAzg0qxptYLTrca+tdB8mOMwcqVBN7fNK
         bRMJWlDlaHB+1mCc9S3VGKsKHIGEsZOaZKEEDQJ1IIEduR9m6HJg3ez31KWRVqtluyY5
         uQb2oJcVSdc+KscKXAB+nTwoNgBSDQ78szVCDPgebR6Uvm1pt/LTzHjdSc331jY8C4jh
         Ko0EHRc2HuDS4HhsSA6OklLYNRtEJ81bdOJ2RunbigvFaM4ItTcF0nRxdju1O48h/pX1
         8ilnZWJEplTL1Ew3PXOou2dqgdD6e9LRePwkiXHs7BGy48V9JNfQONAb81BF1N6Fa74s
         X5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sp2HHcNn5lgUo5F/HWrfP9Rgq/Bp3c0+Zhl6LzgPX3Q=;
        b=cCIS7IrYql9JzIUQ1HdPuYZty2V3TqQSUP5wYcOUjf4MrukAmQIpjBlNBavRY3uO/B
         o+cnlphcQrz9qPwobYjnwtemlPz0EhDTGHB1G8uPMkL02XVBJn4oNnWgUMpiAksxaW/t
         6asWY7is7lt/iYqRLfSdcGAogHYxKBi+QBC1yw8yIOAP/c7yHxt0mBS+enZ5iMPstZOD
         /l6zV8biwD5i5ghxchUat+R6c1gXMV1SdTyg6V3kqKPCDS7YWXbnP4ZXeHPTChOxByQw
         uovcsP6YCkia8jVvsjOf2qyq2DdbD//qdRHznKAIVWk7kNPmYGD8Q7Zx/RQylx08U3D1
         AYqw==
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
Subject: [PATCH 4.16 44/68] ovl: Set d->last properly during lookup
Date: Tue, 17 Apr 2018 17:57:57 +0200
Message-Id: <20180417155751.122616432@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009796047020083?=
X-GMAIL-MSGID: =?utf-8?q?1598009796047020083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivek Goyal <vgoyal@redhat.com>

commit 452061fd4521b2bf3225fc391dbe536e5f9c05e2 upstream.

d->last signifies that this is the last layer we are looking into and there
is no more. And that means this allows for some optimzation opportunities
during lookup. For example, in ovl_lookup_single() we don't have to check
for opaque xattr of a directory is this is the last layer we are looking
into (d->last = true).

But knowing for sure whether we are looking into last layer can be very
tricky. If redirects are not enabled, then we can look at poe->numlower and
figure out if the lookup we are about to is last layer or not. But if
redircts are enabled then it is possible poe->numlower suggests that we are
looking in last layer, but there is an absolute redirect present in found
element and that redirects us to a layer in root and that means lookup will
continue in lower layers further.

For example, consider following.

/upperdir/pure (opaque=y)
/upperdir/pure/foo (opaque=y,redirect=/bar)
/lowerdir/bar

In this case pure is "pure upper". When we look for "foo", that time
poe->numlower=0. But that alone does not mean that we will not search for a
merge candidate in /lowerdir. Absolute redirect changes that.

IOW, d->last should not be set just based on poe->numlower if redirects are
enabled. That can lead to setting d->last while it should not have and that
means we will not check for opaque xattr while we should have.

So do this.

 - If redirects are not enabled, then continue to rely on poe->numlower
   information to determine if it is last layer or not.

 - If redirects are enabled, then set d->last = true only if this is the
   last layer in root ovl_entry (roe).

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 02b69b284cd7 ("ovl: lookup redirects")
Cc: <stable@vger.kernel.org> #v4.10
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/namei.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -815,7 +815,7 @@ struct dentry *ovl_lookup(struct inode *
 		.is_dir = false,
 		.opaque = false,
 		.stop = false,
-		.last = !poe->numlower,
+		.last = ofs->config.redirect_follow ? false : !poe->numlower,
 		.redirect = NULL,
 	};
 
@@ -873,7 +873,11 @@ struct dentry *ovl_lookup(struct inode *
 	for (i = 0; !d.stop && i < poe->numlower; i++) {
 		struct ovl_path lower = poe->lowerstack[i];
 
-		d.last = i == poe->numlower - 1;
+		if (!ofs->config.redirect_follow)
+			d.last = i == poe->numlower - 1;
+		else
+			d.last = lower.layer->idx == roe->numlower;
+
 		err = ovl_lookup_layer(lower.dentry, &d, &this);
 		if (err)
 			goto out_put;
