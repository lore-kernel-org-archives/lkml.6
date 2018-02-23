Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtwyPqd+fsaEzYleNeoBp9H02H6KVMwd4xuQigfC7e0jonQl4kIStbJI+HcTPWLBz4AlwBg
ARC-Seal: i=1; a=rsa-sha256; t=1519410612; cv=none;
        d=google.com; s=arc-20160816;
        b=efu60leB100bjuSIn0KBzo4ttunrtlHdSK6oLjOPLKbaXGvA0WWcQpBn5ggNXl8pno
         veBFM/QZeEB0ATu60xPVRUaPzN+uZ/qkcSVZUNsrdsO8c6HhpfJUqaEMgplldll8v0fh
         ZQBRZdQllXlPfKTb57WbihaAMEgPPum6qJlO/WVkprOYq2SLDvVjCx0zPIo4Savq85O6
         wi9E00wyO7kba6GDywtjdbzr2oDxAdaEjXFjxa/gEMda2tIXUSIJw6NAf7bL6kBP9dmp
         tsaIIALhzl1eDM+AQnfd/P/dZIoZ3EqvnzwMrEn9f4woXd4MK8DsK04gWuuTuaRLL0yt
         Jn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oz0RhDTf6lBC7lpVSSJ7EjZIhEsARb/AknXiOqj6gWg=;
        b=WyXVTFkiosHVqEOocSWGJX50WbNOnkqde3n3pAFxX+IFFqOltJ/gBdOhnz+4aVdW5D
         spxVAAvbP2DZBBAodUFaCThK7864GGEr/j8+BAa7/T9jaRb/TvMgGlAe6SQIS7T16jVk
         lpA5gLOPBHnsACAvAsBaIQpKjjX09yW/CFKJvOYvSaoxE3JlDvHVWHAA9Q99tBgY9A00
         vknOAauSJ1kTXYGM/pRXJ+hS+XqmSC9PttL70NAqd9PI1hUuJPe+hNUVM6MMykgslRMU
         BOUU4K2RS6BWzrfwCwEVz/7QHNYNDupktgbndX9oknE2FS3xT8mCSpAzi2ugeuUQ9t5Z
         dujw==
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
Subject: [PATCH 3.18 13/58] Btrfs: fix deadlock in run_delalloc_nocow
Date: Fri, 23 Feb 2018 19:26:12 +0100
Message-Id: <20180223170208.775595070@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217502104112550?=
X-GMAIL-MSGID: =?utf-8?q?1593217502104112550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1256,8 +1256,11 @@ next_slot:
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
