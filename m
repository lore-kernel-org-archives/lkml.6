Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EBAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1FE2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzPcWVVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBEG1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:27:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38003 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfBEG1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:27:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so1073461plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=muA4hdM6wbFfh3yQ8JgpvKQEPsH+kfYQx+LrHt9v5LI=;
        b=dzPcWVVNkLHvKY2UIDWFCjsaPtonkr5gpkCptS673NmRqUA1hNG3+LlIO8ybFlvvsB
         GtjA6Q2RRdcEJzbR+gvo6lcC3S2E7ZoDclN5OZ1qVCpZHJiqJQswoXnp8zTeWzrvQIsU
         8K54x3nuKHkkgFciR+ky5R+7RzdjFKRBVy2eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=muA4hdM6wbFfh3yQ8JgpvKQEPsH+kfYQx+LrHt9v5LI=;
        b=lXZxx2mtgTd/0on2DhyOfTCr1uaHFSVokq0I0C0Z/ccliWRyo5K4ISwEiGly2617qq
         EnB/rzA9TDdiaKW4dyJQVaLwn1CnkXlvQkKyeP67tRBSsHvp0IHgBSjmg0hp+svwd3VW
         vGxeXTgQ2xHIk2Ne5vAbRpqaCMrg8hi4ztl76QE4JWqc2Cg+HPRQh20qBwvt31C7WGMU
         rUyiII7vZ3mn7OEcTCDdv2k16a87sHdZjcysgtwUUrfKR/QlUQPPZSrK9S6XF5iqMEqt
         CuOEp4TiArkMe/EVY1bX5DRE0eve5RRn7mcD3zEB0QCK2zMri8F81IKkzwBb+6f0usRa
         zapg==
X-Gm-Message-State: AHQUAuYQmWW4j+m2djfTX6NGCwuU3u+c5QKEPO7BSOZgwK0KbiHIS57E
        eKVL76a6GCE7DxQR4vL37xeyXA==
X-Google-Smtp-Source: AHgI3IYGZG2Q/iMX9JgSd6EYvlNIuWfCEEidkEfIQ9VnSs2R20mPixM78RkhGFdYg/3/mE3WdZ99Sw==
X-Received: by 2002:a17:902:12e:: with SMTP id 43mr3475692plb.31.1549348043742;
        Mon, 04 Feb 2019 22:27:23 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q9sm2348934pgn.0.2019.02.04.22.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 22:27:22 -0800 (PST)
Date:   Mon, 4 Feb 2019 22:27:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not
 needed by UFS device"
Message-ID: <20190205062720.GF31919@minitux>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
 <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Feb 20:58 PST 2019, Alim Akhtar wrote:

> Hi Marc,
> 
> On 04/02/19 11:12 PM, Marc Gonzalez wrote:
> > This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
> > 
> > Calling ufshcd_set_vccq_rail_unused hangs my system.
> > It seems vccq is not *not* needed.
> > 
> > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > ---
> 
> AFAIK Samsung and Toshiba UFS devices does not use VCCQ (this pin is 
> either floating or connected to Ground, at least on the devices that I 
> have worked on).

But why does such system define a vccq-supply? If the system doesn't
have a regulator connected to VCCQ, then the UFS driver shouldn't be
told that there is one. And if VCCQ is optional the UFS driver should
support the fact that this regulator might not be supplied (i.e. call
regulator_get_optional() and handle the error indicating that the supply
isn't specified).

Regards,
Bjorn

> You said your system hanged, I believe you have set UFS_DEVICE_NO_VCCQ 
> quirks, in that case VCCQ regulator should having been disabled.
> So you mean your system hanged because vccq regulator got disabled?
> 
> >   drivers/scsi/ufs/ufs.h    |  1 -
> >   drivers/scsi/ufs/ufshcd.c | 59 +++------------------------------------
> >   2 files changed, 4 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> > index dd65fea07687..7da7318eb6a6 100644
> > --- a/drivers/scsi/ufs/ufs.h
> > +++ b/drivers/scsi/ufs/ufs.h
> > @@ -514,7 +514,6 @@ struct ufs_vreg {
> >   	struct regulator *reg;
> >   	const char *name;
> >   	bool enabled;
> > -	bool unused;
> >   	int min_uV;
> >   	int max_uV;
> >   	int min_uA;
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 9ba7671b84f8..8b9a01073d62 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -245,7 +245,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba);
> >   static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
> >   				 bool skip_ref_clk);
> >   static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
> > -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused);
> >   static int ufshcd_uic_hibern8_exit(struct ufs_hba *hba);
> >   static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);
> >   static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
> > @@ -6819,11 +6818,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
> >   	ufs_fixup_device_setup(hba, &card);
> >   	ufshcd_tune_unipro_params(hba);
> >   
> > -	ret = ufshcd_set_vccq_rail_unused(hba,
> > -		(hba->dev_quirks & UFS_DEVICE_NO_VCCQ) ? true : false);
> > -	if (ret)
> > -		goto out;
> > -
> >   	/* UFS device is also active now */
> >   	ufshcd_set_ufs_dev_active(hba);
> >   	ufshcd_force_reset_auto_bkops(hba);
> > @@ -7007,24 +7001,13 @@ static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
> >   static inline int ufshcd_config_vreg_lpm(struct ufs_hba *hba,
> >   					 struct ufs_vreg *vreg)
> >   {
> > -	if (!vreg)
> > -		return 0;
> > -	else if (vreg->unused)
> > -		return 0;
> > -	else
> > -		return ufshcd_config_vreg_load(hba->dev, vreg,
> > -					       UFS_VREG_LPM_LOAD_UA);
> > +	return ufshcd_config_vreg_load(hba->dev, vreg, UFS_VREG_LPM_LOAD_UA);
> >   }
> >   
> >   static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
> >   					 struct ufs_vreg *vreg)
> >   {
> > -	if (!vreg)
> > -		return 0;
> > -	else if (vreg->unused)
> > -		return 0;
> > -	else
> > -		return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
> > +	return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
> >   }
> >   
> >   static int ufshcd_config_vreg(struct device *dev,
> > @@ -7062,9 +7045,7 @@ static int ufshcd_enable_vreg(struct device *dev, struct ufs_vreg *vreg)
> >   {
> >   	int ret = 0;
> >   
> > -	if (!vreg)
> > -		goto out;
> > -	else if (vreg->enabled || vreg->unused)
> > +	if (!vreg || vreg->enabled)
> >   		goto out;
> >   
> >   	ret = ufshcd_config_vreg(dev, vreg, true);
> > @@ -7084,9 +7065,7 @@ static int ufshcd_disable_vreg(struct device *dev, struct ufs_vreg *vreg)
> >   {
> >   	int ret = 0;
> >   
> > -	if (!vreg)
> > -		goto out;
> > -	else if (!vreg->enabled || vreg->unused)
> > +	if (!vreg || !vreg->enabled)
> >   		goto out;
> >   
> >   	ret = regulator_disable(vreg->reg);
> > @@ -7192,36 +7171,6 @@ static int ufshcd_init_hba_vreg(struct ufs_hba *hba)
> >   	return 0;
> >   }
> >   
> > -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused)
> > -{
> > -	int ret = 0;
> > -	struct ufs_vreg_info *info = &hba->vreg_info;
> > -
> > -	if (!info)
> > -		goto out;
> > -	else if (!info->vccq)
> > -		goto out;
> > -
> > -	if (unused) {
> > -		/* shut off the rail here */
> > -		ret = ufshcd_toggle_vreg(hba->dev, info->vccq, false);
> > -		/*
> > -		 * Mark this rail as no longer used, so it doesn't get enabled
> > -		 * later by mistake
> > -		 */
> > -		if (!ret)
> > -			info->vccq->unused = true;
> > -	} else {
> > -		/*
> > -		 * rail should have been already enabled hence just make sure
> > -		 * that unused flag is cleared.
> > -		 */
> > -		info->vccq->unused = false;
> > -	}
> > -out:
> > -	return ret;
> > -}
> > -
> >   static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
> >   					bool skip_ref_clk)
> >   {
> > 
