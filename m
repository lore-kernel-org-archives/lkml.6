Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+QIm21EUA69KVD5XkTu9K22MFZ9xZr9fPeWnIXLXZSr3lKpWScKffo3ufoUi79TnyZV0LL
ARC-Seal: i=1; a=rsa-sha256; t=1524406535; cv=none;
        d=google.com; s=arc-20160816;
        b=tYczOL0aFotrgCJaMcIJ6xLLrFzQrz5YVJ9kczdBFisemWVhGNA8RD/oYJ4yM0XVMB
         F8TY/+EgXTUDvLEyI37Iak3N4tEK0D06s32KRnCZeu0wcU6yT8OX0lXsFG6GYKJsw+9d
         gJpEM+VuEGNRMFqhLwIA4oNxZdKd8qN7IPFiSo3dFZ6ZoKqz7h0opQjblJJyuteIYPo1
         e1+BG98NbTWfs6TtSrBvhzkFv7LBsViL9220maINL127Bz0fvBwEFSUgJ74DQOAeqsXq
         Gic8AuG/FE62iZVQhZa2DUY4ePOG9JRs9mL3OjnCtmQHUrHUkTEan4c2uFoFGizF/zRY
         iKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=82xGzfn7v6JV/s6e01pAKf2unT68oiwz4vhl2IwSEco=;
        b=MMHIgqztzjusPQysJMkfYWEUZlmZHpF6vIpBz57RFORXLp5Q+6TaH0fcIKgiGpb2R4
         9NFg6IpVuqyage/E43OsP6kxNVTToAKwUhggTLqv+goEOsXGLKKxAkwfNaF3NEGRulXL
         UHy7yHAGOnywLRiDQoUgUAkZ5FXJLkhRkMOszWBOprhy39xORaBl5wDy86OF6UwOQOnw
         6tizXjSS+zZ02Ri9F1g2qAX3BfzLrtTWLsHhXTU+zTxVzldQZMVBLWMwIDp14ngsdPs9
         6kRNnuDvTCThVEB4vGzy+FWYG/trcg4WuZKMMy1AONWeUfcafqT5JvnHDVHoLFZhtIXU
         wyDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 12/97] s390/ipl: ensure loadparm valid flag is set
Date: Sun, 22 Apr 2018 15:52:50 +0200
Message-Id: <20180422135305.323664854@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456107565635431?=
X-GMAIL-MSGID: =?utf-8?q?1598456107565635431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit 15deb080a6087b73089139569558965750e69d67 upstream.

When loadparm is set in reipl parm block, the kernel should also set
DIAG308_FLAGS_LP_VALID flag.

This fixes loadparm ignoring during z/VM fcp -> ccw reipl and kvm direct
boot -> ccw reipl.

Cc: <stable@vger.kernel.org>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/ipl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -798,6 +798,7 @@ static ssize_t reipl_generic_loadparm_st
 	/* copy and convert to ebcdic */
 	memcpy(ipb->hdr.loadparm, buf, lp_len);
 	ASCEBC(ipb->hdr.loadparm, LOADPARM_LEN);
+	ipb->hdr.flags |= DIAG308_FLAGS_LP_VALID;
 	return len;
 }
 
