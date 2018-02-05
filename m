Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225E1EEFsppBupLeKS8Nj3zyH+thbGbPWEdYC9c8e/4p39qa6/Wibqdv/+pISj+R6DoZZOpX
ARC-Seal: i=1; a=rsa-sha256; t=1517855194; cv=none;
        d=google.com; s=arc-20160816;
        b=BihmoYX0UVq0yyHuf4A292bVmbFijjGdz/okjY9iENqkBxlZw5astLDRSwcZD2835j
         y/8WH5sHtL9uMt/XjYkqZJg8Qv0G9PKziepKVHsbM4bUctMt2sm3WfPqz9XXmUxbH/fc
         aFb/rA599R2I32uy22zkpS+Lb8gvtzLYL864MAnlbhknktnrvtZKS9PUWgw8bgb78/gj
         0X5T6SCIoemR4Y6zk4Ve0RzvTFUoLg0I56fgoPVZBoxdfDTtcde2R8OqQMEZupQPKdiO
         ia8U8YQgzbWtNqHfPEstLXQZAeF4TELNLueCJwb+BPEHYItuoUr4HGxg5bOabhRuH8ay
         gITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tk1AtUGyVcMFTqbq69IqYSmFLBET80d6OBBrJ9ibZiE=;
        b=cE8bYViUBSzdxIF/UCx5WRoaBh7KbglLX9MRcZgP3BBcOup1w9qMKxN+yAERZ/AhAi
         bjjFDFK0OHwtzPblpCpZ6by6q5GHvprmNdkjoF2G106Qh5CixOpA5UkYjetw0Sc74qsZ
         XCcMzJ6sNn89x/6UN0L+3SlWuXiKdgmIkFOSbuoSZ/wClq3xNuLVpm4XdrVAwjWQAYDX
         5t4VNuuT2PTIznhkmPSa4ZP9gauItkR9vyQbl60uaH5coFv/98LTo+Wzs1tTkvjTmV8r
         RdBUdaU47YVt+AjKcyjJQVvYx8PZNXnocR+g8xDlsaACI+wb9y/sZ+zOx/gC2NRovWlZ
         Sdcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 20/36] quota: Check for register_shrinker() failure.
Date: Mon,  5 Feb 2018 10:23:48 -0800
Message-Id: <20180205182352.609023525@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586528322288722?=
X-GMAIL-MSGID: =?utf-8?q?1591586528322288722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2730,7 +2730,8 @@ static int __init dquot_init(void)
 	printk("Dquot-cache hash table entries: %ld (order %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
-	register_shrinker(&dqcache_shrinker);
+	if (register_shrinker(&dqcache_shrinker))
+		panic("Cannot register dquot shrinker");
 
 	return 0;
 }
