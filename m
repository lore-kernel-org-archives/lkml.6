Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F1C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D2027CA6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D2027CA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932783AbeF2JoH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:44:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932085AbeF2JoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:44:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45F91ACC9;
        Fri, 29 Jun 2018 09:44:03 +0000 (UTC)
Date:   Fri, 29 Jun 2018 11:43:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alpha: switch to NO_BOOTMEM
Message-ID: <20180629094358.GE13860@dhcp22.suse.cz>
References: <1530099168-31421-1-git-send-email-rppt@linux.vnet.ibm.com>
 <201806280311.v9maSSpW%fengguang.wu@intel.com>
 <20180629092359.GC4799@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629092359.GC4799@rapoport-lnx>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-06-18 12:24:00, Mike Rapoport wrote:
> On Thu, Jun 28, 2018 at 05:38:29AM +0800, kbuild test robot wrote:
> > Hi Mike,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v4.18-rc2 next-20180627]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Mike-Rapoport/alpha-switch-to-NO_BOOTMEM/20180627-194800
> > config: alpha-allyesconfig (attached as .config)
> > compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=alpha 
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    mm/page_alloc.c: In function 'update_defer_init':
> > >> mm/page_alloc.c:321:14: error: 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean 'USEC_PER_SEC'?
> >          (pfn & (PAGES_PER_SECTION - 1)) == 0) {
> >                  ^~~~~~~~~~~~~~~~~
> >                  USEC_PER_SEC
> 
> The PAGES_PER_SECTION is  defined only for SPARSEMEM with the exception of
> x86-32 defining it for DISCONTIGMEM as well. That said, any architecture
> that can have DISCTONTIGMEM=y && NO_BOOTMEM=y will fail the build with
> DEFERRED_STRUCT_PAGE_INIT enabled.
> 
> The simplest solution seems to make DEFERRED_STRUCT_PAGE_INIT explicitly
> dependent on SPARSEMEM rather than !FLATMEM. The downside is that deferred
> struct page initialization won't be available for x86-32 NUMA setups.

I am really dubious that 32b systems really need DEFERRED_STRUCT_PAGE_INIT.
Regardless of the memory mode. Those systems simply do not have enough
memory to bother. Deferred initialization is targeting much larger
beasts.
-- 
Michal Hocko
SUSE Labs
