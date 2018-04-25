Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZrJZisQUYOLVOwPr2265peqSbK1JH8kR97sEY7aSzUQG9HaD1/qtErn5Gy51NmAUbcboei0
ARC-Seal: i=1; a=rsa-sha256; t=1524652777; cv=none;
        d=google.com; s=arc-20160816;
        b=sW1sHYyYb21b3AiwZV/K3tr3M1tfmsia16r78bR5HTQf5iBOpZkxuq4bOA7XZaZVcx
         zy1mTTP7H4f24vG/TNqr0ED5bVDex4B155CmDAoTBb2tGYsLQDeTRkchH3mWEilr49cy
         2DV0aRuPyELXuGgrVTkoecJLTuEZsfqxk9smuY5HikSKtRbV4zpo43BmC2UfdAis5C/V
         lEwyl5IwdrYwkMx0X1TjNRD06TmGxZdnpI1GihkCw98e/4Mxm/DyFyhv4IBiXrJawBjP
         /ZYnutJ4gHBlCJkvRCbbPxsQo7SuCR7GZ7vZQRFDig4t8hZ3FhuAU9GKsK6Ke8vZnp6m
         fInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t5Ntu9rq8q+EahCNMtsAeFUJeax9z9PSCY9uKWbwF80=;
        b=l42+yU5vQMslyildo5ZFXjAW1JVTcipu2KIQ+yjQAwJ+8Hnd9LN7SzpY6fQ51II7Y2
         VGMGe25J7IFU9QzRWh+uD+RVh3L73aIZxsm1IqSSbU1zcjYAwSB+gmOLn4wpWpf61+MY
         MKoi0AjR4vbA0xdwHIUYz7gVRUDntDyjr6y84hLB3YBphHbbRZ4917HHSOBx0d2gdeps
         ZdNLobXRJTDoSI2vIBQYdY6Hdh7wsijT73njXDigob45TIHS44BGIb9JW2722a/x3sKk
         vL1BbYPJ5i1B9t2V45oa1S4AIGCOrVBou0FmJg6WETU0AXz5UsQXvL4kwV5p3Tvyn+ox
         vc+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 064/183] btrfs: Fix out of bounds access in btrfs_search_slot
Date: Wed, 25 Apr 2018 12:34:44 +0200
Message-Id: <20180425103245.096293356@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714310369947173?=
X-GMAIL-MSGID: =?utf-8?q?1598714310369947173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>


[ Upstream commit 9ea2c7c9da13c9073e371c046cbbc45481ecb459 ]

When modifying a tree where the root is at BTRFS_MAX_LEVEL - 1 then
the level variable is going to be 7 (this is the max height of the
tree). On the other hand btrfs_cow_block is always called with
"level + 1" as an index into the nodes and slots arrays. This leads to
an out of bounds access. Admittdely this will be benign since an OOB
access of the nodes array will likely read the 0th element from the
slots array, which in this case is going to be 0 (since we start CoW at
the top of the tree). The OOB access into the slots array in turn will
read the 0th and 1st values of the locks array, which would both be 0
at the time. However, this benign behavior relies on the fact that the
path being passed hasn't been initialised, if it has already been used to
query a btree then it could potentially have populated the nodes/slots arrays.

Fix it by explicitly checking if we are at level 7 (the maximum allowed
index in nodes/slots arrays) and explicitly call the CoW routine with
NULL for parent's node/slot.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Fixes-coverity-id: 711515
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2774,6 +2774,8 @@ again:
 		 * contention with the cow code
 		 */
 		if (cow) {
+			bool last_level = (level == (BTRFS_MAX_LEVEL - 1));
+
 			/*
 			 * if we don't really need to cow this block
 			 * then we don't want to set the path blocking,
@@ -2798,9 +2800,13 @@ again:
 			}
 
 			btrfs_set_path_blocking(p);
-			err = btrfs_cow_block(trans, root, b,
-					      p->nodes[level + 1],
-					      p->slots[level + 1], &b);
+			if (last_level)
+				err = btrfs_cow_block(trans, root, b, NULL, 0,
+						      &b);
+			else
+				err = btrfs_cow_block(trans, root, b,
+						      p->nodes[level + 1],
+						      p->slots[level + 1], &b);
 			if (err) {
 				ret = err;
 				goto done;
