Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BCEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0A0214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548767227;
	bh=JbC1K9lRwEc7ZEBsYV9IUREkfUVeCkG0nHneIp6EtjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=heSRu+vJeYjtDXP2IYVRHm/YDomKgvPf3S51j02DMJWwqRSes41IDhrXVFfZn+PQC
	 kHf1rNEznA65x1i4HB92lPV+4cY/bFFL1p/6N1N9vhf5GwOkdi00c8Jm8kaZkhlhnD
	 if+q8rZFP4C9CqShigcZx48+wUFXiSSwR9QwRPBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfA2NHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfA2NHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:07:04 -0500
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 270D820870;
        Tue, 29 Jan 2019 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548767223;
        bh=JbC1K9lRwEc7ZEBsYV9IUREkfUVeCkG0nHneIp6EtjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vk8YZ8X0n+WrbG9ABvkPyRTAaQZVOeJ5BFjOgCqoSGxNlawZEesRMmG5MokEgduJm
         ZnH/UPcmXIesLi48KK6jm4bxTgL4cGc84gasLggl3OIFXJFesm0L9aGZiADRWXMKlj
         fDRE9yNnKODTmWbkCXVwfWZximpCyJjRsmVRoJX4=
Date:   Tue, 29 Jan 2019 14:06:58 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
Message-ID: <20190129130658.GA19205@linux-8ccs>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Thomas Gleixner [28/01/19 23:38 +0100]:
>The original MODULE_LICENSE string for kernel modules licensed under the
>GPL v2 (only / or later) was simply "GPL", which was - and still is -
>completely sufficient for the purpose of module loading and checking
>whether the module is free software or proprietary.
>
>In January 2003 this was changed with commit 3344ea3ad4b7 ("[PATCH]
>MODULE_LICENSE and EXPORT_SYMBOL_GPL support"). This commit can be found in
>the history git repository which holds the 1:1 import of Linus' bitkeeper
>repository:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3344ea3ad4b7c302c846a680dbaeedf96ed45c02
>
>The main intention of the patch was to refuse linking proprietary modules
>against symbols exported with EXPORT_SYMBOL_GPL() at module load time.
>
>As a completely undocumented side effect it also introduced the distinction
>between "GPL" and "GPL v2" MODULE_LICENSE() strings:
>
> *      "GPL"                           [GNU Public License v2 or later]
> *      "GPL v2"                        [GNU Public License v2]
> *      "GPL and additional rights"     [GNU Public License v2 rights and more]
> *      "Dual BSD/GPL"                  [GNU Public License v2
> *                                       or BSD license choice]
> *      "Dual MPL/GPL"                  [GNU Public License v2
> *                                       or Mozilla license choice]
>
>This distinction was and still is wrong in several aspects:
>
> 1) It broke all modules which were using the "GPL" string in the
>    MODULE_LICENSE() already and were licensed under GPL v2 only.
>
>    A quick license scan over the tree at that time shows that at least 480
>    out of 1484 modules have been affected by this change back then. The
>    number is probably way higher as this was just a quick check for
>    clearly identifiable license information.
>
>    There was exactly ONE instance of a "GPL v2" module license string in
>    the kernel back then - drivers/net/tulip/xircom_tulip_cb.c which
>    otherwise had no license information at all. There is no indication
>    that the change above is any way related to this driver. The change
>    happend with the 2.4.11 release which was on Oct. 9 2001 - so quite
>    some time before the above commit. Unfortunately there is no trace on
>    the intertubes to any discussion of this.
>
> 2) The dual licensed strings became ill defined as well because following
>    the "GPL" vs. "GPL v2" distinction all dual licensed (or additional
>    rights) MODULE_LICENSE strings would either require those dual licensed
>    modules to be licensed under GPL v2 or later or just be unspecified for
>    the dual licensing case. Neither choice is coherent with the GPL
>    distinction.
>
>Due to the lack of a proper changelog and no real discussion on the patch
>submission other than a few implementation details, it's completely unclear
>why this distinction was introduced at all. Other than the comment in the
>module header file exists no documentation for this at all.
>
>From a license compliance and license scanning POV this distinction is a
>total nightmare.
>
>As of 5.0-rc2 2873 out of 9200 instances of MODULE_LICENSE() strings are
>conflicting with the actual license in the source code (either SPDX or
>license boilerplate/reference). A comparison between the scan of the
>history tree and a scan of current Linus tree shows to the extent that the
>git rename detection over Linus tree grafted with the history tree is
>halfways complete that almost none of the files which got broken in 2003
>have been cleaned up vs. the MODULE_LICENSE string. So subtracting those
>480 known instances from the conflicting 2800 of today more than 25% of the
>module authors got it wrong and it's a high propability that a large
>portion of the rest just got it right by chance.
>
>There is no value for the module loader to convey the detailed license
>information as the only decision to be made is whether the module is free
>software or not.
>
>The "and additional rights", "BSD" and "MPL" strings are not conclusive
>license information either. So there is no point in trying to make the GPL
>part conclusive and exact. As shown above it's already non conclusive for
>dual licensing and incoherent with a large portion of the module source.
>
>As an unintended side effect this distinction causes a major headache for
>license compliance, license scanners and the ongoing effort to clean up the
>license mess of the kernel.
>
>Therefore remove the well meant, but ill defined, distinction between "GPL"
>and "GPL v2" and document that:
>
>  - "GPL" and "GPL v2" both express that the module is licensed under GPLv2
>    (without a distinction of 'only' and 'or later') and is therefore kernel
>    license compliant.
>
>  - None of the MODULE_LICENSE strings can be used for expressing or
>    determining the exact license
>
>  - Their sole purpose is to decide whether the module is free software or
>    not.
>
>Add a MODULE_LICENSE subsection to the license rule documentation as well.
>
>Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>---
> Documentation/process/license-rules.rst |   62 ++++++++++++++++++++++++++++++++
> include/linux/module.h                  |   18 ++++++++-
> 2 files changed, 79 insertions(+), 1 deletion(-)
>--- a/Documentation/process/license-rules.rst
>+++ b/Documentation/process/license-rules.rst
>@@ -372,3 +372,65 @@ in the LICENSE subdirectories. This is r
> verification (e.g. checkpatch.pl) and to have the licenses ready to read
> and extract right from the source, which is recommended by various FOSS
> organizations, e.g. the `FSFE REUSE initiative <https://reuse.software/>`_.
>+
>+_`MODULE_LICENSE`
>+-----------------
>+
>+   Loadable kernel modules also require a MODULE_LICENSE() tag. This tag is
>+   neither a replacement for proper source code license information
>+   (SPDX-License-Identifier) nor in any way relevant for expressing or
>+   determining the exact license under which the source code of the module
>+   is provided.
>+
>+   The sole purpose of this tag is to provide sufficient information
>+   whether the module is free software or proprietary for the kernel
>+   module loader and for user space tools.
>+
>+   The valid license strings for MODULE_LICENSE() are:
>+
>+    ============================= =============================================
>+    "GPL"			  Module is licensed under GPL version 2. This
>+				  does not express any distinction between
>+				  GPL-2.0-only or GPL-2.0-or-later. The exact
>+				  license information can only be determined
>+				  via the license information in the
>+				  corresponding source files.
>+
>+    "GPL v2"			  Same as "GPL v2". It exists for historic
>+				  reasons.

Did you mean to say 'Same as "GPL"' here? (as in, "GPL v2" conveys the same
information as the "GPL" module license string)

>+
>+    "GPL and additional rights"   Historical variant of expressing that the
>+				  module source is dual licensed under a
>+				  GPL v2 variant and MIT license. Please do
>+				  not use in new code.
>+
>+    "Dual MIT/GPL"		  The correct way of expressing that the
>+				  module is dual licensed under a GPL v2
>+				  variant or MIT license choice.
>+
>+    "Dual BSD/GPL"		  The module is dual licensed under a GPL v2
>+				  variant or BSD license choice. The exact
>+				  variant of the BSD license can only be
>+				  determined via the license information
>+				  in the corresponding source files.
>+
>+    "Dual MPL/GPL"		  The module is dual licensed under a GPL v2
>+				  variant or Mozilla Public License (MPL)
>+				  choice. The exact variant of the MPL
>+				  license can only be determined via the
>+				  license information in the corresponding
>+				  source files.
>+
>+    "Proprietary"		  The module is under a proprietary license.
>+				  This string is soleley for proprietary third

s/soleley/solely/

Otherwise looks good. Thanks for clearing this all up.

Jessica

>+				  party modules and cannot be used for modules
>+				  which have their source code in the kernel
>+				  tree. Modules tagged that way are tainting
>+				  the kernel with the 'P' flag when loaded and
>+				  the kernel module loader refuses to link such
>+				  modules against symbols which are exported
>+				  with EXPORT_SYMBOL_GPL().
>+    ============================= =============================================
>+
>+
>+
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -172,7 +172,7 @@ extern void cleanup_module(void);
>  * The following license idents are currently accepted as indicating free
>  * software modules
>  *
>- *	"GPL"				[GNU Public License v2 or later]
>+ *	"GPL"				[GNU Public License v2]
>  *	"GPL v2"			[GNU Public License v2]
>  *	"GPL and additional rights"	[GNU Public License v2 rights and more]
>  *	"Dual BSD/GPL"			[GNU Public License v2
>@@ -186,6 +186,22 @@ extern void cleanup_module(void);
>  *
>  *	"Proprietary"			[Non free products]
>  *
>+ * Both "GPL v2" and "GPL" (the latter also in dual licensed strings) are
>+ * merily stating that the module is licensed under the GPL v2, but are not
>+ * telling whether "GPL v2 only" or "GPL v2 or later". The reason why there
>+ * are two variants is a historic and failed attempt to convey more
>+ * information in the MODULE_LICENSE string. For module loading the
>+ * "only/or later" distinction is completely irrelevant and does neither
>+ * replace the proper license identifiers in the corresponding source file
>+ * nor amends them in any way. The sole purpose is to make the
>+ * 'Proprietary' flagging work and to refuse to bind symbols which are
>+ * exported with EXPORT_SYMBOL_GPL when a non free module is loaded.
>+ *
>+ * In te same way "BSD" is not a clear license information. It merily
>+ * states, that the module is licensed under one of the compatible BSD
>+ * license variants. The detailed and correct license information is again
>+ * to be found in the corresponding source files.
>+ *
>  * There are dual licensed components, but when running with Linux it is the
>  * GPL that is relevant so this is a non issue. Similarly LGPL linked with GPL
>  * is a GPL combined work.
