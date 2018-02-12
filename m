Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227nP2dOybSO/JTV74xXkiVG9Lzze7MzViiGxfbevtma87/c7Us2E64fJfVynvnVuqZiEqr+
ARC-Seal: i=1; a=rsa-sha256; t=1518469824; cv=none;
        d=google.com; s=arc-20160816;
        b=WAM2bUp9VqN5wNnZQ4cTU0fFuscWDw0MpqI3SaqcQppl1Vle0uyH47lcjahXj61kAX
         V/gJxG0HR/cpkMb7HwDlzsBo68DmuXr3bSTFPDKVzcW4kraeClVMYmkcyz8xscp8PNGL
         Y2l6yHHJOR8MeHH84kJK5E/9pV5Ckvvvmz02nSiVyF4h1cf7NL+iS8768+jd3a6bBzVg
         XcX/EA4HrX8QdF50x94ADcoIIm+KlCdCikW2LkQhGZLgdGRuVKeuyMbD12fHvskvkgfa
         9DQIjKUsvcf29Qt4nhtIfGRTmqnFKg/JRlvpOd3LQ/r28Tb+Q0kdRyyyd+THSbLfZddG
         Vahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=9mM3/nuE9UzfERWz477nvAQVN1efDonDgjeia5fGrlU=;
        b=mWXYn21YH3eaw3RsLz17ef6lorPjQFFhXzJEqgvItCw6CoWLfrVo2C28jV1SHm+5W9
         BvhY8erTK2bcmZvLw3yFoZWODP4A/SHk6BqYA/QE4osBXJx/53py+rfvXdYTjJmsDWnd
         n1yd0FZcG2dvKlQ8E35cdwP3VdnZ2VmFjOMywKi5gMq/dXu556mrX8XuW13Xt5Jfgx/J
         xedhRd3I8Gv1xQ0V7ZY6Pjg9NzG4mr9G1BU6VO2eNvknSwdK/yWAO49dR2ipnoTBdv40
         cfRMlzeLU1x9GgEeM5py8QobWNOMxh3Zdq/jDl8S1wUlcLNMkodyJdnDgeubxvpbdvkI
         jFkA==
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
Subject: [PATCH 1/2] staging: lustre: fix inverted test on strcmp
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151846976573.17168.10557259719846165376.stgit@noble>
In-Reply-To: <151846966702.17168.15765227765350491300.stgit@noble>
References: <151846966702.17168.15765227765350491300.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231015095635167?=
X-GMAIL-MSGID: =?utf-8?q?1592231015095635167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This code tests various fields to see if they are different, except
for one where there test is if they are the same.
This is clearly wrong for a function that is tesding for equality.

So change "!strcmp()" which I always find hard to read, to
"strcmp() != 0" which obviously means that the strings are not equal.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/include/lustre_lmv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_lmv.h b/drivers/staging/lustre/lustre/include/lustre_lmv.h
index f4298e5f7543..080ec1f8e19f 100644
--- a/drivers/staging/lustre/lustre/include/lustre_lmv.h
+++ b/drivers/staging/lustre/lustre/include/lustre_lmv.h
@@ -63,7 +63,7 @@ lsm_md_eq(const struct lmv_stripe_md *lsm1, const struct lmv_stripe_md *lsm2)
 	    lsm1->lsm_md_master_mdt_index != lsm2->lsm_md_master_mdt_index ||
 	    lsm1->lsm_md_hash_type != lsm2->lsm_md_hash_type ||
 	    lsm1->lsm_md_layout_version != lsm2->lsm_md_layout_version ||
-	    !strcmp(lsm1->lsm_md_pool_name, lsm2->lsm_md_pool_name))
+	    strcmp(lsm1->lsm_md_pool_name, lsm2->lsm_md_pool_name) != 0)
 		return false;
 
 	for (idx = 0; idx < lsm1->lsm_md_stripe_count; idx++) {
