Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69EFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDED92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5aD5P7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDED92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeINCl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:41:56 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38879 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeINCl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:41:56 -0400
Received: by mail-yw1-f66.google.com with SMTP id n21-v6so1802819ywh.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VVSRIqE3Jd3XlMDTqI7Lrq6FZzTd1pn1zTB84OsaCNY=;
        b=T5aD5P7O9d0y520HUVzMxyb/4oPIHgf5h5q4t3oYyt9v4gs0jxK+NymfuNE0ledpSm
         PeOwGR+gd20YicucznkKGdelcuty6qcIrMr17CpmnR8j3VuMBENu/z9AgEdhn3+eE2A9
         uauHuUPHnCSjVB5waxZ+hhOULtV2j8wjKiR38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVSRIqE3Jd3XlMDTqI7Lrq6FZzTd1pn1zTB84OsaCNY=;
        b=sZb/LdWv5iXkjNzwfaXjboxOl+kn92onkm86A5ftf/MlMJwWfNPLWtzmAfi2LUVWa8
         eX5+0fFNWpb3RkB2OpAy1G7iJ78RoonWCT0NFf+a9JvNFY2mA5FoSVZmTs8waY/0HoGe
         Rbwt14baCPV4itox5tuVjdos3B5FclC925omZoZlH23p3l7o4rMw4xKgKPjbJGjChStD
         oyEFFU0Fram429OLNN4LAOGdiCLNdb1HUtBNdXEOrFuBCApS71E5SDE6bQLAY6Qmcl/A
         5bYX3hILCJdWI8M4pD4kw19qA6Jk1b6huTQMGHSlft1sa9nxvPNHVqR3ozdSzpBXVmb6
         wh7A==
X-Gm-Message-State: APzg51Drkg5MI0uYwUPOARD4Rjijk1QB6n42vSghneAgCEjmbfniFuBv
        ubACeTNTSIbh/rfLJGZt5z5BvQ==
X-Google-Smtp-Source: ANB0Vda00XGJFEqQSkRGbqxnhqHtJe2uAJz0fxJhln0N2zXOQBjl0qr4m+HDj91CXk+eJND7cjLDSA==
X-Received: by 2002:a81:b91:: with SMTP id 139-v6mr4298159ywl.258.1536874238620;
        Thu, 13 Sep 2018 14:30:38 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:d83:1f22:960e:a1ad])
        by smtp.gmail.com with ESMTPSA id i123-v6sm6526579ywe.14.2018.09.13.14.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:30:37 -0700 (PDT)
Date:   Thu, 13 Sep 2018 16:30:36 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 0/2] qcom: remove memcpy()ing from cmd-db driver
Message-ID: <20180913213036.GA15874@hector.attlocal.net>
References: <20180717202947.197922-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717202947.197922-1-swboyd@chromium.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:29:45PM -0700, Stephen Boyd wrote:
> Some changes to the cmd-db code to not do any more copying
> of memory. Instead, we'll just hand out pointers to things
> inside cmd-db. Merging the second patch will cause problems
> for any in-flight users of the cmd-db APIs that are modified
> and/or removed. Probably that patch can wait until later, or 
> I can provide the fixes for any patches in-flight that get
> wrecked when it's applied.

The Adreno folks picked up the cmd-db APIs and ran with them.  I'll
need an additional patch to fix that breakage.  You can see this in
4.19-rc1.

Thanks,

Andy
