Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A9BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB292147D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB292147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLAOAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:00:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34555 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeLAOAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:00:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so3305407pgg.1;
        Fri, 30 Nov 2018 18:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IpVFGFn4oPb1GJ9be2qP8GxiNjPayVYkeduSEQFq36E=;
        b=WTh2/kyfIVKenYMF8dNuHHqCZFDEUeU83GWHMmiK0sMo0bBgotQT4x6l/H/7FsCGju
         9/7GCDsA9ErKzhUKgr7A1U6t+J1zrXOW/E38FpC4fu1Bc1OTq901OVjOjKSh/ZR2JcNV
         w5U7nw1mMp4J7Gu8hKsxuTwAv/ZLKVYkFpcO2O2DycwH8rRoU5pW1jFEKknhcoKXnf0X
         wFjZ5uSmoG31TIAUwDzHAdYlhQ7Xi91/dw1OGUGCyCPujEYwY8wEGpggzFJOq6zyL5xS
         AbOy2KewcCIdV8r4Z42ZheTBc8DF9nTbF3TA/8SxQPX9yB9ZcQFVspMAGhv67ywQPWlO
         HAig==
X-Gm-Message-State: AA+aEWaMYQAMSUhSeCW+NhjYDBSD/VX3mmzL9UURJ23ErGsQHur5eM8A
        Z6EwpHoltrmLWB+xqoi0myM=
X-Google-Smtp-Source: AFSGD/VJ0kNvL+KkKySO+RcQ+JewuQi3yMnCGDrg/PIwbQ3Bv/otJtSXotGo8SSMkNhLrgIf9r6P5g==
X-Received: by 2002:a62:18ce:: with SMTP id 197mr8242638pfy.88.1543632531889;
        Fri, 30 Nov 2018 18:48:51 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id 125sm8816950pfg.39.2018.11.30.18.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:48:50 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 18:48:47 -0800
Date:   Fri, 30 Nov 2018 18:48:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        brendanhiggins@google.com
Subject: Re: [driver-core PATCH v7 4/9] driver core: Probe devices
 asynchronously instead of the driver
Message-ID: <20181201024847.GH28501@garbanzo.do-not-panic.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345154692.18040.8161459765233879389.stgit@ahduyck-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154345154692.18040.8161459765233879389.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:32:26PM -0800, Alexander Duyck wrote:
> Probe devices asynchronously instead of the driver.

> +static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
> +{
> +	struct device *dev = _dev;
> +	struct device_driver *drv;
> +
> +	__device_driver_lock(dev, dev->parent);
> +
> +	/*
> +	 * If someone attempted to bind a driver either successfully or
> +	 * unsuccessfully before we got here we should just skip the driver
> +	 * probe call.
> +	 */
> +	drv = dev_get_drv_async(dev);
> +	if (drv && !dev->driver)
> +		driver_probe_device(drv, dev);

I believe this should mean drivers which have async work on probe can
deadlock. For instance, if a driver does call async_schedule() or a
derivative call does this for it, the kernel will call
async_synchronize_full() and I believe we deadlock.

Are we sure most subsystems which would use async probe will not have
an async_schedule() call?

  Luis
