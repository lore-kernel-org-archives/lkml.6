Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeBZRRH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:17:07 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:38921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeBZRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:17:05 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH v2 0/2] pci: endpoint: Fix double free in pci_epf_create()
Date: Mon, 26 Feb 2018 18:16:15 +0100
Message-Id: <20180226171617.10016-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:zj09TN4NM4IhlcxWu0JsrrFvo6bECFlc+r48jcCq82QJysXAxJB
 oUMtPrx1w/SuQd0rA2kZSKJqtP11mzxUpBP1yCimIAvMqbnzO/TvgZrOfs4uEFvHb4PLaYH
 0Diz8P45+nMwc2gndea9fj3k8xKppiWUxXOeozqAbkRZ9tngvd8T/xy67NoqD8QsUxFT4Ba
 qc58rqHw6fHB0aMTRG3hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:33Dx7cUxBpk=:4Jm2vs6EMukHFS+6SkYJZe
 tZvwYjtVe0jdSz+QFtRa8y1CNb6XyKMLFeVKc5WIjN5dUmiJatnqUggtJ98/vr5ulP74WD1u4
 dujJbVu3Q4r2IDri1VzlVVF3lJAty3Sjs84cAcXBMJdwAzC/DKv2Kv0Dm8v7ZudYsu7usmOZl
 Zt4KRVCTjjgyKOQrxH1AYSUMKMKY2tviRji6s90S4tTohruSHvM8a9TLB4FF7Hn1egtQNn/QZ
 gsivGzsBpqJMs7vLrrZ919gTIqmeFVsIPRdEiOHiFne874raQPd36r5ch/UDxyhnPQH6JJ96k
 +uam/KwqGX60qejNXL1omKW24YY/eXCQz62+UO/9MCnj7+YF0XDxYVyGwmFzoHA/XanAYyoiY
 Tpm5Ay6h1H4WN1Z0nSiqVNfbL0xgNe7xwW5souAkcfDvNNyt9mWiTDegq7H+FEnwdrI3q2QMu
 Z6NrZhj7Q28i4Uk6LvOF9a56wfy8bTrF1WyWjca/Sn5Q7hDi5/yuyPleMCdsBsBX7gzwpKGYk
 bxhOrIwit7IvmFzkFJU5k8YY6NVxBbg0BIumPid4zxS8EN8buB+4a9z/Qs32ev8yTpQxxQOX3
 TjYFlIg29MpIkzNG6vmVc1EqmGaHv8yaMXH8f8Iq1NS7hm1QrjwRk8DGGNoW6JeGzihOdghqz
 /Orp6PfzG7w9AOAq6hslTcIhX6HP5t6M+TJ2FViuQD3hJt6xWXmNscSNVBy+nfck7sV3l/maU
 Jk0gSlqCmTgilHRm0KdLyzseEyi4n1Ll2k9OUQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of a patchset to avoid double free in function
'pci_epf_create()'.

When I accidentally created a new endpoint device with an empty name,
the kernel warned about "attempted to be registered with empty name!"
and crashed afterwards.

It turned out that the crash was not caused by the 'device_add()'
function itself, but by a double kfree of 'epf->name' and 'epf'.

The first patch just simplifies the code, while the second patch
fixes the problem.

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
