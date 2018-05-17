Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeEQFJx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:09:53 -0400
Received: from vulcan.kevinlocke.name ([107.191.43.88]:56826 "EHLO
        vulcan.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeEQFJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:09:52 -0400
Date: Wed, 16 May 2018 23:00:41 -0600
From: Kevin Locke <kevin@kevinlocke.name>
To: linux-kernel@vger.kernel.org
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
        Sander Eikelenboom <linux@eikelenboom.it>, 890817@bugs.debian.org
Subject: Re: Linux 4.16-rc1: regression bisected, Debian kernel package tool
 make-kpkg stalls indefinitely during kernel build due to commit "kconfig:
 remove check_stdin()"
Message-ID: <20180517050041.GA10885@kevinolos>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        linux-kernel@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Sander Eikelenboom <linux@eikelenboom.it>, 890817@bugs.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkk2KSsdrdf28GaMgOX2hMDOdoNdsjmcFiMsmqA8C4NC-EARQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 2:07 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> On Tue, Feb 13, 2018 at 12:33:24PM +0100, Ulf Magnusson wrote:
>>>>>> Sander Eikelenboom wrote:
>>>>>>> The Debian kernel-package tool make-kpkg for easy building of upstream
>>>>>>> kernels on Debian fails with linux 4.16-rc1.
>>>>>>>
>>>>>>> Bisection turned up as culprit:
>>>>>>>      commit d2a04648a5dbc3d1d043b35257364f0197d4d868
>>>
>>> What the commit does is to make silentoldconfig not immediately exit(1)
>>> when both of the following apply:
>>>
>>>     1. stdin is from something that's not a terminal
>>>
>>>     2. New symbols are prompted for
> 
> Shouldn't be a problem to back this one out either if it turns out to
> cause massive amounts of pain in practice I guess, even if it's the
> Debian tools doing something weird.
> 
> Good to look into what it is they're doing in any case.

It appears that make-kpkg is trying to extract kernel version and
configuration information by including the kernel Makefile then
referencing the variables it exports.  The offending make-kpkg
Makefile is kernel_version.mk[1] which can be simplified to the
following example:

-8<- make-kpkg-regression.mk -----------------------------------------
include Makefile
.PHONY: debian_VERSION
debian_VERSION:
-8<-------------------------------------------------------------------

Invoking this script from the root of the kernel source tree, with
stderr redirected (but not stdin) demonstrates the issue:

make -f make-kpkg-regression.mk debian_VERSION >/dev/null 2>&1

Before d2a04648a5db this would exit, after it will hang waiting for
input.  This occurs because the debian_VERSION target name isn't in
no-dot-config-targets defined in Makefile, so Makefile invokes
silentoldconfig automatically as necessary.[2]

I think the issue is best fixed by make-kpkg, and that d2a04648a5db
doesn't need to be reverted.  The simple fix would be for make-kpkg to
redirect stdin when redirecting stdout/stderr so that
scripts/kconfig/conf will fail as it did before.  The better fix would
be for make-kpkg to use a supported interface for getting the
variables it needs, rather than including Makefile.

Best,
Kevin

1. https://salsa.debian.org/srivasta/kernel-package/blob/master/kernel/ruleset/kernel_version.mk
2. Interestingly, it's not just that the target isn't in
   no-dot-config-targets.  make-kpkg actually sets `dot-config := 1`
   to force silentoldconfig (since 38399c1[3]).
3. https://salsa.debian.org/srivasta/kernel-package/commit/38399c1
