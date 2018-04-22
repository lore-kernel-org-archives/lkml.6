Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nkPrDq3uEVka/AEsHRfTtI7QuIhPS0OI2n1FiywQgPvdZP20+g2rJk298aqlJvu+Iao3d
ARC-Seal: i=1; a=rsa-sha256; t=1524405526; cv=none;
        d=google.com; s=arc-20160816;
        b=Hjq44fUqZCPCL4FidAwvFhPCm0CkAerRvQtVVm8yEi7ucit0Eph7pZ9UUNgLEQYKG6
         NEN5RbLOc0aPHvXH9hPIvQQsTL1PuVlc1wU95Vxa/k8Lw/CNaQSbj+p0hIcl8JTDcosI
         rk7TfJEEPRq7KCmYKhFap98NPztxJMD/SkY2byv4P3+oa9KSJSvJV+ZlUBkCUuHM/hpJ
         o3yKpgchRa4rF5FoL0qhDT3TiE5Wl3Wg4YCIXf5ICZHc1wxOBPaC6Rplwj3qzhkoDmZq
         vnH0BPNzF16tzLFPasOcyKo81E7cruCMIRNb2n4Tkmt+LIwlYWNP7Rn0lSMG2eCUr2f6
         EySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8++761NPdX7XpMt6d46q5KoV+anPNz2XB6TJvTpXXEM=;
        b=S0cpN/7cMhiMyD3wG+MY9Mp5PO9RhL8RE5n6LHS0KQ3VKvQn9VIX3ppQrgWPj2FIAm
         R4UAaFkRUo8bnEkc/MXCb+I49JFd/URWMIWf+A06CuJ0mmrDpcFPr165BugHsRBeJS4u
         15qGCDySx9XF1dEO0P1wIJlKbI4BFdXjvASruRRhjD3MsLFgbPIM7uICD0hXZSOPCx6M
         +xYHtt7hWvjAHTwNgMbykQjpDF39mP4YVidLiNAdclXcetEkAGeCFH5ejCk+Fohm0wd/
         n2yrlhr1pC84UfUUZn5x9QnMECgmOmMzAu51cGUiaPoHZKXwdKgfV7feSFlapyjJpefA
         G9ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.16 100/196] dm: backfill abnormal IO support to non-splitting IO submission
Date: Sun, 22 Apr 2018 15:52:00 +0200
Message-Id: <20180422135109.425346976@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455049644718673?=
X-GMAIL-MSGID: =?utf-8?q?1598455049644718673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit 0519c71e8d461ac3ef9a555bb7339243c9128d37 upstream.

Otherwise, these abnormal IOs would be sent to the DM target
regardless of whether the target advertised support for them.

Factor out __process_abnormal_io() from __split_and_process_non_flush()
so that discards, write same, etc may be conditionally processed.

Fixes: 978e51ba3 ("dm: optimize bio-based NVMe IO submission")
Cc: stable@vger.kernel.org # 4.16
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1477,6 +1477,23 @@ static int __send_write_zeroes(struct cl
 	return __send_changing_extent_only(ci, ti, get_num_write_zeroes_bios, NULL);
 }
 
+static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
+				  int *result)
+{
+	struct bio *bio = ci->bio;
+
+	if (bio_op(bio) == REQ_OP_DISCARD)
+		*result = __send_discard(ci, ti);
+	else if (bio_op(bio) == REQ_OP_WRITE_SAME)
+		*result = __send_write_same(ci, ti);
+	else if (bio_op(bio) == REQ_OP_WRITE_ZEROES)
+		*result = __send_write_zeroes(ci, ti);
+	else
+		return false;
+
+	return true;
+}
+
 /*
  * Select the correct strategy for processing a non-flush bio.
  */
@@ -1491,12 +1508,8 @@ static int __split_and_process_non_flush
 	if (!dm_target_is_valid(ti))
 		return -EIO;
 
-	if (unlikely(bio_op(bio) == REQ_OP_DISCARD))
-		return __send_discard(ci, ti);
-	else if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
-		return __send_write_same(ci, ti);
-	else if (unlikely(bio_op(bio) == REQ_OP_WRITE_ZEROES))
-		return __send_write_zeroes(ci, ti);
+	if (unlikely(__process_abnormal_io(ci, ti, &r)))
+		return r;
 
 	if (bio_op(bio) == REQ_OP_ZONE_REPORT)
 		len = ci->sector_count;
@@ -1617,9 +1630,12 @@ static blk_qc_t __process_bio(struct map
 			goto out;
 		}
 
-		tio = alloc_tio(&ci, ti, 0, GFP_NOIO);
 		ci.bio = bio;
 		ci.sector_count = bio_sectors(bio);
+		if (unlikely(__process_abnormal_io(&ci, ti, &error)))
+			goto out;
+
+		tio = alloc_tio(&ci, ti, 0, GFP_NOIO);
 		ret = __clone_and_map_simple_bio(&ci, tio, NULL);
 	}
 out:
