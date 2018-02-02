Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225XE6RObBJLzxt4zWrZXjDPAfRKHhYG0uoAUrogmLPLQMRrTqAPqS6cc2VtpxXtFrWcVSKD
ARC-Seal: i=1; a=rsa-sha256; t=1517591331; cv=none;
        d=google.com; s=arc-20160816;
        b=tLrCX3Vhh1ji5GrgQRkAtBry1srGeLquMe12BSr6aDchfcTI24N/oQ6FbE8Bg3pc4J
         x9YQKADrkaI9dahdcMLxrllezDRI3lT8/7Zb6Cbk7gIV91IE+HVHL3g8moxNZGtC6EVd
         qXKtCOke6A37etlP2zINF/WTiGllwRahdJpl+0O1X2JPMkhGx46osaysUI3CcrzAYT6K
         edD+SJR1gj7Y6ChOIJr7Hor/WBK1ru1mBmby2UDl/3gQ8RX++nuuSmh+5X+CQ5Mo2NST
         O8jPwWAhzFY/CpZ4guDikxCc/IUADUU/Lu/XD9CIhgqZxbdZ9rkJSn685Ku29R8wUtTU
         0NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IfEp06c5dlvA0k6QBHNrWqpJB/KuFQP4wvGb5W21SBY=;
        b=wLearFqrm96F9nKo23xphGz1bpt3k2H7d+ZmYdPsmhhKWh0er0loUsWaMOfsOJnb7z
         rtyYBu/jc4U+/WaF0E3MNktw65ykeDGSbJ+mA3XS+rh/wZ6dfm1tv9Zy52LYfE/Mw7DH
         nT2Gj8sHQUazZ4dOSCNWdYRvOPbdecOdyiJM4DMKFoTi9HPDV1+sF2iQW7QHTc+o1Nj3
         PwtPNY+qPjDzx9WBGz64s59n1hxrG3dxN1isXrP6KQkPdk6p8FK/qsWYcVkMYdsahwcw
         eC9/z8OZZsF/4M4z5UVoyhqvKy79ol8XOVdVR92dsbdvavDd3TSuB4SwEayjMS6ewuPB
         I5xw==
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
Subject: [PATCH 4.14 043/156] KVM: x86: ioapic: Clear Remote IRR when entry is switched to edge-triggered
Date: Fri,  2 Feb 2018 17:57:04 +0100
Message-Id: <20180202140842.238756142@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309336556964423?=
X-GMAIL-MSGID: =?utf-8?q?1591309848106555245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Leshenko <nikita.leshchenko@oracle.com>


[ Upstream commit a8bfec2930525808c01f038825d1df3904638631 ]

Some OSes (Linux, Xen) use this behavior to clear the Remote IRR bit for
IOAPICs without an EOI register. They simulate the EOI message manually
by changing the trigger mode to edge and then back to level, with the
entry being masked during this.

QEMU implements this feature in commit ed1263c363c9
("ioapic: clear remote irr bit for edge-triggered interrupts")

As a side effect, this commit removes an incorrect behavior where Remote
IRR was cleared when the redirection table entry was rewritten. This is not
consistent with the manual and also opens an opportunity for a strange
behavior when a redirection table entry is modified from an interrupt
handler that handles the same entry: The modification will clear the
Remote IRR bit even though the interrupt handler is still running.

Signed-off-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Reviewed-by: Steve Rutherford <srutherford@google.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/ioapic.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -304,8 +304,17 @@ static void ioapic_write_indirect(struct
 		} else {
 			e->bits &= ~0xffffffffULL;
 			e->bits |= (u32) val;
-			e->fields.remote_irr = 0;
 		}
+
+		/*
+		 * Some OSes (Linux, Xen) assume that Remote IRR bit will
+		 * be cleared by IOAPIC hardware when the entry is configured
+		 * as edge-triggered. This behavior is used to simulate an
+		 * explicit EOI on IOAPICs that don't have the EOI register.
+		 */
+		if (e->fields.trig_mode == IOAPIC_EDGE_TRIG)
+			e->fields.remote_irr = 0;
+
 		mask_after = e->fields.mask;
 		if (mask_before != mask_after)
 			kvm_fire_mask_notifiers(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index, mask_after);
