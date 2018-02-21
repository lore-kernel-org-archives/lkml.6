Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22748CtMV7cJOERmRF0maRWhlGRS8cIKm2vRYvQ6qjvNrDoAc32HKCzX3pZ9AtoEpESSihEV
ARC-Seal: i=1; a=rsa-sha256; t=1519218244; cv=none;
        d=google.com; s=arc-20160816;
        b=i0jldh9Junh5LG6R5nn4L3J7TkE6JnmXIAjbBvASLRdYHY7gq80dQjzUMe0l46TWtZ
         uO9FhZDeXLR4fpGEeYlGjpmpgMnZXYw8k0Sm/BHM75d03KnSzQRxuYwcQwgsgj5tUdaz
         yivcUxfQX6NiV0N0YL4r2ppsw73wADdzcf1M23NrgcMmkJSFsJ20uLrdrm8S9k8zRWip
         GgHRa/Z9Dd9owNcG4LLdxB4ozPTKHSQTZ/cGyuTv7bGDIB6YLRZdVMG6nT5/pwPdfEEC
         r6Uee+5JGMMeitDeuuqLcKIxzmOb6CoohQ1PWtQceGiaJU/6szfShph8TTYtmOJWDIzQ
         0vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nx+H9/MmP6lfQV6DMC8tZ5+eJLR6g7dJKscFMzz9eDo=;
        b=UCqw/VMljBVwkTu0RwFpvqrOEvPTrsjbQY9x3pM3akQXku4Smv4xHSNg1tLPckBRE8
         gjnTzY5AQerRjRRmE0tRP2+WDAZk6JCI+DyShb9WCWq4wsBAShM+oRunIE4RnM1UDchv
         xqJo6R6AfY37XQZF5yy8rcCOggjVtwG8qPh9K+hsTbGbDdXz4l6Lx6lpzweGtd/0V+2X
         tNLtMc79n12mZCYrbZstQynZH7FNYrBJnWBX4fvstpvKn82/C4pDbih3t5HLdmWpYgp2
         USxC4O8Gll7EVEwzqaqVg2BUAPcdNsEv9LPH9F6LlPZ58S2nnKh49GjZcuuIJJnuS5RY
         3DcA==
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
Subject: [PATCH 4.14 137/167] Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
Date: Wed, 21 Feb 2018 13:49:08 +0100
Message-Id: <20180221124532.132874262@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015210708041633?=
X-GMAIL-MSGID: =?utf-8?q?1593015790196521052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5318,7 +5318,7 @@ void btrfs_evict_inode(struct inode *ino
 	trace_btrfs_inode_evict(inode);
 
 	if (!root) {
-		kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
+		clear_inode(inode);
 		return;
 	}
 
