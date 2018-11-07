Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CBFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB7E2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj9tEFq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB7E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKGXaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbeKGXaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:30:17 -0500
Received: from localhost (unknown [104.153.224.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD262085B;
        Wed,  7 Nov 2018 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541599187;
        bh=9RT93D5eu/JKlNHDMo1cWfHDAAwDqs/ydW8HvB+/gGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wj9tEFq4Tn5+AATzawPiSEXTraJWEFwJgQiiXjMNiv58JPPQctz1Lt7cgjZWEevxo
         uENlq46qEURJpNJUHpE9QxO1h3tWxwPCdmD8Wctxnd1xPiEtjUqXIJGD7P004eM8st
         2EAfNOidteTGqY9Kj+yHzb+GYzkZ2cViKiQ70zHA=
Date:   Wed, 7 Nov 2018 14:59:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Message-ID: <20181107135911.GA23393@kroah.com>
References: <20181015183218.GA16900@kroah.com>
 <20181015194441.10475-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015194441.10475-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 09:44:41PM +0200, Niklas Cassel wrote:
> QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
> to select it, not depend upon it.
> 
> Because of this change, we now also need to depend on the same
> Kconfigs as QCOM_QMI_HELPERS depends on.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Hello Greg, Srini,
> 
> I'm sorry for this.
> (Although I'm a bit curious why 0-day test bot didn't catch this.)
> 
> Considering that I've just changed QCOM_QMI_HELPERS in:
> ccfb464cd106 ("soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs")
> which is currently in linux-next, and that this Kconfig should
> depend on the same Kconfigs as QCOM_QMI_HELPERS depends on,
> I chose to have this Kconfig match the QCOM_QMI_HELPERS that is
> currently in linux-next.

Really?  I do this and then I get this build error on x86:

drivers/slimbus/qcom-ngd-ctrl.c: In function ‘of_qcom_slim_ngd_register’:
drivers/slimbus/qcom-ngd-ctrl.c:1333:63: warning: dereferencing ‘void *’ pointer
  data = of_match_node(qcom_slim_ngd_dt_match, parent->of_node)->data;
                                                               ^~
drivers/slimbus/qcom-ngd-ctrl.c:1333:63: error: request for member ‘data’ in something not a structure or union


So I can't take this, something else must be wrong here...

thanks,

greg k-h
