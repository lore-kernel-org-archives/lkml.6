Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631D7C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258F220852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258F220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbeGXUhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:37:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388494AbeGXUhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:37:11 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67D3FC94;
        Tue, 24 Jul 2018 19:29:14 +0000 (UTC)
Date:   Tue, 24 Jul 2018 12:29:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] delayacct: Fix crash in delayacct_blkio_end() after
 delayacct init failure
Message-Id: <20180724122913.af508cf58033e9b1147e7def@linux-foundation.org>
In-Reply-To: <20180724175542.GP1934745@devbig577.frc2.facebook.com>
References: <20180724175542.GP1934745@devbig577.frc2.facebook.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 10:55:42 -0700 Tejun Heo <tj@kernel.org> wrote:

> While forking, if delayacct init fails due to memory shortage, it
> continues expecting all delayacct users to check task->delays pointer
> against NULL before dereferencing it, which all of them used to do.
> 
> c96f5471ce7d ("delayacct: Account blkio completion on the correct
> task"), while updating delayacct_blkio_end() to take the target task
> instead of always using %current, made the function test NULL on
> %current->delays and then continue to operated on @p->delays.  If
> %current succeeded init while @p didn't, it leads to the following
> crash.
> 

lgtm.

How did you make this happen, btw?  Fault injection, or did a small
GFP_KERNEL allocation fail?

