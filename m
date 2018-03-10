Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuE0BU0H0r4vV9Bj4ICuiI8QR7Bm9OTmuIJdFe57XF6OitrQ70t8UhKXEQHm2i9iPt2ieE6
ARC-Seal: i=1; a=rsa-sha256; t=1520641351; cv=none;
        d=google.com; s=arc-20160816;
        b=ven/hy09JXVyNl33qyKTprr5ldEAHoujDZ3Z16w1BNFUh+T6OLXogTr49eWYfCTsbc
         hOkjmKzgyiGcBWmRZfY8o7UB/rKmW4cgfVaeeoEi0RIIvYJGRqcKkcgqI0BM5n+deRkj
         GQyIbyTmrVWbu867lxTVZ9RU6ofJr9e06ECYcxva0UeVfBPYu+vVIiQBRTepbRFtKFV+
         ACIf+HW8KBWdirZ/JKPcEtjNscB7MRclWf3bTIHvExJA3Y9d799DCOjFCen2hphpWkse
         o4PA16ZfCwBftzod4RZxoXjsLpxXXfBoEyAU24mCac7vFaCXr1CMCWlgsZHFYZIj0jKA
         x3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O0yTtLy4kzpTcj4CQDL05LnHWTLyc+qHNwQUE7C+pEA=;
        b=Hos3vm4JlrKbCQB4nqD+cwF0LrzcpYik6UGhvlshtT5fwkaoEDt5F6foCxCWc90LKG
         TnMN228wOr1REb2rfqq/i4dUWwiz/lpN5ka3inzJ4MoLlxAr0m3m+KKfBC1B+rfGjC1/
         9Jz1PoElUsqElSnbWxMHuZ7PODKbezkPYhY+BF12QxlheFGtEIu1TklrAHlmgIVkxozl
         K45fSF/jHevLiyhqQQ/NFQGuDBOEvqcKPt9BgXJqLhYSQPsNAFGdE+7T8as+140pKbfZ
         N152WJK4rnz5hAVE++gw8/DPb7T2Ab7hkh3dGMGvbVghEVnEn6V28QbkxoS2TfS8s5PX
         fzFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhang Yi <yizhan@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.9 25/65] dm io: fix duplicate bio completion due to missing ref count
Date: Fri,  9 Mar 2018 16:18:25 -0800
Message-Id: <20180310001826.924856436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507837427893471?=
X-GMAIL-MSGID: =?utf-8?q?1594508025555865788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit feb7695fe9fb83084aa29de0094774f4c9d4c9fc upstream.

If only a subset of the devices associated with multiple regions support
a given special operation (eg. DISCARD) then the dec_count() that is
used to set error for the region must increment the io->count.

Otherwise, when the dec_count() is called it can cause the dm-io
caller's bio to be completed multiple times.  As was reported against
the dm-mirror target that had mirror legs with a mix of discard
capabilities.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=196077
Reported-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -302,6 +302,7 @@ static void do_region(int op, int op_fla
 		special_cmd_max_sectors = q->limits.max_write_same_sectors;
 	if ((op == REQ_OP_DISCARD || op == REQ_OP_WRITE_SAME) &&
 	    special_cmd_max_sectors == 0) {
+		atomic_inc(&io->count);
 		dec_count(io, region, -EOPNOTSUPP);
 		return;
 	}
