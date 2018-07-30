Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9316256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2E420894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2E420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeG3Ryh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:54:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54542 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbeG3Ryg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:54:36 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fkAsk-0005Yu-7y; Mon, 30 Jul 2018 10:18:51 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fkAsb-0003aG-Tp; Mon, 30 Jul 2018 10:18:41 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 30 Jul 2018 10:18:36 -0600
Message-Id: <20180730161840.13733-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, sbates@raithlin.com, hch@lst.de, bhelgaas@google.com, corbet@lwn.net, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, marc.zyngier@arm.com, kai.heng.feng@canonical.com, mingo@kernel.org, frederic@kernel.org, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, willy@infradead.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v8 0/4] Add parameter for disabling ACS redirection for P2P
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
* Fixed order of operations for device specific disable function as
  noticed by Alex
* Rebased onto v4.18-rc5 (no conflicts)

Changes since v5:
* Add a quirk to handle the Intel SPT PCH case (as pointed out by Alex)
* Warn in the case that we try to disable ACS redirect on a device
  that doesn't have the ACS capability (also suggested by Alex)
* Collect reviewed-by tag from Alex
* Rebased onto v4.18-rc4 (no conflicts)

Changes since v4:
* Fixed a couple documentation mistakes spotted by Randy

Changes since v3:
* Removed some of the cruft that was copied from the resource_alignment
  paramater (per Alex)
* A number of docuemntation fixes as noticed by Alex and Willy

Changes since v2:
* Rebased onto v4.18-rc1 (no conflicts)
* Minor tweaks to the documentation per Andy
* Removed the "path:" prefix and use the path parsing code
  for simple devices (as it works the same). Per a suggestion from Alex

Changes since v1:
* Reworked pci_dev_str_match_path using strrchr as suggested by Alex
* Collected Christian's Acks


Logan Gunthorpe (4):
  PCI: Make specifying PCI devices in kernel parameters reusable
  PCI: Allow specifying devices using a base bus and path of devfns
  PCI: Introduce disable_acs_redir quirk
  PCI: Introduce the disable_acs_redir parameter

 Documentation/admin-guide/kernel-parameters.txt |  41 +++-
 drivers/pci/pci.c                               | 310 +++++++++++++++++++-----
 drivers/pci/quirks.c                            |  78 +++++-
 include/linux/pci.h                             |   5 +
 4 files changed, 361 insertions(+), 73 deletions(-)

--
2.11.0
