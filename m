Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49uhQV5lmAwWz2oSL8za1hgMonPpQJpd5jpD0rbCuNx5g5SEGwHhJMeL5XwjxDS9sQnK8LW
ARC-Seal: i=1; a=rsa-sha256; t=1524652779; cv=none;
        d=google.com; s=arc-20160816;
        b=Qh5OXxemevBMV5z5Zl7+S2IUthTejtcIw5zsRfPheJmav6qKzQUZ7kaBzT/h1Jt1CU
         2KJ3tJcOQIVL5F0eFJHdJwRvxn0iMJO51UhNNJwQ9JQvOH5tYFJh2WwK6lLeDhG3vn2Y
         lPw0V49Wo5rG87Jj/WUdtPSoxT/HtbTJVyNPQS3USb9s5LoIUzx/EvOUxpYyCj/6oVXT
         27AfZtLY6YIObYmaFR+mr0DZh9mFFstrw0Hc7QunarKgvBRtCcpsaxd0rmB9pJ8i/dEB
         t9nTR/5S/qkkufqx5r6fDRem/9QVRrYnpVyM/YOL8X867Q0i5Epyvrc5rB7BsOmL9s8m
         zkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TpivFnVbg2YGx4U7PnWK4z/4K5dh2MgcOcVNES+WqLY=;
        b=qyMZk0aZvLtfMPjo9orFvS3CjrnYjthRVMjt1EEoMeLDIMLQ4tK8Axgsgzpnud039h
         2WrbErRgP8mgr7WimwXTZpW/6+AknFHmi4tVnJRpWVTwCU72a0pNn0HpGPGjTDd9izoQ
         Ol6oikz8D/DUz/OW3hevRKpTEX1gQs9YGnMQQAnhvbYGDoUVl6wCq58o7/Lz6N+o9OoU
         NyqpPGFewiwnSFr1XjgqjZ1nR++m4QYJdtM+Foa7xPslQJpLaG7psumFFfbILFBqsKpy
         NCZQFuN5OqonHw6s7/etqKABEVelRzq2422l8F7A+i7lVvV+FChyJPY/lBMz+tStp8m+
         LaJg==
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
Subject: [PATCH 4.14 065/183] Btrfs: fix scrub to repair raid6 corruption
Date: Wed, 25 Apr 2018 12:34:45 +0200
Message-Id: <20180425103245.136128272@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714312970045815?=
X-GMAIL-MSGID: =?utf-8?q?1598714312970045815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>


[ Upstream commit 762221f095e3932669093466aaf4b85ed9ad2ac1 ]

The raid6 corruption is that,
suppose that all disks can be read without problems and if the content
that was read out doesn't match its checksum, currently for raid6
btrfs at most retries twice,

- the 1st retry is to rebuild with all other stripes, it'll eventually
  be a raid5 xor rebuild,
- if the 1st fails, the 2nd retry will deliberately fail parity p so
  that it will do raid6 style rebuild,

however, the chances are that another non-parity stripe content also
has something corrupted, so that the above retries are not able to
return correct content.

We've fixed normal reads to rebuild raid6 correctly with more retries
in Patch "Btrfs: make raid6 rebuild retry more"[1], this is to fix
scrub to do the exactly same rebuild process.

[1]: https://patchwork.kernel.org/patch/10091755/

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/raid56.c  |   18 ++++++++++++++----
 fs/btrfs/volumes.c |    9 ++++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2159,11 +2159,21 @@ int raid56_parity_recover(struct btrfs_f
 	}
 
 	/*
-	 * reconstruct from the q stripe if they are
-	 * asking for mirror 3
+	 * Loop retry:
+	 * for 'mirror == 2', reconstruct from all other stripes.
+	 * for 'mirror_num > 2', select a stripe to fail on every retry.
 	 */
-	if (mirror_num == 3)
-		rbio->failb = rbio->real_stripes - 2;
+	if (mirror_num > 2) {
+		/*
+		 * 'mirror == 3' is to fail the p stripe and
+		 * reconstruct from the q stripe.  'mirror > 3' is to
+		 * fail a data stripe and reconstruct from p+q stripe.
+		 */
+		rbio->failb = rbio->real_stripes - (mirror_num - 1);
+		ASSERT(rbio->failb > 0);
+		if (rbio->failb <= rbio->faila)
+			rbio->failb--;
+	}
 
 	ret = lock_stripe_add(rbio);
 
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5101,7 +5101,14 @@ int btrfs_num_copies(struct btrfs_fs_inf
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
 		ret = 2;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		ret = 3;
+		/*
+		 * There could be two corrupted data stripes, we need
+		 * to loop retry in order to rebuild the correct data.
+		 *
+		 * Fail a stripe at a time on every retry except the
+		 * stripe under reconstruction.
+		 */
+		ret = map->num_stripes;
 	else
 		ret = 1;
 	free_extent_map(em);
