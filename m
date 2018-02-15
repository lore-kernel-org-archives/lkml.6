Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22499L6nkZzGU+NlqA+L2vliPPZU7fRVS7cK3LzJMmEs8waI0wQXw3K6gWEnByt9f/G2o3W7
ARC-Seal: i=1; a=rsa-sha256; t=1518709096; cv=none;
        d=google.com; s=arc-20160816;
        b=ZDKBkzLo3gI9rZMhLf1OTZwwq4WhkgCWkczHdMtTCRIxwpjfMxYt7cTnp39Jarh4GU
         kBrsfoKfVWZ8Q/dgE9hwxVvt/oYWh86jpkL1v7wm/GCX5i9aBnUCCDaYgjChb793+6h0
         5QGwqq2R9hTwvjPRFTSNmIbjO7yNtOAigw2ofd/WG2IcCOkuJkAEV/dqq5hZFoUTy4Up
         c9Q0WHvcK5YSiVVlMTK4bebmH92Lw3CVEW6pKmWYFwMqzjwpi9rEeZ0ta78FM5Qodt3Y
         QSpSs2ln7RQlm0gEOE7xhAO6LVF0+WcJC64cc2EJYlmktVcWjZhLv6fZzjfPv6UCtBgQ
         d9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FLh0DAZclgqrq/Zf5QALhwZcZ77oHFBecPWM5+RC4oU=;
        b=Lg/k/PbHbj7nU+WcZHQMErUskrf+09u5cUGLqyXOaBLI+soOH0B+74t33zmR4QgkjC
         KnzUkOU8g7I1feZmu5vgwYcwhBrbiabo8TAlUve+j8sc18Tgc7PW3Z/eePbIWs6kKdx+
         6NSTD1qzF2LmNJkVe5PhMiVUAaxAAm0EmGk5g65PfbCMJ98rkNDtTlyhq+0GpCrjcgup
         c6kli02F65sT2AYL4jCYJF4miu8oO+hY+DjuOPJKYqfzFjWNMgCLjszKK1Q4HdumpECt
         PwPXAs1BcPp0mLdHJDOzIcbuxTrUQatfQ+nqhABIxMZ8fUZj/TVcELSqkzJcGkOSzkun
         ZQGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 189/195] ovl: take mnt_want_write() for removing impure xattr
Date: Thu, 15 Feb 2018 16:18:00 +0100
Message-Id: <20180215151715.764928567@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481909946468209?=
X-GMAIL-MSGID: =?utf-8?q?1592481909946468209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit a5a927a7c82e28ea76599dee4019c41e372c911f upstream.

The optimization in ovl_cache_get_impure() that tries to remove an
unneeded "impure" xattr needs to take mnt_want_write() on upper fs.

Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/readdir.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -575,8 +575,15 @@ static struct ovl_dir_cache *ovl_cache_g
 		return ERR_PTR(res);
 	}
 	if (list_empty(&cache->entries)) {
-		/* Good oportunity to get rid of an unnecessary "impure" flag */
-		ovl_do_removexattr(ovl_dentry_upper(dentry), OVL_XATTR_IMPURE);
+		/*
+		 * A good opportunity to get rid of an unneeded "impure" flag.
+		 * Removing the "impure" xattr is best effort.
+		 */
+		if (!ovl_want_write(dentry)) {
+			ovl_do_removexattr(ovl_dentry_upper(dentry),
+					   OVL_XATTR_IMPURE);
+			ovl_drop_write(dentry);
+		}
 		ovl_clear_flag(OVL_IMPURE, d_inode(dentry));
 		kfree(cache);
 		return NULL;
