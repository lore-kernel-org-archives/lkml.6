Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700F2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030F321570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dbaw3Nf1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MnwQ8OeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030F321570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0O0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:26:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeI0O0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:26:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8EF6D60C1D; Thu, 27 Sep 2018 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538035782;
        bh=UxTI0XBhFY3fifwH9aQo2CGKxgpyEpDnMmVvbABH7eU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dbaw3Nf1XZT9n87YJ4n1odqv4vFHWXyHGBWw0Fu9/ZcVzm3xwPlcLpQv5nLr3NI0J
         va1tJJh59mAce91LQ0Xgs9wkU95Z8pdIEqhO+7ylnqHR84wgQ9m5YC0ljxzmo89iuV
         wj8tdpxXWvpDWc4HH2a3Zbv5hGa/bVDzNX5QV6ak=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0B9EA607C6;
        Thu, 27 Sep 2018 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538035781;
        bh=UxTI0XBhFY3fifwH9aQo2CGKxgpyEpDnMmVvbABH7eU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MnwQ8OeIytxlUv5cgXmHuk87YIHQWlqOfZ/BPRaEDzdSmMn5C6Cl8T5cN745UKGhK
         iz7ei03LmlEl6DAst38eC7qI3bVqrE/PdjF/QhSFxI3ySEaq3MnUN928llJKtLJeQV
         OFMhPLTyeZgstfiwu4BmcH0uw1AWZn5+uD8a1V1A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Sep 2018 13:39:41 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v3] memory_hotplug: Free pages as higher order
In-Reply-To: <20180927070957.GA19369@techadventures.net>
References: <1538031530-25489-1-git-send-email-arunks@codeaurora.org>
 <20180927070957.GA19369@techadventures.net>
Message-ID: <f56a750a54eadf76c45d3065622d4cbf@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 12:39, Oscar Salvador wrote:
> On Thu, Sep 27, 2018 at 12:28:50PM +0530, Arun KS wrote:
>> +	__free_pages_boot_core(page, order);
> 
Hi,

> I am not sure, but if we are going to use that function from the
> memory-hotplug code,
> we might want to rename that function to something more generic?
> The word "boot" suggests that this is only called from the boot stage.
I ll rename it to __free_pages_core()

> 
> And what about the prefetch operations?
> I saw that you removed them in your previous patch and that had some
> benefits [1].
> 
> Should we remove them here as well?
Sure. Will update this as well.

Thanks,
Arun
> 
> [1] https://patchwork.kernel.org/patch/10613359/
> 
> Thanks
