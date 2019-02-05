Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9E2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h/FuhpPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfBEIvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:51:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44152 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zdajI9d7VSFDCvicm4MNrL4r4rDSMaQIMTCwHGlaDkM=; b=h/FuhpPqzy9jqdkyZkDZ11StX
        OTZ35S/dvzSjgJ6BGRDieYhmkkEN9RgYc5fcWVB77gKWOOp1rvQdxpiGprWBYVmtO+EutPDitg4AB
        NDO3qBP+fowGg3w0rZFJLP31tSAyPYhvrxTB44OoJPRWzH3t8odElk4yCc4yB+thF2CK1Axtyg/pY
        9MBlUnd7Q7yIkAj1aIicHje03WT3mIeQFWwvOghNqBt7zMqilwJ7MOiw7FO9PKjMkPNnHYKbrcJmZ
        yjzKMIshnNbTsuJttvXkcIqORc2gvFoAyN7s9eIypTjzqxcU9MHivD6fkvuw4JpR9GsTwqyzv/Bkz
        7n8wUXbQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqwRo-00023R-RR; Tue, 05 Feb 2019 08:51:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80BA62029FA06; Tue,  5 Feb 2019 09:51:15 +0100 (CET)
Date:   Tue, 5 Feb 2019 09:51:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205085115.GL17528@hirez.programming.kicks-ass.net>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204210912.GA70429@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204210912.GA70429@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 01:09:12PM -0800, Fenghua Yu wrote:

> Intel SDM published TODAY does have IA32_CORE_CAPABILITY MSR enumerateion
> bit CPUID.0x7.0:EDX[30] now. Please check today's SDM for the bit:
> https://software.intel.com/en-us/download/intel-64-and-ia-32-architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

When I click that link I get Nov'18, not Feb'19.
