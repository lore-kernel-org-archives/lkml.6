Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F03C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B23204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTZWYUav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B23204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeKUDGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:06:08 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43671 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbeKUDGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:06:08 -0500
Received: by mail-yw1-f66.google.com with SMTP id l200so1001017ywe.10;
        Tue, 20 Nov 2018 08:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZPk6X88jmWbA0LBKkgEOfdIJ3iJDdOYKXmDcQOGAJI=;
        b=fTZWYUav0thwvA/I1cJhIfK77MrJ8holI9GwMCzm1NeZaHr9plsTGePvLzgR/UU885
         3Ghmb9qSnPxbGaikmZCdcHIAiqvGkhI4zXAulpAs5Eo55rCJE95w2ejF+bByG+jSVV20
         I2zQdOuRex6IjnwzW2T7szSKia9ESRX49H/xonpWJQ2Q70XVEMTwSGw/PJqO+fBv5iVI
         ctIQTKXD4+eQWSC2N/SKgxZhR4QSkBxYbRB7LYjuQVQZyKW95pcsFU/oVX7j/beZmRs9
         CI0PRcZ8lbycstUbxs+Imef6GoNVcuCHfxx4RU5OfMu01WHo6vet0BIp92mRdaVdrr61
         QStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZPk6X88jmWbA0LBKkgEOfdIJ3iJDdOYKXmDcQOGAJI=;
        b=RiMbmoqg06CipkOaAxKvJoY7ZrdbnmDf3gAcnl/pSVWPHgepoyyKp1n8w/hIn8UoxU
         Kl64CeGo10eu5BJ6za93Uyez18ZGgImx7ml6G0u99kqZyMr5v29AnVaYkjLxW99hZJ07
         NZg2r/hfydp6EiL/CwfrM8D290UJyAOFgsgu5Cse1tI4/ORvYwDRqI8DWmtz3gmTGH6G
         p6NcFvlm1/h4dUKwphPUP7q18Xat77qRomxZRM/0cv+KwzrTU92blinG0ZlGpGr0t9om
         nRH623RSZerhJl9v01ny97ufwE1JN17LLMYFQh25nNVeOYxvIJszTO/SAZrBvPUD4QOx
         G3Xw==
X-Gm-Message-State: AGRZ1gLtAr35CzKxM27eKi2c34ZrbX6F++FdNZ/VeAYs8eSg9cRv7kt4
        Mbfimy7NL7iR7tkC1kzA9Go=
X-Google-Smtp-Source: AJdET5c0O6V6ferbRwwSRbuIwSLVpbCZT4CAuln3ClwlXLnLysvoUOhMFFMtPFPdX5AZitgyvf/u4A==
X-Received: by 2002:a0d:d382:: with SMTP id v124-v6mr2647027ywd.406.1542731766771;
        Tue, 20 Nov 2018 08:36:06 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id c140sm22173231ywa.74.2018.11.20.08.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:36:05 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:36:04 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Message-ID: <20181120163604.GX2509588@devbig004.ftw2.facebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-5-guro@fb.com>
 <20181120162529.GU2509588@devbig004.ftw2.facebook.com>
 <20181120163304.GA21462@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120163304.GA21462@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 04:33:11PM +0000, Roman Gushchin wrote:
> > If a non-frozen task is being moved into a frozen cgroup, shouldn't
> > that also trigger frozen state update?
> 
> It does! Just below these lines:
> 
> 	/*
> 	 * If the task isn't in the desired state, force it to it.
> 	 */
> 	if (task->frozen != test_bit(CGRP_FREEZE, &dst->flags))
> 		cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));

But that wouldn't udpate the cgroup's frozen state and generate
notifications, right?

Thanks.

-- 
tejun
