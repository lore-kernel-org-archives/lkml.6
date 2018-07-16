Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407F7208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407F7208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeGPLTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:19:07 -0400
Received: from foss.arm.com ([217.140.101.70]:56800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbeGPLTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:19:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D11418A;
        Mon, 16 Jul 2018 03:52:16 -0700 (PDT)
Received: from [10.1.210.39] (ostrya.cambridge.arm.com [10.1.210.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98BCF3F589;
        Mon, 16 Jul 2018 03:52:14 -0700 (PDT)
Subject: Re: [PATCH 00/10] iommu/vt-d: Add scalable mode support
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, jacob.jun.pan@intel.com
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
Date:   Mon, 16 Jul 2018 11:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/07/18 07:49, Lu Baolu wrote:
> Intel vt-d rev3.0 [1] introduces a new translation mode called
> 'scalable mode', which enables PASID-granular translations for
> first level, second level, nested and pass-through modes. The
> vt-d scalable mode is the key ingredient to enable Scalable I/O
> Virtualization (Scalable IOV) [2] [3], which allows sharing a
> device in minimal possible granularity (ADI - Assignable Device
> Interface). It also includes all the capabilities required to
> enable Shared Virtual Addressing (SVA). As a result, previous
> Extended Context (ECS) mode is deprecated (no production ever
> implements ECS).
> 
> Each scalable mode pasid table entry is 64 bytes in length, with
> fields point to the first level page table and the second level
> page table. The PGTT (Pasid Granular Translation Type) field is
> used by hardware to determine the translation type.

Looks promising! Since the 2nd level page tables are in the PASID entry,
the hypervisor traps guest accesses to the PASID tables instead of
passing through the whole PASID directory? Are you still planning to use
the VFIO BIND_PASID_TABLE interface in this mode, or a slightly
different one for individual PASIDs?

Thanks,
Jean
