Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416FAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB36F20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB36F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbeGWBqC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:46:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:24823 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbeGWBqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:46:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2018 17:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,391,1526367600"; 
   d="scan'208";a="247951194"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2018 17:47:23 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 17:47:23 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 17:47:22 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Mon, 23 Jul 2018 08:47:19 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     Takashi Iwai <tiwai@suse.de>, "Zhang, Jun" <jun.zhang@intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: RE: [PATCH] ALSA: core: fix unsigned int pages overflow when
 comapred
Thread-Topic: [PATCH] ALSA: core: fix unsigned int pages overflow when
 comapred
Thread-Index: AdQejWjk55iqWVRYS2+apgz1v2Viqv//hmgA//5dnoCAAtJNAIAAKaEA//m9smA=
Date:   Mon, 23 Jul 2018 00:47:18 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D5298169B@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52980C51@SHSMSX104.ccr.corp.intel.com>
        <s5hpnzkbu3v.wl-tiwai@suse.de>
        <88DC34334CA3444C85D647DBFA962C272B0C4C34@SHSMSX104.ccr.corp.intel.com>
        <s5hmuun681l.wl-tiwai@suse.de> <s5h36wf6159.wl-tiwai@suse.de>
In-Reply-To: <s5h36wf6159.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWFjMWExN2MtMTY1OC00MmNjLWJjMGQtMGI0YzNlM2UyNDY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTWY2OWQ2dFIwdHRSaitxK2FtUVI2OHVTeUxIVW54OW5ONE9DdTMrMThJTmt6WHpjWnY0U1wveVlYdHkyR3Y4dWwifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Takashi:
	we tested for the whole weekend, your patch works, no panic issue seen. You can safe merge you patch.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Thursday, July 19, 2018 5:11 PM
To: Zhang, Jun <jun.zhang@intel.com>
Cc: He, Bo <bo.he@intel.com>; alsa-devel@alsa-project.org; perex@perex.cz; linux-kernel@vger.kernel.org; Zhang, Yanmin <yanmin.zhang@intel.com>
Subject: Re: [PATCH] ALSA: core: fix unsigned int pages overflow when comapred

On Thu, 19 Jul 2018 08:42:14 +0200,
Takashi Iwai wrote:
> 
> On Thu, 19 Jul 2018 08:08:06 +0200,
> Zhang, Jun wrote:
> > 
> > Hello, Takashi
> > 
> > I think use our patch, it's NOT possible that the returned size is over sgbuf->tblsize.
> > 
> > In function snd_malloc_sgbuf_pages,
> > 
> > Pages is align page,
> > sgbuf->tblsize is align 32*page,
> > chunk is align 2^n*page,
> > 
> > in our panic case, pages = 123, tlbsize = 128, 1st loop trunk = 32 
> > 2nd loop trunk = 32 3rd loop trunk = 32 4th loop trunk = 16 5th loop 
> > trunk = 16 So in 5th loop pages-trunk = -5, which make dead loop.
> 
> Looking at the code again, yeah, you are right, that won't happen.
> 
> And now it becomes clear: the fundamental problem is that
> snd_dma_alloc_pages_fallback() returns a larger size than requested.
> It would be acceptable if the internal allocator aligns a larger size, 
> but it shouldn't appear in the returned size outside.  I believe this 
> was just a misunderstanding of get_order() usage there.
> (BTW, it's interesting that the allocation with a larger block worked  
> while allocation with a smaller chunk failed; it must be a rare case  
> and that's one of reasons this bug didn't hit frequently.)
> 
> That being said, what we should fix is rather the function
> snd_dma_alloc_pages_fallback() to behave as expected, and it'll be 
> like the patch below.

And we can reduce even more lines.  A proper patch is below.


thanks,

Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: memalloc: Don't exceed over the requested size

snd_dma_alloc_pages_fallback() tries to allocate pages again when the allocation fails with reduced size.  But the first try actually
*increases* the size to power-of-two, which may give back a larger chunk than the requested size.  This confuses the callers, e.g. sgbuf assumes that the size is equal or less, and it may result in a bad loop due to the underflow and eventually lead to Oops.

The code of this function seems incorrectly assuming the usage of get_order().  We need to decrease at first, then align to power-of-two.

Reported-by: he, bo <bo.he@intel.com>
Reported-by: zhang jun <jun.zhang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c index 7f89d3c79a4b..753d5fc4b284 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -242,16 +242,12 @@ int snd_dma_alloc_pages_fallback(int type, struct device *device, size_t size,
 	int err;
 
 	while ((err = snd_dma_alloc_pages(type, device, size, dmab)) < 0) {
-		size_t aligned_size;
 		if (err != -ENOMEM)
 			return err;
 		if (size <= PAGE_SIZE)
 			return -ENOMEM;
-		aligned_size = PAGE_SIZE << get_order(size);
-		if (size != aligned_size)
-			size = aligned_size;
-		else
-			size >>= 1;
+		size >>= 1;
+		size = PAGE_SIZE << get_order(size);
 	}
 	if (! dmab->area)
 		return -ENOMEM;
--
2.18.0

