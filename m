Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806987-2-5460872722127401056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806986; b=eumUxqrmDwUeI29ayr4Pu73+HgGMtnW2YViGq7WUZ6ELuD6
    U44C47Ikd1FtN6lOJ1b1EPTjoX1mTiB9Oz/V3wrD7yg42wvKC5BJbkl9PzNNlw7u
    hUlpkuYFUa0gO4VLVSw4J0Gn6XwKsDZeBCj8bpCvhhdJkSOkWRvD3BAsAbTatlnd
    RKGNKaf1xDttR5mnMzuwWSWzhvD3/4vEIyuQuDK0gz7eEyNslpM957Ciz4hsZqWW
    GVXMNuEXTzvxNUKqk7/YXrnK19rzs/Na9edCialSw8P7hCJdc8w5kctLYe89b99D
    +ll9ITv9BTpJK3xEDf2IQAazFDFz3vlg0Vl0eCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806986; bh=AOCIE48RllYkDNQVoMChsaJW8i
    r9K1cvHN8E0em2oH0=; b=vvrfh0Na1OZmNSe+TUAy0LiLs1uLfrCMwXGub2KsiD
    Wlv4CKL+E5Rmq6rkZlehp04YzI6nFgeyWZEreRUl3RtrHTSBzoQ1UiCZHjwEiPr9
    xPGYAP764cII0OTA+TXtWq3WMxDXOOuGFYkQHztBJ47WKQDCHjbn3FEGOhWP0ihT
    oXlMskuChbg9VV26uaHvVHhqX1ZEamqgvnOYjG0w8H/rsEYgrJ2bPJHWZWz6Ebeq
    2qOeNFoNoUu/C4Kfw1Di1PMqUlgNjg1n6qJO6KxLyWM1UTYU66HEau5VGmwKsPN5
    s3CXO2uSNOD3E7/bEW2v6IQx1NgrGQ3hsGOEE/TSyS7g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeCWJ6R (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbeCWJ6L (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 38/84] rtc: ac100: Fix multiple race conditions
Date: Fri, 23 Mar 2018 10:53:52 +0100
Message-Id: <20180323095417.706620097@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>


[ Upstream commit 994ec64c0a193940be7a6fd074668b9446d3b6c3 ]

The probe function is not allowed to fail after registering the RTC because
the following may happen:

CPU0:                                CPU1:
sys_load_module()
 do_init_module()
  do_one_initcall()
   cmos_do_probe()
    rtc_device_register()
     __register_chrdev()
     cdev->owner = struct module*
                                     open("/dev/rtc0")
    rtc_device_unregister()
  module_put()
  free_module()
   module_free(mod->module_core)
   /* struct module *module is now
      freed */
                                      chrdev_open()
                                       spin_lock(cdev_lock)
                                       cdev_get()
                                        try_module_get()
                                         module_is_live()
                                         /* dereferences already
                                            freed struct module* */

Also, the interrupt handler: ac100_rtc_irq() is dereferencing chip->rtc but
this may still be NULL when it is called, resulting in:
Unable to handle kernel NULL pointer dereference at virtual address 00000194
pgd = (ptrval)
[00000194] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 72 Comm: irq/71-ac100-rt Not tainted 4.15.0-rc1-next-20171201-dirty #120
Hardware name: Allwinner sun8i Family
task: (ptrval) task.stack: (ptrval)
PC is at mutex_lock+0x14/0x3c
LR is at ac100_rtc_irq+0x38/0xc8
pc : [<c06543a4>]    lr : [<c04d9a2c>]    psr: 60000053
sp : ee9c9f28  ip : 00000000  fp : ee9adfdc
r10: 00000000  r9 : c0a04c48  r8 : c015ed18
r7 : ee9bd600  r6 : ee9c9f28  r5 : ee9af590  r4 : c0a04c48
r3 : ef3cb3c0  r2 : 00000000  r1 : ee9af590  r0 : 00000194
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
Process irq/71-ac100-rt (pid: 72, stack limit = 0x(ptrval))
Stack: (0xee9c9f28 to 0xee9ca000)
9f20:                   00000000 7c2fd1be c015ed18 ee9adf40 ee9c0400 ee9c0400
9f40: ee9adf40 c015ed34 ee9c8000 ee9adf64 ee9c0400 c015f040 ee9adf80 00000000
9f60: c015ee24 7c2fd1be ee9adfc0 ee9adf80 00000000 ee9c8000 ee9adf40 c015eef4
9f80: ef1eba34 c0138f14 ee9c8000 ee9adf80 c0138df4 00000000 00000000 00000000
9fa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[<c06543a4>] (mutex_lock) from [<c04d9a2c>] (ac100_rtc_irq+0x38/0xc8)
[<c04d9a2c>] (ac100_rtc_irq) from [<c015ed34>] (irq_thread_fn+0x1c/0x54)
[<c015ed34>] (irq_thread_fn) from [<c015f040>] (irq_thread+0x14c/0x214)
[<c015f040>] (irq_thread) from [<c0138f14>] (kthread+0x120/0x150)
[<c0138f14>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)

Solve both issues by moving to
devm_rtc_allocate_device()/rtc_register_device()

Reported-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ac100.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -567,6 +567,12 @@ static int ac100_rtc_probe(struct platfo
 		return chip->irq;
 	}
 
+	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(chip->rtc))
+		return PTR_ERR(chip->rtc);
+
+	chip->rtc->ops = &ac100_rtc_ops;
+
 	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, NULL,
 					ac100_rtc_irq,
 					IRQF_SHARED | IRQF_ONESHOT,
@@ -586,17 +592,16 @@ static int ac100_rtc_probe(struct platfo
 	/* clear counter alarm pending interrupts */
 	regmap_write(chip->regmap, AC100_ALM_INT_STA, AC100_ALM_INT_ENABLE);
 
-	chip->rtc = devm_rtc_device_register(&pdev->dev, "rtc-ac100",
-					     &ac100_rtc_ops, THIS_MODULE);
-	if (IS_ERR(chip->rtc)) {
-		dev_err(&pdev->dev, "unable to register device\n");
-		return PTR_ERR(chip->rtc);
-	}
-
 	ret = ac100_rtc_register_clks(chip);
 	if (ret)
 		return ret;
 
+	ret = rtc_register_device(chip->rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register device\n");
+		return ret;
+	}
+
 	dev_info(&pdev->dev, "RTC enabled\n");
 
 	return 0;
