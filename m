Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49T6VCpwRYwS+lj1noNToCJKaKR1ODsKSZ/0+0hXas17Mnd5jw3lphDRVLeAOuLgVRs6j4N
ARC-Seal: i=1; a=rsa-sha256; t=1523980908; cv=none;
        d=google.com; s=arc-20160816;
        b=pQkvAD2H+Uq/tMWnThAFm9hlavnfnmaKFGCEefoQnJShjAMJMqaPTQVwaOJrQ9JTTb
         d9PFKDVMBSXlSgyneo6YU+3ZgJDmefQfgKhv5iu3I0RXUEAVUm6IuOSlUXzofzn0/1Ky
         6g8gDKMunxxRnDkMYAWHWmFnAo0116tfwjTF/BdFymqKJsrWgLja+b43VmaYx3kYlhKH
         7f6gyunMYgLlElHdt+t4RRJTSJFk8K/WyjxzoEzBsMwov0ptdLpm6pG/TgL+u+kdPR10
         4Q8ZrqbsRXBhltOxwqGVuLpUxLOI5+EnjMbH1VbPCuv2KScsJve7IgjGw/I3x+BepesQ
         O9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BK2Fwl419cQ6m9BbfYr/q2jKAQ/7r7nCXZ+vf9Q+MIg=;
        b=deiIy3tlbfDSqi3sngbGHgpyQVd1tQuP4OsQ9feHStkefWeHn4+1RGee5++Ah3fvU4
         iSmmYIsD4s5y47vQmVpOvDakGLOnzLiiIJmJ+nbDy4AXMQr6kt6j3fKL2BGWFaIvlmUU
         tNEo9oKd5CJRyv3CIc00iq/k5yBipyoWS6LfS1QkkAdaQ9TjIAWRiGMzULEabDFCzc0S
         OMeuudXwIUPve38eCOhudr0W6v2r32HK856XmQPIgXVwIWS9dC7srZ98idUf0pZKhI2e
         omFPB+kqP6aiPhOgPROk8mciiF9fLlpvgnu4ltAzv+o5sxwWau9yHJ1YQHsX5g1xLcEd
         rjKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.16 47/68] ovl: set lower layer st_dev only if setting lower st_ino
Date: Tue, 17 Apr 2018 17:58:00 +0200
Message-Id: <20180417155751.259519123@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009805628929096?=
X-GMAIL-MSGID: =?utf-8?q?1598009805628929096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 9f99e50d460ac7fd5f6c9b97aad0088c28c8656d upstream.

For broken hardlinks, we do not return lower st_ino, so we should
also not return lower pseudo st_dev.

Fixes: a0c5ad307ac0 ("ovl: relax same fs constraint for constant st_ino")
Cc: <stable@vger.kernel.org> #v4.15
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -118,13 +118,10 @@ int ovl_getattr(const struct path *path,
 			 */
 			if (ovl_test_flag(OVL_INDEX, d_inode(dentry)) ||
 			    (!ovl_verify_lower(dentry->d_sb) &&
-			     (is_dir || lowerstat.nlink == 1)))
+			     (is_dir || lowerstat.nlink == 1))) {
 				stat->ino = lowerstat.ino;
-
-			if (samefs)
-				WARN_ON_ONCE(stat->dev != lowerstat.dev);
-			else
 				stat->dev = ovl_get_pseudo_dev(dentry);
+			}
 		}
 		if (samefs) {
 			/*
