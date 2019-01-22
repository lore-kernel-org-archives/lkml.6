Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96488C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FE220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548186442;
	bh=ZRhKcEBtRj63OA2uu2oEGvFoP7SaUJEPrFDmBTW8VuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N4/79miMNx3M+lBNrapCy+mjdRInBJ5jca/M0C4u0+zlcfOhf1HJ6dYO3nPsJ1JYq
	 6AvrQehDSjGYCFFmHGy5a6fnuUDhNFDAYb2SdLBfwQgtgkXRYrQUm40MmsxTTPLRHe
	 elzuvKV0ZE/+T4WExmkzBrqhAKglQJ0UGRos2kio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfAVTrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:47:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46882 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:47:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so11957177ply.13;
        Tue, 22 Jan 2019 11:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWlB2kA1o3qxEvhnSpkZDe8u25k/XTrds3FcwlfjOPM=;
        b=XXFdAtJrVBsFRpVnKMH8OBDChVqMnX5RvGU5kyT2e1yNcAOsO24gWMg2oV956ltfhB
         +difozxPA8sTeups4qnm8LAUXKvWm1WGV/5gsR4p1MtGzs/SFLTxKjC3aLnPi4FEyjpM
         mJWYwtNIMamvQwWSlbZSbxr+66ERpiRHkY2Sb1WXAL/zBlytJQpPuY+oFfh9agLrLkh/
         6qJjAVbA1aUST7X3djIDHMa7zpK6EAHo0DcRKlnddxzC4Cp61vNwcr3purSq1NmyODVi
         epkxlQxqh0MIC82fBOF0ZQJV4i3tC5ADQXNJO3iWfL5abbcMPJ7PT3dS+gm+yShKpv/y
         D8pw==
X-Gm-Message-State: AJcUukdJx6/kgfMHPYw52kkAFhLKyBlRmOIgff1KPxxFKP7mnYgNqmjI
        9Y5dHRmPWje1WBX5+devdbY=
X-Google-Smtp-Source: ALg8bN4KPKgZ8WJLvXF4NmBzB8/SSSqiW2m7YtFqBwvuMXAcYUTIfzp03SJniTuJkKreGkl7r/XWsA==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr34944119plt.98.1548186439612;
        Tue, 22 Jan 2019 11:47:19 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id 125sm19367365pfx.159.2019.01.22.11.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:47:18 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Tue, 22 Jan 2019 11:47:17 -0800
Date:   Tue, 22 Jan 2019 11:47:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib/test_kmod: Potential double free in error handling
Message-ID: <20190122194716.GC11489@garbanzo.do-not-panic.com>
References: <20190121140011.GA14283@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121140011.GA14283@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 05:00:11PM +0300, Dan Carpenter wrote:
> There is a copy and paste bug so we set "config->test_driver" to NULL
> twice instead of setting "config->test_fs".  Smatch complains that it
> leads to a double free:
> 
> lib/test_kmod.c:840 __kmod_config_init() warn: 'config->test_fs' double freed
> 
> Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks!

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis
