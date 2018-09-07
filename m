Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3400C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D6F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeIHCUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:20:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbeIHCUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:20:49 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E18B0EC3;
        Fri,  7 Sep 2018 21:37:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Lukasz Dorau <lukasz.dorau@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4.9 57/63] libnvdimm: fix ars_status output length calculation
Date:   Fri,  7 Sep 2018 23:10:28 +0200
Message-Id: <20180907211016.091074274@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Verma <vishal.l.verma@intel.com>

commit 286e87718103acdf85f4ed323a37e4839a8a7c05 upstream.

Commit efda1b5d87cb ("acpi, nfit, libnvdimm: fix / harden ars_status output length handling")
Introduced additional hardening for ambiguity in the ACPI spec for
ars_status output sizing. However, it had a couple of cases mixed up.
Where it should have been checking for (and returning) "out_field[1] -
4" it was using "out_field[1] - 8" and vice versa.

This caused a four byte discrepancy in the buffer size passed on to
the command handler, and in some cases, this caused memory corruption
like:

  ./daxdev-errors.sh: line 76: 24104 Aborted   (core dumped) ./daxdev-errors $busdev $region
  malloc(): memory corruption
  Program received signal SIGABRT, Aborted.
  [...]
  #5  0x00007ffff7865a2e in calloc () from /lib64/libc.so.6
  #6  0x00007ffff7bc2970 in ndctl_bus_cmd_new_ars_status (ars_cap=ars_cap@entry=0x6153b0) at ars.c:136
  #7  0x0000000000401644 in check_ars_status (check=0x7fffffffdeb0, bus=0x604c20) at daxdev-errors.c:144
  #8  test_daxdev_clear_error (region_name=<optimized out>, bus_name=<optimized out>)
      at daxdev-errors.c:332

Cc: <stable@vger.kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Lukasz Dorau <lukasz.dorau@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: efda1b5d87cb ("acpi, nfit, libnvdimm: fix / harden ars_status output length handling")
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-of-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -748,9 +748,9 @@ u32 nd_cmd_out_size(struct nvdimm *nvdim
 		 * overshoots the remainder by 4 bytes, assume it was
 		 * including 'status'.
 		 */
-		if (out_field[1] - 8 == remainder)
+		if (out_field[1] - 4 == remainder)
 			return remainder;
-		return out_field[1] - 4;
+		return out_field[1] - 8;
 	} else if (cmd == ND_CMD_CALL) {
 		struct nd_cmd_pkg *pkg = (struct nd_cmd_pkg *) in_field;
 


