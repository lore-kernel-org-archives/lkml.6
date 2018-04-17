Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+NXRMDmlH1rl4Lv2CRDx6+GGru8abF/a3iz62wdYweHD7qo+466v9G/KtKSkkugsLz396K
ARC-Seal: i=1; a=rsa-sha256; t=1523981261; cv=none;
        d=google.com; s=arc-20160816;
        b=QLjACivLHhqgYkMmVEeqsQNrp1Q/RZZlZ9A9xNQ/+AJxHTe7hQy5JxvzNzzw+ZbxBK
         93JDc1+WGlRZb4D/YRHFITNdW1HOQDo7noXRMW3dA+uI1hazFu7ZOTfykS9hwNgFS6aE
         z5PSt7y9TzkZNuqj3SuZdCLPX3NwJVyZ7C0+wurMA0I3QxkM3zSEvOYO1wzzHhPCTxyE
         8/zEDrFsAxBc3bcDQpnAwcZ3CbeXGenumU8VIt9j6uDnbyj8OilihOO6lV2xETQGsvIG
         hkH9mrQVCla9VyMBNWTwIEKfor0TJvNG4aVvQ0Zh055JR81esmdDyR7uqfUWbUUuExch
         Qqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZAY50QHrAg8hAZvOEay8EWeORQ08BABtraO+qD9m4X4=;
        b=LzmVE2A5Y2S+4EDNDI2cCAPzdOI82JUsT4bbEhn5t3maYwzeI18imnp4eG1Gyg82ai
         xKZNKJml250NP/kJ692Cfw2s4ZsFJG58G7ouZ3bxsQLhdf7uJnUfn0VNrlbmQ/OvRzN5
         i8kHChLKo1XCc50TY0DxpFsBLuy8ZxZkr8pRT6+iD2aJQUJvwGq1vn9RDWwZM1wirHUV
         ks2KB81tx4Ix8heKNTaWAMjbm+hZqFpGMMfu3402r3uapdZxwDWfIITDXfqIr373iIYq
         L0ZHMtDmwrF1l3CiiEUQCEIfQquDW+XxiZeqGxsYC2FXqXBvD9hYZsAdP9tqv1WSQ7Xn
         3+cw==
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
Subject: [PATCH 4.14 28/49] s390/qdio: dont retry EQBS after CCQ 96
Date: Tue, 17 Apr 2018 17:59:07 +0200
Message-Id: <20180417155716.373107602@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009842403765495?=
X-GMAIL-MSGID: =?utf-8?q?1598010174710872203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -126,7 +126,7 @@ static inline int qdio_check_ccq(struct
 static int qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 			int start, int count, int auto_ack)
 {
-	int rc, tmp_count = count, tmp_start = start, nr = q->nr, retried = 0;
+	int rc, tmp_count = count, tmp_start = start, nr = q->nr;
 	unsigned int ccq = 0;
 
 	qperf_inc(q, eqbs);
@@ -149,14 +149,7 @@ again:
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
