Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9E7218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY4GMwXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfAYXSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:18:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41632 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:18:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so5218245plm.8;
        Fri, 25 Jan 2019 15:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5fumqvJ8dTWn3w7Lj//Pa3DgDTg8O2es7+qSnnNc+Z0=;
        b=ZY4GMwXBTMT5cAHqXFE76XLM1nnWELupmpRDlqHBIxvckfGr/ZA6ImkoRSAkAXBerC
         mcAiDIzcKtDAeVPYv9N65x4gEmKaGxBYEp1XXmYQ+htl0Unu0KCweHTUOfzqjyPmwZnz
         pRHCWyfPUNz784AMm9/V40b/ZBrhEzv/vcsRylbtf8nQA2D3yYn9YY9CsJih5h3ZtL9m
         WVQ/7A8qwuxLSEmc9nOrop4j4i/8U0/4hehbXGxyfdBOZ4sqZbLA9Bd64Uln1gYSgpxu
         0gc7JbZ+mKDRy011zVc1Rq5nr45Vg9NJ8yCXeOiMRKO1Dq/ErXfdpIpoEVYq8nV37v87
         83GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5fumqvJ8dTWn3w7Lj//Pa3DgDTg8O2es7+qSnnNc+Z0=;
        b=j5m/WJ7mG11u0TdaSC6qOJCCZ92uhTtewQSmIYHxxwDvSAcOVIAkclaonRBKT+nBeu
         FPz5UM3phghYYP+oguPCXi0fKqq/OL8zSDqBFp/Ya02Sr1CJFMVHlGJ66REve7UVEUXb
         UHefo7Im01Mu1z94r18tWPOax3rMYuSPNQo3lWTiMXkxiNpCFgxWmBsaAOFt4YeAHAEQ
         I+VNSL39h3/OPHTdCssmloQkbdQmS0ouo47Q12HfxuwTo7IQd0K9wabVzqGA5LUKdcd3
         ycKOuLohDYb49XpiNhqZeXGCh1oXM8wDhmkbi+vEl7dkpOlTxTWhxfg22D1IQhEBS+oN
         fhpA==
X-Gm-Message-State: AJcUukfqD/CRkjwS5p60tA0MQ+4ND99UNgeYXdnLS++48MzKO1o21Ub6
        kuBMBODeEGbsR3h8Iu9z3Z8=
X-Google-Smtp-Source: ALg8bN6fVwjZuoEaJj/Ug0UWvRjzdeObzxUdpXkYUpIF8qUYsBSuDcrzCBbSG5QabcMz4J48tfSGUw==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr13177902plb.103.1548458286650;
        Fri, 25 Jan 2019 15:18:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm32796791pfh.61.2019.01.25.15.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:18:06 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:18:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/63] 4.14.96-stable review
Message-ID: <20190125231805.GD27619@roeck-us.net>
References: <20190124190155.176570028@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:19:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.96 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:15 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
