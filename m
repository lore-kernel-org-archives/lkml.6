Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226fSuFZNSxTpoYO3p1CJqNGjNDbPnEILzkuNbLybIw5hVhoKsOcX9sgMS+ifwqVQMJvL+z7
ARC-Seal: i=1; a=rsa-sha256; t=1519093601; cv=none;
        d=google.com; s=arc-20160816;
        b=O1FwV0DnYXaVgA8EA+dLfF3i7Q2vcrXL2LH2I2KRXAl2wfmDem0ZuwfN9BvJVyJx91
         b1x9rVzvrFhSHebukrAvY9MmQFDrPyf+AqDHLij2Jo+cex7XUDw2EMnQHoa3rPQatSJq
         j5Hv7DN5/46t3KWWJL/0D/WqFkD4elGN5EnRP8uFOldOYS906Fp05y/BKrN9EW8uQNMh
         svrDMX5f4rBfLiXtrBWNb73tvIrfAjhwrXudlr0ZDSycp3qr9v271hxicy1TM/TvWVqj
         +c0ufR2saVVWdeKEau/uE/AUMfFNNXHoJAavcJ06jnvQf7UaAZz0xnWihrvgHK6xTmFY
         mzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=8pXxPROLg4kA01FVFwI577+If/ZY21khPMLD0JjpQd8=;
        b=iZYm8wt7gRMPiakWcNbQ4btyPmAWfsKbIEdQ5SwmPj/5uytZY2GIGYlgSvA5bE47At
         p8EKF5PBLSdddYLC6/JZ4fzMhg3nGSKxLoLV5Gdacebqn6OM2gsruLTBFfJcQxGvb3Kj
         qShF5tj3dCwnRPe7TWRX+0pfLsBNq7kOElh0zmeyYQXiICSN+sp1ZuSnoAFrL00p3rGJ
         IAC1Wyyw0SvHgYi3QhittYmnHPNh6xw9TZGMmXHda5M+VSkUjjXAdGmDV7HPfp1AdbaJ
         /FevFUrGeXxyXP6MyJ8t2Sr8RA4/628vwsdPIZ1ssa0nAc1QoGTCB8ndvXwbwV9gpnRb
         ejtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:38 +1100
Subject: [PATCH 20/21] staging: lustre: fid: perform sanity checks before
 commiting
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341823.25814.12569503440862267846.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885091860113848?=
X-GMAIL-MSGID: =?utf-8?q?1592885091860113848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When fid fetches a new range from the server, it commits
to it (*output = *out) *before* performing sanity checks.
This looks backwards.
Don't commit to a value until it has been found to be sane.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/fid/fid_request.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/lustre/lustre/fid/fid_request.c b/drivers/staging/lustre/lustre/fid/fid_request.c
index 6e0dfe18ef5f..fa23423eb8b3 100644
--- a/drivers/staging/lustre/lustre/fid/fid_request.c
+++ b/drivers/staging/lustre/lustre/fid/fid_request.c
@@ -118,22 +118,22 @@ static int seq_client_rpc(struct lu_client_seq *seq,
 		goto out_req;
 
 	out = req_capsule_server_get(&req->rq_pill, &RMF_SEQ_RANGE);
-	*output = *out;
 
-	if (!lu_seq_range_is_sane(output)) {
+	if (!lu_seq_range_is_sane(out)) {
 		CERROR("%s: Invalid range received from server: "
-		       DRANGE "\n", seq->lcs_name, PRANGE(output));
+		       DRANGE "\n", seq->lcs_name, PRANGE(out));
 		rc = -EINVAL;
 		goto out_req;
 	}
 
-	if (lu_seq_range_is_exhausted(output)) {
+	if (lu_seq_range_is_exhausted(out)) {
 		CERROR("%s: Range received from server is exhausted: "
-		       DRANGE "]\n", seq->lcs_name, PRANGE(output));
+		       DRANGE "]\n", seq->lcs_name, PRANGE(out));
 		rc = -EINVAL;
 		goto out_req;
 	}
 
+	*output = *out;
 	CDEBUG_LIMIT(debug_mask, "%s: Allocated %s-sequence " DRANGE "]\n",
 		     seq->lcs_name, opcname, PRANGE(output));
 
