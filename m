Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD73214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547168483;
	bh=l7osxpZsN682QcM4TNEXqTFkMgOfdi+veNmBfHbARWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qCNu+Fc7tuUi7lcrb4kNhdzgsRus6i6oBqtJxPMPAEeDD54eiRhE/i22fF8HxhSuy
	 rrO9B0yrww6exiawrpMRr7TnJmzsgrT2FMA+kE/audbD9RfJTH5fQmi+y82MsrDI+A
	 zLuPMASGP8KLf38f7fOC6oM4XexGvbWXHddcc/ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfAKBBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfAKBBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:01:19 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6933206B7;
        Fri, 11 Jan 2019 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547168478;
        bh=l7osxpZsN682QcM4TNEXqTFkMgOfdi+veNmBfHbARWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfHqjuAFi7k+98Dt3caZBRCkoXLbVCikPgiDlsjXW6ZdQbVQaez0d7Esos47ZDIUe
         4pkNsgdK3ygskwkZDi41wbCjMbBCm2gsoP63dedvu9JCCfJq6VoJ8qIuoB3OJAvMHS
         VjfaPG+7VL+sIMEDjQPfKNxlOkWEvnGTpavhFmvc=
Date:   Thu, 10 Jan 2019 17:01:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>, Theodore Ts'o <tytso@mit.edu>
Cc:     Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] fscrypt: remove filesystem specific build
 config option
Message-ID: <20190111010116.GG149637@gmail.com>
References: <20190110233230.GA23953@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110233230.GA23953@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:32:30PM -0800, Guenter Roeck wrote:
> On Sat, Dec 08, 2018 at 12:21:38PM +0530, Chandan Rajendra wrote:
> > In order to have a common code base for fscrypt "post read" processing
> > for all filesystems which support encryption, this commit removes
> > filesystem specific build config option (e.g. CONFIG_EXT4_FS_ENCRYPTION)
> > and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
> > value affects all the filesystems making use of fscrypt.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> This results in:
> 
> Building ia64:allnoconfig ... failed
> --------------
> Error log:
> make[1]: Entering directory '/tmp/buildbot-builddir.7Wft3'
>   GEN     Makefile
> scripts/kconfig/conf  --allnoconfig Kconfig
> arch/ia64/Kconfig:128:error: recursive dependency detected!
> arch/ia64/Kconfig:128:	choice <choice> contains symbol IA64_HP_SIM
> arch/ia64/Kconfig:202:	symbol IA64_HP_SIM is part of choice PM
> kernel/power/Kconfig:144:	symbol PM is selected by PM_SLEEP
> kernel/power/Kconfig:104:	symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
> kernel/power/Kconfig:31:	symbol HIBERNATE_CALLBACKS is selected by HIBERNATION
> kernel/power/Kconfig:34:	symbol HIBERNATION depends on SWAP
> init/Kconfig:250:	symbol SWAP depends on BLOCK
> block/Kconfig:5:	symbol BLOCK is selected by UBIFS_FS
> fs/ubifs/Kconfig:1:	symbol UBIFS_FS depends on MISC_FILESYSTEMS
> fs/Kconfig:227:	symbol MISC_FILESYSTEMS is selected by ACPI_APEI
> drivers/acpi/apei/Kconfig:8:	symbol ACPI_APEI depends on ACPI
> drivers/acpi/Kconfig:9:	symbol ACPI depends on ARCH_SUPPORTS_ACPI
> drivers/acpi/Kconfig:6:	symbol ARCH_SUPPORTS_ACPI is selected by IA64_HP_SIM
> arch/ia64/Kconfig:202:	symbol IA64_HP_SIM is part of choice <choice>
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> 
> Didn't we have exactly the same problem before ?
> 
> Guenter

Indeed, Chandan Rajendra sent out a new version of the patch which fixes the
problem (by removing the 'select BLOCK' from fs/ubifs/Kconfig), but it never
made it into the fscrypt tree and hence never made it into linux-next.

Ted, what you are planning to do with the fscrypt tree following the fsverity
discussion?  IMO, we should keep the fsverity stuff in its own branch, separate
from any fscrypt changes.  As a suggestion, in the branch "fscrypt" of my
linux.git repo [1], I applied just these four patches on top of v5.0-rc1 and
resolved the conflicts with them no longer being on top of fsverity:

	fscrypt: remove CRYPTO_CTR dependency
	ext4: use IS_ENCRYPTED() to check encryption status
	f2fs: use IS_ENCRYPTED() to check encryption status
	fscrypt: remove filesystem specific build config option

(The last patch is the fixed version.)

Please consider doing the same with the official fscrypt tree.  Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=fscrypt

- Eric
