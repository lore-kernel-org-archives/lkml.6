Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591852-2-4150357691656158394
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
    t=1517591851; b=Y1gMlxNrl+1RIWVN7w5xkioA3vcKgD+gA67EeNWBlyGEwp0
    GA8CQ0ahlafS1/rqGxM+dBolGEmnyqvqUhKZJlS0dEOy44EdtwKWVmY5LGw18p0n
    BjJ6WzvUiazaRZ2pxeTCKUFINBetXbAmjnVexy7VsAbxbhQT7rmRsxN4/PUYJ3cU
    m+RyBzH1DmcWyz/T5LeY5b94Ol56ms4w/c/zTMKVg6zqST0AMkfMms+R2yrdZ4xl
    8hIZoxqdeF+hNzpX649jx+iaZ85lfG1Pt/KGyD9NUh7HOf5VgNx0Fc6I5Xv8CjUl
    ZrigWyEmb9PA68as0mclFAmOuUAAEc6WzmvnGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591851; bh=4nroiMDPYT1kvOF3vgho7GHUWL
    BRi+f+pd+XPjWnO0s=; b=R23qqob46wJLC1VW0P7ooUJIc5YH2Xf256r5B51EJ/
    Ltk0qIlW/dU7XFhxv89kZPREcVqZWyLxqnJ/dWW58NPtJXW6q5vdUVOX9hwqD3rZ
    6dukgi8MQ+0j2QFtr8UkZBkb81BowX7QRv8zRxoqAbb5nACkV7paefM0B2GZ8S6r
    OrdSCuN5QSZcrIls+XwHkjgtTc0g1PDpAPUzxk0s3ZVu612b/uIvYHnzxMAbipC3
    dQeol4c3CeND/aJVHLvnpinLFT7Wv3zGTHp6cd4jZrCQIhOLUX5yC7ixnn7TrIp3
    jjJ0ibo7ksEVdI+6T7tBrUiL0B7vcBl4ILZCTwT3m4aQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbeBBRR0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:17:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeBBRRX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:17:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.15 54/55] Input: synaptics-rmi4 - do not delete interrupt memory too early
Date: Fri,  2 Feb 2018 17:59:12 +0100
Message-Id: <20180202140831.259749651@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit a1ab69021a584d952e6548a44b93760547b1b6b5 upstream.

We want to free memory reserved for interrupt mask handling only after we
free functions, as function drivers might want to mask interrupts. This is
needed for the followup patch to the F03 that would implement unmasking and
masking interrupts from the serio pass-through port open() and close()
methods.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_driver.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -41,6 +41,13 @@ void rmi_free_function_list(struct rmi_d
 
 	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
 
+	/* Doing it in the reverse order so F01 will be removed last */
+	list_for_each_entry_safe_reverse(fn, tmp,
+					 &data->function_list, node) {
+		list_del(&fn->node);
+		rmi_unregister_function(fn);
+	}
+
 	devm_kfree(&rmi_dev->dev, data->irq_memory);
 	data->irq_memory = NULL;
 	data->irq_status = NULL;
@@ -50,13 +57,6 @@ void rmi_free_function_list(struct rmi_d
 
 	data->f01_container = NULL;
 	data->f34_container = NULL;
-
-	/* Doing it in the reverse order so F01 will be removed last */
-	list_for_each_entry_safe_reverse(fn, tmp,
-					 &data->function_list, node) {
-		list_del(&fn->node);
-		rmi_unregister_function(fn);
-	}
 }
 
 static int reset_one_function(struct rmi_function *fn)
