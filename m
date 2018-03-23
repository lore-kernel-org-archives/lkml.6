Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802615-2-4411042161434174432
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
    t=1521802614; b=CpYO9ZSjX6XKHrAqw4FQMCmgnBlNFV8X0GG7DEBy0Lz9QKi
    l0OkDzJ9kcHf6KpKAJcw+3VW01t2z3Njv5KrnRV6xwlV0g8anwBKL7ZNCQpNTuN7
    6rbBp4Ye1cqGCsanr2nogpLvWQ5dZ1TzmIn+95sT+A7eRFUns8yvTF1Yu6ch0rZA
    2fyTkNLmwOhUJMK9ziwWojiIODzzioAUcHCrw8c/b0cKmYf1QSB2LVggryQCV8MU
    K8UPJEEjrKT5UL8DdL5q0Hjx/DW/XAucwxlewdgwfT6tOz3o/5shrGDVErdaBq72
    woJv/eS0jSBkudVHdCGYYr5alKZXJRds4ijFvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802614; bh=cZMVUCn0AfbNwtCJcM16ZjVQYJ
    rjcGecBrgMS3KtoEY=; b=GMoK2qoaUTxi6PKXuI6o10M93ogntJKu5l0LRbFks4
    BKXLYr5vGst3Y7u/V35Cq9kOgetPPoCChEc2mV0s1A6OcnC/2BrusaMEhSHb+ohN
    D2eZqnjazGQLGiSdyaIULKRS0yrLHew/6WDj2XCdT1f9A/9NJKCFMpHwP9ADcfRn
    pkHl8V81eJQPEJM1tw0lDdo55wimnMSyJlSAQch6dRLnMWjPd8gzrJDS91Czy82a
    WL3cqBx4crKXXkDQdipytm5kyRtyGbLcamnJb9J8rHDElQhtUClYZxGh+WJt/pjO
    gKIuRcvKuN5rQ2uyTk4AcgvS0T2uaCQtNh311GWle2fw==
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
        id S1755613AbeCWKNE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44542 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbeCWKM7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Boone <jeremy.boone@nccgroup.trust>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.4 01/97] tpm: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri, 23 Mar 2018 10:53:48 +0100
Message-Id: <20180323094157.619109611@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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
@@ -1040,6 +1040,11 @@ int tpm_get_random(u32 chip_num, u8 *out
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
@@ -622,6 +622,11 @@ static int tpm2_unseal_cmd(struct tpm_ch
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
@@ -629,6 +634,7 @@ static int tpm2_unseal_cmd(struct tpm_ch
 		payload->migratable = data[data_len - 1];
 	}
 
+out:
 	tpm_buf_destroy(&buf);
 	return rc;
 }
