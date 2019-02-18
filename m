Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADFF217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550490474;
	bh=UsS22V1FrbDB0hLJXgK6+COBj+ujyQWrJOu5+Qz48bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tA5NPJWCzZFRMiPXZZcI8EG89bEYZ3jcfJvigdKSPyJaQUqnqyhVWaxPNkjxPLbiJ
	 +yYegrd6dEhsJFi9aHKutaGh0ZvCpXkFl4CcLdpZVMoF2+m/SWl0qb/ntjfqF6i7lx
	 YU1v7JKnBntyQ3wUy48MmBp+vB3kMSLB3y56zIng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfBRLrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfBRLrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:47:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1582C2177E;
        Mon, 18 Feb 2019 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550490471;
        bh=UsS22V1FrbDB0hLJXgK6+COBj+ujyQWrJOu5+Qz48bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1g/HLYJs86Qz4BG2r+qTdgZIgobaBEe1eWfXeWN5mlTDrqsNn+JySipPkjJd+2Sw
         ay1SX1eA68BR87PCFgpwADgA6ee7d+ryMLHBgW9YSyrYBkW0exQYvJyKEjNE8ZBox/
         cvg/PAVFyvT37ynqfGkIFnWWZ0eo7cke3Vm0z/eo=
Date:   Mon, 18 Feb 2019 12:47:49 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "chenzefeng (A)" <chenzefeng2@huawei.com>
Cc:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>
Subject: Re: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Message-ID: <20190218114749.GA602@kroah.com>
References: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 02:01:31AM +0000, chenzefeng (A) wrote:
> On x86-64, for 32-bit PC-relacive branches, we can generate PLT32 relocation, instead of PC32 relocation. and R_X86_64_PLT32 can be treated the same as R_X86_64_PC32 since linux kernel doesn't use PLT.
> 
> In linux 4.4 commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as R_X86_64_PC32") been fixed for the module loading, but not fixed for livepatch relocation, which will fail to load livepatch with the error message as follow:
> relocation failed for symbol <symbol name> at <symbol address>
> 
> Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
> ---
>  arch/x86/kernel/livepatch.c | 1 +
>  1 file changed, 1 insertion(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
