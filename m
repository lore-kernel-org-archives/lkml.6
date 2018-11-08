Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF25ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875A12089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjIsRNRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875A12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeKIHuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbeKIHr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E99208A3;
        Thu,  8 Nov 2018 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714997;
        bh=x90ORX4s+u52P4dF98f/FM1dr+Gkw4qq6ZklxNeWG8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjIsRNRIdqHelBByq86jYduS4C4AC+jzg9JSMjW8yoL6r53Ka0kGVVj24yEkL06mm
         TlzDD7FXPccKDwXkPnyfD8MYxWbN4YXWlNVeLpOPKpH+Pzp9xjK1yNvUMNzZvR5izj
         JfEhDUE9qEuECEBKex0xwnEmVZ5l9K/yvx0CTa4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: [PATCH 4.18 20/34] usb: roles: intel_xhci: Fix Unbalanced pm_runtime_enable
Date:   Thu,  8 Nov 2018 13:52:49 -0800
Message-Id: <20181108215140.176881646@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

commit 009b1948e153ae448f62f1887e2b58d0e05db51b upstream.

Add missing pm_runtime_disable() to remove(), in order to avoid
an Unbalanced pm_runtime_enable when the module is removed and
re-probed.

Error log:
root@intel-corei7-64:~# modprobe -r intel_xhci_usb_role_switch
root@intel-corei7-64:~# modprobe intel_xhci_usb_role_switch
intel_xhci_usb_sw intel_xhci_usb_sw: Unbalanced pm_runtime_enable!

Fixes: cb2968468605 (usb: roles: intel_xhci: Enable runtime PM)
Cc: <stable@vger.kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/roles/intel-xhci-usb-role-switch.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -161,6 +161,8 @@ static int intel_xhci_usb_remove(struct
 {
 	struct intel_xhci_usb_data *data = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	usb_role_switch_unregister(data->role_sw);
 	return 0;
 }


