Return-Path: <wang6495@umn.edu>
X-Google-Smtp-Source: AB8JxZoxjHIDxLUYdr7T8W46ltccC3GR/+VWB3Mb1QmhhA3DLRm5l6kNZ41rqYk13JVSMiKHkvhS
ARC-Seal: i=1; a=rsa-sha256; t=1524872726; cv=none;
        d=google.com; s=arc-20160816;
        b=bY4bbYmJL5CcLDLAozecTDC7H6nMuKpaivswEczNlpqSrqEhPcHlyUnyuQ+3hY+bpY
         u6aM7IhV1/JxWle14cF/KutjjDyIvIJqCMG76lknUWP8rK0qaQJVnRaOnKRyDPszFElQ
         +RIUlmjQCpzkR9Xx9saFhpPE4NxKTbcYyUvFPFHiVHX59/qnKAReXP314qFNF5KSCjpu
         fdI15cV8fKjC7mCuqEhOuYLQC8uhM5y/Clmnv+vtkUIquJLv/aRny/yqdkr9qSijbQ93
         mW3Pw/EHlJ3GhdL4VxoAZdVXzbBlw5NiKGaOyBt8KHjdALxCjZLDLySp+inMU5ZRy46q
         5KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=q6Gl4P0CS2e1mHpsBuKQbf3BnjL1gzgkxiAFGLyVcGk=;
        b=EM49hS6qSXbqi1E4GtAZmTyaac42L4OqRQZrsoPBoi1X0tmA8GIkCl4yUHnkvEnxWq
         4EYAakGVvR9yEYpD2mrmqmCXKDQxK4o4NoG+rVmedVj8G9ckk22Kem+8DnMPJiUiX6My
         6AL7yWRddHjxvgTLomHR35zWZB2czhMMSgfUeZSK8Tx1LxOoricQ6bv5i5zQ6cVQzFDr
         x1VjD0pfiBZUqaGr1yJk+Zny5Uo+K9MfPJ4m4Ujy4wb78HhyGsmcSUI3NjzVDHpn/AG0
         dbVs2JFh+KWkDPjJjKPOx/wVFn9vRgFj1vmsydv/0gEWnUL52fynErLaCA6Dky02zz2j
         kVJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=MWX7585D;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.206 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=MWX7585D;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.206 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
From: Wenwen Wang <wang6495@umn.edu>
To: wang6495@umn.edu
Cc: kjlu@umn.edu,
	Oleg Drokin <oleg.drokin@intel.com>,
	Andreas Dilger <andreas.dilger@intel.com>,
	James Simmons <jsimmons@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ben Evans <bevans@cray.com>,
	Aastha Gupta <aastha.gupta4104@gmail.com>,
	NeilBrown <neilb@suse.com>,
	Jeff Layton <jlayton@redhat.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	lustre-devel@lists.lustre.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: luster: llite: fix a potential missing-check bug when copying lumv
Date: Fri, 27 Apr 2018 18:45:02 -0500
Message-Id: <1524872704-13391-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598944943578176100?=
X-GMAIL-MSGID: =?utf-8?q?1598944943578176100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In ll_dir_ioctl(), the object lumv3 is firstly copied from the user space
using Its address, i.e., lumv1 = &lumv3. If the lmm_magic field of lumv3 is
LOV_USER_MAGIV_V3, lumv3 will be modified by the second copy from the user
space. The second copy is necessary, because the two versions (i.e.,
lov_user_md_v1 and lov_user_md_v3) have different data formats and lengths.
However, given that the user data resides in the user space, a malicious
user-space process can race to change the data between the two copies. By
doing so, the attacker can provide a data with an inconsistent version,
e.g., v1 version + v3 data. This can lead to logical errors in the
following execution in ll_dir_setstripe(), which performs different actions
according to the version specified by the field lmm_magic.

This patch rechecks the version field lmm_magic in the second copy.  If the
version is not as expected, i.e., LOV_USER_MAGIC_V3, an error code will be
returned: -EINVAL.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/staging/lustre/lustre/llite/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/lustre/lustre/llite/dir.c b/drivers/staging/lustre/lustre/llite/dir.c
index d10d272..80d44ca 100644
--- a/drivers/staging/lustre/lustre/llite/dir.c
+++ b/drivers/staging/lustre/lustre/llite/dir.c
@@ -1185,6 +1185,8 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (lumv1->lmm_magic == LOV_USER_MAGIC_V3) {
 			if (copy_from_user(&lumv3, lumv3p, sizeof(lumv3)))
 				return -EFAULT;
+			if (lumv3.lmm_magic != LOV_USER_MAGIC_V3)
+				return -EINVAL;
 		}
 
 		if (is_root_inode(inode))
-- 
2.7.4
