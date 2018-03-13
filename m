Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtIjiT+CRy16PhKe69Lfw8CDdGdJmWYSgjzdE7VDHVSCM7qr2Yk8GJyp5qnu1VjAdH/kbil
ARC-Seal: i=1; a=rsa-sha256; t=1520955552; cv=none;
        d=google.com; s=arc-20160816;
        b=RqT3qb2Tw0PhupkDKnatNLAlIZcreKaXkgThXJemaRMLGzak9ypmEebIzE+fqzK4sF
         Do9SlP5sWkJ78lizKVSBCsZsmDhfAZdhqP4cuL/ISBmQgSSN62i69SxAxYb1u8z4jTvR
         gGykE40i433wJ2+lV44IgvIm37JrtvfswElo2ZirgY8bmrzGgBqkTLtcpTgRnKD4/Itx
         8BMEDzYX36/UtcZY19f5y8vDgL2GlsMIHZPL4ce79LmsbhounzJ5QQZYnAbSvqe/5+qy
         oGXRaFbde6fIWP9pNbtnkWByq+T1ZTHsZPbw3+PU1HUd/iKK26VYRbLr0UAxHXZw7y55
         GONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0HMRlNgnkpS2aUFNpEYIlnpEWp+vekZ/VPqt5YZ2TJI=;
        b=lclXjQMFBSgzcq82jbCB9aMQes8z+IfoLZActZp35XuEOnGrS6zYmMFo30v9I6oDIP
         vJJ7bBlV2rsJGWKZhzo2dnNOYpfqGM+NrJqXfcOqolZHl5sO7sqqM640TRfhIhiU9hTm
         9nVIZuhnLE/ChfU8VOghJqVW1t7WSquGq/ng0O0ZtAdGY1G7STGHN66OeWlXGPnHLjX2
         9OGREba8RPo2875iT7QUjxRx2uFhX2D0IftfdRGXsZrXdTBVpm5PUWacQRBpET6D7q9U
         Uk6VpD8sbje0WHPIqmH4Fcc0JZ+1IvdS/ymH5KHIzANa7TxFaz6YGm8VzwxyJpZHDuOc
         2nUA==
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
Subject: [PATCH 4.14 089/140] KVM: s390: fix memory overwrites when not using SCA entries
Date: Tue, 13 Mar 2018 16:24:52 +0100
Message-Id: <20180313152504.116029117@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836903307298402?=
X-GMAIL-MSGID: =?utf-8?q?1594837489866149384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2119,6 +2119,7 @@ static void sca_add_vcpu(struct kvm_vcpu
 		/* we still need the basic sca for the ipte control */
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
+		return;
 	}
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
