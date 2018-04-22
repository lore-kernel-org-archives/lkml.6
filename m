Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx485lMe2fIRLB7whAus/7d5ZnlRcIjIBIxOKsaSYmMpkL9KWHIhihul4Cf/wbLzQzo7j+7f3
ARC-Seal: i=1; a=rsa-sha256; t=1524405348; cv=none;
        d=google.com; s=arc-20160816;
        b=oaIZEiEtqauIzytfHDprqEmK+8KnHRDPS4CIJCQm/F2DsGPeqZjv48M3VWxo1MOqtD
         d6wc0AuJX71x9xd7Kiy3d1ck+RoyywzIa1RkPCTj6KhoSco0LU6SmEv7nyre25waZCzE
         n6LoZJ7JLRvW4gaZJ94FFb1F3aiQYNpRnaFJoLJ/MI7T1BGlqFlXhnF3h5x/Tw3JnYLb
         lf4L7XPt/7gJn46MZIkKyrT3oFAjPflmT5PxuqcFK/AdBOjRCyqz8qh+Uysa3FplcTtO
         ssxzZyTIftNlGCx0Ikyfsvuyy3fo8W+GILoiwSG0cbJ4O1whvs19fOiU+eR17oHmwErk
         kSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9lQaqgxy2LLU0D9ZWFj1KTE1HWbgNYNsARPw3zYbt40=;
        b=wvM+mftrUsE9tpEqEoiRs3QIKfQf4UZsbrH8XEILIf+Ah7UgymHp7tM1REban3bKIV
         E6eb/PzLeEWjkAO+obRWsGUWjUP9KTxJTGqgfBQ17t8unKZhbDlUQWY/krTfA/jPK/py
         iRDC6rEldgn1Ipk89mkk1r33Dp1c17BV/MJ74eWAXcx+NBxwIQ3ag/78FZpFoEYNS7Vf
         JmjD1pVpdgpsi374m6M2qmx7E+WpF5rh+B4SmfkPJiAWqH+DZXAOY7MZFO60z7oXRXDQ
         x9Od0dBm7Cu+CRuZAWEGntopfl9meOb0EJvO3i8/BxHJHgEvYkhWaLUOdOX9fYQpq8KO
         b5BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Devin Heitmueller <dheitmueller@kernellabs.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.16 033/196] media: vb2: core: Finish buffers at the end of the stream
Date: Sun, 22 Apr 2018 15:50:53 +0200
Message-Id: <20180422135105.816331285@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454862808864148?=
X-GMAIL-MSGID: =?utf-8?q?1598454862808864148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 03703ed1debf777ea845aa9b50ba2e80a5e7dd3c upstream.

If buffers were prepared or queued and the buffers were released without
starting the queue, the finish mem op (corresponding to the prepare mem
op) was never called to the buffers.

Before commit a136f59c0a1f there was no need to do this as in such a case
the prepare mem op had not been called yet. Address the problem by
explicitly calling finish mem op when the queue is stopped if the buffer
is in either prepared or queued state.

Fixes: a136f59c0a1f ("[media] vb2: Move buffer cache synchronisation to prepare from queue")

Cc: stable@vger.kernel.org # for v4.13 and up
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Devin Heitmueller <dheitmueller@kernellabs.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/videobuf2/videobuf2-core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1696,6 +1696,15 @@ static void __vb2_queue_cancel(struct vb
 	for (i = 0; i < q->num_buffers; ++i) {
 		struct vb2_buffer *vb = q->bufs[i];
 
+		if (vb->state == VB2_BUF_STATE_PREPARED ||
+		    vb->state == VB2_BUF_STATE_QUEUED) {
+			unsigned int plane;
+
+			for (plane = 0; plane < vb->num_planes; ++plane)
+				call_void_memop(vb, finish,
+						vb->planes[plane].mem_priv);
+		}
+
 		if (vb->state != VB2_BUF_STATE_DEQUEUED) {
 			vb->state = VB2_BUF_STATE_PREPARED;
 			call_void_vb_qop(vb, buf_finish, vb);
