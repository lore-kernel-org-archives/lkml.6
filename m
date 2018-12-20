Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14056C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D525B218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP+sy3Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbeLTS2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:28:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44240 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbeLTS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:28:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so1252244pgr.11;
        Thu, 20 Dec 2018 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxZ7xvhosk7DnA/WLvL5Vb9KcvSMSR9K+cq/sDBYXyM=;
        b=UP+sy3Ip1c6Ds4QlQPiq4OW5OsT14QoMqcGhgi5N8guuGJPr3Z0rGBkEJARsf1PVKu
         8cmLJrIa9do/6XIj7rnyDj0gKfA13GHzdTDd7gqnS3KadL1JshMRP8Hh3Be9kh+ozizA
         wJpTxzylfinQAX5g+sGH2sbPVRdfWwCtYTuKv6qjUbuvRQQZFYbT4+OsDaX0Ia2VwNhv
         CM8iT4YA5sk4DJKnT7Ni1k/fkx4SbSKhsnLPgUWdagLhWxPIqs6TSrzty6oDJBZfjO3q
         pGTp2+m46k/szc4H4h9DhAvZIGdXozn1GGLRQhZdcLX7pyJTMkiX2IfFG5sAR9nOD3Ut
         pzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxZ7xvhosk7DnA/WLvL5Vb9KcvSMSR9K+cq/sDBYXyM=;
        b=GvlWdaa+YYmaLQYokGULOxdTQNqXIHEkPj+eSs7kclyr2ZXCyOzUR1pYcM/50swF+o
         3n9J3zpWRPOroCQ2TLUzkoog2eHxmm+k734bLDc8Y8QXvgz/uq4ibuC32CHns9uZTRMb
         MF4yfCcnqe2qQMRjTTexDGtMhjKvI3pP/RBcnx9UMp8HmbvvOswaifR1OIZcEquAJJy+
         nwbBTh/rEdV57LmIMUSo1YKPwtN1COObKK5e5aZjZAcHQWlFGCFpS+nFgfVcnv8vS++v
         sug3A6+e8FKvSU2IJL83vWwdTgPTWXBmUuJQhRXvl0S+lW961xDQ8c2T3ALRkNJdCaVT
         JUeQ==
X-Gm-Message-State: AA+aEWbt8UIFxkSKoeR8v2lUOMPTUs7NYGWVXQoRRFar2/JQrvQ0S0Nm
        QeYWLETmsRdGaDR7Jxgu+rQ=
X-Google-Smtp-Source: AFSGD/XZg8Yca9arYB+dZfSONKYuA2Y3979i+CpWHogiMZHRJ0vFqnps7JC9eWdeyxVWbLoNdfQfLQ==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr23329350pgc.216.1545330496011;
        Thu, 20 Dec 2018 10:28:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l69sm44483325pfb.75.2018.12.20.10.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:28:15 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:28:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/40] 4.4.169-stable review
Message-ID: <20181220182814.GB12802@roeck-us.net>
References: <20181220085826.212663515@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:18:12AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.169 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:58:16 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 170 pass: 170 fail: 0
Qemu test results:
	total: 278 pass: 278 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
