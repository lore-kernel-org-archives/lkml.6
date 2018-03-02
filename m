Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtGYZK54uVojbJRpPEKXQz/p5fOHHTeI9vDQ5KttoN+mRijdKN+bywzOpGISCw/1LFgrCBt
ARC-Seal: i=1; a=rsa-sha256; t=1519981044; cv=none;
        d=google.com; s=arc-20160816;
        b=qldwYFs63DC4jQxDlQEp2GrILUENG3zVwsESyjzWFYsmHUtKCWkzNTQimAXFZiip+5
         GnXTnmDS3lrihLZlKqerlkps7uZqD7pCBjWXqMbHGcLs3FNRp3Pzj5dUlWVufn+BixDk
         hmk5H/Y/GF/gcIJHIONsFoD3MYDtDXWn1BybarjvpHr9+mSuecAdPWJIowp+bzcORtJn
         TuTV+CpBJqQQm5aI49jUeJYyudsf7kaC5yVOwcP/mSS0NMjXwXSMP4fvShCxXqJhe3Dt
         ocCvfaNV0Yf/9dFu5LEoWHeitAve0tzsm+FaG8RKdXeJnq27U0gz3fIIHKYRsLVBL5oS
         8daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cExll6wvzoZKchDZcDo8tHcAEMEMXfLgvJRsYwCsY3w=;
        b=f1sX4mtxQjGwUff65xE8P7Lh/S1j+wGUOo8GOrvvvScoT2ZiGLncade6CHHaqY6zZn
         8MMhqfgZ4QiZLGHZJQLjBDdG3oywfA7AE1Q8gmaJxWVjGJPylw+Ig/NocGtQgkJ31Bdu
         qM78T0RjUgvfi0QVbyPiUzvU81LZOqguR8jvXUyyfhaK3/V+RN9akp0n5bwrwRGpktav
         XtA40BbSsg8g7WpWXkH4t8s3gVofKuQIoQh3Tf+yhxk2oW4PXaMRA2j9hTnRiWJnhEtH
         xmJR90SYpGc5UJAytomkM0YoTQbF1VPV54XUQ+1+YAGdozxWqFm7IFH0cO8asaBHyDJM
         qDgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 33/56] s390/dasd: fix wrongly assigned configuration data
Date: Fri,  2 Mar 2018 09:51:19 +0100
Message-Id: <20180302084451.254047135@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815289222410240?=
X-GMAIL-MSGID: =?utf-8?q?1593815643301591570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.vnet.ibm.com>


[ Upstream commit 8a9bd4f8ebc6800bfc0596e28631ff6809a2f615 ]

We store per path and per device configuration data to identify the
path or device correctly. The per path configuration data might get
mixed up if the original request gets into error recovery and is
started with a random path mask.

This would lead to a wrong identification of a path in case of a CUIR
event for example.

Fix by copying the path mask from the original request to the error
recovery request in case it is a path verification request.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_3990_erp.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2755,6 +2755,16 @@ dasd_3990_erp_action(struct dasd_ccw_req
 		erp = dasd_3990_erp_handle_match_erp(cqr, erp);
 	}
 
+
+	/*
+	 * For path verification work we need to stick with the path that was
+	 * originally chosen so that the per path configuration data is
+	 * assigned correctly.
+	 */
+	if (test_bit(DASD_CQR_VERIFY_PATH, &erp->flags) && cqr->lpm) {
+		erp->lpm = cqr->lpm;
+	}
+
 	if (device->features & DASD_FEATURE_ERPLOG) {
 		/* print current erp_chain */
 		dev_err(&device->cdev->dev,
