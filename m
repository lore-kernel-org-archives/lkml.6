Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbw2N7nKbSk/Hy9GiqBLE1Xjc8wFPiQt/cpAuRhDX2wjOlV4tcJHf0aG4MWAENv2v9rLAG
ARC-Seal: i=1; a=rsa-sha256; t=1525767160; cv=none;
        d=google.com; s=arc-20160816;
        b=P+vJF0WbzDelIodKoHi9rCByY29pjRAxpshL7H1Q4C8EgrQWzrNS1Dll1d1v4W68or
         A4NjsVMYtIc+RWawJUACeur+W9UppZDEUL1kjIrRsGM8RAfQ0hdy4RFi9SvFmVYr2sRH
         ZcJrfVaRVwJVIrGtSnucvNi/RNWyUTH9dIDKiraPaHy1YVgUdgXVJYgfd3XE5tsUV1Jd
         YO594fZq1AltsyoHzn5z3QagXrEfB9Ie0tiKsPC7cjFGwywCA1rmENsF+vR6jHEk9eYU
         UOZfr/bDmWWcu5lMZe514XZdGkWSh8E/dXBNll7CgL39zz9BFWtljBQO+cszoDIO+WIs
         jIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Tz5SYn7KHoY/YsG4+zAm+ryFxepEdmZH8BKrYdwRAAM=;
        b=FNBPDCThc3MjxMIRFgt7EcSVw8h+Bpz+ysUrlcza96/lvRG5rOegE9E810qQBfrNbv
         fvGNwAOVsthfVNN/aT9WJJtBbBRQPKD17fqC3E1AYiIwPEgZwtcvlj7n7Jk+nOwHX3Nq
         dquXxMeaCxyYaApKrLlZ+xPcxbUVgChTcV78R4o4mIpd2pyxpu74LJtP+h6MazcHdRkZ
         dVJ8NILmvlUdZuCFDck8iMb5aStyA3zDI3SyRfKU2rKjuDosTs5LEgjHBra7Y2ZLdldM
         sJUEmcSrt4jQOuGpcsRbP16jTHfajRBOZkYtZzCsG8t8wIpc0EZadCweazNCEqzQbV27
         DuQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lOvRYDUt;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lOvRYDUt;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	ethanwu <ethanwu@synology.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.16 30/52] btrfs: Take trans lock before access running trans in check_delayed_ref
Date: Tue,  8 May 2018 10:10:28 +0200
Message-Id: <20180508073932.232169601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882826311602745?=
X-GMAIL-MSGID: =?utf-8?q?1599882826311602745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ethanwu <ethanwu@synology.com>

commit 998ac6d21cfd6efd58f5edf420bae8839dda9f2a upstream.

In preivous patch:
Btrfs: kill trans in run_delalloc_nocow and btrfs_cross_ref_exist
We avoid starting btrfs transaction and get this information from
fs_info->running_transaction directly.

When accessing running_transaction in check_delayed_ref, there's a
chance that current transaction will be freed by commit transaction
after the NULL pointer check of running_transaction is passed.

After looking all the other places using fs_info->running_transaction,
they are either protected by trans_lock or holding the transactions.

Fix this by using trans_lock and increasing the use_count.

Fixes: e4c3b2dcd144 ("Btrfs: kill trans in run_delalloc_nocow and btrfs_cross_ref_exist")
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: ethanwu <ethanwu@synology.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3155,7 +3155,11 @@ static noinline int check_delayed_ref(st
 	struct rb_node *node;
 	int ret = 0;
 
+	spin_lock(&root->fs_info->trans_lock);
 	cur_trans = root->fs_info->running_transaction;
+	if (cur_trans)
+		refcount_inc(&cur_trans->use_count);
+	spin_unlock(&root->fs_info->trans_lock);
 	if (!cur_trans)
 		return 0;
 
@@ -3164,6 +3168,7 @@ static noinline int check_delayed_ref(st
 	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
 	if (!head) {
 		spin_unlock(&delayed_refs->lock);
+		btrfs_put_transaction(cur_trans);
 		return 0;
 	}
 
@@ -3180,6 +3185,7 @@ static noinline int check_delayed_ref(st
 		mutex_lock(&head->mutex);
 		mutex_unlock(&head->mutex);
 		btrfs_put_delayed_ref_head(head);
+		btrfs_put_transaction(cur_trans);
 		return -EAGAIN;
 	}
 	spin_unlock(&delayed_refs->lock);
@@ -3212,6 +3218,7 @@ static noinline int check_delayed_ref(st
 	}
 	spin_unlock(&head->lock);
 	mutex_unlock(&head->mutex);
+	btrfs_put_transaction(cur_trans);
 	return ret;
 }
 
