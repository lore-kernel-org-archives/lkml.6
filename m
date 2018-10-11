Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED9F2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="beGzCIbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED9F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeJKUKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:10:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43634 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJKUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:10:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id r8-v6so8081250ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tvxHzqKC5Oj33wVMuvYGaYovF6R8jWaY6QYfdB7DNEw=;
        b=beGzCIbuFZLRGhqtcvuDBPGPuOwos0Fje9BHD24q3/nF/ZehHGoD6TeSCEdj7m8XYF
         NQ4iegQ9Z+LbVXN5FLx0ZYUCm6Fd5mP4cUsRzePKMiuCps1HA7gEVUB+iHdmXhlmg49i
         1O7T8ttzj8qJHiKPqE+Jr8GqvjRH5aOo0jKG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tvxHzqKC5Oj33wVMuvYGaYovF6R8jWaY6QYfdB7DNEw=;
        b=Hq2PgmQDKDZ3I+1yEY3kpoTouJgEH+wwvOPgfXqZaGoXp1hy5XSxXzJgo1cKbdOXBc
         3ojCj0OWCJKIG2yUN2+jQvY9hyyNmW5/KXSOb6HRZJTdnorJPtaWyfE+Rp0ouMr7ud+X
         rl4Gc/riykV5p2pyzRl7d7uCJEeEcC1rWKHGQRJ63a0DT+09/oxS8VknClJf9tZ4SvGw
         /TMgGFgq4+FIJ0IW/RQyc+z0qF7dC0ZqXWlgZWJwxaLTNPE2kwwUFWKqUJaEjQfQfeVS
         +skSOMEboKOIi4SfZPh+hXtvyDWZzSvFQjeUdeHHdEaPrfQMipCM64rxqcnLioRO3rvR
         ftsA==
X-Gm-Message-State: ABuFfogHLhYEE9k6vY42co5aVxkRHtGDOLwc5DZYMLNLlb3UBskgcj/O
        P2TNsc/6uqyGMFtXv7/vOU1TzQ==
X-Google-Smtp-Source: ACcGV61mrhAGkVsxYbMumP4CYIU5qBVKrPkYdk1un88De2sXzFxkbb9g+sUjZe8a1xJrEvirwLSKvg==
X-Received: by 2002:a2e:4b11:: with SMTP id y17-v6mr1131721lja.42.1539261815959;
        Thu, 11 Oct 2018 05:43:35 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id a18-v6sm6044145ljk.80.2018.10.11.05.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 05:43:35 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:43:33 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20181011124333.GA10790@centauri.lan>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181004210407.GB7926@centauri.lan>
 <40719973-21a0-120d-7193-8e6287cbbd18@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40719973-21a0-120d-7193-8e6287cbbd18@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 04:45:25PM +0530, Taniya Das wrote:

> > WARNING: Duplicate signature
> > #370:
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> >
> > If you are more than one author, you can use the Co-Developed-by tag.
> >
>
> Hmm, I do see multiple SOBs being used and merged.
>

From Documentation/process/submitting-patches.rst:

"""
A Co-Developed-by: states that the patch was also created by another developer
along with the original author.  This is useful at times when multiple people
work on a single patch.  Note, this person also needs to have a Signed-off-by:
line in the patch as well.
"""

So it is not wrong to have two Signed-off-bys, just that
having the Co-Developed-by tag clearly shows that there
was more than one author.

Without the Co-Developed-by tag, the second Signed-off-by tag
is ambiguous, since the seconds Signed-off-by tag might just
have meant that that person was in the delivery chain of the
patch.

I think that the Co-Developed-by tag is optional, so if the
co-developer doesn't care about taking credit, it can probably
be skipped.


Kind regards,
Niklas
