Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4429BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4202083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4202083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLGPei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:34:38 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:50703 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLGPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:34:36 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gVI93-0000EJ-PF; Fri, 07 Dec 2018 15:34:25 +0000
Message-ID: <1544196864.2867.70.camel@codethink.co.uk>
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     mike.kravetz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Eric Munson <emunson@mgebm.net>
Date:   Fri, 07 Dec 2018 15:34:24 +0000
In-Reply-To: <20181207144157.GB20201@kroah.com>
References: <20181206143011.174892052@linuxfoundation.org>
         <CA+G9fYtzxd9a=OVr=Uwcouqikpe2EB_WJyuBhO7BX96mYWJ1NQ@mail.gmail.com>
         <20181207144157.GB20201@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 15:41 +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 07, 2018 at 02:40:26PM +0530, Naresh Kamboju wrote:
> > On Thu, 6 Dec 2018 at 20:15, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > This is the start of the stable review cycle for the 4.9.144 release.
> > > There are 101 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.144-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > Mike Kravetz <mike.kravetz@oracle.com>
> > >     hugetlbfs: check for pgoff value overflow
> > > 
> > > Mike Kravetz <mike.kravetz@oracle.com>
> > >     hugetlbfs: fix offset overflow in hugetlbfs mmap
> > > 
> > > Mike Kravetz <mike.kravetz@oracle.com>
> > >     mm/hugetlb.c: don't call region_abort if region_chg fails
> > 
> > Results from Linaro’s test farm.
> > Regressions detected on arm32 and i386.
> > 
> > truncate_above_4GB (2M: 32): FAIL mmap() offset 4GB: Invalid argument
> 
> Can this be tracked down to a commit in this tree that caused this
> regression?

The test failure is part of a hugetlb test group, so one of the above
is responsible.

Ah, I missed this fix (it's already in 4.14-stable:

commit 5df63c2a149ae65a9ec239e7c2af44efa6f79beb
Author: Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu Apr 5 16:18:21 2018 -0700

    hugetlbfs: fix bug in pgoff overflow checking

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
