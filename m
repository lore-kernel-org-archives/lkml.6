Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rLdAx7CtG1M/wIHg610Q10rpXbU0wrW+BR1bPpie9+1MTzdnTaaCZm/kdCJMK37Eebw4p
ARC-Seal: i=1; a=rsa-sha256; t=1523473189; cv=none;
        d=google.com; s=arc-20160816;
        b=dKODePA4pxC71+Oc/THE2ZNeDxZMIoO59zDKh0C2WwL04428eiGtjlYmLY7lYUDeS0
         pfTRo3yf3D7fi5E5opWtQ5+LLxSgItNm728Aos0FPQOAVLELFDhKowhIi21OUd0mcQSn
         UoZpohf+5oNQRvA6s7Hwl5mcTmlXX4xDxkoxJAWMDw+Ki9B2L6qzUpdCciUMQ8b0R9FN
         lHvU2Xf/HiTCZIlg4zVdEDtr3jM7Xy7+eCEkm6SrBJxr1tkLS8cVE3BnMoPPKnw6R7DE
         RHQSs4hbumhE1ji3052m1mTwZpezeK0tAyXHhRpkQIbVrCLicQk07Jahog9/boZD/r2H
         iA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aPVHiF/XwFqDdQ5zIme4HuqWm3oiM3RaYP5d67B4Kso=;
        b=BOldq28O/49aP743g38lvNthPqLLc4sK8STOzzO4eq7WQaKbCTLg7qWxt3S8hvMWYT
         w5tOE42UCtS2BgMRHvmYArV3G9oQJ9GTgxpXCjMGCR7kTU3OrwTEqxW4hxkZb1RtPDwo
         LUvQ+rDesm4BmVV3pgW4+dxHGuzW7YcoIQafxkYiIZ2NgWO//k2lzV/U9+98ZY65xKCL
         ipEO98lVSYLscnf3Bga5/rOKGthwZBbQMKOErZnBNjxvtjtgs96SG4sfmRnhRxG+kQ1T
         v43z5KpWU8kafqCoZOT9Ryc6TEE8wKAXrKesJ4Bm/OBhuAcesVzap83Mp7tO036X52EN
         252A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Sanchez <sebastian.sanchez@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 141/310] IB/rdmavt: Allocate CQ memory on the correct node
Date: Wed, 11 Apr 2018 20:34:40 +0200
Message-Id: <20180411183628.515763157@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477422829604323?=
X-GMAIL-MSGID: =?utf-8?q?1597477422829604323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>


[ Upstream commit db9a2c6f9b6196b889b98e961cb9a37617b11ccf ]

CQ allocation does not ensure that completion queue entries
and the completion queue structure are allocated on the correct
numa node.

Fix by allocating the rvt_cq and kernel CQ entries on the device node,
leaving the user CQ entries on the default local node.  Also ensure
CQ resizes use the correct allocator when extending a CQ.

Reviewed-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rdmavt/cq.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -197,7 +197,7 @@ struct ib_cq *rvt_create_cq(struct ib_de
 		return ERR_PTR(-EINVAL);
 
 	/* Allocate the completion queue structure. */
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
+	cq = kzalloc_node(sizeof(*cq), GFP_KERNEL, rdi->dparms.node);
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
 
@@ -213,7 +213,9 @@ struct ib_cq *rvt_create_cq(struct ib_de
 		sz += sizeof(struct ib_uverbs_wc) * (entries + 1);
 	else
 		sz += sizeof(struct ib_wc) * (entries + 1);
-	wc = vmalloc_user(sz);
+	wc = udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc) {
 		ret = ERR_PTR(-ENOMEM);
 		goto bail_cq;
@@ -368,7 +370,9 @@ int rvt_resize_cq(struct ib_cq *ibcq, in
 		sz += sizeof(struct ib_uverbs_wc) * (cqe + 1);
 	else
 		sz += sizeof(struct ib_wc) * (cqe + 1);
-	wc = vmalloc_user(sz);
+	wc = udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc)
 		return -ENOMEM;
 
