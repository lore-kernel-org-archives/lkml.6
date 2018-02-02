Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225dnK/GYkqqDYle5ckX07w1P20ZYOK1L//+3n8ba6i7+NgSwnQff36dTaLGrJHvdoSvG1sA
ARC-Seal: i=1; a=rsa-sha256; t=1517591023; cv=none;
        d=google.com; s=arc-20160816;
        b=ytyE8GY9HAWN7KwB2NEoNbSLtEVLBS9//bpC3Yv4updWZLFskdNn5svxViQzDkBfAE
         p3pOuiF/dAoR+1icZ5/DGPs75ABqyjmJheN64oG93srhPIv7Eqgz3c2W7VrEmLJWYonG
         a4ujdllFofqvjPr6+iBdbjSWe6HxbMqxPO0xpGzhtm0oNhPJ3GjJ5CjURWJ3sARCjp4Z
         Mo296pR/kgV/fnELGWStKSPc4vX7YmmvTDUOqgR8Cmsda6lHt70hLLAqMnyFTGmiSdCY
         qBaJIJ3SPTN0u41mrR0dNc7JPhHwu3qm/2A02VKn975d05d5eRnx25U3EwIgDlQXgH1i
         jUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tNus1TT0t1OLiuIQp2OTXJnX9XHj1S9DocATfEgqIBw=;
        b=YrMCnv1rqgCOpH2jM21ZdyLkkvk8qzqcIjXFm43toJeEuSe2IIq3cftpbQDMBYU12W
         UuNjRXAxUic4Irh7FcYsAs1kZvYI6QXU4KzxIfVdMu8nhxnoZLiQ99NWti0tAx5cFVcd
         zO5BVIE632eBF3hQH9kxckWP0piYPobrjwgqbVaty6aFHalF/xi94TNASSfXt0rK3caQ
         FApO/a1Jwn26blLBeWpbpZH43NBaiRGpPKB9RAhZTs1mucakap2PJUh/54lXKaTiMgxQ
         tRPA4CQdqlNzPEFVn61x/azN983/FzE+xe8biU6CBsbP9QvlPrkjSRDwT+MWKkEERky9
         pDiw==
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
Subject: [PATCH 4.9 26/86] KVM: x86: ioapic: Preserve read-only values in the redirection table
Date: Fri,  2 Feb 2018 17:57:46 +0100
Message-Id: <20180202140825.029699721@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309369903259525?=
X-GMAIL-MSGID: =?utf-8?q?1591309524855263685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -278,6 +278,7 @@ static void ioapic_write_indirect(struct
 {
 	unsigned index;
 	bool mask_before, mask_after;
+	int old_remote_irr, old_delivery_status;
 	union kvm_ioapic_redirect_entry *e;
 
 	switch (ioapic->ioregsel) {
@@ -300,6 +301,9 @@ static void ioapic_write_indirect(struct
 			return;
 		e = &ioapic->redirtbl[index];
 		mask_before = e->fields.mask;
+		/* Preserve read-only fields */
+		old_remote_irr = e->fields.remote_irr;
+		old_delivery_status = e->fields.delivery_status;
 		if (ioapic->ioregsel & 1) {
 			e->bits &= 0xffffffff;
 			e->bits |= (u64) val << 32;
@@ -307,6 +311,8 @@ static void ioapic_write_indirect(struct
 			e->bits &= ~0xffffffffULL;
 			e->bits |= (u32) val;
 		}
+		e->fields.remote_irr = old_remote_irr;
+		e->fields.delivery_status = old_delivery_status;
 
 		/*
 		 * Some OSes (Linux, Xen) assume that Remote IRR bit will
