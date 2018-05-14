Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeENO7w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:59:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54337 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeENO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:59:48 -0400
X-Google-Smtp-Source: AB8JxZo6Ek62DzZq6fjbyB93IVLWomFYlbl9cBNT+GW712h0IPT1BcSOBTmV8Qyzz37pwM2q+F7A3w==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bp@alien8.de
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] acpi: apei: Improve PCIe error handling with FFS
Date: Mon, 14 May 2018 09:59:27 -0500
Message-Id: <20180514145933.10291-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430212836.7807-1-mr.nuke.me@gmail.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Alexandru Gagniuc (2):
  acpi: apei: Rename ghes_severity() to ghes_cper_severity()
  acpi: apei: Do not panic() on PCIe errors reported through GHES

 drivers/acpi/apei/ghes.c | 63 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 11 deletions(-)

-- 
2.14.3
