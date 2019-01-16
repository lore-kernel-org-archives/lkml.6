Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C38220651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejGwBCRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405831AbfAPRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:21:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfAPRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HjB4WyTG0y963TSzDm2EKwD/+zJ5pPanwxddC7G0mTw=; b=ejGwBCRoKP4jizHf4jljpbq8Ge
        ocCCBkkxl47KYLXCdgdiSlP1dPQ4T+/v7X9oPIF96L33/f6dIitqjyFlq0jNCV2n7uDwd9bcp5gcu
        1CmaOIU+Hz15IHxd+zAJc4JWyEOQzUJCFr64ukBPVoMOvn6B66p3jrlLgYdx/Fs7TMSMvTAbH1827
        TQL888u1TxkBcoqcj5Mc8C6ZQSSiwIo2pynIwahqkRuXq6a6lUs2+czBg+iHGFb5nxpvsV93YVz8D
        2KRhJFDorEc5PSVa7knXcLCqEkAap6W/kCR7dyMgPqJ808vj9ZJ79fmvbIeyLjncdF18CEl1YnEcb
        y+oADF8A==;
Received: from [199.233.58.37] (helo=[10.83.93.157])
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjosL-0002gO-7t; Wed, 16 Jan 2019 17:21:13 +0000
Subject: Re: [PATCH] powerpc/ps3: Use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190108210010.GA980@embeddedor>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <595f7b4b-9e26-ae72-de5f-270dce677c65@infradead.org>
Date:   Wed, 16 Jan 2019 09:21:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108210010.GA980@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On 1/8/19 1:00 PM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/powerpc/platforms/ps3/device-init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
> index e7075aaff1bb..59587b75493d 100644
> --- a/arch/powerpc/platforms/ps3/device-init.c
> +++ b/arch/powerpc/platforms/ps3/device-init.c
> @@ -354,9 +354,7 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
>  		 repo->dev_index, repo->dev_type, port, blk_size, num_blocks,
>  		 num_regions);
>  
> -	p = kzalloc(sizeof(struct ps3_storage_device) +
> -		    num_regions * sizeof(struct ps3_storage_region),
> -		    GFP_KERNEL);
> +	p = kzalloc(struct_size(p, regions, num_regions), GFP_KERNEL);
>  	if (!p) {
>  		result = -ENOMEM;
>  		goto fail_malloc;
It seems to me the motivation for this change is just to have a
code change.  As I've said for other similar patches, I'm reluctant
to accept such trivial changes to the PS3 code because it makes
it harder for me to maintain the code in the long term.  When I
need to do a git bisect to track down a problem I generally have
a set of debugging patches that I apply on top of the bisect.  A
change to the code like this creates the potential for a patch
conflict that I then need to manually edit to resolve.

If this change was for relatively new code, or better, for a patch
that was submitted but not yet merged, then my feelings would be
different.  I think it would be really useful to have something
that scans patches in patchwork.

-Geoff
