Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELvTfodts0GZbe+hgbYGsi9rDG4gLvbo/TAg395cmt8U27tQQrj8ov3+A3rZjzSQopYPAIS7
ARC-Seal: i=1; a=rsa-sha256; t=1519947162; cv=none;
        d=google.com; s=arc-20160816;
        b=TSa7/vpRANj4PCw5vX+14zGRf0g8ltoRD1Ed4pIevGVxAVcZnHO2Vg08cVB6pnil9l
         Maxj594dyDGHJQEN0GA/XjT0Pw39g1V3x3eiyYfBEh02sxpMjRH1TlTLQDtY1P9g9e69
         STfRvPtDjybf/yPqHE6cvkcGfE8acx6jH4c3mx4ZGR3LOkZGm5VYBlWMPBsyaSLlCllM
         KA3USU9GcMhCpl7zf1BUV28xQSJg+S7MtQrdsJUzE9lTbzhsLsDr5mE9OO8Q/QP2Ks2S
         zxil7bCYTkwB2xCUGnokXWZLVHzdRwjl5bKVeueJYAdBD0bVyBZsgQ7zejFSUrxgndhi
         EEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=jHOSYWaeNyqXdGPinYF2SUJ3PQ3PezIxJ9oxpwU2sOQ=;
        b=JmBvooae68XgzBjT7KBX+4Mysy6J0r++p9oJOA9R57hGQfD9YrSHWSTJSp7JbuYJY/
         ZqNj4/BvC1dbcLD9v+zBArfaWtm6RVqy/lRB5c4I6FW8iXzUcXgXRytRIIumbuoT3s39
         XAFAwMw+FsfnkDYrE7t73hn3UyQV1J0rYpMcWq065z8dXxOQsP+zYBzFmyJxngO2J4EX
         BeDORgfYW+e/eL1xgTOjtfzp4dRAe+146eo2fpQ1UzKbTB1ug21rVeBIqKmTkfsLZipF
         0AcM4JZhvhqRAAADzqvm2G9F1WURW42hKZopqOncvlpyScUjxag/VMDCr7bW0VDWH/9p
         GpMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 04/17] staging: lustre: obdclass: don't require lct_owner to
 be non-NULL.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708517.7628.10169180583984336095.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780115063763673?=
X-GMAIL-MSGID: =?utf-8?q?1593780115063763673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some places in lu_object.c allow lct_owner to be NULL, implying
that the code is built in to the kernel (not a module), but
two places don't.  This prevents us from building lustre into
the kernel.

So remove the requirement and always allow lct_owner to be NULL.

This requires removing an "assert" that the module count is positive,
but this is redundant as module_put() already does the necessary test.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index cca688175d2d..880800e78c52 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -1380,12 +1380,8 @@ static void key_fini(struct lu_context *ctx, int index)
 		lu_ref_del(&key->lct_reference, "ctx", ctx);
 		atomic_dec(&key->lct_used);
 
-		if ((ctx->lc_tags & LCT_NOREF) == 0) {
-#ifdef CONFIG_MODULE_UNLOAD
-			LINVRNT(module_refcount(key->lct_owner) > 0);
-#endif
+		if ((ctx->lc_tags & LCT_NOREF) == 0)
 			module_put(key->lct_owner);
-		}
 		ctx->lc_value[index] = NULL;
 	}
 }
@@ -1619,7 +1615,6 @@ static int keys_fill(struct lu_context *ctx)
 			LINVRNT(key->lct_init);
 			LINVRNT(key->lct_index == i);
 
-			LASSERT(key->lct_owner);
 			if (!(ctx->lc_tags & LCT_NOREF) &&
 			    !try_module_get(key->lct_owner)) {
 				/* module is unloading, skip this key */
