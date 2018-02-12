Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x224phT45xC/tyLnYy83dUrHAmt5acIMJKRgQcInt4dVnqwH3ctkIfFscY3Qg21e4TS3gZWST
ARC-Seal: i=1; a=rsa-sha256; t=1518469831; cv=none;
        d=google.com; s=arc-20160816;
        b=Drv7zs/NSuGVuEgpvR+nbdTGfTbp9acjM7OIZbb5oz/CIs4ehXGSTcwLGVquzjL5zY
         aslLGERm/ZlFx/Ihq0aN45DlzPCRiQv10+oXgPrmQ96qQf6x29eb00J3TS+zBpiirJCI
         a+1CdiyMuX4RtVeSN6k+BAE8ZLDYp94es6USMo7TMtXROTjMdR3P28Cru5/HbU9OCIJi
         LTKOlSvaGhG18UJayluoZRCnxluftLqIgOPjB0s+DqU3s6FTtd8LZW8WhC8CnWYHv71v
         xoBSIH2+Ei4Jts3r0jWTMKxX2xTc0IPCxda9/hBF/ia8IkqmuM9p0hWvzn5cGOZI+boG
         dTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=eOCCKHbBZTT1OcIouDm7rQGZCA9cOpwbL4tBpORKdM0=;
        b=bzMnmneVZTEB2ru6WDMB3elbUDL6iaIrA4b6DGY10PDGq6+QgrkBMLPz4uQwpb1PPd
         4MNrz+6af0GnxrDbwm85QtCIJNG+bdc4jbR2v3W9j6Tahk5s+NZToc5TG6OcIkkG69i8
         RY3FrpUZGOLW8OEUgwX1j8GkbNXn8Fj7lBO3hdjqkpTuuVb00Uuq1f4Ods4OubUPhQ+B
         JvvUPrvaOBjPgQWut0AfIOkt9blwBOrpTi4DgjdMJwfyQWi0bqMGzNgkF00ILPs69a8L
         NdxnP0sKzqFFqAeBWB4CpFp92WDZpQz4KD1JZizlS0NyWjE+SjcN1FIkZ29flw42ktN0
         Eqxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:09:25 +1100
Subject: [PATCH 2/2] staging: lustre: honor error code from ll_iget().
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151846976581.17168.2838881093184873250.stgit@noble>
In-Reply-To: <151846966702.17168.15765227765350491300.stgit@noble>
References: <151846966702.17168.15765227765350491300.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231022616034580?=
X-GMAIL-MSGID: =?utf-8?q?1592231022616034580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 020ecc6f3229 ("staging: lustre: llite: Remove IS_ERR tests")
changed ll_prep_inode to assume any error from ll_iget() meant
-ENOMEM because at that time it only returned NULL for errors.
Commit c3397e7e677b ("staging: lustre: llite: add error handler in
inode prepare phase") changed ll_iget() to once again return
meaningful codes, but nobody told ll_prep_inode().

So change ll_prep_inode() back to using PTR_ERR(*inode).

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/llite_lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index 6735a6f006d2..020f0faeb750 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -2143,7 +2143,7 @@ int ll_prep_inode(struct inode **inode, struct ptlrpc_request *req,
 				md.posix_acl = NULL;
 			}
 #endif
-			rc = -ENOMEM;
+			rc = PTR_ERR(*inode);
 			CERROR("new_inode -fatal: rc %d\n", rc);
 			goto out;
 		}
