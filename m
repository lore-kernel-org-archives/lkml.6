Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16829C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA3E204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xy1UODqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA3E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeI1XmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:42:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33127 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1XmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:42:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so4777982pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=crtRLGJiVAFC0D32YvyvgtTHnUYkXZHpcOpGMJz8SWI=;
        b=Xy1UODqwSPw4hiwRPXNO5bfuT+g61rV3W+n/AXj+eFbFB8AI2oadBqhrhLM5xOFO5n
         NJgCHafvWzXaZdewsiUNQtUiF7Q2m0oGhlry7n2L3+c9oyZKMHB2fL4eQsHOYev3cjNM
         QUQHsvy1RNP7OlrPbBo5inGRKixrNYNOjG20Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=crtRLGJiVAFC0D32YvyvgtTHnUYkXZHpcOpGMJz8SWI=;
        b=tXKDhi8KdW9Ilq9cR3GXqcZX8Q4hVY1mS/eDY0iugCkJ1fJnvuSCQfBNS3tnrygI4r
         Sw8DsklJRYrZuLL3ShJ2/R3yszIIt1X6B7vedGGszsHtFNBD4XrYE/uX8MohwBl7D+e2
         OlHvbdEfhouLrcFL4mUxbwQNi1CMh+qPSRIw8MhNrCYxQPQ4RvCC8rSe+Wf0KYYejKFa
         SNP9dpQORJ0IDDEIb7wAwPCmnVmmqcJi+5vwR8jIkerv9JiypToFk+Oo0retR1J428v4
         CciKJWltPuovUdxRJFA2ZmWKxteWASGHKJTsK4Helx/gaMGRQng+jdWUWjFJZ5oL+iIz
         JvnQ==
X-Gm-Message-State: ABuFfojb37cpoikzt5+F2rSGtWZdLtDEm51Zuzu+/PxpuzZD7cqGVDCv
        gH3UgJllc+ErgB9Q9EKOv9vjhA==
X-Google-Smtp-Source: ACcGV60rKrpfOBR4ra6rZiihVbMfYwnddJHs6sAv/4LKXNoKfpGAfTqaaaUpAZMvTvWXj3JgWKXjyQ==
X-Received: by 2002:a62:ff09:: with SMTP id b9-v6mr17649426pfn.46.1538155039850;
        Fri, 28 Sep 2018 10:17:19 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z7-v6sm11485240pff.146.2018.09.28.10.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 10:17:19 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:21:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
Message-ID: <20180928172145.GA5008@tuxbook-pro>
References: <20180427140358.30839-1-elder@linaro.org>
 <ec0e7861-4bf0-f135-a881-1a1de4579277@linaro.org>
 <20180928122616.GA5249@centauri.lan>
 <4025f206-631a-55e9-9b7a-89dcf3370284@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4025f206-631a-55e9-9b7a-89dcf3370284@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28 Sep 06:23 PDT 2018, Alex Elder wrote:

> On 09/28/2018 07:26 AM, Niklas Cassel wrote:
> > On Fri, Sep 28, 2018 at 06:41:11AM -0500, Alex Elder wrote:
> >> Was there something wrong with this patch?  I sent it a long time
> >> ago but it still applies cleanly.  I can re-send if you like.
> > 
> > Hello Alex,
> > 
> > This patch does not apply on top of
> > https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next
> 
> Sorry, I sent this before I tracked down where Andy's for-next
> tree was.  It applied OK to linus/master.
> 
> > When you don't specify a string for a Kconfig, then you won't be able to
> > select it via menuconfig, only through other Kconfigs, e.g.:
> > $ git grep QCOM_QMI_HELPERS
> > drivers/remoteproc/Kconfig:     select QCOM_QMI_HELPERS
> > 
> > What Kconfig is it that needs QCOM_QMI_HELPERS?
> 
> IPA, which is not yet merged.
> 
> The entry in "drivers/soc/qcom/Kconfig" for this option includes
> help text, so I presume it was an oversight not to include a
> string (prompt).  It is the only non-trivial entry in that file
> that does not include one.  Why should this entry not be listed
> in menus?
> 
> > Why do you need to make is selectable via menuconfig?

I made it this way because I don't see a reason for anyone to ever
select this config option if there isn't a client available - and
clients that "depends on" this simply forces the developer to find the
QMI helpers in menuconfig and enable it manually.

> > Isn't it sufficient to add a "select QCOM_QMI_HELPERS" to that Kconfig?
> 
> I have CONFIG_IPA dependent on CONFIG_QCOM_QMI_HELPERS.  I could
> change that to select it instead but I still think this entry
> should be changed.
> 

Why do you say it needs to change? I tested this by just adding a
"select QCOM_QMI_HELPERS" in my client drivers.

> I'll mention that SLIM_QCOM_NGD_CTRL in drivers/slimbus/Kconfig
> also depends on--rather than selects--QCOM_QMI_HELPERS.
> 

That's wrong.

Regards,
Bjorn

> 					-Alex
> 
> > 
> > Kind regards,
> > Niklas
> > 
> >>
> >> 					-Alex
> >>
> >> On 04/27/2018 09:03 AM, Alex Elder wrote:
> >>> Add a prompt to the "tristate" attribute in the Kconfig file in
> >>> which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
> >>> without it.
> >>>
> >>> Signed-off-by: Alex Elder <elder@linaro.org>
> >>> ---
> >>>  drivers/soc/qcom/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> >>> index 5c4535b545cc..81a501765cd9 100644
> >>> --- a/drivers/soc/qcom/Kconfig
> >>> +++ b/drivers/soc/qcom/Kconfig
> >>> @@ -36,7 +36,7 @@ config QCOM_PM
> >>>  	  low power modes.
> >>>  
> >>>  config QCOM_QMI_HELPERS
> >>> -	tristate
> >>> +	tristate "Qualcomm QMI Helpers"
> >>>  	depends on ARCH_QCOM && NET
> >>>  	help
> >>>  	  Helper library for handling QMI encoded messages.  QMI encoded
> >>>
> >>
> 
