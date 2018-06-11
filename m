Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56D71C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B43B20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKvDO4SU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B43B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934278AbeFKUp3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933204AbeFKUp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:45:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F9120839;
        Mon, 11 Jun 2018 20:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528749926;
        bh=O6MXkE9dvC/xZu35zWNiDz+9cz6yl1xemYEV74ViOy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKvDO4SU0twjrqtZY3B/ox0xrMGtuEJ+AL1U/pk77CuAsNDpH7jqUEDAbky/PkRRQ
         prZi7/1jsSrLIc3IKOs+HTPIEOZRNvCMrZrUC3y2fuK80aOORLPGIo+t7HU1BpfjHI
         hfTt1LIz0FBJ8YRGPXCuVXtrQz4cjzDxv5JNp8LE=
Date:   Mon, 11 Jun 2018 22:45:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Colin King <colin.king@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: pcie: make array prop static, shrinks object
 size
Message-ID: <20180611204506.GA21542@kroah.com>
References: <20180611171537.14597-1-colin.king@canonical.com>
 <7f508dccf95cff7fb8e083666b8939c58f65f894.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f508dccf95cff7fb8e083666b8939c58f65f894.camel@perches.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:40:55PM -0700, Joe Perches wrote:
> (adding Greg KH)
> 
> On Mon, 2018-06-11 at 18:15 +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Don't populate the read-only array 'prop' on the stack but
> > instead make it static. Makes the object code smaller by 20 bytes:
> > 
> > Before:
> >    text    data     bss     dec     hex filename
> >   71659   14614     576   86849   15341 trans.o
> > 
> > After:
> >    text    data     bss     dec     hex filename
> >   71479   14774     576   86829   1532d trans.o
> > 
> > (gcc version 7.3.0 x86_64)
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > index 7229991ae70d..c4626ebe5da1 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > @@ -1946,7 +1946,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
> >  	struct iwl_trans_pcie_removal *removal =
> >  		container_of(wk, struct iwl_trans_pcie_removal, work);
> >  	struct pci_dev *pdev = removal->pdev;
> > -	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
> > +	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
> >  
> >  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
> >  	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
> 
> Now what is happening is that prop is being reloaded
> each invocation with the constant addresses of the strings.
> 
> It seems the prototype and function for kobject_uevent_env
> should change as well to avoid this.
> 
> Perhaps this should become:
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
>  include/linux/kobject.h                         | 2 +-
>  lib/kobject_uevent.c                            | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index 7229991ae70d..6668a8aad22e 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -1946,7 +1946,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
>  	struct iwl_trans_pcie_removal *removal =
>  		container_of(wk, struct iwl_trans_pcie_removal, work);
>  	struct pci_dev *pdev = removal->pdev;
> -	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
> +	static const char * const prop[] = {"EVENT=INACCESSIBLE", NULL};
>  
>  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
>  	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index 7f6f93c3df9c..9f5cf553dd1e 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -217,7 +217,7 @@ extern struct kobject *firmware_kobj;
>  
>  int kobject_uevent(struct kobject *kobj, enum kobject_action action);
>  int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
> -			char *envp[]);
> +			const char * const envp[]);
>  int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count);
>  
>  __printf(2, 3)
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 63d0816ab23b..9107989a0cc8 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -452,7 +452,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>   * corresponding error when it fails.
>   */
>  int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
> -		       char *envp_ext[])
> +		       const char * const envp_ext[])
>  {
>  	struct kobj_uevent_env *env;
>  	const char *action_string = kobject_actions[action];

No objection from me, care to make it a real patch so that I can apply
it after 4.18-rc1 is out?

thanks,

greg k-h
