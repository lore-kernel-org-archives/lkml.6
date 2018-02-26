Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676940-5-2161166504780845711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676940; b=kl/wtYjrmhIH/hlKrg6JF9kjB53+ajqJRexndxqcKeEINbs
    1jnbbErnG/wjlqUTCV/afqc8vB9rrFV2j/pyORI10LzC6JxvzFPrsFl5Qx4D4Y9j
    Jq2lxrRUEtNjwGvoHTC+z3XH9AIMOzQbUBKlMN5/EICHHc4MHWJU56YUkSuVCphn
    xV2mjg5XaAOvvHhYlMEqpdtMZResOf2zQi3q65LSGrN+s9dfQYhp1Vs8W9ydRpZf
    MrT00R7xiRGdlwRQGX5BiQ88Vv4b6sKC2kTKaylOo+1u3dal1Ur9vHGI5ZD5JNYW
    uBd1bwd3c7i3DfTpSU/lFrVTI1QNdJwjiB3QMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676940; bh=i7Ea4lP1I3Qus2sVjwQi+gDOYc
    I8lmbVfiXcVvRDFNQ=; b=SnMm6CqA2mA/oAkRldP/uj+Xdq3Da6FzqWAb0LSiom
    5z7Si562Yw0rHLd86tnLjLiUO3oP1L/axFUpIVNuwHEPirJpCNfYomiV9714TjYr
    tH9ATp7/FLOgS182ARWwAmWsBsExEnG1fPFVALKiC8As9f1NRxHQIrB/rhceovwy
    8ixbCeSioQGoTLHY6I7FuSdbyVfX2b8NoqRWT73s2JUOAm5zAW4Va9mrLcLgCCTy
    Uqx0Nu95S4x3qOX7Fjb1eDtVk1jrLCLJyLHPzsyUpfRWIKLrGu6u0iMKhLlYhymj
    fnB4/vjLeS8flBjpK8DCo4YJ191c6g8vHgzDxN4AFd4g==
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
        id S1753567AbeBZU25 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:28:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeBZU2y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:28:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 61/64] drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)
Date: Mon, 26 Feb 2018 21:22:38 +0100
Message-Id: <20180226202156.052750985@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit 458d876eb869d5a88b53074c6c271b8b9adc0f07 upstream.

We only support vga_switcheroo and runtime pm on PX/HG systems
so forcing runpm to 1 doesn't do anything useful anyway.

Only call vga_switcheroo_init_domain_pm_ops() for PX/HG so
that the cleanup path is correct as well.  This mirrors what
radeon does as well.

v2: rework the patch originally sent by Lukas (Alex)

Acked-by: Lukas Wunner <lukas@wunner.de>
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de> (v1)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2228,8 +2228,6 @@ int amdgpu_device_init(struct amdgpu_dev
 	 * ignore it */
 	vga_client_register(adev->pdev, adev, NULL, amdgpu_vga_set_decode);
 
-	if (amdgpu_runtime_pm == 1)
-		runtime = true;
 	if (amdgpu_device_is_px(ddev))
 		runtime = true;
 	if (!pci_is_thunderbolt_attached(adev->pdev))
