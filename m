Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641288-2-15018155245477057908
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
    t=1520641288; b=pcVn3dL01oXktotraJBSEotREOY64q0ymxIBUkWtwfcBamH
    W6ddsvq5+6t00Bm28HAjOgyd2zpynmMRkr1lo278neBfUZvLVCtYGtRt6o+qIc9A
    rEa5ZD0Ph4C3HNfb7YB0ys00hYYAwf7QZ4XLYNsY4W1+GhnbDMQfyjNhSwa6b/K6
    thCwQ8TK/JFAgvy1hHK/u0ajHy04UKOn8GaoE8dfd8nyXcFJ9x+ErJe4DJimJBmG
    LnWUAuab02ws0lcQRHlWuGDJLvxkvyjLUdpSna+5V63g9HtE20UmR8E396zEGdgz
    QeLM41t1oqXHUs11XYhhLv+J0JD+ssjVxgIufbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641288; bh=UbgE/iWsXrmMMBk+Ns9kbWJ+p6
    LHSz0oHw54n16wCyQ=; b=e8HFbHwzDBdExhVV7D2TKmpVg4Tt/7t/g407k08UTI
    /HPpH20bQ3iJvssiWs6Ge/cK5AA1AE8kwwLgS9yBLg1lmUnfCshoFxHvsYAQ87F+
    1pD1UdzHdx5KhptDocj/6HpOqpV7ghMP0/Ad47QAsuxMup7v+TsI2WczihRpsaMp
    ya7Znn8Hz+fYsvOdoEZJDT2kgb1GR/QxeOcwboK4shA++MuD1tcrUju5HWS2RSWM
    w4tQcx3rvaOyBkaN0Esl8FCrwlJWQXf1gO0o3dCB2+AKjJ6UnKokzspFHqZYe8bm
    qaz3vieibVhQT37W53sPC0jmBJG79xqbwGu6bD6id3Ng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeCJAVX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:21:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933652AbeCJAVV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:21:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Boone <jeremy.boone@nccgroup.trust>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.9 02/65] tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:02 -0800
Message-Id: <20180310001825.134829486@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

commit 9b8cb28d7c62568a5916bdd7ea1c9176d7f8f2ed upstream.

Discrete TPMs are often connected over slow serial buses which, on
some platforms, can have glitches causing bit flips.  In all the
driver _recv() functions, we need to use a u32 to unmarshal the
response size, otherwise a bit flip of the 31st bit would cause the
expected variable to go negative, which would then try to read a huge
amount of data.  Also sanity check that the expected amount of data is
large enough for the TPM header.

Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_i2c_infineon.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -437,7 +437,8 @@ static int recv_data(struct tpm_chip *ch
 static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int size = 0;
-	int expected, status;
+	int status;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -452,7 +453,7 @@ static int tpm_tis_i2c_recv(struct tpm_c
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if ((size_t) expected > count) {
+	if (((size_t) expected > count) || (expected < TPM_HEADER_SIZE)) {
 		size = -EIO;
 		goto out;
 	}
