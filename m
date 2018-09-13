Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A18C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6C620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6C620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeIMSlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:41:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeIMSlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:41:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4007CF3;
        Thu, 13 Sep 2018 13:32:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 27/60] staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice
Date:   Thu, 13 Sep 2018 15:30:34 +0200
Message-Id: <20180913131746.678693930@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

[ Upstream commit e083926b3e269d4064825dcf2ad50c636fddf8cf ]

The PFI subdevice flags indicate that the subdevice is readable and
writeable, but that is only true for the supported "M-series" boards,
not the older "E-series" boards.  Only set the SDF_READABLE and
SDF_WRITABLE subdevice flags for the M-series boards.  These two flags
are mainly for informational purposes.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/ni_mio_common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -5275,11 +5275,11 @@ static int ni_E_init(struct comedi_devic
 	/* Digital I/O (PFI) subdevice */
 	s = &dev->subdevices[NI_PFI_DIO_SUBDEV];
 	s->type		= COMEDI_SUBD_DIO;
-	s->subdev_flags	= SDF_READABLE | SDF_WRITABLE | SDF_INTERNAL;
 	s->maxdata	= 1;
 	if (devpriv->is_m_series) {
 		s->n_chan	= 16;
 		s->insn_bits	= ni_pfi_insn_bits;
+		s->subdev_flags	= SDF_READABLE | SDF_WRITABLE | SDF_INTERNAL;
 
 		ni_writew(dev, s->state, NI_M_PFI_DO_REG);
 		for (i = 0; i < NUM_PFI_OUTPUT_SELECT_REGS; ++i) {
@@ -5288,6 +5288,7 @@ static int ni_E_init(struct comedi_devic
 		}
 	} else {
 		s->n_chan	= 10;
+		s->subdev_flags	= SDF_INTERNAL;
 	}
 	s->insn_config	= ni_pfi_insn_config;
 


