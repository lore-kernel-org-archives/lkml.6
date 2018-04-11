Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49bQOTO/T0k1pm9TZqdGrbdWcsjraVYzo0CIZhjKOxMN1M7EyNMCTvOxiEMe5yvCHO88m6q
ARC-Seal: i=1; a=rsa-sha256; t=1523472981; cv=none;
        d=google.com; s=arc-20160816;
        b=bhYiLmLHqNj3K+Cn3RbZMVkK0EeQ+HvX9WUm9KCd1yQe7vnDGbgJKWTyB6BFN8LLai
         jIuoOVdQNWoEQQ7vFxnx5lKNCouQEGsWn1tHENju8EMId3Ia+/07eyP9L/c+WRDxKYZP
         unPNmn/OQg5/+LeTwPYA4kbl+5qoktP4UpxvPDau8r+oyzOY9vxqeBg3edc8UMxjgOQi
         1ARXLhzuj3SjCNUd0GdqkT9vwfK0rIaeTVPspZbIT5xiZCqzjRl8e+w+q44zFnt9RQ9e
         W13eBGXO2rjCmdMvG/5UVU61YS0cx7QmvSUxnOjvJ3QcI6iVj+eg+fhorW2HrdDo2Hum
         uVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lhkpoewnm15dX6rH0dDTRkiMPH+u5KXc/mXVk7niodI=;
        b=fXMiSrhlchQ8pgKDwMGUZqBmuPwmNUnF/AG9f8EaFJIr2NIElu/55He0qXlRR352aM
         LDGSvD1P5ha6oXUiB/WHZEH5T1gTIMLZfGbTw7JrC4JLo8iz8OXeQ6IbVOYp5JJINyNy
         C+ocNMD3p3AzpoI9NgC62y/xFzThOxmus8OCyPRi515GNcfFXUuoLn0xxMSTvr1Ht4f1
         NezLfXPD2aJJjnHmdU+bqmlhTH2J5aSPYhCPZWD6FCpOntnI0eBfR819/R8EdG50JSOM
         LpRjk4PTX6Q9QjBIvaPILEDwGs9HjeUPHW/tEHhayigQbuVucllBwzvZJCwbNqFfsH4E
         tdug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 086/310] ext4: handle the rest of ext4_mb_load_buddy() ENOMEM errors
Date: Wed, 11 Apr 2018 20:33:45 +0200
Message-Id: <20180411183625.973364202@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476551972650721?=
X-GMAIL-MSGID: =?utf-8?q?1597477205299114994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>


[ Upstream commit 9651e6b2e20648d04d5e1fe6479a3056047e8781 ]

I've got another report about breaking ext4 by ENOMEM error returned from
ext4_mb_load_buddy() caused by memory shortage in memory cgroup.
This time inside ext4_discard_preallocations().

This patch replaces ext4_error() with ext4_warning() where errors returned
from ext4_mb_load_buddy() are not fatal and handled by caller:
* ext4_mb_discard_group_preallocations() - called before generating ENOSPC,
  we'll try to discard other group or return ENOSPC into user-space.
* ext4_trim_all_free() - just stop trimming and return ENOMEM from ioctl.

Some callers cannot handle errors, thus __GFP_NOFAIL is used for them:
* ext4_discard_preallocations()
* ext4_mb_discard_lg_preallocations()

Fixes: adb7ef600cc9 ("ext4: use __GFP_NOFAIL in ext4_free_blocks()")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3877,7 +3877,8 @@ ext4_mb_discard_group_preallocations(str
 
 	err = ext4_mb_load_buddy(sb, group, &e4b);
 	if (err) {
-		ext4_error(sb, "Error loading buddy information for %u", group);
+		ext4_warning(sb, "Error %d loading buddy information for %u",
+			     err, group);
 		put_bh(bitmap_bh);
 		return 0;
 	}
@@ -4034,10 +4035,11 @@ repeat:
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
 
-		err = ext4_mb_load_buddy(sb, group, &e4b);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
+					     GFP_NOFS|__GFP_NOFAIL);
 		if (err) {
-			ext4_error(sb, "Error loading buddy information for %u",
-					group);
+			ext4_error(sb, "Error %d loading buddy information for %u",
+				   err, group);
 			continue;
 		}
 
@@ -4293,11 +4295,14 @@ ext4_mb_discard_lg_preallocations(struct
 	spin_unlock(&lg->lg_prealloc_lock);
 
 	list_for_each_entry_safe(pa, tmp, &discard_list, u.pa_tmp_list) {
+		int err;
 
 		group = ext4_get_group_number(sb, pa->pa_pstart);
-		if (ext4_mb_load_buddy(sb, group, &e4b)) {
-			ext4_error(sb, "Error loading buddy information for %u",
-					group);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
+					     GFP_NOFS|__GFP_NOFAIL);
+		if (err) {
+			ext4_error(sb, "Error %d loading buddy information for %u",
+				   err, group);
 			continue;
 		}
 		ext4_lock_group(sb, group);
@@ -5117,8 +5122,8 @@ ext4_trim_all_free(struct super_block *s
 
 	ret = ext4_mb_load_buddy(sb, group, &e4b);
 	if (ret) {
-		ext4_error(sb, "Error in loading buddy "
-				"information for %u", group);
+		ext4_warning(sb, "Error %d loading buddy information for %u",
+			     ret, group);
 		return ret;
 	}
 	bitmap = e4b.bd_bitmap;
