Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrrf6cT8LbccpOmWXnFfmj/uf+GohZvFNR6EDJJEg9UbeAVuBgsItt4jmsRP7Gmo7VHFZg8
ARC-Seal: i=1; a=rsa-sha256; t=1526937363; cv=none;
        d=google.com; s=arc-20160816;
        b=f7xPplFUSF7KDiiD4/p4ejbj+ccpw1h/mF14sAv9/kkKIZrJ0WISh0UutG/RRhfs3y
         Puxpl7dKXaDwddv2GkPXzSxMmEvIrR9D3bO5OoTcSM85+eKEApBV2ZyWanUgtnS7uqR1
         xc9G/1fiGOOjI95gP/5LAwWlCerWyTdKAsTk2FA+b0koZwmI8Lcqt22Thf2eS6kx9ZV9
         4nIVlVaqlYUle2lna22qGCsg+VkWVOcMtFt5KVLNQ7O4yhROPmFx8YTps7sUyXb3Zhvs
         0sW1dcxygwEntEpAywPV/Bs1xG5+L7vTKd38cqddpdm1RhLKhZG5y/K8cziY7PVUkoD2
         +WRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Zdf3wUUQUB0mGfNOMRAW3ToUk4rmVnQ6asywtW78YG4=;
        b=jPyzbsQO8GPHFDjhY1s4btxmBQZJBJh8aDp7r2QujPILTd3kuxyZrDBLekW4xNXXml
         kFc7F9uCilF5mAz0JW/7SvptqmC/Xw5Sb/RKM6EDRIaYlAaOgw58od3pXim44RpM/DcL
         DwGa4SSueIgqgeZCfbI/hOzWBSLPg+zfVfU8b5HTjSpjabhOfQz5JPaXuBxrSaGeZkx+
         AyQrb0poU1ooK9Ly7rlzgPrctO75Du+dCoThKJL8n3vxHkL8MXrE/wyAimGU1H3RnSDg
         nopd+iT9Az9noUFxYnoqak0eprcy+4eFQwek/UoG0QM0Ctqkoctt7v1BEKSn3+ZuoaFx
         EYgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eVevyDJT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eVevyDJT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 20/87] s390/qdio: fix access to uninitialized qdio_q fields
Date: Mon, 21 May 2018 23:10:56 +0200
Message-Id: <20180521210422.154652994@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109872569829997?=
X-GMAIL-MSGID: =?utf-8?q?1601109872569829997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit e521813468f786271a87e78e8644243bead48fad upstream.

Ever since CQ/QAOB support was added, calling qdio_free() straight after
qdio_alloc() results in qdio_release_memory() accessing uninitialized
memory (ie. q->u.out.use_cq and q->u.out.aobs). Followed by a
kmem_cache_free() on the random AOB addresses.

For older kernels that don't have 6e30c549f6ca, the same applies if
qdio_establish() fails in the DEV_STATE_ONLINE check.

While initializing q->u.out.use_cq would be enough to fix this
particular bug, the more future-proof change is to just zero-alloc the
whole struct.

Fixes: 104ea556ee7f ("qdio: support asynchronous delivery of storage blocks")
Cc: <stable@vger.kernel.org> #v3.2+
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -140,7 +140,7 @@ static int __qdio_allocate_qs(struct qdi
 	int i;
 
 	for (i = 0; i < nr_queues; i++) {
-		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		q = kmem_cache_zalloc(qdio_q_cache, GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
 
