Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932300AbeE3U2C convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:28:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:54947 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbeE3U17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:27:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="43446632"
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: "longli@microsoft.com" <longli@microsoft.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Topic: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Index: AQHT+E9hTFeqJV5uMUSZ70a6r5JX76RIuHuA
Date: Wed, 30 May 2018 20:27:57 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663B38F01CD@FMSMSX108.amr.corp.intel.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-3-longli@linuxonhyperv.com>
In-Reply-To: <20180530194807.31657-3-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGFkNTg1OTUtOWJjMy00MDU4LTk1ZjktMzA1MWFjOGI4ODE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTnlobVd1NG96eElsS2IzWGlaOUlsUENVOUVLd3RjMFRPQTlHTHB3dHZZa3gzb3FUTVpWYUlKSUdLMmpiTSs5WCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
>owner@vger.kernel.org] On Behalf Of Long Li
>Sent: Wednesday, May 30, 2018 3:48 PM
>To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org; samba-
>technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
>rdma@vger.kernel.org
>Cc: Long Li <longli@microsoft.com>
>Subject: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
>
>From: Long Li <longli@microsoft.com>
>
>Add a function to allocate rdata without allocating pages for data
>transfer. This gives the caller an option to pass a number of pages
>that point to the data buffer.
>
>rdata is still reponsible for free those pages after it's done.
>
>Signed-off-by: Long Li <longli@microsoft.com>
>---
> fs/cifs/cifsglob.h |  2 +-
> fs/cifs/file.c     | 23 ++++++++++++++++++++---
> 2 files changed, 21 insertions(+), 4 deletions(-)
>
>diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
>index 8d16c3e..56864a87 100644
>--- a/fs/cifs/cifsglob.h
>+++ b/fs/cifs/cifsglob.h
>@@ -1179,7 +1179,7 @@ struct cifs_readdata {
> 	unsigned int			tailsz;
> 	unsigned int			credits;
> 	unsigned int			nr_pages;
>-	struct page			*pages[];
>+	struct page			**pages;
> };
>
> struct cifs_writedata;
>diff --git a/fs/cifs/file.c b/fs/cifs/file.c
>index 23fd430..1c98293 100644
>--- a/fs/cifs/file.c
>+++ b/fs/cifs/file.c
>@@ -2880,13 +2880,13 @@ cifs_strict_writev(struct kiocb *iocb, struct
>iov_iter *from)
> }
>
> static struct cifs_readdata *
>-cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
>+cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
> {
> 	struct cifs_readdata *rdata;
>
>-	rdata = kzalloc(sizeof(*rdata) + (sizeof(struct page *) * nr_pages),
>-			GFP_KERNEL);
>+	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
> 	if (rdata != NULL) {
>+		rdata->pages = pages;
> 		kref_init(&rdata->refcount);
> 		INIT_LIST_HEAD(&rdata->list);
> 		init_completion(&rdata->done);
>@@ -2896,6 +2896,22 @@ cifs_readdata_alloc(unsigned int nr_pages,
>work_func_t complete)
> 	return rdata;
> }
>
>+static struct cifs_readdata *
>+cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
>+{
>+	struct page **pages =
>+		kzalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
>+	struct cifs_readdata *ret = NULL;
>+
>+	if (pages) {
>+		ret = cifs_readdata_direct_alloc(pages, complete);
>+		if (!ret)
>+			kfree(pages);
>+	}
>+
>+	return ret;
>+}
>+
> void
> cifs_readdata_release(struct kref *refcount)
> {
>@@ -2910,6 +2926,7 @@ cifs_readdata_release(struct kref *refcount)
> 	if (rdata->cfile)
> 		cifsFileInfo_put(rdata->cfile);
>
>+	kvfree(rdata->pages);

Is the kvfree() correct?

You use kzalloc() and kfree in cifs_readdata_alloc().

Mike

> 	kfree(rdata);
> }
>
>--
>2.7.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
