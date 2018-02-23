Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227/5TYbycWh361KrC7Gmm9Ixa/4PlFeqkaGFpQquvu0NAuTlCkH0DszDlTnItNar7cutk7r
ARC-Seal: i=1; a=rsa-sha256; t=1519411083; cv=none;
        d=google.com; s=arc-20160816;
        b=lll9htetGZsD9wK5FaSktjQtw2LAJ9acL+s5HuNvNMhEqJauP54hj6Fs5PVqKD2Snv
         VwNF+c+UkhfvLe8cmAnCsAY8RHNLixFQpTmUDqCnigrOOP34GyPSfo2yTBKsLTZlQ+MR
         MhcLSt0eWcZNRpF09ciIXsBg22gx5wPSPAI8cHi9HZ0mI/0tt9fN4toUP/Q17/Iz8CWo
         FSio4ezc2w42XRg5gR3DA+lgzk8lIZppz2ZHo8nWRwDA+0o7M+N0TxwJzZz7wR2P1dk9
         i1q7SV8D7Tnkwg7376mi2Vr1sirNqevE2oTx2T9XXGsOPZrzwSPP7xPbgBhl/+FjQzQs
         cpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AZavuPWPLj2gLqu+2a1aKJ/ffiJcVGBKxAiTdpfI1Cg=;
        b=PMzG3S7xrhf2L/rH4TCM2a8rZed44CPY1bfkLMswDYKYt5VO/84C2INsRysvT0goK6
         0If97Z2EssGukO76IAUolelL6p4Zcmz/0eAh6p9P9MjqBdA7J7AaC4ReAH2Ku4H2w2c7
         ScM3/B00KSb8MU9/b8B7D1cCHxuJp9/Sy13RuVr/b8AmVnGEASD51/SXWt96VOl0bYVD
         wK7hUMp4wgz8fqCCnm0FDD4J7xmcGeixJHo1Rg4rcGIlFtAV8PoOwt2qZLzZgUC4EB9G
         EqofiARjpl3TCRy2h/s41JqKkf8mmdFa8OaedM8nUnWKG6p3UMVOz5yKYIDBxKi/eCbw
         5Pvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 077/193] scsi: advansys: fix uninitialized data access
Date: Fri, 23 Feb 2018 19:25:10 +0100
Message-Id: <20180223170338.094710484@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217996534204075?=
X-GMAIL-MSGID: =?utf-8?q?1593217996534204075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 44a5b977128c0ffff0654392b40f4c2ce72a619b upstream.

gcc-7.0.1 now warns about a previously unnoticed access of uninitialized
struct members:

drivers/scsi/advansys.c: In function 'AscMsgOutSDTR':
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+5)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
         ((ushort)s_buffer[i + 1] << 8) | s_buffer[i]);
                          ^
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+7)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+5)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+7)' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The code has existed in this exact form at least since v2.6.12, and the
warning seems correct. This uses named initializers to ensure we
initialize all members of the structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/advansys.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -6291,18 +6291,17 @@ static uchar AscGetSynPeriodIndex(ASC_DV
 static uchar
 AscMsgOutSDTR(ASC_DVC_VAR *asc_dvc, uchar sdtr_period, uchar sdtr_offset)
 {
-	EXT_MSG sdtr_buf;
-	uchar sdtr_period_index;
-	PortAddr iop_base;
-
-	iop_base = asc_dvc->iop_base;
-	sdtr_buf.msg_type = EXTENDED_MESSAGE;
-	sdtr_buf.msg_len = MS_SDTR_LEN;
-	sdtr_buf.msg_req = EXTENDED_SDTR;
-	sdtr_buf.xfer_period = sdtr_period;
+	PortAddr iop_base = asc_dvc->iop_base;
+	uchar sdtr_period_index = AscGetSynPeriodIndex(asc_dvc, sdtr_period);
+	EXT_MSG sdtr_buf = {
+		.msg_type = EXTENDED_MESSAGE,
+		.msg_len = MS_SDTR_LEN,
+		.msg_req = EXTENDED_SDTR,
+		.xfer_period = sdtr_period,
+		.req_ack_offset = sdtr_offset,
+	};
 	sdtr_offset &= ASC_SYN_MAX_OFFSET;
-	sdtr_buf.req_ack_offset = sdtr_offset;
-	sdtr_period_index = AscGetSynPeriodIndex(asc_dvc, sdtr_period);
+
 	if (sdtr_period_index <= asc_dvc->max_sdtr_index) {
 		AscMemWordCopyPtrToLram(iop_base, ASCV_MSGOUT_BEG,
 					(uchar *)&sdtr_buf,
