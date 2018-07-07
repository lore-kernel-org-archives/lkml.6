Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2EFC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0525208DD
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0525208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeGGNiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 09:38:18 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:50905 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeGGNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 09:38:17 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7F6E92801E50B;
        Sat,  7 Jul 2018 15:38:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 24D1C36A1B; Sat,  7 Jul 2018 15:38:15 +0200 (CEST)
Date:   Sat, 7 Jul 2018 15:38:15 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH 5/5] thunderbolt: Add support for runtime PM
Message-ID: <20180707133815.GA6656@wunner.de>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618110731.57427-6-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 02:07:31PM +0300, Mika Westerberg wrote:
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -132,6 +133,8 @@ static ssize_t boot_acl_show(struct device *dev, struct device_attribute *attr,
>  	if (!uuids)
>  		return -ENOMEM;
>  
> +	pm_runtime_get_sync(&tb->dev);
> +
>  	if (mutex_lock_interruptible(&tb->lock)) {
>  		ret = -ERESTARTSYS;
>  		goto out;
[snip]
> @@ -426,6 +437,13 @@ int tb_domain_add(struct tb *tb)
>  	/* This starts event processing */
>  	mutex_unlock(&tb->lock);
>  
> +	pm_runtime_no_callbacks(&tb->dev);
> +	pm_runtime_set_active(&tb->dev);
> +	pm_runtime_enable(&tb->dev);
> +	pm_runtime_set_autosuspend_delay(&tb->dev, TB_AUTOSUSPEND_DELAY);
> +	pm_runtime_mark_last_busy(&tb->dev);
> +	pm_runtime_use_autosuspend(&tb->dev);
> +
>  	return 0;
>  
>  err_domain_del:

You're setting pm_runtime_no_callbacks() on the domain.  A side effect of
setting this flag is that whenever the domain's device is runtime resumed,
it's parent (the NHI) is *not* runtime resumed, see this comment in
rpm_resume():

	/*
	 * See if we can skip waking up the parent.  This is safe only if
	 * power.no_callbacks is set, because otherwise we don't know whether
	 * the resume will actually succeed.
	 */

Above, you're runtime resuming the domain in boot_acl_show().  So if the
NHI is runtime suspended while that sysfs attribute is accessed, it won't
be runtime resumed.  Is that actually what you want?


> @@ -514,6 +532,28 @@ void tb_domain_complete(struct tb *tb)
>  		tb->cm_ops->complete(tb);
>  }
>  
> +int tb_domain_runtime_suspend(struct tb *tb)
> +{
> +	if (tb->cm_ops->runtime_suspend) {
> +		int ret = tb->cm_ops->runtime_suspend(tb);
> +		if (ret)
> +			return ret;
> +	}
> +	tb_ctl_stop(tb->ctl);
> +	return 0;
> +}
> +
> +int tb_domain_runtime_resume(struct tb *tb)
> +{
> +	tb_ctl_start(tb->ctl);
> +	if (tb->cm_ops->runtime_resume) {
> +		int ret = tb->cm_ops->runtime_resume(tb);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  /**
>   * tb_domain_approve_switch() - Approve switch
>   * @tb: Domain the switch belongs to
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -900,7 +900,32 @@ static void nhi_complete(struct device *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct tb *tb = pci_get_drvdata(pdev);
>  
> -	tb_domain_complete(tb);
> +	/*
> +	 * If we were runtime suspended when system suspend started,
> +	 * schedule runtime resume now. It should bring the domain back
> +	 * to functional state.
> +	 */
> +	if (pm_runtime_suspended(&pdev->dev))
> +		pm_runtime_resume(&pdev->dev);
> +	else
> +		tb_domain_complete(tb);
> +}
> +
> +static int nhi_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tb *tb = pci_get_drvdata(pdev);
> +
> +	return tb_domain_runtime_suspend(tb);
> +}
> +
> +static int nhi_runtime_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tb *tb = pci_get_drvdata(pdev);
> +
> +	nhi_enable_int_throttling(tb->nhi);
> +	return tb_domain_runtime_resume(tb);
>  }

You're invoking tb_domain_runtime_suspend() from nhi_runtime_suspend(),
same for ->runtime_resume.

Wouldn't it make more sense to make tb_domain_runtime_suspend() the
->runtime_suspend callback of the domain instead of mixing it together
with NHI runtime suspend?

BTW, what's the purpose of nhi_enable_int_throttling()?


> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> +/*
> + * Currently only need to provide the callbacks. Everything else is handled
> + * in the connection manager.
> + */
> +static int __maybe_unused tb_switch_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int __maybe_unused tb_switch_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops tb_switch_pm_ops = {
> +	SET_RUNTIME_PM_OPS(tb_switch_runtime_suspend, tb_switch_runtime_resume,
> +			   NULL)
> +};
> +
>  struct device_type tb_switch_type = {
>  	.name = "thunderbolt_device",
>  	.release = tb_switch_release,
> +	.pm = &tb_switch_pm_ops,
>  };

Looking at the call sites of RPM_GET_CALLBACK(), I'm under the impression
that if no callbacks are defined, the PM core will simply assume success.
Then you don't need to define any PM callbacks for tb_switch.  Am I missing
something?

Thanks,

Lukas
