Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49pPlYG6/I3LHLGerF0CVOLul718rR8yLxmsCW2q56nm1d19cKrFkyuiYDEF+anc+oP1b7T
ARC-Seal: i=1; a=rsa-sha256; t=1524405912; cv=none;
        d=google.com; s=arc-20160816;
        b=ntuk+8c2StTDAZDivX8CqCjUV4Z05XUwqf6RgYQfTmqBjKliOBE3pAYHu2XG5fdR6p
         Wyf+rDPoSkl3aF8rMPYRSFEPnbR69XjHqLHRJaYXm8YxvR0jzd0n9kA7nV3rCLDYlK21
         SoE7s8OUiTPl/jmCgNFVE5eMxBzwtPhR0GybNwmO36GWK0rPnzdqoMRiNRABMC1yde//
         9OFjgA1PNcyvcU6STLo9/Hn1G5QGSvMP1n2aC+/ggVmUFORgSqdjfBFxjFhWgl7XHrJF
         AQt5KQlX7orr0DcsHCxvc2SOPYHkxE3COiJ5ym222531+Cz8CLcY5ZslMYzgVhKf8kz1
         M6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a0H/+sb8UVPfMuSOqU2heVGVHBMRtMHQ54c7SmVRBaU=;
        b=ysNslvW4uoVrAIl8XPdyhILhZlhxYI/OeaAQebpsY1+Z9Psu4ScC5wvPNtPOcQRYoC
         GB5aiZB0HWmazFpa4mK0+z/E0X9UJvN8wIA33fAFeiNYtvvPkcLuhvA49nWm/UQdA+N5
         /L5ktFiuxgtEVF+Iolkqxl+GBM43Ht5aEo5pqtGpFD3EQDF7iscn+acfvc3iAvzEPQI0
         s8D5zDW6F6ZIPD3HwWOC8qlkenwj/edkxF4F3279F6mM+Qp5LuvIeNsfj7hCG/GeY52/
         U6qluRcZVoE/eO4JlXAtakO0weBpZFGiDrDjLgJXCy5m1R/biRLg6rz5KIG5YjdERE4+
         gmFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.14 044/164] smb3: Fix root directory when server returns inode number of zero
Date: Sun, 22 Apr 2018 15:51:51 +0200
Message-Id: <20180422135137.212217675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455013219213358?=
X-GMAIL-MSGID: =?utf-8?q?1598455453901092805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 7ea884c77e5c97f1e0a1a422d961d27f78ca2745 upstream.

Some servers return inode number zero for the root directory, which
causes ls to display incorrect data (missing "." and "..").

If the server returns zero for the inode number of the root directory,
fake an inode number for it.

Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsglob.h |    1 +
 fs/cifs/inode.c    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1449,6 +1449,7 @@ struct dfs_info3_param {
 #define CIFS_FATTR_NEED_REVAL		0x4
 #define CIFS_FATTR_INO_COLLISION	0x8
 #define CIFS_FATTR_UNKNOWN_NLINK	0x10
+#define CIFS_FATTR_FAKE_ROOT_INO	0x20
 
 struct cifs_fattr {
 	u32		cf_flags;
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -707,6 +707,18 @@ cgfi_exit:
 	return rc;
 }
 
+/* Simple function to return a 64 bit hash of string.  Rarely called */
+static __u64 simple_hashstr(const char *str)
+{
+	const __u64 hash_mult =  1125899906842597L; /* a big enough prime */
+	__u64 hash = 0;
+
+	while (*str)
+		hash = (hash + (__u64) *str++) * hash_mult;
+
+	return hash;
+}
+
 int
 cifs_get_inode_info(struct inode **inode, const char *full_path,
 		    FILE_ALL_INFO *data, struct super_block *sb, int xid,
@@ -816,6 +828,14 @@ cifs_get_inode_info(struct inode **inode
 						 tmprc);
 					fattr.cf_uniqueid = iunique(sb, ROOT_I);
 					cifs_autodisable_serverino(cifs_sb);
+				} else if ((fattr.cf_uniqueid == 0) &&
+						strlen(full_path) == 0) {
+					/* some servers ret bad root ino ie 0 */
+					cifs_dbg(FYI, "Invalid (0) inodenum\n");
+					fattr.cf_flags |=
+						CIFS_FATTR_FAKE_ROOT_INO;
+					fattr.cf_uniqueid =
+						simple_hashstr(tcon->treeName);
 				}
 			}
 		} else
@@ -832,6 +852,16 @@ cifs_get_inode_info(struct inode **inode
 				&fattr.cf_uniqueid, data);
 			if (tmprc)
 				fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
+			else if ((fattr.cf_uniqueid == 0) &&
+					strlen(full_path) == 0) {
+				/*
+				 * Reuse existing root inode num since
+				 * inum zero for root causes ls of . and .. to
+				 * not be returned
+				 */
+				cifs_dbg(FYI, "Srv ret 0 inode num for root\n");
+				fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
+			}
 		} else
 			fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
 	}
@@ -893,6 +923,9 @@ cifs_get_inode_info(struct inode **inode
 	}
 
 cgii_exit:
+	if ((*inode) && ((*inode)->i_ino == 0))
+		cifs_dbg(FYI, "inode number of zero returned\n");
+
 	kfree(buf);
 	cifs_put_tlink(tlink);
 	return rc;
