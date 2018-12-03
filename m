Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32580206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+s3Bu5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32580206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLCGm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:42:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33326 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeLCGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:42:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so5958196plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=231Tudf4Wlbfc1Gq1KAS4cejac6+ZJLTVFOAL2p+yxI=;
        b=a+s3Bu5VlGsPJhWFJZtpx3mCrLOvZki8+Nlssw8Bu0gU8X6gvukCluo/BzPRK4jeT/
         RY3YSC5I2pjjj8ULlMT7RBzgRRpRurWhFwBLDs4RyTPDW8WMxP1H2Lhb2J+SxK++SSRP
         fQ2dcimi9OV6AnHNJjSddQGNxTzs+Uf7H2pQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=231Tudf4Wlbfc1Gq1KAS4cejac6+ZJLTVFOAL2p+yxI=;
        b=luK7hMr7NniYc3i796YOGWU2rVc6tr640qGNG8v2uWBq4koWyL/iFW/gbHVaClsVMq
         w5rWHVuNbOU9FnZ4lOiTR1byMtEpBQTuGRo4Uf67lz3kj5FflBefu4IbrLtuG82HDPOY
         mpYodS7oe5DAOuF51bL+26Vay19UsQ5Rwy56RHUnrtq57/zgIUmVZ/1sm8pmdx0cDaGv
         cSYjOgl27MhicgtVGmPaqczlIm5ctYBuIqSJhUrCWkaXvyIgGqJQOTsjwgUSUyUxmB/+
         8U/pOzxOu49jtHhl3Z08Dm9P6vD2l8q4Z/EZ+zNCRsVID371Y1wDni8EUthwqGmr5yaH
         IPHg==
X-Gm-Message-State: AA+aEWaE59v8cnLU6L+y7DWAWXqnrXx+jtoTsBsLNgIdGj10SM/hQz6K
        d2GpxUik16t12GNSFO3PhM2Kkg==
X-Google-Smtp-Source: AFSGD/WmL6xEvTXLD2GMXI+WzWs1/dn0vzFWYJFdELpjuUSm6c+BARwsZzBHumVz5B+JiatgkSFGLQ==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr14978534plo.50.1543819343785;
        Sun, 02 Dec 2018 22:42:23 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id u78sm27763879pfi.2.2018.12.02.22.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 22:42:22 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:12:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/5] OPP: Add dev_pm_opp_xlate_performance_state()
 helper
Message-ID: <20181203064220.l5pxuyhljhnpeji6@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <8bb37fb6120221ded6abb53e69c86620aade20f6.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFo+P0oUoPuNCJV4eumn-cqrM5_LBOvY3qQ9qy_HY5Lt2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo+P0oUoPuNCJV4eumn-cqrM5_LBOvY3qQ9qy_HY5Lt2g@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-18, 09:45, Ulf Hansson wrote:
> On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> > be used to translate from pstate of a device to another one.
> 
> I don't get this, could you please elaborate?
> 
> >
> > Initially this will be used by genpd to find pstate of a master domain
> > using its sub-domain's pstate.
> 
> I assume pstate is the performance state of a genpd that you refer to,
> no? Please try to be a bit more descriptive in your changelogs, to
> avoid confusions.

Here is the new changelog:

    OPP: Add dev_pm_opp_xlate_performance_state() helper
    
    dev_pm_genpd_set_performance_state() needs to handle performance state
    propagation going forward. Currently this routine only gets the required
    performance state of the device's genpd as an argument, but it doesn't
    know how to translate that to master genpd(s) of the device's genpd.
    
    Introduce a new helper dev_pm_opp_xlate_performance_state() which will
    be used to translate from performance state of a device (or genpd
    sub-domain) to another device (or master genpd).
    
    Normally the src_table (of genpd sub-domain) will have the
    "required_opps" property set to point to one of the OPPs in the
    dst_table (of master genpd), but in some cases the genpd and its master
    have one to one mapping of performance states and so none of them have
    the "required-opps" property set. Return the performance state of the
    src_table as it is in such cases.
    
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>



Hope this looks fine ?

-- 
viresh
