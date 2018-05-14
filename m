Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoQ93ICp5aMVkoEnYMQhoiTnabGiu0gI+YjYhVLilwReW9bAJJwI31cPXfKonF021t053Qv
ARC-Seal: i=1; a=rsa-sha256; t=1526281233; cv=none;
        d=google.com; s=arc-20160816;
        b=pObMKPLseu3XO1LJ+AWPL4ajnZPlUe1W+ZPU5wfINydGqkFSVO2b312+cM4vxULmQj
         Etl1LXmuohL1m+DAfVncyXy8OGYjwAWI/TZ8S99KSSLnJNx9NrGnRtXASeebsgzK/Hzk
         HWCXr+JYk+ay+OCKvMjJtU9X7g3YMhY5AtaWH1bO2ibgS+3Kt2XOLziYusgs8gLXXRTc
         /waantAEBVhpOoqhpdo3rjiQKpkVIrH8G2buYTkD4VFwfEzgkR+NlHrXmzY8hP9Ov/Qe
         b98rlQ8CICESzugEDeY0C2qfdNPKvnXBYpg5Tm0hPe1QgqDlnNMfL2ECvi7ee5Fp/CvH
         kW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZrFn2waHzC5FdyR3BlBtAj9tmMTtfmqh1HIYOiUEp3M=;
        b=LoweUl+EGqvqkcr18aVrykIcuAaP2gzbiot0E8AAzBq5ll7X+9EInIbSwW5dgJ6ldM
         8g2sj0ajqGZm8FVkCE4gTxIEzfV5nk2b9w7OWK6U4rXGEecTwZ0Bl0pg5KuwCeddKqYd
         y/zO+7cBolibIs1Uqob1C/dFUXve5RHnxaR26VFPXAY968Nb1DYsV5JrdpGbtgg2NZqH
         1vnS7oHQHAtB/jJ2BiFj2d3oSmixrAtrqSkeqeMosFNe2neDEs/hHLs+OXLxJaVaq3x8
         HCOXbb53jHNlLYGoWjpbVXnlSlDlIrNV2FiQhqxOYIoQDxP8dkYWpZrhSMX9uz1VLOXa
         uULg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BmSqdfz8;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BmSqdfz8;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 64/72] swiotlb: silent unwanted warning "buffer is full"
Date: Mon, 14 May 2018 08:49:21 +0200
Message-Id: <20180514064827.471483168@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421869855887037?=
X-GMAIL-MSGID: =?utf-8?q?1600421869855887037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

commit 05e13bb57e6f181d7605f8608181c7e6fb7f591d upstream.

If DMA_ATTR_NO_WARN is passed to swiotlb_alloc_buffer(), it should be
passed further down to swiotlb_tbl_map_single(). Otherwise we escape
half of the warnings but still log the other half.

This is one of the multiple causes of spurious warnings reported at:
https://bugs.freedesktop.org/show_bug.cgi?id=104082

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 0176adb00406 ("swiotlb: refactor coherent buffer allocation")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Christian König <christian.koenig@amd.com>
Cc: Michel Dänzer <michel@daenzer.net>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org # v4.16
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/swiotlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -727,7 +727,7 @@ swiotlb_alloc_buffer(struct device *dev,
 
 	phys_addr = swiotlb_tbl_map_single(dev,
 			swiotlb_phys_to_dma(dev, io_tlb_start),
-			0, size, DMA_FROM_DEVICE, 0);
+			0, size, DMA_FROM_DEVICE, attrs);
 	if (phys_addr == SWIOTLB_MAP_ERROR)
 		goto out_warn;
 
