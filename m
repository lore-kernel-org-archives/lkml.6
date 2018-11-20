Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8413EC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D8020831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecbPsISb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D8020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeKUEaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:30:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeKUEaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EXc0euKzVaK7g1CJFWlQ4ErwfgJEkzlK5fcJ1+AWcKQ=; b=ecbPsISb3Z8gjR9yhemc34NdU
        /o2cR2nLN/pBugW6elCV0e3qwfDMuCASI4nl6Y2NJaUqa5vAR9hW81fn+3PXbjRcDuy8Ek+GpPbaw
        klhmhoj0Zv0TuMEIk9MzlYK4ucE7arWk94Dqu+DGWU5X8lSfR97yBAP9VljJlW96QSqYzuvkB1Txz
        khKjOgcUmYRRqRKp1/kQEZq5HFm+JU5kzk/WlDrCglZRUOYrp0qeaCbsIG2fyxiNM+IkJN1eLlCxf
        +qw04rfCdvXCqJNYaRZSkmhF33B50AxJa5KYNGkfgYLm4sox9aHCoUCEInADHkOqxIYxyPpGCGFhl
        82evOV+8Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPAJP-0001lF-Et; Tue, 20 Nov 2018 17:59:47 +0000
Date:   Tue, 20 Nov 2018 09:59:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181120175947.GE3065@bombadil.infradead.org>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd>
 <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
 <20181120091829.GD16916@amd>
 <20181120173912.GD3065@bombadil.infradead.org>
 <CAKOZuevidVnZ+9vB1CxsetPVH=2P7eoORA1F445HOp-jS5rwOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevidVnZ+9vB1CxsetPVH=2P7eoORA1F445HOp-jS5rwOA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:48:27AM -0800, Daniel Colascione wrote:
> On Tue, Nov 20, 2018 at 9:39 AM Matthew Wilcox <willy@infradead.org> wrote:
> > We have a limit on the number of FDs a process can have open for a reason.
> > Well, for many reasons.
> 
> And the typical limit is too low. (I've seen people clamp it to 1024
> for some reason.)

1024 is the soft limit.  4096 is the default hard limit.  You can always
ask root to set your hard limit higher if that's what you need.

> A file descriptor is just a handle to a kernel
> resource. All kernel resources held on behalf of applications need
> *some* kind of management interface. File descriptors provide a
> consistent and uniform instance of such a management interface. Unless
> there's a very good reason, nobody should be using non-FD handles for
> kernel resource management. A low default FD table size limit is not
> an example of one of these good reasons, not when we can raise FD
> table size limit. In general, the software projects should not have to
> put up with ugly workarounds for limitations they impose on
> themselves.

I'm not really sure why you decided to go off on this rant.  My point to
Pavel was that there's no way a single process can tie up all of the PIDs.
Unless root decided to let them shoot everybody else in the system in
the foot.
