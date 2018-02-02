Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227V1mzshxWDgMUUIskYTkNvcvNXd065QxR6IWuZZKLqJLfjABFf+deFZPhAAmGkCuUbeRTA
ARC-Seal: i=1; a=rsa-sha256; t=1517591196; cv=none;
        d=google.com; s=arc-20160816;
        b=eFKebiqSfcfhobc/mDoyg+tKfDK1++AkDxsI6y6vi2/2BCbC7DXLnIHFm2ECyeS4+R
         97PVkGlWqHOYCOlXrDGQOjqu7FvhN+0KuYRrWDVEzdxEdC6nqoschfrJaFe8b9duGWll
         84jfYXnbaKGzefI1lekFW/UTGfQtt0K3HyUq5kAaGcVrqd8V66pKLzkjZiriHZBAMwur
         H5lsau02glcO9A7rLNB5f6ZgHkYpLQNm0vgy6N0FPMmGpbmoEssygzb7maExMbm00I6G
         UL5V+du8u+UQDvztIL/Syxtad+BOSr2B1rgaCD+1HxRKA2kuYxZfjrOKd6K3xpLc/KMQ
         +RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J87ZbkEnEsuGI65+RTO4ZJM4rimBjtsf/ZzIQ39sZ+0=;
        b=weHR0laZOvx2NQVji0CI+P0zTXpG5TYpeXiMFiX0zq8rQTnv24CH/r2rC/UxU2gteu
         HkYfo2aLvDt4t8dChXeeh48M6ZMzeZ7xLQSSrHzT+3nKdBoEytTCU173IyqWa0eEn+7d
         VS7trkQMFRnT5QRvKAO/P2mKkHulhkQdBnJO3rSw3c2pkA15/3IBu32RThGQNzrdAyWO
         qyhCoJ+N3akeEjkU3f5J9OI8DmR36fEUm7oaGJwrKoBKYvvbA8TlbwsX9c5KGLab9ySG
         5CpvbezPmKUu1AehpYKJ0sSeUfmiiTwn20GjJ5SDxzn0erXiktQwftYiLGG9nfLer/P/
         cnLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 51/86] quota: Check for register_shrinker() failure.
Date: Fri,  2 Feb 2018 17:58:11 +0100
Message-Id: <20180202140826.948824042@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309376971073820?=
X-GMAIL-MSGID: =?utf-8?q?1591309706585567356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>


[ Upstream commit 88bc0ede8d35edc969350852894dc864a2dc1859 ]

register_shrinker() might return -ENOMEM error since Linux 3.12.
Call panic() as with other failure checks in this function if
register_shrinker() failed.

Fixes: 1d3d4437eae1 ("vmscan: per-node deferred work")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jan Kara <jack@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/quota/dquot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2985,7 +2985,8 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	register_shrinker(&dqcache_shrinker);
+	if (register_shrinker(&dqcache_shrinker))
+		panic("Cannot register dquot shrinker");
 
 	return 0;
 }
