Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5EBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B6520870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfAaHmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:42:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfAaHmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:42:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C13B3A0498;
        Thu, 31 Jan 2019 07:42:30 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A26760BF7;
        Thu, 31 Jan 2019 07:42:25 +0000 (UTC)
Date:   Thu, 31 Jan 2019 15:42:21 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131074221.GA19091@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <CAFgQCTsuuOSSLKXOaF7jchDRevegZkzZVNiTgB6D+S4=dpc5Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTsuuOSSLKXOaF7jchDRevegZkzZVNiTgB6D+S4=dpc5Xg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 31 Jan 2019 07:42:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/19 at 01:25pm, Pingfan Liu wrote:
> On Fri, Jan 25, 2019 at 10:08 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> > > AFAIK, some people prefer to explictly reserve crash memory at high
> > > region even if it is possible to reserve at low area.  May because
> > > <4G memory is limited on large server, they want to leave this for other
> > > use.
> > >
> > > Yinghai or Vivek should know more about the history, probably they can
> > > recall some initial reason.
> >
> Go through the git log, and I found the initial introduction of
> crashkernel_high option. Refer to
> commit 55a20ee7804ab64ac90bcdd4e2868a42829e2784
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Mon Apr 15 22:23:47 2013 -0700
> 
>     x86, kdump: Retore crashkernel= to allocate under 896M
> 
>     Vivek found old kexec-tools does not work new kernel anymore.
> 
>     So change back crashkernel= back to old behavoir, and add crashkernel_high=
>     to let user decide if buffer could be above 4G, and also new
> kexec-tools will
>     be needed.
> 
> But kexec-tools-2.0.3, released at 2012, can run 4.20 kernel with
> crashkernel=256M@5G, so I think only very old kexec-tools requires
> memory under 896M. Due to -1.few people running latest kernel with
> very old kexec-tools to date, -2. crashkernel=X is more popular than
> crashkernel=X.high, it should be time to eliminate this limit of
> crashkernel=X parameter, otherwise we will run into this bug.
> As for crashkernel=,high, I think it is a more professional option for
> who cares about the DMA32. On high-end machine, big reserved region is
> used for crashkernel(e.g. in this case 384M), which make the crowed
> situation under under 4GB memory worse.

This seems answers the question why ,high is needed and why
crashkernel=X can not allocate from high by default.

Another reason for this question is for crashkernel=,high, a separate
region under 4G is still needed.  I searched some history bug/emails,
previously the initial commit does not reserve low memory by default if
,high is used, but later Yinghai saw a regression bug in case iommu
disabled. see below commit:
commit c729de8fcea37a1c444e81857eace12494c804a9
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Mon Apr 15 22:23:45 2013 -0700

    x86, kdump: Set crashkernel_low automatically

    Chao said that kdump does does work well on his system on 3.8
    without extra parameter, even iommu does not work with kdump.
    And now have to append crashkernel_low=Y in first kernel to make
    kdump work.
    
    We have now modified crashkernel=X to allocate memory beyong 4G (if
    available) and do not allocate low range for crashkernel if the user
    does not specify that with crashkernel_low=Y.  This causes regression
    if iommu is not enabled.  Without iommu, swiotlb needs to be setup in
    first 4G and there is no low memory available to second kernel.
[snip]



> 
> > Yes, just "prefer" is not good enough. There should be a technical
> > reason why that's there.
> >
> > Also, if the user doesn't care, then the code should be free to force
> > "high" and thus probe a different range for allocation.
> >
> Do you suggest to remove crashkernel=X,high parameter?

I do not think it can be removed,  because for ,high we also need extra
low memory, it will cause confusion, most people are just fine without
this.  People can choose to use ,high if they really need it.

Thanks
Dave
