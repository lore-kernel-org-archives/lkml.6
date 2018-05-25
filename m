Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967006AbeEYPyF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:54:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35712 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:54:03 -0400
X-Google-Smtp-Source: AB8JxZqx7JHujhVZrmgCpIMtU+8EShVGYBHeb/Mdn+KBj3vY7tSDYzxfhJLV0HpN0F8UZnIe0zY+OQ==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org
Subject: [PATCH v7 0/3]  acpi: apei: Drop panic() on fatal errors policy
Date: Fri, 25 May 2018 10:53:45 -0500
Message-Id: <20180525155352.22350-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FFS (firmware-first) handling through APEI seems to have developed a
policy to panic() on any fatal errors. This policy is completely
independent of the non-FFS case. It is also inconsistent with how the
native error handlers, a number of which will recover the system from
fatal errors.

The purpose of this series is to obsolete this idiotic policy, with
the motivation to enable identical handling of PCIe errors to native
reporting.


Rafael, this is copypaste from the previous patch series. I suspect
you might have missed it last time, because you asked questions which
were answered here. I've included it so you don't have to go digging
old emails:

"
The purpose of these changes is to see if we can safely de-escalate
the situation and notify the appropriate error handler. Since FFS
reports errors through NMIs or other non-standard mechanism, we have
to be just a little more careful with reporting the error.

We're concerned with things, such as being able to cross the NMI/IRQ
boundary, or being able to safely schedule work and notify the
appropriate subsystem. Once the notification is sent, our job is done.
I'm explicitly _NOT_ concerned with whether the error is handled or
not, especially since such concern reduces to a call to __ghes_panic().

There are rare cases that prevent us from de-escalating to lesser
contexts, such as uncorrectable memory errors in kernel. In these sort
of cases, trying to leave the NMI might cause a triple fault. James
Morse explained this very well when discussing v1 of this series. In
and only in such cases, we are justified to panic().

Once the error is safely sent its merry way, it's really up to the
error handler to panic() or continue. For example, aer_recover_queue()
might for ungodly reasons fail. However, it's up to the AER code to
decide whether failing to queue an error for handling is panic worthy.
"

Changes since v6:
 - Fixed silly compilation warning
 - Dropped concept of

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
