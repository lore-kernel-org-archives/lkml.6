Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA33C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC92120989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551083687;
	bh=tF4cS0ccobmRG8YoHydriorPYEIkgkwVo/2fCofkpK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Oku6TYIuiNIiJqZkDIZA6Repl5mvj5HCChqWXfEAv66G+A6VndBCyy38IsdH/0tX
	 BK96cptyBbLoTN43AaPfmYWJNIYSQI1n6bfgfsPkX2UE8NNcfkr2FNmwPPY9b2OWgJ
	 bxNLbNKH+Is05S0S5q8If6HT3wp/fJPLqTJ1/yKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfBYIeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:34:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34584 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBYIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:34:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id u21so6226700lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 00:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R8/jrsgZy37rcm9d0JexY38x/Q69aQEf6gbO5bG0DkY=;
        b=bDXS5I90RDEfHESvHrHCURG/2BWSSX2cZFD1o4UclNzUCPfsG+BR/T0U0filMl7DGn
         7JkwuMdpQerSbkuuTlxt919UcylSGZ2eFG4v4f8wkxMR4ps2Iy5CN6yp3HQATT0Z9GeM
         vav+u0rTyWijFa2POwTV2sBFsiNBonoR86s3O7Qo6MVumCk8zYYABWWIyUOwy7lAk1po
         5mz5em0VOPZeBOi837ibuiWIiwvish3Yw9hfjFqlcQJM5a+8sKVP7KzNaL9uSDoxJ3rn
         1lw4A4D9F6IE8uEtNA0+FeQlXYpr0JuqtC+4ZmWRgzfh8eRzovYf5MRfBvhwPl1SOAfA
         QrmQ==
X-Gm-Message-State: AHQUAuanckeMP04oqsY+U9gKEIVMNYB9yr/Dhj1XHlZ7wlQcFovePhx/
        uym7QyViwzx7NwFXYdH9IC4=
X-Google-Smtp-Source: AHgI3IbpVAcNvJ/RI/ODmtkNTc4XSW4F/rMbpCk7xXnQjot2+iILsr3VwMBpiZYPBoE97/QaUQZBIw==
X-Received: by 2002:a19:7613:: with SMTP id c19mr9383947lff.103.1551083683383;
        Mon, 25 Feb 2019 00:34:43 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id j12sm2765584lfb.90.2019.02.25.00.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 00:34:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gyBih-0000Hq-TZ; Mon, 25 Feb 2019 09:34:39 +0100
Date:   Mon, 25 Feb 2019 09:34:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v6 PATCH 6/6] RISC-V: Assign hwcap as per comman capabilities.
Message-ID: <20190225083439.GA4747@localhost>
References: <1550864500-13652-1-git-send-email-atish.patra@wdc.com>
 <1550864500-13652-7-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550864500-13652-7-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:41:40AM -0800, Atish Patra wrote:
> Currently, we set hwcap based on first valid hart from DT. This may not
> be correct always as that hart might not be current booting cpu or may
> have a different capability.
> 
> Set hwcap as the capabilities supported by all possible harts with "okay"
> status.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Reviewed-by: Johan Hovold <johan@kernel.org>
