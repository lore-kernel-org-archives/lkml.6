Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZrSPj99kcXXPYE4kpM8ku3sgcCQHOhVUpgB3KWiZ1xn7kTaAh/Y+M2lkLp3B6bYnFYjGIJc
ARC-Seal: i=1; a=rsa-sha256; t=1525654597; cv=none;
        d=google.com; s=arc-20160816;
        b=hvVMDlolQFnw4Lb8UkKtzhWUBn+BqA7FFqgIP2PvlMySVqoZXVanoEUAfWFk9GkZLW
         A+A6lM2GfS2MMv8woMYb2lCs4KcKS4txG/Fo4L3vrEfPWU78pBmrI5NbLMs+Dy7Gufxp
         v3ByWjgCESXopN+VBEIKoe1Qs11gjBSTagYV6lO5bzqDInXW7PR54KvpX+OzoyuPEkyt
         aifvXe2ZNBTNtE0IyhAV7OM1rK6+1DkGjMtwY85AySzP8JWWzLF2J9BNunSy1Q/sttNF
         b1r9joDh7iogP7RhMRbX7MrCxfPmVHeladvTgK6++tMP2EqcK6pPQNNzhlZL53gghWYH
         /Mqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=aagqde/1R/viZRZGuxIU8hbsmM2eqCHZRspOFSA+LAY=;
        b=a7JXTdKEjnGR+VwEHfIB+mluklGirCEbZWhNfpWQ/2tza3qxhZaiQMayFbquzzISW0
         FofWaOmW220sgn5PBZXZYPgvBi9EDPTpGJjfopfRsJ4VHblfd92lQV02cydnRPcGr+Ta
         zhw6YXk3DT2gCZ72tY2iCv0v2JpIwq6B2xb7cYTIu/mt7IV1QFhqRpmEA+e5flniSVHM
         8BBY3gA20Eug4a12ManJkYsNsjfsHJs29itkqEXhsFIRoV6q/uPKx0dzkOHrLXCkNxua
         r8hyZBjmnj4iid/oJKiOhHwyKzyJMs9TbbUn6t5UqvSpt2T+kpJEw8KIyour8r1YllRu
         6qTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 07 May 2018 10:54:48 +1000
Subject: [PATCH 10/10] staging: lustre: fix error deref in ll_splice_alias().
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565448830.30131.6113766424862020086.stgit@noble>
In-Reply-To: <152565436690.30131.2229703651041382739.stgit@noble>
References: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764795063797888?=
X-GMAIL-MSGID: =?utf-8?q?1599764795063797888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

d_splice_alias() can return an ERR_PTR().
If it does while debugging is enabled, the following
CDEBUG() will dereference that error and crash.

So add appropriate checking, and provide a separate
debug message for the error case.

Reported-and-tested-by: James Simmons <jsimmons@infradead.org>
Fixes: e9d4f0b9f559 ("staging: lustre: llite: use d_splice_alias for directories.")
Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/namei.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index 6c9ec462eb41..9ac7f097802d 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -442,11 +442,16 @@ struct dentry *ll_splice_alias(struct inode *inode, struct dentry *de)
 	} else {
 		struct dentry *new = d_splice_alias(inode, de);
 
+		if (IS_ERR(new))
+			CDEBUG(D_DENTRY,
+			       "splice inode %p as %pd gives error %lu\n",
+			       inode, de, PTR_ERR(new));
 		if (new)
 			de = new;
 	}
-	CDEBUG(D_DENTRY, "Add dentry %p inode %p refc %d flags %#x\n",
-	       de, d_inode(de), d_count(de), de->d_flags);
+	if (!IS_ERR(de))
+		CDEBUG(D_DENTRY, "Add dentry %p inode %p refc %d flags %#x\n",
+		       de, d_inode(de), d_count(de), de->d_flags);
 	return de;
 }
 
