Return-Path: <srivatsa@csail.mit.edu>
X-Google-Smtp-Source: AH8x2266rO7Ef7eFe6SZk+snbx+uMRixiQ9WoGIXZdaBOcw02GLQvFsY0vlE3NhTvH1v+8aWbgri
ARC-Seal: i=1; a=rsa-sha256; t=1517883917; cv=none;
        d=google.com; s=arc-20160816;
        b=uQfgg1R1ejGDqo2W2EmWhrLGepSVUhWYQ6H4waZyeMS77hLKRaB1DVLvin53vh8dJC
         iLzk4rLSYuNI16uOrigIDLknfLL7crhF9qraDCe6knsJ0GiK7YEXq7jEt/Q5K56fHCFs
         4eYg293PBH2lG5hzmJtRpcxbcfWuf2Odhx0zrVClxk6scsGZCSW+spM7ZO15ffSIO9as
         SYgegAEw1+NxNrYyuFL0umYgjjCfaF/r6ZsGL1pGdK6VeaAJa5GgnkA3IEpLCT3SuYaB
         v/JuPqh+aM+craxJ/hAA1VS+rvkMyBv9r9PHOAMovKe0e8P9yqTezYidnnf/iCQd5zGJ
         sNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:arc-authentication-results;
        bh=HZhqYiJY62N6lMqvHyC2I2DpmboRIaTfAkcVO5muy0I=;
        b=LT7g5MZKxl4lLTtNEQWqvLIx0LcFvuk9HkVGpfORjkQX9ZMxFGqw96qPjZUp/j3z0e
         c+iksXCzkYUHLE4zsIVT/Fb8ABwtZutk0Mw5H7IetInWNg5o7ZVdPLStWVxtdWgnYPvR
         oIzR5aPsf/dGkXY9NtbeBvk3ZV2KCgwDpqUZKxoSDIY3sxanE4cQn/SIGuFVhxUJpobG
         ke5eB0od1QqhdBMR72gRTE4UGNyqZw/l+parsK+4F2AGTBk4JCvtJ5S3rTTAgmmB+gGP
         QziGMBjXGyyMVyrBHx65Jpu6Xk21Y1+jKkMtdQ8tiLt11lnNAerIpI6OLftcVph5BjFr
         Gz6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Subject: [PATCH 1/2] char_dev: Fix off-by-one bugs in find_dynamic_major()
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: gregkh@linuxfoundation.org, logang@deltatee.com
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 srivatsa@csail.mit.edu
Date: Mon, 05 Feb 2018 18:25:09 -0800
Message-ID: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591616647486250157?=
X-GMAIL-MSGID: =?utf-8?q?1591616647486250157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>

CHRDEV_MAJOR_DYN_END and CHRDEV_MAJOR_DYN_EXT_END are valid major
numbers. So fix the loop iteration to include them in the search for
free major numbers.

While at it, also remove a redundant if condition ("cd->major != i"),
as it will never be true.

Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---

 fs/char_dev.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index a65e4a5..33c9385 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -67,18 +67,18 @@ static int find_dynamic_major(void)
 	int i;
 	struct char_device_struct *cd;
 
-	for (i = ARRAY_SIZE(chrdevs)-1; i > CHRDEV_MAJOR_DYN_END; i--) {
+	for (i = ARRAY_SIZE(chrdevs)-1; i >= CHRDEV_MAJOR_DYN_END; i--) {
 		if (chrdevs[i] == NULL)
 			return i;
 	}
 
 	for (i = CHRDEV_MAJOR_DYN_EXT_START;
-	     i > CHRDEV_MAJOR_DYN_EXT_END; i--) {
+	     i >= CHRDEV_MAJOR_DYN_EXT_END; i--) {
 		for (cd = chrdevs[major_to_index(i)]; cd; cd = cd->next)
 			if (cd->major == i)
 				break;
 
-		if (cd == NULL || cd->major != i)
+		if (cd == NULL)
 			return i;
 	}
 
