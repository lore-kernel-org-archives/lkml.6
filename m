Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+YNUN37ijxOjGKkJksycyUxEVbmaFwXQY0P6y5RqXvlMJyBehRFGRLlcuQPwNMS+M5T2p6
ARC-Seal: i=1; a=rsa-sha256; t=1523473011; cv=none;
        d=google.com; s=arc-20160816;
        b=MU+KTdRIVqzyr1MOCxksGe1DgZwaKdtnkG4dwp/tQfaCJ5whKLindSMcpbcCedtLeY
         tpvhXdnTg/SRSq7m0NPiwibdONAKAstPdbRCC3rURq/Md2frMgGyo0bl0IDQF+SGnQ7e
         BUudfK+sL9tEpySlTqcblY+4Q+Dd4YNcCXpIiD2hRa6dsmgOggbiW8GlfYG54in8CC1I
         zxn6o0WBMiaQiTievC6gUvyM8i3gHFFQ7kVp0EP3aG66y8UuDHDBBMt8+VJyEsIk8AhC
         h9wTCApUIsgfAhBbtkjiM5kL6k0n8I6rbj4LrEOg0fN3HAQpEyesmozCyFF/6BvfjXFs
         Hpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MgiySfdHpDeGrMoVU4ofZ1BZtraKLR1q8nmUydwO3T0=;
        b=kLVeMvtL7T53xJp/CYyBnP9tv/XPJKpA6PCT5Kb3H9EzhmDxfVeXAhKLbiE/Duh+Bl
         83yGA1VjSHei4gp+LBthmAPFqmkUS6h2IcBRv++qdN8aXRazmkKeQpTssXWwQ6nbsPKl
         OAmqBn0LrKDqaHXAJbA8Rk/qCLN9SyUPsXRySPhOH1CPZPbULvvbX7Vpher0b8COJK66
         16X/ZTWmoEkwhbQp99WwtveYb9nP3SS9nH2/zwcyfM7lRAckqP9O/3MLE6eT5SAWLY0b
         YpNYPtZBkgL0CnOYXV4RK24UetY567m2Xh9yHLa9Qc2XS9qzVLj8fB8bwkPhodsueNnW
         N7Lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephen Smalley <sds@tycho.nsa.gov>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 096/310] selinux: do not check open permission on sockets
Date: Wed, 11 Apr 2018 20:33:55 +0200
Message-Id: <20180411183626.359291395@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476669353223127?=
X-GMAIL-MSGID: =?utf-8?q?1597477236861189973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Smalley <sds@tycho.nsa.gov>


[ Upstream commit ccb544781d34afdb73a9a73ae53035d824d193bf ]

open permission is currently only defined for files in the kernel
(COMMON_FILE_PERMS rather than COMMON_FILE_SOCK_PERMS). Construction of
an artificial test case that tries to open a socket via /proc/pid/fd will
generate a recvfrom avc denial because recvfrom and open happen to map to
the same permission bit in socket vs file classes.

open of a socket via /proc/pid/fd is not supported by the kernel regardless
and will ultimately return ENXIO. But we hit the permission check first and
can thus produce these odd/misleading denials.  Omit the open check when
operating on a socket.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/hooks.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2033,8 +2033,9 @@ static inline u32 file_to_av(struct file
 static inline u32 open_file_to_av(struct file *file)
 {
 	u32 av = file_to_av(file);
+	struct inode *inode = file_inode(file);
 
-	if (selinux_policycap_openperm)
+	if (selinux_policycap_openperm && inode->i_sb->s_magic != SOCKFS_MAGIC)
 		av |= FILE__OPEN;
 
 	return av;
@@ -3031,6 +3032,7 @@ static int selinux_inode_permission(stru
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	const struct cred *cred = current_cred();
+	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
 	__u32 av = FILE__WRITE;
 
@@ -3046,8 +3048,10 @@ static int selinux_inode_setattr(struct
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
-	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE)
-			&& !(ia_valid & ATTR_FILE))
+	if (selinux_policycap_openperm &&
+	    inode->i_sb->s_magic != SOCKFS_MAGIC &&
+	    (ia_valid & ATTR_SIZE) &&
+	    !(ia_valid & ATTR_FILE))
 		av |= FILE__OPEN;
 
 	return dentry_has_perm(cred, dentry, av);
