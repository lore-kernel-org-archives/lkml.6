Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74ED2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfAaRLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:11:18 -0500
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:33996 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbfAaRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:11:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0EF431802EC2A;
        Thu, 31 Jan 2019 17:11:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wind88_623057b075b3a
X-Filterd-Recvd-Size: 2456
Received: from XPS-9350 (unknown [149.142.244.94])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Jan 2019 17:11:14 +0000 (UTC)
Message-ID: <dc6d827c187cd228b917f8d9d984bd5ea578d712.camel@perches.com>
Subject: Re: [PATCH net-next] nfp: use struct_size() in kzalloc()
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Jan 2019 09:11:12 -0800
In-Reply-To: <20190131003859.GA28539@embeddedor>
References: <20190131003859.GA28539@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 18:38 -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.

Might be useful to augment the script to include cases
where the computed size is saved to a temporary and
that temporary is used ala:

https://patchwork.kernel.org/patch/10782453/

On Sat, 2019-01-26 at 20:42 +0800, YueHaibing wrote:
> Use kmemdup rather than duplicating its implementation
[]
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
[]
> @@ -1196,13 +1196,9 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
>  	regd_to_copy = sizeof(struct ieee80211_regdomain) +
>  		valid_rules * sizeof(struct ieee80211_reg_rule);
> -	copy_rd = kzalloc(regd_to_copy, GFP_KERNEL);
> -	if (!copy_rd) {
> +	copy_rd = kmemdup(regd, regd_to_copy, GFP_KERNEL);

This should probably be

	copy_rd = kmemdup(regd, struct_size(regd, reg_rules, valid_rules),
			  GFP_KERNEL);



