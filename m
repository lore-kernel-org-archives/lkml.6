Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370AAC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F992075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGCBf2d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F992075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJZTxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34185 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeJZTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id f1-v6so3975843wmg.1;
        Fri, 26 Oct 2018 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fIrLgaHXQ/AO6xy90J74d3DaqpUJhlzzd9HZQiK/Oc=;
        b=kGCBf2d3UBvNpHAquiuAG2jaBs/BFhLJzqrrF0m4XIi6Xhxx7ZOnXbOnR4jQmPxdW2
         qU05NYfoitr64l59dGVw96yUkQ9UskuFBXOn5YdffQEZcm7UmJ/jDiP55qmz0XEPkCtx
         RWABdUOFi+EwnJMUycWw1HFmTEXSRlcCGRgpe2Gw/R+3FobVXVp9HALdQ3o9ghQdqfd+
         YZ15IL/Q74zIfjIfODzmBmio28NeCGjSW8QdXQk7PjfGS9CiCN8XYD2asJUg0vrfLcuU
         tLy38ULycrwyfd+wE+LsBSmEtAl8gjb6vAyH5AMudv6ffgoFNN5meir6MYSSjRmyo32h
         32mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fIrLgaHXQ/AO6xy90J74d3DaqpUJhlzzd9HZQiK/Oc=;
        b=Z1pNSmPjtMdQSDjP7OrOfUzJJiFwIVpUD62TFZRtKgAcTM7DT6kY5x1ZI/l9kkgWFS
         4ROOMN6M0SK09cjWaHBRlnKDPAlakKdfx4zNgidEok+5q8t/abQhkx0e89cfbewGr21U
         4mH/UXwjacTiCeUyagbcxJmaR+kB0OCTwCCu9lqQSnGdq7EvmH1z39tkHKATCdpBWug4
         HTfb9iyprd9WK9KBIVxwtdlrjPAlABTTFezoOSPVxJIquosiN4AZkgD1lVMYMPOeWYPJ
         tbI+elWPE3g8rQcZ4u8lnPXgSi/vbs3jQZJlVPWIMktLAJLQrbv5ttcXkAxOSLBAjP2A
         eXpw==
X-Gm-Message-State: AGRZ1gI4eE2VjR6ttdzMO2XZzt1L+F5KCWyrc0LsrIBsC5HQ9Tu+cWS+
        Wsd4PyEdb862BSzlw81m5pU=
X-Google-Smtp-Source: AJdET5fX9Y++YPNuK2MA4Bpb2TAQbY43Yz0ykPfkDCBI2yv7G2RQ6geaGn6OcIaMKHVWEO12cCP6yg==
X-Received: by 2002:a1c:e583:: with SMTP id c125-v6mr5370078wmh.134.1540552601374;
        Fri, 26 Oct 2018 04:16:41 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id y31-v6sm759589wrd.94.2018.10.26.04.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:40 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] serial: Add Tegra Combined UART driver
Date:   Fri, 26 Oct 2018 13:16:29 +0200
Message-Id: <20181026111638.10759-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi everyone,

this is a reworked version of Mikko's earlier proposal[0]. I've reworked
the TCU driver itself so that it relies less on global variables as well
as added a Kconfig option to allow the console support to be selected. I
also fixed a couple of issues that manifested themselves as I was moving
towards the IRQ driven mode (TCU was passing a pointer to a local
variable which was getting stored in the mailbox's ring buffer and the
data pointed at was becoming stale by the time the mailbox got around to
dequeue it).

The biggest bulk of the changes is in the mailbox driver. This series
addresses all of Jassi's comments from back at the time. One notable
additional change is that shared mailboxes are now interrupt driven,
which removes the need for polling mode.

Unfortunately there is still an issue because the TCU uses the mailbox
in atomic context for both TTY and console modes, so we get a sleeping-
while-atomic BUG when using mbox_client->tx_block = true in order to
rate-limit mbox_send_message(). In order to work around this, I added a
mechanism to mbox_send_message() that will allow blocking from atomic
context if the mailbox controller implements the new ->flush() callback.
For Tegra HSP shared mailboxes this is done by spinning on the shared
mailbox register until the receiver has marked the mailbox as empty. I
have been running this locally for a couple of days now and it works
perfectly.

Furthermore this series incorporates Mikko's work in progress on
splitting up the mailbox controllers and allowing multiple controllers
to match on the same device tree node during mbox_request_channel().

Last but not least there are no build-time dependencies between the
mailbox and serial drivers, so I think the easiest way to merge this is
if Jassi picks up patches 1-5, Greg takes patches 6 & 7 and I pick up
patches 8-9 into the Tegra tree.

Thanks,
Thierry

[0]: https://lore.kernel.org/patchwork/project/lkml/list/?series=357641

Mikko Perttunen (5):
  mailbox: Allow multiple controllers per device
  dt-bindings: tegra186-hsp: Add shared interrupts
  dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
  arm64: tegra: Add nodes for TCU on Tegra194
  arm64: tegra: Mark TCU as primary serial port on Tegra194 P2888

Thierry Reding (4):
  mailbox: Support blocking transfers in atomic context
  mailbox: tegra-hsp: Add support for shared mailboxes
  mailbox: tegra-hsp: Add suspend/resume support
  serial: Add Tegra Combined UART driver

 .../bindings/mailbox/nvidia,tegra186-hsp.txt  |   3 +
 .../bindings/serial/nvidia,tegra194-tcu.txt   |  35 ++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  38 +-
 drivers/mailbox/mailbox.c                     |  11 +-
 drivers/mailbox/tegra-hsp.c                   | 495 +++++++++++++++---
 drivers/tty/serial/Kconfig                    |  22 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/tegra-tcu.c                | 299 +++++++++++
 include/linux/mailbox_controller.h            |   4 +
 include/uapi/linux/serial_core.h              |   3 +
 11 files changed, 847 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
 create mode 100644 drivers/tty/serial/tegra-tcu.c

-- 
2.19.1

