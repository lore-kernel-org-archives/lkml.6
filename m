Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeBUMsI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:48:08 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:53251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeBUMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:48:04 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH 0/2] pci: endpoint: Fix double free in pci_epf_create()
Date: Wed, 21 Feb 2018 13:47:05 +0100
Message-Id: <20180221124707.26308-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:LlQTe3c1ay8gElqygpQ3DVrw50yLa1eEx0zNhbytx12fMu8G5Sh
 7ONhBdZfslHUAhXTEzk4JNu424GUYyHOfvWZIIKsNAeX3G/4PMDKbnxXSpo9z8oI31yxxoX
 Bq4xoOvT0g8djC+urGY4+EI58l5Z2AkrRUwltMzwZNfCeY7YENVtdNy5wEUzR/oSOOfTjni
 uozCGhIaL3NXLMzFPM+pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FNEB11zxpLE=:qbHi5IsDMjIFuM1tgaRM/s
 sPDvqX4siO8MCfy+GCVjgoDXg0oscKl6yXmr9O4JUcrr55ql1mVmqdUsMaaEhX747NryCp/z9
 8f1sQSSzLBmz58EvkoS+KyBd3/VR/6USXm7yVadIEBtuqeJginO773CdYuHWjcL4pQrB5Hk9G
 iV0wBEdSfwzo4PrbiGJL4NmFOh6Bqys/pjnno09s2i6zMp8mz9bwCkTNsDLltdHm3owFnUlXl
 /qkfOPz8rRRW319AtsoDKjd50akNNqVqdq0gOae2cHZ0umfzyjfkmtkKRPkmvu5mSVwcTN4AB
 HtT75fyLCjO9VXWt9zvFIEqmepDGNIClbY5PE+naZg7B+QaBCF7mSTHcv1jWAm66w297++m2Y
 dD/FOP6IDUpNXuXtwUC5pAET1/u9Pc+ioWZdozPb93QEjFG18GOKLkPmG7OkfUdGJ5zTDOz//
 aua0MzKlrI1qvnBx5hlmjpwmtTLiszKuno5/XzycY0IpXG9A72WfHh4RjxgQp8LepJ0vRM2yQ
 /zZigkb/nA43CillM7Rst2NoXtOZB8TXQMEulfHI0yhp7wT3sLvFadJ1CoCIiCyIA5fUFWiv2
 DymrOAWuS8oMGtIWcL2FQ2qg8nYQHmselnkipMzZ6eD8igguMcXNgyq9VXTbHCSH9qQeAd6C7
 NjH2fk0Z87+VYHEXzPjITSTvJLl47SPGsKk7zXZxRcgtv6H9oI95bgQ+z2CxH7YinZbh1hwDs
 2HKS/Gp4/2IyhWNdHtSmHW0hpiXkRzsVIk85oA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I accidentally created a new endpoint device with an empty name,
the kernel warned about "attempted to be registered with empty name!"
and crashed afterwards.

It turned out that the crash was not caused by the 'device_add()'
function itself, but by a double kfree of 'epf->name' and 'epf'.

The first patch just simplifies the code, while the second patch
fixes the problem.

Rolf Evers-Fischer (2):
  pci: endpoint: Free func_name after last usage
  pci: endpoint: Fix kernel panic after put_device()

 drivers/pci/endpoint/pci-epf-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.16.2
