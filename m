Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpMbczmzvwLw9kd10C1wlBSe3sY4aVq9pvDsE9IVvCU2XvSYaI93IhkWNRKgeIeZOkJEMjL
ARC-Seal: i=1; a=rsa-sha256; t=1526937763; cv=none;
        d=google.com; s=arc-20160816;
        b=yg8yE+nbwI2wgPLVuKDz9BSRv/73gQ1BQZG3TTBdhOvN9qrVH8AXIkfA/7pqwiyGKP
         Gnto9lAHWnRDc7q9/nXsunwLA0Al13T3F29/BqWm2+tO1FtLHcAqb3UoMgjr8vg2Q4FY
         CJ9jVp4j2R95aZgqLtGUO0o2awORRaQpE4L666B3a24H76NLLawo4GIJQxnl8Pn8AVr/
         zIcjEDibd0gw66dxgtKey71e65vpgESF5YxaasiOOjseKqG/JIUbrkwGdaoeOl72O7Wy
         bchOk/SVkLdrUz043ljApcPDs+fZnK01T+prj2cA+yQm9YJ/6+NizdIk/ft9xLRAQ/Eb
         affg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bDS+TF1/nhlp73HghaO3ZGqYo0mg2E/qPEEGu5uJl0c=;
        b=Pnwo3lSl6WE1Lv/VtfbpzVPCcxDQa2O8i9XiCwOOa5sB6vu+3JGgkbGtDNUdJ4GAO/
         Zs2Nj4js1CD5fNuduuoeStu52waF8SpsG7twa56Lmc+MxvjkqXUoO+CO481qTLQZU+jp
         M08zXjlG4WD6K8QE6h2YFLWIo2w66NIVMtc/bRSNAd45YUnoe9y4xGwBDBg7FESkoGCq
         UhLw+OKggMw4s61lxzypK9Yc5qmS6ahmPvNUK6S+TM90sbzmztIwl/v6xd6Wrz9shkNS
         S2PkC/4ngZF0TNY5WjUPzIP0TRqInYZM2y85lG6bzRXLZYD0fwg3o2nREfpnypE8zFGN
         hdMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lenLJOFe;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lenLJOFe;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Glauber <jan.glauber@caviumnetworks.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.16 017/110] KVM: arm/arm64: VGIC/ITS save/restore: protect kvm_read_guest() calls
Date: Mon, 21 May 2018 23:11:14 +0200
Message-Id: <20180521210505.413676620@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110002195518274?=
X-GMAIL-MSGID: =?utf-8?q?1601110291940432473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>

commit 711702b57cc3c50b84bd648de0f1ca0a378805be upstream.

kvm_read_guest() will eventually look up in kvm_memslots(), which requires
either to hold the kvm->slots_lock or to be inside a kvm->srcu critical
section.
In contrast to x86 and s390 we don't take the SRCU lock on every guest
exit, so we have to do it individually for each kvm_read_guest() call.
Use the newly introduced wrapper for that.

Cc: Stable <stable@vger.kernel.org> # 4.12+
Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-its.c |    4 ++--
 virt/kvm/arm/vgic/vgic-v3.c  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1896,7 +1896,7 @@ static int scan_its_table(struct vgic_it
 		int next_offset;
 		size_t byte_offset;
 
-		ret = kvm_read_guest(kvm, gpa, entry, esz);
+		ret = kvm_read_guest_lock(kvm, gpa, entry, esz);
 		if (ret)
 			return ret;
 
@@ -2266,7 +2266,7 @@ static int vgic_its_restore_cte(struct v
 	int ret;
 
 	BUG_ON(esz > sizeof(val));
-	ret = kvm_read_guest(kvm, gpa, &val, esz);
+	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
 	if (ret)
 		return ret;
 	val = le64_to_cpu(val);
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -329,7 +329,7 @@ retry:
 	bit_nr = irq->intid % BITS_PER_BYTE;
 	ptr = pendbase + byte_offset;
 
-	ret = kvm_read_guest(kvm, ptr, &val, 1);
+	ret = kvm_read_guest_lock(kvm, ptr, &val, 1);
 	if (ret)
 		return ret;
 
@@ -382,7 +382,7 @@ int vgic_v3_save_pending_tables(struct k
 		ptr = pendbase + byte_offset;
 
 		if (byte_offset != last_byte_offset) {
-			ret = kvm_read_guest(kvm, ptr, &val, 1);
+			ret = kvm_read_guest_lock(kvm, ptr, &val, 1);
 			if (ret)
 				return ret;
 			last_byte_offset = byte_offset;
