Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E0CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FD62087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfA1J6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:58:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfA1J6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:58:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE90FC02C019;
        Mon, 28 Jan 2019 09:58:17 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-122.pek2.redhat.com [10.72.12.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 938305C234;
        Mon, 28 Jan 2019 09:58:13 +0000 (UTC)
Date:   Mon, 28 Jan 2019 17:58:09 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190128095809.GC3732@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125140823.GC27998@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 28 Jan 2019 09:58:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/19 at 03:08pm, Borislav Petkov wrote:
> On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> > AFAIK, some people prefer to explictly reserve crash memory at high
> > region even if it is possible to reserve at low area.  May because
> > <4G memory is limited on large server, they want to leave this for other
> > use. 
> > 
> > Yinghai or Vivek should know more about the history, probably they can
> > recall some initial reason.
> 
> Yes, just "prefer" is not good enough. There should be a technical
> reason why that's there.
> 
> Also, if the user doesn't care, then the code should be free to force
> "high" and thus probe a different range for allocation.

Another reason is in case ,high we will need automatically reserve a
region in low area for swiotlb.  So for example one use
crashkernel=256M,high,  actual reserved memory is 256M above 4G and
another 256M under 4G for swiotlb.  Normally it is not necessary for
most people.  Thus we can not make ,high as default.

Thanks
Dave
