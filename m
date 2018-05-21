Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqljzgDnsOdWR/KCLNakVmNnlvORYglwySFRHUmADyOa72drpu8+LuQiSz3payrmLPAD5jB
ARC-Seal: i=1; a=rsa-sha256; t=1526937831; cv=none;
        d=google.com; s=arc-20160816;
        b=mSKzSezFlM5P0nOZ+ZUPabHGgFDHSU0WH3NTmDJaJuYBCdhNnvyMUD0PXGi6MSZxz+
         8Q3InIv4amsHjgaqo2QjZqntmaQxH0jodY8XqUscJeddRlTvd1fyh2pnh//SsEmMBICY
         N7G9v9SNIK/RNsk1PZCVN6QFZ+08QGRfcH3qTOVPI8tvta+95RmXgn3ePCcstaD1J6Er
         xPmJNP3vMWE5qM9H1EdLYAlzx1OOzdNoVXRJAohVbOCyTNRtDXfTxyrP7u/WZuySxpTB
         B5eDVRKiS56sQHCMxJjHn+qgaKUopUKQuqoDmA+9gyza5YffrF3NvAW9eZMj1Jg+XFet
         x5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=o8PWWH9l28w2w/I/WJn6wozheaUESM1/9RB+99kvNmI=;
        b=nLjZQZ4WZlID35LPRGdpiM093N0qBjmb8bOkAXbuy7GeZPS/Bv9Zwfpz7L6T5kzaiZ
         upXH22fPLsneoVhwHVw1Jou1B1TBBiQFfWpb6/Z+3PH47Hu/JZqjLZCrtRvx/Q5IRqAw
         BrCEp2k5+4G+A/E1I3XypFZkqAPC9OTR7ot9xPZ1geJNG/vFox4xWyL7iqGJckf5kLvV
         D3m9Ce3XMe7HZaZR9+tw+sNjRA3NxY8+rN5wX8Trrn7EV0RuDU3UW31pl1hGdz28HeXg
         JxMM5JDSti9ZJnSXpBm/0G0pvnOTA941TiQKNk6k04kOp2cJtmzqf0kW+J4gQU7WLx22
         8mSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NqGBV5Kp;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NqGBV5Kp;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 042/110] s390/qdio: dont release memory in qdio_setup_irq()
Date: Mon, 21 May 2018 23:11:39 +0200
Message-Id: <20180521210507.853502959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109877906061998?=
X-GMAIL-MSGID: =?utf-8?q?1601110363537779117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit 2e68adcd2fb21b7188ba449f0fab3bee2910e500 upstream.

Calling qdio_release_memory() on error is just plain wrong. It frees
the main qdio_irq struct, when following code still uses it.

Also, no other error path in qdio_establish() does this. So trust
callers to clean up via qdio_free() if some step of the QDIO
initialization fails.

Fixes: 779e6e1c724d ("[S390] qdio: new qdio driver.")
Cc: <stable@vger.kernel.org> #v2.6.27+
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_setup.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -456,7 +456,6 @@ int qdio_setup_irq(struct qdio_initializ
 {
 	struct ciw *ciw;
 	struct qdio_irq *irq_ptr = init_data->cdev->private->qdio_data;
-	int rc;
 
 	memset(&irq_ptr->qib, 0, sizeof(irq_ptr->qib));
 	memset(&irq_ptr->siga_flag, 0, sizeof(irq_ptr->siga_flag));
@@ -493,16 +492,14 @@ int qdio_setup_irq(struct qdio_initializ
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_EQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO EQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->equeue = *ciw;
 
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_AQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO AQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->aqueue = *ciw;
 
@@ -510,9 +507,6 @@ int qdio_setup_irq(struct qdio_initializ
 	irq_ptr->orig_handler = init_data->cdev->handler;
 	init_data->cdev->handler = qdio_int_handler;
 	return 0;
-out_err:
-	qdio_release_memory(irq_ptr);
-	return rc;
 }
 
 void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
