Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeB0P1z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:27:55 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:46421 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeB0P1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:27:53 -0500
X-Google-Smtp-Source: AG47ELs33oeW5TvDfC62RIRE1OJWPZkEgW6KynvE61JJJ+foXkjnTKm6tVQBlC6oF9sn1Iq6DtXJcA==
Message-ID: <1519745270.4300.83.camel@redhat.com>
Subject: Re: [LKP] [lkp-robot] [iversion] c0cef30e4f: aim7.jobs-per-min
 -18.0% regression
From: Jeff Layton <jlayton@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: kemi <kemi.wang@intel.com>, Ye Xiaolong <xiaolong.ye@intel.com>,
        lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 27 Feb 2018 10:27:50 -0500
In-Reply-To: <666.1519738993@warthog.procyon.org.uk>
References: <1519738149.4300.45.camel@redhat.com>
         <20180225150505.GD7144@yexl-desktop> <1519573271.4702.10.camel@redhat.com>
         <20180226083807.GE8942@yexl-desktop> <1519645434.4443.15.camel@redhat.com>
         <1519648433.4443.18.camel@redhat.com>
         <8b48844f-7f9a-a9d7-b5bc-3bc403e0fa78@intel.com>
         <666.1519738993@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-27 at 13:43 +0000, David Howells wrote:
> Jeff Layton <jlayton@redhat.com> wrote:
> 
> >    0xffffffff813ae828 <+136>:	je     0xffffffff813ae83a <ima_file_free+154>
> >    0xffffffff813ae82a <+138>:	mov    0x150(%rbp),%rcx
> >    0xffffffff813ae831 <+145>:	shr    %rcx
> >    0xffffffff813ae834 <+148>:	cmp    %rcx,0x20(%rax)
> >    0xffffffff813ae838 <+152>:	je     0xffffffff813ae862 <ima_file_free+194>
> 
> Is it possible there's a stall between the load of RCX and the subsequent
> instructions because they all have to wait for RCX to become available?
> 
> The interleaving between operating on RSI and RCX in the older code might
> alleviate that.
> 
> In addition, the load if the 20(%rax) value is now done in the CMP instruction
> rather than earlier, so it might not get speculatively loaded in time, whereas
> the earlier code explicitly loads it up front.
> 

Thanks David, that makes sense.

At this point, I think we ought to wait and see what the results look
like without IMA compiled in at all.

It's possible we're misunderstanding this completely. At most, we'll be
hitting this once on every close of a file. It doesn't seem like that
ought to be causing something this noticeable though.
-- 
Jeff Layton <jlayton@redhat.com>
