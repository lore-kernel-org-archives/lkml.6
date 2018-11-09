Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5958DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0E720883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwzM1JGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0E720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeKJFXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:23:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35269 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeKJFXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:23:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so1387958plp.2;
        Fri, 09 Nov 2018 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cm3TN1DzTnSUmce2iZSnmNa6o3+uac0LLY81nVfE5jo=;
        b=BwzM1JGylRJBMIwiO1NO+kwCdMgMlQHXiVM1hIihPdKqmE9qjbzkMI3LZVVl6DWQvP
         XMeeAM1C45ZxZ3XyUGsP1Q3EY/ITA55lFFtRSB23kkcSCuUey82Zm7l7zJ3PTDSPnkGz
         2yOeed6Csy64p7KwydRqRFcJPzCV/FF4aPoyHRwyfeJwGPRCTnq8GE9nMTNbfBOmc5+J
         Izb+qOX5pU4DMpqwASRltEnt9fRxmXH+LeIedj0nQII/mX6jlL4Xfk8dxSTufXagcPr1
         uARUKgrd5P+wr9O7g7w2gNYSTHSCTatHp07C5rllN060YaptYd3fnTqdBVqCripQYGaL
         i9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cm3TN1DzTnSUmce2iZSnmNa6o3+uac0LLY81nVfE5jo=;
        b=OS28HjhLDrebUbPIou6MKBadpoKZ1A8VLXbX1zM1S1OFP7gBqZBLLITdzGBRuaAXGE
         MCByRXKimOCcsB4J7Dr7lR5yoQJcD9TxnHJf3DKkvP48fks5jEWHIduJS7ZqoyIf92PD
         XsXmQKY9nfRXTGXBdNACzvbgNt0h97aap8r1Spzw+KXybvi34rQgOOGNUK5CSYLfEXun
         oSgWLlB+H3TlqVoLwPggKSPUnSV4wHH2j0kt3uVjgUzQYm4fDAxjBw2aXrneyoXJwgy/
         Ojt2mItfT7TnDRPedYmLDJWGTMtqgEAsIByU36tjlbWUhV0iWgWkboNlVslsiAPXWtyD
         Q6NQ==
X-Gm-Message-State: AGRZ1gIAkHDbYkgTKtGS0s9/zzrJHVYu5KiyFAax2/lJdfIwai7cMu26
        yuovspmXAt8sfKzVExo+sNSsVkKB
X-Google-Smtp-Source: AJdET5dZ9ol589dXb79De8EzjeJ51QOGQZqU2Pcgc7VY3LV4X//u20dhc9Vjbr2PbWTV0H4EZrrLQg==
X-Received: by 2002:a17:902:5c4:: with SMTP id f62-v6mr10312824plf.18.1541792503072;
        Fri, 09 Nov 2018 11:41:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z83-v6sm8939249pfi.4.2018.11.09.11.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 11:41:42 -0800 (PST)
Date:   Fri, 9 Nov 2018 11:41:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/34] 4.18.18-stable review
Message-ID: <20181109194141.GD27564@roeck-us.net>
References: <20181108215138.892971755@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:52:29PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.18 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:51:21 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 295 pass: 295 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
