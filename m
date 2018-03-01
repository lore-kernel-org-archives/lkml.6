Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELtEOyYS6S6xpCr2jdf03ry7W0rTDoUJ1wQheUj328wk4y4EHqFkFZ8TW+U2peTs9asaW4nE
ARC-Seal: i=1; a=rsa-sha256; t=1519947147; cv=none;
        d=google.com; s=arc-20160816;
        b=cj52V7bvawBYP8kFZA3XZuQJFIaA/2m2aFN6TAe+6k7q+13nfWWak2YTzty50HS3fz
         jdDEkoopefTc/3CjEQzsJ5jWXvUKWamyIry+lXET3bkM3PLBIAHMhEQfH02OEtjoSVRA
         taqSkKIPwKCckKS1JxNDBjsU3tCRoucRYlb4lq2/UQu/jRs33qEvN9lLcMEXnAwyaru6
         LzH/9XFdA8Pi7GPvpVmRyjX6IdpVLeHt8ZQ62ugKmxpb9uVvYlZq5ugdm0FKHBVZUoae
         k31hStjbqx/6LlEx9YSgjiTPPymkWNMPoz2G9CsDHvTv0gyuxwnYNCRmRTtnkE7r8XN4
         mxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=M6QbPuLwzydgHOlGzLCM7xKJ0PtovmPYXfd/5agbH5I=;
        b=U7aKWJkS3AObJfYmL4AY7QGHVWuf6BvSsak2szzpkhVJ/+82fqFZQSTtd6xkVVap1c
         BHgtQ3aA9SYMM4bulZrVFPiiRLwYIdYxUlL0tdcpEXEalYUV/wyQHkQgzd7DO70k/dMx
         sYx5ctMRllAAX8AyKqBhqfBCAMq1wPymWJpjaRGfSLTdOZAY5VlEor/S8kfqXx5kgXqz
         jm0kWGBpi8iWup4kYEakb3zq7Ntwri+WuCqUmQcq7ohJ4atX+77lnCSlhJc6PP8Diqfl
         1qcqCAJoxYTkGxFdsUrST+sikF+VWN/j4CD4RMwzdV81/loEeH2JkKs4z0xOimvuSgFb
         DB0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 02/17] staging: lustre: fix bug in osc_enter_cache_try
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708510.7628.7308229784516417641.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780100194865307?=
X-GMAIL-MSGID: =?utf-8?q?1593780100194865307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/staging/lustre/lustre/include/obd.h   |    2 +-
 drivers/staging/lustre/lustre/osc/osc_cache.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/obd.h b/drivers/staging/lustre/lustre/include/obd.h
index 4368f4e9f208..f1233ca7d337 100644
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
diff --git a/drivers/staging/lustre/lustre/osc/osc_cache.c b/drivers/staging/lustre/lustre/osc/osc_cache.c
index 1c70a504ee89..459503727ce3 100644
--- a/drivers/staging/lustre/lustre/osc/osc_cache.c
+++ b/drivers/staging/lustre/lustre/osc/osc_cache.c
@@ -1529,7 +1529,7 @@ static int osc_enter_cache_try(struct client_obd *cli,
 	if (rc < 0)
 		return 0;
 
-	if (cli->cl_dirty_pages <= cli->cl_dirty_max_pages &&
+	if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&
 	    atomic_long_read(&obd_dirty_pages) + 1 <= obd_max_dirty_pages) {
 		osc_consume_write_grant(cli, &oap->oap_brw_page);
 		if (transient) {
