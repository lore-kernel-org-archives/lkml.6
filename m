Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226sdXdpuBkaduPAaC91dnWQdES4v7TCZGRsHEwFGrup+RZipkxahq31oSAoKX0oqfCIZbhj
ARC-Seal: i=1; a=rsa-sha256; t=1518323637; cv=none;
        d=google.com; s=arc-20160816;
        b=u+XVhBaIPxScxsg6YtJyUrgIHXzuO7IgTJlYPk+jEwAGpoUjYbQSehMQ9TfDUrei5d
         FTf/p8C7OFH2p3QuGGi+HPWd6xNFrehOBzbU2z3zrudnkPWyixFwZfzZehXDKS7XXuxq
         w/vAlM4+S5AGsgxcs3blPKyOa2YmW3HOsugMelDAV0+dj3TfDdESRRvY+Co4F5rXiyx1
         +ZjjjEE4NSdglLHLckqTKZyt3+rzTHD37Vjvu9T1K7OP1Z6SJMc6FbKCHazbUBDh9m11
         L3hWSFPQuLWbP/hzxIcEd6XhgPlNYGxyu00Gun7Yz4LckLkqA/Zqnlwy1Id+LmrgrIma
         X3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=2Qlus5P0pNRzZmc78recbGC+YG2thsoXTfhHFB9UWsA=;
        b=n85QkzN5A0eueKVUq4sIkwUSXF2qz1wJnVg+WQ/9eiBzCZObwwLPPCE6wT9zjXY33f
         IdjRgihlZTz/XOdAFUOsHdcpqmyzboxjtCOGN0reUvHNK5BHgUvsQ6Eaon+ZL9of7PJS
         jPAK1M4ytI/xthM2muloh6TymSxF/bheC3OsFgJRD+UCfodvY8uQuNsBcXbMG1k1CH7Y
         wfnDQkSoDltjd7kO9snKKlpTwflvPBj3Z1ry74Nh9+ZtOvJJLKMEQvTI75sL3fXESxMk
         stK4eJCsbgr1HUzPwVeKC6RMKL7R8mClb3n8Jhmfg6XLcO4UVhG6UUs3b2lC76cQnLkr
         oAMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Andreas Dilger" <andreas.dilger@intel.com>,
 "Oleg Drokin" <oleg.drokin@intel.com>,
 "Peng Tao" <bergwolf@gmail.com>,
 "James Simmons" <jsimmons@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Nadav Amit" <namit@vmware.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.173295807@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 002/136] staging: lustre: ptlrpc: kfree used instead
 of kvfree
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077727067359977?=
X-GMAIL-MSGID: =?utf-8?q?1592077727067359977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit c3eec59659cf25916647d2178c541302bb4822ad upstream.

rq_reqbuf is allocated using kvmalloc() but released in one occasion
using kfree() instead of kvfree().

The issue was found using grep based on a similar bug.

Fixes: d7e09d0397e8 ("add Lustre file system client support")
Fixes: ee0ec1946ec2 ("lustre: ptlrpc: Replace uses of OBD_{ALLOC,FREE}_LARGE")

Cc: Peng Tao <bergwolf@gmail.com>
Cc: Oleg Drokin <oleg.drokin@intel.com>
Cc: James Simmons <jsimmons@infradead.org>

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: use OBD_FREE_LARGE()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/lustre/lustre/ptlrpc/sec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/ptlrpc/sec.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec.c
@@ -867,7 +867,7 @@ void sptlrpc_request_out_callback(struct
 	if (req->rq_pool || !req->rq_reqbuf)
 		return;
 
-	OBD_FREE(req->rq_reqbuf, req->rq_reqbuf_len);
+	OBD_FREE_LARGE(req->rq_reqbuf, req->rq_reqbuf_len);
 	req->rq_reqbuf = NULL;
 	req->rq_reqbuf_len = 0;
 }
