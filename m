Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3427C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0F2214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfAJMec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:34:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33592 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfAJMec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:34:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C85A480D;
        Thu, 10 Jan 2019 04:34:31 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06A3D3F5AF;
        Thu, 10 Jan 2019 04:34:29 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:34:27 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "xiaoguangrong(Xiao Guangrong)" <xiaoguangrong@tencent.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "yulei.kernel@gmail.com" <yulei.kernel@gmail.com>,
        Stefani Seibold <stefani@seibold.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "mkelly@xevo.com" <mkelly@xevo.com>, Jiri Kosina <jkosina@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?eXVsZWl4emhhbmco5byg6KqJ56OKKQ==?= 
        <yuleixzhang@tencent.com>
Subject: Re: [PATCH] kfifo: add memory barrier in kfifo to prevent data loss
Message-ID: <20190110123427.GD27065@fuggles.cambridge.arm.com>
References: <20181211034032.32338-1-yuleixzhang@tencent.com>
 <CAGXu5jKkqf-9ksvNTCS5xgB_JtfvCc=Eot2uWYYP8rpoKLw=mg@mail.gmail.com>
 <019819C6E743904A88B43F7DDEED99BBA7E74E37@EXMBX-SZMAIL006.tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <019819C6E743904A88B43F7DDEED99BBA7E74E37@EXMBX-SZMAIL006.tencent.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 07:43:10AM +0000, xiaoguangrong(Xiao Guangrong) wrote:
> On 12/12/18 8:50 AM, Kees Cook wrote:
> > On Mon, Dec 10, 2018 at 7:41 PM <yulei.kernel@gmail.com> wrote:
> >>
> >> From: Yulei Zhang <yuleixzhang@tencent.com>
> >>
> >> Early this year we spot there may be two issues in kernel
> >> kfifo.
> >>
> >> One is reported by Xiao Guangrong to linux kernel.
> >> https://lkml.org/lkml/2018/5/11/58
> >> In current kfifo implementation there are missing memory
> >> barrier in the read side, so that without proper barrier
> >> between reading the kfifo->in and fetching the data there
> >> is potential ordering issue.
> >>
> >> Beside that, there is another potential issue in kfifo,
> >> please consider the following case:
> >> at the beginning
> >> ring->size = 4
> >> ring->out = 0
> >> ring->in = 4
> >>
> >>      Consumer                        Producer
> >> ---------------                  --------------
> >> index = ring->out; /* index == 0 */
> >> ring->out++; /* ring->out == 1 */
> >> < Re-Order >
> >>                                   out = ring->out;
> >>                                   if (ring->in - out >= ring->mask)
> >>                                       return -EFULL;
> >>                                   /* see the ring is not full */
> >>                                   index = ring->in & ring->mask;
> >>                                   /* index == 0 */
> >>                                   ring->data[index] = new_data;
> >> 　　　　　　　　　　　　　　　　 ring->in++;
> >>
> >> data = ring->data[index];
> >> /* you will find the old data is overwritten by the new_data */
> >>
> >> In order to avoid the issue:
> >> 1) for the consumer, we should read the ring->data[] out before
> >> updating ring->out
> >> 2) for the producer, we should read ring->out before updating
> >> ring->data[]
> >>
> >> So in this patch we introduce the following four functions which
> >> are wrapped with proper memory barrier and keep in pairs to make
> >> sure the in and out index are fetched and updated in order to avoid
> >> data loss.
> >>
> >> kfifo_read_index_in()
> >> kfifo_write_index_in()
> >> kfifo_read_index_out()
> >> kfifo_write_index_out()
> >>
> >> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> >> Signed-off-by: Guangrong Xiao <xiaoguangrong@tencent.com>
> > 
> > I've added some more people to CC that might want to see this. Thanks
> > for sending this!
> 
> Hi,
> 
> Ping... could anyone have a look? ;)

I've started looking at kfifo, but I suspect it needs a fair amount more
work than your patch. Please stay tuned.

Will
