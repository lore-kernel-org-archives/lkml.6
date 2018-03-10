Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELudKSkedB+mfwt/d/wIQZBcaYqsHi/Lipo/ZxxsJxvA8UFRlY2S7Mvj40mKm9MKaquLtDhL
ARC-Seal: i=1; a=rsa-sha256; t=1520641392; cv=none;
        d=google.com; s=arc-20160816;
        b=M6h8TcNW4ovP1l7q7ggRknuwK7SEgPqUR5abuCg6BxBKvP/9T6qBftZYW6WKG62Ll4
         Siz+wRNlfFHioVWawLpafzGIpCC1fH4XFBRLXMgXtvvIDdP2JQYA4YUWYtGtU2BqnSPo
         QlPrHoMc0HH61Mid2GwklYTDkk6jtqEmT0UQO5L5OH5OrabXWYAVwv36+2uRQUQx+SL3
         0P88SCvDEvstQHu0sOavpj+9HmPlX8qB1/qwfp5GANOT+nyFuDD3AIh4JwRpYseUgW4+
         droNLc842dxzgpE9vyip2NEhKg8QPTRe1Srsk6va3t9Wo21TAaV4wt7LE9TtlXOVWMCF
         MkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FiwcVfIStPb7XxifCE134k4agdBoPm7dx8Ru2NStuMk=;
        b=F2M6KFsvKG0Irs2zUrvRBB9cgvFR5Pc/Vu64FhjICevUqLpgHqrDaPYEFIQuQ0GjEG
         vZbjgw0Y8M0bHkZs1dUSmckRCmr8sJC8C05fWqJQH2SGQdKDFoDM+a/oQqwgZ+5xsHmL
         WzmyAKHNQuzvGW/FG2YUnWg2muVcLNpvzz3MBOHo8DnljgjDnvONB324s9x7R+Klunay
         A6mzefd8+h9grscYrC9Lom9CQJQe/zjCnr345Cogzv3c30VrR6il8coNCrhy46vyGRm7
         Eqjkr0lpx+QwAhOi2JDlstErOXFo3og8Qer12s9ZREPwE02+Pq7sG4wObJnqvZIUYyVC
         MyTw==
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
Subject: [PATCH 4.9 65/65] btrfs: preserve i_mode if __btrfs_set_acl() fails
Date: Fri,  9 Mar 2018 16:19:05 -0800
Message-Id: <20180310001830.508801057@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507905443929738?=
X-GMAIL-MSGID: =?utf-8?q?1594508068616128294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -114,13 +114,17 @@ out:
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
