Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48eVgiJAeUplCMrnMiTuv+ZgQw5vC+N6YyfZr08fPygaFyAZqKzEoBZy6KGdoml2dWK8bq8
ARC-Seal: i=1; a=rsa-sha256; t=1522168227; cv=none;
        d=google.com; s=arc-20160816;
        b=KQ+Y9nriTC7E/be4i2z9pd7Gzk+AfdyIKqdGzSP6QiEAcKYVrJ/8ZryH+58TCIqOB0
         f3qVFLNn4uloAaG/mmnFz0tlVcXpTl5yguxNWnVGOeFvL/cFfPImfYzwYJUzbh6XzIth
         PJCQcsPyldV0fer5mcxvDYHgeZdgUvrOs4h8qEKHw7oHhzm3LAj5F67B22rVskhmzWph
         E73DaAT7Ivc2ni562NSRJVdmetUg8M2zKFEFBNJBG9xTGKQaVQDhsQqOvEBI1G4bJ4jZ
         QftErusiLhw/8b3glvCbgqpdtJ7kfO7/6RyzF6INoV458WzlzYdhm0hx9F5x8npN5d+Y
         EsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XwAYKaf6vYgFJ1wRyZfGjzFNZ7O2Pzo2aEJO+bJXQiM=;
        b=XLE6Yk02ECP/qgchlzF2/NXveY1QIkVF5zvsVLI1nHdWEB72sKPES70OWJiv4bI8Vl
         EnWLvzYykVQ0KuuzsdWE3i6Xnc4MTVOLNIbFEr9r1SMUmoQf/0xXi0N9ZWt9TzTWcGXL
         lek0KrjZANACqsUiCGIRIAnfWNqCTzkPknHJ5zfMyyRPFLB866oXqpn6mwr+6JaO7zdC
         Aq6sfz1DdP+/2Xd6l7Aag5OSMLe3FI1/LM6x9Bx5CNu1fEza9eZK93eovzqxG0kBXdg1
         ZGKhrblwOK/YG1ZSuqZlylgW+tCWoQREz68yP56xJDx5VPsECkQLEm2fySc/L5ZB7jSB
         pzoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peng Tao <bergwolf@gmail.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	James Simmons <jsimmons@infradead.org>,
	Nadav Amit <namit@vmware.com>,
	Andreas Dilger <andreas.dilger@intel.com>
Subject: [PATCH 4.4 40/43] staging: lustre: ptlrpc: kfree used instead of kvfree
Date: Tue, 27 Mar 2018 18:27:44 +0200
Message-Id: <20180327162718.644716725@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109071523353050?=
X-GMAIL-MSGID: =?utf-8?q?1596109071523353050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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

---
 drivers/staging/lustre/lustre/ptlrpc/sec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/ptlrpc/sec.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec.c
@@ -824,7 +824,7 @@ void sptlrpc_request_out_callback(struct
 	if (req->rq_pool || !req->rq_reqbuf)
 		return;
 
-	kfree(req->rq_reqbuf);
+	kvfree(req->rq_reqbuf);
 	req->rq_reqbuf = NULL;
 	req->rq_reqbuf_len = 0;
 }
