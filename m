Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZriip+0jNHCeBxa+Fi3z3th2EMO1ROlbfMjeH9InyNQfnncU9ySe/Do+v2l/9EGPGBl9SwK
ARC-Seal: i=1; a=rsa-sha256; t=1524837739; cv=none;
        d=google.com; s=arc-20160816;
        b=uw2Kr14c7hbismW1IWY67k0OFxykfgfSfUAbO0S3X78HiBq6vQjRJHZGE6FIONNu8Z
         gkybEQ4SAIVEx4wtDsH9chtedyCX2Skj5AJ0tUzFVNqUFSjPRRsgwS1XTZgidkKVSsej
         PaGILkoo6h0OfCeV5E9sazRDRjq3TXRq6rolp7sKdWPpMR56pmTENatnAZlj2mxRTb+m
         4F+A5ldZDk0w1LNbyDbU13I+OvIFgUEz2VfYGwPcPZRW+jhBTLneHBsRtw5nVvSQtLhf
         UM3nGD30SFvBY9T4HhJS/Xjr/vNnHz+53P8l6EcZaZMOUHzCzNy7GSJUS7E6LzJHHwix
         Mf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=89zKIG0dVRw8+HZAr+ooEd2Z68tnfk1tf0o3ngvaXmc=;
        b=PmSh151cVqUECAxpeyWt3udM0qt2H4eJLqVO2fFiEC8jh6L4UFolZaOXQDOExIcu2r
         PdrNb8mkVgu6EKoBuG9eGay91S+czciUvopy+WGHQonwtx6e2r9ifOyWbN3RWJhq42w3
         Ax59VuEZR1jjFAHTQ6MyYZqkO2uhb/LeJZrrLTWQwEH2L3KypUDtb2LwwApXkD5a96gK
         xLJMzB0Rc9Z2PyQDaMw3DqoRZQg0hT2QK0KPbqZo21FxxB7W5CfiB8ySvd8x/6vZCthk
         cpXf1Jj9rVmM+yE/V7TKq3ZoVw0EJHN3YhEnpx/sJoDk6ufbWG8nHc6sY9VqB1B3/JOz
         u4xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C6621897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 14/50] s390: add optimized array_index_mask_nospec
Date: Fri, 27 Apr 2018 15:58:16 +0200
Message-Id: <20180427135656.542157500@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908257042358835?=
X-GMAIL-MSGID: =?utf-8?q?1598908257042358835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit e2dd833389cc4069a96b57bdd24227b5f52288f5 ]

Add an optimized version of the array_index_mask_nospec function for
s390 based on a compare and a subtract with borrow.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/barrier.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -53,4 +53,28 @@ do {									\
 	___p1;								\
 })
 
+/**
+ * array_index_mask_nospec - generate a mask for array_idx() that is
+ * ~0UL when the bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	unsigned long mask;
+
+	if (__builtin_constant_p(size) && size > 0) {
+		asm("	clgr	%2,%1\n"
+		    "	slbgr	%0,%0\n"
+		    :"=d" (mask) : "d" (size-1), "d" (index) :"cc");
+		return mask;
+	}
+	asm("	clgr	%1,%2\n"
+	    "	slbgr	%0,%0\n"
+	    :"=d" (mask) : "d" (size), "d" (index) :"cc");
+	return ~mask;
+}
+
 #endif /* __ASM_BARRIER_H */
