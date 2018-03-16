Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214302-2-7427771548035841481
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
    t=1521214301; b=EG/0HIlwAZJt12LbVehrfjPKMfgno5t8EqFEo6zY0FyzGJe
    A3kn8kPGBpVj0TWLppXGY/28qAgJIdQ08DO0bbAbiwz0oYk+r1SNfLp2nzcPcUn3
    tgIkQcMWwqc/RdZwuz0Ho+g4RlkXWAu1vuc3plgiStlWB44rHTGocc1/1qwK7ouN
    v7Nv1KTuS5jlkQP0nUhQqp8RArBnOAARmLliLQgEbBfrBddRPS4Zo8FvDzxAvWJB
    3WgopdZg0nEw0JQ2YRgQ5GZXVOlVMUACGYhypTcGV1gsrkztJ1VgLKytL3wHfT6Z
    rorFXYY3OgjDeoPrfAAjYr3dbiLrhLdUifkHJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214301; bh=sj3nTBJbWXbaDhfr5fbTPGQ3dq
    gVDD9ZQNpdNGcZx4E=; b=ACkCnsBnhO4DkgxJNfAU3LgeFmTGuQe/aV2vL4vsAr
    wgTWG4Y+925+xKC/UHZy0zIy6qRrcXbD4ORvdlZcW4XHjxARb7n7pQ2ykkgOXC44
    Ab4JVRfQkuPfpL1NE9qTuYbmJ2fSlRKVYzpu6buKlgk5CdnTMwapRXEUNAVbLBKU
    YgGcOkpG0E98nVJmy3GIyPBm9XC8udYsWso3ljilW4VvrQoALhwiyOcyEgQ0Rx2y
    jfa36QF3uTqzf/U35KBeNBlpUpMlnXtcUmb47hug6y/Q6kaYh4IRXJ2W/KLQXyO7
    EVrBu3outCHycssHGGR7t5eCjBDYmMolzzMI6n25sliA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S933414AbeCPPbi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:31:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933410AbeCPPbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:31:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>
Subject: [PATCH 4.9 12/86] drm/amdgpu: Notify sbios device ready before send request
Date: Fri, 16 Mar 2018 16:22:35 +0100
Message-Id: <20180316152318.128741687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
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
@@ -540,6 +540,9 @@ int amdgpu_acpi_pcie_performance_request
 	size_t size;
 	u32 retry = 3;
 
+	if (amdgpu_acpi_pcie_notify_device_ready(adev))
+		return -EINVAL;
+
 	/* Get the device handle */
 	handle = ACPI_HANDLE(&adev->pdev->dev);
 	if (!handle)
