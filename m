Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuBYyLpwKSu95M9l0QM9rMR/1clKBW7IlKMU4Nw7R29iBcm80YRAE4fV5x0ZIIy3l+Rdr+M
ARC-Seal: i=1; a=rsa-sha256; t=1520641184; cv=none;
        d=google.com; s=arc-20160816;
        b=yRhbZ4XylDSJ2IC2gyfYJnrPiO8wPNmdFUhFoVX3pyI0hHlJdrKe6GaPw4f15qzf0Q
         1Q9nlZZcKiOyXwovGaOnozbCQHcZ1n+FPIcrOBPWutDFcUxCY6CkMiSfE8/HWQzsZclU
         4M9pOKDNx4CO2xXk8sE0T7UAphw+xXLXheYDmFTTw7chqCmVXYEuInKlTLGkc2hZ4VqL
         ogXtgRvtj8ReHtj8BK7ahWqxhyFYWlrtd+dppkh/u0ZooSHxsxZVirBGGHxFxFvmsiPi
         kPap2lWAfBUIoDvqyIqFVSWqRMswIbkn+XS2eJ/l6zjiDkRysPOYQ7wsybSXKfXxOAJZ
         GJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1hDlqHNTd1qgwz+X2t2U4pVlrPG/ByXcO7kIDKPAKwI=;
        b=WHqQq11Jlqi+Q60eClS4qrfQzEnaPprPu5RNf28DNGZhYj1wOmJGF0IcQRlNzMTBuz
         pGW1mcF0jKsmuiSevOI0ClzF+29pYu8Wc7HoLhzWwTkiDBJG2UFdYkDsCYHM2xKG//mm
         SZ6Ta1/uUHoYY6nV4qVdlw1/K2BRFZsDBen4LX1xZllVwXpJJqmvRl3GJ3ASkfDk3f+d
         YMyJSYJSDN1zDibtwoe20MQ/UDdzkoR1uwc5H5AanpKQLdRzneSf/qI18XVlcVtjm+D9
         ssc2XrZoam/tXevtoGPwJs9QdYJnrEAsKfUMCVyeLlGVPOw2nLrsZL18tyP7/XenSDEE
         POkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4.4 12/36] btrfs: Dont clear SGID when inheriting ACLs
Date: Fri,  9 Mar 2018 16:18:28 -0800
Message-Id: <20180310001807.896983748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507851161005593?=
X-GMAIL-MSGID: =?utf-8?q?1594507851161005593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit b7f8a09f8097db776b8d160862540e4fc1f51296 upstream.

When new directory 'DIR1' is created in a directory 'DIR0' with SGID bit
set, DIR1 is expected to have SGID bit set (and owning group equal to
the owning group of 'DIR0'). However when 'DIR0' also has some default
ACLs that 'DIR1' inherits, setting these ACLs will result in SGID bit on
'DIR1' to get cleared if user is not member of the owning group.

Fix the problem by moving posix_acl_update_mode() out of
__btrfs_set_acl() into btrfs_set_acl(). That way the function will not be
called when inheriting ACLs which is what we want as it prevents SGID
bit clearing and the mode has been properly set by posix_acl_create()
anyway.

Fixes: 073931017b49d9458aa351605b43a7e34598caef
CC: stable@vger.kernel.org
CC: linux-btrfs@vger.kernel.org
CC: David Sterba <dsterba@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/acl.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -82,12 +82,6 @@ static int __btrfs_set_acl(struct btrfs_
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name = POSIX_ACL_XATTR_ACCESS;
-		if (acl) {
-			ret = posix_acl_update_mode(inode, &inode->i_mode, &acl);
-			if (ret)
-				return ret;
-		}
-		ret = 0;
 		break;
 	case ACL_TYPE_DEFAULT:
 		if (!S_ISDIR(inode->i_mode))
@@ -123,6 +117,13 @@ out:
 
 int btrfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
+	int ret;
+
+	if (type == ACL_TYPE_ACCESS && acl) {
+		ret = posix_acl_update_mode(inode, &inode->i_mode, &acl);
+		if (ret)
+			return ret;
+	}
 	return __btrfs_set_acl(NULL, inode, acl, type);
 }
 
