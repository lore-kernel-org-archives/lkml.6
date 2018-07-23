Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D61ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938BD20671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNp1WqHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938BD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbeGWUWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:22:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39888 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeGWUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:22:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so1905116edi.6;
        Mon, 23 Jul 2018 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7daXY6qJLHLywgL3tysz7px+hLf4TBHs+jGQIdCfXTc=;
        b=GNp1WqHNfVABJP1+NzksygWXTSDJ8OCX5tsTvfO51NwwsfuIg25JH/9ln0msjY0d5r
         4yV4C2phRbKDUMLCXw78jBZzK0uAdgeopud2WHBujM6QWtodnkv6ajCcJ98NpqS5+CCT
         eE+8CNX6iP3k6tNQ6IGGPxeLKw1KqXIsmSZaax31CJ4VFDe7MUuEr+ukGFg5Ok4wD0dO
         pG4u/5RRJFj+V+lCnHs4QUHV0gUNpxiVpVCT5TYgY6u6slrmcEXsb+jStUhxyeiqvByj
         D822wFCCim7bdP7NzE3YmqIpL8n7pNaBnx0lK11yC+VOoIPDhIggR4vtRPk+GpImO/FB
         e3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7daXY6qJLHLywgL3tysz7px+hLf4TBHs+jGQIdCfXTc=;
        b=SEvv1BsguDzni8SsKBd/JFCnmorTyLUBx2Rmk11tDS81tcGR7V3Th2/lfDeW9QDSLc
         SZoyhs8cCSCnfdOrd3kJhBmYANyJXY/IQW4kYrWwuzBkcRRN/C6DdXA/Xny+FkbdNVyF
         LG+MZTjSNGrNlQXSuu9MUdOJ0xJ8JjerEAx71COX3Bhd0ivvSS3+vgPXS4eU86kSgU02
         icB8z1WsqgBIY3FXFyXYhXHS/DIPALS0q6WVD84GeUe+b2L1pd8hJ89sGb00Dr1z/gOW
         A+I3sms+S7UeO4yuB3FWCySXfKvILxfE+ibiSsPykDlB2EH5hb4iHZq6jJnqLR0gzFQ9
         ATuQ==
X-Gm-Message-State: AOUpUlGXgJlSh5/md56p/ezGw/md0EZKWDDXMNMlIID+8Mil3S3uuA/T
        kmc7mOMvOGwLr8J8rWhEe0c=
X-Google-Smtp-Source: AAOMgpdk3bDO4D/75OQyQCpnlyllKUQDWKCf9rYP50n5fI0iQvAWkfxkmIGRae+gUwTk+wS8+/IuJw==
X-Received: by 2002:a50:8d19:: with SMTP id s25-v6mr14756628eds.238.1532373609957;
        Mon, 23 Jul 2018 12:20:09 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g6-v6sm5267368edn.28.2018.07.23.12.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 12:20:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
Date:   Mon, 23 Jul 2018 22:20:07 +0300
Message-ID: <3459086.gtf8SULmVS@dimapc>
In-Reply-To: <95929e34-eeb4-f3a4-daa1-0b89dd60f570@gmail.com>
References: <e411faa3-7d42-710f-a18a-a4fdd764b60a@gmail.com> <20180723181318.GG13981@sirena.org.uk> <95929e34-eeb4-f3a4-daa1-0b89dd60f570@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 July 2018 21:37:50 MSK Peter Geis wrote:
> On 07/23/2018 02:13 PM, Mark Brown wrote:
> > On Mon, Jul 23, 2018 at 01:58:26PM -0400, Peter Geis wrote:
> >> SW2 and SW4 use a shared table to provide voltage to the cpu core and
> >> devices on Tegra hardware.
> >> Added this table to the cpcap regulator driver as the first step to
> >> supporting this device on Tegra.
> > 
> > This also doesn't apply against current code (though it does now parse
> > OK), please check and resend - make sure you don't have other out of
> > tree changes and are using an up to date kernel (ideally my regulator
> > for-next branch) as a base.
> 
> Good Afternoon,
> 
> I thought it was my error in the patches being stripped, unfortunately
> it seems to be a known Gmail behavior.
> Any ideas on how to get around it?

Use the "git send-email" instead of email client.

You need to create and send out patches using git, that will be something like 
this:

1) "git format-patch -v1 -2 ..." to make patches
2) "git send-email --smtp-server=smtp.gmail.com --smtp-
user=pgwipeout@gmail.com --smtp-encryption=tls --smtp-server-port=587 --
suppress-cc=all --confirm=always --to 'Mark Brown <broonie@kernel.org>' --cc 
'linux-tegra@vger.kernel.org' --cc 'linux-kernel@vger.kernel.org' ... 
00*.patch" to send out the patches



