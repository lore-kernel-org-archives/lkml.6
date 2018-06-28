Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340D6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CC32721B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CC32721B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeF1K1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:27:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752350AbeF1K1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:27:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0420180D;
        Thu, 28 Jun 2018 03:27:49 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999D23F266;
        Thu, 28 Jun 2018 03:27:44 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:27:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
 <20180628061758.j6bytsaj5jk4aocg@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628061758.j6bytsaj5jk4aocg@ltop.local>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 08:17:59AM +0200, Luc Van Oostenryck wrote:
> On Wed, Jun 27, 2018 at 06:17:58PM +0100, Catalin Marinas wrote:
> > sparse is indeed an option. The current implementation doesn't warn on
> > an explicit cast from (void __user *) to (unsigned long) since that's a
> > valid thing in the kernel. I couldn't figure out if there's any other
> > __attribute__ that could be used to warn of such conversion.
> 
> sparse doesn't have such attribute but would an new option that would warn
> on such cast be a solution for your case?

I can't tell for sure whether such sparse option would be the full
solution but detecting explicit __user pointer casts to long is a good
starting point. So far this patchset pretty much relies on detecting
a syscall failure and trying to figure out why, patching the kernel. It
doesn't really scale.

As a side note, we have cases in the user-kernel ABI where the user
address type is "unsigned long": mmap() and friends. My feedback on an
early version of this patchset was to always require untagged pointers
coming from user space on such syscalls, so no need for explicit
untagging.

-- 
Catalin
