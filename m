Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225sxkyBb3B1/O+qE5l5+CLjI0uzoO7H22VSYOHb2YPRODeJQIaxd+G0IG6hEYQWJaNCQt3y
ARC-Seal: i=1; a=rsa-sha256; t=1519218380; cv=none;
        d=google.com; s=arc-20160816;
        b=SM9ACFefwGVVEV3qFsQUghhuP+/UM7qS7fDw4pp+GIiWw7RZhfAWZHX3g9hD9M1LU7
         M5lsbD8cJp20RegmPde7BxlkzMNWIE3hdnXDTMRKW4gVBkkZTOcSoxiWigqB3QTD9ZbA
         1q80eDDFBVoxhiFgqFCYuGK4ROVDfZQaHyF5nk7UedOm5Mf4TCXX3ygDxqPyM7CTdain
         V/R8xhZse6PdKVLPgoYOheOBxoDNJ2VrwXh9xa2eEbiez2nsz9VTu/kuaEZMji355x9s
         9hcNExoemcyT83HvQaOTrfVSJEx/ubtUKLGTThPBC/3NyI+2hWjSruIPE9bzTaPv9qSy
         fkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jnf6geqSmWqeBaocx+cVBi6uheApCGhqm1zm52cAgMo=;
        b=gFQYaWNtWltRvtJ5oGK9DEYc5WiOibebq1ngdg3+uYOzmdR2NPgvABtQtVefco+t9T
         Ero33/irfQKDCHTIUgMa3bfZlwJ6cynki8an0KJHssmOMYJPwUqHuoTOifW7D6944m+2
         j0TQztiTjGp4OmoA54aQ9Lr4TsFrIpDZnZwumnTaIMmj9bFhL2EUOBOrEyMFsacDHrcf
         pitQDd8SdHIjdt3SRmW1bH+eWtkDTpYMyauSfrJaAZGZjiR5jUJ9GhZzACwmCkCdTFvO
         gNHjxDIua3Mz/GiEZ4JTVyGYtYUqy2kflE2eMQ5s48i2y236hlkAaMCEDLpaOaaAvqId
         4KUA==
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
Subject: [PATCH 4.15 003/163] IB/qib: Fix comparison error with qperf compare/swap test
Date: Wed, 21 Feb 2018 13:47:12 +0100
Message-Id: <20180221124530.140974532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015257383542372?=
X-GMAIL-MSGID: =?utf-8?q?1593015931820970750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -434,13 +434,13 @@ no_flow_control:
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
