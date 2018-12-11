Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA991C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6F420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6F420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeLKOlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:41:46 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4FCA2054F;
        Tue, 11 Dec 2018 14:41:42 +0000 (UTC)
Date:   Tue, 11 Dec 2018 09:41:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>, jeffm@suse.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, Tim.Bird@sony.com,
        khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181211094140.2a928fe7@gandalf.local.home>
In-Reply-To: <20181211140926.7wzd5jh6klcfsfgz@pathway.suse.cz>
References: <20181128193636.254378-1-brendanhiggins@google.com>
        <20181128193636.254378-12-brendanhiggins@google.com>
        <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
        <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
        <20181204204701.GT28501@garbanzo.do-not-panic.com>
        <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
        <20181206153718.GD24603@bombadil.infradead.org>
        <20181211140926.7wzd5jh6klcfsfgz@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 15:09:26 +0100
Petr Mladek <pmladek@suse.com> wrote:

> > We have liburcu already, which is good.  The main sticking points are:
> > 
> >  - printk has started adding a lot of %pX enhancements which printf
> >    obviously doesn't know about.  
> 
> I wonder how big problem it is and if it is worth using another
> approach.

No, please do not change the %pX approach.

> 
> An alternative would be to replace them with helper functions
> the would produce the same string. The meaning would be easier
> to understand. But concatenating with the surrounding text
> would be less elegant. People might start using pr_cont()
> that is problematic (mixed lines).
> 
> Also the %pX formats are mostly used to print context of some
> structures. Even the helper functions would need some maintenance
> to keep them compatible.
> 
> BTW: The printk() feature has been introduced 10 years ago by
> the commit 4d8a743cdd2690c0bc8 ("vsprintf: add infrastructure
> support for extended '%p' specifiers").

trace-cmd and perf know about most of the %pX data and how to read it.
Perhaps we can extend the libtraceevent library to export a generic way
to read data from printk() output for other tools to use.

-- Steve
