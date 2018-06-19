Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9FBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0022083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0022083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757209AbeFSMbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:31:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756675AbeFSMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:31:19 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVFmu-0004xH-1n; Tue, 19 Jun 2018 14:31:08 +0200
Date:   Tue, 19 Jun 2018 14:31:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 07/38] x86/intel_rdt: Initialize new resource group
 with sane defaults
In-Reply-To: <44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1806191418460.1684@nanos.tec.linutronix.de>
References: <68030110df15615d95731fd354ff7adfb0476d37.1527593970.git.reinette.chatre@intel.com> <44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018, Reinette Chatre wrote:
> +/**
> + * cbm_ensure_valid - Enforce validity on provided CBM
> + * @_val:	Candidate CBM
> + * @r:		RDT resource to which the CBM belongs
> + *
> + * The provided CBM represents all cache portions available for use. This
> + * may be represented by a bitmap that does not consist of contiguous ones
> + * and thus be an invalid CBM.
> + * Here the provided CBM is forced to be a valid CBM by only considering
> + * the first set of contiguous bits as valid and clearing all bits.
> + * The intention here is to provide a valid default CBM with which a new
> + * resource group is initialized. The user can follow this with a
> + * modification to the CBM if the default does not satisfy the
> + * requirements.
> + */
> +static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
> +{
> +	unsigned long *val = (unsigned long *)_val;

I'm a bit worried about the u32 to unsigned long case here. I know that
cbm_len cannot exceed 32, but still. At least it wants a comment.

Thanks,

	tglx


