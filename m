Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F5C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42E2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDESaIx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F42E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJMD7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:59:07 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:36370 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeJMD7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:59:07 -0400
Received: by mail-pf1-f172.google.com with SMTP id l81-v6so6741533pfg.3;
        Fri, 12 Oct 2018 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ESDOzR470cAODi2THgeAyCFK5JT7nCcbvpBCMDXPI4=;
        b=KDESaIx6G+kM0P+VC+leoUzctlycTbT1YcONFifSdeL80r6/dZKYlOWaduM3HGWbTi
         2zLhf7jfY8yxm7K7l0PD7zXEShsZTTBQ0/cnXgfZ2LMHX7MYHIahmf9y5Gpb38+4Hpm0
         1kbTUSUiRcti8GIbkEhS6IJnoQEovqThhLMEkdaELnxGroiAZqzgq8XN+571Fwp6G96f
         Jt6mjVbnO9Yh7350k3iIb31pPnyIb/USHiDXS6T52xVR5ZiZwAmWS6ZPMm/dYvpR5u1b
         7t8/N9YpNYK0ykznYiugTbrTjsDvLwwLjoautj9ZRJzBYwu/2sObbc9vGVknPW179ZgK
         i5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ESDOzR470cAODi2THgeAyCFK5JT7nCcbvpBCMDXPI4=;
        b=ic2asd2pF/1OpD8zZsvc/CX9VmEJZ5/UhtbkfYl/+USq1O9062gAtRYryuwBMikaGe
         bK7Fgu918jO1iQre2Q3ELrPo6dXqUk3KZTory6L0rCEmmbPZYow3OWjsaH7dDQtAa3Lp
         OckBxrFhXeu7oiEkZIjxAU4aGWnVWepNWg7uM8sixN/hsMOsE9skhOjoYmSdotugDS59
         ioMg3g59PONJHbe4Si6qQo3CdAxvR+50K8KbwTKCRc/sgZLcQNBYjA/Xdeu0pp3vEI+G
         da87C+dN0zHfBhCDfcNxXxXrTgKAgV0ygpsw855A3LTR/1F+kBNHuBK4K9R24kij2nVT
         sW4Q==
X-Gm-Message-State: ABuFfojGwiVLRXxbH6kvirjDX8sXFNwlmPV40x6iXrvq28sSD76ASQb0
        +Q5vJYCk94Jjy+jmugyadKU=
X-Google-Smtp-Source: ACcGV63dKKAD5134X8ZEzX1Ck322n7d/q2nivp4+sfXkOzwpcEGlw6F8+305oCmOh4jNXpP8W3hTCA==
X-Received: by 2002:a62:5c03:: with SMTP id q3-v6mr7658244pfb.182.1539375895234;
        Fri, 12 Oct 2018 13:24:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a11-v6sm3011633pfn.66.2018.10.12.13.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 13:24:54 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:24:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
Message-ID: <20181012202452.GA30665@roeck-us.net>
References: <20181011152549.500488630@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:33:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.124 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> Anything received after that time might be too late.
> 

For v3.18.123-122-gfaa00f6cbce8:

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 221 pass: 221 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
