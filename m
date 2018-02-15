Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518711236-2-4537304146987311251
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
    t=1518711235; b=VW9gdwZsoKcXSRNUUylgb2r20FAy8CvNZCWOtJyDdvrYwvr
    YfpUBuKSwTt1j84qTQlmxRSPM0AY3i42mFBqIXTGou4F7PDWslZ6Vcxspyu3WFxZ
    7sKS/Qw399d8JnxHM2OqT7K+HRnr3ol+8NhnzDYok6SWZ2ui3TVo99npmro18cx6
    TNhNIdsfOJ4hsv/1FE74gsjZPz7AylsLIuaOKHKd1mceHq2lT5vlkQ+WEh7c7Q6g
    T6AxmSMPFX2z1AqLj9SU3xt8FtJDwQYVpr2g/d4+dh6Absh0EnCkXTOnBOoMeeiw
    pv+C0jLhSWIAec5yGuGTiz9yovtL1swi+Muj1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711235; bh=rNmUSKzhKM2eiiUjxhO4l6mPkf
    6NsrDu9zwzLwQWttw=; b=ZVHoF6us1fTCrkpGMtNzXvR87JR/RHF+86bKsCCeAE
    RLTDsvQfYgLiP27+/gy0YR1GYuUx+yIvbrYL1HRGMQQPGNsirThKnXI1uGI6JAgP
    8SmsTVbh2Gc0x0ApSn4/21Gj3209RUMg0KZXUNiS0bd+7oZFwkfYjowA2LcnfwLX
    ofxXKWcQcV7U55rQgzTTyYZ+J4XA3jgW+MwfiWOx4HF4pqlvtYIJFh1L6CbI4bEm
    3QpFWoSpA4/+aO4K5jvX4X3rOVPUBsdj4+RytSGNlZ6nS//SyEvdBLEgrnwYnQnz
    dFdYvfVXqz9A7LvaMrNYCXkzgcqZdO+U7FucX7ofbNoA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424355AbeBOPo5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:44:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033989AbeBOPo4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 139/202] ASoC: skl: Fix kernel warning due to zero NHTL entry
Date: Thu, 15 Feb 2018 16:17:19 +0100
Message-Id: <20180215151720.365039969@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 20a1ea2222e7cbf96e9bf8579362e971491e6aea upstream.

I got the following kernel warning when loading snd-soc-skl module on
Dell Latitude 7270 laptop:
 memremap attempted on mixed range 0x0000000000000000 size: 0x0
 WARNING: CPU: 0 PID: 484 at kernel/memremap.c:98 memremap+0x8a/0x180
 Call Trace:
  skl_nhlt_init+0x82/0xf0 [snd_soc_skl]
  skl_probe+0x2ee/0x7c0 [snd_soc_skl]
  ....

It seems that the machine doesn't support the SKL DSP gives the empty
NHLT entry, and it triggers the warning.  For avoiding it, let do the
zero check before calling memremap().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/skylake/skl-nhlt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -43,7 +43,8 @@ struct nhlt_acpi_table *skl_nhlt_init(st
 	obj = acpi_evaluate_dsm(handle, &osc_guid, 1, 1, NULL);
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-		nhlt_table = (struct nhlt_acpi_table *)
+		if (nhlt_ptr->length)
+			nhlt_table = (struct nhlt_acpi_table *)
 				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				MEMREMAP_WB);
 		ACPI_FREE(obj);
