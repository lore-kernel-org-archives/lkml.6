Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeB0NnS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:43:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753177AbeB0NnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:43:16 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1519738149.4300.45.camel@redhat.com>
References: <1519738149.4300.45.camel@redhat.com> <20180225150505.GD7144@yexl-desktop> <1519573271.4702.10.camel@redhat.com> <20180226083807.GE8942@yexl-desktop> <1519645434.4443.15.camel@redhat.com> <1519648433.4443.18.camel@redhat.com> <8b48844f-7f9a-a9d7-b5bc-3bc403e0fa78@intel.com>
To: Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, kemi <kemi.wang@intel.com>,
        Ye Xiaolong <xiaolong.ye@intel.com>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [lkp-robot] [iversion] c0cef30e4f: aim7.jobs-per-min -18.0% regression
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <665.1519738993.1@warthog.procyon.org.uk>
Date: Tue, 27 Feb 2018 13:43:13 +0000
Message-ID: <666.1519738993@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

>    0xffffffff813ae828 <+136>:	je     0xffffffff813ae83a <ima_file_free+154>
>    0xffffffff813ae82a <+138>:	mov    0x150(%rbp),%rcx
>    0xffffffff813ae831 <+145>:	shr    %rcx
>    0xffffffff813ae834 <+148>:	cmp    %rcx,0x20(%rax)
>    0xffffffff813ae838 <+152>:	je     0xffffffff813ae862 <ima_file_free+194>

Is it possible there's a stall between the load of RCX and the subsequent
instructions because they all have to wait for RCX to become available?

The interleaving between operating on RSI and RCX in the older code might
alleviate that.

In addition, the load if the 20(%rax) value is now done in the CMP instruction
rather than earlier, so it might not get speculatively loaded in time, whereas
the earlier code explicitly loads it up front.

David
