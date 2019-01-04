Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC489C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A222087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfADD05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:26:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:35610 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfADD04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:26:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x043Q4ms011435;
        Thu, 3 Jan 2019 21:26:05 -0600
Message-ID: <7bbf788adeac78da48a83b100f820b962b16ba19.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi:fsi-sbefifo: Fix possible concurrency
 use-after-free bugs in sbefifo_user_release
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, dhowells@redhat.com,
        joel@jms.id.au, eajames@linux.vnet.ibm.com, andrew@aj.id.au
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 04 Jan 2019 14:26:03 +1100
In-Reply-To: <798fbb98-0cba-07f8-2165-180c63012e95@gmail.com>
References: <20181226135618.12784-1-baijiaju1990@gmail.com>
         <0adee96b58a533bc8c5927039e96b5ed77c9bbad.camel@kernel.crashing.org>
         <798fbb98-0cba-07f8-2165-180c63012e95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-04 at 10:26 +0800, Jia-Ju Bai wrote:
> 
> On 2019/1/4 8:47, Benjamin Herrenschmidt wrote:
> > On Wed, 2018-12-26 at 21:56 +0800, Jia-Ju Bai wrote:
> > > In drivers/fsi/fsi-sbefifo.c, the functions sbefifo_user_release(),
> > > sbefifo_user_read() and sbefifo_user_write() may be concurrently executed.
> > So after refreshing my mind, looking at the code and talking with Al, I
> > really dont' see what race you are trying to fix here.
> > 
> > read/write should never be concurrent with release for a given file and
> > the stuff we are protecting here is local to the file instance.
> > 
> > Do you have an actual problem you observed ?
> > 
> 
> Thanks for the reply.
> 
> In fact, this report is found by a static tool written by myself, 
> instead of real execution.
> My tool found that in some drivers, for the structure "struct 
> file_operations", the code in intetrfaces ".read" , "write" and 
> ".release" are protected by the same lock.
> The functions kcs_bmc_read(), kcs_bmc_write() and kcs_bmc_release() are 
> examples.
> Thus, my tool inferred that the intetrfaces ".read" , "write" and 
> ".release" of "struct file_operations" can be concurrently executed, and 
> generated this report.
> I manually checked this report, but I was not very sure of it, so I 
> marked it as a "possible bug" and reported it.

So what happens is that they cannot be executed concurrently for a
given struct file. But they can be for separate files.

In the fsi-sbefifo case, all of the data and the lock are part of a
private structure which is allocated in open() and thus is per-file
instance, so there should be no race.

In the example you gave, kcs_bmc.c, the data and lock are part of a
per-device (struct kcs_bmc) and thus shared by all file instances. So
in that case, the race does exist.

>  From your message, now I know my report is false, and ".read" , "write" 
> cannot be concurrently executed with ".release" for a given file.
> Sorry for my false report, and thanks for your message.

Right, your tool is valuable as pre-screening but you need in addition
to check (probably manually) whether the data accessed (and lock) are
shared by multiple open file instances or are entirely local to a given
file instance.

Cheers,
Ben.

