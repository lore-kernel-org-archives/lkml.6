Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D5CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9919520C07
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5vff4QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9919520C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeHTEoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 00:44:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeHTEoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 00:44:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so3189879pgv.8;
        Sun, 19 Aug 2018 18:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJTS9pFKE0G37vfh8FSM1Vqw45dSJyCo99xfEe0AXJA=;
        b=M5vff4QMjMsyNQ2pyt49cmMkc6saSy8Y5H09LDDEaYS4lmFoD+Uf3NVgLJjNv2Zl+W
         BPpUcOqmzGvBUrPjOJm6X0E2ftvCb3tubB5eKc8+NMLFaIcb2YWdGpfcPdTw4l+4Bd/K
         2nxi5Y8ddT/CBtQ2VukKu8ElQBYGDUeSXFuNUCMishBBxOxKH1K4NuZMz5aAtVCfz4HY
         i5Evrhku6H+8OHap3zzIbofS47rjIZSSmVtIeIwjRXXqTQPtTvsqD+uk4fC7+i+5u0I/
         IPx3yI8iClDHO56d5bP1krmPBkRP0PsTFWXe8sQDpZmt6n21Add7HB4zHu/hKDwfvukX
         Ufgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJTS9pFKE0G37vfh8FSM1Vqw45dSJyCo99xfEe0AXJA=;
        b=FNyxrjTifFwRhP7xrbSjfUC2CPFg/pwVCfN+3uFRZ+SppW8FG6Xsdb5KcLtjBYX/ki
         jEWDkafPkvF13Et7CuxibBpUo3SP79A++EK4bX3jcRnU0CTgFGFIEf3fLTikWf1z9/0a
         HNZ6z1YJL0Ityq3sGEPtdcqSFnk9oZkimilSIHfanyPgwt53/agtoCAehTZS2vOSQMjU
         RdjFdYJgwsMdUiww1V2kPBa0xsVVekOyI97zaeC5n4Br9EKXDsqhGYaIEuUzJcBkrYdm
         9gIMqRU/slbzty8kvVZ5BupTvQEt0E4ZasxEiz7XBrOUeMjUKm3CtD87a+zWWWLpe562
         GJaw==
X-Gm-Message-State: AOUpUlGeD9OTaltmiWOmQHlU6/n3cvg9JpJROp7mJ7v0hkaMEL2eCh1f
        91z2cNSEFjNdH3qXrCbCscntnd6g
X-Google-Smtp-Source: AA+uWPxESvI5uXXUy09rcVvg56XbgKXU49OZxvk+n8gQR7fvpIEWSdP5bUerMTouLWp8m6ej2zizEw==
X-Received: by 2002:a63:d03:: with SMTP id c3-v6mr10528685pgl.322.1534728663938;
        Sun, 19 Aug 2018 18:31:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p3-v6sm10589083pfo.130.2018.08.19.18.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 18:31:02 -0700 (PDT)
Date:   Sun, 19 Aug 2018 18:31:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
Message-ID: <20180820013101.GA2556@roeck-us.net>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
 <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
 <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
 <20180815224028.GA12104@roeck-us.net>
 <947d07eb6bc64eefe5cfd9a08420a33f855cbe2c.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <947d07eb6bc64eefe5cfd9a08420a33f855cbe2c.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 09:38:41AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-08-15 at 15:40 -0700, Guenter Roeck wrote:
> > On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> > > (Resent with lkml on copy)
> > > 
> > > [Note: This isn't meant to be merged, it need splitting at the very
> > > least, see below]
> > > 
> > > This is something I cooked up quickly today to test if that would fix
> > > my problems with large number of switch and NVME devices on POWER.
> > > 
> > 
> > Is that a problem that can be reproduced with a qemu setup ?
> 
> With difficulty... mt-tcg might help, but you need a rather large
> systems to reproduce it.
> 
> My repro-case is a 2 socket POWER9 system (about 40 cores off the top
> of my mind, so 160 threads) with 72 NVME devices underneath a tree of
> switches (I don't have the system at hand today to check how many).
> 
> It's possible to observe it I suppose on a smaller system (in theory a
> single bridge with 2 devices is enough) but in practice the timing is
> extremely hard to hit.
> 
> You need a combination of:
> 
>   - The bridges come up disabled (which is the case when Linux does the
> resource assignment, such as on POWER but not on x86 unless it's
> hotplug)
> 
>   - The nvme devices try to enable them simultaneously
> 
> Also the resulting error is a UR, I don't know how well qemu models
> that.
> 
Not well enough, apparently. I tried for a while, registering as many
nvme drives as the system would take, but I was not able to reproduce
the problem with qemu. It was worth a try, though.

Guenter
