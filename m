Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518720257-2-1441895883440958638
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720257; b=PAdSBeFgigy9/KY3zNTnmSp9I2+broX9DB3xD584PZQ3GUw
    Vjv45RNiRp8fj+U3p1ItwMfeD5kR8uDmzeP4ojNT3bpBAup/Ke7G5crlig/VdyzL
    Dl27o5itdb32axpUz6afau8UplmA1mfUyn72Hjnt3eNs3ZwWhE2Q0M+LqpYGR7uA
    3i3pcg3Ys55fIsK8s0q4pZbku61F7sKimUqIXvqMLlwqBX5ClJT34fiP2G14qZdr
    48+c614ioQSD9FWXwtTBTBXne3cUiYzX/oB5YCt7dR1pXQM9OUGOmwANdy/j9weL
    O4/x9iK5JukFCQmYes69z+Fy6XvYFuGFd41lu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720257; bh=VHpQ6VUKTCiHrZV2aV6z3vvfy9
    /kk+AUWxeF6fclyRA=; b=SPqrszmdasmR6Q+xko/1l8oq3RfMTuKI2rgfS4msGA
    tDzftwlDBi0vB3GpKh9JLegUVocmdwe9Ab/3Tu2FHuh1Ilsg+JDSz/Avg1iyPz5F
    3RShPcsV3GmZnevEaT0Vnv2JWXF2HMdwW25f8yhgYe91bXQ6sfPQ5wc7AhwnhmM/
    S5R6pbem6S2sQ7KvlhjP74AKwojzO1LHUL+rLC7Vx/jpck9YIPEQtaUf1skGPjQI
    1+kpx3G98KpcZPOdDj9koCW9ei9wotVV0lRcHF1k4+Qhf4OHqJqoaXPDAND7+6mx
    fQ8h52ElGg0faaQJAxTvTsa7Y8eibVJPHunM3FKXuOmA==
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
        id S1162593AbeBOPXM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161910AbeBOPXJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4.4 016/108] powerpc/64s: Allow control of RFI flush via debugfs
Date: Thu, 15 Feb 2018 16:16:13 +0100
Message-Id: <20180215151224.849053614@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 236003e6b5443c45c18e613d2b0d776a9f87540e upstream.

Expose the state of the RFI flush (enabled/disabled) via debugfs, and
allow it to be enabled/disabled at runtime.

eg: $ cat /sys/kernel/debug/powerpc/rfi_flush
    1
    $ echo 0 > /sys/kernel/debug/powerpc/rfi_flush
    $ cat /sys/kernel/debug/powerpc/rfi_flush
    0

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/setup_64.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -38,6 +38,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memory.h>
 #include <linux/nmi.h>
+#include <linux/debugfs.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -935,6 +936,35 @@ void __init setup_rfi_flush(enum l1d_flu
 		rfi_flush_enable(enable);
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int rfi_flush_set(void *data, u64 val)
+{
+	if (val == 1)
+		rfi_flush_enable(true);
+	else if (val == 0)
+		rfi_flush_enable(false);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rfi_flush_get(void *data, u64 *val)
+{
+	*val = rfi_flush ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
+
+static __init int rfi_flush_debugfs_init(void)
+{
+	debugfs_create_file("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
+	return 0;
+}
+device_initcall(rfi_flush_debugfs_init);
+#endif
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (rfi_flush)
