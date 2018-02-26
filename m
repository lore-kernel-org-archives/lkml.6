Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227yZ1qoucxGG1hQBmlMG344oY8ZsARFHhBmDCmuDc9MvNhN0o0HCXnZIJM3Agiux1rvZU3/
ARC-Seal: i=1; a=rsa-sha256; t=1519676895; cv=none;
        d=google.com; s=arc-20160816;
        b=tHNq6DEC/n9ZFCQlJ63KMKFJUJIyW3deZ8+5JY2aCOcgJ51PmKOzeEN9M3MTRd9XTp
         JLj3rpEf9Moy/oTLvWsksZlmy+gq4Lv2XQO7hSNUBY/4iEw1ynDT+vrrkPS81v2ze8DO
         Z17SMhgqNK43WwjG9r9N/PeTUia1YRMFkl0IC4ECmqOn0ndkyEITpASy2LKYqM41yNqB
         GvNUhea0vHdvS9e7FHcXp1SOHxYillakncSiUTBe0gDxT8SPXxf173rg2iJLSSYolidz
         7kpjPAxPr9RtZMcnjw6pieAvvMPr5eCpuSWZrpQJJCnM+6Vm7jz0OT8SDddUpYxasbNX
         wWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0/0Vs3uoxJDogdASkWPvyHlvHfpnaAnhN0I/uGhhWgY=;
        b=WQVGiOAp7KR8JPdyrBw54WIG8G/3ayZkRZDqzysmc1LMqncnPaqLPyCcqR4juZJTsw
         7Pjqg/UWHPXqVheVHN94rJsTX9tjLWD99yh1YvVqJntoMiZ9JYeii4UPweCeDCrAJJDK
         /okzsIqofdGOIa0Sk352OXH45UzmtXYKguB54niR3g5/v7rwH6r6Xm8oO21muJNoBAUQ
         7RXyC6u1I9Q+PshoA1/Iv0OrNalwK0ETuntNtXCPd/woOiPxTy0gWgjwUFVlXBCfuUyE
         x82j3C2M51dlXI+avwmS5gFyDkcssUKfoczJ0xH+qC5bJqDJQznUU81tlSxDvqq9Tlm4
         TVMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.15 49/64] Revert "usb: musb: host: dont start next rx urb if current one failed"
Date: Mon, 26 Feb 2018 21:22:26 +0100
Message-Id: <20180226202155.548768959@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496312946551337?=
X-GMAIL-MSGID: =?utf-8?q?1593496719782422933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 44eb5e12b845cc8a0634f21b70ef07d774eb4b25 upstream.

This reverts commit dbac5d07d13e330e6706813c9fde477140fb5d80.

commit dbac5d07d13e ("usb: musb: host: don't start next rx urb if current one failed")
along with commit b5801212229f ("usb: musb: host: clear rxcsr error bit if set")
try to solve the issue described in [1], but the latter alone is
sufficient, and the former causes the issue as in [2], so now revert it.

[1] https://marc.info/?l=linux-usb&m=146173995117456&w=2
[2] https://marc.info/?l=linux-usb&m=151689238420622&w=2

Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_host.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -393,13 +393,7 @@ static void musb_advance_schedule(struct
 		}
 	}
 
-	/*
-	 * The pipe must be broken if current urb->status is set, so don't
-	 * start next urb.
-	 * TODO: to minimize the risk of regression, only check urb->status
-	 * for RX, until we have a test case to understand the behavior of TX.
-	 */
-	if ((!status || !is_in) && qh && qh->is_ready) {
+	if (qh != NULL && qh->is_ready) {
 		musb_dbg(musb, "... next ep%d %cX urb %p",
 		    hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
 		musb_start_urb(musb, is_in, qh);
