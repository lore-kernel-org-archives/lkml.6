Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31241ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E043221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlk3XJsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E043221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIXOuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:50:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44021 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeIXOuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:50:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so15893795lfe.10;
        Mon, 24 Sep 2018 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Nl81KiGyPBQHPKa0FSMbf1X7vxjngsQN6k4rFGgDmk=;
        b=dlk3XJsVwZexXh1rRCOjt+1y+oZNS/jbB5ZmGfROxSwsZRqbzVjtREHX5YbU8eiltg
         G81YGbutbQhNHAz5BMxURHdHubd79peAwa3raLwLDXvzv2FeNeSxHVBPv09zuYSSFpjV
         am6/IY+r0sS9vtmvzo8NhmeM4qliOPy/2ep6AUSOVsJcYnpUtK7Ibk6sRxVrdNRxlDD5
         G56BYgQRzIFx1l6lokEu3Poz4h7qEi98hfMhQ5aok+FKb+V86r3UQa9ShrYtHZ8K8loG
         2f8GMsBf/KDADDpu2TRQ+19V2SA1kkjPoqepBurYIQBSHZVU9cri2XsPAgKUvdDBKGxg
         f7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Nl81KiGyPBQHPKa0FSMbf1X7vxjngsQN6k4rFGgDmk=;
        b=JLjnmJ0r6Z3WaEZWwNxCBS8xvYE9Zn2BmvTIG0DHWe/4CcYvohjQUlKNS6kh6fPm3p
         l46i+7mN+6o+YysRL6RJdTfz9eb6UzaZ0SFGjeK6IgtNFDN8NPpQMzM4XpjgETJfl9p+
         MeYB+8c1fop09U9E5TO99WHPUj95598eMdxZGIpvmYlAqdpv1KVwIZEkZPfl/khTN2Kv
         4KgVRfxflGJ9dFWXXiv8C48VDP8v6oLREtqqTzDweXEXqhLfMGyEL6zXJ32KFZnbc/kt
         gNChugAJpjVEakXpLmub2lPabWEwdCJ/kibhgwiCtqeXmhc93FpxsuijxFiEPy/VWASh
         U24g==
X-Gm-Message-State: APzg51D4B0frEpE6+qySw6vnKgy+DEPJnYk2E4q8B8eNgsgHHb3oYIEO
        pzSKjtCFmrPt1u3Jx4Stn1QXfAXi
X-Google-Smtp-Source: ANB0VdavnnjDcdtc+E3hIbVbKZ/kNQTLD4/09Ool6WAY/voXzXvFewFBrbQI6ONwY2gOC7f5uKMSwA==
X-Received: by 2002:a19:ab1a:: with SMTP id u26-v6mr1172208lfe.103.1537778978509;
        Mon, 24 Sep 2018 01:49:38 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 41-v6sm1779659lfq.95.2018.09.24.01.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 01:49:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4MYi-0005h1-Kp; Mon, 24 Sep 2018 10:49:36 +0200
Date:   Mon, 24 Sep 2018 10:49:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cypress_m8: fix spelling mistake
 "retreiving" -> "retrieving"
Message-ID: <20180924084936.GE5101@localhost>
References: <20180923230408.8721-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923230408.8721-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:04:08AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_dbg message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.

Johan
