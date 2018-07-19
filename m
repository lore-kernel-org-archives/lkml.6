Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94005ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445022084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445022084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeGSDEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:04:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730811AbeGSDEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:04:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 019F087A74;
        Thu, 19 Jul 2018 02:23:40 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-145.pek2.redhat.com [10.72.12.145])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E841C55D;
        Thu, 19 Jul 2018 02:23:30 +0000 (UTC)
Date:   Thu, 19 Jul 2018 10:23:25 +0800
From:   Dave Young <dyoung@redhat.com>
To:     James Morse <james.morse@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180719022325.GA2773@dhcp-128-65.nay.redhat.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180716122623.GB7160@dhcp-128-65.nay.redhat.com>
 <c8c09929-165a-b710-6993-0b149a0c3b99@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c09929-165a-b710-6993-0b149a0c3b99@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 02:23:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 02:23:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
On 07/18/18 at 05:52pm, James Morse wrote:
> Hi Dave, Akashi,
> 
> On 16/07/18 13:26, Dave Young wrote:
> > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> >> Memblock list is another source for usable system memory layout.
> >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> >> other memblock-based architectures, particularly arm64, can also utilise
> >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> >> into the existing arch_kexec_walk_mem() for general use, either resource
> >> list or memblock list.
> >>
> >> A consequent function will not work for kdump with memblock list, but
> >> this will be fixed in the next patch.
> > 
> > If this breaks something, then it would be good to fold the following
> > patch in this patch so that bisect can still work?
> 
> This patch is just moving code from arch/powerpc that is generic.
> powerpc doesn't support kdump via kexec_file, so nothing is damaged by adding
> this new code in the next patch.
> 
> arm64 would need this kdump support, but it doesn't use it until patch 11.

Ok, then I'm fine with it, thanks for the explanation.

> 
> 
> Thanks,
> 
> James

Thanks
Dave
