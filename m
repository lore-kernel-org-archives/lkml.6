Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeDJS0u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:26:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35088 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJS0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:26:48 -0400
X-Google-Smtp-Source: AIpwx49GsfCXlU/LHXlDOfxgkqUVZowI038A/dlGus2cEtfeOi+8DKL2g5NJIrBsYSaxmscCopjmGw==
Date: Tue, 10 Apr 2018 11:27:29 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic PALLARDY <loic.pallardy@st.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/3] rpmsg: Only invoke announce_create for rpdev with
 endpoints
Message-ID: <20180410182729.GB1510@tuxbook-pro>
References: <20180327210643.3436-1-bjorn.andersson@linaro.org>
 <20180327210643.3436-3-bjorn.andersson@linaro.org>
 <3c952b4ca0cc4666ba01cf0dbe605248@SFHDAG7NODE2.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c952b4ca0cc4666ba01cf0dbe605248@SFHDAG7NODE2.st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 Apr 02:12 PDT 2018, Loic PALLARDY wrote:
> > -----Original Message-----
> > From: linux-remoteproc-owner@vger.kernel.org [mailto:linux-remoteproc-
> > owner@vger.kernel.org] On Behalf Of Bjorn Andersson
[..]
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index dffa3aab7178..e85d2691d2cf 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -442,7 +442,7 @@ static int rpmsg_dev_probe(struct device *dev)
> >  		goto out;
> >  	}
> > 
> > -	if (rpdev->ops->announce_create)
> > +	if (ept && rpdev->ops->announce_create)
> 
> This check is already part of virtio_rpmsg.c (see line 341)
> 	/* need to tell remote processor's name service about this channel ? */
> 	if (rpdev->announce && rpdev->ept &&
> 	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {

The introduction of rpdev->ept in this check was done by Henri, as he
was implementing rpmsg_char support for virtio_rpmsg:

b2599ebffb2d ("rpmsg: virtio_rpmsg_bus: fix announce for devices without endpoint")

It's there because the rpmsg_device will not have a primary endpoint and
as such there's no communication channel to announce. We could add this
check in each implementation of announce, but I think it's a common
issue.

> 
> should it be part of qcom_smd driver too? (but each implementation will duplicate checks)
> Or may have a generic check in the core including rpdev->announce as well (and doing virtio_rpmsg.c clean-up)
> 

I think we want to remove the ept check in virtio_rpmsg, to reduce that
part of the duplication at least.

> Change will become:
> 	if (rpdev->announce && ept && rpdev->ops->announce_create)
> 

That might make sense, let's see what Wendy comes up with related to
rpmsg_char and supporting Linux-side services, as I suspect that this
handling might be affected.

Regards,
Bjorn
