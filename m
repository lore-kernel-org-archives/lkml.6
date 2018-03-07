Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvua2EZyw6Esg0sEniKAKUdbGCKphwxVvAC/FouMHEPyCFIJP+fieIHrxV4d4EZAETM1HBk
ARC-Seal: i=1; a=rsa-sha256; t=1520452053; cv=none;
        d=google.com; s=arc-20160816;
        b=07qBqfBywR4Y8iyVXDP7OBfSpTu5Puk/fhRF4Luv4trLKocTn8PYCko4gNOAWvWzy2
         3obbAiKOOF/b4DCD4E8lCW9Xkyp0sHyN+Ja/cFZeGiUlH+DZZrc37Ys6wroX4yFG1ZqS
         tqzgldCm1JU9ZWFBanZF8hxBnMliLeWecFOu+MRY8+gi36mHjNojdg5MyDa9831GdP4d
         y+NfwKZyuqA8BqFxVAXRY2g4YiijSW7a3YgptOqFCqLTiGB4/28wBCAwphA2Aph7A+CK
         79V4PFguqrIF4KcAnLijDPZ/0Q9eBgh0Exp1V+q4lxS4/fmAKa613T/Wl6MfOYRR+SgO
         WQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3C9otcujwp7iAomC0rmzBaFSWD5LdqBqhQTOg8i6PVE=;
        b=js5yg+AJk//SeOmqaOYxGBp2rO1YlSdlfGX7BqZ6BwLkaS/vR0oCJIYckQsyGBRv+0
         aCu3VGipRX8kpWChmM5NQZmxpfSg9aSsr+KMkXt3ZiiETyOyjadHPn2n++wE1bUjCsN5
         C9f5lQyKcYGAgCxr+xRgm2LtO9WAYYefGxpvdHFql+WAGIflkYpfMfXt0ilIn3X0RkEC
         QVBZzQzk300v/1vnDkDVh7kVbNySNCabbba5hyENsKD2RsbvSvhyrqrl3elXC8hPXED0
         f904H7BE4HzctDgjCaFtt49jnV5H9HYak5Y4cHzgRNohVCgcZpEvOuTK6L7icVIqKSKz
         T5/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.14 088/110] KVM: s390: consider epoch index on hotplugged CPUs
Date: Wed,  7 Mar 2018 11:39:11 -0800
Message-Id: <20180307191051.118223074@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309278008146063?=
X-GMAIL-MSGID: =?utf-8?q?1594309531991317547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit d16b52cb9cdb6f06dea8ab2f0a428e7d7f0b0a81 upstream.

We must copy both, the epoch and the epoch_idx.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180207114647.6220-4-david@redhat.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2357,6 +2357,7 @@ void kvm_arch_vcpu_postcreate(struct kvm
 	mutex_lock(&vcpu->kvm->lock);
 	preempt_disable();
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
+	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
 	preempt_enable();
 	mutex_unlock(&vcpu->kvm->lock);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
