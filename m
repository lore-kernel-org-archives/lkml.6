Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591634-2-13984376839331212206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591633; b=WwqPMuhnFMujdH5+wtns9wTrbWlM5Y7QWQOTva33p+MudNS
    kmEBALaC/5P20nctCZCrc7N+gKYKHfv4M+gIXHxZ+b1aOeomuf1qB1E0d9JnNyee
    DtfQFs997qUHDamIZlNxkXYPb5NP7I2ezyu2noSnWSRFlDRV5SKuIrXL1mUptxB0
    0/zX+hkgt9ArAlATAK7oXP1cArkQqJjgrVusYoTpdPKYzmuvBRjBCNa68pIy7DfK
    a+z2P98vrVx9FdWODxdaV5t3mi8ria8GgBJCJJOYdONC5g1E/US0NXyYNR+DgO0l
    9GlY/3S2lYVyA7Wfy3yqaUtvWljFhjNOHZZF4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591633; bh=QJJzDayzoABr3f9zrXuxSfhZN5
    7YiX9sAih7rGsVJdk=; b=Hlw91urkJUIM22q7Xmo44CdV+Jwwz+LA+fw1v0HI4Z
    BKHQ3THV3ORZdTEwqbJFyEG7qJJaivVLdXb9hz4oixS8493Cojr+Cl73AJn1sD7i
    8GlQ6daGmHcyZFmxsT1K2N5xn/CxWPPnAqWlnHJdJI90Cpu2OGZsHpmIsBeHlhqS
    SLC2sVTpJ+NtImzJ5gSI6CRrDrU0ctvUA5QqcJ/MaMcKd2g6oisr+2dZ+6Cftle4
    aRuH8KirzPed27xgC52JbworTCMVZwwKjTU5/3fswDs2w3NXXtCiPlXIdteI54hh
    wMUe9KkAT6FpeqtaSCNxdW3Eok9WtClDGIU1FMW/5vdQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeBBRNv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:13:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbeBBRNq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:13:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Martijn Coenen <maco@android.com>, Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 145/156] android: binder: use VM_ALLOC to get vm area
Date: Fri,  2 Feb 2018 17:58:46 +0100
Message-Id: <20180202140846.937885894@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ganesh Mahendran <opensource.ganesh@gmail.com>

commit aac6830ec1cb681544212838911cdc57f2638216 upstream.

VM_IOREMAP is used to access hardware through a mechanism called
I/O mapped memory. Android binder is a IPC machanism which will
not access I/O memory.

And VM_IOREMAP has alignment requiement which may not needed in
binder.
    __get_vm_area_node()
    {
    ...
        if (flags & VM_IOREMAP)
            align = 1ul << clamp_t(int, fls_long(size),
               PAGE_SHIFT, IOREMAP_MAX_ORDER);
    ...
    }

This patch will save some kernel vm area, especially for 32bit os.

In 32bit OS, kernel vm area is only 240MB. We may got below
error when launching a app:

<3>[ 4482.440053] binder_alloc: binder_alloc_mmap_handler: 15728 8ce67000-8cf65000 get_vm_area failed -12
<3>[ 4483.218817] binder_alloc: binder_alloc_mmap_handler: 15745 8ce67000-8cf65000 get_vm_area failed -12

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
Acked-by: Martijn Coenen <maco@android.com>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -668,7 +668,7 @@ int binder_alloc_mmap_handler(struct bin
 		goto err_already_mapped;
 	}
 
-	area = get_vm_area(vma->vm_end - vma->vm_start, VM_IOREMAP);
+	area = get_vm_area(vma->vm_end - vma->vm_start, VM_ALLOC);
 	if (area == NULL) {
 		ret = -ENOMEM;
 		failure_string = "get_vm_area";
