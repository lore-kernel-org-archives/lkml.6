Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78942075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKoiWVS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78942075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeJWXug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:50:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWXug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5d6BfSSnqZv5s5EkgVe/s7U5D4MKONerriVnO9DzggY=; b=iKoiWVS5QPZEtUonfO5txCoTg
        GQZyl+lxvsfr6OH2HAw7KHkNO6DwQCwT9nPIJ6Wj5jbv3QBpJZaWYpTWG7wxqnxB7a+cPYpBvkktF
        88/zrzdgCM6YFp0s3mZPsoVbpui3YgnIlzGEvYfxoMnzNv5cBsQqnVKsE0ILeFSIw1Ba99ddkH2YT
        /e4vBddEvmB64Z+EKTpjWJVPj/64nvYdcaL89VAiTWJKsJO9yLxDDGLbZUWNAbn9Rt67Q3/U7tUvd
        E6z8J+pMhRMZLCFVIDziOhmmGuIDiFEU+8bWMxehfUZNgXt0cGwGfsnjCwi+xq14frT9LuE0SCWO+
        zQawPECqA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEyZs-0001My-GN; Tue, 23 Oct 2018 15:26:40 +0000
Date:   Tue, 23 Oct 2018 08:26:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181023152640.GD20085@bombadil.infradead.org>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:02:56AM -0600, Shuah Khan wrote:
> Hi Michal,
> 
> On 10/23/2018 01:23 AM, Michal Hocko wrote:
> > Hi Shuah,
> > 
> > On Mon 22-10-18 18:52:53, Uladzislau Rezki wrote:
> >> On Mon, Oct 22, 2018 at 02:51:42PM +0200, Michal Hocko wrote:
> >>> Hi,
> >>> I haven't read through the implementation yet but I have say that I
> >>> really love this cover letter. It is clear on intetion, it covers design
> >>> from high level enough to start discussion and provides a very nice
> >>> testing coverage. Nice work!
> >>>
> >>> I also think that we need a better performing vmalloc implementation
> >>> long term because of the increasing number of kvmalloc users.
> >>>
> >>> I just have two mostly workflow specific comments.
> >>>
> >>>> A test-suite patch you can find here, it is based on 4.18 kernel.
> >>>> ftp://vps418301.ovh.net/incoming/0001-mm-vmalloc-stress-test-suite-v4.18.patch
> >>>
> >>> Can you fit this stress test into the standard self test machinery?
> >>>
> >> If you mean "tools/testing/selftests", then i can fit that as a kernel module.
> >> But not all the tests i can trigger from kernel module, because 3 of 8 tests
> >> use __vmalloc_node_range() function that is not marked as EXPORT_SYMBOL.
> > 
> > Is there any way to conditionally export these internal symbols just for
> > kselftests? Or is there any other standard way how to test internal
> > functionality that is not exported to modules?
> > 
> 
> The way it can be handled is by adding a test module under lib. test_kmod,
> test_sysctl, test_user_copy etc.

The problem is that said module can only invoke functions which are
exported using EXPORT_SYMBOL.  And there's a cost to exporting them,
which I don't think we're willing to pay, purely to get test coverage.

Based on my own experience with the IDA & XArray test suites, I would
like to propose a solution which does not require exporting all of
these symbols:

Create a new kernel module in mm/test_vmalloc.c

Towards the top of that file,

#include <linux/export.h>
#undef EXPORT_SYMBOL
#define EXPORT_SYMBOL(x)	/* */
#include "vmalloc.c"

Now you can invoke even static functions from your test harness.
