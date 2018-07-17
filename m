Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0637DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070B21470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C070B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeGQIiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:38:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:38:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2E03EC74;
        Tue, 17 Jul 2018 08:06:50 +0000 (UTC)
Date:   Tue, 17 Jul 2018 10:06:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: linux-next: build failure after merge of the staging tree
Message-ID: <20180717080648.GA15755@kroah.com>
References: <20180717162839.2f5e7053@canb.auug.org.au>
 <64f9c9c3-edf0-40b8-c3d1-60208025389b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f9c9c3-edf0-40b8-c3d1-60208025389b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:49:45AM +0300, Ivan Safonov wrote:
> On 07/17/2018 09:28 AM, Stephen Rothwell wrote:
> > Hi Greg,
> > 
> > After merging the staging tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/staging/rtl8188eu/core/rtw_security.c: In function 'rtw_tkip_decrypt':
> > drivers/staging/rtl8188eu/core/rtw_security.c:399:21: error: storage size of 'mycontext' isn't known
> >    struct arc4context mycontext;
> >                       ^~~~~~~~~
> > drivers/staging/rtl8188eu/core/rtw_security.c:437:4: error: implicit declaration of function 'phase1' [-Werror=implicit-function-declaration]
> >      phase1((u16 *)&ttkey[0], prwskey, &prxattrib->ta[0], pnh);
> >      ^~~~~~
> > drivers/staging/rtl8188eu/core/rtw_security.c:438:4: error: implicit declaration of function 'phase2' [-Werror=implicit-function-declaration]
> >      phase2(&rc4key[0], prwskey, (unsigned short *)&ttkey[0], pnl);
> >      ^~~~~~
> > drivers/staging/rtl8188eu/core/rtw_security.c:442:4: error: implicit declaration of function 'arcfour_init'; did you mean 'rcu_init'? [-Werror=implicit-function-declaration]
> >      arcfour_init(&mycontext, rc4key, 16);
> >      ^~~~~~~~~~~~
> >      rcu_init
> > drivers/staging/rtl8188eu/core/rtw_security.c:443:4: error: implicit declaration of function 'arcfour_encrypt'; did you mean 'rtw_wep_encrypt'? [-Werror=implicit-function-declaration]
> >      arcfour_encrypt(&mycontext, payload, payload, length);
> >      ^~~~~~~~~~~~~~~
> >      rtw_wep_encrypt
> > drivers/staging/rtl8188eu/core/rtw_security.c:445:23: error: implicit declaration of function 'getcrc32'; did you mean 'get_cred'? [-Werror=implicit-function-declaration]
> >      *((__le32 *)crc) = getcrc32(payload, length-4);
> >                         ^~~~~~~~
> >                         get_cred
> > drivers/staging/rtl8188eu/core/rtw_security.c:399:21: warning: unused variable 'mycontext' [-Wunused-variable]
> >    struct arc4context mycontext;
> >                       ^~~~~~~~~
> > 
> > Caused by commit
> > 
> >    0d4876f4e977 ("staging:r8188eu: Use lib80211 to encrypt (TKIP) tx frames")
> > 
> > interacting with commit
> > 
> >    69a1d98c831e ("Revert "staging:r8188eu: Use lib80211 to support TKIP"")
> > 
> > from the staging.current tree.
> > 
> > I just reverted the staging.current commit ...
> > 
> All commits using lib8022 in r8188eu cause the system to crash. I will
> revert 5 commits in the near future (2 for decryption and 3 for encryption)
> in one patch, it will be bit easier.
> 
> I apologize for such an unpleasant situation.

Not a problem, thanks for fixing this up.  If you need me to merge the
two branches together right now in order to make the patch apply easier,
please let me know and I will be glad to do so.

thanks,

greg k-h
