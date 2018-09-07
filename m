Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5138AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D145F2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D145F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeIGG1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:27:47 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39875 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbeIGG1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:27:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07651889|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03272;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CnUOxOu_1536284878;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CnUOxOu_1536284878)
          by smtp.aliyun-inc.com(10.147.41.231);
          Fri, 07 Sep 2018 09:47:58 +0800
Date:   Fri, 7 Sep 2018 09:47:57 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 05/26] csky: System Call
Message-ID: <20180907014757.GB8288@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <bff609c9d2c5f0085448cc7d4227614ab7b7116a.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1W5yvymAHKLTP5EwLm_usUqVBBE_86pRp0TmxrTiTfjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1W5yvymAHKLTP5EwLm_usUqVBBE_86pRp0TmxrTiTfjA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:10:49PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > +SYSCALL_DEFINE6(mmap2,
> > +       unsigned long, addr,
> > +       unsigned long, len,
> > +       unsigned long, prot,
> > +       unsigned long, flags,
> > +       unsigned long, fd,
> > +       off_t, offset)
> > +{
> > +       if (unlikely(offset & (~PAGE_MASK >> 12)))
> > +               return -EINVAL;
> > +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> > +               offset >> (PAGE_SHIFT - 12));
> > +}
> 
> Please call ksys_mmap_pgoff() instead of sys_mmap_pgoff() here.
Ok.

> The prototype in include/asm-generic/syscalls.h uses 'unsigned long'
> for the last argument as well, not off_t.
Ok, unsigned long for last argument.
 
> > +struct mmap_arg_struct {
> > +       unsigned long addr;
> > +       unsigned long len;
> > +       unsigned long prot;
> > +       unsigned long flags;
> > +       unsigned long fd;
> > +       unsigned long offset;
> > +};
> > +
> > +SYSCALL_DEFINE1(mmap,
> > +       struct mmap_arg_struct *, arg)
> 
> Something is still wrong here, there should be no way to
> call sys_mmap(), since it's not in the syscall table.
You are right, remove it.

> > +       return sys_fadvise64_64(fd, offset, len, advice);
> > +}
> 
> And call ksys_fadvise64_64() here.
Ok.

 Guo Ren
