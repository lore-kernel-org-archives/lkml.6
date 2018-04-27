Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrxV3FISY8vtEsJ2Rm7ZJzfEjnt0cRiJtwj1s56AWxm8gQgJ6gQyxtQsOTzif8jk9H3uiJL
ARC-Seal: i=1; a=rsa-sha256; t=1524838365; cv=none;
        d=google.com; s=arc-20160816;
        b=VkUHBgPg2QfX7omd1o3UaP5vPPhvUGMRtYpMyvk9Qg7HA7+TKpdrhfp39m4mRtJtIN
         XhmUunxjDu134NC1LmuKT82tU0HTJ4nrt1b6yf4kvEkG6E8q3dN+lY8FVe+wL9h5Dqf3
         EcCMdDRi9bOWJyk2hLjByL3DtL+KCLPfVxvoSYxA94G0ePEYPybxpS5xn1JrQH7ugMQ4
         SXFmbKb7lMSB++eo1yQhdwhpAsgrCLMdrQr+SS9KqGPAfyCWGzk1s+w7jtyNKeDvgZFJ
         bgiKYNQ+yjw/b1IgWfbcyLYew5YMzqHo9c2eumu6qaTDTWKYQpmvWqd/FpXQ5wRtbCwu
         DKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kLd3886W12Cvg6HU2d7msQpv+cBYGI0xQWO4VMl7Isc=;
        b=rlq4aPYHFxS/1zTBBqoxzzyqz4FYsW91Yvjm2607G9uuYXUufdDy8c82TXITOgT7WB
         PV5yLBuRrrBiMoN4SY3f3L+3AyxjFwXZw7+GfBV7pRdBqC5df3YV22v6JkBReiZyncVm
         Yj8xLmJLHdVX0gM5gEElZc4wvlzhoQstbG/dOjoQL0HIT8PHJMNyYFb3WP9FQlwcf3v9
         R9ZGfoqZslpEcz5/fFOmgi4v8WiAgEFOEik4NwUrBf+tHweAYmJTIdQ2F4mc0KQSvsp1
         efIJfaJDxCT26/wFZlxJUqrPFC1cVB0ZqHYVKDPdfW7Zm3+afGHIpDdmacrT1HIhO4HD
         i7xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D73821897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ziqian SUN <zsun@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 78/81] s390/uprobes: implement arch_uretprobe_is_alive()
Date: Fri, 27 Apr 2018 15:59:20 +0200
Message-Id: <20180427135747.777727904@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908281426362601?=
X-GMAIL-MSGID: =?utf-8?q?1598908913260709633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit 783c3b53b9506db3e05daacfe34e0287eebb09d8 upstream.

Implement s390 specific arch_uretprobe_is_alive() to avoid SIGSEGVs
observed with uretprobes in combination with setjmp/longjmp.

See commit 2dea1d9c38e4 ("powerpc/uprobes: Implement
arch_uretprobe_is_alive()") for more details.

With this implemented all test cases referenced in the above commit
pass.

Reported-by: Ziqian SUN <zsun@redhat.com>
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/uprobes.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/s390/kernel/uprobes.c
+++ b/arch/s390/kernel/uprobes.c
@@ -150,6 +150,15 @@ unsigned long arch_uretprobe_hijack_retu
 	return orig;
 }
 
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+			     struct pt_regs *regs)
+{
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return user_stack_pointer(regs) <= ret->stack;
+	else
+		return user_stack_pointer(regs) < ret->stack;
+}
+
 /* Instruction Emulation */
 
 static void adjust_psw_addr(psw_t *psw, unsigned long len)
