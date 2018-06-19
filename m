Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CBA2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA9cxpfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CBA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937182AbeFSBVO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:21:14 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:41518 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937146AbeFSBVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:21:13 -0400
Received: by mail-pl0-f50.google.com with SMTP id w8-v6so8487052ply.8;
        Mon, 18 Jun 2018 18:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yNKNRgiCib/3nprrTEdnU0tm36FsRo82UkzYLLthkSE=;
        b=gA9cxpfSf3uq1XeweGdekY8dZNf7eyIeJCHBi1diZ5FEueSX94ed9WKzcdhApmNoHz
         UB56/9y/goWI43I9jfHJKA9DlT10Ai8qDTAVtcI4GBvjsXKzo2R9z62DTLjCEa5z9Uh1
         SwHjB4xDASA/qwrcDojR7r/QhwHO3O+KrkLvCXtcLvac3FwLv0VUKU4skjKs8XC4LFzZ
         rWdG9rCAfOxBJ9CgXafHv8dge3tNITxBWpHfq8dprQMrHDTdHkWG19EZU+4HFWC4AJo0
         EAY2Cox84k4qEHKbHYHjPgBRuJh+Uyt1CM04yteU72pmVwB2vqfZgN34qhoFABITa/2w
         UFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yNKNRgiCib/3nprrTEdnU0tm36FsRo82UkzYLLthkSE=;
        b=WSF/Kwu2ybed0p310Bj2Rg4Nc47g9H3r4GPT90T1hMbOVEA4ywuppi3o7PfQQqHeWf
         KHlETYIPqXSmTzQaLLSKq9fLbRSrgoX4vzE/csa8NQI0Ahg/dBXAurzg73bITdwsMXe1
         kWf8Qf2CvS+4usPM5ishBynyJAxlWYdAJ+VVIVix0HBkjkU6Atxjn/qjVinCEm74OBtk
         V5XhrnFQ8tISRwx+li+kvHTU2JMOpxOrII7l15QYK2pJ4SfisFm17BItRZeTKVeHLjdU
         BiVZ9eS/tiNQ7VPK2bmJK9F6dCex3oLzyVCDZTqT0Hu4T3q5IqQacS9hUrUUr+wAjP88
         DEPw==
X-Gm-Message-State: APt69E0vTct/iPSMKE/+z5+vTqdFjtW7HjQi6mj02brLqirl8wXCjFO+
        4o4dVKrsaOMB+YUpeOz0+fCr+s9GyXQT3Pe7ZD33cw==
X-Google-Smtp-Source: ADUXVKI8u44yd8SOm5Udg0i9Hk8LX+e4wTkTGOQoDcfI4wegdwMdEZ6akoxiy8DO8kJVwYkjnWFbCHK65B7wfaRMdio=
X-Received: by 2002:a17:902:4301:: with SMTP id i1-v6mr16446623pld.280.1529371272310;
 Mon, 18 Jun 2018 18:21:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:80cc:0:0:0:0 with HTTP; Mon, 18 Jun 2018 18:20:51
 -0700 (PDT)
In-Reply-To: <c447e18b-439d-f125-f74c-9c50a0d55e5b@embeddedor.com>
References: <20180618130737.GA13880@embeddedor.com> <CAH2r5muZJkx0eR0uAyuRBkkTf7-97x5oSMWPXdfb1TUK4rwGJw@mail.gmail.com>
 <CAH2r5mvu7e2ec6fb0Aay5OAr8S31jy=j7_7sL_VRfi6U2G_mZA@mail.gmail.com> <c447e18b-439d-f125-f74c-9c50a0d55e5b@embeddedor.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 18 Jun 2018 20:20:51 -0500
Message-ID: <CAH2r5mvyYP+BjiJMRTRpcONS+tQOseGeBAt6kDK-ZEVdjCAThQ@mail.gmail.com>
Subject: Re: [smb3] unreachable code and memory leaks
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien spotted a problem with the patch - will resend to you

On Mon, Jun 18, 2018 at 12:34 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Hey Steve,
>
> On 06/18/2018 12:18 PM, Steve French wrote:
>>
>> Gustavo,
>> Thx for pointing this out.  Let me know if this patch addresses what
>> you found.  Code is experimental mount option but extremely important
>> to get right due to move away from SMB1/CIFS which had posix
>> extensions.
>>
>
> Yep. It seems correct.
>
> Reviewed-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Thanks!
> --
> Gustavo



-- 
Thanks,

Steve
