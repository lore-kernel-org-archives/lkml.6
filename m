Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA682087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfBYLM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:12:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfBYLM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 06:12:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0BB53082E20;
        Mon, 25 Feb 2019 11:12:25 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 647535C21E;
        Mon, 25 Feb 2019 11:12:20 +0000 (UTC)
Date:   Mon, 25 Feb 2019 19:12:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>, bhe@redhat.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
References: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225110043.GA5884@suse.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 25 Feb 2019 11:12:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/19 at 12:00pm, Joerg Roedel wrote:
> On Fri, Feb 22, 2019 at 02:00:26PM +0100, Borislav Petkov wrote:
> > On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > > The current default of 256MB was found by experiments on a bigger
> > > number of machines, to create a reasonable default that is at least
> > > likely to be sufficient of an average machine.
> > 
> > Exactly, and this is what makes sense.
> > 
> > The code should try the requested reservation and if it fails, it should
> > try high allocation with default swiotlb size because we need to reserve
> > *some* range.
> 
> Right, makes sense. While at it, maybe it is time to move the default
> allocation policy to 'high' again. The change was reverted six years ago
> because it broke old kexec tools, but those are probably out-of-service
> now. I think this change would make the whole crashdump allocation
> process less fragile.

One concern about this is for average cases, one do not need so much
memory for kdump.  For example in RHEL we use crashkernel=auto to
automatically reserve kdump kernel memory, and for x86 the reserved size
is like below now:
1G-64G:160M,64G-1T:256M,1T-:512M

That means for a machine with less than 64G memory we only allocate
160M, it works for most machines in our lab.

If we move to high as default, it will allocate 160M high + 256M low. It
is too much for people who is good with the default 160M.  Especially
for virtual machine with less memory (but > 4G)

To make the process less fragile maybe we can remove the 896M limitation
and only try <4G then go to high.

Thanks
Dave
