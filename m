Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv/0iV9lFArov21STR2dFXN2E3Py6f/H2pRctSXBKxYrRV7Cqy8NExCPDwBbsVH4OxZ3QYf
ARC-Seal: i=1; a=rsa-sha256; t=1520641232; cv=none;
        d=google.com; s=arc-20160816;
        b=GxgGsYa0R2QsnukMT+AlbkbVDUmk2hSKr4Mx5ySP5s7a8Xh4wnaA1n5OrR+JQwqzOF
         yW2PsFELwEdsDtWGWkBOFJbMvy4J1ed/LT3sqkcDxcyoCOr7TWxsiuaS3su8A6sjS03+
         0rVXRf7mUfnB+VUconsd7mQpx0Epw25I98uYEKoyYfKNDPtayeCaDsaYFk1sxEIv9Y3r
         YM7/v+ru6W7+WdfaWNePKE29JCv9wUMJB6zUATAmpewDTIU/TEW6N6J9eRlvoD41xBLn
         0YGo6GKvxY8qSWkD8UL5AXrUKkjTxV6a2SxyIjGSiXmNWAV9Ofw5jWDsYysi9d1+9NwU
         AR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XvCU50PC7u3+kkdd3B1fa7iYG0KWLmagx96s3ABLpJw=;
        b=mFvzhUks3DCxRYNJZzEXpmp/k5AiFaI6Lf5iV+O6zdF4tu+W0Jt0cef7TInPbvGslk
         cDCkjupmOXBwYe32R9TZFX4X9rCGEyFPJ/uXa2U3yLgi3nffuYNBtK3T1qrwW8sT3cEs
         LMdtHesHOUH5Cvo6uAc+0j6OAi1UbEHptmArOGxewfMB6uclvuTj22ueRvlhEIY7YRQH
         F6r0XJG4j95nviJdqe5/rY5Tr8dovhnVp9SgnL161MDxKpfVPRaZGuApq9AN7EJT1lfC
         X2k0WFNguVWQRwiPH9Ss1/Rt/OXWufo+JZYdO3ndUxlY0TzUIhZETmRAaJzr7wj4jkXn
         Z3CA==
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
Subject: [PATCH 4.4 34/36] dm io: fix duplicate bio completion due to missing ref count
Date: Fri,  9 Mar 2018 16:18:50 -0800
Message-Id: <20180310001809.241968272@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507837427893471?=
X-GMAIL-MSGID: =?utf-8?q?1594507901164942330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -300,6 +300,7 @@ static void do_region(int rw, unsigned r
 	else if (rw & REQ_WRITE_SAME)
 		special_cmd_max_sectors = q->limits.max_write_same_sectors;
 	if ((rw & (REQ_DISCARD | REQ_WRITE_SAME)) && special_cmd_max_sectors == 0) {
+		atomic_inc(&io->count);
 		dec_count(io, region, -EOPNOTSUPP);
 		return;
 	}
