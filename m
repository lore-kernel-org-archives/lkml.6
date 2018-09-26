Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073EBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10242154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10242154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeI0Ev2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:51:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeI0Ev1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:51:27 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54D21100B;
        Wed, 26 Sep 2018 22:36:17 +0000 (UTC)
Date:   Wed, 26 Sep 2018 15:36:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pavel.tatashin@microsoft.com,
        dave.jiang@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 2/4] mm: Provide kernel parameter to allow disabling
 page init poisoning
Message-Id: <20180926153615.90661e27d0713a02651b2282@linux-foundation.org>
In-Reply-To: <f5648747-642f-763e-80b9-24fb203c85e9@intel.com>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
        <20180925201921.3576.84239.stgit@localhost.localdomain>
        <20180926073831.GC6278@dhcp22.suse.cz>
        <f5648747-642f-763e-80b9-24fb203c85e9@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 08:36:47 -0700 Dave Hansen <dave.hansen@intel.com> wrote:

> On 09/26/2018 12:38 AM, Michal Hocko wrote:
> > Why cannot you simply go with [no]vm_page_poison[=on/off]?
> 
> I was trying to look to the future a bit, if we end up with five or six
> more other options we want to allow folks to enable/disable.  I don't
> want to end up in a situation where we have a bunch of different knobs
> to turn all this stuff off at runtime.
> 
> I'd really like to have one stop shopping so that folks who have a
> system that's behaving well and don't need any debugging can get some of
> their performance back.
> 
> But, the *primary* thing we want here is a nice, quick way to turn as
> much debugging off as we can.  A nice-to-have is a future-proof,
> slub-style option that will centralize things.

Yup.  DEBUG_VM just covers too much stuff nowadays.  A general way to
make these thing more fine-grained and without requiring a rebuild
would be great.

And I expect that quite a few of the debug features could be
enabled/disabled after bootup as well, so a /proc knob is probably in
our future.  Any infrastructure which is added to support a new
kernel-command-line option should be designed with that in mind.

