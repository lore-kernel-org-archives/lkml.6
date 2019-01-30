Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900EC20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfA3XOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:14:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfA3XO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:14:29 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 581AE3BB7;
        Wed, 30 Jan 2019 21:58:46 +0000 (UTC)
Date:   Wed, 30 Jan 2019 13:58:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 0/2] genirq, proc: Speedup /proc/stat interrupt
 statistics
Message-Id: <20190130135845.406c51b7f565232a7fed0de6@linux-foundation.org>
In-Reply-To: <20190130123130.785636313@linutronix.de>
References: <20190130123130.785636313@linutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 13:31:30 +0100 Thomas Gleixner <tglx@linutronix.de> wrote:

> Waiman reported that on large systems with a large amount of interrupts the
> readout of /proc/stat takes a long time to sum up the interrupt
> statistics. In principle this is not a problem. but for unknown reasons
> some enterprise quality software reads /proc/stat with a high frequency.
> 
> The reason for this is that interrupt statistics are accounted per cpu. So
> the /proc/stat logic has to sum up the interrupt stats for each interrupt.
> 
> The following series addresses this by making the interrupt statitics code
> in the core generate the sum directly and by making the loop in the
> /proc/stat read function smarter.
> 

Has the speedup been quantified?
