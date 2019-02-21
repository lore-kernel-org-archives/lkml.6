Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B3EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE122084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760105;
	bh=OuZX+FrCUKxRcsNjEz02N06tGEEpJYuJl6TRoDfB4xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JAGKYiKkfhVeSAFrqLVyIS93HgwU4l3ub1sRg26UQ0lFoOAbbx2zfAJdz6h1KPcyY
	 yz7Fvy5g+MwPd2nf4e+roSDtcpKSM2to6pypT87ELjDDdmHiAUVMMYlXvHtkbIYbu5
	 WG+2ZebdVbuf5l7cBBm9fFczEi5fN/0eICvMc80c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfBUOlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbfBUOli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:41:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29E12084F;
        Thu, 21 Feb 2019 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760097;
        bh=OuZX+FrCUKxRcsNjEz02N06tGEEpJYuJl6TRoDfB4xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xf58rwwSvBFYb0x5ne0RL/8IDX2u3tZLl1IOMfo8UZFYx/E7jfE2mnpunPutTrYVN
         LwHmCE8lN+lu3SLgECGC4KP8gWH5LbW0cFqtkvjZDawj0+3z5AqxwV+w4ZdSTNNZJc
         0eoflR9aiG6BLVttgez8TOP1ujibcStZgAFbtYdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.19 25/30] PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter
Date:   Thu, 21 Feb 2019 15:36:07 +0100
Message-Id: <20190221125252.000358199@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Logan Gunthorpe <logang@deltatee.com>

commit d2fd6e81912a665993b24dcdc1c1384a42a54f7e upstream.

The disable_acs_redir parameter stores a pointer to the string passed to
pci_setup().  However, the string passed to PCI setup is actually a
temporary copy allocated in static __initdata memory.  After init, once the
memory is freed, it is no longer valid to reference this pointer.

This bug was noticed in v5.0-rc1 after a change in commit c5eb1190074c
("PCI / PM: Allow runtime PM without callback functions") caused
pci_disable_acs_redir() to be called during shutdown which manifested
as an unable to handle kernel paging request at:

  RIP: 0010:pci_enable_acs+0x3f/0x1e0
  Call Trace:
     pci_restore_state.part.44+0x159/0x3c0
     pci_restore_standard_config+0x33/0x40
     pci_pm_runtime_resume+0x2b/0xd0
     ? pci_restore_standard_config+0x40/0x40
     __rpm_callback+0xbc/0x1b0
     rpm_callback+0x1f/0x70
     ? pci_restore_standard_config+0x40/0x40
      rpm_resume+0x4f9/0x710
     ? pci_conf1_read+0xb6/0xf0
     ? pci_conf1_write+0xb2/0xe0
     __pm_runtime_resume+0x47/0x70
     pci_device_shutdown+0x1e/0x60
     device_shutdown+0x14a/0x1f0
     kernel_restart+0xe/0x50
     __do_sys_reboot+0x1ee/0x210
     ? __fput+0x144/0x1d0
     do_writev+0x5e/0xf0
     ? do_writev+0x5e/0xf0
     do_syscall_64+0x48/0xf0
     entry_SYSCALL_64_after_hwframe+0x44/0xa9

It was also likely possible to trigger this bug when hotplugging PCI
devices.

To fix this, instead of storing a pointer, we use kstrdup() to copy the
disable_acs_redir_param to its own buffer which will never be freed.

Fixes: aaca43fda742 ("PCI: Add "pci=disable_acs_redir=" parameter for peer-to-peer support")
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6113,7 +6113,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
-				disable_acs_redir_param = str + 18;
+				disable_acs_redir_param =
+					kstrdup(str + 18, GFP_KERNEL);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);


