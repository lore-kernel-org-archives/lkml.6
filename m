Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A0B21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546508342;
	bh=tIuOwBoDNPFBYczIQ+f0QpEYcT8fDPEDg7wsSAJAs6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AFT2wIBwTkE89Y4D/A1dlvXNP4ChYCYU/J70ayti9EOJ3JrAoLMEJ1YRo8yT31tgb
	 R3nHSsOsLkWOmag8xaJ14LWUAztz9M9booniwwD1DqQu8+LOZFT3VlTs51vtGrwxbs
	 weO20auWfxYlLXzYglRr4eFDQYv12IfqihowSnkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfACJjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:39:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfACJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:39:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8B221019;
        Thu,  3 Jan 2019 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546508340;
        bh=tIuOwBoDNPFBYczIQ+f0QpEYcT8fDPEDg7wsSAJAs6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r75D68V+JMNpKK7qdQJyRlNEY4d3Sn/iZ9LMQQzQtTOPlGM2penXmKnJMxgiK+TtX
         XFBM9g7yaTwT7SAzXEt6KS6TgKliSKONEM1uzwED1ZTnPdeBq4mYp3K4uWEQLg04B5
         HgSJVUysJDX3P8JCd/CAorgPyjYvPk4Peq2nz2Z0=
Date:   Thu, 3 Jan 2019 10:38:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, marc.zyngier@arm.com, suzuki.poulose@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, steven.price@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190103093858.GA10794@kroah.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103004921.1928921-2-jeremy.linton@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> There is a lot of variation in the Arm ecosystem. Because of this,
> there exist possible cases where the kernel cannot authoritatively
> determine if a machine is vulnerable.

Really?  Why not?  What keeps you from "knowing" this?  Can't the
developer of the chip tell you?

> Rather than guess the vulnerability status in cases where
> the mitigation is disabled or the firmware isn't responding
> correctly, we need to display an "Unknown" state.

Shouldn't "Unknown" really be the same thing as "Vulnerable"?  A user
should treat it the same way, "Unknown" makes it feel like "maybe I can
just ignore this and hope I really am safe", which is not a good idea at
all.

thanks,

greg k-h
