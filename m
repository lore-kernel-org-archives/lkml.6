Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvzyiqH0tMhsP9OW7BA5/lB0kE6diQ8Cefnumnpd4cPPPA/FLGjgdGEx5TnzeNO3gHACstM
ARC-Seal: i=1; a=rsa-sha256; t=1520451813; cv=none;
        d=google.com; s=arc-20160816;
        b=zIsO1fgUkftVMZUmT4jbboHAsvIp0NMAFU6u7OBn+YqtHOUUzw22NBB4IlXi/XV4pZ
         lIwcBZSQ+pjH5C1HX8N7IYLUZ4v14V5ORaKazb5egawZA+pPetWgSSDoYLRJgjVAzFt/
         dYYy1+yHqK++TnJD+rSE2b6AMq8B2L5WsYlQeHv1MSiA49HZZWwTDH7MYxr8pmUs9x4X
         49l7MlRH96Kti3pXUorpKOZKTGhE6FHG8m2hRRi3RTdTD6iZ9f7gxWsrXIQsPD6ZgPKf
         MeHneS4IwFqNeAMbJ03Otv6PGknh7LJzRKmiTbbCD2CuAEdmY7UqlNqvjEqv+BEj0LLy
         tBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YJjD67KlFJqH218hfgYusGtwVsdAskYiIfyMyLdlk4k=;
        b=cw3Fd3X7eGjWvwLtfy11jtMjwFTrdSODCeb4L0yiM8/LvsNjz0fg1ce2ysS8r7aLvE
         Lch1cibDGqMfwUJtosDnZiu4Cc06MFfoFnjzVjFFdsWCd1oG0LwXwDbm7ZuYqTw87TOM
         32ttcLvhvwmvJ+jE6KgjZup1WWFhkXv3rUm8tA8BSUp4TqFGqrx7s997QMhb4p52EzTe
         MlHhIDZ/CS/+Opaqsxg+xwFnehLrjmFBze3qfaxx9JOdwBqwS50Papf6koFQz2ZLyMOm
         6IRkTUGlz2hMP7bjX9uk0vnH7eys2tEv4KMKXA9N3a41iaDB4FjTZKDUlWuN3jubiZ7w
         pU0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.15 104/122] KVM: s390: consider epoch index on TOD clock syncs
Date: Wed,  7 Mar 2018 11:38:36 -0800
Message-Id: <20180307191744.549054908@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309280290613110?=
X-GMAIL-MSGID: =?utf-8?q?1594309280290613110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 1575767ef3cf5326701d2ae3075b7732cbc855e4 upstream.

For now, we don't take care of over/underflows. Especially underflows
are critical:

Assume the epoch is currently 0 and we get a sync request for delta=1,
meaning the TOD is moved forward by 1 and we have to fix it up by
subtracting 1 from the epoch. Right now, this will leave the epoch
index untouched, resulting in epoch=-1, epoch_idx=0, which is wrong.

We have to take care of over and underflows, also for the VSIE case. So
let's factor out calculation into a separate function.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180207114647.6220-5-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[use u8 for idx]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |   32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -166,6 +166,28 @@ int kvm_arch_hardware_enable(void)
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 			      unsigned long end);
 
+static void kvm_clock_sync_scb(struct kvm_s390_sie_block *scb, u64 delta)
+{
+	u8 delta_idx = 0;
+
+	/*
+	 * The TOD jumps by delta, we have to compensate this by adding
+	 * -delta to the epoch.
+	 */
+	delta = -delta;
+
+	/* sign-extension - we're adding to signed values below */
+	if ((s64)delta < 0)
+		delta_idx = -1;
+
+	scb->epoch += delta;
+	if (scb->ecd & ECD_MEF) {
+		scb->epdx += delta_idx;
+		if (scb->epoch < delta)
+			scb->epdx += 1;
+	}
+}
+
 /*
  * This callback is executed during stop_machine(). All CPUs are therefore
  * temporarily stopped. In order not to change guest behavior, we have to
@@ -181,13 +203,17 @@ static int kvm_clock_sync(struct notifie
 	unsigned long long *delta = v;
 
 	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm->arch.epoch -= *delta;
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			vcpu->arch.sie_block->epoch -= *delta;
+			kvm_clock_sync_scb(vcpu->arch.sie_block, *delta);
+			if (i == 0) {
+				kvm->arch.epoch = vcpu->arch.sie_block->epoch;
+				kvm->arch.epdx = vcpu->arch.sie_block->epdx;
+			}
 			if (vcpu->arch.cputm_enabled)
 				vcpu->arch.cputm_start += *delta;
 			if (vcpu->arch.vsie_block)
-				vcpu->arch.vsie_block->epoch -= *delta;
+				kvm_clock_sync_scb(vcpu->arch.vsie_block,
+						   *delta);
 		}
 	}
 	return NOTIFY_OK;
