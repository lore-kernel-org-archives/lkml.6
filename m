Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D7520851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfdbiwQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D7520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeLJRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:38:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33295 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeLJRi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:38:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so5580255plo.0;
        Mon, 10 Dec 2018 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hz707KYSnjULRGls5w6XQJ+JzChQr0hSm9QIMsDXICk=;
        b=QfdbiwQy6RldfvRr+5v1YIaSbczNX2W0wwUxUGQaBy9Oi3Bj2eB9dKnKd2gyxecMev
         7W86irwY+xqSIkqkLOaoI42f/GQMMYogPEtixpFc+eFqTZr+c4+erphGi+WDZ3E9IAIp
         95P+x/SDCLbvlxP/Xo1WJbIuiaLwI0xa8JtobZDjuSpiC7UmciDyhCZVerXxtBKoLSo2
         m/QFGa6uhLXB0Ftc4MvBcFr40mLafLLminhfo9VZsFyO4WjpKEo++ivAw1lYf4uXnbSq
         68P9BQxdq7NYsatlBQeUc5zuvrbJMCvw2VC4LcKcKIHeAgAihrXcdEpCC7VXRtq+vrEE
         fM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hz707KYSnjULRGls5w6XQJ+JzChQr0hSm9QIMsDXICk=;
        b=sc+zjuVkSrRAT0g6658uSoc81iUgM+XVy0Y+Lz5DCHcgYXVf5F/4yBoxtE1MxXNfi4
         FocgHoY0m/x4eDrW/vpTCGhLtdavJpmxYmHEgygg+x0a7iIT8zG+bQ2Jzl1zSGatlWjH
         d23XssEmRhfcAFE+JdInvl9n+9AYSXR846uh8TdHheWW83KkulXIe4Nfw0fcxNp+Y8Bw
         dOPB/vO85Db8jzwti9WMP4/g3txU3d6W0PXu6g3TC8nBIcP0ZXbJNSR72IgvojqmcFgO
         Y1oNrHvlAzJqkmSv6BbLBnSBi5BP1yGvgH/cpe1geGCKY+vA3RY/r/aisniv71JGFyZx
         K5DQ==
X-Gm-Message-State: AA+aEWZqmDMMModWPv0yO0jXNnySibTWu5Mq1/UsJWY+Tojb9RQqG2Bz
        LZxuDw6N/hx5XgvOuUcpXPI=
X-Google-Smtp-Source: AFSGD/XiH5/O2v2K/a5b7nBINiLufGI/8geS6LenbJbXRNpAQFYuoIZNrQ9U4E+5+LmgtYjwr0l8cA==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr13238115plt.30.1544463537242;
        Mon, 10 Dec 2018 09:38:57 -0800 (PST)
Received: from xldev-tmpl.dev.purestorage.com ([192.30.188.252])
        by smtp.gmail.com with ESMTPSA id e24sm15782588pfi.153.2018.12.10.09.38.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 09:38:56 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:38:54 -0700
From:   Anatoliy Glagolev <glagolig@gmail.com>
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     aglagolev@purestorage.com, qla2xxx-upstream@qlogic.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        kmahlkuc@linux.vnet.ibm.com
Subject: Re: [PATCH] scsi: qla2xxx: disabling pci error handler early
Message-ID: <20181210173853.GA36196@xldev-tmpl.dev.purestorage.com>
References: <1544212602-28085-1-git-send-email-glagolig@gmail.com>
 <d7b867f3-22d1-855d-86ce-43089e46ca6a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b867f3-22d1-855d-86ce-43089e46ca6a@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Brian. Great point. Even for AER, it looks like in-flight
error handler completion is not guaranteed on
pci_disable_pcie_error_reporting call, so the crash is still possible.
It looks like we need to maintain per-pci_dev context and keep track
of in-flight callbacks to make a clean fix. I will send a new patch.

On Fri, Dec 07, 2018 at 04:00:27PM -0600, Brian King wrote:
> On 12/07/2018 01:56 PM, Anatoliy Glagolev wrote:
> > qla2x00_disable_board_on_pci_error and pcie error handlers may run
> > in parallel. Specifically, I observed qla2xxx_pci_slot_reset running
> > at around the same moment as qla2x00_disable_board_on_pci_error.
> > If scsi_qla_host_t or qla_hw_data structs are removed before an error
> > handler completes, the handler crashes.
> > 
> > This patch disables pcie error handling early in
> > qla2x00_disable_board_on_pci_error and in other paths that remove
> > those structs.
> 
> While this may fix this issue for PCIe AER, I think you'll still have
> the exposure for EEH errors on a Power system, since we don't have
> the pci_enable_pcie_error_reporting API wired up to do anything,
> nor do we have much ability to do anything with it since its an
> attribute of the hardware.
> 
> Is there a way to fix this that doesn't break Power?
> 
> Thanks,
> 
> Brian
> 
> > 
> > Signed-off-by: Anatoliy Glagolev <glagolig@gmail.com>
> > ---
> >  drivers/scsi/qla2xxx/qla_os.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> > index e881fce..b8f277a 100644
> > --- a/drivers/scsi/qla2xxx/qla_os.c
> > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > @@ -2775,9 +2775,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
> >  			return ret;
> >  	}
> > 
> > -	/* This may fail but that's ok */
> > -	pci_enable_pcie_error_reporting(pdev);
> > -
> >  	ha = kzalloc(sizeof(struct qla_hw_data), GFP_KERNEL);
> >  	if (!ha) {
> >  		ql_log_pci(ql_log_fatal, pdev, 0x0009,
> > @@ -3039,6 +3036,9 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
> >  		goto probe_hw_failed;
> >  	}
> > 
> > +	/* This may fail but that's ok */
> > +	pci_enable_pcie_error_reporting(pdev);
> > +
> >  	pci_set_drvdata(pdev, base_vha);
> >  	set_bit(PFLG_DRIVER_PROBING, &base_vha->pci_flags);
> > 
> > @@ -3400,6 +3400,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
> >  		kthread_stop(t);
> >  	}
> > 
> > +	pci_disable_pcie_error_reporting();
> > +
> >  	qla2x00_free_device(base_vha);
> >  	scsi_host_put(base_vha->host);
> >  	/*
> > @@ -3625,6 +3627,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
> >  	}
> >  	qla2x00_wait_for_hba_ready(base_vha);
> > 
> > +	pci_disable_pcie_error_reporting(pdev);
> > +
> >  	qla2x00_wait_for_sess_deletion(base_vha);
> > 
> >  	/*
> > @@ -3698,8 +3702,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
> >  	pci_release_selected_regions(ha->pdev, ha->bars);
> >  	kfree(ha);
> > 
> > -	pci_disable_pcie_error_reporting(pdev);
> > -
> >  	pci_disable_device(pdev);
> >  }
> > 
> > @@ -5826,6 +5828,8 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
> >  		return;
> >  	}
> > 
> > +	pci_disable_pcie_error_reporting(pdev);
> > +
> >  	qla2x00_wait_for_sess_deletion(base_vha);
> > 
> >  	set_bit(UNLOADING, &base_vha->dpc_flags);
> > @@ -5866,7 +5870,6 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
> >  	qla2x00_unmap_iobases(ha);
> > 
> >  	pci_release_selected_regions(ha->pdev, ha->bars);
> > -	pci_disable_pcie_error_reporting(pdev);
> >  	pci_disable_device(pdev);
> > 
> >  	/*
> > 
> 
> 
> -- 
> Brian King
> Power Linux I/O
> IBM Linux Technology Center
> 
