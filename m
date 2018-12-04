Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE618C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBDE20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBDE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeLDRHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:07:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:33173 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDRHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:07:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 09:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="115584689"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2018 09:07:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 051A6300F9B; Tue,  4 Dec 2018 09:07:00 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <balbirs@au1.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS) documentation
References: <20181203233509.20671-1-jglisse@redhat.com>
        <20181203233509.20671-3-jglisse@redhat.com>
Date:   Tue, 04 Dec 2018 09:06:59 -0800
In-Reply-To: <20181203233509.20671-3-jglisse@redhat.com> (jglisse's message of
        "Mon, 3 Dec 2018 18:34:57 -0500")
Message-ID: <875zw98bm4.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jglisse@redhat.com writes:

> +
> +To help with forward compatibility each object as a version value and
> +it is mandatory for user space to only use target or initiator with
> +version supported by the user space. For instance if user space only
> +knows about what version 1 means and sees a target with version 2 then
> +the user space must ignore that target as if it does not exist.

So once v2 is introduced all applications that only support v1 break.

That seems very un-Linux and will break Linus' "do not break existing
applications" rule.

The standard approach that if you add something incompatible is to
add new field, but keep the old ones.

> +2) hbind() bind range of virtual address to heterogeneous memory
> +================================================================
> +
> +So instead of using a bitmap, hbind() take an array of uid and each uid
> +is a unique memory target inside the new memory topology description.

You didn't define what an uid is?

user id?

Please use sensible terminology that doesn't conflict with existing
usages.

I assume it's some kind of number that identifies a node in your
graph. 

> +User space also provide an array of modifiers. Modifier can be seen as
> +the flags parameter of mbind() but here we use an array so that user
> +space can not only supply a modifier but also value with it. This should
> +allow the API to grow more features in the future. Kernel should return
> +-EINVAL if it is provided with an unkown modifier and just ignore the
> +call all together, forcing the user space to restrict itself to modifier
> +supported by the kernel it is running on (i know i am dreaming about well
> +behave user space).

It sounds like you're trying to define a system call with built in
ioctl? Is that really a good idea?

If you need ioctl you know where to find it.

Please don't over design APIs like this.

> +3) Tracking and applying heterogeneous memory policies
> +======================================================
> +
> +Current memory policy infrastructure is node oriented, instead of
> +changing that and risking breakage and regression HMS adds a new
> +heterogeneous policy tracking infra-structure. The expectation is
> +that existing application can keep using mbind() and all existing
> +infrastructure under-disturb and unaffected, while new application
> +will use the new API and should avoid mix and matching both (as they
> +can achieve the same thing with the new API).

I think we need a stronger motivation to define a completely
parallel and somewhat redundant infrastructure. What breakage
are you worried about?

The obvious alternative would of course be to add some extra
enumeration to the existing nodes.

It's a strange document. It goes from very high level to low level
with nothing inbetween. I think you need a lot more details
in the middle, in particularly how these new interfaces
should be used. For example how should an application
know how to look for a specific type of device?
How is an automated tool supposed to use the enumeration?
etc.

-Andi
