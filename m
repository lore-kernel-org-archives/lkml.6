Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224iOCUkJcNF8AbN4xjvAeGKar3t47xzziHebmGA/1S4GokK3+aJW/S8W1d1D6vD8Va2qYZR
ARC-Seal: i=1; a=rsa-sha256; t=1517591499; cv=none;
        d=google.com; s=arc-20160816;
        b=pih6TTLbgVU0UjtSX5B3DW/THhQ4fXlL/EFr6Uzh3aVhmSAbXGUX1L54aJtyYACYxA
         6v0NE8kGBtseD6A30U8QaDSP6PblBGEWhWfqXPKw0DuPcfIM8eRyaHRKe+LfZMKYS/sM
         ymv3qBY00C+s1YmImO0+xeoPywa8j8qh4rhkJBWQrz/F8D0LVZBxSuQsEhT1QK+8RNuK
         qdslN1vTxNkOX3SegRY+HYjSLZhGVG8SxHkBjVgGtFKYq0yJbw7/iZf1aPYxsJb7O73Q
         mLjW5yoTOIKpafy58n301rsxMMrq3GktmjOMLsZ8x10pknqYCSXBKWuQdG0NV2irC9eT
         lc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0S9KoW8ZRO5lJLxbYTnnb04W2idS3aHkJYzzU5NvMC0=;
        b=EQQcxRC/TP7jNR5IDBPYgP6C4pr62jm5b0SgHpZQzvUs8nmh2KabsGWWH6A2XjNFwb
         T+GtTL3QHSAfxLUm4VNxPLn6kleGGtNlfXpU1Viudx5N7O38poD5DtJsutyMJA8bTX+7
         naNFi7/SS/ifn8DnXYqASt4ubNdtIxFvaARk5oq0qa6ybbgR0janF6KaySMjt9etZMyp
         PkBnTkBEKRLf1Xjvq9lHBoBb+yHCoJZFntzAPBBRRFOJYAzkkCpnjQUeoC+b4QURl0op
         7VI59+JdLma3FPmOn3MG0CPiGA8KzBaPV1+AQrdIFqlydLGnM8liwD8t46FhE5K/7jo8
         gWZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>,
	Omar Sandoval <osandov@fb.com>,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 071/156] btrfs: fix deadlock when writing out space cache
Date: Fri,  2 Feb 2018 17:57:32 +0100
Message-Id: <20180202140843.498772658@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309342633146937?=
X-GMAIL-MSGID: =?utf-8?q?1591310024348636472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>


[ Upstream commit b77000ed558daa3bef0899d29bf171b8c9b5e6a8 ]

If we fail to prepare our pages for whatever reason (out of memory in
our case) we need to make sure to drop the block_group->data_rwsem,
otherwise hilarity ensues.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add label and use existing unlocking code ]
Signed-off-by: David Sterba <dsterba@suse.com>

Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/free-space-cache.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1264,7 +1264,7 @@ static int __btrfs_write_out_cache(struc
 	/* Lock all pages first so we can lock the extent safely. */
 	ret = io_ctl_prepare_pages(io_ctl, inode, 0);
 	if (ret)
-		goto out;
+		goto out_unlock;
 
 	lock_extent_bits(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
 			 &cached_state);
@@ -1358,6 +1358,7 @@ out_nospc_locked:
 out_nospc:
 	cleanup_write_cache_enospc(inode, io_ctl, &cached_state);
 
+out_unlock:
 	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
 		up_write(&block_group->data_rwsem);
 
