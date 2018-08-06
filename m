Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D870C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CF22157F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CF22157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHFL4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:56:33 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:33426 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFL4c (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 6 Aug 2018 07:56:32 -0400
Received: from linux-l9pv.suse (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 06 Aug 2018 11:48:10 +0200
Date:   Mon, 6 Aug 2018 17:48:04 +0800
From:   joeyli <jlee@suse.com>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     Oliver Neukum <oneukum@suse.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
Message-ID: <20180806094752.GH27062@linux-l9pv.suse>
References: <cover.1531924968.git.yu.c.chen@intel.com>
 <20180718202235.GA4132@amd>
 <20180718235851.GA22170@sandybridge-desktop>
 <20180719110149.GA4679@amd>
 <20180719132003.GA30981@sandybridge-desktop>
 <20180720102532.GA20284@amd>
 <1532346156.3057.11.camel@suse.com>
 <20180723162302.GA4503@sandybridge-desktop>
 <1532590246.7411.3.camel@suse.com>
 <20180806075754.GA12124@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806075754.GA12124@chenyu-desktop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:57:54PM +0800, Yu Chen wrote:
> Hi Oliver,
> On Thu, Jul 26, 2018 at 09:30:46AM +0200, Oliver Neukum wrote:
> > On Di, 2018-07-24 at 00:23 +0800, Yu Chen wrote:
> > > 
> > > Good point, we once tried to generate key in kernel, but people
> > > suggest to generate key in userspace and provide it to the
> > > kernel, which is what ecryptfs do currently, so it seems this
> > > should also be safe for encryption in kernel.
> > > https://www.spinics.net/lists/linux-crypto/msg33145.html
> > > Thus Chun-Yi's signature can use EFI key and both the key from
> > > user space.

As Ard and James's comments, the EFI key can not be accepted:
	https://lkml.org/lkml/2018/8/5/135

The lower entropy problem can be covered by RDRAND or EFI random
protocol. But the key point is that we can not fully trust manufacturer.
And, the secure boot relies on Microsoft's business interests. It's
not designed for confidentiality.

So I will move to TPM trusted key + encrypted key.

> > 
> > Hi,
> > 
> > ecryptfs can trust user space. It is supposed to keep data
> > safe while the system is inoperative.
> Humm, I did not quite get the point here, let's take fscrypt
> for example, the kernel gets user generated key from user space,
> and uses per-inode nonce(random bytes) as the master key to
> do a KDF(key derivation function) on user provided key, and uses
> that key for encryption. We can also added similar mechanism
> to generate the key in kernel space but the key should be
> original from user's provided key(password derived), because
> the security boot/signature mechanism could not cover the case
> that, two different users could resume to each other's context
> because there isn't any certification during resume if it is
> on the same physical hardware.
>

Sounds there have two different purposes. One is to prevent that
the secret in snapshop image be detected/changed outside the machine.
Another one try to prevent that B user resumes to A user's context
on the same machine.

In the case of B resumes A's context, I still think that the attacker
must physical accesses the machine. Which means that it's out of EFI
secure boot's design. Could you please explan the detail for the attack?

So I think that the password from user space is for user authentication,
and the TPM trusted key is for snapshot image encryption/verification.    

Thanks
Joey Lee
