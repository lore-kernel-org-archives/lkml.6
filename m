Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225PSUItUd2ikAWY8ZRdSbb3s3LJlwRVJV8LXfJmpuWQ1wueFWe8NTDr9BFgJ0uAe1rLPMGb
ARC-Seal: i=1; a=rsa-sha256; t=1519217736; cv=none;
        d=google.com; s=arc-20160816;
        b=SVVmR9qtMT2gROFDM6em/mR70sCWeGHVAcIrq2AigJJLcMpMPYnZxR+1jg8okJ9jMG
         RG7x2HBo/xZVWY4HwWxvC4lqUnkYFJ9x9cZc88erQCdQR3LYBT7E+p7RCY6AA9XrCh10
         1cAf1I6vZMhWeIjs4izQYa/nPptRisdXhhgP4euAL+KyAstIA082p5Vtpp2OodVDr7tU
         GszhjIXrh7L14GrbvbcWNuMjgpeseXXDZOovdB2ImPXuYJG0dDjrCzlAD/sh4OKIjcuQ
         DilHdexnMmr8Y7A5RDGQZ49xhabel/IMUOodSXoLjlXrWK/tICru8lACbiQyep4TCeDo
         BLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DKsUhQAO6fD3zNex/xe9Q2MNOY/13cq5FXLpUmqBCiU=;
        b=lETmyViUyfFmjlRdHwbwMv626ZR7NUd0BiwDoUe+2uW3pJtdFmgM3oghH9EMOwhcGs
         2WktT+E7uJoATmOZKWQIinDQWZAtJUKPpRjI6kZko4UKGL1gqJ6gU6uNpq908i/gsVoX
         VK2NXSAKKREGoV65akYISIYeSNr1yNfDApNDPARywBUxMvVcGSQJtGNxdXbylVk2Pich
         aFZTrKaOsxNadZR4X9TDMxigjmaQg2UgHpcbFSX6eZScx5s0MWQpSW8Q7XkZCZRnDE45
         jKEQRmtekhW/w+5ifk/s2E/QsjlZHgbnMbFrpkiWmfy3x+yw/zbxYnBXQQvuE0tMSQHv
         MX0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 35/77] IB/qib: Fix comparison error with qperf compare/swap test
Date: Wed, 21 Feb 2018 13:48:44 +0100
Message-Id: <20180221124433.654956196@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015257383542372?=
X-GMAIL-MSGID: =?utf-8?q?1593015257383542372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit 87b3524cb5058fdc7c2afdb92bdb2e079661ddc4 upstream.

This failure exists with qib:

ver_rc_compare_swap:
mismatch, sequence 2, expected 123456789abcdef, got 0

The request builder was using the incorrect inlines to
build the request header resulting in incorrect data
in the atomic header.

Fix by using the appropriate inlines to create the request.

Fixes: 261a4351844b ("IB/qib,IB/hfi: Use core common header file")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/qib/qib_rc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/qib/qib_rc.c
+++ b/drivers/infiniband/hw/qib/qib_rc.c
@@ -443,13 +443,13 @@ no_flow_control:
 				qp->s_state = OP(COMPARE_SWAP);
 				put_ib_ateth_swap(wqe->atomic_wr.swap,
 						  &ohdr->u.atomic_eth);
-				put_ib_ateth_swap(wqe->atomic_wr.compare_add,
-						  &ohdr->u.atomic_eth);
+				put_ib_ateth_compare(wqe->atomic_wr.compare_add,
+						     &ohdr->u.atomic_eth);
 			} else {
 				qp->s_state = OP(FETCH_ADD);
 				put_ib_ateth_swap(wqe->atomic_wr.compare_add,
 						  &ohdr->u.atomic_eth);
-				put_ib_ateth_swap(0, &ohdr->u.atomic_eth);
+				put_ib_ateth_compare(0, &ohdr->u.atomic_eth);
 			}
 			put_ib_ateth_vaddr(wqe->atomic_wr.remote_addr,
 					   &ohdr->u.atomic_eth);
