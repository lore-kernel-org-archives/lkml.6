Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F2BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6E22082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pq14H4g0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6E22082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeJ3ABt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:01:49 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38576 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbeJ3ABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aQyW1iGgeDAjWkuahUCBcMcb9F2dD9H0+yGaYLqFNNY=; b=Pq14H4g0D7b9Zb5SUXupUiZxG
        APb5TPbjX5iUqOiP4pPiAVxIMsKUR/tKydvUjMJYskRSiaejIlri+k0Bi+Oc/5j+CaGcwtypvr7Yw
        VsCQSvNoX6kpNCyiJAKeP7rYcAyBzdW+Y8uhFCb2W5+mXytwfYgT4OkQ+BVn2g+vm2/Hs=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:32769)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gH9DW-0005BI-6h; Mon, 29 Oct 2018 15:12:34 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gH9DT-0002Oa-1a; Mon, 29 Oct 2018 15:12:31 +0000
Date:   Mon, 29 Oct 2018 15:12:29 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Cc:     "tony@atomide.com" <tony@atomide.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: mm: fault: check ADFSR in case of abort
Message-ID: <20181029151228.GG30658@n2100.armlinux.org.uk>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 02:20:51PM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> When running into situations like:
> "Unhandled fault: synchronous external abort (0x210) at 0xXXX"
> or
> "Unhandled prefetch abort: synchronous external abort (0x210) at 0xXXX"
> it is useful to know the content of ADFSR (Auxiliary Data Fault Status
> Register) to indicate an ECC double-bit error in L1 or L2 cache.
> 
> Refer to:
> Cortex-A15 Technical Reference Manual, Revision: r2p1
> [6.4.8. Error Correction Code]

This is CPU independent code, and so must only access registers that are
present on all CPUs which may run that code.

Here's the extract from the ARM ARM for the ADFSR and AIFSR:

  The position of these registers is architecturally-defined, but the
  content and use of the registers is IMPLEMENTATION DEFINED. An
  implementation can use these registers to return additional fault
  status information. An example use of these registers is to return
  more information for diagnosing parity errors.

So by testing bits in this register, you are making use of
implementation defined values.

It also goes on to say:

  These registers are not implemented in architecture versions before
  ARMv7.

So before ARMv7, we have to take note of the unimplemented CP15 rules:

2. In an allocated CP15 primary register, accesses to all unallocated
   encodings are UNPREDICTABLE for accesses at PL1 or higher.  This
   means that any MCR or MRC access from PL1 or higher with a
   combination of <CRn>, <opc1>, <CRm> and <opc2> values not shown in,
   or referenced from, Full list of VMSA CP15 registers, by coprocessor
   register number on page B3-1481, that would access an allocated
   CP15 primary register, is UNPREDICTABLE. As indicated by rule 1, for
   the ARMv7-Aarchitecture, the allocated CP15 primary registers are:
   • in any VMSA implementation, c0-c3, c5-c11, c13, and c15
   ...

So I'd prefer if we didn't attempt to read this register on CPUs where
this isn't explicitly implemented.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
