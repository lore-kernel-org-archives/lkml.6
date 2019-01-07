Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE062147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfAGQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:57:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37482 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfAGQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:57:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so448811pfb.4;
        Mon, 07 Jan 2019 08:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJdMPYu/0NflhcvSrMuMBq305Eo6Gc5EGRok8Qlozkc=;
        b=A0HaXVlZeebk3aNnwG/DzifJk9EFHoUyaZwiaUGeIoaN9LV+1GxQCQw7vVLC2KMb9w
         2lTBc5mzBi5ynOzG2JX0CigI0zN1WurndQGnTo9RjQVCGoMJQEE1T27t6ILcCrmwaMiO
         qkB/LLw7GPbvmVbowHxnWGI8krEotT/oF8OMVCNrWh+CwYSB5ZDZl+wSSIwXMna2e5mD
         IhtWmIyZAmnZYyYIbkSnIyrQmQDhVFntrMlqm4bPDvv4YSWTmqm0vUoGB6UynvcLs0lA
         T2eaDXAWfUWJZjbNoZ2wh9w/waNUGRecgfLm6wD0HR2QCtUyxA6kkpRaHAok9NASZEGh
         DdcQ==
X-Gm-Message-State: AJcUukfG4Dd2Q66CkqFCWJjkmzizYzTOlsKurEHW9EmUkburTdW4axuY
        W7ofuJCxPcobFfOobvvX8IVkRjIkvDU=
X-Google-Smtp-Source: ALg8bN51+8jGvchV8wVaYDHPtDaIaH47x/vA6ifZyBFKGmQlng7FT7fHFKvhlO4wqElQfhxTmlzXLQ==
X-Received: by 2002:a63:1408:: with SMTP id u8mr7275502pgl.271.1546880245656;
        Mon, 07 Jan 2019 08:57:25 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i193sm114975922pgc.22.2019.01.07.08.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 08:57:24 -0800 (PST)
Message-ID: <1546880243.83374.12.camel@acm.org>
Subject: Re: [PATCH] scsi: sd: Make protection lookup tables static
From:   Bart Van Assche <bvanassche@acm.org>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Mon, 07 Jan 2019 08:57:23 -0800
In-Reply-To: <1546872111-5627-1-git-send-email-john.garry@huawei.com>
References: <1546872111-5627-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 22:41 +-0800, John Garry wrote:
+AD4 Currently the protection lookup tables in sd+AF8-prot+AF8-flag+AF8-mask() and
+AD4 sd+AF8-prot+AF8-op() are declared non-static. As such, they will be rebuilt for
+AD4 each respective function call.
+AD4 
+AD4 Optimise by making them static.
+AD4 
+AD4 This saves +AH4-100B object code for sd.c:
+AD4 
+AD4 Before:
+AD4    text	   data	    bss	    dec	    hex	filename
+AD4   25403	   1024	     16	  26443	   674b	drivers/scsi/sd.o
+AD4 
+AD4 After:
+AD4   text	   data	    bss	    dec	    hex	filename
+AD4   25299	   1024	     16	  26339	   66e3	drivers/scsi/sd.o

Since the sd+AF8-prot+AF8-op() function only has a single caller, please move it from sd.h
into sd.c.

Thanks,

Bart.
