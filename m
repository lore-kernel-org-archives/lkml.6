Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqyvOtbkM+8Kfh4Zl6cTgkIp8CnS+duvP5P1bluvCni+G9Tx5RMcTyiy9n9I+MS8MdVWeWc
ARC-Seal: i=1; a=rsa-sha256; t=1526937760; cv=none;
        d=google.com; s=arc-20160816;
        b=LvEshBLE1Oisropwe7yyZ3Tv0R7H7+rROgoJE3X00uVmmoDJz1BCAElO9p0Nb61hoC
         rDlU8ExV8gXiYYvLVNCayrtSvjpapH/9vzkGaJmv9bokEHgvmY/Z0hnLZuTPfwDrf2GZ
         y1TZe8XbfpFoWTUePZLllQZT1a7x85U05CiYkFjzWrI2Wo9U2S/sWNPdfywi7nOwlwxc
         7sAZyee297+MrJ8RgZQyOJtOk5Lj/w40+/KSdvBhkmEx+vtj4xcsPFBP7BEBICV5NEbD
         Ux/8HC7tsOkOXat6gkSPgD6m/2jr2QGlSXTs4Z7YJDM8bEZZVXSEm9kVsdxJdmByA1cH
         T70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=VpVIckQujiMgb4ng3kuR40qcGe5SVBRpF7BvSXfPFss=;
        b=XrBxlWvjRpreM2COwxdB/QHJPD2iHI3OYffXbDK7CjTiocrdOj7CUNxI89A0YKi2Sa
         eN1BUTvChN6mSxesN9/hAA0icCpzzHm/BrHvqA4fxlIkC7ye9q+vabB0rPSdIbUWpRG9
         5MWIeiHCFmOR5XtA4teU2S/4lNMYBo046hrmpG6jVpgyTwKs1pxJdo2D7Mcltnnwq68g
         RJiMsIg96DEJWvJ48Q3u3EGGJjMhEeM5pyGrEmMk3iBJHq+Se5KJa1I1qn9n0NOXMfhE
         eqnEJD/nYcXsYO++YJCGFTb+prIvzjvMyXOsAWVi0cqm+bd4VZt87tD4Yx6uuZ4GYE4d
         a14A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RftsbDGC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RftsbDGC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Glauber <jan.glauber@caviumnetworks.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.16 016/110] KVM: arm/arm64: VGIC/ITS: Promote irq_lock() in update_affinity
Date: Mon, 21 May 2018 23:11:13 +0200
Message-Id: <20180521210505.360653406@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110289431283482?=
X-GMAIL-MSGID: =?utf-8?q?1601110289431283482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>

commit 9c4188762f7fee032abf8451fd9865a9abfc5516 upstream.

Apparently the development of update_affinity() overlapped with the
promotion of irq_lock to be _irqsave, so the patch didn't convert this
lock over. This will make lockdep complain.

Fix this by disabling IRQs around the lock.

Cc: stable@vger.kernel.org
Fixes: 08c9fd042117 ("KVM: arm/arm64: vITS: Add a helper to update the affinity of an LPI")
Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-its.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -350,10 +350,11 @@ static int vgic_copy_lpi_list(struct kvm
 static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
 {
 	int ret = 0;
+	unsigned long flags;
 
-	spin_lock(&irq->irq_lock);
+	spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->target_vcpu = vcpu;
-	spin_unlock(&irq->irq_lock);
+	spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	if (irq->hw) {
 		struct its_vlpi_map map;
