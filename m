Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsnZcv/oasRDjfbqPQFE4gkAANG7ysQqR6zeMcTG2aX/5fUWE6wYHFL0/FuhV4JzKYF3lSD
ARC-Seal: i=1; a=rsa-sha256; t=1521214234; cv=none;
        d=google.com; s=arc-20160816;
        b=TzKNOUPyXPJJIlBs40asan9u9k2UVADAriIxwCvKjYw3z3QBQyTZofl9bw1k8b/LG2
         2amzTeNW7xnrd/39FKJbuXjf0Ag7bB26bMTvtUfnZhbgXv66cIRhkt+KPZaxGMGxA7dr
         7dxeNqOl+WCU7zO21zgM56dv1BSY+L4n11L01znRC64Ipilqd3jBq+woAj0z56ilC0/m
         8M92SFPmWnV3/HcfPQBCYtxrELyvy0PVb1Dus7EBzwMb2khkjEaxmHMnWsyLv2DL/sHu
         VjF7hXxf8BoTMmOoFulUMMAkO0gQTpRv9pBOEPrNB7Wsc/xk530HVnAaVA8pQhcsG5Dt
         E0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k82zpL9TiMCRgluCmfd8fUZhmb34NNA883jQR/bNER4=;
        b=v5vyBGrIoS+VQgN3jyojWY63/N1VzHrZ2KSer/F1A5as8JfqP9din5hby9DDD1Pljx
         zEtCDxbx2+7Xtg3I41bpoxtoU6MUGPtXHFh78gpLL7H3p9NFDbtF8VKSmuRDga2KajXK
         DgV5dzKuYA0eQhKamIN2DrYK0DHL1dYTFwQ4tMQaipPfGq6QDZbFkcd/nDKFeArlJta/
         4n97Io+dw0nWziYIeykp7Z/qq7NQQuJyU1eYMSUd5KQw3J1C6q3OyHy0wmX3Bzssqo2P
         B9Ui17CjuRh2xKCOnw8+H/nuk2Mvc48hmRSAbwGMEADFdh5iLS+5saYf0DYLrIqNcgkM
         netg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.9 23/86] KVM: s390: fix memory overwrites when not using SCA entries
Date: Fri, 16 Mar 2018 16:22:46 +0100
Message-Id: <20180316152318.939963790@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108737027492904?=
X-GMAIL-MSGID: =?utf-8?q?1595108737027492904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1601,6 +1601,7 @@ static void sca_add_vcpu(struct kvm_vcpu
 		/* we still need the basic sca for the ipte control */
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
+		return;
 	}
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
