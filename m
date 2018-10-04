Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9187DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D28F2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q1XvDlcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D28F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJEA14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:27:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37015 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJEA14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:27:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so3732744pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3y+ixJPU5deJfQaCAYwk+NrLgOzdpPsB/rbHU8Fd3sI=;
        b=Q1XvDlcOBp9xfcOP1k8lQuOMQ03Tpt7KDVEUhiWQQlnOOhKaidPdVEru5BZQU48gxi
         sTMXHYTNMt23iuBN7NJvRZa911IdJLf32qxcbxbuJr1TAq6m361sX6mMsGBVjyyYQU74
         KpSY60hRw7pMkbLF1POCgjm1oSeVlV001CakY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3y+ixJPU5deJfQaCAYwk+NrLgOzdpPsB/rbHU8Fd3sI=;
        b=kBGoTSeXY/Jna3vsuZ9uypo3umFVBN8GT2XxWxzJoICcGUsBnV6iGpGbPrGcoXYhwk
         FHU6I5rq2fA6qaCqoYwvSuxQuTtBhsLQ+p8+BUVznwk/QJX46VqbXVpC0pYwegpSGZ4v
         wWZ24UsyO1v8nheLGVRavkGGl+t+KcSdjybeHhp9ZdQDzsVWIXnCZVvWVBRT2JK2gyap
         al8UNVCCv8UFxnWGrdIN3GP/buQZ/3bzlrNIXzt6iKinn9tbErF+mNYpeXcpOZ0tYlBP
         zvtW0d8YS+L3w+03TCE+vJwdFOCLmv0U/3XQ82c1MwUan1WPCXf7lfESI2LK38qVYg5J
         /39w==
X-Gm-Message-State: ABuFfoi5X7k5v+FnThDmmO62VS1ZrfvCywOwMzBOJjbXRmK3tfTuNc1v
        pPQHljBcPozDRdoZq/w+dbZ5lw==
X-Google-Smtp-Source: ACcGV62sgEJCIkv3LkMYesABq57gX0P6o8tB/++x+A6iEtTiKXxOxvOhvDl8e1az+QM5iUthQwE3sA==
X-Received: by 2002:a63:4563:: with SMTP id u35-v6mr6731187pgk.30.1538674419857;
        Thu, 04 Oct 2018 10:33:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id x73-v6sm8302160pfk.139.2018.10.04.10.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 10:33:39 -0700 (PDT)
Date:   Thu, 4 Oct 2018 10:33:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Message-ID: <20181004173338.GL22824@google.com>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
 <20180927171305.GG22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927171305.GG22824@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:13:05AM -0700, Matthias Kaehlcke wrote:
> On Thu, Sep 27, 2018 at 12:47:06PM -0400, Sinan Kaya wrote:
> > On 9/27/2018 12:41 PM, Balakrishna Godavarthi wrote:
> > >   void bt_sock_reclassify_lock(struct sock *sk, int proto);
> > > 
> > > +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> > 
> > Maybe change the API name to start with bt_ and get rid of device_?
> 
> device_ indicates that we get the BD_ADDR for a 'struct device' and
> not for e.g. a 'struct fwnode_handle'.
> 
> Anyway with this version of the patch fwnode_get_bd_address() has been
> scrapped and it might never be introduced again, so I'm open to change
> the name to bt_ if there is a general preference for it.

Marcel, can you live with this being added to the Bluetooth code base
instead of property? Also if you'd prefer the function to be named
bt_get_bd_address() let me know.

Cheers

Matthias
