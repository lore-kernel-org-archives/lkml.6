Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48fMfZX1CQ9LemAJxaiETgsjubh4MydF0gmU6RsxeBOEVNfSPvJ38X0PkX2H2MvOoPWD01s
ARC-Seal: i=1; a=rsa-sha256; t=1524406346; cv=none;
        d=google.com; s=arc-20160816;
        b=zwdZGdwe3SyJ7uK2JpzzZlOa3QJQDeATvwdmJsXC3BwrRE9ngbYA6aqWr5JGmYW4U/
         sNbuE+UDz2t7c8xrsi7o24+cIHgdVT0XR+RXqAhlyoN8IOpjMMFvfqRzgr97XJqJeNfj
         cjUlY9ax1/WAYmvm1QCGWZX/Ddk8DIVT+VT/DcS+8olk/eqHzb3wenKOqQPeIAvtOsx8
         +7absBiYzT15t8VkPjaVCoGeJqk5XSWeMc4DOPiKLYMOWlqD1flL9cNU+d21naO+DUbR
         bFVUjuJyv5W/JE28A+skQNs2vzAkF2dFM/07WoaNK0oe5K15LufAAei5U3CKqd+C75Ac
         GdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=C97/RWm4/2ci6jyQZmlg4Wy1vyJ90FfImc+C/HfdGZM=;
        b=dWtS6KC0XOY46PvaSiMCypUzk+du+Tivr4WEpM+y1uTT9z+b7k/I34YBvv2ZqdZzqn
         C/laD/cwzFziKFrAR1euNkED+tQh+bTMMUJseoOqGTMLyKDUPPyb1ePEoScdiOD113vJ
         tSBpeSQZyZcwYxv/ykQRXLyBMO/3u+QqIyqsgSzvvyg3xNni322sfHnP9JOwRnrvh82I
         5ZyLGrmCnFqxlRqEEaRwUe0aFF7zz+5WmzFijNDxoGRlhNX2Gk6RdidwR9LIZApS4Zh/
         4heueRSUkWTf54z5EGH36oL9Q+K+dLAYLGXAlcDCFm6Gff1rTFhA8giLFTnckCQN24Ai
         FWow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wen Xu <wen.xu@gatech.edu>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 38/95] ext4: fail ext4_iget for root directory if unallocated
Date: Sun, 22 Apr 2018 15:53:07 +0200
Message-Id: <20180422135211.979705732@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455030517761315?=
X-GMAIL-MSGID: =?utf-8?q?1598455909103468345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8e4b5eae5decd9dfe5a4ee369c22028f90ab4c44 upstream.

If the root directory has an i_links_count of zero, then when the file
system is mounted, then when ext4_fill_super() notices the problem and
tries to call iput() the root directory in the error return path,
ext4_evict_inode() will try to free the inode on disk, before all of
the file system structures are set up, and this will result in an OOPS
caused by a NULL pointer dereference.

This issue has been assigned CVE-2018-1092.

https://bugzilla.kernel.org/show_bug.cgi?id=199179
https://bugzilla.redhat.com/show_bug.cgi?id=1560777

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4493,6 +4493,12 @@ struct inode *ext4_iget(struct super_blo
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
 
+	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
+		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
