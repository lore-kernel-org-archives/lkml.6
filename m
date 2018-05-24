Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZozQBh2+DtQW56NKDejj59+8OHykNi/rnoLfC5xXHsT23SmSHkXnzvAz7sDg95VNlQJRK0Z
ARC-Seal: i=1; a=rsa-sha256; t=1527156313; cv=none;
        d=google.com; s=arc-20160816;
        b=LcSCs+vvLoCpI5SX+JRS/8tfGrq6C+tHBCYtXjux82LZitkP0xbtKxeWusMSp5wNmr
         AX70m3PzaeyCRUo67U/7swSfCQWgkYd9A/oWmmZnI0/HjtlitGpFttVVDTgPN3Dfz1s9
         v1RDVhl+r+sIXUE6cysm23aL9zRj5fKN06pMaN31GiVT/TmX6+AHdd7Db/7DJ5XerIPE
         ZveeMvaxwMKoyYkEW7vttk2BNDfzUlSvBTJEf3w88py1cw7bF8M++4Xn2n0xcFTkJDOs
         VphuJx/XoExyRPGurGlX0Z1G0FXze3+G5kwT0Uyf3FLT/XqXmhpgVvDVIr+sHkvJVtwH
         Qsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=y54RMqiM+3ZdQBqHuxMBADug6ClwgNqmeV5udoTOgGA=;
        b=R4vEJwzcxQJ7wKreKbPPmpxWWYF8QB58uIzWSzYzyxQpmSIgH87MHp4j/hxJ2JLUNb
         OJ9FaXvMQ1iwfd9nLaUkuwl7NOFEGhwQSmg0lx2mbM8z8RdKYHt0x8BFr/jHljUkJQGL
         z84vBsCnKbOPP7ZBCc3IQwc9Jp23mHRZl2GoOhhOZMgg0vyZLCR/aCKBXYl7ZSCkTk6k
         jFz5quMJkT6ckSve4ONy3s/1lxNMXgwWWzcl2+hNzb5anbNqzSN5hX5Uj6dI8qbKI7zO
         6QuBOoZBdcYPz2Xr7OLzLJz7QVur3hq4670BLie6cF+DUVF9QOXjFVCXO+sOPU+Uoix8
         AtcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K6xbg+cn;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K6xbg+cn;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	James Simmons <jsimmons@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 096/161] staging: lustre: lmv: correctly iput lmo_root
Date: Thu, 24 May 2018 11:38:41 +0200
Message-Id: <20180524093029.941985000@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338435846457823?=
X-GMAIL-MSGID: =?utf-8?q?1601339458926123685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

[ Upstream commit 17556cdbe6ed70a6a20e597b228628f7f34387f8 ]

Commit 8f18c8a48b73 ("staging: lustre: lmv: separate master object
with master stripe") changed how lmo_root inodes were managed,
particularly when LMV_HASH_FLAG_MIGRATION is not set.
Previously lsm_md_oinfo[0].lmo_root was always a borrowed
inode reference and didn't need to by iput().
Since the change, that special case only applies when
LMV_HASH_FLAG_MIGRATION is set

In the upstream (lustre-release) version of this patch [Commit
60e07b972114 ("LU-4690 lod: separate master object with master
stripe")] the for loop in the lmv_unpack_md() was changed to count
from 0 and to ignore entry 0 if LMV_HASH_FLAG_MIGRATION is set.
In the patch that got applied to Linux, that change was missing,
so lsm_md_oinfo[0].lmo_root is never iput().
This results in a "VFS: Busy inodes" warning at unmount.

Fixes: 8f18c8a48b73 ("staging: lustre: lmv: separate master object with master stripe")
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lustre/lmv/lmv_obd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -2695,7 +2695,7 @@ static int lmv_unpackmd(struct obd_expor
 	if (lsm && !lmm) {
 		int i;
 
-		for (i = 1; i < lsm->lsm_md_stripe_count; i++) {
+		for (i = 0; i < lsm->lsm_md_stripe_count; i++) {
 			/*
 			 * For migrating inode, the master stripe and master
 			 * object will be the same, so do not need iput, see
