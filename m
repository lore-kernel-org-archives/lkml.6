Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A47C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786F02081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLO4DhUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786F02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJaBpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeJaBpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:45:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F348D20664;
        Tue, 30 Oct 2018 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540918245;
        bh=TmgARSgPS53rF2j9sW6Vxnn8vSv59GJF7tX+pW+IB/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLO4DhUZSFYZ8x926eDjDPUp+BL6v/RmYZjmARDyjAEufl5br+Sb4lEcL9drWWVID
         Sf1mSspfdq9dcn0is2wOsrCh5uZ6nXuSkPfForjV2pvAnmxmsUs+VeAeVBQnbEGEJI
         a4Uhju9G3yP3XXMWkzBKTmrkYU+222mXuOXN+rt4=
Date:   Tue, 30 Oct 2018 17:51:19 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Message-ID: <20181030165119.GA23017@kroah.com>
References: <20180926191336.101885-1-namit@vmware.com>
 <E1B69BF2-458D-435C-8065-6944111A9EC6@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1B69BF2-458D-435C-8065-6944111A9EC6@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 04:32:22PM +0000, Nadav Amit wrote:
> From: Nadav Amit
> Sent: September 26, 2018 at 7:13:16 PM GMT
> > To: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org
> > Cc: Xavier Deguillard <xdeguillard@vmware.com>, linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>, Michael S. Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, linux-mm@kvack.org>, virtualization@lists.linux-foundation.org
> > Subject: [PATCH v3 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
> > 
> > 
> > This patch-set adds the following enhancements to the VMware balloon
> > driver:
> > 
> > 1. Balloon compaction support.
> > 2. Report the number of inflated/deflated ballooned pages through vmstat.
> > 3. Memory shrinker to avoid balloon over-inflation (and OOM).
> > 4. Support VMs with memory limit that is greater than 16TB.
> > 5. Faster and more aggressive inflation.
> > 
> > To support compaction we wish to use the existing infrastructure.
> > However, we need to make slight adaptions for it. We add a new list
> > interface to balloon-compaction, which is more generic and efficient,
> > since it does not require as many IRQ save/restore operations. We leave
> > the old interface that is used by the virtio balloon.
> > 
> > Big parts of this patch-set are cleanup and documentation. Patches 1-13
> > simplify the balloon code, document its behavior and allow the balloon
> > code to run concurrently. The support for concurrency is required for
> > compaction and the shrinker interface.
> > 
> > For documentation we use the kernel-doc format. We are aware that the
> > balloon interface is not public, but following the kernel-doc format may
> > be useful one day.
> > 
> > v2->v3: * Moving the balloon magic-number out of uapi (Greg)
> > 
> > v1->v2:	* Fix build error when THP is off (kbuild)
> > 	* Fix build error on i386 (kbuild)
> > 
> 
> Greg,
> 
> I realize you didn’t apply patches 17-20. Any reason for that?

I have no idea, that was a few thousand patches reviewed ago...

Did I not say anything about this when I applied them?

greg k-h
