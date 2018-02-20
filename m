Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x225pchIJPw6LB1EUcpyxdxH2LW0e6UbkOyMrfbHSvTMZvRc8jnIkh6+BiNXqFymSXqKP0ywZ
ARC-Seal: i=1; a=rsa-sha256; t=1519093588; cv=none;
        d=google.com; s=arc-20160816;
        b=PCYYd9VN5vjRnViDNpW/hwwDsEzwvya3XWk8YzXD7g0AP1zasOv+n36pHnByBejyPL
         DFclv1ad1kgXG0om4kSB5UU3joQThJW0Iws+2kCi3A67WoCK7uWk7jOOviScfgcFo4Z6
         /vXUzioMoY2bJ0HDfmA2stm/uTuT7y1FKJmIqxcIcUBzAFryAVGlw+5TvOaxsfvXN7lu
         8IveF7E4z3AxtNl5Ot2xA+fMEpvJ2dVGypHkVOH706T8uACFomHZLCbEhwkBaP0OHEG6
         P3G7xc7ZTYzKyUJlC/iyUTOKR/DJ5UJOuS4UWYsxph8vlmodwsY9WbVS8w9/weGJX15l
         wOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=JPGsueUQq3yyPiEpPoQr5h7eDCQ/P2gOT4KnKbCc2Fs=;
        b=XgjFnVZPpN8/FpunsQt3luefEOpyE8fu1E+GY0PIXz3QlloXucJfDXm+NnfWgLvFlX
         +TNRyTIiAUwBm6oZlN/Q0Jz+JtQFrz4LMqcsGea8GnSHQcqrbMEIDi8mzzRO8Mq2QE8m
         4194ufghPiuEfHdfYjnc9WMAM6lgl1MCNJpAMhh+k3OHBMDNSHpKDd6OUFAayz8dw8p/
         ygSwLf+g13UEMwD4iEAodTiYjiL/fd8mrMxcQavo3KolTjkzCqiMGXRRXx0E4MQH6W69
         Ro+WamI5YM40txVWCMiBhrHdp26FvPPbvrRZTU60Y1AbOnNBWLgD+F1EJAeQdDyStghv
         17rA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:38 +1100
Subject: [PATCH 18/21] staging: lustre: fid: remove seq_fid_alloc_fini() and
 simplify
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341816.25814.6263195320580542505.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885078575430232?=
X-GMAIL-MSGID: =?utf-8?q?1592885078575430232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

seq_fid_alloc_fini() is tiny and only called
from two places in the one function.  We can move
both those calls earlier and merge them so only
one call is needed.  At that point, there is no
value added by having a separate function.

Also instead of using ++ and -- on ->lcs_update to
toggle between 0 and 1, explicitly set to 0 or 1
as appropriate.

Moving the locking earlier means that the code which updates
seq->lcs_fid is now protected, so
ldebugfs_fid_fid_seq_show() now cannot see a torn value.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/fid/fid_request.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/lustre/lustre/fid/fid_request.c b/drivers/staging/lustre/lustre/fid/fid_request.c
index ef9ee5426151..6e0dfe18ef5f 100644
--- a/drivers/staging/lustre/lustre/fid/fid_request.c
+++ b/drivers/staging/lustre/lustre/fid/fid_request.c
@@ -192,14 +192,6 @@ static int seq_client_alloc_seq(const struct lu_env *env,
 	return rc;
 }
 
-static void seq_fid_alloc_fini(struct lu_client_seq *seq)
-{
-	LASSERT(seq->lcs_update == 1);
-	spin_lock(&seq->lcs_lock);
-	--seq->lcs_update;
-	wake_up(&seq->lcs_waitq);
-}
-
 /* Allocate new fid on passed client @seq and save it to @fid. */
 int seq_client_alloc_fid(const struct lu_env *env,
 			 struct lu_client_seq *seq, struct lu_fid *fid)
@@ -230,14 +222,18 @@ int seq_client_alloc_fid(const struct lu_env *env,
 		u64 seqnr;
 
 		LASSERT(seq->lcs_update == 0);
-		++seq->lcs_update;
+		seq->lcs_update = 1;
 		spin_unlock(&seq->lcs_lock);
 
 		rc = seq_client_alloc_seq(env, seq, &seqnr);
+
+		spin_lock(&seq->lcs_lock);
+		seq->lcs_update = 0;
+		wake_up(&seq->lcs_waitq);
+
 		if (rc) {
 			CERROR("%s: Can't allocate new sequence, rc %d\n",
 			       seq->lcs_name, rc);
-			seq_fid_alloc_fini(seq);
 			spin_unlock(&seq->lcs_lock);
 			return rc;
 		}
@@ -254,8 +250,6 @@ int seq_client_alloc_fid(const struct lu_env *env,
 		 * to setup FLD for it.
 		 */
 		rc = 1;
-
-		seq_fid_alloc_fini(seq);
 	}
 
 	*fid = seq->lcs_fid;
