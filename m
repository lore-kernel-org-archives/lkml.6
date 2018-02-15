Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227J3KB/i3IDDsLbFTC8Fi5+/SMGjzOeuRG8kO4arzie/yRpQ4qV27Ko1ia3UZ5iwy7xZJ98
ARC-Seal: i=1; a=rsa-sha256; t=1518709402; cv=none;
        d=google.com; s=arc-20160816;
        b=0HSoteaRsSqgC8PKAO9m7BL+yCrW1X6uZxC06mMMjVIFLt++nhUcckZKsMhSS5RE4t
         yo7xYq8MY6fNO0OUn+OML/yw8CSdXvfwJra2IH4QTvnDeNlRe57Mg16IiX6+4TI8Vk40
         smn8ETzEdTiutbVosszcKGOg1iq/S4KYgo7/zbgC0oe15jyGhgdKRwzzTuF3Wl8eN9Eu
         NjoZ0AwwGsoh2NsE6e4VZ2gf0m+ok2dxrH9MTT2bYX/LJDq5GPBapMPvMqRdajM9MCL8
         QH+9aOIeGsOa9Ekddme3hSfIDmVJEIRENmp2YXeDN2NjQ1hEwAQBumIlKZ0GlQpB8HJm
         abxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OdxgEVWn751qvsFvLhPu3sscrwpz8d0isO+U11BCxW0=;
        b=0PFOtNkgPYG+tjPW9U6wYWJoSYR/o4no1Bffj24OMIsPo/O6rrN/K1w96qBZYg1g+Q
         aDI7WIgwCvtu3z6/Yu+FSP2H7nrlXYodndqPTrbrZMrKkSAK9C2BFSYiWWI+VLnKO3TJ
         FxRxRc6asZeibZQQ8wm/wlTflr+h4t34wxLLiJY/RSOl6Vq5806qF6RpEArlpXiDhg+u
         8u3ioL63C9ollwHu2f4GPub4BmAEZjhL0Ds+j1py6YB8LXdVrtzovWxsomQ0qDnmIzHy
         W2amW67nr/g0ifCXTS3YyO3layyoEN1bDUvh2Jj6Dac2mBu75+OJWTapKzm7qbPkkvaU
         wZVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.15 104/202] kernfs: fix regression in kernfs_fop_write caused by wrong type
Date: Thu, 15 Feb 2018 16:16:44 +0100
Message-Id: <20180215151718.713009147@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480732716912474?=
X-GMAIL-MSGID: =?utf-8?q?1592482229554510039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

commit ba87977a49913129962af8ac35b0e13e0fa4382d upstream.

Commit b7ce40cff0b9 ("kernfs: cache atomic_write_len in
kernfs_open_file") changes type of local variable 'len' from ssize_t
to size_t. This change caused that the *ppos value is updated also
when the previous write callback failed.

Mentioned snippet:
...
len = ops->write(...); <- return value can be negative
...
if (len > 0)           <- true here in this case
        *ppos += len;
...

Fixes: b7ce40cff0b9 ("kernfs: cache atomic_write_len in kernfs_open_file")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -275,7 +275,7 @@ static ssize_t kernfs_fop_write(struct f
 {
 	struct kernfs_open_file *of = kernfs_of(file);
 	const struct kernfs_ops *ops;
-	size_t len;
+	ssize_t len;
 	char *buf;
 
 	if (of->atomic_write_len) {
