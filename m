Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE12C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B5C208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B5C208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbeHWRsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:48:36 -0400
Received: from ozlabs.org ([203.11.71.1]:44025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731404AbeHWRsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:48:36 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41x63533G3z9s5b; Fri, 24 Aug 2018 00:18:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 810e9f86f36f59f1d6f6710220c49afe0c705f38
In-Reply-To: <8097a1d32403ea47d076803e9070869badfe24bc.1534856426.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        aneesh.kumar@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: powerpc/nohash: fix pte_access_permitted()
Message-Id: <41x63533G3z9s5b@ozlabs.org>
Date:   Fri, 24 Aug 2018 00:18:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 13:03:23 UTC, Christophe Leroy wrote:
> Commit 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper
> for other platforms") replaced generic pte_access_permitted() by an
> arch specific one.
> 
> The generic one is defined as
> (pte_present(pte) && (!(write) || pte_write(pte)))
> 
> The arch specific one is open coded checking that _PAGE_USER and
> _PAGE_WRITE (_PAGE_RW) flags are set, but lacking to check that
> _PAGE_RO and _PAGE_PRIVILEGED are unset, leading to a useless test
> on targets like the 8xx which defines _PAGE_RW and _PAGE_USER as 0.
> 
> Commit 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted
> for hugetlb access check") replaced some tests performed with
> pte helpers by a call to pte_access_permitted(), leading to the same
> issue.
> 
> This patch rewrites powerpc/nohash pte_access_permitted()
> using pte helpers.
> 
> Fixes: 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper for other platforms")
> Fixes: 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check")
> Cc: stable@vger.kernel.org # v4.15+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/810e9f86f36f59f1d6f6710220c49a

cheers
