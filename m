Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BDC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BB6254F0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BB6254F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeFYG4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:56:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeFYG4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:56:06 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9E4D41C;
        Mon, 25 Jun 2018 06:56:04 +0000 (UTC)
Date:   Mon, 25 Jun 2018 14:55:57 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.17 00/70] 4.17.3-stable review
Message-ID: <20180625065557.GA5140@kroah.com>
References: <20180624142740.481662434@linuxfoundation.org>
 <CA+G9fYsxWVXZH=VB9tCvBcJ_K4pOPs51J1XnnCjF8vcBVMadDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsxWVXZH=VB9tCvBcJ_K4pOPs51J1XnnCjF8vcBVMadDg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:10:08PM +0530, Naresh Kamboju wrote:
> On 24 June 2018 at 20:51, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.17.3 release.
> > There are 70 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue Jun 26 14:27:20 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64 and arm.
> 
> Kselftest test case mov_ss_trap_64 is causing kernel panic on
> qemu-system-x86_64 and PASS on real x86_64 hardware.
> 
> [RUN] MOV SS; CSx14 INT3
> [  762.263790] PANIC: double fault, error_code: 0x0
> [  762.265169] CPU: 2 PID: 3380 Comm: mov_ss_trap_64 Not tainted 4.17.3-rc1 #1
> [  762.267588] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1 04/01/2014
> [  762.273190] RIP: 0010:error_entry+0x12/0x100
> 
> Test code snippet,
> main() {
> <>
>     printf("[RUN]\tMOV SS; CS CS INT3\n");
>     asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss));
> <>
> }
> 
> Reported upstream,
> https://lkml.org/lkml/2018/6/25/19

Nit, there is a better way to refer to lkml emails, see the bottom of
this page as lots of time lkml.org does not work for people:
	https://www.kernel.org/lore.html

This looks like a quemu bug, not a kernel issue, so did you tell the
qemu developers about this?

In looking at the full headers:
	https://lore.kernel.org/lkml/CA+G9fYu0E0fM+WaFim1WKup5BZvjtGZ_4ii5FhTUjNZEqaAuwA@mail.gmail.com/
it doesn't look like you did :(

thanks,

greg k-h
