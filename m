Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6CEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD6420838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226168;
	bh=ITha4gPfiB9FbQvIDoogLuvzULQX+Sl2sDpO76oyiP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0H5a+R2raat7o0dXKoFsMceTusUBNNuU9fdDGiNXeHWuGFSWHiVzuWKkp6Uzfxs0q
	 tHLLhnA3KR3WpsIZ+Hr95qtvnaVLGWctEWNc+QrTsbl7XX7NtwUmH96LU7jeaM8r9y
	 YMfDPfnab8FcXBf7TFVjOBkaHCppjrh5CBrtwDSc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD6420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGXmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:42:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34219 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:42:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so5429653otk.1;
        Fri, 07 Dec 2018 15:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xBkS9oC5J2T56O5ifzXztrOap29WFWrlphkgmjH7eRU=;
        b=pHKOfCdpMqCSpTsBIY4IP+CGFN1MBhiqnmHKHqQCS2KsaQx4gob58MGsivpmK/4Pgm
         zt7LBAMPiuXnzcDsawWnngd0K70oPXujxxZ30CRsi1tlv3E8y6EDlnx4xNMJPulLMzI2
         qyoGLcMxCQT0LHI3hjrDJDoVLS08iz2jjVgOp9VNJzIIOD9Hc/rKmAD8qwNpdQF9FpaJ
         JHygFLMx4FkP0dgSdt9K/UT4gI5X6OEB+RADgtc0nGD7s5YiCVuYhM1TnIGCfXQ4x9+6
         6g3OoiR9QVP99IQlIBH1oypYcpRGpUb7ejXzDZUPI6oXBW0jY0bB9DV+SjJkBLNmzbtS
         FfZg==
X-Gm-Message-State: AA+aEWa1pIBKqAFp3+0qrmiLIDROL2whrFd4Be1JQ73cEH6vKCGOFSOS
        ZybExWMKxGfIkqMg2A47Vw==
X-Google-Smtp-Source: AFSGD/WFf9i/mNGxR677KAugbYzHyAUF446G9TIoKmt2mMgec5VYIk2HWptGLpalCIxkoDAHJUk4zA==
X-Received: by 2002:a9d:bf7:: with SMTP id 110mr2901801oth.201.1544226166044;
        Fri, 07 Dec 2018 15:42:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f127sm2471702oia.19.2018.12.07.15.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:42:45 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:42:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Kerello <christophe.kerello@st.com>
Subject: Re: [ v3 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND
 controller documentation
Message-ID: <20181207234244.GA19886@bogus>
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com>
 <1543509663-26128-2-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543509663-26128-2-git-send-email-christophe.kerello@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 17:41:01 +0100, Christophe Kerello wrote:
> This patch adds the documentation of the device tree bindings for the STM32
> FMC2 NAND controller.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
