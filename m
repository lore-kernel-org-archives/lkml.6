Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00081C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AD620578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130585;
	bh=v1sokFURBqK+vDZKHhvrxZHjZV+OQwdYcYfMeG1Dj2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rt+BXh5qKyHa1nar8Ff4SVGvTNfCF8FY93SJJbqcejbkXtlsW3ZasSLA/5pmqm20B
	 LC/d3Bp8Q2Jyi3GK0MCK6TY6ZZ4svVbiHl9E+XVac+bxLPB7eS0ZtmJQPA5TIjqjby
	 BUZuRnrz9nZdRr0vLt6/VCCb5ymqORrv5g0kvGgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbfBYVgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731551AbfBYVgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1058B217F5;
        Mon, 25 Feb 2019 21:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130580;
        bh=v1sokFURBqK+vDZKHhvrxZHjZV+OQwdYcYfMeG1Dj2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnLwTpSvC4qmcSkQtGTa6kO6vxhPlcUaXgrwNvgb/9vCPBCjGVO4+wVR+9XUHvL+t
         nZWmA2hUqfrF5BmMEivH/MWIz/CfLEoRiHWJ3vIybZqXBqEMynMM73iIeoo1l6v9R2
         nl26WrTRXhpCSsuxQfBCNlsjtrHGjHPR9fmmaytA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.20 166/183] s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity
Date:   Mon, 25 Feb 2019 22:12:19 +0100
Message-Id: <20190225195123.115123633@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre Morel <pmorel@linux.ibm.com>

commit b10bd9a256aec504c14a7c9b6fccb6301ecf290a upstream.

When facility.76 MSAX3 is present for the guest we must issue a validity
interception if the CRYCBD is not valid.

The bit CRYCBD.31 is an effective field and tested at each guest level
and has for effect to mask the facility.76

It follows that if CRYCBD.31 is clear and AP is not in use  we do not
have to test the CRYCBD validatity even if facility.76 is present in the
host.

Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")
Cc: stable@vger.kernel.org

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1549876849-32680-1-git-send-email-pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/vsie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -297,7 +297,7 @@ static int shadow_crycb(struct kvm_vcpu
 	scb_s->crycbd = 0;
 
 	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
-	if (!apie_h && !key_msk)
+	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
 		return 0;
 
 	if (!crycb_addr)


