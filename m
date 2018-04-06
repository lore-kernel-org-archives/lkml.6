Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tkErMXSYvG4bFPkfXtglai3hWR8N2cZxNQ+GHhHKPioaEtRKLoQaRPk8e0ALOd1U1TJQk
ARC-Seal: i=1; a=rsa-sha256; t=1523021704; cv=none;
        d=google.com; s=arc-20160816;
        b=DRcrsvkdxmwAl7eaMr1FWRQv2PZYvOGLLENTJwdIbAy/33W6XGjYNauebQ/BwlcfZl
         rMJyRgj7jI4V0ozFENbHJCM66d9jBP0pfIZmTl9zIuupIpc6C6f7pgDJl+R4/1gxBu2X
         uBesoJ/ffG030kEXEiJ/ljhMeBcqmJiUVdJoYoVP9v9t4CmPiglDj7G22R647H3FyquO
         faykf4JWnvdL/0gI9z5U/2mIwKarAJb+PauqndQTKk+zOowkooI4YHhqqlFPND75xdaP
         iOs14+MCTZguSsBeAGM/LXHtjhpXlaOhqUSqQI1ygF6B3u6nLXaTZU22qWqonLMco5EW
         /9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZY8u02iOOkjZMxToXNZJwgPWE4/F4TIKRvpU2YGuwC8=;
        b=xQh/KH8JyWMNJSjY76r5lI+PsouwV14iYPQI0l4hRm/oT/XHdhY7YOMwHxwVAXhcjB
         8K2JwNhZUGhCliUSYp2DP3OvfkkyUpSTz/SKDJbxYpupmCZP0AiyrslhsH0mJi3K9keD
         UcuNm8fIRCf0jAt7jK6+FLpUj/spGzYAd7xvCwuP7l/ETkbwsT7BaPaa0XMIMs1cXgck
         J7yAGVzGE/sDYc4WY+R/MHCHyFGOo9OyFHyXhcyieDLfn1/ztz46YgBTexbW7JhU92LJ
         VlfkaqAu8XdY8WPWe5/ARsyzescyWOl4gD6/3xUrQHZd0XgzTkFxBKwpdF2kB/D5j5f1
         5Iug==
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
Subject: [PATCH 4.9 033/102] selinux: Remove redundant check for unknown labeling behavior
Date: Fri,  6 Apr 2018 15:23:14 +0200
Message-Id: <20180406084336.289708652@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003700659162016?=
X-GMAIL-MSGID: =?utf-8?q?1597004006564305363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |   16 ----------------
 1 file changed, 16 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -406,18 +406,6 @@ static void superblock_free_security(str
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
 static inline int inode_doinit(struct inode *inode)
 {
 	return inode_doinit_with_dentry(inode, NULL);
@@ -528,10 +516,6 @@ static int sb_finish_set_opts(struct sup
 		}
 	}
 
-	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
-		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
-		       sb->s_id, sb->s_type->name);
-
 	sbsec->flags |= SE_SBINITIALIZED;
 	if (selinux_is_sblabel_mnt(sb))
 		sbsec->flags |= SBLABEL_MNT;
