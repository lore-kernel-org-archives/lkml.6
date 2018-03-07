Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsiujB+xefqk9vbpaoK5OY77EU+q+/GNAkMhSQdl9Qjr28dHR6Kvvp7T06p0tXXkUh1ke2J
ARC-Seal: i=1; a=rsa-sha256; t=1520451811; cv=none;
        d=google.com; s=arc-20160816;
        b=BqnDNedw0iScQ/Y8rkQ9cwsqNK8/NGY60cuP313eKeak/nS0RA9cKh3bxpiLJBGzu6
         bxPTb7N3gJODYieGim1CKwZtt0rRY9lcqc5bARiEJwwR+dWPGMgqLHoKm5yknqPzINCc
         EiuPgif3z1KFxfcOk4N6BeLux1eTI7KX8ejuh7BR0Y/93gLuZlCw7v8KLQWsuWz9VD3R
         pAkeD6K1sBY8p+HpHMI7lGBVnB3SBZQuLRbXFSC4/AUdcQx3f1bGCKcDSiNgKoh/taIU
         DtjbA4AljtW41yXIkZsThthGA52fB7JSc7MP9PtZ8e1y4fQg6qeJMPjdFt8o97jjE3mm
         KXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wmYeoGFyGEKsiCJdQwNX88t8J3eqZboLuofM8aRK4qE=;
        b=E4nXHlUrfsAQGRlc1rqshjo+ydFWZ13k+m8wWHCUjTpW4zst0VeZ2g9BW6Xv0iwmzj
         ZdttqB818VKWoMm4MLGbyzxcZ/XN6lYeJsCh9kR5ZyjkloJmC2pLGKhH+imNROPSCX21
         4tuj8euHI3/Spdcilw1wN2xrW7cjfFU9VQtRqOJQmtJzYet3RpMm4ZoOpal021/3ONQZ
         kXlO/KYiT9XS1LMT2a+YZ6DATbnMwBD1yjg8WIxSHNJDVD9zRUXLhbzBg8DNItTXY9OJ
         jRBJkiHQuhKheBHNsn9rru6X9SghzTy/uRDFDFtBpDRfkQ74j0bT8LAEH/26EypUGyu6
         NFSg==
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
Subject: [PATCH 4.15 103/122] KVM: s390: consider epoch index on hotplugged CPUs
Date: Wed,  7 Mar 2018 11:38:35 -0800
Message-Id: <20180307191744.368559705@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309278008146063?=
X-GMAIL-MSGID: =?utf-8?q?1594309278008146063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2359,6 +2359,7 @@ void kvm_arch_vcpu_postcreate(struct kvm
 	mutex_lock(&vcpu->kvm->lock);
 	preempt_disable();
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
+	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
 	preempt_enable();
 	mutex_unlock(&vcpu->kvm->lock);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
