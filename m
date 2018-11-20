Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76CAC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709E020684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfoQ/pVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709E020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeKUCoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:44:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44598 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeKUCoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:44:16 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so3119031qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFkje0LByaHXSh5jvs9SoRz0ZbkPFdiSkn9hiMbBcVg=;
        b=NfoQ/pVkyOfcy23Lw52m1s3ErqGUYCRcDn34Q8p5/ovvhPs8o+lhTsuMmFwFZ/NIfN
         NtvyC6z/zAbhIwh+E3R/DlPYtTznBTsF9+ZbuLje53KPeQ337qtv3WyZELN5Anq82xbL
         U7j0m1o65w9ozD3mMkuxG/zpRUz5FFQTJTVZCGsqeq2deK2C4YOuUXZ/hzglNa+9m4io
         ioYg1NdY5SC+E6QrBiupaURwv1p8yqo1C3qA9OEX9xqApSnGECOBhnSoCiNpic/HLx55
         X9mq6pD+NZ1zEa4B+UJFZdtslJPcWHHdvGUq/54+aJuVA4NbBgcuvYgc0qVYJ285KgkH
         /4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFkje0LByaHXSh5jvs9SoRz0ZbkPFdiSkn9hiMbBcVg=;
        b=eQp59RSstup+0hYLLVGvwfsNqCz8QUvDXFEFXIi+e3bRWFiC2Qu0ahmNMm6H46+Y4c
         PyfdPT32GpMQkz9pq9XTn0GHNA9W0N4dgd00H+MgNBZ59U/+KyZBn6l303dyg1DYNZqs
         LPoOP7FQLeRW8bGe5Yj9N87iaVaqtsAYxgHMwwRwBhFMyWRc9qjdnLr1VR5Rn4kfDMYu
         nClSKcmGYtMVlN+zWrJAspBKmQipfHku1E5ZrJ5FL+KDZE3oo17hkWHh4OmCTQIzP85h
         NuZL9lo+IBv+LnpmJsOE+5qdAmpQM6RQqrgNAzWr1+urorZ9Gl7qGYZIxD7A3IpQnmNy
         kZGw==
X-Gm-Message-State: AA+aEWb5ghclQtaMH2LCxeYkjUq8POZrBmy9wHAsKnco93MHUvR6Aaps
        c55NlOU3JFPOxZYAig9Rqmk=
X-Google-Smtp-Source: AFSGD/XXFoHsqgT0r1xxV3VtvWjn+bae0BbDYkHp3qnrDTif/gd7ZJX0bd+s1HTy6qm12p8SAt45CQ==
X-Received: by 2002:a37:358d:: with SMTP id c135mr2224078qka.232.1542730462667;
        Tue, 20 Nov 2018 08:14:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id n3sm25005699qtc.81.2018.11.20.08.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:14:21 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:14:19 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Radu Rendec <radu.rendec@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] Improve kernfs_notify() poll notification latency
Message-ID: <20181120161419.GS2509588@devbig004.ftw2.facebook.com>
References: <20181116020954.24924-1-radu.rendec@gmail.com>
 <20181116020954.24924-2-radu.rendec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116020954.24924-2-radu.rendec@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 09:09:54PM -0500, Radu Rendec wrote:
> kernfs_notify() does two notifications: poll and fsnotify. Originally,
> both notifications were done from scheduled work context and all that
> kernfs_notify() did was schedule the work.
> 
> This patch simply moves the poll notification from the scheduled work
> handler to kernfs_notify(). The fsnotify notification still needs to be
> done from scheduled work context because it can sleep (it needs to lock
> a mutex).
> 
> If the poll notification is time critical (the notified thread needs to
> wake as quickly as possible), it's better to do it from kernfs_notify()
> directly. One example is calling sysfs_notify_dirent() from a hardware
> interrupt handler to wake up a thread and handle the interrupt in user
> space.
> 
> Signed-off-by: Radu Rendec <radu.rendec@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Greg, can you please route this one?

Thanks.

-- 
tejun
