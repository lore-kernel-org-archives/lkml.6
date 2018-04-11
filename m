Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48N9ARyLH2Xh3gO6vG200uTDvZQeaykdub3/pHohANiVR5Saiu8BSk+htFHeQA1zyTyaJXo
ARC-Seal: i=1; a=rsa-sha256; t=1523472929; cv=none;
        d=google.com; s=arc-20160816;
        b=MaaJEzxS/SdTUX79kqgtnCJqxHKp+VaPVM5MrMiLzAolY5qU+jPzh3UVyoILB5H2ii
         RN3egIPSZo/yuYZgZfdw7mXI7uZovifoKCzMA4J66Z99TevCTPuFwwn1OmD6Ds99eHHI
         VgtyLZ+618N77gWj0s0OasnuJ4R1SWBRbNKKbtrt7b28S/VL7RGPi9KiyCTTmvXW/Dsx
         lON+ww0eHVons+hTFYCUsb7xvubANtTw7s1/ujc8H3/W/DT9dzMcHut1q6dQdgXkFxRs
         BAay2H20OAFPksXKIofVUNAh3Oif3Ab00OXFraljm8m5/UXq4EW3wAWPtg2uuuboMYsN
         YEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kuXLDTiFQuKZZoLjSpzcq4fXr96fu7RHCchhT/pb9tQ=;
        b=JBdwLGLHaPd7sbdbUripF5wuCuXKz1VSFXU3jxN2nO/KayhZoHNkCEvK+PN2sEBLfr
         yidfwGh1tE1oUl9B+VFEdB74piaFofA+OF216fle8Fe3KC+ji/NDpn8sqjDEWh0vRr+V
         W8XkUnvIR/YpS+0U/gIKqezgCj31zSAjOWsb5RLvHHDeI2pds9qYtwrHOIA++PJZ1dN8
         qEUU+Y/gCA0fyrhj3KLaxbb7Hsb3Kgr4OemjD+/F/pHGb6h5RkedgGWA0swM++hgs/NG
         1lbKdmFKW8SYFuhhIT45tP76AEZEKo60T28hnQSG+i0lBjYQ7of2ApLixbfLGFFlDcCc
         5DfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 035/310] KVM: PPC: Book3S PR: Check copy_to/from_user return values
Date: Wed, 11 Apr 2018 20:32:54 +0200
Message-Id: <20180411183623.790127932@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476168802820578?=
X-GMAIL-MSGID: =?utf-8?q?1597477150483099672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>


[ Upstream commit 67325e988faea735d663799b6d152b5f4254093c ]

The PR KVM implementation of the PAPR HPT hypercalls (H_ENTER etc.)
access an image of the HPT in userspace memory using copy_from_user
and copy_to_user.  Recently, the declarations of those functions were
annotated to indicate that the return value must be checked.  Since
this code doesn't currently check the return value, this causes
compile warnings like the ones shown below, and since on PPC the
default is to compile arch/powerpc with -Werror, this causes the
build to fail.

To fix this, we check the return values, and if non-zero, fail the
hypercall being processed with a H_FUNCTION error return value.
There is really no good error return value to use since PAPR didn't
envisage the possibility that the hypervisor may not be able to access
the guest's HPT, and H_FUNCTION (function not supported) seems as
good as any.

The typical compile warnings look like this:

  CC      arch/powerpc/kvm/book3s_pr_papr.o
/home/paulus/kernel/kvm/arch/powerpc/kvm/book3s_pr_papr.c: In function ‘kvmppc_h_pr_enter’:
/home/paulus/kernel/kvm/arch/powerpc/kvm/book3s_pr_papr.c:53:2: error: ignoring return value of ‘copy_from_user’, declared with attribute warn_unused_result [-Werror=unused-result]
  copy_from_user(pteg, (void __user *)pteg_addr, sizeof(pteg));
  ^
/home/paulus/kernel/kvm/arch/powerpc/kvm/book3s_pr_papr.c:74:2: error: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result [-Werror=unused-result]
  copy_to_user((void __user *)pteg_addr, hpte, HPTE_SIZE);
  ^

... etc.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_pr_papr.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -50,7 +50,9 @@ static int kvmppc_h_pr_enter(struct kvm_
 	pteg_addr = get_pteg_addr(vcpu, pte_index);
 
 	mutex_lock(&vcpu->kvm->arch.hpt_mutex);
-	copy_from_user(pteg, (void __user *)pteg_addr, sizeof(pteg));
+	ret = H_FUNCTION;
+	if (copy_from_user(pteg, (void __user *)pteg_addr, sizeof(pteg)))
+		goto done;
 	hpte = pteg;
 
 	ret = H_PTEG_FULL;
@@ -71,7 +73,9 @@ static int kvmppc_h_pr_enter(struct kvm_
 	hpte[0] = cpu_to_be64(kvmppc_get_gpr(vcpu, 6));
 	hpte[1] = cpu_to_be64(kvmppc_get_gpr(vcpu, 7));
 	pteg_addr += i * HPTE_SIZE;
-	copy_to_user((void __user *)pteg_addr, hpte, HPTE_SIZE);
+	ret = H_FUNCTION;
+	if (copy_to_user((void __user *)pteg_addr, hpte, HPTE_SIZE))
+		goto done;
 	kvmppc_set_gpr(vcpu, 4, pte_index | i);
 	ret = H_SUCCESS;
 
@@ -93,7 +97,9 @@ static int kvmppc_h_pr_remove(struct kvm
 
 	pteg = get_pteg_addr(vcpu, pte_index);
 	mutex_lock(&vcpu->kvm->arch.hpt_mutex);
-	copy_from_user(pte, (void __user *)pteg, sizeof(pte));
+	ret = H_FUNCTION;
+	if (copy_from_user(pte, (void __user *)pteg, sizeof(pte)))
+		goto done;
 	pte[0] = be64_to_cpu((__force __be64)pte[0]);
 	pte[1] = be64_to_cpu((__force __be64)pte[1]);
 
@@ -103,7 +109,9 @@ static int kvmppc_h_pr_remove(struct kvm
 	    ((flags & H_ANDCOND) && (pte[0] & avpn) != 0))
 		goto done;
 
-	copy_to_user((void __user *)pteg, &v, sizeof(v));
+	ret = H_FUNCTION;
+	if (copy_to_user((void __user *)pteg, &v, sizeof(v)))
+		goto done;
 
 	rb = compute_tlbie_rb(pte[0], pte[1], pte_index);
 	vcpu->arch.mmu.tlbie(vcpu, rb, rb & 1 ? true : false);
@@ -171,7 +179,10 @@ static int kvmppc_h_pr_bulk_remove(struc
 		}
 
 		pteg = get_pteg_addr(vcpu, tsh & H_BULK_REMOVE_PTEX);
-		copy_from_user(pte, (void __user *)pteg, sizeof(pte));
+		if (copy_from_user(pte, (void __user *)pteg, sizeof(pte))) {
+			ret = H_FUNCTION;
+			break;
+		}
 		pte[0] = be64_to_cpu((__force __be64)pte[0]);
 		pte[1] = be64_to_cpu((__force __be64)pte[1]);
 
@@ -184,7 +195,10 @@ static int kvmppc_h_pr_bulk_remove(struc
 			tsh |= H_BULK_REMOVE_NOT_FOUND;
 		} else {
 			/* Splat the pteg in (userland) hpt */
-			copy_to_user((void __user *)pteg, &v, sizeof(v));
+			if (copy_to_user((void __user *)pteg, &v, sizeof(v))) {
+				ret = H_FUNCTION;
+				break;
+			}
 
 			rb = compute_tlbie_rb(pte[0], pte[1],
 					      tsh & H_BULK_REMOVE_PTEX);
@@ -211,7 +225,9 @@ static int kvmppc_h_pr_protect(struct kv
 
 	pteg = get_pteg_addr(vcpu, pte_index);
 	mutex_lock(&vcpu->kvm->arch.hpt_mutex);
-	copy_from_user(pte, (void __user *)pteg, sizeof(pte));
+	ret = H_FUNCTION;
+	if (copy_from_user(pte, (void __user *)pteg, sizeof(pte)))
+		goto done;
 	pte[0] = be64_to_cpu((__force __be64)pte[0]);
 	pte[1] = be64_to_cpu((__force __be64)pte[1]);
 
@@ -234,7 +250,9 @@ static int kvmppc_h_pr_protect(struct kv
 	vcpu->arch.mmu.tlbie(vcpu, rb, rb & 1 ? true : false);
 	pte[0] = (__force u64)cpu_to_be64(pte[0]);
 	pte[1] = (__force u64)cpu_to_be64(pte[1]);
-	copy_to_user((void __user *)pteg, pte, sizeof(pte));
+	ret = H_FUNCTION;
+	if (copy_to_user((void __user *)pteg, pte, sizeof(pte)))
+		goto done;
 	ret = H_SUCCESS;
 
  done:
