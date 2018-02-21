Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227LJXtSX4rNAmkl/O5eNAbV04v5PK59/Zx/jVnkkVRXaMd9o4Bg7gYfvQ3p9x9uthsEDagZ
ARC-Seal: i=1; a=rsa-sha256; t=1519217692; cv=none;
        d=google.com; s=arc-20160816;
        b=ubyQK+mrIOtHc6iYi0AehGOEHj4qIP2woCm4tKicPpUx74SkrfiG/jmBHvHdndeKu8
         e3PB4hxTYuBUkC1JzZXgLGEWE7FHojTwhG/GxjCjCR3Snij4eHscSHCL9D76sFe26Tzz
         lA1TXylq28HIHNajTh+f36BAF5MiR4GbTzt7x6EhsvJIwIIxD+cg01X6sgqtmkAUCTJS
         HfN7rlPA0+LShS5EnH7JQfEewr+Zw36v6sI3Zv11OMBXt6rzISK2j3IjyB/XHDL562Eq
         zeEmorsWNPMYX1Jbnmj49IYV/oraITat7hhc+ggQ4ZAwMg1LqdnpnLGL4oalDoSOqvEH
         7+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Tf3u1JJEYNwvw9qOWo98z2MX5fMFwJVHJLbfiEENCpM=;
        b=ws80JZ8CMsxQ0hhDX+JcvxBZLKQWmGGHvWmUOZGWKkGqwe3QYuAiNyCY0CuuchAIRq
         GntT6oU/vPC8FH5rqncSg/qjzH7FYYCJzKJG1NQegM9MvC86/PhEAz9YK6h2YnbLdqjH
         lfjX45NiOR8b9f8qqNwlAZlpOoEv2QrAV79alGIYs0vG46eu+1y4iaf2J44bzUeM1QAO
         Y7lHLL4h1sweCJJmrW1hBaYgjVbDMnEcxGyyuw6ltu4w5i4zN/LaxAUCGkCZiOS9a3Yo
         u3MHYe0+O7sZ8CiedpZnf2fAskI9l1GODT+y2HvUeVqSXHZGNTmpbY27gUPYftrRntGz
         CFJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	Nikolay Borisov <nborisov@suse.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 21/77] Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
Date: Wed, 21 Feb 2018 13:48:30 +0100
Message-Id: <20180221124433.073992378@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015210708041633?=
X-GMAIL-MSGID: =?utf-8?q?1593015210708041633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit e8f1bc1493855e32b7a2a019decc3c353d94daf6 upstream.

This regression is introduced in
commit 3d48d9810de4 ("btrfs: Handle uninitialised inode eviction").

There are two problems,

a) it is ->destroy_inode() that does the final free on inode, not
   ->evict_inode(),
b) clear_inode() must be called before ->evict_inode() returns.

This could end up hitting BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
in evict() because I_CLEAR is set in clear_inode().

Fixes: commit 3d48d9810de4 ("btrfs: Handle uninitialised inode eviction")
Cc: <stable@vger.kernel.org> # v4.7-rc6+
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5229,7 +5229,7 @@ void btrfs_evict_inode(struct inode *ino
 	trace_btrfs_inode_evict(inode);
 
 	if (!root) {
-		kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
+		clear_inode(inode);
 		return;
 	}
 
