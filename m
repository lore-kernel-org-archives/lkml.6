Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221623-2-18417021642230254859
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
    t=1521221623; b=TPQMTbJ3822MSX17WZOsmt38KWdHJSiIiPTz/6dxw78NhWg
    vOXxiqhpX3zaL5cAPJqqR7c99HwCDg3rmylQNSAKv+rXv3T9YbcZ4sWPSXE4b124
    IHa8beUz0LzJtVFtUPdMaczpj6oIPBxHwZK+t8XOv5px0JibJ4Vebvj5UJxMwZYP
    kBRNiSqr11gPSqDOQFUPAhyqQQvjn1WX2R+la7PaEaXIJDzuaDsVzeIrCUjNEza2
    uUzbqVuR8S5dAm+W2P+pM6LYo1h02Av6MqwIfuookXNMmkAV/Amth4uxWz2WBQGC
    7ONTgxLR7gPG8ns4ariJddVxoy486D5cu2dWabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221623; bh=tsiAnsg+W7/cjok5Aanrq3dcE3
    lifnktOWnWeMtKik4=; b=Hu8A4vYIPqxbXQWah7MtYL1PegTIK3TaIuMb7Sr5rm
    oPkLly32V3jsZdKq9jGUMZnbPj7RT6fO0ClKN2E8zbrFi5trL1y8BO7LwY41bXnG
    KEt8nkDOr+MupgXw86lSDXWX1SJeWRYq0xR9UzfM5ojxI4VKghYaVenE2SZLbfVo
    EYD2bG/p3qkAwNaaAyo0iExAewWl3zqMyZtEhO55UdCDr52vG+znT/Pevd2/EFwf
    D1IchzLaeVkPRQGcwW9b4tTbR3Prpmdy9vF6EZTxJj3vKqax0l2CU1tBN8MVAEQQ
    wnyQtdgOJ8I4j4ZF38aO8nOlf0/zLGjeQGRXRi8iAHkw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S932217AbeCPRd0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:33:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932573AbeCPP1P (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>
Subject: [PATCH 4.4 10/63] drm/amdgpu: Notify sbios device ready before send request
Date: Fri, 16 Mar 2018 16:22:42 +0100
Message-Id: <20180316152301.225170299@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
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

From: Rex Zhu <Rex.Zhu@amd.com>

commit 1bced75f4ab04bec55aecb57d99435dc6d0ae5a0 upstream.

it is required if a platform supports PCIe root complex
core voltage reduction. After receiving this notification,
SBIOS can apply default PCIe root complex power policy.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -585,6 +585,9 @@ int amdgpu_acpi_pcie_performance_request
 	size_t size;
 	u32 retry = 3;
 
+	if (amdgpu_acpi_pcie_notify_device_ready(adev))
+		return -EINVAL;
+
 	/* Get the device handle */
 	handle = ACPI_HANDLE(&adev->pdev->dev);
 	if (!handle)
