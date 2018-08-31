Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7D1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E7F205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7639a2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E7F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeHaNse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:48:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40809 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:48:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so9577999ljc.7;
        Fri, 31 Aug 2018 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cFwG3x8yT3jbbxxmQvjq20KjgOv+da/qeKinUhzvC8g=;
        b=t7639a2v9yBdm0QmgnB4R3hSutZDihB+qpPr2PEsbvS1p2TEobI5fGIxdx0BO0AtFU
         ceHaU5OGIqrD+7VL/paRBiZ3duGafdONQPHxaR9j0YUe5qCFIJQK1wsWYQt7F/kHWP+r
         mts+WKcEwHyKO7mLzgm5tP00ZeV7bT1xf5fojSY24n82AF6/T7UgycCPbMNEcFHpj42P
         stutHcydpyHtG0D6E6fI1u488Dxwr9RS3XFcMm5E70iR8gRBFhAwC5SbOHBYG9+iERId
         ENFFrWIkRUq2JD/krvombTeUEUBFW980hanMdkKGgZOS/SHrvnvbR3NA7CxzrggwQQAZ
         OEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cFwG3x8yT3jbbxxmQvjq20KjgOv+da/qeKinUhzvC8g=;
        b=ZaLfwakIdTvTevfRCcx36KadIj8CiJlm2HaFmlWx20PLGS/l4ZGz244SPw4Ogq93Ts
         qNBCCl5JFXK95rcHubaVNKWDWRpEUSIwizQLvJOlziLn4Mq8iphEmaKowEtazTSQNrPG
         tuS9cVnBLCjKPzeY3isV2RlCYkjMuS6a6MuVTIO1zd81zNY8USiMatU2hxcqQa9lZBVQ
         QfTUjQr2bDufgMOpkVKB2UM/A1bEn324wUXLUNGxk6YOJ2AwCmo0Bf6HQaxygV8cN4Yq
         V3KZpyqC2LIZ8msC+oGfvIqsswe6JtktKbEvmyeiFxWT7DzLn2WpGtoxM4OUx4Y/GuCg
         d+FQ==
X-Gm-Message-State: APzg51ApJkaGdCK1i8TBn4C+w3O+JkcNFedi1UjKONjph5DxwUW48KjR
        IoKzczmPSigWQeDhB1Ers6A=
X-Google-Smtp-Source: ANB0Vdafc+FQnT+Ke+mFxRB83bh/1IJM3w3dOSZjDXAWi4DDYr2rteoMOB63qx2Nk5KXVf02egwa9w==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr9617613ljf.102.1535708513585;
        Fri, 31 Aug 2018 02:41:53 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o68-v6sm1814436lfk.19.2018.08.31.02.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 02:41:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fvfwA-0006fe-2Q; Fri, 31 Aug 2018 11:41:54 +0200
Date:   Fri, 31 Aug 2018 11:41:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
Message-ID: <20180831094154.GL28861@localhost>
References: <626cea85395e3a1f002ef0a241bb508d770a33c0.1535536218.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626cea85395e3a1f002ef0a241bb508d770a33c0.1535536218.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:16:40AM +0800, Chunfeng Yun wrote:
> Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> never return NULL value;
> But still need ignore the error of -ENODEV, for more information, please
> refer to:
> [0] https://lkml.org/lkml/2018/4/19/88
> [1] https://patchwork.kernel.org/patch/10160181/
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> V3: abandon the ternary operator suggested by Johan
> 
> V2: keep the -ENODEV check

Perhaps the patch Subject is a little misleading as this is more of a
clean up than a fix (as there's no bug here).

But apart from that this looks good to me.

Reviewed-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/usb/core/phy.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 9879767..38b2c77 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -23,10 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>  				   struct list_head *list)
>  {
>  	struct usb_phy_roothub *roothub_entry;
> -	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	struct phy *phy;
>  
> -	if (IS_ERR_OR_NULL(phy)) {
> -		if (!phy || PTR_ERR(phy) == -ENODEV)
> +	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	if (IS_ERR(phy)) {
> +		if (PTR_ERR(phy) == -ENODEV)
>  			return 0;
>  		else
>  			return PTR_ERR(phy);

Thanks,
Johan
