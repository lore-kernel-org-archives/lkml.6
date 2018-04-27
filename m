Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZret0yknupqd2tMDmCb/Ew0oEkm9M4+7lV6QYEaPxK59DjWYxpvxjWKnzf57Pa2olgv/yT8
ARC-Seal: i=1; a=rsa-sha256; t=1524837848; cv=none;
        d=google.com; s=arc-20160816;
        b=A6fq245+5tqBbSA+r354EW0Ere2YfJKNLzZZJEJi4vaC/ANHDFKZXVkZYDwEURu36i
         6hhojaIuAInkj4kruJTVw/fT+qIQwptK+oQP/ruvLM1PGjozyYogX5u0RzQZ+TsI+98m
         RUBhfzrEuC+khKlgqSp1f6W69KZunwLdUQxYlX0Yge0NP1ctK1tQv0VksJZP7fSH6jFj
         sTZdEUjqnRRxEeiib5aQL/2UBJQRahjF+N3l6JNLIBU6wz4F33XfzZ4RoJlGbu+p/Ox2
         KuDjrywtarvYlF7OiQpceEPbDNaymQyy5q9yQsn7owPtHMxXbWlgq4h7SI8tKzicc6p7
         zYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4iVmRO6Aq5mi3UYQJ43xmeeLBAdEDpgw1/dtQ45aXBQ=;
        b=UGeomLCYKBiHR0R2Lvstx+yghNxlEFDlwOb11dvar3nE3gW6p4GZ/emwrnkMwKlgnr
         BzhtzCaV5IvVtHeV1z1O6+QqxLLZJu0lL/l1qC7sKMPYsq5WLaol41DhkDlWL1bnBB/I
         q+viCxHXAPfjVgDP03FCpb9loSBeQPWifNa4CDzEVsbNEGTZt7Ctw63lEUzON0vWjMfM
         k71/PrNwi0zJ9yIv+H6fCOYA8H3Uw0RAgMi3v7mwbtLvN4BkrKWrVLOiV76tLwwyx4my
         sCn03yZtS6oAHmTBV8/dp306WOXBL92RTzkN7/SgPbW7uaqZwjjy2adQ6GwAueSXHFBX
         tacw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE9F21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 39/74] s390: do not bypass BPENTER for interrupt system calls
Date: Fri, 27 Apr 2018 15:58:29 +0200
Message-Id: <20180427135711.547413426@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908178667353015?=
X-GMAIL-MSGID: =?utf-8?q?1598908371871061958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit d5feec04fe578c8dbd9e2e1439afc2f0af761ed4 ]

The system call path can be interrupted before the switch back to the
standard branch prediction with BPENTER has been done. The critical
section cleanup code skips forward to .Lsysc_do_svc and bypasses the
BPENTER. In this case the kernel and all subsequent code will run with
the limited branch prediction.

Fixes: eacf67eb9b32 ("s390: run user space and KVM guests with modified branch prediction")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1316,7 +1316,8 @@ cleanup_critical:
 	srag	%r9,%r9,23
 	jz	0f
 	mvc	__TI_last_break(8,%r12),16(%r11)
-0:	# set up saved register r11
+0:	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
+	# set up saved register r11
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r9,STACK_FRAME_OVERHEAD(%r15)
 	stg	%r9,24(%r11)		# r11 pt_regs pointer
