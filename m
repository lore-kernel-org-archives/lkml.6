Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DADC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABF220882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9LG5aK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABF220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeILVjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:39:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33373 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILViU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:38:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id b30-v6so1247608pla.0;
        Wed, 12 Sep 2018 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k/sXLsM7J090yYoftR7Se1bwfe1Z3YDRhJ6ZF5/wMkQ=;
        b=Q9LG5aK+P7c02EZIME553q7+99rrBipy8/qyTp9SbcjE3KPo6bjRSlOD86HgCFsD4F
         LLn52hQid+/DKzSUA0YpD6xhqjdyWeNmpzJZ57tLRQiRp83BCujQUXgb/Eza7Qvbu6pX
         B/xW4jZUEvWxxx4Ego0PAaCEKIzwaZIuZAfCMP8WzIL6h23hw6bMojuXBdLG83WXPIFg
         095VUsXwiZj0lBfzCOw3cdiq4NGBTsPSc7kmKx2ICFRyOHNsyfQyfNGEAilf0J/pz3X9
         bmroCUc6mBB5m/Gawa8sFFa1zDkLIje+vwE5YAN0uq2CJVf+7bNk3LeYY++tu5zwcjfI
         r43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k/sXLsM7J090yYoftR7Se1bwfe1Z3YDRhJ6ZF5/wMkQ=;
        b=Zig9WerqeUsX5dikAJ4dCrMQrzfqcPi2kg2FURl6IVFjjM97FIiDgc8LVgDRkZ1jou
         2K0oJjBFBzDagMcDKeUYXezk7r13yIMPkEB3uRhgR56Pj+S/ceRGsCLTRC7GvLc9H/Rw
         HcMnOPHGBjLA2Lemwr4WNIWUUQBpMRi5A2d3l3B6VAFaVmo7skTDMD+FXxs+XtSeCFFA
         oEeWpQTAjFDIQeDJLs5lLrzKAgCuR/xNO9cYTYU8wXY1z/CdaswThKXCaf5HYhg/pwjp
         jaivVXOqe/BJXFciJu6tpeEWmLmyRlpVGKZdeYsRyo8wh1vFUcSy6SNsFdg6QkgycsGi
         7BCQ==
X-Gm-Message-State: APzg51D1z8cxaIexevbWCC3vEiqUPBfCHBH2xvj03ZUfvTwgrvsdSvfb
        F520P7OhnTDavytutZ97Nw8=
X-Google-Smtp-Source: ANB0Vdaejx6l76EBsj2B6Q2ZDY8mKCV7s6a9jvo0zQeDcQ3qY07PlcnNoFCy4R9Z7umM6+A9EBuECw==
X-Received: by 2002:a17:902:864b:: with SMTP id y11-v6mr3205117plt.335.1536769981393;
        Wed, 12 Sep 2018 09:33:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q26-v6sm3736928pfj.127.2018.09.12.09.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:33:00 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:32:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: get the vbus source and charge values
 from  the devicetree
Message-ID: <20180912163259.GC3300@roeck-us.net>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180911145931.32441-1-angus@akkea.ca>
 <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
 <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:08:58AM -0600, Angus Ainslie wrote:
> On 2018-09-11 09:33, Guenter Roeck wrote:
> >I cant put my finger on it but this seems wrong. As i said both src
> >and sink should never be true at the same time. I also din’t
> >understand why turning off src should power off your board. Ultimately
> >my concern is that we may be just painting over the real problem, and
> >that would be really bad to do with dt properties.
> >
> 
> I agree that this doesn't seem like the correct way of solving the problem.
> On this HW (Emcraft iMX8M BSB) I think the PTN5110 chip has been connected
> correctly so I'm assuming that it is some quirk of the PTN5110.
> 
> I didn't design the HW or the chip. This is a workaround for "quirky"
> hardware and there may be others that don't behave exactly as expected.
> 

I wouldn't be that sure about that. It may as well be that the tcpc driver
and/or the tcpm driver are doing something wrong when initializing.

I didn't really understand the logs you sent out earlier. It looked like
the system would loose power if the TCPC_CMD_DISABLE_SRC_VBUS command is
sent.  That doesn't really make sense to me since it indicates that the
chip sources power to the remote, and turning that off should not result
in a local loss of power.

Note that the chip is supposed to be able to report if it is sourcing vbus
and if VBUS is present, in the POWER_STATUS register. Another question is
the content of the ROLE_CONTROL register when the system boots, and the
DEVICE_CAPABILITIES settings.

Overall I suspect that we don't handle startup for your system correctly
in the tcpc driver. The ideal solution would be to find a solution which
does not require any devicetree properties, but to do that we'll need
to get a better understanding about your system's requirements.

Guenter
