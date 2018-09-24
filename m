Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B2C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAA22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyEiCM36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAA22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeIYETD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeIYETD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:19:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4CC208D9;
        Mon, 24 Sep 2018 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537827281;
        bh=fBpjm1v+gsCP+i0e8xACsHU5USa/118ivjGUWsBOhhM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NyEiCM36UasQ0iYMdLiBTCUkI8Iatfs47nj4alWJYxnOutqzPcQ0Fg0jV8leA6GMe
         UMHHtJphr1FUsWAEYe+3/oMVJhwVsnPl4pYJyfeyIOE5gqZ8yETTCSPgP+S9BAG2mf
         hN+zmz9pjEnVVN21/hYBLXBT7PUO5KiIbSpuic9g=
Subject: [PATCH 0/3] find_next_iomem_res() fixes
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, bp@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com
Date:   Mon, 24 Sep 2018 17:14:37 -0500
Message-ID: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180921073211.20097-2-lijiang@redhat.com>
References: <20180921073211.20097-2-lijiang@redhat.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

These three patches are a possible replacement for your first patch
("[PATCH 1/3 v3] resource: fix an error which walks through iomem
resources").

I think the interface of find_next_iomem_res() can be improved to make
the code easier to read and also avoid the errors you're fixing.

I can't test these, so they've only been compiled.  If you can test
them and if you like them, feel free to incorporate them into your
series.  If not, just drop them (but please at least fix the same
error in walk_system_ram_range()).

---

Bjorn Helgaas (3):
      x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error
      resource: Include resource end in walk_*() interfaces
      resource: Fix find_next_iomem_res() iteration issue


 arch/x86/include/asm/kexec.h |    2 -
 kernel/resource.c            |   96 ++++++++++++++++++------------------------
 2 files changed, 43 insertions(+), 55 deletions(-)
