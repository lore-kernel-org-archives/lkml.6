Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49MUghPbdzmJMZ20GtfPUG6cLv17Y8QudKxTFAne2Akf2BoArEcdaH0yMtG5yMY4cABPJIP
ARC-Seal: i=1; a=rsa-sha256; t=1524652832; cv=none;
        d=google.com; s=arc-20160816;
        b=VSc+/Fh963J63joMWFxaU5DZ3I1ij0iHGngig6lYh2JXtA/3PxTyqd+H8mHOs/u/an
         RB3/cQ/EZDmw5AF0HHRAtqa0rUvRNyTmY4nfbCk7gsTI9XT/PSZVPd7+E2YiRGGeDEES
         QAVkaBn/HREAVwuigCDtpgrNcR3/BzQxXHE4uFDzM/aWSI6o4bGoHLsotxIOBdcBw1hl
         Q6Xvqq619QppXNwu6J6JuGJL3t9eyWE36qSPtuabLbo9tLsNQHI0XSgL+8l6IJC/MqJi
         ejLwKMdkvpkpQXQMuk0KppyQYGJ7uHluCcnC3r3HeoIqsFCIlkgYxDSmun4/PVPAqSgY
         /3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gb9VukKy8lfazEwzynMK6s8sdJfmocZlIEHxhNLKKfw=;
        b=BZ+zAuoQHMl7Ldm1y0Il+z7lD8hCLXIqbgTxZBFIaCJFHVxYSt8sIvgN4/GQyazCUu
         DL7tLlNywUnboEQa2m0CL8l7GG37OCBCo4udijHS54BhXe2rGlC3YDpc4+qTQUBE4JKL
         rN/tYe20vMP66yr/euR47BP3Lldf527GKrwO3H/BkQNQiXoHwe/c4hMyfI9eHyb2wjmT
         tvp9E7BDfKD6dZ6KENtH02fuaaJ8RVj4R2xY3eYvy3N1Rd+CMyFtkZnKECI/TxtFAzMT
         DlyLIfWqlk5c6vEoJx0ZE/a0pwh2D04XWx8zDlMVhi/lPaxeBQYBxo3oi+ZlpO63ArJJ
         flrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Carretero?= <cJ-ko@zougloub.eu>,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 068/183] Btrfs: raid56: fix race between merge_bio and rbio_orig_end_io
Date: Wed, 25 Apr 2018 12:34:48 +0200
Message-Id: <20180425103245.253338998@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714368100510606?=
X-GMAIL-MSGID: =?utf-8?q?1598714368100510606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>


[ Upstream commit 7583d8d088ff2c323b1d4f15b191ca2c23d32558 ]

Before rbio_orig_end_io() goes to free rbio, rbio may get merged with
more bios from other rbios and rbio->bio_list becomes non-empty,
in that case, these newly merged bios don't end properly.

Once unlock_stripe() is done, rbio->bio_list will not be updated any
more and we can call bio_endio() on all queued bios.

It should only happen in error-out cases, the normal path of recover
and full stripe write have already set RBIO_RMW_LOCKED_BIT to disable
merge before doing IO, so rbio_orig_end_io() called by them doesn't
have the above issue.

Reported-by: Jérôme Carretero <cJ-ko@zougloub.eu>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/raid56.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -858,10 +858,17 @@ static void __free_raid_bio(struct btrfs
 	kfree(rbio);
 }
 
-static void free_raid_bio(struct btrfs_raid_bio *rbio)
+static void rbio_endio_bio_list(struct bio *cur, blk_status_t err)
 {
-	unlock_stripe(rbio);
-	__free_raid_bio(rbio);
+	struct bio *next;
+
+	while (cur) {
+		next = cur->bi_next;
+		cur->bi_next = NULL;
+		cur->bi_status = err;
+		bio_endio(cur);
+		cur = next;
+	}
 }
 
 /*
@@ -871,20 +878,26 @@ static void free_raid_bio(struct btrfs_r
 static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 {
 	struct bio *cur = bio_list_get(&rbio->bio_list);
-	struct bio *next;
+	struct bio *extra;
 
 	if (rbio->generic_bio_cnt)
 		btrfs_bio_counter_sub(rbio->fs_info, rbio->generic_bio_cnt);
 
-	free_raid_bio(rbio);
+	/*
+	 * At this moment, rbio->bio_list is empty, however since rbio does not
+	 * always have RBIO_RMW_LOCKED_BIT set and rbio is still linked on the
+	 * hash list, rbio may be merged with others so that rbio->bio_list
+	 * becomes non-empty.
+	 * Once unlock_stripe() is done, rbio->bio_list will not be updated any
+	 * more and we can call bio_endio() on all queued bios.
+	 */
+	unlock_stripe(rbio);
+	extra = bio_list_get(&rbio->bio_list);
+	__free_raid_bio(rbio);
 
-	while (cur) {
-		next = cur->bi_next;
-		cur->bi_next = NULL;
-		cur->bi_status = err;
-		bio_endio(cur);
-		cur = next;
-	}
+	rbio_endio_bio_list(cur, err);
+	if (extra)
+		rbio_endio_bio_list(extra, err);
 }
 
 /*
