Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA74C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC12C2400A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC12C2400A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeGFNhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:37:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:25225 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753529AbeGFNhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:37:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 06:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,316,1526367600"; 
   d="scan'208";a="72745001"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2018 06:37:01 -0700
Date:   Fri, 6 Jul 2018 21:42:27 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     joeyli <jlee@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Message-ID: <20180706134226.GA9631@sandybridge-desktop>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180705161637.GK3628@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705161637.GK3628@linux-l9pv.suse>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for late reply.
On Fri, Jul 06, 2018 at 12:16:37AM +0800, joeyli wrote:
> Hi Chen Yu, 
> 
> On Wed, Jun 20, 2018 at 05:39:37PM +0800, Chen Yu wrote:
> > Hi,
> > As security becomes more and more important, we add the in-kernel
> > encryption support for hibernation.
> > 
> > This prototype is a trial version to implement the hibernation
> > encryption in the kernel, so that the users do not have to rely
> > on third-party tools to encrypt the hibernation image. The only
> > dependency on user space is that, the user space should provide
> > a valid key derived from passphrase to the kernel for image encryption.
> > 
> > There was a discussion on the mailing list on whether this key should
> > be derived in kernel or in user space. And it turns out to be generating
> > the key by user space is more acceptable[1]. So this patch set is divided
> > into two parts:
> > 1. The hibernation snapshot encryption in kernel space,
> > 2. the key derivation implementation in user space.
> > 
> > Please refer to each patch for detail, and feel free to comment on
> > this, thanks.
> > 
> > [1] https://www.spinics.net/lists/linux-crypto/msg33145.html
> > 
> > Chen Yu (3):
> >   PM / Hibernate: Add helper functions for hibernation encryption
> >   PM / Hibernate: Encrypt the snapshot pages before submitted to the
> >     block device
> >   tools: create power/crypto utility
> >
> 
> I am trying this patch set.
> 
> Could you please tell me how to test the user space crypto utility with
> systemd's hibernation module? 
> 
Usage:
1. install the kernel module:
   modprobe crypto_hibernation
2. run the tool to generate the key from
   user provided passphrase:
   ./crypto_hibernate
3. launch the hibernation process:
   echo disk > /sys/power/state
4. The initrd launches cryto_hibernate
   to read previous salt from kernel and
   probe the user passphrase and generate the same key:
   ./crypto_hibernate
5. kernel uses this key to decrypt the hibernation
   snapshot.
> I have a question about the salt. If the salt is saved in image header,
> does that mean that kernel needs to read the image header before user
> space crypto utility be launched? Otherwise user space can not get
> the salt to produce key? I a bit confused about the resume process.
> 
The crypto_hibernate will first read the salt from the kernel
via ioctl(the kernel will first expose the salt for the user
in crypto_restore(), then the crypto_hibernate uses ioctl to
read it) and then uses that salt together with user provided
passphrase to generate the key, and pass that key to the kernel
for decryption.
> Thanks
> Joey Lee 
