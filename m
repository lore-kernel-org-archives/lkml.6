Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227fQuWKQPb4Ay+91OTSNW9DhoL4O72eEhu9ne3rH+m5NnY90zs8ONnqHGr/TtOM9wrahBvQ
ARC-Seal: i=1; a=rsa-sha256; t=1519217728; cv=none;
        d=google.com; s=arc-20160816;
        b=tndErs3PKdbityhV5Dw2dzI1VfZK7IDOiORLoKkxp+EarhUJ03J5xj4EiN0FR1xkZ8
         VUx3srS59D6WY5UnmcVq/ZoxR/3At+BHlgGdvUS0r66rCmYSMWaFFfqMBNBKOQaM/j1L
         FvsuLqkvpJz2BPi+ZfvvQNTE9j6FTQ/RSbiWypj2Z8JW0zvcaCl48ZIpuxykbw1sygTd
         +O8YKmwNPHRbEwTC2OT2h3jpBrSjtfGuDw88tLLkGd4LoEmhWzHuA4gfb4MDiZgkMjPY
         +VrkvYHgcCY6KT7EKiGvjV3pDNiwRfZFVbJ1unDHBRU7dFrf9mxenzJTziMgzD4m7HlZ
         YfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LluB5H22ZRuAVRx41cnTKlXDww0NzfxAMOoVcDHYqfs=;
        b=P/SuU96n8Ndd1Fa3hXF/ni/wWnj6D6K5NE+hJ4qIljayi4twbNLY+T0lSs0VGYF3Rg
         +iWy4jWEQ/bcs5qhU6dEsHM8Gz96iEqe2rTVIg2eNRYmkMTB9F1O9mUr7zOsPTEoAPEO
         oLj7RSfL8kjuVjDSWF/KZzQmYj/A1SlyLKRGkD80vUxZtIB0taemrh9o4tfCl800RSLY
         BsK/Hmzcd5/Z1CCTHgfzT3XWVk+c6VB/ECpdqwEc6lNXYLNuulR4rbbi2Uk0pFvmUJPE
         hoptnq+6OiG1d6cTe27Rnu2XbiVoH8TIWyeKTE99SVjTG8sIW2Hl1uCbECy6Uj6HCNEv
         ExmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.9 33/77] dm: correctly handle chained bios in dec_pending()
Date: Wed, 21 Feb 2018 13:48:42 +0100
Message-Id: <20180221124433.581232888@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014686624050782?=
X-GMAIL-MSGID: =?utf-8?q?1593015248786280655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit 8dd601fa8317243be887458c49f6c29c2f3d719f upstream.

dec_pending() is given an error status (possibly 0) to be recorded
against a bio.  It can be called several times on the one 'struct
dm_io', and it is careful to only assign a non-zero error to
io->status.  However when it then assigned io->status to bio->bi_status,
it is not careful and could overwrite a genuine error status with 0.

This can happen when chained bios are in use.  If a bio is chained
beneath the bio that this dm_io is handling, the child bio might
complete and set bio->bi_status before the dm_io completes.

This has been possible since chained bios were introduced in 3.14, and
has become a lot easier to trigger with commit 18a25da84354 ("dm: ensure
bio submission follows a depth-first tree walk") as that commit caused
dm to start using chained bios itself.

A particular failure mode is that if a bio spans an 'error' target and a
working target, the 'error' fragment will complete instantly and set the
->bi_status, and the other fragment will normally complete a little
later, and will clear ->bi_status.

The fix is simply to only assign io_error to bio->bi_status when
io_error is not zero.

Reported-and-tested-by: Milan Broz <gmazyland@gmail.com>
Cc: stable@vger.kernel.org (v3.14+)
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/md/dm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -809,7 +809,8 @@ static void dec_pending(struct dm_io *io
 		} else {
 			/* done with normal IO or empty flush */
 			trace_block_bio_complete(md->queue, bio, io_error);
-			bio->bi_error = io_error;
+			if (io_error)
+				bio->bi_error = io_error;
 			bio_endio(bio);
 		}
 	}
