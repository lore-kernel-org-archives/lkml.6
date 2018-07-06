Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6431C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A61E24017
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A61E24017
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeGFBO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753439AbeGFBOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E955EC31E;
        Fri,  6 Jul 2018 01:14:54 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBD372166BA9;
        Fri,  6 Jul 2018 01:14:53 +0000 (UTC)
Date:   Fri, 6 Jul 2018 09:14:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH] resource: Use 2-factor allocator calls
Message-ID: <20180706011450.GB2762@MiWiFi-R3L-srv>
References: <20180704173153.GA34386@beast>
 <20180705150742.82f6efdf2cd8475a5d94e84a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705150742.82f6efdf2cd8475a5d94e84a@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 01:14:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 01:14:55 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Kees, 

About the implemention of walk_system_ram_res_rev(), it was posted by
AKASHI firstly for his arm kexec_file adding, later he dropped it
because he took other way and doesn't need walk_system_ram_res_rev() any
more in his patchset.

Then I found my below patch needs a walk_system_ram_res_rev(), 

	kernel/kexec_file.c: load kernel at top of system RAM if required

so I took AKASHI's patch and posted a patchset including above patch,
and AKASHI's patch, it can be seen here:
http://lkml.kernel.org/r/20180322033722.9279-1-bhe@redhat.com

Then Andrew reviewed and added comment to say this
walk_system_ram_res_rev() is not good, and suggested me to change the
singly linked list of child resource to standard list_head which is
doubly linked list, then walk_system_ram_res_rev() can be implemented
very easily to do reversed searching. So I posted v2:
http://lkml.kernel.org/r/20180408024724.16812-1-bhe@redhat.com

Now the latest post is v6:
http://lkml.kernel.org/r/20180704041038.8190-1-bhe@redhat.com


Since changing resource child tree to take doubly linked list list_head
impacts all ARCH and many components, I am still fixing issues test
robot reported since I can only test on x86. Now I plan to ask intel
0day team to tell how I can run scripts locally for all ARCH to find out
all codes impacted and fix them all at one time.

So I think we can drop the old walk_system_ram_res_rev() in v1, I am
still working on this issue. Sorry for the confusion I made because of
my mistakes.

Thanks
Baoquan

On 07/05/18 at 03:07pm, Andrew Morton wrote:
> On Wed, 4 Jul 2018 10:31:53 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > As already done treewide, switch from open-coded multiplication to using
> > 2-factor allocation helpers.
> > 
> 
> This is against resource-add-walk_system_ram_res_rev.patch
> (http://lkml.kernel.org/r/20180322033722.9279-2-bhe@redhat.com).
> 
> That patch is awaiting (for several months!) a v2.  Will this be happening?
