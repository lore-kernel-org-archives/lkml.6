Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175C1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A102208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A102208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeHWKow convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:44:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12581 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeHWKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:44:52 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5gpw91kgwllX1BiDcw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.18 DYNA|AUTH)
        with ESMTPSA id x038eeu7N7GQSge
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 23 Aug 2018 09:16:26 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is installed" introduced in v4.18.4.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <7e154505-5f73-1054-e67e-cdfb249fec43@infradead.org>
Date:   Thu, 23 Aug 2018 09:16:23 +0200
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lucas.demarchi@profusion.mobi, lucas.de.marchi@gmail.com,
        michal.lkml@markovi.net, jeyu@kernel.org, cwhuang@linux.org.tw,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <75BCA8F9-B649-48BD-9A30-2561AEFBB877@goldelico.com>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com> <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org> <CAKdAkRQ+BXezzT0JsuSa_-imHq+u-q2P5rMVMCL4=N18VYxSAw@mail.gmail.com> <7e154505-5f73-1054-e67e-cdfb249fec43@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> Am 23.08.2018 um 03:07 schrieb Randy Dunlap <rdunlap@infradead.org>:
> 
> On 08/22/2018 05:39 PM, Dmitry Torokhov wrote:
>> On Wed, Aug 22, 2018 at 4:35 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>> 
>>> On 08/22/2018 11:53 AM, H. Nikolaus Schaller wrote:
>>>> This patch requires that /sbin/depmod is installed and installable on
>>>> the build host.
>>>> 
>>>> But not all build hosts for cross compiling Linux are Linux systems
>>>> and are able to provide a working port of depmod, especially at the
>>>> file patch /sbin/depmod.
>>>> 
>>>> I use, for example, a Darwin system to cross compile Linux and I run
>>>> depmod -a on the embedded system once, after installing a new Linux
>>>> kernel there.
>>>> 
>>>> I have no problem with seeing a warning, but aborting the build process
>>>> is IMHO a bad idea since the previous behaviour didn't harm many people
>>>> as far as I see. Probably 99% of people compiling Linux kernels do that
>>>> on Linux and 99% of those have depmod installed for optimal operation of
>>>> their build host. So IMHO printing the warning is good enough.
>>> 
>>> Thanks for the report and sorry about the problem.
>>> 
>>> I'm OK with changing the error to a warning.
>>> Does the patch below work for you?
>> 
>> Why would one want a warning on a host that never runs "make modules_install"?
>> Can this check be only done when we actually try to install modules?
> 
> 
> So Nikolaus:  how do you provoke this problem that you are reporting?
> It's not just a theoretical problem, is it?
> 
> The way that I read the top-level Makefile, this check for $DEPMOD only happens
> when you run "make modules_install".

Yes,
we run on the build host

 make letux_defconfig dtbs uImage INSTALL_MOD_PATH=/tmp/kernel-modules-$$ modules modules_install

and then scp the files from  /tmp/kernel-modules-$$ to the embedded device.
Or pack into some installable file setfor download on our server.

So we run modules_install on the build host as well to copy the modules into the correct hierarchy
and give it the correct lib/modules/<kernel_release> prefix.

I would have to duplicate this what module_install does in some wrapper script.

BTW: it is a standard technique described by others:

http://labs.isee.biz/index.php/The_Linux_kernel#IGEP_Boards_based_on_Texas_Instruments_.C2.A0Processors

 make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=/media/user/rootfs

http://en.gnublin.org/index.php/Kernel_compile_%2B_Module_installation#Compile_the_modules

 mkdir kernel_archiv
 make modules_install INSTALL_MOD_PATH=kernel_archiv
 cp arch/arm/boot/zImage kernel_archiv
 cd kernel_archiv
 tar cfvz kernel.tar.gz zImage lib/

All these descriptions will now break if run on a host without /sbin/depmod installed.

BR and thanks,
Nikolaus
