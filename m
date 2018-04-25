Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5xWtowRrJUHuzxnO+JFpKcwLJR4M3f4jTI7fbdNXbPc5snSiLr/oxoU2vI2z8yxbKyFQb
ARC-Seal: i=1; a=rsa-sha256; t=1524652774; cv=none;
        d=google.com; s=arc-20160816;
        b=c6hFqG5W8VB9zTAy+j2did0tOLQ1q1mcCjjvMGN4Jj6+gp6qSpZFZ5pHNvB3u/YFq4
         gyPI5Z6uta9WrSCm0VT8bUgeiylzfO64NP1noe2yeygdCdEbGNd8UwRc5ankNbXxHBb/
         snVU67hY4I1X1swtaZ/rSERO4pG405C0CrAylWNSpwgXK8xBNR7E/jxmL5ZR968ydt6g
         BLARURxPlBIzlRbYpf7c920pAkvGuc25hyifQOvz0FjaJxfhQXLHZ9QbHYdblOIuvri7
         exWmOS1anPIjl3wDdLaLdA2/HzPfyrRSnR5VSH/qpcSriWyRFbr3yvjlK8+NyhTpBgOA
         +pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jmJ3/whBXSJggkDbcSAtt66CNE1dx4bqLqbsTrk9OkQ=;
        b=JIdD3Rl5gUO45+G1vCh5d2ocSbnX93eCdjL4xheoGcFq9x52Me2NsL/Ml6HLDXij5o
         DZGdwzed4K1uyW3PnpJko7AD5xoo3SkpS4aFR5yiWJuUbKJtMrZhTB7ZtUAytbz9zQ8z
         ex8HUavM9x6wiFUDbO32ak7GqWWkJVFdMkf7hok5QV/FYWi+K7KKYfwSbV9Nhl3jgarj
         uTRLFLicctvsWHmqS/6yxwJvlQT/bM8lQQ1uW9BSEjmYWmo0U6FldUlmvcHFS5qIa6ls
         NHL7xhV1UGBmmg/4OF7pXrIIvxDFyZRPciug1lr6XKJwDSt2ItsJkgeJvxdlIFy1Uy+4
         62Pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 063/183] Btrfs: set plug for fsync
Date: Wed, 25 Apr 2018 12:34:43 +0200
Message-Id: <20180425103245.059479448@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714307119735174?=
X-GMAIL-MSGID: =?utf-8?q?1598714307119735174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>


[ Upstream commit 343e4fc1c60971b0734de26dbbd475d433950982 ]

Setting plug can merge adjacent IOs before dispatching IOs to the disk
driver.

Without plug, it'd not be a problem for single disk usecases, but for
multiple disks using raid profile, a large IO can be split to several
IOs of stripe length, and plug can be helpful to bring them together
for each disk so that we can save several disk access.

Moreover, fsync issues synchronous writes, so plug can really take
effect.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/file.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2018,10 +2018,19 @@ int btrfs_release_file(struct inode *ino
 static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end)
 {
 	int ret;
+	struct blk_plug plug;
 
+	/*
+	 * This is only called in fsync, which would do synchronous writes, so
+	 * a plug can merge adjacent IOs as much as possible.  Esp. in case of
+	 * multiple disks using raid profile, a large IO can be split to
+	 * several segments of stripe length (currently 64K).
+	 */
+	blk_start_plug(&plug);
 	atomic_inc(&BTRFS_I(inode)->sync_writers);
 	ret = btrfs_fdatawrite_range(inode, start, end);
 	atomic_dec(&BTRFS_I(inode)->sync_writers);
+	blk_finish_plug(&plug);
 
 	return ret;
 }
