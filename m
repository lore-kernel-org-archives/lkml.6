Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeBUTdq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:33:46 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33880 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBUTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:33:42 -0500
X-Google-Smtp-Source: AH8x226THIWDsdlcb/f32LDw0+9m5N2jc06mf4QYHBkdRqnBsroRjBw2qGRVteEvUkt/lodjCnHZQQ==
Date: Wed, 21 Feb 2018 11:33:38 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jitendra Sharma <shajit@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Govind Singh <govinds@qti.qualcomm.com>,
        Shon Parate <sparate@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: rmtfs-mem: Add support for assigning
 memory to remote
Message-ID: <20180221193338.GB18510@minitux>
References: <20180213013724.3177-1-bjorn.andersson@linaro.org>
 <7d9ab926-a0cd-267e-6c85-3e3af2467e97@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9ab926-a0cd-267e-6c85-3e3af2467e97@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Feb 05:04 PST 2018, Jitendra Sharma wrote:

> Hi Bjorn,
> 
> 
> On 2/13/2018 7:07 AM, Bjorn Andersson wrote:
> > On some platform the remote processor's memory map is not statically
> > configured in TrustZone, so each memory region that is to be accessed by
> > the remote needs a call into TrustZone to set up the remote's
> > permissions.
> > 
> > Implement this for the rmtfs memory driver, to give the modem on 8996
> > access to the shared file system buffers.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >   drivers/soc/qcom/Kconfig     |  1 +
> >   drivers/soc/qcom/rmtfs_mem.c | 34 ++++++++++++++++++++++++++++++++++
> >   2 files changed, 35 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index e050eb83341d..a993d19fa562 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -47,6 +47,7 @@ config QCOM_QMI_HELPERS
> >   config QCOM_RMTFS_MEM
> >   	tristate "Qualcomm Remote Filesystem memory driver"
> >   	depends on ARCH_QCOM
> > +	select QCOM_SCM
> >   	help
> >   	  The Qualcomm remote filesystem memory driver is used for allocating
> >   	  and exposing regions of shared memory with remote processors for the
> > diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> > index 0a43b2e8906f..c8999e38b005 100644
> > --- a/drivers/soc/qcom/rmtfs_mem.c
> > +++ b/drivers/soc/qcom/rmtfs_mem.c
> > @@ -37,6 +37,8 @@ struct qcom_rmtfs_mem {
> >   	phys_addr_t size;
> >   	unsigned int client_id;
> > +
> > +	unsigned int perms;
> >   };
> >   static ssize_t qcom_rmtfs_mem_show(struct device *dev,
> > @@ -151,9 +153,11 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
> >   static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> >   {
> >   	struct device_node *node = pdev->dev.of_node;
> > +	struct qcom_scm_vmperm perms[2];
> >   	struct reserved_mem *rmem;
> >   	struct qcom_rmtfs_mem *rmtfs_mem;
> >   	u32 client_id;
> > +	u32 vmid;
> >   	int ret;
> >   	rmem = of_reserved_mem_lookup(node);
> > @@ -204,10 +208,31 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> >   	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
> > +	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
> > +	if (ret < 0 && ret != -EINVAL) {
> > +		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");
> > +		goto remove_cdev;
> > +	} else if (!ret) {
> > +		perms[0].vmid = QCOM_SCM_VMID_HLOS;
> > +		perms[0].perm = QCOM_SCM_PERM_RW;
> > +		perms[1].vmid = vmid;
> > +		perms[1].perm = QCOM_SCM_PERM_RW;
> > +
> > +		rmtfs_mem->perms = BIT(QCOM_SCM_VMID_HLOS);
> > +		ret = qcom_scm_assign_mem(rmtfs_mem->addr, rmtfs_mem->size,
> > +					  &rmtfs_mem->perms, perms, 2);
> > +		if (ret < 0) {
> > +			dev_err(&pdev->dev, "assign memory failed\n");
> > +			goto remove_cdev;
> > +		}
> > +	}
> > +
> I have a query here,
> We assigned memory ownership to modem at boot up. In case of errors in other
> parts of driver, where we are returning, have we assigned memory back to
> HLOS

We're assigning the rmtfs memory to MPSS from the time this driver
probes until it is removed. The PIL related memory regions shared with
MPSS is handled by the remoteproc driver, for the duration of the MPSS
being up.

The one issue worth mentioning here is that this extends the dependency
the booting MPSS have on the remote-storage QMI service being
functional, i.e. if this device isn't present, we can't serve
remote-storage requests and MPSS will not function.

I haven't yet come up with a good idea of how to make the MPSS PIL
explicitly depend on the remote-storage service being present.

Regards,
Bjorn
