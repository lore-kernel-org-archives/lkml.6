Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2258ecWBGgBXKqTrJJn4cDJ00YQZkeJJ6sGi0LWvBjvVPJvaHkrKJFSgfOa/wxmM7Nc3hTBP
ARC-Seal: i=1; a=rsa-sha256; t=1517591334; cv=none;
        d=google.com; s=arc-20160816;
        b=YRjqf7QzZyB57RBw5M9KVLWClfM0rRzB3A8n2oJRJb7u9EmI9RsNuSlTj6tDGyBJix
         o30xNZVpXcUJlse9+EwFNvct4z1TVCJj9MMA1mEb22t9RlluY26EKmP1qVAJbse5BLbU
         pJIz7Q6/gD5EkItx48/U8pzhhLK/6S767+lQTn+/9Xx15nJU8TibcKuF8eLPy7LdV56E
         QC/M3D42BqODq6c1YTA7GuVoR/+iS622SQOdI+Kz4tdgRHthmfkcbZwqgFVPK73bs0Dn
         H8f7zBvchmR4I33sJUE7eDH+YbMPjivcSzYLfBmnynzNU/UJ+eN4VMRmzpVIySZkfZzr
         Vx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lILhHFYr/h62c+pWLogrL2diBgG5HL4XsBuyhHTpP+w=;
        b=MHBqBNq81jwF26tHgi/K51JdvWk80/ooQwBZ1Mf6geUzhXMqNQGrGsvX47Z7ss4oqK
         4Iy2BYkiA9rU5Rh6IcH6pxQhSU+S06fpvufjpIDMWdSGlOb9yJv1YdO7kbMLWXC4C4r0
         KJQng0takxAbB0abgK+ptqVbc5Mq1FmGie2YAYER70n975mgc9oeMkdBUxNF8murh1Sy
         GdUMLDOPBR37kkTvSjh4cxR1tt1jLvEJ0z5fQJuHwRcZQ8/2AaM/R5KYm17gQkYMk/Zu
         5pgXjbQSN96W1v3+6ruBsVB3fvf9pw22Wylb3xkQQOUlOHMZkmXpli/QIsLLxnqfi8xd
         Ltwg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 044/156] KVM: x86: ioapic: Preserve read-only values in the redirection table
Date: Fri,  2 Feb 2018 17:57:05 +0100
Message-Id: <20180202140842.277144028@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309369903259525?=
X-GMAIL-MSGID: =?utf-8?q?1591309851057360037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/ioapic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -276,6 +276,7 @@ static void ioapic_write_indirect(struct
 {
 	unsigned index;
 	bool mask_before, mask_after;
+	int old_remote_irr, old_delivery_status;
 	union kvm_ioapic_redirect_entry *e;
 
 	switch (ioapic->ioregsel) {
@@ -298,6 +299,9 @@ static void ioapic_write_indirect(struct
 			return;
 		e = &ioapic->redirtbl[index];
 		mask_before = e->fields.mask;
+		/* Preserve read-only fields */
+		old_remote_irr = e->fields.remote_irr;
+		old_delivery_status = e->fields.delivery_status;
 		if (ioapic->ioregsel & 1) {
 			e->bits &= 0xffffffff;
 			e->bits |= (u64) val << 32;
@@ -305,6 +309,8 @@ static void ioapic_write_indirect(struct
 			e->bits &= ~0xffffffffULL;
 			e->bits |= (u32) val;
 		}
+		e->fields.remote_irr = old_remote_irr;
+		e->fields.delivery_status = old_delivery_status;
 
 		/*
 		 * Some OSes (Linux, Xen) assume that Remote IRR bit will
