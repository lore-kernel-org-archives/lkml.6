Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpJyRuWo1JBR37x6+gHGpI6jImw7WJSW7Ejks7lgmh+w7ANXmcV8TTjLsQ6i0aQjHrkLrs8
ARC-Seal: i=1; a=rsa-sha256; t=1526937837; cv=none;
        d=google.com; s=arc-20160816;
        b=DIIFcMGDDADNFpvN2YiWlluqnDwPc3ygrdg2mh4lx2N+Z0idTohEx5fXXUWzZwagVH
         /RoasXExCS9y6qBKf+4CqoPhqhCmtkKFsa416S29IXSSZcqnQun90inEwuFZQrsNF7cD
         j9rGNH9H/AAIClZsznoPcnFrltUJnXljVaHu/PojD9qXv/Mq+Lk2bPKo0g4LIN9iPcDA
         GpGwxCAZhwQORRhlypznGRvDBuuSRB5E0ebbX2tn7AAX/CHFU0k5G3YkMkuakzdPJsCe
         kazvdbXdCHzS/YUphf5qPa7ftA8Mt6lG7BKT8/FprYyHXyNVyK8Qs9alNTk/zq7q5FfA
         wdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Ov7q8aLZPBPMmKmalX3xnXY7G7Hc6V8SubA+HSZ9eFQ=;
        b=bV9FAYWJONuT0VPIcjI6pG6c9ADRx0AelXchsVr4V9CIjG0X85+naogmU9zYUuhICr
         Z2XDLhLt1QVDbDSFG6AHrrAxbyMETVAbU/QY/L1lwNbP8IARFMXeF8DnnTO6pK66lJ1n
         ANYbG0yP8YxwplIFwm0olo6c+KP0BS68c9GCWJow1UHk1q1EMG23reAwA8iMwM26xVfD
         GdeDCUgMXr3iYejS3WTRszHJU8WYzHNNKlPsX8/ZBEpDFpORpy6/Ozc5X09GP5Xr1KZv
         e2Q/OCo4/Q4RsPJgxYJVFb6PcDgnDfQnizFt/4TBWAIxRvBJmTcw2v54QsU0VDOk9aTr
         E4pA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Rn8BpU+A;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Rn8BpU+A;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Coly Li <colyli@suse.de>,
	"Massimo B." <massimo.b@gmx.net>,
	Kai Krakow <kai@kaishome.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 044/110] bcache: return 0 from bch_debug_init() if CONFIG_DEBUG_FS=n
Date: Mon, 21 May 2018 23:11:41 +0200
Message-Id: <20180521210508.025108599@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110369441687237?=
X-GMAIL-MSGID: =?utf-8?q?1601110369441687237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Coly Li <colyli@suse.de>

commit 1c1a2ee1b53b006754073eefc65d2b2cedb5264b upstream.

Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
returns the return value of debugfs_create_dir() to bcache_init(). When
CONFIG_DEBUG_FS=n, bch_debug_init() always returns 1 and makes
bcache_init() failedi.

This patch makes bch_debug_init() always returns 0 if CONFIG_DEBUG_FS=n,
so bcache can continue to work for the kernels which don't have debugfs
enanbled.

Changelog:
v4: Add Acked-by from Kent Overstreet.
v3: Use IS_ENABLED(CONFIG_DEBUG_FS) to replace #ifdef DEBUG_FS.
v2: Remove a warning information
v1: Initial version.

Fixes: Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Reported-by: Massimo B. <massimo.b@gmx.net>
Reported-by: Kai Krakow <kai@kaishome.de>
Tested-by: Kai Krakow <kai@kaishome.de>
Acked-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Kai Krakow <kai@kaishome.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/debug.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -251,6 +251,9 @@ void bch_debug_exit(void)
 
 int __init bch_debug_init(struct kobject *kobj)
 {
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+
 	debug = debugfs_create_dir("bcache", NULL);
 
 	return IS_ERR_OR_NULL(debug);
