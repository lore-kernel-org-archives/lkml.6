Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsdaRaFCngWetpxW4Lm8hdIGBh+YGRNV05+YHQSKozCcZLuNcujQGIOyGCHNHvqxd9LRuFf
ARC-Seal: i=1; a=rsa-sha256; t=1519676588; cv=none;
        d=google.com; s=arc-20160816;
        b=Jp6XCYSuUQxqi1NZHvtvA+iqzR6xHNuG/DEUrckHaNjB8mA1Oc4UtfwlyBDFxGASEe
         IRwOZ0La4Yr+M0BMWSwCjjpDgHbsFzrxm+1VJ98LAgjOBr9o0kdtXI0P/srmL3SreR3z
         3XEraL7VXX2jECsuFS8GMUIQn5o8b1DHXbx7d4Z7tfr6OOOSSroas7kAmXN0c5BveDBE
         EELgtBr2mv6arFyS5pIut94EW4snTVk8GaAwlWpAgA2HM+xuG6oxC0Rv39Ri5d/jZRBH
         ws5yHKbUiV1netTjHn7eiVeOBzqUBYUUltRFTub4mEjQWorb+zP5axA2h36y1IegiDJ1
         h1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/B6X2j6nqLlqjm6cxlgZQeUaaHkr8OVE1WB4RTVSXTw=;
        b=JRX9F18RZj+GwR+tmQhq1r76c5McqKh7AgLUXHye7Bk3D1ogHqK6OssQwjwLkk7Wez
         QPldN/OCRL8aon09Ks8Q1xVksiTM7Ndg/qG2+nCpe24trfpX/Jv7UKFRk/+Vp5DyX+pJ
         djr5zIWJXZEw5DmSjM/O1oUah9gINSBTQ+W25SdSaADwg7l3CHoHpWMAAQa+y4HZhYQy
         T+RuMI/J/GoQ4ORnaevcyrLtqoCtwNgfQ/cu6pp3xPK7hkta/qLvdpEbk1E6FnIlvWPg
         gtsCQyFsa/qrPi5NwLc5xpy50pWllihZYbtT6Erokd7mWyuSDJ8IHgFprfaL2e8XySny
         3xLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Inki Dae <inki.dae@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 35/39] IB/core: disable memory registration of filesystem-dax vmas
Date: Mon, 26 Feb 2018 21:20:56 +0100
Message-Id: <20180226201645.206972157@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496398659736325?=
X-GMAIL-MSGID: =?utf-8?q?1593496398659736325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 5f1d43de54164dcfb9bfa542fcc92c1e1a1b6c1d upstream.

Until there is a solution to the dma-to-dax vs truncate problem it is
not safe to allow RDMA to create long standing memory registrations
against filesytem-dax vmas.

Link: http://lkml.kernel.org/r/151068941011.7446.7766030590347262502.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Doug Ledford <dledford@redhat.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -193,7 +193,7 @@ struct ib_umem *ib_umem_get(struct ib_uc
 	sg_list_start = umem->sg_head.sgl;
 
 	while (npages) {
-		ret = get_user_pages(cur_base,
+		ret = get_user_pages_longterm(cur_base,
 				     min_t(unsigned long, npages,
 					   PAGE_SIZE / sizeof (struct page *)),
 				     gup_flags, page_list, vma_list);
