Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeDCRIv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:08:51 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:44045 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbeDCRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:08:50 -0400
X-Google-Smtp-Source: AIpwx49+mqjMqjOrJXHBG9xqnDtcEuKel0wqgFDuNebFEQix7Hyi0a09wys0X/hE3OdxqnmKXJ1QDA==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH 0/4]  acpi: apei: Improve error handling with firmware-first
Date: Tue,  3 Apr 2018 12:08:26 -0500
Message-Id: <20180403170830.29282-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm helping out Dell work out through the issues related to PCIe and NVMe
hotplug. Although hot-plug generally works, there are corner cases such as
pin bounce, drives failing and surprise removal that are not 100% worked out.
Because of this, NVMe is not yet on feature parity with SCSI and SAS.

One of the interesting issues is that most server vendors like to use
firmware-first (FFS), for various reasons that I won't go into. The side
effect of that is that we oftentimes don't even a stab at correcting the
problem.

This is especially troublesome for NVMe, which needs PCIe hotplug to work
correctly. When we do get a stab, it's after FFS can't handle a fatal error,
and we're told of it through ACPI tables. On x86, this happens through an
NMI, and as soon as we see a "fatal" error, we panic().

One problem with this FFS approach is that AER never even gets notified of
the issue. And even if a PCIe drive were to stop responding, nvme or higher
block drivers would notice something is wrong even without AER. Unless there
is a physical defect or silicon bug, AER can recover the link.

Another issue we're seeing with FFS is that BIOSes assume than an OS will crash
on a fatal error reported through ACPI. Sometimes they will leave hardware in
a "kind of" working state, or will fail to re-arm the errors. From what I've
observed, this happens on hardware with silicon bugs. For example, PCIe root
ports are unaffected, but certain PCIe switches may stop issuing hotplug
interrupts. It's just another headache with FFS.

While I don't expect server vendors to drop FFS in favor of native AER control,
I do think we can harden linux against the idiosyncrasies of such systems. The
scope of these patches is to protect against poorly designed firmware, and
perform proper error handling when possible. It is not to make FFS a first
class citizen in error handling.

Alexandru Gagniuc (4):
  acpi: apei: Return severity of GHES messages after handling
  acpi: apei: Swap ghes_print_queued_estatus and ghes_proc_in_irq
  acpi: apei: Do not panic() in NMI because of GHES messages
  acpi: apei: Warn when GHES marks correctable errors as "fatal"

 drivers/acpi/apei/ghes.c | 100 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 36 deletions(-)

--
2.14.3
