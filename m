Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B2CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D520645
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUPcD9Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBSSrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:47:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41649 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:47:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so2285205pfn.8;
        Tue, 19 Feb 2019 10:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3OETKXStBibk3GWbQisutIiswzQhSNXZDKKLjOHU0qY=;
        b=WUPcD9KpxImQPTrHtSrO+ejeEUgDADQOprPW4qX1t6Oy6Bplz0eMXoFBfuWfXqWHtV
         ILMWkMfXXLqB028vqhPm/ZNdoKxpqmVYxZfifR+vAGsjUQJ6drB7hDhflfClts7IZFAn
         B1w4S9jFGEdGDSY+8oLiJwjVASuHQufOLcuP1KYs+SPLit4tYQBww/jRHmzZhQY5Oul9
         mFXhin83OOkDpdIqY7yKrxXo+fpUmyB7TuK/NtEkA//7EmzUhL7d+zuLoF+Th44qGdNd
         hlfjCBpMEBoHKSn8ZjJLun90pYb5Q9NBNt+8rKpSM46+bWmMekKzy8H+9im3So1fl2yX
         yYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3OETKXStBibk3GWbQisutIiswzQhSNXZDKKLjOHU0qY=;
        b=AN125HBw8KfNO5fKjbyY8SjWAh9/MYA/klm1utJlFRYfOV6CoQY6QDYsXgCM6Yn9tI
         /TVfUpnl+WQWHOSIXsWAiaBJwPdUnPnw+cClFuAv6ENkQot+5mZuMMH2mGeXLvtzGxf/
         xIwGc5DFLznZvr46BzLSDy8qLCBQpzTtMmPuhKv/e1TlnBiilTP1l3YVbFhs2Jv6RpLU
         DOxpnTK0EejyFTGdoNjO4bEVKPNnsO1hDzlOrrVRaFWSj2sPbu6sfhv3KUaQdxuqiCQT
         lP5qvuXm9/+7WN30wYYax9PMirkxtdko1wMMaQAZy6qZ6b+m/Z7FINypaFVN2vZ39NEN
         1a+A==
X-Gm-Message-State: AHQUAubUMJNv2ijFtR/XdDVMtcSowMwKO1HYIUcVFQjEaqKLnmayHo10
        yD6cm46S2YL3ndOhmwGdr/TN59n9
X-Google-Smtp-Source: AHgI3IZLzKH0vQbZb3EbvppqShMdyvi8aXAbR8KQN5S0RrivLrmzzSgWMY/qywHP9haU56YdJNradg==
X-Received: by 2002:a63:9348:: with SMTP id w8mr25216355pgm.198.1550602060169;
        Tue, 19 Feb 2019 10:47:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f62sm26859651pgc.67.2019.02.19.10.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 10:47:39 -0800 (PST)
Subject: Re: [PATCH] s390/setup: fix early warning messages
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190218154640.GA27699@roeck-us.net>
 <20190218180146.79930fe6@mschwideX1> <20190218182106.61b10ee4@mschwideX1>
 <20190218191655.103c81ca.cohuck@redhat.com>
 <05e78442-07e1-9783-965f-b3d64a2c5e99@roeck-us.net>
 <20190218233021.368bb475.cohuck@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <eca82ff3-bc07-ee2f-b67a-91425fe1ace0@roeck-us.net>
Date:   Tue, 19 Feb 2019 10:47:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218233021.368bb475.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cornelia,

On 2/18/19 2:30 PM, Cornelia Huck wrote:

>> What is your qemu command line ?
> 
> Ignoring any additional devices:
> 
> s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu max  -m 1024 -nographic -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001 -drive file=/home/cohuck/vm-images/vm1.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 -sandbox on -kernel ~/git/linux/arch/s390/boot/bzImage -append "root=/dev/sda3"
> 

Is "accel=tcg" and "-cpu max" expected to make any difference ? CPU consumption
on my system seems to be identical to the default (no -M or -cpu on command line).
This is with qemu 3.1.

Thanks,
Guenter
