Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqy6TNt1Iocd740qTDq06C/QwY4qLBd69lb1PIxrEpRXQpYsRbmtaWWTGKOw5pA3YFWrKZJ
ARC-Seal: i=1; a=rsa-sha256; t=1526937486; cv=none;
        d=google.com; s=arc-20160816;
        b=OWtcM7ymnupNMtI5f/vnXwbWp1sLgz+eVnf0gulA3FGHdPdMbYbXeS3pI6/1KPHTdY
         5CglAiis9PhPN0OW+xpN2e7t8rjdpwp/bmeGEi4vgZlIVnUEAqyvIOno/OrYS3Hd5fQo
         PXRhNuemOyPypeJjLMUt2KghoQVqy9WQwRTZNGNI4R6sQqlUxrf/G27pqNH5CxX6XZx0
         CPvMi4aSREgVu5JciAiKg5T4n0McRDWFU1As+/bNpXLTM3YDRpi1SfJ2z1n/7xzgvNdV
         81HdVx8gyh7DtPXHnS1yNXTL+Gb7TC68w1TpxCmb+WQW3Frh7C6ibkYwbutbqYbH1ebE
         NCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2MJITZSN73HNSvcg04f0qgQXrkHmf5QBr9AVFTIqWlE=;
        b=PazEhM3xN/wv6rQv6bIGk+AabD7EcP0DrsDOUlIUBBcl45erBs0dnJqdUqMdiAbSWB
         xVipgtYt8DC1hEaxr1MBNoBTWfWhjyVzhjhkwnFLbWaUoHeq3XBP9u+pAgCDZqwDu6qS
         8BCfbwSMasY4fjVUBnZ6pnr6EHDbjnJdNWsVOnJ8Dv2r8hn4S6nICmsG0dgkWflvBy4r
         h/kuzScTGV4/eURWpmDkmenUhGJdKGf/ig4Qx7JwpNx90tTwpW2f8f/YJ3rbiEXxCWM9
         lV3QYMm/n8+gVmSTfbduZt6YV0qAq1GgV9/8Yehn0Y9Zy2lyy1XPvlCFfnmFYy25H6Jr
         PYng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CfP43Bic;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CfP43Bic;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Glauber <jan.glauber@caviumnetworks.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 12/95] KVM: arm/arm64: VGIC/ITS save/restore: protect kvm_read_guest() calls
Date: Mon, 21 May 2018 23:11:02 +0200
Message-Id: <20180521210450.041829852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110002195518274?=
X-GMAIL-MSGID: =?utf-8?q?1601110002195518274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1830,7 +1830,7 @@ static int scan_its_table(struct vgic_it
 		int next_offset;
 		size_t byte_offset;
 
-		ret = kvm_read_guest(kvm, gpa, entry, esz);
+		ret = kvm_read_guest_lock(kvm, gpa, entry, esz);
 		if (ret)
 			return ret;
 
@@ -2191,7 +2191,7 @@ static int vgic_its_restore_cte(struct v
 	int ret;
 
 	BUG_ON(esz > sizeof(val));
-	ret = kvm_read_guest(kvm, gpa, &val, esz);
+	ret = kvm_read_guest_lock(kvm, gpa, &val, esz);
 	if (ret)
 		return ret;
 	val = le64_to_cpu(val);
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -297,7 +297,7 @@ retry:
 	bit_nr = irq->intid % BITS_PER_BYTE;
 	ptr = pendbase + byte_offset;
 
-	ret = kvm_read_guest(kvm, ptr, &val, 1);
+	ret = kvm_read_guest_lock(kvm, ptr, &val, 1);
 	if (ret)
 		return ret;
 
@@ -350,7 +350,7 @@ int vgic_v3_save_pending_tables(struct k
 		ptr = pendbase + byte_offset;
 
 		if (byte_offset != last_byte_offset) {
-			ret = kvm_read_guest(kvm, ptr, &val, 1);
+			ret = kvm_read_guest_lock(kvm, ptr, &val, 1);
 			if (ret)
 				return ret;
 			last_byte_offset = byte_offset;
