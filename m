Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750861AbeEaXud (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 19:50:33 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59074 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbeEaXu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 19:50:28 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 31 May 2018 17:50:07 -0600
Message-Id: <20180531235010.5279-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, sbates@raithlin.com, hch@lst.de, bhelgaas@google.com, corbet@lwn.net, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, marc.zyngier@arm.com, kai.heng.feng@canonical.com, mingo@kernel.org, frederic@kernel.org, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/3] Add parameter for disabling ACS redirection for P2P
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As discussed in our PCI P2PDMA series, we'd like to add a kernel
parameter for selectively disabling ACS redirection for select
bridges. Seeing this turned out to be a small series in itself, we've
decided to send this separately from the P2P work.

This series generalizes the code already done for the resource_alignment
option that already exists. The first patch creates a helper function
to match PCI devices against strings based on the code that already
existed in pci_specified_resource_alignment().

The second patch expands the new helper to optionally take a path of
PCI devfns. This is to address Alex's renumbering concern when using
simple bus-devfns. The implementation is essentially how he described it and
similar to the Intel VT-d spec (Section 8.3.1).

The final patch adds the disable_acs_redir kernel parameter which takes
a list of PCI devices and will disable the ACS P2P Request Redirect,
ACS P2P Completion Redirect and ACS P2P Egress Control bits for the
selected devices. This allows P2P traffic between selected bridges and
seeing it's done at boot, before IOMMU group creating the IOMMU groups
will be created correctly based on the bits.

Thanks,

Logan

--

Changes since v1:

* Reworked pci_dev_str_match_path using strrchr as suggested by Alex
* Collected Christian's Acks

--

Logan Gunthorpe (3):
  PCI: Make specifying PCI devices in kernel parameters reusable
  PCI: Allow specifying devices using a base bus and path of devfns
  PCI: Introduce the disable_acs_redir parameter

 Documentation/admin-guide/kernel-parameters.txt |  39 ++-
 drivers/pci/pci.c                               | 353 ++++++++++++++++++++----
 2 files changed, 331 insertions(+), 61 deletions(-)

--
2.11.0
