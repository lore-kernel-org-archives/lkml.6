Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799452-2-17471752585694982024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521799452; b=h1moDLSt8QCC8ZaVYu1Jxi1C8fsYtdmU0Vx56PDozKY0YAB
    3fYze/BSVhKu0rjPmQ1gNqrSClvxG2LcWPieFa1LbI553ZxGVegCBRAOCYRW/EwG
    X1mjwI3fAmmLyIFwFvyu4h3k1wyqhO43Qct6Jm/Br1iR2rXThqLnJgcREtPAviT1
    b7A6Q5kWRP2KT9W4+8YaGbK+RN2q2ay4b0JZCiDb8esjpjzFxwsISRQb/vtlOcHO
    3we4YwwzB9w+5PNHnM6GkOA6VH8YP+gpuI/gDGQXYfhEBsAsbe5QHgLmIKof8+xG
    +WkLl53eDDzu5L+peWLllqsKVKUOQJMpqQSx6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799452; bh=CwDNlmCH7HzmtCqbp5BFH6cu57
    21TGfaw1h5uK/d3vA=; b=QEcP7/wu5lO3ollwbsmCOEeFmeq468jyfbPfZDnIYA
    e1OWgRGnedNvr2YkDaNViaA/61CzYFwT8LvSVbyk6W1E0pZP1VjXQz6ljXJtSVRI
    +Sy5J9F6YtW2KYUEbJIkntMf0R0ANTL4myTwV9/u8BU+7A7LQ1bK5RMBC/4Vc2TS
    ecfCifPyuMtELCbBNMRSGvHEqKTqGFJi321NKHSW81reD9jmpVbQkyfAKD7pS+B3
    RSWq18t2KwjER8kwOKHt/qMbFQ1oacKKPIs9h8H+t21g18LRzyGXbobG4QXR02A2
    e9+IJUKhv3IQcp7XvKKxoD6+VTmugBTvpAJ7dgLk/a2w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1754604AbeCWKEJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbeCWKEI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Boone <jeremy.boone@nccgroup.trust>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.9 001/177] tpm: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri, 23 Mar 2018 10:52:09 +0100
Message-Id: <20180323094205.172538837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
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

commit 3be23274755ee85771270a23af7691dc9b3a95db upstream.

Discrete TPMs are often connected over slow serial buses which, on
some platforms, can have glitches causing bit flips.  If a bit does
flip it could cause an overrun if it's in one of the size parameters,
so sanity check that we're not overrunning the provided buffer when
doing a memcpy().

Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    5 +++++
 drivers/char/tpm/tpm2-cmd.c      |    6 ++++++
 2 files changed, 11 insertions(+)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1078,6 +1078,11 @@ int tpm_get_random(u32 chip_num, u8 *out
 			break;
 
 		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
+		if (recd > num_bytes) {
+			total = -EFAULT;
+			break;
+		}
+
 		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);
 
 		dest += recd;
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -668,6 +668,11 @@ static int tpm2_unseal_cmd(struct tpm_ch
 	if (!rc) {
 		data_len = be16_to_cpup(
 			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+			rc = -EFAULT;
+			goto out;
+		}
+
 		data = &buf.data[TPM_HEADER_SIZE + 6];
 
 		memcpy(payload->key, data, data_len - 1);
@@ -675,6 +680,7 @@ static int tpm2_unseal_cmd(struct tpm_ch
 		payload->migratable = data[data_len - 1];
 	}
 
+out:
 	tpm_buf_destroy(&buf);
 	return rc;
 }
