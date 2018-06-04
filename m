Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeFDPE5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:04:57 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37380 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeFDPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:04:55 -0400
X-Google-Smtp-Source: ADUXVKI5bdzmKZooewOvlNXw9h8Uyp/Kgo1sYr9v/fvoYL3H9o1SPFGJMsolveQoSymNi9KMbxwYnQ==
From: mrnuke <mr.nuke.me@gmail.com>
X-Google-Original-From: mrnuke <mrnuke@austins740xd.dell>
To: linux-acpi@vger.kernel.org, tony.luck@intel.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        mrnuke <mrnuke@austins740xd.dell>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org
Subject: [PATCH v8 0/3]  acpi: apei: Drop panic() on
Date: Mon,  4 Jun 2018 10:04:37 -0500
Message-Id: <20180604150443.1265-1-mrnuke@austins740xd.dell>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FFS (firmware-first) handling through APEI seems to have developed a policy
to panic() on any fatal errors. This policy is completely independent of
the non-FFS case and inconsistent the native behavior of error handlers.
A number of handlers will cope with fatal errors just fine when the APEI
code path is not used.

The purpose of this series is to obsolete this phoronic policy, with
the motivation to enable identical handling of PCIe errors to native
reporting.

Changes since v7:
 - Now applies and complies on shiny v4.17

Changes since v6:
 - Fixed silly compilation warning
 - Dropped concept of "degrading" error severity

Changes since v5:
 - Removed zoological references from commit message

Changes since v4:
 - Fix Freudian slip and use GHES_ instead of CPER_ enum
 - Rephrased comments to clarify what we don't care about

Changes since v3:
 - Renamed ghes_severity to something more concrete
 - Reorganized code to make it look like more than just a rename
 - Remembered to remove last patch in the series

Changes since v2:
 - Due to popular request, simple is chosen over flexible
 - Removed splitting of handlers into irq safe portion.
 - Change behavior only for PCIe errors

Changes since v1:
 - Due to popular request, the panic() is left in the NMI handler
 - GHES AER handler is split into NMI and non-NMI portions
 - ghes_notify_nmi() does not panic on deferrable errors
 - The handlers are put in a mapping and given a common call signature

Alexandru Gagniuc (3):
  acpi: apei: Rename GHES_SEV_PANIC to GHES_SEV_FATAL
  acpi: apei: Rename ghes_severity() to ghes_cper_severity()
  acpi: apei: Do not panic() on PCIe errors reported through GHES

 arch/x86/kernel/cpu/mcheck/mce-apei.c |  2 +-
 drivers/acpi/apei/ghes.c              | 65 +++++++++++++++++++++++++++--------
 drivers/edac/ghes_edac.c              |  2 +-
 include/acpi/ghes.h                   |  2 +-
 4 files changed, 54 insertions(+), 17 deletions(-)

-- 
2.14.3
