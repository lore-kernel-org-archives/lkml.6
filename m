Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZqK59/W0qg1VMJH6dT0C2McYavp3AXfJ+2El3dueePmGixNvc+yjE3mHPYtj3CBZg0+NnfT
ARC-Seal: i=1; a=rsa-sha256; t=1525146857; cv=none;
        d=google.com; s=arc-20160816;
        b=DykAkidEYAXhHc1CDfP//pnybjory+c8Zdw7whREjhSqALnaL4vpACqdWpuPee9gnZ
         x2a1WlVnGUTQ6ctvoPpplO2iYeJzrJU/1+y7ZosLFBudfGnYGHtxj9Fgf+LMWv4EaGh6
         rWesdeddyQ2B1mTUIpbzOhJZKSPu42kffrwNL5qVzv7gDzwmuwfcDholKQQdFqdWBH0o
         5JlGCxYn8Nh6lxohdBGAoOZoBdI46X45b7NJ0hvc2foFbBGsB1B4FVnBA5F73QVb3sf1
         ellFMoxMIaEj7ZlpHLg5vQ4S5M51UcJRuskD+dCr8jkHnVOTtFY3nEJ0lBWj1pBcDn6n
         EkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=F+R/VJIxpSF44pS1vie/JLRZfio/77rJhe0JvTal/FI=;
        b=tQ1ozCA8O0lHtqagXP52fIEK0QTJXpehMA4I941jD6ayK/JuhM4MEKhDvlTxigTHvz
         ZWqRQ6YFnf0tU+79o5vwUXiX/SUmA549CbCR23IGipbsDfHGw1ZYGOBGj3yV9AsFYYLN
         qHThBm1X0XG/sm5Z3hbg6W6PejJ4Gqufs2kJbkigF/ajaMzChnxH4uzPhoYiSlR5b0cq
         5FJYO/uaHe8jsdBypT9t0uxJhUegMBc3hoa9fnlWA8/3bBksLh1ogBEC7R5F8H8QLV/2
         ewtRv09fjM+kyEZc5Wzj8Dz1E/i3fCqEPVaiftyNfMe18ITs1+7OynbXWWOPWXy0ieCY
         qYOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:39 +1000
Subject: [PATCH 10/10] staging: lustre: fix error deref in ll_splice_alias().
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514675919.17843.11688659715084804936.stgit@noble>
In-Reply-To: <152514658325.17843.11455067361317157487.stgit@noble>
References: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232390798280014?=
X-GMAIL-MSGID: =?utf-8?q?1599232390798280014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

d_splice_alias() can return an ERR_PTR().
If it does while debugging is enabled, the following
CDEBUG() will dereference that error and crash.

So add appropriate checking, and provide a separate
debug message for the error case.

Reported-by: James Simmons <jsimmons@infradead.org>
Fixes: e9d4f0b9f559 ("staging: lustre: llite: use d_splice_alias for directories.")
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
Tested-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/namei.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index 6c9ec462eb41..24a6873d86a2 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -442,11 +442,15 @@ struct dentry *ll_splice_alias(struct inode *inode, struct dentry *de)
 	} else {
 		struct dentry *new = d_splice_alias(inode, de);
 
+		if (IS_ERR(new))
+			CDEBUG(D_DENTRY, "splice inode %p as %pd gives error %lu\n",
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
 
