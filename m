Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227U2Jw50wZrKuND6vB7xC64rZW5yHC/6hkRKmk0iFIsfcS3kBUh5VfN4+fNs3lEzno5YMzy
ARC-Seal: i=1; a=rsa-sha256; t=1517591475; cv=none;
        d=google.com; s=arc-20160816;
        b=TMsZdwyQtvEIr5Lr4T5Vov2CWu0Z6t2W66TdT+vatJSPa5/NVNDC+lDIzXCRuMBjKk
         Vs2lw8+LU8HINn/W9L+t6qn9p8DaITCgTTL0LoGix0kl3t0GFE3COotAv2M47HTgH6RP
         WPObmX8Qci+3R1aZL4PBHFmpyWgADnuLN4EOPLmtFxX9L1ddslrqWHTp/yGZjbLBwM+P
         e6KAuYR9Wnzz81ozhffEPsBOrMktxyxS1dcqJFiAvkeRsMxExm01HCLjVKgvmHR6ULNe
         NZpVNwePtZJupiYLtGrWtvxWosSPz0bpMhxVQ3Cm8sfrCClXcl7OMqfeE6aLpL+sHXw0
         BkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o7bbXmV2+BFr00KYt+Al8ZulHw2PnKowK2jpeq9gVIs=;
        b=gT4zRzb3AxnsQo1FGjk6GS3cm+DAykeXO60vEifb1GCODOmxu57kVxIn7G2p5i7089
         6RY5Z3mAzh+LtcMOQbSuM9P+8f/FqeLg+BGO9wTEwCdTTJR6Hj7W7PGZWZEA8pdx0JYl
         4k0g78BjczoZQTONRtvF3JJ+RPcPUq+Mc99XMVz7GS+b4YTSXTnwNir2Kjf0J9vsCMy9
         vIF6wdn9bGZ7Kc7dM5p/Ix4GYcpfreJib52n0MLqKnvaIqbluR8x8OSYvmHcBIPY6Z+d
         tEqm41HIfO3NGh5t8HsA6S9RVfDE3rVCahh8R9SSsTzMFzW9F5PzDglQ3Hc7sG3N/rKj
         tdEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Chao Yu <yuchao0@huawei.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 092/156] quota: propagate error from __dquot_initialize
Date: Fri,  2 Feb 2018 17:57:53 +0100
Message-Id: <20180202140844.405332383@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309999435898622?=
X-GMAIL-MSGID: =?utf-8?q?1591309999435898622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>


[ Upstream commit 1a6152d36dee08da2be2a3030dceb45ef680460a ]

In commit 6184fc0b8dd7 ("quota: Propagate error from ->acquire_dquot()"),
we have propagated error from __dquot_initialize to caller, but we forgot
to handle such error in add_dquot_ref(), so, currently, during quota
accounting information initialization flow, if we failed for some of
inodes, we just ignore such error, and do account for others, which is
not a good implementation.

In this patch, we choose to let user be aware of such error, so after
turning on quota successfully, we can make sure all inodes disk usage
can be accounted, which will be more reasonable.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/quota/dquot.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -934,12 +934,13 @@ static int dqinit_needed(struct inode *i
 }
 
 /* This routine is guarded by s_umount semaphore */
-static void add_dquot_ref(struct super_block *sb, int type)
+static int add_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode, *old_inode = NULL;
 #ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
 #endif
+	int err = 0;
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
@@ -959,7 +960,11 @@ static void add_dquot_ref(struct super_b
 			reserved = 1;
 #endif
 		iput(old_inode);
-		__dquot_initialize(inode, type);
+		err = __dquot_initialize(inode, type);
+		if (err) {
+			iput(inode);
+			goto out;
+		}
 
 		/*
 		 * We hold a reference to 'inode' so it couldn't have been
@@ -974,7 +979,7 @@ static void add_dquot_ref(struct super_b
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 	iput(old_inode);
-
+out:
 #ifdef CONFIG_QUOTA_DEBUG
 	if (reserved) {
 		quota_error(sb, "Writes happened before quota was turned on "
@@ -982,6 +987,7 @@ static void add_dquot_ref(struct super_b
 			"Please run quotacheck(8)");
 	}
 #endif
+	return err;
 }
 
 /*
@@ -2372,10 +2378,11 @@ static int vfs_load_quota_inode(struct i
 	dqopt->flags |= dquot_state_flag(flags, type);
 	spin_unlock(&dq_state_lock);
 
-	add_dquot_ref(sb, type);
-
-	return 0;
+	error = add_dquot_ref(sb, type);
+	if (error)
+		dquot_disable(sb, type, flags);
 
+	return error;
 out_file_init:
 	dqopt->files[type] = NULL;
 	iput(inode);
