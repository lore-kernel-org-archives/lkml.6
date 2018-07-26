Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B378420671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="GnncMk58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B378420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbeGZUru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:47:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42151 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbeGZUrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:47:49 -0400
Received: by mail-io0-f195.google.com with SMTP id g11-v6so2288278ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfGwUp+57BGWzw9VTelhYfHJ8+iLKeYGViDqXz9dTsE=;
        b=GnncMk58Qr2idIRiSlvgVqODSxaqrLMKmHjoAG50ABEL4qzGrBExeSs4JsPJ0BN6bj
         2aJWiTG1ICTI0vZ7EkGHt8QQyArtv8k3q/Sn0mkTCOa810QhGmJNBbPs6++CyLmUpziv
         ys14JKKyYsf+1fDiT+rG2cqdyb+K2FwIKKLcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfGwUp+57BGWzw9VTelhYfHJ8+iLKeYGViDqXz9dTsE=;
        b=sHsb2XsRUN7WqSugiVbSFLvG+SQ6dGoFXf0Y/A5SFsBopLJNXJNMNCxKdZqrygk/Yn
         Ad6fHg/RQgrFaqjRIfuoM6Bm9x+RW7I89iqxxrrATTxeS68WgGIGX6sh5kzEhmEj6xP/
         BwFL4dX6lp8rwyMx8NGRYN5fVc+Dqf7f4Th+sUNUAYG0Ojc92fFDeTI0UijZHfkDpqeG
         McJcrweAXIaTZ+FF+szBv81HTQYm03JGsgEY1zaqOnsJHuTm6JK89MlTHBkyEEpvwuzN
         ZGksL8iDKADE5tXM4uT8nmTFhymG5nchbWq6tpqN40IW4hLoZ4OH07fmH9PnDpl+y84Q
         eO8A==
X-Gm-Message-State: AOUpUlHpEa5ldLODdivzXfL5ZNrP7llGhxeefA8xBS8t7fa6osAf5/ks
        YXoFolVkZ0I+yN/1BmSDBC5WSQ==
X-Google-Smtp-Source: AAOMgpfMeWzXqng5Cf2JUESIkrh740R2n8Aa8gNeOo718vBqXA9w7eZFxs9xApMEl+bZKgsJ3fVzXQ==
X-Received: by 2002:a6b:3756:: with SMTP id e83-v6mr2527683ioa.229.1532633372971;
        Thu, 26 Jul 2018 12:29:32 -0700 (PDT)
Received: from rocky ([2607:fea8:bd9f:ebda:7467:360e:236d:23a5])
        by smtp.gmail.com with ESMTPSA id y18-v6sm1397601ita.29.2018.07.26.12.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 12:29:32 -0700 (PDT)
Message-ID: <0cd53c74f33c7218e158539b83e0ef59ef429923.camel@kepstin.ca>
Subject: Re: [PATCH 2/2] turbostat: Add support for AMD Fam 17h (Zen) RAPL
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Date:   Thu, 26 Jul 2018 15:29:30 -0400
In-Reply-To: <CAJvTdKnnaGrj3PSMd00B2GVAYk-KQ07aV72mbzPSTZRbXSsdng@mail.gmail.com>
References: <20180718222656.11795-1-calvin.walton@kepstin.ca>
         <20180718222656.11795-3-calvin.walton@kepstin.ca>
         <CAJvTdKnnaGrj3PSMd00B2GVAYk-KQ07aV72mbzPSTZRbXSsdng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 15:10 -0400, Len Brown wrote:
> Hi Calvin,
> I'll assume you are waiting for this to be tested by somebody who has
> the HW (sorry, I don't have AMD HW to test this)
> and will re-send a checkpatch.pl clean version when you have that
> result.
> 
> thanks,
> -Len

I need to rebase this on top of the 4.18-rc code at a minimum, I
suspect there will be some conflicts due to the changes for system
"Nodes". (This patch was based off 4.17)

I'll resubmit the CPUID fix shortly, and continue working on the RAPL
patch.

Thanks,
Calvin.

