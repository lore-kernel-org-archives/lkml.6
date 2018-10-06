Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21305C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9AA2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzRha8nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9AA2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJFNNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:13:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37004 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeJFNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:13:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so6037876pfi.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K42Cvg+0JCrHPZPATtlCPfs4YxgFVLQk0K/l7cVaXow=;
        b=bzRha8nLy4/ZQTz79D2tt0sWOoH8waIv3WWx8JuQAC5LsEuhIB2MloGlckXUC0qP/a
         JlV32hZRO+LdpSZwJB1BO0Bivdy8OaXk3ahvVmRkTclc1oNfRMjNPM/HPaGwGLWSSvho
         oKBe/40xioOaC6Nc3PZm8XTfjANZnsP47tEbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K42Cvg+0JCrHPZPATtlCPfs4YxgFVLQk0K/l7cVaXow=;
        b=SdwoA3srbAPrZ1TxueoPdhZxtQuBbt9PC2oD5KtGbIezlQmOr0/0jbLrAnshv1AXYT
         IdVSWvl+AoupISDQe1dAFUJI9LKJaRu9zsTc2E0KJCO10SexqHbFiyo/GnmqukL2OVPG
         SNiMrQNp7hm05TLfHdpYVc7G3m1OGhl+UZ1P2SSKZxgYGLvdLV5pbtiw/83cY29go7lG
         ZAxXq280fc6PtPDjLO/cqdAMaXGg1ZOIER/7d4mLagfSxbEFSsL/KJm+h7zMZZqMFpNV
         fabXrWx04jhSn0Vi6x9wm18sqc63ulIg6sCjHjx2/87Hg//iJdM6mJUaH36T51QWMN8H
         gz0Q==
X-Gm-Message-State: ABuFfoibL3XG7kHE0vL3Vf7h4LmXZtsIKyggoG7amDmr9J0Akrb6+Xh7
        u2QHvLsW3Wn0LKwe5y6prOxd/A==
X-Google-Smtp-Source: ACcGV61i4QFUhi8JVZsSqagk6DrAloCEh0MXiiGCJ4yhxQO4wlokwz7Jph+IZ4RcbxcekIgUdtnB2w==
X-Received: by 2002:a63:f347:: with SMTP id t7-v6mr12352222pgj.255.1538806310956;
        Fri, 05 Oct 2018 23:11:50 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v189-v6sm16285934pfb.54.2018.10.05.23.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:11:50 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:14:36 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] remoteproc: Add missing kernel-doc comment for
 auto-boot
Message-ID: <20181006061436.GE12063@builder>
References: <20180915003725.17549-1-s-anna@ti.com>
 <20180915003725.17549-4-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915003725.17549-4-s-anna@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Sep 17:37 PDT 2018, Suman Anna wrote:

> The commit ddf711872c9d ("remoteproc: Introduce auto-boot flag")
> introduced the auto-boot flag but missed adding the corresponding
> kernel-doc comment. Add the same.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Applied.

Thanks,
Bjorn

> ---
>  include/linux/remoteproc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e3c5d856b6da..75f9ca05b865 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -439,6 +439,7 @@ struct rproc_dump_segment {
>   * @cached_table: copy of the resource table
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
> + * @auto_boot: flag to indicate if remote processor should be auto-started
>   * @dump_segments: list of segments in the firmware
>   */
>  struct rproc {
> -- 
> 2.18.0
> 
