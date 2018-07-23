Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BTU0rhef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbeGWSJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:09:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbeGWSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T3WvCznmAx9tET1JqyrE3eU50YVuYPxWbVmmaX4VHow=; b=BTU0rhefCndHdmKT7Ohs+WOeD
        bRkQpswCVaOYl/be+sarh6HJGeVdxBxhLx26n63fQje/pQXZo+VpI7oiXgVRAklHp2o1utg7lJcU/
        ZcBnafiuJz/vmnON4B+vgV+1ll8Nyiz5O0BzMZ2fJjgtc0oSkIUNSVxVT3VENnorI1JmS1VvJAbRF
        Dwdn08tmVHMWaJ+7ib0/G0hfU1ne70EINKzGhZ4WXKcKMmx5NvXgvvzapmXVvP9C0WYP0DpfWbiUT
        K97wH7PuhlAoYfQia/we/sLgyubG/CfbxWVcpVWEoSxwNm+BdWaeyDyjH9SA4PS7EyFY+wqOSziBP
        WSwUzcgxg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fheJD-0004O0-Pl; Mon, 23 Jul 2018 17:07:43 +0000
Subject: Re: [PATCH] btrfs: fix size_t format string
To:     dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717135236.3673195-1-arnd@arndb.de>
 <20180717150400.GA3126@twin.jikos.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <544184a7-25ae-55a6-3e81-0e1fa1e5cd1d@infradead.org>
Date:   Mon, 23 Jul 2018 10:07:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717150400.GA3126@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 08:04 AM, David Sterba wrote:
> On Tue, Jul 17, 2018 at 03:52:27PM +0200, Arnd Bergmann wrote:
>> The newly added check_block_group_item() function causes a build warning
>> on 32-bit architectures:
>>
>> fs/btrfs/tree-checker.c: In function 'check_block_group_item':
>> fs/btrfs/tree-checker.c:404:41: error: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Werror=format=]
>>
>> The type of a sizeof() expression is size_t, which is correctly printed
>> using the %zu format string.
>>
>> Fixes: 9dc16aad5660 ("btrfs: tree-checker: Verify block_group_item")
> 
> Folded to the commit, thanks.
> 

Hi David,
Where did this patch end up?  linux-next-20180723 is still showing this
format warning.

thanks,
-- 
~Randy
