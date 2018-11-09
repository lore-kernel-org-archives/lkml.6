Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A4EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AF22089A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AF22089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeKIUAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:00:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbeKIUAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:00:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9901CA78;
        Fri,  9 Nov 2018 02:20:45 -0800 (PST)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5482F3F718;
        Fri,  9 Nov 2018 02:20:43 -0800 (PST)
Subject: Re: [RFC][PATCH v1 02/11] mm: soft-offline: add missing error check
 of set_hwpoison_free_buddy_page()
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-3-git-send-email-n-horiguchi@ah.jp.nec.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9ea93154-4843-231d-d72b-bf12c8807c24@arm.com>
Date:   Fri, 9 Nov 2018 15:50:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541746035-13408-3-git-send-email-n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
> set_hwpoison_free_buddy_page() could fail, then the target page is
> finally not isolated, so it's better to report -EBUSY for userspace
> to know the failure and chance of retry.
> 

IIUC set_hwpoison_free_buddy_page() could only fail if the page is not
free in the buddy. At least for soft_offline_huge_page() that wont be
the case otherwise dissolve_free_huge_page() would have returned non
zero -EBUSY. Is there any other reason set_hwpoison_free_buddy_page()
would not succeed ?

> And for consistency, this patch moves set_hwpoison_free_buddy_page()
> in unmap_and_move() to __soft_offline_page().

Yeah this check should be handled in soft offline functions not inside
migrations they trigger.
