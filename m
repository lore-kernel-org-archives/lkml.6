Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26425C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BE821A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BE821A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeHFMgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:36:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727517AbeHFMgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:36:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0978AE1F;
        Mon,  6 Aug 2018 10:28:11 +0000 (UTC)
Message-ID: <1533550820.15815.14.camel@suse.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
From:   Oliver Neukum <oneukum@suse.com>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Mon, 06 Aug 2018 12:20:20 +0200
In-Reply-To: <20180806075754.GA12124@chenyu-desktop>
References: <cover.1531924968.git.yu.c.chen@intel.com>
         <20180718202235.GA4132@amd> <20180718235851.GA22170@sandybridge-desktop>
         <20180719110149.GA4679@amd> <20180719132003.GA30981@sandybridge-desktop>
         <20180720102532.GA20284@amd> <1532346156.3057.11.camel@suse.com>
         <20180723162302.GA4503@sandybridge-desktop>
         <1532590246.7411.3.camel@suse.com> <20180806075754.GA12124@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2018-08-06 at 15:57 +0800, Yu Chen wrote:
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
> > 
> > Hi,
> > 
> > ecryptfs can trust user space. It is supposed to keep data
> > safe while the system is inoperative.
> 
> Humm, I did not quite get the point here, let's take fscrypt

While the system is running and the fs is mounted, your data
is as secure as root access to your machine, right? You encrypt
a disk primarily so data cannot be recovered (and altered) while
the system is not running.

Secure Boot does not trust root fully. There is a cryptographic
chain of trust and user space is not part of it.

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

Please explain. You will always have to suspend the whole machine
with all tasks of all users. And STD with Secure Boot need not
imply that you encrypt your discs. You need to encrypt only
kernel memory to meet the requirements.

As STD affects the whole machine it must require root rights.
So I cannot see how you can talk about a session belonging
to a user. Please explain.

It seems to me that you can in theory encrypt the password
by a key coming from user space, so that you need to know
an additional key to resume the system, but that seems to me
above and beyond what Secure Boot requires.

	Regards
		Oliver

