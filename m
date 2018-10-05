Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2B9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABteVN3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2B9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeJFBpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:45:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41385 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbeJFBpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:45:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so5095781pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hzYLogY2p5TzBJ4aSV1Se+L4V3+rxWdFjXrpyYwynqo=;
        b=ABteVN3U5jJoF57ylkW8762HmjMH15OaDyTOaiTdGDT/caCEMTCxPwHq8AzVKsS7KB
         GkNp6vuIDWoWHESSrKm51JSr9Tbn6BFeZ2yE78N3Z+uN47/iOgtNnpBtzdUcdvWpCtCL
         CTJuyL90du1t51PyAMuiz/cAHpgZmsBbTzy8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hzYLogY2p5TzBJ4aSV1Se+L4V3+rxWdFjXrpyYwynqo=;
        b=CYX7N9ZwX1RNoyu54lzEf0GJei5qgqx4MOMeEFb/SLK3zvkDdTyuVwifcZRTbXzEoR
         H+8XL8mTS6WCcXh0aV8PWN+duHUrf+Sj7bh2yKGdYj03S5wWoB/O++ZHdsPGAuYivBUn
         Amb/dLscxQsw4LIRT9t6q585BjuDYRwLIjYz5zTozcWC5Xm2EXIynBwQBv5dYFkP1Wfw
         ZjNv/JO3Z4/EOf48proRKiFXsg20jJHjwovwkwDxyg2MM+OkUFPLEwd++i+SgIHMTxXf
         JnpZ/84deEvTF9GK0ovTVDSajH7/Q3YATWsM2VouUG0jfYc6zvikFb+IAmL+Nvw/7JeW
         3i0Q==
X-Gm-Message-State: ABuFfohlRDJJJv6keFaC3HVOk2pCmeqvgDxRa9j15jtVtTcylFlP8TC9
        TIJHIoRRGMAnUpNUktmfukxeJQ==
X-Google-Smtp-Source: ACcGV63Gac4m75wlNhZsaRBeNtABDzc7TCx9hjUoWDDnlyyqqUCBik+P+3wftQqoSkT/BxvT8JYRJQ==
X-Received: by 2002:a62:830e:: with SMTP id h14-v6mr13522492pfe.29.1538765119406;
        Fri, 05 Oct 2018 11:45:19 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q21-v6sm32667978pfq.51.2018.10.05.11.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 11:45:18 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:48:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sibi Sankar <sibis@codeaurora.org>, mka@chromium.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 0/6] Add support for PDC Global on SDM845 SoCs
Message-ID: <20181005184804.GA12063@builder>
References: <20180829191215.10071-1-sibis@codeaurora.org>
 <20180903193647.GJ3456@tuxbook-pro>
 <2ae729fe-321b-0918-a06c-d04e43b47101@codeaurora.org>
 <1538729187.3545.2.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538729187.3545.2.camel@pengutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05 Oct 01:46 PDT 2018, Philipp Zabel wrote:

> Hi Sibi, Bjorn,
> 
> On Thu, 2018-10-04 at 23:57 +0530, Sibi Sankar wrote:
> > On 09/04/2018 01:06 AM, Bjorn Andersson wrote:
> [...]
> > > Philipp, there's no compile time dependencies between the PDC and
> > > remoteproc patches in this series. Will you take these two through your
> > > tree and I'll take the remaining four through the remoteproc tree?
> > > 
> > > Regards,
> > > Bjorn
> >
> >Hey Phillip,
> > 
> > Will the PDC driver make the cut for reset/next this time for the
> > 4.20rc?
> 
> I have applied patches 1 and 2 to reset/next. I'll send a pull request
> early next week.
> 

Thanks Philipp, I picked patch 3 through 6 in the rproc-next branch.

Regards,
Bjorn
