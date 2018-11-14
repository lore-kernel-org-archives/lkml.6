Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A29C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392922419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A392922419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbeKNS4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:56:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeKNS4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:56:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1D10EBD;
        Wed, 14 Nov 2018 00:53:58 -0800 (PST)
Received: from [10.162.42.147] (p8cg001049571a15.blr.arm.com [10.162.42.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15C873F5CF;
        Wed, 14 Nov 2018 00:53:55 -0800 (PST)
Subject: Re: [RFC][PATCH v1 02/11] mm: soft-offline: add missing error check
 of set_hwpoison_free_buddy_page()
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-3-git-send-email-n-horiguchi@ah.jp.nec.com>
 <9ea93154-4843-231d-d72b-bf12c8807c24@arm.com>
 <20181113001652.GA5945@hori1.linux.bs1.fc.nec.co.jp>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ffbc7a7e-58c3-742c-2bae-8cd4cf1e6aa8@arm.com>
Date:   Wed, 14 Nov 2018 14:23:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113001652.GA5945@hori1.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2018 05:46 AM, Naoya Horiguchi wrote:
> Hi Anshuman,
> 
> On Fri, Nov 09, 2018 at 03:50:41PM +0530, Anshuman Khandual wrote:
>>
>> On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
>>> set_hwpoison_free_buddy_page() could fail, then the target page is
>>> finally not isolated, so it's better to report -EBUSY for userspace
>>> to know the failure and chance of retry.
>>>
>> IIUC set_hwpoison_free_buddy_page() could only fail if the page is not
>> free in the buddy. At least for soft_offline_huge_page() that wont be
>> the case otherwise dissolve_free_huge_page() would have returned non
>> zero -EBUSY. Is there any other reason set_hwpoison_free_buddy_page()
>> would not succeed ?
> There is a race window between page freeing (after successful soft-offline
> -> page migration case) and the containment by set_hwpoison_free_buddy_page().
> Or a target page can be allocated just after get_any_page() decided that
> the target page is a free page.
> So set_hwpoison_free_buddy_page() would safely fail in such cases.

Makes sense. Thanks.
