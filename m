Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224wCjQxDaRY3gHsn7hGQ5RxweJ7WFhQTQ+xmcChid0tB2W5f7GzGQr0l+1zXH80laRBcz26
ARC-Seal: i=1; a=rsa-sha256; t=1519217145; cv=none;
        d=google.com; s=arc-20160816;
        b=WrATkGqAhedPmWFcsff7nG8xb5HtIrkdAnFffyDwRBjlunxxnpOfQIAqgw10w6gGMe
         Fsstd6TAtbhEaKIF4Yg9DM+D2+TaTIlnmUDfzp4qXf//tAwltmr4rNZsWK+O6B5E8LIO
         YpjJWIz2n730whntLjcheat0IiZWTZch9bCX8sMdBfg7/2FDcWy0GJCIaE7A8IEg5ECW
         ILiomLd3ubsVl6CgX0UVLnJnl1NX3pV6KwVgMNKSn8M3P7g4JR8DKuJgaSvdy/tWDG8B
         z4HS8+H51TPiKyfY4lfrqACcWgq27e88zMfZ2iSWy4NAP2wpK1hGk5rKiU8PJYh1+4Qd
         mTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MEMYijsZvJsy79WK83pWpP3NVssbxUPdhOq9N4IaFTs=;
        b=1HhWwjt53U532u0IgrZi5rsenv9Owag8FUM/nV/UyDUf0nw7ptaQYtswNBhhdouivo
         oR10rsRRhzzI1WkvkmSJs4NYLlzD6XoTCjqUWNP6lC8pgVkCQXNs2wbB3cUJ0DyvXCLt
         JNEppLGANQWLcrcKWHlnzdYD9H7186DD2Rh5Z8szB3J49ijlkYhXNY/F8oHrhW0NcTFk
         /tFboA4FIkp9V3b5yI8j35F82kbetapwJJUw8m1Q4HvasJHPUmpjZl/+VJFdpg0ZfLOG
         wffLa+M6lPC1ErPYmhlWEldyQ8qQ7l4AKShbqVYqvqj2T7nugirOmLCvmRQl4EeKNlij
         UUhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 19/33] Btrfs: fix deadlock in run_delalloc_nocow
Date: Wed, 21 Feb 2018 13:45:02 +0100
Message-Id: <20180221124410.602319680@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014637413119175?=
X-GMAIL-MSGID: =?utf-8?q?1593014637413119175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit e89166990f11c3f21e1649d760dd35f9e410321c upstream.

@cur_offset is not set back to what it should be (@cow_start) if
btrfs_next_leaf() returns something wrong, and the range [cow_start,
cur_offset) remains locked forever.

cc: <stable@vger.kernel.org>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1292,8 +1292,11 @@ next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
+			if (ret < 0) {
+				if (cow_start != (u64)-1)
+					cur_offset = cow_start;
 				goto error;
+			}
 			if (ret > 0)
 				break;
 			leaf = path->nodes[0];
