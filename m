Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvU8o6XIg/AeqQfrnta1TZ+Z8Iu1k65nEQxLCEgUnw67vKhpLzBC2I0NJDLC2YOWmYaYdP
ARC-Seal: i=1; a=rsa-sha256; t=1520954993; cv=none;
        d=google.com; s=arc-20160816;
        b=G7jyESGBzEUw+tPoNN+eR7KU1MswCmAnoO/msk+uKCxo5a5+V56e05hoJalIW2hQyj
         qzrqBxigVV6qb242GyQPK4hnWmZGSgSp9UvN/P6H4s/vTHs9w1RkcBgvR4uBg8SH7tBa
         gIZ2b5etc+dgc9m5EF1sbyfgv/hRPBElH+tNmp/mslaP7/oAK+NRKi0TVPbfkQCwgtoC
         yQ3ApGMgPJN2bbJM3YX9tYnLGaWsxNZUH4WR2GTrYyPwUkZp7oHGb7vJsCCIcVj8vAHM
         89lDjk4XBIq88zRlFhlNY/Qj/ZBLAorIYrm+JBPT8uENvoTQAA5GrdHmWIK0Vq3HVO3g
         FR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gjE0g4KPD8S22Y9gMWeel5XM5l+6Om1tyahMvELWnoc=;
        b=jsNtp9A0GWk+ZalZCgqcIai/PL/aMA6nJuaC3JejK0SI8XBccSOzfUV+dv6tvNm9mP
         ImpsxAl39ZcyUYu41Rt8BrhYXkTMYaCNEBzH5LDqykbwXRUCvZPQ44GUx5yQDeTT+al7
         5slia16Br+JCwppNMBnvdnHjy0PITgefc+RyHW+dhpkoWbgzqQ4Iqt7xnrUnW6Qs8tuN
         DmiiRw9Clm7mBf8FQN9YmJrclazhrYrC307UrwxEZbip9L1wn54WdhNTQpOEl/udsvYZ
         KLr+h8VMSIoKGjff5ip4F7O677D9pMc4NwXOmRW7CIHdvg2RX6fX9v9g28LOIud9Gbtp
         YmnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.15 053/146] KVM: s390: fix memory overwrites when not using SCA entries
Date: Tue, 13 Mar 2018 16:23:40 +0100
Message-Id: <20180313152324.733971401@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836903307298402?=
X-GMAIL-MSGID: =?utf-8?q?1594836903307298402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit f07afa0462b76a5b9c4f3a43d5ac24fdb86a90c2 upstream.

Even if we don't have extended SCA support, we can have more than 64 CPUs
if we don't enable any HW features that might use the SCA entries.

Now, this works just fine, but we missed a return, which is why we
would actually store the SCA entries. If we have more than 64 CPUs, this
means writing outside of the basic SCA - bad.

Let's fix this. This allows > 64 CPUs when running nested (under vSIE)
without random crashes.

Fixes: a6940674c384 ("KVM: s390: allow 255 VCPUs when sca entries aren't used")
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180306132758.21034-1-david@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2118,6 +2118,7 @@ static void sca_add_vcpu(struct kvm_vcpu
 		/* we still need the basic sca for the ipte control */
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
+		return;
 	}
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
