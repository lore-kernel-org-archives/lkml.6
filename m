Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710098-2-1482669188698669820
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710097; b=oRet0jdnYyCNHRdKX2iU3w++sks7idMOMVPmGmOxHDwfbNt
    gQiJR3HYJ9QXUD74+jSRNFGHL1EsoMfC++2Tmf5LRYqhgpmesGV8Q+oB806O05Ct
    4u1QQh107IxvOBi8BmoN3YTbBnCS5AP1inUyhOY5CX/6OwB+Mrcpj763/HIJk7YG
    CkkdyxvZi9mSj3ZbI9ukuLSbn5//56XXZTPeHvs9bBsGVmyEqFiLlQrNL3jZ6AM0
    rzG0Dcjc3BMcvK3b7eZ5rNXsw1pIrqXIwlRKKeZ2VbxpnQpU/jmH4EdiuCrI9oHt
    f2VhRYAdFiLz9kzBmEYTQpNSaiWGrObSzpkQq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710097; bh=YKHIOaHkwxrIl+iRVMJ25ovlju
    Rj41F6nnJo1y/dGWc=; b=I2dmvstPgEXmlQDOzKU+YZNl69+TVpT/CLn4b2eswd
    Kr6C3Afko1oUUlAPH6j99UJt5LqORyU/LgI7daHYoYDH8bvD6PjVNuP5i1Txct0D
    j1sQxg5zWeUTDjd8IK/QTKSLWgVPxmJ1Ysia8W4N+UEclkLHAu6ToMek6CfGD7rf
    FW9QGsIrvxUQ/9Pd2BPd9hSQcrgHa13ZxwsBG17gK/s+BMpzEcae+aHa9Gu9ZgdP
    06LQvPXO+pmLY5UOudYJJeCSzWqWv5ugOHJgtg+zh5GxXUiYKuERhu+YR7IygUo+
    QuX01156adwTV0ziWKcKbarPSeJFHIDvUInJOUp2DPNw==
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
        id S1424887AbeBOPr0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424880AbeBOPrX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.15 191/202] acpi, nfit: fix register dimm error handling
Date: Thu, 15 Feb 2018 16:18:11 +0100
Message-Id: <20180215151722.728109974@linuxfoundation.org>
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

From: Toshi Kani <toshi.kani@hpe.com>

commit 23fbd7c70aec7600e3227eb24259fc55bf6e4881 upstream.

A NULL pointer reference kernel bug was observed when
acpi_nfit_add_dimm() called in acpi_nfit_register_dimms() failed. This
error path does not set nfit_mem->nvdimm, but the 2nd
list_for_each_entry() loop in the function assumes it's always set. Add
a check to nfit_mem->nvdimm.

Fixes: ba9c8dd3c222 ("acpi, nfit: add dimm device notification support")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1867,6 +1867,9 @@ static int acpi_nfit_register_dimms(stru
 		struct kernfs_node *nfit_kernfs;
 
 		nvdimm = nfit_mem->nvdimm;
+		if (!nvdimm)
+			continue;
+
 		nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
 		if (nfit_kernfs)
 			nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,
