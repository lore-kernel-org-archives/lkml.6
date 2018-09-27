Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF3AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B8421710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn9sIeeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B8421710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeI1ErZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:47:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42521 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1ErZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:47:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so2332391pgq.9;
        Thu, 27 Sep 2018 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lOIve25UwKnZgqeZiZurWTEAw8byIOfDlSwqLjlu6cc=;
        b=pn9sIeeC9xpKXUL8zH4U5X1aLIv/EyWt9fUVb8EkJGBBcbZTU2RVgxVNxHhGdgw7/U
         iVx0qiO07d+vkibPPdzV/Npjdc+zBsQ5EXpI7Om4nIGLI0rlYwLtNf8f1jaq8PiudVWb
         mRNQqNO9rf0znOYO9OI04DJWEJ9wuemnl7HzdhCLQWQS08sBPl0OYculdhKSgbIycRyH
         cpCStEzwj24h+kN5p4zVty+nsK+mdf+H4MXyrnurtHVRLPq5xzSAU2sxyxtSB8aq0jr+
         k2mBxLHcDVoPYQrp845bMhw65+nvcaOf27CAzVzF79Uay6owHTL5BwoO8V84/V3zwEcY
         tAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lOIve25UwKnZgqeZiZurWTEAw8byIOfDlSwqLjlu6cc=;
        b=slSNo04zllFMSElcsqmkTN12UlgieDnUoh2vC4HKsXKLiw8elyvTfirob6XXVTPida
         fJy8b+Udqy76LM1jKU+laRyXD/h9wu7i1MILgTczCuBoEV7wWXkrEM04SBcNrl2bys6l
         Zv2UJy5Mhaa2Czy6hMxjAPMfYK/bwx8FFrvaoD5yckPsa6+stnpZQftYmb3d9LMPQAfm
         DxbibMzqnyo0IglXnDzw9cDw+2le5SePXL73XgbUwTslcDXEYD6JrTCSvEB8vM8i+Wds
         /5D96QP6mua8gw3Z3A1DESMeHyfJHzEKoi9o7tPlVXSNvJp5/Q5305whZqZfFU1UNF2f
         9YVA==
X-Gm-Message-State: ABuFfohEEx94ZtnvUqDMzjmJaDnaq08Jbtp2yh9e+Knyo918ebhTYxFl
        lGVlHyBoq25HcK53pu9Nmq2r2LN+
X-Google-Smtp-Source: ACcGV60z10Q+y48JXwBr3J6/wI3bxnkKzEGEcJtf26Itc9zHMheunYeicS1N+6k9t6bCH7vGnj8nWA==
X-Received: by 2002:a63:c4f:: with SMTP id 15-v6mr12253413pgm.155.1538087213692;
        Thu, 27 Sep 2018 15:26:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id p19-v6sm4475076pgh.60.2018.09.27.15.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:26:53 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:26:14 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180927222614.GA8430@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:06:32AM -0700, Guenter Roeck wrote:
> > +static inline bool ina3221_is_enable(struct ina3221_data *ina, int channel)
> 
> s/is_enable/is_enabled/, maybe ?

Fixing.

> > +	return (config & INA3221_CONFIG_CHx_EN(channel)) > 0;
> 
> The "> 0" is unnecessary. Conversion to bool is automatic. If you want to make
> it explicit, please use
> 
> 	return !!(config & INA3221_CONFIG_CHx_EN(channel));

Removing "> 0".

> It should not be necessary to re-read the value from the chip all the time.
> I would suggest to cache the value in the 'disabled' variable.

Regarding this part, I added a cache before sending this one. But
I realized if the chip got powered off and rebooted during system
suspend/resume, the cache would not reflect the actual status. As
I mentioned earlier, this was enlightened by your comments about
the BIOS. So I feel it'd be safer to read the register every time
at this point, until I add the suspend/resume feature by syncing
with regcache. What do you think about it?

> > +	ret = kstrtoint(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* inX_enable only accepts 1 for enabling or 0 for disabling */
> > +	if (val != 0 && val != 1)
> > +		return -EINVAL;
> > +
> Just use kstrtobool().

Fixing.

Thanks
Nicolin
