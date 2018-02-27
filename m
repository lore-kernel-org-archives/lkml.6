Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeB0KCy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:02:54 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:57537 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeB0KCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:02:52 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH v3 0/2] pci: endpoint: Fix double free in pci_epf_create()
Date: Tue, 27 Feb 2018 11:02:28 +0100
Message-Id: <20180227100231.22561-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:Pg2a6I7tuR5QGaPjxfdPmWw0HNIv+TzHMz65RDzssxvRUxWPV0Y
 MWUkyzd/COIOP9tqALrAI7414rlqcorR8ZmOHFd9p89lotDt7BpZMvSOL5KjBrb/Ow6fOky
 gvV5AoRrYfYq+retrz5LET0EReoL+t2EhFNDfVTi96tAe2Pz6nSANopuf1cOth1+d1cp4p9
 NafZYZ/KXW5LbQi6ZylWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rozk238EuIE=:JubCG/wUM7vzgIwowzVf12
 wIMqw83xktm51xBVML7T412dNUX30guU0yOkoHga9PJHsWymPru8n4+I+C0n0sldaM7KbYt1j
 WoV3OrzRwp2cPhxvdTtny2pFAtOM6ykolog6ZhAWVWGgYR2BA6LH20JRf+gfvxTavGfWBtDGL
 IzRf+A9wDgrgwg2MqQgkOdNm+WmEKBNYUpI1EIlqf2St2T4xU9LhHM++JUDw56fGohVgMfOPC
 Mea0/ZcI9KldNgPyjvf+aMUQgSNDtGxN26g0cd9KNW0iHJW9x/9r0rJyjDPXXXr3WdqdLQV2O
 Nz+u9c5dmVl+PifnUU8JTkalI0RqsXdldPOXUAaUUf5E0/fJ46WtEzHo4joeydEoTXKKRZLIr
 gWK6Sq2u0Rb12CxIU1JL06PRGvJZQsGsGXBar38U89yymg21U6uwCDVj5stYEhVbxHe7MWaK5
 VlCfazspV5F6P6TtCLkMsjwt6MKBuJGnFFQvjh5c+TejQg8TRZsYK2U8v7krXyhJPD2L7MQkE
 oRIlIF+I0o/oH8zeOuqR2ECBLnvKd4ZRlmIor9VsIyFtl1FkoXVYMXphn64jU0E5KRhwG7SmT
 e3LSmTyfMOub870oDGFZeAWTCEdVpVI4gv5PdHSFSOECXNnGhvZWm35urc1ozDpD1D7XnS3DI
 YEBrXq0G9NQ/l56tzQB5QBN2jWlNNM+N4HcmNoJTwAZy2ZZERage7OS2h3wRoRdHQ4TYWvk5Q
 0BeL5NuVqJ46AHB8FFlMMWQt+lgrcjC6kQs0Yg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 3 of a patchset to avoid double free in function
'pci_epf_create()'.

When I accidentally created a new endpoint device with an empty name,
the kernel warned about "attempted to be registered with empty name!"
and crashed afterwards.

It turned out that the crash was not caused by the 'device_add()'
function itself, but by a double kfree of 'epf->name' and 'epf'.

The first patch just simplifies the code, while the second patch
fixes the problem.

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

Rolf Evers-Fischer (2):
  pci: endpoint: Simplify name allocation for epf device
  pci: endpoint: Fix kernel panic after put_device()

 drivers/pci/endpoint/pci-epf-core.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

-- 
2.16.2
