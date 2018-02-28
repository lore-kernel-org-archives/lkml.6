Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeB1NHx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:07:53 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:43055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeB1NHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:07:51 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH v4 0/3] pci: endpoint: Fix double free in pci_epf_create()
Date: Wed, 28 Feb 2018 14:07:16 +0100
Message-Id: <20180228130719.31218-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:SqhKdHUopVWtKJRM0RDI8WhbDAV3gph4n+/65cX2WeAT3A12dIY
 zOyndKnrJnCYygLrUmJK+lrJx5kjPM02zsmzclIW5iqf76WS86uRh4r71n3CpAFykEKPhbJ
 VC8Awaj0gyJHLeSPi+CdDv/UKC1dMZcIkR5r3Nz23VzrNszZJfo7wEQs7/KB/WQkfs/RrZn
 jywF1YCtKOIzi5cj7sdzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dPj4wDhfWmM=:1lqv0LvJ41QLfj4f8k5dxk
 aUo9V8Xm0p2ZKN6t59PGR6TbmZCfRm2q5Ygn9wH49glV6OKyBmOc6yOH6YG/eGolbqpaQkDeJ
 oo8SJ2iWXezwnd00tgcUyIMfjQUgFGXPbJuNrFvGCpSoWKlgtpVb245OAWuv26uA/y3TD0/yP
 qfKCec7spH01o8nn+7EOjHG6kxnKfArP3tZeHAbPz+VfoCI3u3ez4Ove/gyiqQrlbEoLziCUh
 wbT4mWcPjImFTvSLYc/tQywiX/Zmpd2EGITW2a+jkibtY4cfvgT0YTblRJfu0FIGwM8U/Ka4c
 jHFzLd9yX5uptyU867AQh8C7mG/1TDkLCoDb1WWu27bHhKz8oVQZFSvcuhW+1Uw3JOaM5Hxyh
 NdKFAj9wcfE1sdv5AG5MmYRFRM5vL0yNBmlqFRRp+W9d+YKVRUjZS6dJ0WhuhWqnID7hQOu1N
 98E359m6/dzwxrIIPU0Zm3wjWEAaUwruk1kVBWzWeay+CGdoh4bJLlwnNWF8g4mgYVU/+xO1o
 6Yo4gBPTqZ1TN3+28yEFNctixwj9y/jmR31+MtlccMw5B0TYkVbcaF3vfEiWamgjHqYzimEPI
 hpxwrHzxaPFwXAGalSmBi7XkMtEBNA2f7W6zVDJpk11f/W2mWwa1kxMdkfMldggn+8ZMJwG7e
 cwd51jMf8rULfcHreWvIQjPoVujeNdQav0LE4gnggL9tVU1XCLuu2QzXR6g6CueCr6sYNsP7V
 2own1ss7OtarhaDRH8VNr2Nu0tyihSWZN0hk4A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 4 of a patchset to avoid double free in function
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
have been changed.

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

 drivers/pci/endpoint/pci-epf-core.c | 50 +++++++++----------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

-- 
2.16.2
