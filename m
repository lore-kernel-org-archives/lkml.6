Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE68C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D22120BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D22120BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeGLLjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:39:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:8878 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbeGLLjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:39:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 04:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,342,1526367600"; 
   d="scan'208";a="72156327"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2018 04:30:06 -0700
Message-ID: <5B473CB8.1050306@intel.com>
Date:   Thu, 12 Jul 2018 19:34:16 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Michal Hocko <mhocko@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com> <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com> <5B455D50.90902@intel.com> <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com> <20180711092152.GE20050@dhcp22.suse.cz> <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com> <5B46BB46.2080802@intel.com> <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com> <5B46C258.40601@intel.com> <20180712081317.GD32648@dhcp22.suse.cz>
In-Reply-To: <20180712081317.GD32648@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 04:13 PM, Michal Hocko wrote:
> On Thu 12-07-18 10:52:08, Wei Wang wrote:
>> On 07/12/2018 10:30 AM, Linus Torvalds wrote:
>>> On Wed, Jul 11, 2018 at 7:17 PM Wei Wang <wei.w.wang@intel.com> wrote:
>>>> Would it be better to remove __GFP_THISNODE? We actually want to get all
>>>> the guest free pages (from all the nodes).
>>> Maybe. Or maybe it would be better to have the memory balloon logic be
>>> per-node? Maybe you don't want to remove too much memory from one
>>> node? I think it's one of those "play with it" things.
>>>
>>> I don't think that's the big issue, actually. I think the real issue
>>> is how to react quickly and gracefully to "oops, I'm trying to give
>>> memory away, but now the guest wants it back" while you're in the
>>> middle of trying to create that 2TB list of pages.
>> OK. virtio-balloon has already registered an oom notifier
>> (virtballoon_oom_notify). I plan to add some control there. If oom happens,
>> - stop the page allocation;
>> - immediately give back the allocated pages to mm.
> Please don't. Oom notifier is an absolutely hideous interface which
> should go away sooner or later (I would much rather like the former) so
> do not build a new logic on top of it. I would appreciate if you
> actually remove the notifier much more.
>
> You can give memory back from the standard shrinker interface. If we are
> reaching low reclaim priorities then we are struggling to reclaim memory
> and then you can start returning pages back.

OK. Just curious why oom notifier is thought to be hideous, and has it 
been a consensus?

Best,
Wei
