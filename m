Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227X7JwHjSi1I2gw4AJyfcUqnJUs9JdVHybKJeekVejmU+muMQn9VvZDvUg/l1ebAwk+6crP
ARC-Seal: i=1; a=rsa-sha256; t=1519412150; cv=none;
        d=google.com; s=arc-20160816;
        b=m/Y4zCo/hFqMsAnkL4zKUScJiJ1bnsRAcfP0HIb4BHfN0RNN4vKW5O4UAcD66CpgQX
         H5dcUNv4sWvXCaybEtw6pOZOXjovXDswhDBoMz/sX2AjBLwogH624m+92evswrBXWVWL
         GBmbaAKMgCCQ+d7rJTQHHJYJrs1PRQVUOclcyPJWF0awQ3kLQB+4Pbe7rKWSBk5MtAnS
         9RfLj5g0YIaEdb0s5ZTEoJibnGITMuVRE/DHe4Lh3GLJfqQgolSqK+QdfkGm2+cYQaZ/
         3t531ZTJQokjG0S2q9otVgkeyk5LZ3GfGqwneP4uGkODx0HBJOR+2+ZMJ7++yRq9hyM/
         Lb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UmYmfNHpMtENI2KufR/ZpkYyTL/gXcm4vk9xwIuuu8o=;
        b=QTgakrcZQTFbuprhOOExbNd9KMQIykUmlsgazWgZhcaidj1bFaUz8944uoBH8WeywN
         /6l2XmUA7ZTQ1JbxC0tZceG2GNaO5+ZB2q06sYu/P6Xx326XShl8nuh0fLHsd0L777n3
         JjpqZAOC7Qy3EAOzw9m+WrqGpzMUlROpzeicJte2hkS+0UEYVxA6jc1S1HRaEZmCwrNR
         H+YL8GovuQXdBvBYkyXEY/YpoDJhqkmOcRxaHL3WqG5Iifkzna/5D71U/WWs1DH2cZ1N
         IIuzf1x7y0XOuPzEMvx2uxdFfWENeaJpVQQDvFGBVsbizsQKtycgqEoqaTrtUkOpQrs9
         7Tag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Krish Sadhukhan <krish.sadhukhan@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 115/159] KVM: VMX: fix page leak in hardware_setup()
Date: Fri, 23 Feb 2018 19:27:03 +0100
Message-Id: <20180223170757.218356619@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219115163670101?=
X-GMAIL-MSGID: =?utf-8?q?1593219115163670101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>


[ Upstream commit 2895db67b01cb875457c9c3f30a14723b6b5dfd5 ]

vmx_io_bitmap_b should not be allocated twice.

Fixes: 23611332938d ("KVM: VMX: refactor setup of global page-sized bitmaps")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6950,7 +6950,6 @@ static __init int hardware_setup(void)
 			goto out;
 	}
 
-	vmx_io_bitmap_b = (unsigned long *)__get_free_page(GFP_KERNEL);
 	memset(vmx_vmread_bitmap, 0xff, PAGE_SIZE);
 	memset(vmx_vmwrite_bitmap, 0xff, PAGE_SIZE);
 
