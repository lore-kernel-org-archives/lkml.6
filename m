Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8oJuz5XD1TBreY2nCRHeAmmW5luWx1FerMusxLTgDbX6SnrymT6lQrrPaPmV7RwCrW6Kc
ARC-Seal: i=1; a=rsa-sha256; t=1523981149; cv=none;
        d=google.com; s=arc-20160816;
        b=UZl/bfElGRLduh2FB7IieukzVq9q1BYpV6F0sHMcq4w1hrV8fvOz7EbHaPKhTeeD12
         +R0qtFZcWsYdQ7GZwrslG+Ny3m0pGcV1M/f6V78dCUFjeoVVpR+bD7PXHrn62pmzFeoh
         i0Y9ygU7ZtxxST9pBMucQmCBJU04QaymsgHBWgd44CoMf70CsoBU9DdEbkEtBvMj9+dW
         uHAe53lc3ZNcvpiH6T31NCKLjDs7+f3/SGdGJ3GL02CB8/ZKW4hHVNkNpAlydzxDj9ro
         B2hIcbD6pEW45U6t3kkAYysNRgcffbjdeJn9VmqUKStwdgbPpmHBJbQK29nwwRASF1+G
         +ZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GuPoM0Ex7VJOMHXlZvhTVOFU9VMwUjnynsKL5DI8VM0=;
        b=DcsxXIxvpOvA+UF7npX2E2fEsdhM6Wd22haZ4atE/ni84q/xzlzVsBbUPd5adxepGE
         3qCVajs7dzDi9Z6gsOc9NQCdsEIErid4j7DZbJGv+AfAPrTWQBP38yiwP7fG6whU9qKD
         bBLyRKdZpVl/bNucqM0Q03+Bep+xvjq1QRdcHtFrILDjjq/XnZhXiUG0BCnK3gYU04eJ
         UZM3X1ecq1eMd+h9shrasRl+CqB/emcVec8H5CYPI4dxuIeqeeMjjkVb/PqKEFQ7zKHY
         2EEAUePfDTcuVBWma9I6nA1I0nydjNcRESYmHzIt5i6s2B6KwUbZLtD29q04PqZ0XrV4
         SJAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.14 11/49] parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
Date: Tue, 17 Apr 2018 17:58:50 +0200
Message-Id: <20180417155715.545576763@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009710354383751?=
X-GMAIL-MSGID: =?utf-8?q?1598010057939963210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit d5654e156bc4d68a87bbaa6d7e020baceddf6e68 upstream.

Make sure that the HPMC (High Priority Machine Check) handler is 16-byte
aligned and that it's length in the IVT is a multiple of 16 bytes.
Otherwise PDC may decide not to call the HPMC crash handler.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/hpmc.S |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -84,6 +84,7 @@ END(hpmc_pim_data)
 	.text
 
 	.import intr_save, code
+	.align 16
 ENTRY_CFI(os_hpmc)
 .os_hpmc:
 
@@ -300,12 +301,15 @@ os_hpmc_6:
 
 	b .
 	nop
+	.align 16	/* make function length multiple of 16 bytes */
 ENDPROC_CFI(os_hpmc)
 .os_hpmc_end:
 
 
 	__INITRODATA
+.globl os_hpmc_size
 	.align 4
-	.export os_hpmc_size
+	.type   os_hpmc_size, @object
+	.size   os_hpmc_size, 4
 os_hpmc_size:
 	.word .os_hpmc_end-.os_hpmc
