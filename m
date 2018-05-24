Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrhuOXTwlGOWcyzDz9Fl61tWvUZbPPZyp2AFlTrxiVOJs8KmjWdeRQq+zAkygSTa7pnObOb
ARC-Seal: i=1; a=rsa-sha256; t=1527155170; cv=none;
        d=google.com; s=arc-20160816;
        b=qKYDjAZAwA17VeKSpU0uQyTewMhdw8n1Es+9AJaH7hKAEUE15HGsjnRL9SWMhpc8WW
         5iFhznXrgsRf00YgHCV2kdr5dC0eQ3lrvFUh7RMgaVePSw8bUlwlHY0a/+7EQsCIgzxJ
         89M5NR/FTZ2LgoF2uHuASn8hf19GcdUUFLaRzQ9aZZBHcAO8UoCFmOOtemjnA/clZ46u
         WYf3ftDhLpdpW/xrzENYR4cfn7t0hc+bdzXH5DUJvUP0Z3JqhneNfSwHFhyFW3daqbkE
         /bFKn4t/2yO2E6+/ZeQrYzlVan9wZNnnJGfd1CZ6UKLbFzj+TZAW3SO2bDgFiJk4z0wU
         6JPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/2976aUSLYb9y5lxnzmVFGf44r/utXaelQAbD9fLk+E=;
        b=RS6fUSaLpVf5IgL8QfbDY1TzMEGvvB1P7LH3Gxiq+lyAaGEluGluWza8SUEEcR0U4R
         TZCxA433s8kdeKXMl9ZEwd7eu52TrsnJwhn74APThPrt6AdpG1l6n7On05oFXNu6V2YV
         0H5R8hd8U00pHo32AIIrAiOK2h7ppSd9GIe0k3GqK8pjXQXlYFvjJrTzsdIRkfwZa6LI
         X2XVMJrxrqWCc1MvQlNwH/rDXdVgxkoM/GJGbGvBPQkv8wC2x0xK6pMzMQyZsWE9wagJ
         SHtndklocoJgjzb2dwi9QP57AOQUypeVLeF+e2pecqO2xtnYdyT14eSKUKXocp2ZANxe
         zGZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fhv0wY1L;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fhv0wY1L;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vladimir Davydov <vdavydov@virtuozzo.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>
Subject: [PATCH 4.4 47/92] vmscan: do not force-scan file lru if its absolute size is small
Date: Thu, 24 May 2018 11:38:24 +0200
Message-Id: <20180524093203.997483717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338259899789374?=
X-GMAIL-MSGID: =?utf-8?q?1601338259899789374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Davydov <vdavydov@virtuozzo.com>

commit 316bda0e6cc5f36f94b4af8bded16d642c90ad75 upstream.

We assume there is enough inactive page cache if the size of inactive
file lru is greater than the size of active file lru, in which case we
force-scan file lru ignoring anonymous pages.  While this logic works
fine when there are plenty of page cache pages, it fails if the size of
file lru is small (several MB): in this case (lru_size >> prio) will be
0 for normal scan priorities, as a result, if inactive file lru happens
to be larger than active file lru, anonymous pages of a cgroup will
never get evicted unless the system experiences severe memory pressure,
even if there are gigabytes of unused anonymous memory there, which is
unfair in respect to other cgroups, whose workloads might be page cache
oriented.

This patch attempts to fix this by elaborating the "enough inactive page
cache" check: it makes it not only check that inactive lru size > active
lru size, but also that we will scan something from the cgroup at the
current scan priority.  If these conditions do not hold, we proceed to
SCAN_FRACT as usual.

Signed-off-by: Vladimir Davydov <vdavydov@virtuozzo.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmscan.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2057,10 +2057,16 @@ static void get_scan_count(struct lruvec
 	}
 
 	/*
-	 * There is enough inactive page cache, do not reclaim
-	 * anything from the anonymous working set right now.
+	 * If there is enough inactive page cache, i.e. if the size of the
+	 * inactive list is greater than that of the active list *and* the
+	 * inactive list actually has some pages to scan on this priority, we
+	 * do not reclaim anything from the anonymous working set right now.
+	 * Without the second condition we could end up never scanning an
+	 * lruvec even if it has plenty of old anonymous pages unless the
+	 * system is under heavy pressure.
 	 */
-	if (!inactive_file_is_low(lruvec)) {
+	if (!inactive_file_is_low(lruvec) &&
+	    get_lru_size(lruvec, LRU_INACTIVE_FILE) >> sc->priority) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
