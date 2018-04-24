Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeDXTfR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbeDXTfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:35:14 -0400
From: Al Stone <ahs3@redhat.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Al Stone <ahs3@redhat.com>
Subject: [PATCH v2 0/3] mailbox: ACPI: Remove incorrect error message about parsing PCCT
Date: Tue, 24 Apr 2018 13:35:02 -0600
Message-Id: <20180424193505.6934-1-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches provide some cleanup in ACPI for minor issues
found while correcting a bogus error message (the first two patches),
and the correction for the error message itself (patch 3/3).  Note
that patches 1/3 and 2/3 are not required for 3/3 to work: 1/3 only
changes a comment and 2/3 makes an ACPI table parsing loop a wee bit
more robust.

For patch 3/3, many systems on boot have been reporting "Error parsing
PCC subspaces from PCCT" which turns out to not be an error at all.
The issue is that the probe for ACPI mailboxes defined in the PCCT
(Platform Communications Channel Table) makes a faulty assumption about
the content of the PCCT.  What's more, when the error is reported, no
further PCC mailboxes are set up, even when they have been defined
in the PCCT.  So, in the reported cases, there was no error and the
data in the PCCT was being ignored.  This is described in more detail
in patch 3/3.

Since these patches primarily involve ACPI usages, it may make
sense for all of them to go through the linux-acpi tree; clearly,
this is up to the maintainers, though.

v2:
  -- removed one extraneous '+' in a comment in patch 3/3
  -- fixed an if test that had a predicate that kbuild pointed out would
     always be zero

Al Stone (3):
  ACPI: improve function documentation for acpi_parse_entries_array()
  ACPI: ensure acpi_parse_entries_array() does not access non-existent
    table data
  mailbox: ACPI: erroneous error message when parsing the ACPI PCCT

 drivers/acpi/tables.c |  9 ++---
 drivers/mailbox/pcc.c | 99 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 30 deletions(-)

-- 
2.14.3
