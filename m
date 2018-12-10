Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B1BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D722082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui+aGj4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D722082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeLJTFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:05:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38213 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbeLJTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:05:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so11496224otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7SUu/lyKL9Wf2JrMSYtA/5vF7FuD3ePKhKiwfJjQjvA=;
        b=Ui+aGj4QXyH6Y0L1ERqvoQHQJaYvaiKHG3zk97ot328FaobPFB2oYFGh+p2lUe0tPl
         +EK6/bNlyRN+NtjJlCMGbTPnDKnufSz6zR/C5XoeU9YjXJAtsK5vfy0p83KQ5/sJb7i8
         PdJ1Nkbw3nzRR9amdGWO/B87UsMQaDbKngEzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7SUu/lyKL9Wf2JrMSYtA/5vF7FuD3ePKhKiwfJjQjvA=;
        b=twG4c28MXRZGI7LFwja8SqFajsuWdQdBbwF+oQmJp2DSknMENr3ON6OGV3TXR4rKwZ
         d6T6wJbTMpoeen0bfWDHIdo8gBK2KDd1uV2pFf+QBP46CBUsNc4j12ujZXGIUhNPIgWA
         88xEndHOTg67PM9xjU3awtbHlo1VlGCRdbyvbdgKlMbr4WoAY4FMaFDsyZ0q3yuQODPL
         2Xf2X5VztNGwtm3O28+LGXC8kY9NyPpdRw4vxG56+rw1HUGnHhdS0CKg6N2q7TMYY/hw
         YzqoWV8R1/3Us6d/F3hLzU/17ESED0c7xZVwK6BZOqOAAeyAbZBGqb897hfrEwP1wpF2
         kxYQ==
X-Gm-Message-State: AA+aEWbGi2QtkI6cm/h5INFn2eUsQ8Wdq51si9krSPqBvV9ieO/wh2NE
        EQTnrfqKLTz1AQucgExyL9Bvzw==
X-Google-Smtp-Source: AFSGD/XoOrY/Zz8ADlqf2KGwZeCBF58UmsKD+4rdcnD6w3aWnO84/h5qGAd0288ER5MAdLdxUXRGyg==
X-Received: by 2002:a9d:886:: with SMTP id 6mr10012948otf.256.1544468715086;
        Mon, 10 Dec 2018 11:05:15 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:79bb:a266:cd71:3186])
        by smtp.gmail.com with ESMTPSA id m25sm5458255otq.32.2018.12.10.11.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 11:05:14 -0800 (PST)
Date:   Mon, 10 Dec 2018 13:05:13 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     arm@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
Message-ID: <20181210190513.GA25288@hector.attlocal.net>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
 <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 02:20:47PM +0200, Stanimir Varbanov wrote:
> Hi Andy,
> 
> On 12/8/18 7:13 AM, Andy Gross wrote:
> > The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
> > 
> >   drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2
> > 
> > for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:
> > 
> >   MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)
> > 
> > ----------------------------------------------------------------
> > Qualcomm ARM Based Driver Updates for v4.21 Part 2
> > 
> > * Fix MAINTAINERS email address for Todor
> > * Fix SCM compilation error
> > 
> > ----------------------------------------------------------------
> > Jonathan Marek (1):
> >       firmware: qcom: scm: fix compilation error when disabled
> > 
> > Todor Tomov (1):
> >       MAINTAINERS: Change Todor Tomov's email address
> 
> I saw this patch is applied also in media_tree.git, not sure that is
> problem though.

Which one?  The maintainer or the scm?

Andy
