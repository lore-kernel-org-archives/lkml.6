Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226VXWuaUN6HhPXpXQihUsSeioZKo8pIOC3/2qjC09n/JnPd9Oi4ujLRgFwL/RZGVZfDlZZD
ARC-Seal: i=1; a=rsa-sha256; t=1517590875; cv=none;
        d=google.com; s=arc-20160816;
        b=OZ5TgrlGerSii03g3cTMT9RL037bsnhWOYMdpw7kJ+Y6rbT3PI3W8BrpMkgaLP8QKr
         i2c4LnntnwQhB4difOoFilyUyx6GBqiWirRKckakAizJwPNQzuhzTTvhvffNeoC23wSR
         TVGnS0Xdzv9Up/aqmz0ePRHph7EK5eOMCMMOZXt3aAFED4Ap/nGLue+aVcK2kzyiOUpZ
         VZ9ywM8PfU1A2J/+mtBcU5/6wRFAS/HQAOJJWGgF+7DQziM9BqFJVWhsFRyETqRgycPE
         n6ZATVcQ8J2KG0pEBYGlP1ZlbOf7HRwS7L34bV/w7rJeyNHP0pBN+Av0pBCL6hcMOnbE
         0a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/HtVtY/ucxHMFrfN5+8yi8nFBgiQmCPriXQISLfgYLk=;
        b=OiAC1ht8az1CJ8xyXcSJzAT+cFcMeFhn2nN8XNgcCe3w+zDtaLQlMDa4DkjmwwFvbS
         CBE8hZ2ClGyjvY9t7gdunmGPdOvCr5Ot7VNNjTAkW5DHeKvTVtEGy8jX+cea5zXs9Gc7
         KHOhT6qStauhSPKIHcWLW9lCLTggNudoa8OJNoWkX0WqV86amII7OeqAoz6l8Vpy0Aht
         NDZqtkJdHvGSed1ltkklN/sR1+bZdGp7Ip/596g1qsnWj0QSaZ8OF2OwlSrX1rI4uh+M
         QgnArXxwdQraDOKmdroEYUqzAMteEsJpN1X7lFIK//1KT1AiiDFmnBXfndKUBRSoakO3
         DXvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikita Leshenko <nikita.leshchenko@oracle.com>,
	Liran Alon <liran.alon@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Steve Rutherford <srutherford@google.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 26/67] KVM: x86: ioapic: Preserve read-only values in the redirection table
Date: Fri,  2 Feb 2018 17:57:55 +0100
Message-Id: <20180202140818.348657591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309369903259525?=
X-GMAIL-MSGID: =?utf-8?q?1591309369903259525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Leshenko <nikita.leshchenko@oracle.com>


[ Upstream commit b200dded0a6974a3b69599832b2203483920ab25 ]

According to 82093AA (IOAPIC) manual, Remote IRR and Delivery Status are
read-only. QEMU implements the bits as RO in commit 479c2a1cb7fb
("ioapic: keep RO bits for IOAPIC entry").

Signed-off-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Reviewed-by: Steve Rutherford <srutherford@google.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/ioapic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -268,6 +268,7 @@ static void ioapic_write_indirect(struct
 {
 	unsigned index;
 	bool mask_before, mask_after;
+	int old_remote_irr, old_delivery_status;
 	union kvm_ioapic_redirect_entry *e;
 
 	switch (ioapic->ioregsel) {
@@ -290,6 +291,9 @@ static void ioapic_write_indirect(struct
 			return;
 		e = &ioapic->redirtbl[index];
 		mask_before = e->fields.mask;
+		/* Preserve read-only fields */
+		old_remote_irr = e->fields.remote_irr;
+		old_delivery_status = e->fields.delivery_status;
 		if (ioapic->ioregsel & 1) {
 			e->bits &= 0xffffffff;
 			e->bits |= (u64) val << 32;
@@ -297,6 +301,8 @@ static void ioapic_write_indirect(struct
 			e->bits &= ~0xffffffffULL;
 			e->bits |= (u32) val;
 		}
+		e->fields.remote_irr = old_remote_irr;
+		e->fields.delivery_status = old_delivery_status;
 
 		/*
 		 * Some OSes (Linux, Xen) assume that Remote IRR bit will
