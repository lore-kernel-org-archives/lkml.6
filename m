Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC419C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882762173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrZnkkCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfAJXcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:32:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45932 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfAJXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:32:35 -0500
Received: by mail-io1-f65.google.com with SMTP id c2so10516946iom.12;
        Thu, 10 Jan 2019 15:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r/aefQtgoTHOutF3l7mzUV+CTld7IU60uu943B9Plmo=;
        b=UrZnkkCyBH/UG0cGZiIXn48JNVsAy9TwadnZtJc736EIbf4oCGg/gzg5IyuL0Zb2/S
         tUfKS5ShsP3eiKj6bjIDGGmhOfEnx33R1u+7iSWk7ltlJoWxvt2/0v/FZPtKhDbJzjnf
         vq2HhDBaJWKPWWqP0+x4Xcm9/trHTwpHRLZy0LlFI+ln2DqffU6fFwrEtnToNW4d2loL
         BZoSmEaBbouUzi0MaS3J+pq4fOcCoE3BtkEHDw3v17TwVdAUDMMMZt50RpUujTslU2do
         3e3ONWE7cXrpabcXB/i72Zw3JKAJ0eFMz/m4/ronE38rFzN2rShIoRMSHbmFRlQPD2/f
         at4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=r/aefQtgoTHOutF3l7mzUV+CTld7IU60uu943B9Plmo=;
        b=rqAUz0auVxzwNuKqekXmplPfJks/XsE6ST2KKmzYpQ3Hdz04NMSYyf0LpEvIr7ANx5
         TALGirYUFs2LfKZ/vmVuk88VEvCtT34rKca5LMl0W+X+/7jt0qS4grsrzDpoH1uWf6BS
         11Mwhrsz/3cAAayOdHnuj3lK5Jg5frj5oXjGi482IKIWK/yhA7NrCxMs9vWXlUTBg4Dw
         xdwk3fce6vyqRNkhcqB+hFrg65wVdaTRwdV0/iKAuDXkSj83OOJVOLSXvAgrpHeGsuZl
         wTWPQpxhLc9NTBO55rZhIIsgfCjfth91oU4DqTitODQlRFWA7y6w6rhjr3oR2oB9NT5l
         Aaqg==
X-Gm-Message-State: AJcUukfFnjU6OB130Vsa5S/Gvcby6Sc+waLAh32PGcY8hYd+nvUs8Y2q
        Wc1B2HIIAMbshMQUGS5XXC0=
X-Google-Smtp-Source: ALg8bN5+TiTFpI5MqYQxAsptd6eer5AsafeJEoC6PHHv/JvA+wd51xlcZoXBxI02HWVMv0I6Px6GPg==
X-Received: by 2002:a02:6:: with SMTP id 6mr8279454jaa.19.1547163153709;
        Thu, 10 Jan 2019 15:32:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z10sm33105637ioh.20.2019.01.10.15.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 15:32:32 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:32:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc:     Eric Biggers <ebiggers@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: remove filesystem specific build config option
Message-ID: <20190110233230.GA23953@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:21:38PM +0530, Chandan Rajendra wrote:
> In order to have a common code base for fscrypt "post read" processing
> for all filesystems which support encryption, this commit removes
> filesystem specific build config option (e.g. CONFIG_EXT4_FS_ENCRYPTION)
> and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
> value affects all the filesystems making use of fscrypt.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

This results in:

Building ia64:allnoconfig ... failed
--------------
Error log:
make[1]: Entering directory '/tmp/buildbot-builddir.7Wft3'
  GEN     Makefile
scripts/kconfig/conf  --allnoconfig Kconfig
arch/ia64/Kconfig:128:error: recursive dependency detected!
arch/ia64/Kconfig:128:	choice <choice> contains symbol IA64_HP_SIM
arch/ia64/Kconfig:202:	symbol IA64_HP_SIM is part of choice PM
kernel/power/Kconfig:144:	symbol PM is selected by PM_SLEEP
kernel/power/Kconfig:104:	symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
kernel/power/Kconfig:31:	symbol HIBERNATE_CALLBACKS is selected by HIBERNATION
kernel/power/Kconfig:34:	symbol HIBERNATION depends on SWAP
init/Kconfig:250:	symbol SWAP depends on BLOCK
block/Kconfig:5:	symbol BLOCK is selected by UBIFS_FS
fs/ubifs/Kconfig:1:	symbol UBIFS_FS depends on MISC_FILESYSTEMS
fs/Kconfig:227:	symbol MISC_FILESYSTEMS is selected by ACPI_APEI
drivers/acpi/apei/Kconfig:8:	symbol ACPI_APEI depends on ACPI
drivers/acpi/Kconfig:9:	symbol ACPI depends on ARCH_SUPPORTS_ACPI
drivers/acpi/Kconfig:6:	symbol ARCH_SUPPORTS_ACPI is selected by IA64_HP_SIM
arch/ia64/Kconfig:202:	symbol IA64_HP_SIM is part of choice <choice>
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

Didn't we have exactly the same problem before ?

Guenter

---
# bad: [6cab33afc3dd17bd9922c99a828f5680b4667cd9] Add linux-next specific files for 20190110
# good: [bfeffd155283772bbe78c6a05dec7c0128ee500c] Linux 5.0-rc1
git bisect start 'HEAD' 'v5.0-rc1'
# bad: [45daa05b201d684d42a186970731a9e39f75beb7] Merge remote-tracking branch 'mtd/mtd/next'
git bisect bad 45daa05b201d684d42a186970731a9e39f75beb7
# good: [f570411d3495dc4acf76cffa3a4c3cca6ae693fb] Merge remote-tracking branch 'renesas/next'
git bisect good f570411d3495dc4acf76cffa3a4c3cca6ae693fb
# bad: [849603c11808c63603b5ed4469e10e0760bc3d54] Merge remote-tracking branch 'ext3/for_next'
git bisect bad 849603c11808c63603b5ed4469e10e0760bc3d54
# good: [2a6bce75e611c112d3971a4b9dcff8028d8b1f2d] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect good 2a6bce75e611c112d3971a4b9dcff8028d8b1f2d
# good: [41602048a8a5b2003f8341d07ae9f0071276653d] Merge remote-tracking branch 'xtensa/xtensa-for-next'
git bisect good 41602048a8a5b2003f8341d07ae9f0071276653d
# bad: [a9e5d743c35d47c459d5ee80454fe23391a8d654] Merge remote-tracking branch 'btrfs-kdave/for-next'
git bisect bad a9e5d743c35d47c459d5ee80454fe23391a8d654
# good: [dc82005ead5de0e5bb764c0c1c50a19891b6de15] ext4: use IS_ENCRYPTED() to check encryption status
git bisect good dc82005ead5de0e5bb764c0c1c50a19891b6de15
# bad: [7138851022cbedd6ae6303168c2195c714ed3548] fsverity: Move verity status check to fsverity_file_open
git bisect bad 7138851022cbedd6ae6303168c2195c714ed3548
# bad: [4dedd7844d2241d358c121d06109dfda2e46843f] Add S_VERITY and IS_VERITY()
git bisect bad 4dedd7844d2241d358c121d06109dfda2e46843f
# bad: [f3fd6cd74fedf99b6060f75df00943fda13b65f2] fscrypt: remove filesystem specific build config option
git bisect bad f3fd6cd74fedf99b6060f75df00943fda13b65f2
# good: [1dcfeb539c09237c98b99685fb9cd156241db13f] f2fs: use IS_ENCRYPTED() to check encryption status
git bisect good 1dcfeb539c09237c98b99685fb9cd156241db13f
# first bad commit: [f3fd6cd74fedf99b6060f75df00943fda13b65f2] fscrypt: remove filesystem specific build config option
