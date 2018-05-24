Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr+5mBaKDxxQhqNPgurBTKJPc3Z9aUZd4ahiWbzmjuoRzvA0q5WqVgdfW9oO+9bZxCUBHlD
ARC-Seal: i=1; a=rsa-sha256; t=1527156182; cv=none;
        d=google.com; s=arc-20160816;
        b=PM1TR2dGc55zkbzuAai79I0KcOSIJ4dDL6qMdHyz5B2hGiY2tcJUz0Wu9IS2Q3aMq5
         tMrOi1Yrk7yZPRCKExK/9ftlIk9sRLb+ZSKOrV1iXZawmBRfjO6AoKmVoDD850hmCNp7
         ruzpmrJQHcpv61/I3GC4kYzJbBwPQXKdyCW5rtR/1oKLRNFZuFppqoojoMfpvt7B+HSA
         cwOBLvU6Dy/KX4hrztErBpbV4Hl/E2HXXgBAqVjkHgIk1UK9zQ5nnEaQZDgXIuUdtIew
         WDfZlMw7GpTc31F82gnqC22EhogBp4DhoN+nLn4MQxz8zTh9qs5BPqHsM0wLT1A++kZi
         9c5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=gV0dbmxXRGEVTR0sqS1Pl6RpAeoUOIXAktHkcFTJzoM=;
        b=kIOsQSpyaTxjUyP3olc7Mvmx8Z3fTHLapZUtNHGQB5WMtQnGYFB3Jhy7t7P1rUJej4
         PYVmptwddnuPM3K6k/X+eRgDq/ya4OfbztuGegc4INfDCAlCOXOLp53EZqpQ7/yHQBW2
         +daLEXCtMfDUBoAvruRDFSEXDlgVtgligQxbXXldLa1r5mRgNaYfmzV/BZ6zEH07DDdY
         J/FavcuzHmFFWzX5f2ZApv6uBN6ySD0fw84ycKG6OX/jp5x8htAV3Y2qgc+qd8S7Irjn
         q/W1q5Jq2XYyBuTv6YAtxvGXKPFyilYoOc+ycfKlSjtmlABQA6Y4vXBRJL3/oCFF//lI
         jp/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=odkbXrWp;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=odkbXrWp;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 092/161] staging: lustre: fix bug in osc_enter_cache_try
Date: Thu, 24 May 2018 11:38:37 +0200
Message-Id: <20180524093029.439099481@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338430003114719?=
X-GMAIL-MSGID: =?utf-8?q?1601339320728269951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

[ Upstream commit 2fab9faf9b27298c4536c1c1b14072ab18b8f80b ]

The lustre-release patch commit bdc5bb52c554 ("LU-4933 osc:
Automatically increase the max_dirty_mb") changed

-       if (cli->cl_dirty + PAGE_CACHE_SIZE <= cli->cl_dirty_max &&
+       if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&

When this patch landed in Linux a couple of years later, it landed as

-       if (cli->cl_dirty + PAGE_SIZE <= cli->cl_dirty_max &&
+       if (cli->cl_dirty_pages <= cli->cl_dirty_max_pages &&

which is clearly different ('<=' vs '<'), and allows cl_dirty_pages to
increase beyond cl_dirty_max_pages - which causes a latter assertion
to fails.

Fixes: 3147b268400a ("staging: lustre: osc: Automatically increase the max_dirty_mb")
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lustre/include/obd.h   |    2 +-
 drivers/staging/lustre/lustre/osc/osc_cache.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/lustre/lustre/include/obd.h
+++ b/drivers/staging/lustre/lustre/include/obd.h
@@ -191,7 +191,7 @@ struct client_obd {
 	struct sptlrpc_flavor    cl_flvr_mgc;   /* fixed flavor of mgc->mgs */
 
 	/* the grant values are protected by loi_list_lock below */
-	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pahges */
+	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pages */
 	unsigned long		 cl_dirty_max_pages;	/* allowed w/o rpc */
 	unsigned long		 cl_dirty_transit;	/* dirty synchronous */
 	unsigned long		 cl_avail_grant;	/* bytes of credit for ost */
--- a/drivers/staging/lustre/lustre/osc/osc_cache.c
+++ b/drivers/staging/lustre/lustre/osc/osc_cache.c
@@ -1530,7 +1530,7 @@ static int osc_enter_cache_try(struct cl
 	if (rc < 0)
 		return 0;
 
-	if (cli->cl_dirty_pages <= cli->cl_dirty_max_pages &&
+	if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&
 	    atomic_long_read(&obd_dirty_pages) + 1 <= obd_max_dirty_pages) {
 		osc_consume_write_grant(cli, &oap->oap_brw_page);
 		if (transient) {
