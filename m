Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226VXue4L8FbEAeqdmvqLW+7c+YIMpIPDrLnVQK5GHmAFf7c2KN7t6rmzjjOOxjRkMprdm25
ARC-Seal: i=1; a=rsa-sha256; t=1517591552; cv=none;
        d=google.com; s=arc-20160816;
        b=FCRlMeP3CmFTIqxESu4UoqLX2y64ypsa2wJhFZPmZtG7J/4JHEUoHtua5z2NKNI1rZ
         f+xKIpRxvNfUajrJKmw8TbgJ0hAq2pa1wyKwZK5iK62TDTmS0U3z/9tX6jIf5oUwi00+
         y5c35/0l4oAhzM8qZx/SjnBPmp/YZJec1H9LlMCcG246xgRG6tYrdQD1I4NoBnERVkMT
         0sTgaVPI75nfTGqox0sU1prtKirbBNQGbdMXCiG5pcaRAtS2qACaHbmsG9OTHqj7fJ8v
         42K4yKHi1JhhKxSdcy1Wyx6Kxh32H4RMnJ4aSC9v7lw7F+M5WTYwn4ZtiAypqaAiHQ/D
         lDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AVsgAIVzynWi4a+EyI4ZsjL/NyicpZBn29EMNqZXa1I=;
        b=MRAJTARNmk5Izow6qNNVkOBlKsvR8LjII6lvoiapg6Xexlv2TUNTH4JNTDneArIdlO
         rYBeYvu5gIr0RewbTg030fUjNzNJdqMcbaB3ZsJblxktckfEe4QNeTTS7V9jU6NMvWxh
         HGXFcwpDKhsrLk0J3jyAAD5wClR4WA98a64vJcl2WAbhBL+UX10Lo2Q194YkRqHgf2u0
         /dN9S99C3rsWw2HFj8/yz0WUNnDNA1D0iHJcmmvf+B6iv8hI4ZD7CiWJCMYgrc99pTG0
         WEHk3bwS0fmscnYWZ9HKCv5j/SsGnZ8QP869J1sR9wjxuEFEv3kxTRGWKx+tu7n2x3Jn
         guPg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 101/156] quota: Check for register_shrinker() failure.
Date: Fri,  2 Feb 2018 17:58:02 +0100
Message-Id: <20180202140844.777208902@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309376971073820?=
X-GMAIL-MSGID: =?utf-8?q?1591310079726219723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
