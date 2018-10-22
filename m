Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A158C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990BC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VILLMoR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990BC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeJWDWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:22:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46065 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbeJWDWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:22:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id c24-v6so4812758lfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5ID5WKJrfkdcLoERsjoZ/K2q9uEi3Aqy1CFjN9gDnY=;
        b=VILLMoR5dLCZn0OD+k+qFlafxEeeadNXbLIAoH4q4q+PLbT4VTbNHJTc3SC71u9int
         mKOJejeeG6MYiScv0Pw1MQiHloiCfHQevZ8yCYFLiloxv5ZOUw/5a/xUMBdyixtv5GgO
         sWk0BJ1fyqyFVj/IAq9clSA7byfBpqszz9Z9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=z5ID5WKJrfkdcLoERsjoZ/K2q9uEi3Aqy1CFjN9gDnY=;
        b=NDuY8MQXYTYm4hgfwtapAP3Em2OfJvTGZ58VqGJGiCE7oEc6Rmm/qZq36hbFX0vj+h
         mD0elR7ursDb5xzDJiBiLrym0g2CVxJ5Yz1QXWYiyB3MUAwBv2MSLp/1+Q9OSq+nH0rK
         jGqKKrN+u2fIN0dn5StYIAaNM7iA4mEGWqEngmq2OQi5LycKy+6A/hjl5QL/lezDu+PT
         5fxuRLFrwY/JCxRfAUmisL5NCg7o/5+dlJjoEqeCDn/1ge+CuVCa970yojaQE7eQ0PPB
         n2snFDA/p5OzYjco0VGS5O+pmV2F8mohl4G+C7E+X/VbEAmKTJdEb+IMjM6BSaUxn/iv
         rx5w==
X-Gm-Message-State: ABuFfogzqo3KDr/R0IhkaToZJrlN41jbpUDApo4CcRPpKKKI/Qw+XSC3
        aXDrqcK3ueintD6SqiIsDHttPw==
X-Google-Smtp-Source: ACcGV60FraSentNbNWLV5NFVmszbKEohnBejUtVUbrwFmDD8ScQa132adJCh8QOmw14ooPwHfeClGg==
X-Received: by 2002:a19:9e54:: with SMTP id h81-v6mr9683112lfe.155.1540234974456;
        Mon, 22 Oct 2018 12:02:54 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id c16-v6sm789815lfj.43.2018.10.22.12.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 12:02:53 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:02:51 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: unsync mcast entries
 while switch promisc mode
Message-ID: <20181022190249.GA4892@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
 <6ac434fa-858b-8395-91e7-442cf18b33f0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6ac434fa-858b-8395-91e7-442cf18b33f0@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:26:35PM -0500, Grygorii Strashko wrote:
>
>
>On 10/19/18 3:25 PM, Ivan Khoronzhuk wrote:
>>After flushing all mcast entries from the table, the ones contained in
>>mc list of ndev are not restored when promisc mode is toggled off,
>>because they are considered as synched with ALE, thus, in order to
>>restore them after promisc mode - reset syncing info. This fix
>>touches only switch mode devices, including single port boards
>>like Beagle Bone.
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>---
>
>
>So, this is follow up fix for
>176b23 net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update
>because I can't reproduce it otherwise.
>
>Could you update description and re-send pls.?

Done.

-- 
Regards,
Ivan Khoronzhuk
