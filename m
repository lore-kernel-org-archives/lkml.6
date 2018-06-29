Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53F8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A2727B06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A2727B06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030687AbeF2Cbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:31:46 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:57942 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966843AbeF2Cbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:31:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4C614182CED34;
        Fri, 29 Jun 2018 02:31:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seed24_4928e830c5134
X-Filterd-Recvd-Size: 2617
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 Jun 2018 02:31:42 +0000 (UTC)
Message-ID: <4e0802ced7c15f9c750bef76256233ee85897392.camel@perches.com>
Subject: Re: [PATCH v5] drivers/staging: Gasket driver framework + Apex
 driver
From:   Joe Perches <joe@perches.com>
To:     Simon Que <sque@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Chan <benchan@chromium.org>,
        Chun-Ta Lin <itspeter@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>
Date:   Thu, 28 Jun 2018 19:31:41 -0700
In-Reply-To: <20180629002430.59486-1-sque@chromium.org>
References: <20180629002430.59486-1-sque@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 20:24 -0400, Simon Que wrote:
> The Gasket (Google ASIC Software, Kernel Extensions, and Tools) kernel
> framework is a generic, flexible system that supports thin kernel
> drivers. Gasket kernel drivers are expected to handle opening and
> closing devices, mmap'ing BAR space as requested, a small selection of
> ioctls, and handling page table translation (covered below). Any other
> functions should be handled by userspace code.

As this is not likely to be added to v4.18,
it likely would be better to target v4.19
and allow this to be compiled against -next.

This currently does not compile correctly
against next-20180628

---

$ make drivers/staging/gasket/
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC      drivers/staging/gasket/gasket_core.o
drivers/staging/gasket/gasket_core.c: In function ‘gasket_mm_unmap_region’:
drivers/staging/gasket/gasket_core.c:1433:9: error: void value not ignored as it ought to be
  return zap_vma_ptes(
         ^~~~~~~~~~~~~
   vma, vma->vm_start + virt_offset,
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DIV_ROUND_UP(mappable_region.length_bytes, PAGE_SIZE) *
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PAGE_SIZE);
    ~~~~~~~~~~
drivers/staging/gasket/gasket_core.c:1437:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^
scripts/Makefile.build:317: recipe for target 'drivers/staging/gasket/gasket_core.o' failed
make[1]: *** [drivers/staging/gasket/gasket_core.o] Error 1
Makefile:1691: recipe for target 'drivers/staging/gasket/' failed
make: *** [drivers/staging/gasket/] Error 2

