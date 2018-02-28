Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeB1Rcx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:32:53 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeB1Rcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:32:50 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH v5 0/3] pci: endpoint: Fix double free in pci_epf_create()
Date: Wed, 28 Feb 2018 18:32:17 +0100
Message-Id: <20180228173220.544-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:AUWFMIpi0MOKzKocbzqqf1ZTwQVkZmMxpEnMMYVvjhKLM6MlswH
 WZWxEPdwK6MdXemZYg/fDNgFA8chz+DIwCUaIJoIRY/KokeoRlY5KWPMMWCMqY+nAdXXTAi
 c6YZQU1BJNmLw5ZvixO5jGFcmkhQ9SlN8QFzJhGNGrH2Agd983Puf7jk4w5eIuwSP8C1C0G
 3e9mejvCDBmEm0KRBrxGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7SMsB7xM8WA=:G04F7DWLKtBJvVK5C+jxSS
 03XNKBuAZcTvINmAi05/T0w4nsEVWWGtzqAu28+glxUL1nfxTwUoz5KYBk7XzkUtnzrKVVPMd
 ABWT5FXw+Y9RGat0EbPamJT4gcFsuESOJZ2ypdifiPADRTGQ89eUr8PjXoWdUjpdplJwSR/Sx
 AvRMBU/uBXwAcOJ5zJeFlA38Y3RLt06fNLdoHdhYc2qD2qXgBov5Z2n3dnwBDJBlHO4fmg2S4
 2iZutt9ZY6d5dTWpTmCjj+Ps4t37IsQjkUaAaFAkJREwdER7Xov7SSLnzP4wSvNCYQnNQJr7u
 x1tKEQ1ptdhowar3cADsfMBmbS1iyWMiSLh25UTyt31EibAIok2f3/G/jGTEDITOX4l0D57WW
 6lLAhlUVLBTPbUmN5cD4KdDJxovpSldpghKlh5XyfummPHBjZVAsppW97gYWyTb/XpQGId/YF
 MhIPL0e/lnWvKeda0H+g3BCToqcXbWi2Q9fg0ihNfoftgsUeQUJRGQ8dxgNxtS5mxPNLDBs0Q
 u60uanfNCS46NvAXSVp5QcR1rL0trih5zR39dx4HWYl1mMMthnnRvf4SyXJ/tB3JuWtHSd17y
 wZ/SJNRc/DEu3eAcSCvkAWl/i+4z9ByCw1JMTQvwyKTmwl+irStQPb7vnG8t9osds9o+2Xdvd
 3f8/tCqT+tOmniObuvq/I9AgwrKVfB9uQVlmKzWkV5NXarfUhTY0f2mk7HUB6A7AbgPi9C9bG
 Q5Eg3b1CGJ9DczEUF2JnbFLh+LTc8JdjwZnbUA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 5 of a patchset to avoid double free in function
'pci_epf_create()'.

When I accidentally created a new endpoint device with an empty name,
the kernel warned about "attempted to be registered with empty name!"
and crashed afterwards.

It turned out that the crash was not caused by the 'device_add()'
function itself, but by a double kfree of 'epf->name' and 'epf'.

The first patch just simplifies the code, while the second patch
fixes the problem. The third patch removes the goto labels.

Thank you Andy and Kishon for your Ack/Review on v3 for patches 1 and 2.
In v4 of these patches only the first lines of the commit messages
have been changed. In v5 these two patches have not been changed.
Therefore the 'Acked-By'/'Reviewed-By' lines have been added. I hope
that's acceptable.

Changes in v5:
- Beautified the ugly part of Patch #3 (v4), where the correct return
  value was hidden under two levels of 'if'.

Changes in v4:
- s/pci/PCI and s/epf/EPF in the first line of
  recent commit messages (thanks, Bjorn!)
- The new patch #3 removes the goto labels
  in function 'pci_epf_create()' (thanks, Lorenzo!)

Changes in v3:
- Matched to other pending pci endpoint commits (thanks, Bjorn!)
- Added "Fixes" tag in patch 2 (thanks, Andy!)

Changes in v2:
- Based on feedback from Lorenzo, Andy and Kishon (thanks!)
- Change IDs removed
- First patch completely reworked in order to eliminate the
  need for the second 'kstrdup' allocation and the 'kfree' of
  the first allocation.
  It was tested with name="pci_epf_test.0" and name="pci_epb":
  The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).

Rolf Evers-Fischer (3):
  PCI: endpoint: Simplify name allocation for EPF device
  PCI: endpoint: Fix kernel panic after put_device()
  PCI: endpoint: pci_epf_create: remove goto labels

 drivers/pci/endpoint/pci-epf-core.c | 52 +++++++++++--------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

-- 
2.16.2
