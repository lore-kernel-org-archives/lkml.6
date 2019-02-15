Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE17C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771112192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550215718;
	bh=O/XorrlCP+6osysvASAW6imQn/0HY9d7EdOL356+5WM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=P1hubZhxtAB5T+g2YD4KfJ5ZbVB4xBlAi7OeofS3j12jRjfcF0Lw20eUA7pbHbg8j
	 SUgpNQQHQR+9vUJD5541U6PLiauAMRDGRxB9+NYnhhLzWLJ7bWdFcBNU7ALffo2n7W
	 JY3xLGAjI+rBM3i2LnXHFZ2g6N/92ycbrFfnQKMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbfBOH2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfBOH2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:28:22 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A212F21920;
        Fri, 15 Feb 2019 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550215697;
        bh=O/XorrlCP+6osysvASAW6imQn/0HY9d7EdOL356+5WM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=aRozOm1Y5k5CIXOPsdCpEuVk6Kg8JR9ffGqt6YJz8YL+LtUFRNo514dqEOEuSQjkH
         WZLcMa2pKgcvgRSUNtT3xBwoNUOj4vQRRGZWRy50lvaJ9WyYfw/gI3O898LVxRD3w9
         Bs3LPLonlDARkhBuvVmsvwwO3VZq3T9HggZqBIIg=
Date:   Fri, 15 Feb 2019 08:28:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "chenzefeng (A)" <chenzefeng2@huawei.com>
cc:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>
Subject: Re: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
In-Reply-To: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
Message-ID: <nycvar.YFH.7.76.1902150826400.11598@cbobk.fhfr.pm>
References: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019, chenzefeng (A) wrote:

> On x86-64, for 32-bit PC-relacive branches, we can generate PLT32 
> relocation, instead of PC32 relocation. and R_X86_64_PLT32 can be 
> treated the same as R_X86_64_PC32 since linux kernel doesn't use PLT.
> 
> In linux 4.4 commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as 
> R_X86_64_PC32") been fixed for the module loading, but not fixed for 
> livepatch relocation, which will fail to load livepatch with the error 
> message as follow: relocation failed for symbol <symbol name> at <symbol 
> address>
> 
> Signed-off-by: chenzefeng <chenzefeng2@huawei.com>

What kernel version is this patch based on? We've got rid of x86-specific 
module loading stub and offloaded all the relocation handling to generic 
kmod loader long time ago.

-- 
Jiri Kosina
SUSE Labs

