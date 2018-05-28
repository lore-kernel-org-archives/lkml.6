Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939256AbeE1NsL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937482AbeE1Km3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:42:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 4.14 030/496] KVM: s390: vsie: fix < 8k check for the itdba
Date: Mon, 28 May 2018 11:56:55 +0200
Message-Id: <20180528100320.855375849@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit f4a551b72358facbbe5714248dff78404272feee upstream.

By missing an "L", we might detect some addresses to be <8k,
although they are not.

e.g. for itdba = 100001fff
!(gpa & ~0x1fffU) -> 1
!(gpa & ~0x1fffUL) -> 0

So we would report a SIE validity intercept although everything is fine.

Fixes: 166ecb3 ("KVM: s390: vsie: support transactional execution")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/vsie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -590,7 +590,7 @@ static int pin_blocks(struct kvm_vcpu *v
 
 	gpa = READ_ONCE(scb_o->itdba) & ~0xffUL;
 	if (gpa && (scb_s->ecb & ECB_TE)) {
-		if (!(gpa & ~0x1fffU)) {
+		if (!(gpa & ~0x1fffUL)) {
 			rc = set_validity_icpt(scb_s, 0x0080U);
 			goto unpin;
 		}
