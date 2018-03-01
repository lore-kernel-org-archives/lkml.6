Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033721AbeCASBr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:01:47 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46012 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033223AbeCASBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:01:43 -0500
X-Google-Smtp-Source: AG47ELvbpOq8KmJQ6yrzExgT0N4srF0QROigs50XR694ZLN0Pw2Q0CIOIslk3j9ZxWnsZtc5qmXqlA==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Subject: [PATCH v4 0/4] of: change overlay apply input data from unflattened
Date: Thu,  1 Mar 2018 10:00:52 -0800
Message-Id: <1519927256-4868-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Move duplicating and unflattening of an overlay flattened devicetree
(FDT) into the overlay application code.  To accomplish this,
of_overlay_apply() is replaced by of_overlay_fdt_apply().

The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
code, which is thus responsible for freeing the duplicate FDT.  The
caller of of_overlay_fdt_apply() remains responsible for freeing the
original FDT.

The unflattened devicetree now belongs to devicetree code, which is
thus responsible for freeing the unflattened devicetree.

These ownership changes prevent early freeing of the duplicated FDT
or the unflattened devicetree, which could result in use after free
errors.

These changes led to migrating some unittest overlay data into
their own devicetree source files, and then converting most of
them to use sugar syntax instead of hand coding fragments.

Changes from v3:
  - patch 1/4: OF_OVERLAY: add select OF_FLATTREE

Changes from v2:
  - improve error messages in patch 4/4, as suggested by Geert

Changes from v1:
  - rebase on v4.16-rc1
  - update documentation
  - split out error message to a separate patch


Frank Rowand (4):
  of: change overlay apply input data from unflattened to FDT
  of: Documentation: of_overlay_apply() replaced by
    of_overlay_fdt_apply()
  of: convert unittest overlay devicetree source to sugar syntax
  of: improve reporting invalid overlay target path

 Documentation/devicetree/overlay-notes.txt       |   4 +-
 drivers/of/Kconfig                               |   1 +
 drivers/of/of_private.h                          |   1 +
 drivers/of/overlay.c                             | 129 ++++++++--
 drivers/of/resolver.c                            |   6 -
 drivers/of/unittest-data/Makefile                |  28 ++-
 drivers/of/unittest-data/overlay.dts             | 101 ++++----
 drivers/of/unittest-data/overlay_0.dts           |  14 ++
 drivers/of/unittest-data/overlay_1.dts           |  14 ++
 drivers/of/unittest-data/overlay_10.dts          |  27 +++
 drivers/of/unittest-data/overlay_11.dts          |  28 +++
 drivers/of/unittest-data/overlay_12.dts          |  14 ++
 drivers/of/unittest-data/overlay_13.dts          |  14 ++
 drivers/of/unittest-data/overlay_15.dts          |  30 +++
 drivers/of/unittest-data/overlay_2.dts           |   9 +
 drivers/of/unittest-data/overlay_3.dts           |   9 +
 drivers/of/unittest-data/overlay_4.dts           |  18 ++
 drivers/of/unittest-data/overlay_5.dts           |   9 +
 drivers/of/unittest-data/overlay_6.dts           |  10 +
 drivers/of/unittest-data/overlay_7.dts           |  10 +
 drivers/of/unittest-data/overlay_8.dts           |  10 +
 drivers/of/unittest-data/overlay_9.dts           |  10 +
 drivers/of/unittest-data/overlay_bad_phandle.dts |  23 +-
 drivers/of/unittest-data/overlay_bad_symbol.dts  |  25 +-
 drivers/of/unittest-data/tests-overlay.dtsi      | 217 +----------------
 drivers/of/unittest.c                            | 294 +++++++++++------------
 include/linux/of.h                               |   7 -
 27 files changed, 575 insertions(+), 487 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_0.dts
 create mode 100644 drivers/of/unittest-data/overlay_1.dts
 create mode 100644 drivers/of/unittest-data/overlay_10.dts
 create mode 100644 drivers/of/unittest-data/overlay_11.dts
 create mode 100644 drivers/of/unittest-data/overlay_12.dts
 create mode 100644 drivers/of/unittest-data/overlay_13.dts
 create mode 100644 drivers/of/unittest-data/overlay_15.dts
 create mode 100644 drivers/of/unittest-data/overlay_2.dts
 create mode 100644 drivers/of/unittest-data/overlay_3.dts
 create mode 100644 drivers/of/unittest-data/overlay_4.dts
 create mode 100644 drivers/of/unittest-data/overlay_5.dts
 create mode 100644 drivers/of/unittest-data/overlay_6.dts
 create mode 100644 drivers/of/unittest-data/overlay_7.dts
 create mode 100644 drivers/of/unittest-data/overlay_8.dts
 create mode 100644 drivers/of/unittest-data/overlay_9.dts

-- 
Frank Rowand <frank.rowand@sony.com>
