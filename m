Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqlfcINZAUwhbPRzxDDOZwmrKfYqoc1nd4N3WQtKrsu/8gvshygU8ZqjdIoWuCd/S927cgU
ARC-Seal: i=1; a=rsa-sha256; t=1526937533; cv=none;
        d=google.com; s=arc-20160816;
        b=ouS5RBS1z+GbgaZTzWFlJZGAMlL1Gs7VzuxtNyDKtRolignae7ofiRyE2p5CKvidfe
         ohoKn5oSZ4Iq6Byn+WElmZut8o1/cnPwRmaEjsmvdejdp3QsADEDbxWpBYnLCUio3ink
         m8RktQdHa/Fh0FwIxpzd+f6sCiQhFVF6HAjY1LfP4iyUPZusH6B6RhKIpWra7h90BNlh
         H+R/BLujQYmgDEO/aigbLt7J29VAijIK9zOb9K4G9twm/B1UdFFmrfHH1ehOxYNQTJ3D
         2Oe+E9LaZR4+2+cWi5mvde99R3tHqGjqmGp83Qmuu5JPwW/8b3KHyFGvOQSSlPqdabgw
         4wFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DNzvJywzxxdmo2GqliiWiQ0rBsLTiQoZOMYFs9pUo4c=;
        b=offpo9ulTSUCiygwtmGZ+9x/BYixeDvxvDIUaqXV3coZWtLuPeVDKIpmMLEeeX67ge
         hIIfIcJqsVbtJUQXwqm916ZiCzcl21OTq2tSwiKr14E9+7kdqQh2b8rqRN/j4J0rixkN
         Qgq8VxvYUh9WMYUlC/G11uRrDWHHtX3J1nWDIX9p22+H4Htlq8Z63vQ5jwpFpefW1sol
         mTkbIhQwORGZTMKPXpGTAm1gZJ7/i7ypTpPBWnuEpMrzESW9F+8g6JN4v65+1IHBK3YG
         Ag4vL9D+N9htPzVZvxcArGYQIsP/1nst9kFiPjcY6qwVNyVHBjb1xDqRDfSrcBAIGYBb
         0Kyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FhBymtL7;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FhBymtL7;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 28/95] s390/qdio: fix access to uninitialized qdio_q fields
Date: Mon, 21 May 2018 23:11:18 +0200
Message-Id: <20180521210454.082712215@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109872569829997?=
X-GMAIL-MSGID: =?utf-8?q?1601110050733364771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
