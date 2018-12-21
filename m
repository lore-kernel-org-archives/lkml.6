Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D153218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390745AbeLUBx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:53:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:36286 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbeLUBx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:53:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 17:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,379,1539673200"; 
   d="scan'208";a="131745556"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.153])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2018 17:53:25 -0800
Date:   Fri, 21 Dec 2018 09:53:52 +0800
From:   Philip Li <philip.li@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org,
        lkp@01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [ide] ec7d9c9ce8:
 WARNING:at_fs/proc/generic.c:#remove_proc_entry
Message-ID: <20181221015352.GA7734@intel.com>
References: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com>
 <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:05:28AM -0800, Linus Torvalds wrote:
> On Thu, Dec 20, 2018 at 1:19 AM kernel test robot <lkp@intel.com> wrote:
> >
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: ec7d9c9ce897174243af4fcd201dbfc34df0f3a3 ("ide: replace ->proc_fops with ->proc_show")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Funky.  How did the kernel test robot suddenly figure out an 8-month
> old problem?
Hi Linus, sorry for this late report. I can't figure out exact reason but some possible clues.

The issue is captured by rcutoture which doesn't work well before. And only from late october,
we have solved a few issues of the execution including the rootfs (yocto) it is using. And this issue
is against an randconfig, i'm not sure whether the issue depends on a certain kconfig thus only
be triggered or successfully bisected this time.

> 
> > [   44.180514] WARNING: CPU: 1 PID: 165 at fs/proc/generic.c:662 remove_proc_entry+0xb9/0x155
> 
> This is a warning for somebody doing "remove_proc_entry() on a name
> that doesn't actually exist in that /proc directory.
> 
> In this case, it does seem to be due to the named commit adding a
> 
> +               remove_proc_entry("settings", drive->proc);
> 
> to ide_proc_unregister_device(), and looking at the patch I get the
> feeling that it's due to a typo: the code *creates* the file called
> "setting", but removes the file "settings". Note the missing "s" at
> creation time.
> 
> And yes, the name of the /proc file _should_be "settings", judging by
> the rest of the patch.
> 
> So it does seem to be a real bug. Nobody noticed until now? Why did
> the test robot suddenly react to it?
> 
>               Linus
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
