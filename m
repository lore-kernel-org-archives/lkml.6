Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B025A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PjpbT//D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mQ+BpRgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B025A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeJVSvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:51:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbeJVSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:51:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51DE160C4C; Mon, 22 Oct 2018 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540204389;
        bh=AHxOMvz/rwnT09iJ6eDb35LsSgvNLA11wcJbgov+mBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PjpbT//DomAkQrUs7H938mWdeuDup27b9/ELFcNwHvYel1Wi8Tnx3RVCUEtX4FSS3
         KF4zo1CLnjT8+XbCgTINq8EJH/A7zvggSydR0SFVRVRA16dMG7wDtwPdquh83EerUo
         MNyiBYUV9h5hccXVhamlqa4a22fMdyufr753hnsA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 24D1160850;
        Mon, 22 Oct 2018 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540204388;
        bh=AHxOMvz/rwnT09iJ6eDb35LsSgvNLA11wcJbgov+mBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQ+BpRgfjGtSdG5H617PQAtZW3uE13y5FkQo4lBjBdbVYsCnbCKQcQVi6YF1+4a8P
         p6KQNuI4pz8VweaQHrE6y7RpSTjFCSnjGDWnGZXK2arzkmd5lCFZt3tNq8+EgR172j
         I86z9q5yn8cd+pNTVRpa5VuBHnbSV/EVf4jVR7hA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Oct 2018 16:03:08 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        dan.j.williams@intel.com, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <20181019080755.GK18839@dhcp22.suse.cz>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
 <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
 <20181010173334.GL5873@dhcp22.suse.cz>
 <a2d576a5fc82cdf54fc89409686e58f5@codeaurora.org>
 <20181011075503.GQ5873@dhcp22.suse.cz>
 <20181018191825.fcad6e28f32a3686f201acdf@linux-foundation.org>
 <20181019080755.GK18839@dhcp22.suse.cz>
Message-ID: <c6289fada694462ed708174f9a1f3b6c@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-19 13:37, Michal Hocko wrote:
> On Thu 18-10-18 19:18:25, Andrew Morton wrote:
> [...]
>> So this patch needs more work, yes?
> 
> Yes, I've talked to Arun (he is offline until next week) offlist and he
> will play with this some more.

Converted totalhigh_pages, totalram_pages and zone->managed_page to 
atomic and tested hot add. Latency is not effected with this change.
Will send out a separate patch on top of this one.

Regards,
Arun
