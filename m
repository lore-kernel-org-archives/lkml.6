Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226vW7LDclmVnZj9wDsiiqjNZGZO/8uZFMKmjF5bLVaG76vEoCo8WN9cd6xLc3bcdUIoy5ee
ARC-Seal: i=1; a=rsa-sha256; t=1517591016; cv=none;
        d=google.com; s=arc-20160816;
        b=LocwuPQEMpn/VKrpVLpGzUZPJIuLeBdNOH6Ad99HodEahW13KKIPedDwtrUMMD4NG0
         FxxeDGlMVYTyi74klgSVB36PyF9xlE6yHc1x7D0QQvi4IImcjq63kSCyWCbniKE1Rju6
         6ddmvSb1wAzfTbrgR/2zgK0EX84xolf0SDRXWppu+DlWd7/qqZFEej1Xu7rrsS1xfHJ0
         e3rCdqbBEjCiPhPonP6EukH01YeBix952uUiS3mLFWx/fVuHTSZ4/f+bYUzTza3m5x6I
         9p0UV+JGzZCPu1yqGGsBkx/WLJJ6Do7iY0LrG6Z4tjzhDh7wxYADDFiXFB3SrKysvR0B
         wmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SaV4MwspdCyfJC4ZmRmrFLqttVD9RBOgTkrf5y7fXZQ=;
        b=aajzBwzyhQFCC8nKWVUAG+oBgqyP6BNavHZYS6ECJvDE7ePoKq6gOv1Q4RkZI1SLyQ
         C6nBdLW2hl2nc9VpfICYvD44511ajPmjbclO5bIAv2szUAqof6zmnTFfjYAT/wNwjoyD
         bGchyc6LI237N9OzFJbuRlszkySdVC89BY+SDigaJ9WOXcH2u1O4fNqSRa6bDT4uGKsG
         /nccAK9sbNrWINWx3w+vDZiGFczybUxY209ic+rxg0CRiS/snbS14rTIKRiqZMmo7gaD
         +FdlDTXlDX5BCPTHXBQjTTzmxiIrGTFk6j5c8X2mSomE2vDO0s02N1Rac3k/oV0XQXyx
         GH9g==
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
Subject: [PATCH 4.9 24/86] KVM: x86: ioapic: Clear Remote IRR when entry is switched to edge-triggered
Date: Fri,  2 Feb 2018 17:57:44 +0100
Message-Id: <20180202140824.868776845@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309336556964423?=
X-GMAIL-MSGID: =?utf-8?q?1591309517770779562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/ioapic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index a7ac8688bba8..4b573c8694ac 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -306,8 +306,17 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
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
-- 
2.16.1
