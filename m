Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvmhMFlr6T/7SPh3mSBeMNpm4YXW8Q2FQ2sDo7gexiVNWhCDyqsp6HqTdZ34rW88yZgbe5d
ARC-Seal: i=1; a=rsa-sha256; t=1521483846; cv=none;
        d=google.com; s=arc-20160816;
        b=AV9jFSJFEZm2td+hKbq6Uk9VJNk1yXjt1ehevFkOvD/16UakhlP4XR5iz3qGuuK0z5
         cC7oBB8aUHKGTJKZowgPH2GsBuaMemK8uhzFawfYVJIPnO206LiovSQhik7msBIkYONV
         CqMeNUE7oBdpISYrDuhSYPsCqE2QgwZC3ECuZFCPHqEOFrhxi8jObwShPrZliMUHDq+0
         xhOxBOO5CV0zhGmathNOoZM4TIV8IoX7RRavueZ0/VMNYMQsEXT+xcV1EQ/jlQpgEKe4
         PLyWlcVZYH9DFnMKIwp/qkw4bPyULqvXOlFbXkprhviW4sXhyZZGRGz3Y/g0KGgHj94g
         plmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zUHO7N72lFwgUQ1fAVmphsAwnTrEQDwawoG9hntiMdo=;
        b=uPPE+HI5zp4rSBHvE6J0MftSOl+JfZ+zeetBkcqd+89hh0Cr1XxfKHGdVUJzx/rm1v
         hPE0vluAh2qKpQVLNcyXQZPf8j3ynPXyFTN0pSHsovdIFmffrGWvYXc9HPYVsqm5Eurt
         BL/7Mbc/rMjDSiyYpHp9LZFyDq7ULCWWEUFg3Hl2t3MwrsgpCeS/LdBzg4V+ZNIi0j8N
         TOUKKAPlMHNFhbGec/kasxTq9Mb02h2wdig9lm35wffMaRGlz9sox5lq9mjCmARQqHe6
         jncwNhtexnajaqrDVoJpiXEgKqEe7QNyCW6cgulT7kFtKOJ67lwNkivoT2UibDhAoWac
         TVVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhilong Liu <zlliu@suse.com>,
	Guoqing Jiang <gqjiang@suse.com>,
	Shaohua Li <shli@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 137/241] md.c:didnt unlock the mddev before return EINVAL in array_size_store
Date: Mon, 19 Mar 2018 19:06:42 +0100
Message-Id: <20180319180756.864287271@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391445973831242?=
X-GMAIL-MSGID: =?utf-8?q?1595391445973831242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhilong Liu <zlliu@suse.com>


[ Upstream commit b670883bb9e55ba63a278d83e034faefc01ce2cf ]

md.c: it needs to release the mddev lock before
the array_size_store() returns.

Fixes: ab5a98b132fd ("md-cluster: change array_sectors and update size are not supported")

Signed-off-by: Zhilong Liu <zlliu@suse.com>
Reviewed-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4826,8 +4826,10 @@ array_size_store(struct mddev *mddev, co
 		return err;
 
 	/* cluster raid doesn't support change array_sectors */
-	if (mddev_is_clustered(mddev))
+	if (mddev_is_clustered(mddev)) {
+		mddev_unlock(mddev);
 		return -EINVAL;
+	}
 
 	if (strncmp(buf, "default", 7) == 0) {
 		if (mddev->pers)
