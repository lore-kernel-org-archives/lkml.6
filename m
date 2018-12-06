Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD17EC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C75520850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544054703;
	bh=C5fap2hIw3E0G0atJerDh5eNioYuOtMpB/ZKTNjBiSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R1gORf5ruCd4YOzNoMW2NQ/BJabdusJLqXD05Unzz3IPcHytPt66d59BaoUbME1wi
	 YkvmBaYix1EskT/2N4CuaXDRkvXXj9UZofoG7gqjrFP7SFNXCbc77UzRYzOGU5Ejfl
	 nlIc6Ktoh280Xr74ed7ZMZJrUCmVVoVjTZJizHFs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C75520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeLFAFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:05:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbeLFAFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:05:02 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 401112082B;
        Thu,  6 Dec 2018 00:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544054701;
        bh=C5fap2hIw3E0G0atJerDh5eNioYuOtMpB/ZKTNjBiSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyNrHemcmKF145w+x02nzqu58Pm0plTPp1+n6dIukYmrX3jtYoddLZZDHkK8uZrSj
         ogjMZpLg9H4J3OGrVvkMIKuzbWn9d7ai0E1qTEddxK7TQ1E/CqWwfhtzhVkKFPotW4
         M+bLGqkpR7MUD79et5NaYXhOINByC4FBoazi9Odo=
Date:   Wed, 5 Dec 2018 16:04:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        nhorman@tuxdriver.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: Implement a generic crypto statistics
Message-ID: <20181206000458.GA209772@gmail.com>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537351855-16618-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On Wed, Sep 19, 2018 at 10:10:54AM +0000, Corentin Labbe wrote:
> +int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct crypto_alg *alg;
> +	struct crypto_dump_info info;
> +	int err;
> +
> +	if (cb->args[0])
> +		goto out;
> +
> +	cb->args[0] = 1;
> +
> +	info.in_skb = cb->skb;
> +	info.out_skb = skb;
> +	info.nlmsg_seq = cb->nlh->nlmsg_seq;
> +	info.nlmsg_flags = NLM_F_MULTI;
> +
> +	list_for_each_entry(alg, &crypto_alg_list, cra_list) {
> +		err = crypto_reportstat_alg(alg, &info);
> +		if (err)
> +			goto out_err;
> +	}
> +
> +out:
> +	return skb->len;
> +out_err:
> +	return err;
> +}
> +
> +int crypto_dump_reportstat_done(struct netlink_callback *cb)
> +{
> +	return 0;
> +}

How did you test this part?  Hint: these functions are never executed.

- Eric
