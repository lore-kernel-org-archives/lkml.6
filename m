Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtZtlBlvyVgIqtu6hY3XPrX7i/dDX2UG7yvq05EDR50Z2ipb3WbUS6pRPfKX6vGVe3o44cO
ARC-Seal: i=1; a=rsa-sha256; t=1520641236; cv=none;
        d=google.com; s=arc-20160816;
        b=0qcRc1QnF6/FhiPnPxrcRyT1QMvc2jWicgwilsjg2vsOw0DD7hxnllW84x8kaH08MG
         V0v2PT1UA8K/+1w8dKIfwPv0v/iDP9vRrxfF9X51U2SB6E3YM6AZzypEmvzYwC+bH2BL
         4mXIo3cC3/db5gjcQdILdstxoIxWewV+jFpNwca4tDqCRET79o/n449bg2QGoWc0Xp55
         f1HxwSqS8ZDkCwQORneViaR7xk5b6LHl4ZvNt6QV465dC4hX7vBNCjDN6m7VmyY86Nqw
         VhesenYC1h3vSKSaNP8ZcjZM4vAmPOn6eYNU5A5LRpKquxLi0T+yrLMVwnIi+0DgtGDF
         UzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GP/XKICzu+mgdf0T7+IvMaJYVe2Lk4bo0s8DFPQZ9Qo=;
        b=FEy73lJ42GKnbdz7Sz2/ILE6w6wQcyf6Iu0mio75LFiRYR8+mgGLEVryIdltRjdiX5
         /5IqYhHiL0cpDQDagkeoPzIGNCHPnZVwkQAWdR1w3gLPuSL8Nvsiv4tIvIK7VnBxPCXA
         KuJISXUYGztu4p1uP/+I9J3IZueOHMI22ou1H2z3LSUexvLJc87isvalubXFX9VhfL5a
         dQKaNBxkyHb+3RjSjVbKWijolsdO8c0bI7qckU6XukG+QLwSAnewuFFvcTYmHylmsVho
         lDKjHBIRWVIPG9dnDX10OPyYGN3qu3rzfl6sBq9UM7FQGtA0r68t8ZXRZIWysCOuBDrJ
         mD5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" <ernesto.mnd.fernandez@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4.4 36/36] btrfs: preserve i_mode if __btrfs_set_acl() fails
Date: Fri,  9 Mar 2018 16:18:52 -0800
Message-Id: <20180310001809.379071601@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507905443929738?=
X-GMAIL-MSGID: =?utf-8?q?1594507905443929738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

commit d7d824966530acfe32b94d1ed672e6fe1638cd68 upstream.

When changing a file's acl mask, btrfs_set_acl() will first set the
group bits of i_mode to the value of the mask, and only then set the
actual extended attribute representing the new acl.

If the second part fails (due to lack of space, for example) and the
file had no acl attribute to begin with, the system will from now on
assume that the mask permission bits are actual group permission bits,
potentially granting access to the wrong users.

Prevent this by restoring the original mode bits if __btrfs_set_acl
fails.

Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/btrfs/acl.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -118,13 +118,17 @@ out:
 int btrfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
 	int ret;
+	umode_t old_mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
 		ret = posix_acl_update_mode(inode, &inode->i_mode, &acl);
 		if (ret)
 			return ret;
 	}
-	return __btrfs_set_acl(NULL, inode, acl, type);
+	ret = __btrfs_set_acl(NULL, inode, acl, type);
+	if (ret)
+		inode->i_mode = old_mode;
+	return ret;
 }
 
 /*
