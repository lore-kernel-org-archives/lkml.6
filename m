Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77305C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2423E20838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ye2NAM8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJYOBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:01:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53912 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbeJYOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:01:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id l26-v6so138714wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gs9SgyZuw+dbAm6aFOPXkL0Pu2vbsZ/++lD/Uq0//bU=;
        b=Ye2NAM8pj7R+R3sjfvuIugGew6SEcHzoWDzP3TM8IPg7VilLgE2ILqaU5QJFAXlVKQ
         iQSqZabpEnHkxOIzNZIs4lI8rFyAfa72XdoO6Qj5Sa+xJBzJNBvJqyqvFpBqmhoMDuGr
         D5Isju5BkrtEv+YakBnVbq8GGCQljDlwf58jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gs9SgyZuw+dbAm6aFOPXkL0Pu2vbsZ/++lD/Uq0//bU=;
        b=Pddb+TwROzrXcp9q7rzWiyPwdUKJv31Nkt69ElivH80uXwv5q0ZPzlTzVt0G/Iq9Wd
         x8UX4s7fKVjUMSKDr5SDZla94/2dpatP3YnD27Aj1DGDGAQp3lWStH+rIKaVyeRMjd6I
         pmC3iEXUEi1JK+uK/+zmtEngo6YPBe3jxSRV3NQRmBWBV6LoQidxUy+et+acJGCGx11D
         /7xKBxv5ri/dLd+DwAq+pOe4JRK1DZejqi4AMiYfMfgIbDoh5vOGYlQGxKExIV85Moff
         xNtVx+axxpPCiAbuZ3b6vE+iCo03fNGyiZfIfX7WUHnwfLMRx5X5tUItjMiYUNlRN6r5
         9EuA==
X-Gm-Message-State: AGRZ1gIwM8dJCEZkf9z8/LSc+S8JqwL/fqm419xqCIjlcHnx+koG3xPG
        QJ/Wb2y+XN912hpD8gVFXRMQLA==
X-Google-Smtp-Source: AJdET5ehNHALzH5Dzebf5elfVS5aMvq/tcovbcMP1c2szsGgEfBmv+6If/oxsm3CbFBcfPc6FDWdLg==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr236310wmd.100.1540445433628;
        Wed, 24 Oct 2018 22:30:33 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id u9-v6sm5374658wrr.66.2018.10.24.22.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 22:30:32 -0700 (PDT)
Date:   Thu, 25 Oct 2018 06:30:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH v8 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
Message-ID: <20181025053030.GD4939@dell>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-9-jae.hyun.yoo@linux.intel.com>
 <20181024105903.GB4939@dell>
 <db7570cb-8f63-b551-d119-c54270ce6139@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db7570cb-8f63-b551-d119-c54270ce6139@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018, Jae Hyun Yoo wrote:
> On 10/24/2018 3:59 AM, Lee Jones wrote:
> > On Tue, 18 Sep 2018, Jae Hyun Yoo wrote:
> > 
> > > This commit adds PECI client MFD driver.
> > > 
> 
> <snip>

[...]

> > > +bool peci_temp_need_update(struct temp_data *temp)
> > > +{
> > > +	if (temp->valid &&
> > > +	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +EXPORT_SYMBOL_GPL(peci_temp_need_update);
> > > +
> > > +void peci_temp_mark_updated(struct temp_data *temp)
> > > +{
> > > +	temp->valid = 1;
> > > +	temp->last_updated = jiffies;
> > > +}
> > > +EXPORT_SYMBOL_GPL(peci_temp_mark_updated);
> > 
> > These are probably better suited as inline functions to be placed in
> > a header file.  No need to export them, since they only use their own
> > data.

Also move them into the HWMON header file.

They have no business in MFD.

[...]

> > > +int peci_client_rd_pkg_cfg_cmd(struct peci_mfd *priv, u8 mbx_idx,
> > 
> > This is gobbledegook.  What's rd?  Read?
> > 
> 
> Yes, the 'rd' means 'read'. I intended to keep command names as listed
> in the PECI specification such as RdPkgConfig, WrPkgConfig and so on.
> Should I change it to 'peci_client_read_package_config_command' ?

I looks/reads a lot nicer, don't you think?

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
