Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ypDK0gxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 982E9607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeFFMlr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:41:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33643 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeFFMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:41:44 -0400
X-Google-Smtp-Source: ADUXVKItV3zMbOwnBaknaPg9TpR69FEvwpY8KFnWa4wPiuwy7Rd7cWh7tFMvRGOc4ACVRO0nWNH5Fg==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 0/6] serial: uartps: Add run time support for more IPs than hardcoded 2
Date: Wed,  6 Jun 2018 14:41:33 +0200
Message-Id: <cover.1528288895.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is trying to address discussion I had with Alan in past
https://patchwork.kernel.org/patch/9738445/ and also with Rob in v1
https://lkml.org/lkml/2018/4/26/551.

The first 5 patches are preparation patches to have the last patch as
small as possible to focus on changes there.

Cases without DT aliases are not solved in this series but one function
was shared in RFC v1.
The purpose of this series to get feedback on solution where every
driver instance allocate at run time own uart_driver.

For example this is how it works.
uart0 on higher alias
serial0 = &uart1;
serial100 = &uart0;

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jun  6 12:19 /dev/ttyPS0
crw--w----    1 root     root      253, 100 Jan  1  1970 /dev/ttyPS100

Thanks,
Michal


Changes in v2:
- new patch - it can be sent separately too
- Remove nr field logic
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- Register one uart_driver with unique minor at probe time

Michal Simek (6):
  serial: uartps: Do not initialize field to zero again
  serial: uartps: Move register to probe based on run time detection
  serial: uartps: Do not use static struct uart_driver out of probe()
  serial: uartps: Move alias reading higher in probe()
  serial: uartps: Fill struct uart_driver in probe()
  serial: uartps: Remove CDNS_UART_NR_PORTS macro

 drivers/tty/serial/xilinx_uartps.c | 126 ++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 58 deletions(-)

-- 
1.9.1
