Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49v4T27cNPW6dkOxyMFu187cp6umPlJLcCkGGVP/nlbJo8UVs1GIsXlAJHCZ81G5WBYr66G
ARC-Seal: i=1; a=rsa-sha256; t=1523981121; cv=none;
        d=google.com; s=arc-20160816;
        b=XxBKAJypKn7BJPmR2FfJUQt20pqlTv2ujxwRFpDmj3VLXQUA1LAlE/PlG0UkJNbTtE
         0yUWn4fBpiIw1+QGawFELAAq9Tr8/aANOwai1flvcEqhlAC1j9ZwOlaqYIBXyKCFQICW
         40ZFPRIH12HzwodLAVnG+e9Qy6gX6diB6+Ar8uBWDmNtMQu39cm8520zN36Rk4UE1Z7R
         VF3WreJuT3uqnimNrdwSclJfIMwQS53qgBj7E6yd45VBfQVj3a8pCbNX8xpWtNkrmZKE
         58KcXj6rzYqQwm/KzZEJ2AQeYF8lIGCsAYuhfP/pcmgh6zmlh30eLyKbD2LzebslFhWR
         Dsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nA4XzvHyhxecp1JMANYyGzRSMDLWE56zVndLpaKc8og=;
        b=xJuMGUFrJ84GBrrsFOh5aI4OFZfPw1+3ziAERGeNvYHEyGRNmhTRMSJ2IEFThs2aEy
         3XlrQF8NslhN2x+KgC3B3RgNZhOMd9w+wm5bMOjTtjnI662BJ5lyvhsDniNtaVmVpU9C
         AktPP24oog1R6EznJildbZFwlr+bxa12hwK6UG9P6LqXPy61hq7qpjCmga0MAWOU5DNA
         r83/3pKO/eseQlleGisR5sQRBOJm5/SXYt9bkf4+B1YXm4XAOF085WiOzuF9bRrtzNjj
         D9y15RwoGR2TI62fSISqgNI3e2PkCLe72s5d/de/lOd7663o0XUidR59kHmP5ZnC9UzA
         A6lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	Benjamin Block <bblock@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.15 43/53] s390/qdio: dont retry EQBS after CCQ 96
Date: Tue, 17 Apr 2018 17:59:08 +0200
Message-Id: <20180417155725.195969915@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009842403765495?=
X-GMAIL-MSGID: =?utf-8?q?1598010028918834924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

commit dae55b6fef58530c13df074bcc182c096609339e upstream.

Immediate retry of EQBS after CCQ 96 means that we potentially misreport
the state of buffers inspected during the first EQBS call.

This occurs when
1. the first EQBS finds all inspected buffers still in the initial state
   set by the driver (ie INPUT EMPTY or OUTPUT PRIMED),
2. the EQBS terminates early with CCQ 96, and
3. by the time that the second EQBS comes around, the state of those
   previously inspected buffers has changed.

If the state reported by the second EQBS is 'driver-owned', all we know
is that the previous buffers are driver-owned now as well. But we can't
tell if they all have the same state. So for instance
- the second EQBS reports OUTPUT EMPTY, but any number of the previous
  buffers could be OUTPUT ERROR by now,
- the second EQBS reports OUTPUT ERROR, but any number of the previous
  buffers could be OUTPUT EMPTY by now.

Effectively, this can result in both over- and underreporting of errors.

If the state reported by the second EQBS is 'HW-owned', that doesn't
guarantee that the previous buffers have not been switched to
driver-owned in the mean time. So for instance
- the second EQBS reports INPUT EMPTY, but any number of the previous
  buffers could be INPUT PRIMED (or INPUT ERROR) by now.

This would result in failure to process pending work on the queue. If
it's the final check before yielding initiative, this can cause
a (temporary) queue stall due to IRQ avoidance.

Fixes: 25f269f17316 ("[S390] qdio: EQBS retry after CCQ 96")
Cc: <stable@vger.kernel.org> #v3.2+
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_main.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -127,7 +127,7 @@ static inline int qdio_check_ccq(struct
 static int qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 			int start, int count, int auto_ack)
 {
-	int rc, tmp_count = count, tmp_start = start, nr = q->nr, retried = 0;
+	int rc, tmp_count = count, tmp_start = start, nr = q->nr;
 	unsigned int ccq = 0;
 
 	qperf_inc(q, eqbs);
@@ -150,14 +150,7 @@ again:
 		qperf_inc(q, eqbs_partial);
 		DBF_DEV_EVENT(DBF_WARN, q->irq_ptr, "EQBS part:%02x",
 			tmp_count);
-		/*
-		 * Retry once, if that fails bail out and process the
-		 * extracted buffers before trying again.
-		 */
-		if (!retried++)
-			goto again;
-		else
-			return count - tmp_count;
+		return count - tmp_count;
 	}
 
 	DBF_ERROR("%4x EQBS ERROR", SCH_NO(q));
