Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA05C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7520815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfBCNtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:49:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52744 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727741AbfBCNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:41 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0003tu-Jy; Sun, 03 Feb 2019 13:49:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0006oJ-VD; Sun, 03 Feb 2019 14:49:39 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Ian Abbott" <abbotti@mev.co.uk>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.781057016@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 017/305] staging: comedi: quatech_daqp_cs: use
 comedi_timeout() in ao (*insn_write)
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: H Hartley Sweeten <hsweeten@visionengravers.com>

commit e031642eccc040648b09cfc7d632e2e8d0b6f94f upstream.

The data link between the D/A data port and the D/A converter is a serial
link. The serial link requires about 8ms to complete a transfer. Use the
comedi_timeout() helper to ensure that there is not a previous transfer
still happening before trying to write new data to the channel.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ija: Backported to 3.16: No 'readback' member in subdevice.]
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 .../staging/comedi/drivers/quatech_daqp_cs.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/staging/comedi/drivers/quatech_daqp_cs.c
+++ b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
@@ -633,6 +633,19 @@ static int daqp_ai_cmd(struct comedi_dev
 	return 0;
 }
 
+static int daqp_ao_empty(struct comedi_device *dev,
+			 struct comedi_subdevice *s,
+			 struct comedi_insn *insn,
+			 unsigned long context)
+{
+	unsigned int status;
+
+	status = inb(dev->iobase + DAQP_AUX);
+	if ((status & DAQP_AUX_DA_BUFFER) == 0)
+		return 0;
+	return -EBUSY;
+}
+
 static int daqp_ao_insn_write(struct comedi_device *dev,
 			      struct comedi_subdevice *s,
 			      struct comedi_insn *insn,
@@ -650,6 +663,12 @@ static int daqp_ao_insn_write(struct com
 
 	for (i = 0; i > insn->n; i++) {
 		unsigned val = data[i];
+		int ret;
+
+		/* D/A transfer rate is about 8ms */
+		ret = comedi_timeout(dev, s, insn, daqp_ao_empty, 0);
+		if (ret)
+			return ret;
 
 		val &= 0x0fff;
 		val ^= 0x0800;		/* Flip the sign */

