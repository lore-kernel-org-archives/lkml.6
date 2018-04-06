Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48fzhpvRyfkLBsKpO+nwCl82donNkaN2g+phET9qsquZtym5LGyxDg95slvFLkVK69+JvdA
ARC-Seal: i=1; a=rsa-sha256; t=1523021412; cv=none;
        d=google.com; s=arc-20160816;
        b=HpAnVx3WOg33xMVzIB3AMlmYjiwn7POlotD2VGjvG7mEIFsCXWwSf1xLSxI9SJvsdA
         loTsnWt4oxt/yMdA3et1OYRtK/C+1iKzjJcakeHrhz50qpXJEz7mIeCRkTw/WSbtBLvG
         CK5wP5dh+q5ZBqgf17r6QJBGm0rxBot4VX/UaSQWHFx4WDc1FsuyBQCBuiHr8CO59lri
         eHxj+gFyY0S/oWrtwLa9n/y3vs4y0/jQetH59bJ6YCs916NAR8FQaZJ1a8THgVo4iuIi
         hereHTgJ05Laz+oG4S2sw+OAfQj7Fwj8AJpVZqzpbUhWmfoZiebqsEj5T06qjwosLLZ6
         vzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hazDl942c1GxyeXqAT200a8rNJx56UK1+EqeFH5sM4M=;
        b=XmHIjMqXyQNmoJ2X3yycQIuCMeK+2L8GbT4ErzU8aMG7Mf703Fz3r9Pr5l7F7KoFkA
         DrhhssadI0Vy21ZBlhxVZOgiLtA42DumYzQJd/6Q11wuDQ2SsyzRo9nlO02jDiDMrG83
         H0OYqrEZY2iCQNN4YzFq6W4xPT4TSLYdZJomk9dQFDK6+ZHaC7yrRaLuV0tojQ9JWqZ/
         mhgFm7EzOGDgAkFzFHjxD1lI6RPqSYOjqHwuY0zNClgHF6ssl9i6621TSmG4WSpFRzO9
         T31yvGLNbCoaSvK95f7qCAHb5libBkzwKXHtxipl2kNkUxu/2GLj2HqWnLiYxzXM/1J6
         bqMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	Paul Moore <paul@paul-moore.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 27/72] selinux: Remove redundant check for unknown labeling behavior
Date: Fri,  6 Apr 2018 15:23:28 +0200
Message-Id: <20180406084307.431462913@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003700659162016?=
X-GMAIL-MSGID: =?utf-8?q?1597003700659162016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 270e8573145a26de924e2dc644596332d400445b upstream.

The check is already performed in ocontext_read() when the policy is
loaded. Removing the array also fixes the following warning when
building with clang:

security/selinux/hooks.c:338:20: error: variable 'labeling_behaviors'
    is not needed and will not be emitted
    [-Werror,-Wunneeded-internal-declaration]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
[natechancellor: inode_doinit_with_dentry still present]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/hooks.c |   16 ----------------
 1 file changed, 16 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -333,18 +333,6 @@ static void superblock_free_security(str
 	kfree(sbsec);
 }
 
-/* The file system's label must be initialized prior to use. */
-
-static const char *labeling_behaviors[7] = {
-	"uses xattr",
-	"uses transition SIDs",
-	"uses task SIDs",
-	"uses genfs_contexts",
-	"not configured for labeling",
-	"uses mountpoint labeling",
-	"uses native labeling",
-};
-
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
 
 static inline int inode_doinit(struct inode *inode)
@@ -456,10 +444,6 @@ static int sb_finish_set_opts(struct sup
 		}
 	}
 
-	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
-		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
-		       sb->s_id, sb->s_type->name);
-
 	sbsec->flags |= SE_SBINITIALIZED;
 	if (selinux_is_sblabel_mnt(sb))
 		sbsec->flags |= SBLABEL_MNT;
