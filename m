Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72685C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F11020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2lbSXnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfAQW6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:58:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33586 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfAQW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:58:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so5567392pfb.0;
        Thu, 17 Jan 2019 14:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hOLHsDcN3M+Y15CByh8o4KM+bOk6ckKCKfslehmFH/k=;
        b=s2lbSXnd7TrNJEEZJeJ9t0qmbjylrH/uKnwg5UeUpLAdpP4j9V2eevtlqv0g9GHcIM
         Sd8PEehI0MEV2A9jYdzoEw+IOfvHEEEFn3+B7li91/lDklKPDDJO/puvSCL0EJ7u0/7k
         tIPoBi/9otw7pABd5TtThLfJOt9coloc07E46LyGz73i8JjYz10gq/k8EQEmry4hYRs4
         kvJNDH/kox2b2y+LX2+O8SWRtNDKS1xsGSPK3xXGNNgothCt+4fZEnE0R/pv15N730EL
         fKvuf5PFg+0tXDfWUfwkHZ3cL0/gY1V+vEqHzetWiJDTeggiKGOy49u2QwPXDH13Viqf
         rgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOLHsDcN3M+Y15CByh8o4KM+bOk6ckKCKfslehmFH/k=;
        b=dLM9fCX8458toJfiQtWPPnVUed1tpv1Bq46M3yx1odjjwtSLX4sPV6uCQK49NmxC+j
         rxwQSKUFaZWCd18n9qwugYm/ElSG2wZrt0KOYduCy2z0N+view4uZdp0Y3u9T9IYUZVt
         v8d3oriSfnlADNrKQWLulWervvko3NV7UWmhlMvUXlMFDYWO7xtPDI+uLq6/++a6wPI7
         724tyO3dJ+LOe3glicif4u42ay05+mo6mqzzOB3Fv7hNOGyClN900ROK42sMon2RNtTR
         5c/NzoN/NP9DrAlNpO7AnzqQ5ygJxzleI3nnpoeccWUXpzttSTt7Q13SL898pLTUnNe1
         RFXw==
X-Gm-Message-State: AJcUukcDMGNq8xlWE1LMip8964sC3qtOgw6DVMwoXSSalSB7x4kn+LSD
        ksg/vBJ+LLprtSdrgukVYXQ=
X-Google-Smtp-Source: ALg8bN5+T+GJog8Bs/9xRoNGZO//4jCFVdLOdrvik+3Nqlsrw2MG4rIOpwWLmOyqTwVRPcAjGSML8A==
X-Received: by 2002:a63:2141:: with SMTP id s1mr15286016pgm.148.1547765924849;
        Thu, 17 Jan 2019 14:58:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm4048761pfp.125.2019.01.17.14.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 14:58:43 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:58:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (ina3221) Implement ti,single-shot DT
 property
Message-ID: <20190117225842.GA23511@roeck-us.net>
References: <20190105030636.533-1-nicoleotsuka@gmail.com>
 <20190105030636.533-3-nicoleotsuka@gmail.com>
 <20190107193555.GA13547@roeck-us.net>
 <20190117223012.GH16918@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117223012.GH16918@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:30:13PM -0800, Nicolin Chen wrote:
> On Mon, Jan 07, 2019 at 11:35:55AM -0800, Guenter Roeck wrote:
> 
> > > +	if (of_property_read_bool(np, "ti,single-shot"))
> > > +		ina->single_shot = true;
> > > +
> > 	ina->single_shot = of_property_read_bool(np, "ti,single-shot");
> > 
> > No need to resend right now; let's wait for feedback from Rob.
> 
> Looks like Rob has acked. Is this resend version fine for review?
> 
"Right now" was supposed to mean that you should wait for Rob's
feedback before sending v3 with the feedback above applied.
Did you send that version ? I don't see it in patchwork, nor
in my inbox.

Thanks,
Guenter
