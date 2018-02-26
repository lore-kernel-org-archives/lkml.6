Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676384-2-721455027299911383
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
    t=1519676384; b=qrzTqT/SBd8v53CtHkU4EQdJB5h1xWQMdC+A3IOt/iOC+gJ
    PnA0L2SuNd5BgS/xtZBHshMJWLIZMrHpXiYVhbCW2+5spXmdiN0BcA+OrC3xtGRb
    Q1ickeqqTcsGPPJPz5FEgE716nOdWyyrlEhf+eGbRsg8bYAIJWLmNfgzyJNvdZoN
    znXAYkeIptuDnAQY2spJKhiDs6feWp9aLFpPas/3pa7g2OmhZ5F0njJVYRn03kjc
    SFp9IL/eIJKwDKrRvAxRk3u4Pk+pl+tersRDSn1QkOIEkobdVTQEstYlaufsX59E
    WG4uyvN0LcMZkT0lNez07Ck1FPxV27VBKgBbbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676384; bh=jTKtLkPItEVLAjTaMDy0w0TeQF
    zQQ7sT5zXHli8ah90=; b=rzgisUi7jrcK5kNoRGYkEDx8H6IdBYYxsczarIa8a1
    F/0WcB2+S5qORhoC+IwYbatXbHVxiYh7i/T6VOxhi8P2REW+526R6zcH+Nf5l3tF
    tbAnwHlhT2G4CaKkMRA7+i3jaMdtenqgMr7PcvfDH4aBk3J3A1DL2NZz9TadvJ7Q
    S1+436DRkyU+N2T8q1QfhWjjIZUWivOLL4/CjwpCd52YSU1427f9HDWAImmMe6l/
    koZtHWSKt1XuAVAu8cV6fCVPSXXhcwQn6ZAgr+UHOihc3C+2MbnWEzx8f7fjY3WT
    smzZeabpIhxNN2JA6UH9M8pyhYLwn5JQLxaLgGroaieg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBZURO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZURL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.4 21/22] drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)
Date: Mon, 26 Feb 2018 21:16:21 +0100
Message-Id: <20180226201559.658971149@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1467,8 +1467,6 @@ int amdgpu_device_init(struct amdgpu_dev
 	 * ignore it */
 	vga_client_register(adev->pdev, adev, NULL, amdgpu_vga_set_decode);
 
-	if (amdgpu_runtime_pm == 1)
-		runtime = true;
 	if (amdgpu_device_is_px(ddev))
 		runtime = true;
 	vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, runtime);
