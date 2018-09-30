Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A1C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C202075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C202075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI3QAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:00:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeI3QAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:00:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37AD75D676;
        Sun, 30 Sep 2018 09:27:51 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B059F5DC19;
        Sun, 30 Sep 2018 09:27:44 +0000 (UTC)
Date:   Sun, 30 Sep 2018 17:27:41 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com,
        Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com,
        tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com,
        dan.j.williams@intel.com, bp@suse.de, tglx@linutronix.de,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20180930092741.GC6950@dhcp-128-65.nay.redhat.com>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 30 Sep 2018 09:27:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/18 at 05:21pm, Dave Young wrote:
> Hi Bjorn,
> 
> On 09/27/18 at 09:21am, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The only use of KEXEC_BACKUP_SRC_END is as an argument to
> > walk_system_ram_res():
> > 
> >   int crash_load_segments(struct kimage *image)
> >   {
> >     ...
> >     walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
> >                         image, determine_backup_region);
> > 
> > walk_system_ram_res() expects "start, end" arguments that are inclusive,
> > i.e., the range to be walked includes both the start and end addresses.
> 
> Looking at the function comment of find_next_iomem_res,  the res->end
> should be exclusive, am I missing something?

Oops,  you fix it in 2nd patch, I apparently miss that.

Since the fix of checking the end is in another patch, probably merge
these two patches so that they are in one patch to avoid break bisect. 

Thanks
Dave
