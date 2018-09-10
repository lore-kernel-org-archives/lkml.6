Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2721820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ly9spqar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2721820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeIJQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:22:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeIJQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MjN4hz016Kg5WJj/fDrDRPZSMdNeZsVRjeo+mCWCUh4=; b=Ly9spqarxkIWE1mdAXahmYszr
        8G/7WNhylhi/rzpIuNdK22DH8Fu74AbUAAeu4xfcI0/3MgavKbHCVFcBFJNOkAFEVbuwsKSpmAyCW
        OJJ0fuGJswXcCJu2xxtcnBh7gZn01ttOnSO6IuHVZRbcBFBozMdJcmB8HVL8YHwo8ys7KqY65u28p
        xxdwzzESNnVWpgXGbx7JeRKtMNhKzii/xe3gHTz11QpwCcVs6iH/ZbCKxyfiCF070lup0wF20B4Dq
        hIjSpScdFRsoCzyXrB5ZVv5lLMz+OuivAtfmrQHrR8YvU19hSZqBEEf5juEmpgpfuIrjg3tyRYP4w
        d6U/BVtWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzKNR-0007kv-R8; Mon, 10 Sep 2018 11:29:09 +0000
Date:   Mon, 10 Sep 2018 04:29:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org, mark.rutland@arm.com,
        Damien.LeMoal@wdc.com, jason@lakedaemon.net,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, dmitriy@oss-tech.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 11/12] RISC-V: Use Linux logical cpu number instead of
 hartid
Message-ID: <20180910112909.GJ12979@infradead.org>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-12-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536221135-182613-12-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:05:34AM -0700, Atish Patra wrote:
> Setup the cpu_logical_map during boot. Moreover, every SBI call
> and PLIC context are based on the physical hartid. Use the logical
> cpu to hartid mapping to pass correct hartid to respective functions.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by  : Anup Patel <anup@brainfault.org>

Same whitespace issue here.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
