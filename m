Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224vAnlRRYFddyWQOuPLeAt7j+6PKrNkVUx1vlXVlxM4JTiVtTjjlrlzNgjnx8sNCFdLoANG
ARC-Seal: i=1; a=rsa-sha256; t=1519218217; cv=none;
        d=google.com; s=arc-20160816;
        b=c6cKFpA1zYhCGupRCikydTe8dkGO9urQpR+TKkTSkfwZ5tU/pZWRCskScAoTdw0/S8
         zfcJar/PFy+MbNOcLxtUI0ddlOuDrlz3GvyRfJnzveOgyZDQUdKI7oPYPEQZ0ELloqN/
         Gpa/fBxfzGvGbYCpYnAOyQzWZDLTB4MyPeQr7l/c2OR7JEgXy8LXlvgis4er2q5xh01c
         pYQXngw4K6LO8qZCacuC2DiX843YRwfav1OTkdTEzUj7b7iiZLZrU+h/avwCeqPvlSE/
         53DDDxMMHb3p34M7wrUo743GCAFGziE/xZYl69x2C9j0tf3M/LiY7xbIXowCdXxHyKPK
         aTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6b4aJQzGadtM/GkBDzlTt1xVOGGBa7fG6uUudvYzlSY=;
        b=oCPF3/qAOsa8T53smtSj2T9fcilL05f7aHIwekdWSOiMc1DV468JMI6XP023S3UPYN
         nrCLMzFeZGY8ZC79X67ZrEOpsb/3z40Jq0oL9l/omj2GYo7SuEpjVhy3au+/0hklPPvg
         Q3CTniF+jY0V2wv59/dga/mZg0Ujgv3Up7mFGf/pqWlcdzLznrVPCqb7B8eRRDF/g/0s
         2/xIa5PFDnCYlelwY9aD2Ds2XMWEZanRFyFr1IxWdHqbkrd1dcvASj3tk4Z27HzIT7g4
         pPwJZK/CgYJdv+2QzMovfhI1e9n1uqIacrd0F8hohX9TE6oaleTl3P+Ciwyjp1JbaEHe
         BD9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.14 128/167] xprtrdma: Fix calculation of ri_max_send_sges
Date: Wed, 21 Feb 2018 13:48:59 +0100
Message-Id: <20180221124531.595333431@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015761707323407?=
X-GMAIL-MSGID: =?utf-8?q?1593015761707323407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 1179e2c27efe21167ec9d882b14becefba2ee990 upstream.

Commit 16f906d66cd7 ("xprtrdma: Reduce required number of send
SGEs") introduced the rpcrdma_ia::ri_max_send_sges field. This fixes
a problem where xprtrdma would not work if the device's max_sge
capability was small (low single digits).

At least RPCRDMA_MIN_SEND_SGES are needed for the inline parts of
each RPC. ri_max_send_sges is set to this value:

  ia->ri_max_send_sges = max_sge - RPCRDMA_MIN_SEND_SGES;

Then when marshaling each RPC, rpcrdma_args_inline uses that value
to determine whether the device has enough Send SGEs to convey an
NFS WRITE payload inline, or whether instead a Read chunk is
required.

More recently, commit ae72950abf99 ("xprtrdma: Add data structure to
manage RDMA Send arguments") used the ri_max_send_sges value to
calculate the size of an array, but that commit erroneously assumed
ri_max_send_sges contains a value similar to the device's max_sge,
and not one that was reduced by the minimum SGE count.

This assumption results in the calculated size of the sendctx's
Send SGE array to be too small. When the array is used to marshal
an RPC, the code can write Send SGEs into the following sendctx
element in that array, corrupting it. When the device's max_sge is
large, this issue is entirely harmless; but it results in an oops
in the provider's post_send method, if dev.attrs.max_sge is small.

So let's straighten this out: ri_max_send_sges will now contain a
value with the same meaning as dev.attrs.max_sge, which makes
the code easier to understand, and enables rpcrdma_sendctx_create
to calculate the size of the SGE array correctly.

Reported-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Fixes: 16f906d66cd7 ("xprtrdma: Reduce required number of send SGEs")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/rpc_rdma.c |    2 +-
 net/sunrpc/xprtrdma/verbs.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -142,7 +142,7 @@ static bool rpcrdma_args_inline(struct r
 	if (xdr->page_len) {
 		remaining = xdr->page_len;
 		offset = offset_in_page(xdr->page_base);
-		count = 0;
+		count = RPCRDMA_MIN_SEND_SGES;
 		while (remaining) {
 			remaining -= min_t(unsigned int,
 					   PAGE_SIZE - offset, remaining);
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -523,7 +523,7 @@ rpcrdma_ep_create(struct rpcrdma_ep *ep,
 		pr_warn("rpcrdma: HCA provides only %d send SGEs\n", max_sge);
 		return -ENOMEM;
 	}
-	ia->ri_max_send_sges = max_sge - RPCRDMA_MIN_SEND_SGES;
+	ia->ri_max_send_sges = max_sge;
 
 	if (ia->ri_device->attrs.max_qp_wr <= RPCRDMA_BACKWARD_WRS) {
 		dprintk("RPC:       %s: insufficient wqe's available\n",
