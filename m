Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754681AbeDYOt1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:49:27 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:60450 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753327AbeDYOt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:49:26 -0400
Date: Wed, 25 Apr 2018 15:48:52 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180425154852.2486f267@alans-desktop>
In-Reply-To: <20180425131958.hhapvc3b2i3b4pgy@lakrids.cambridge.arm.com>
References: <20180419051510.GA21898@mwanda>
        <20180425131958.hhapvc3b2i3b4pgy@lakrids.cambridge.arm.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) Compiler transformations can elide binary operations, so we cannot
>    rely on source level AND (&) or MOD (%) operations to narrow the
>    range of an expression, regardless of the types of either operand.
> 
>    This means that source-level AND and MOD operations cannot be relied
>    upon under speculation.

You need to use volatiles and memory barriers if trying to do it
explicitly in C. The compilers will do some really quite insanely
brilliant things otherwise. That's one reason that not using fences is
really tricky and belongs wrapped in helpers.

> I suspect this means *many* more potential spectre gadgets. :(

I expect so as well as probably a lot of false positives - the tools in
the space are all pretty new.

Array access isn't always needed either. Remember that something as
simple as

	x = size_table[user];
	memset(buf, 0, x);

can speculatively reveal things, as can 'classical' side channels such as
variable length instruction timings.

Alan
