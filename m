Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtDD8FRqBJGn+c1QngpxyGpj+aFVkDaTDLl1H0yiEpupv2VYBreQbEuemoZwqahPyyeLyUU
ARC-Seal: i=1; a=rsa-sha256; t=1519981471; cv=none;
        d=google.com; s=arc-20160816;
        b=swXCjhYumq66hXMhGIMVyHCmqnBiaK4gdDScjDmNXP5Qkp9/i28Uw0Z7A6WdWweW8B
         Pz4OMP19WQoc7zMa5HdUs3V7LcbS6S/9k4tho2KWbxZsRPyS1O+VeFKcZ0vsqHBm5HKJ
         UUCT+Pu4V00M9abmBe5jZKY/d79RiaZ0wKm55tjzhh0cfpj8fuT86zB/z+udOl3osVWg
         FSce5X9qalIukw4lbyPYWjH8AK6KxaT2usr34Laqwte4pidtplCajGomo3LuzwCRyI8o
         m2dlD42K1rrTU0Y9alJDKhOdk9xp0AxUCjvAYfswQtZ2lJ1Vsnqk+xonic5ytDevnOFv
         cd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OBwomgwkcYV7HvqABYsvrVM9Qhc2SvfEf7lOwU51Zvg=;
        b=eEgIbopai8C79k3KZHY3z/mQFHgmW8TCknbKpOePTsehlQNTmqT3P0LdSAYRuRtcL7
         f82ntG6KSPV8wugJM2lz3IxZeLTTC2dA6Ek5W38uRB0ZY9wt6B8wMprpIuZjWqTeVqS5
         F5cJR87AZyRCQF4AOt0hgwN3dgrD6QvM/1lewk1ku5ivQmDwZ4EG620lhCCfE3s6NuQ2
         RJAX2BODFM9oy5iFL2uuRwTXAoa3geS7wIDmP/aQrSVc5Y6Fj5O0US4TsqaWFKGHRCAn
         tloO15TAL8zZMccCTs0B7e6idSBv77Fpb+3hjaYOZqld3Rcop8dQrYgr/hYitMRjuoRp
         0ELQ==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 066/115] s390/dasd: fix wrongly assigned configuration data
Date: Fri,  2 Mar 2018 09:51:09 +0100
Message-Id: <20180302084506.539112740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815289222410240?=
X-GMAIL-MSGID: =?utf-8?q?1593816091174578398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_3990_erp.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2803,6 +2803,16 @@ dasd_3990_erp_action(struct dasd_ccw_req
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
