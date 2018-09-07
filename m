Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1686C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E1E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="I0aOfVm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E1E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIGWyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:54:49 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:46827 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:54:49 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 6BD3FAE0B80;
        Fri,  7 Sep 2018 20:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536343960; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufHU2UyQb6AuaMpsZULxMXNBun8C6vXYtp1gXR0ouXo=;
        b=I0aOfVm/yt6pCGPAyRqJgRZayLS410oz+xMVyYpYHATtDx0/tNp+qKM9LdZ4a9Qb3J6Qd4
        JCOnZ8UAy1/2Bz6oQ8eyNjvxfsg0kzU58qmVMhPtz5FLWwsk5ws79C9QBdD9J0XKbs/L6a
        BzbpTVYIT8ekzIOmTHMrIutuoKP8//2NsrHfyKIaJz0oe2mjL1ePYC4beSEHJ5OwpqE/dd
        fSxUooaC9O1pTIEEXBRA1MDk22uG+wuswdXeOQ7n4PLFuQeCkuxlcPGRP18WznokmMYG/v
        WegRbA8D6cVqKX+kacaM0wit6PB+GM0DepJClbNpO2zFaesrCnb9WmzYB51/FA==
Subject: Re: [PATCH v2 0/3] mtd concat device driver
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20180907173515.19990-1-kernel@nospam.obeliks.de>
 <20180907173515.19990-2-kernel@nospam.obeliks.de>
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
Message-ID: <7ea0a54e-fc10-8e21-aa2f-864c40297369@nospam.obeliks.de>
Date:   Fri, 7 Sep 2018 20:12:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907173515.19990-2-kernel@nospam.obeliks.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, again, I seem not to be able to handle git-send-mail
correctly, the cover letter got lost in operation (using get_maintainers
on a cover letter is not a good idea). Here it is again:


Hi everybody,

when porting my router board from a mach-file based OpenWRT target to a
device-tree based target, I found that there is no generic way to create
a mtd_concat device from within the dts. The following patches attempt
to provide that possibility.

This is a second roll of that patch series, the first one can be seen at
[1]. Apologies for not including the correct recipients in the first
roll.

In this first discussion, concerns were raised that a driver for a
"virtual" device like this might have no place in the device tree
system. However, I would argue that this very similar to specifying the
partitions of a mtd device, which can also done in the device tree. In
fact, I believe this is the only way to be able to specify the
partitions of such a concat device in the dts file (but I'm happy to be
corrected if I'm mistaken).
I have made the example in the dt-binding documentation a little bit
more expressive in this detail.

In this second roll I have also addressed all issues that reviewers have
brought up so far, hopefully to their satisfaction.

Best Regards
Bernhard

[1] 
http://lists.infradead.org/pipermail/linux-mtd/2018-September/083832.html


Bernhard Frauendienst (3):
   mtd: core: add get_mtd_device_by_node
   dt-bindings: add bindings for mtd-concat devices
   mtd: mtdconcat: add dt driver for concat devices

  .../devicetree/bindings/mtd/mtd-concat.txt    |  36 +++++
  drivers/mtd/Kconfig                           |   2 +
  drivers/mtd/Makefile                          |   3 +
  drivers/mtd/composite/Kconfig                 |  12 ++
  drivers/mtd/composite/Makefile                |   7 +
  drivers/mtd/composite/virt_concat.c           | 128 ++++++++++++++++++
  drivers/mtd/mtdcore.c                         |  38 ++++++
  include/linux/mtd/mtd.h                       |   2 +
  8 files changed, 228 insertions(+)
  create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.txt
  create mode 100644 drivers/mtd/composite/Kconfig
  create mode 100644 drivers/mtd/composite/Makefile
  create mode 100644 drivers/mtd/composite/virt_concat.c

-- 
2.17.1

