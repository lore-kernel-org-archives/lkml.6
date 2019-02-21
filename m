Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFA5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B980D2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfBUSpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:45:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33649 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUSpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:45:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so11807048pgl.0;
        Thu, 21 Feb 2019 10:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFMnt8qZAAz9edp0BewfPgS4DYaF2p/virsaeNQXMUI=;
        b=E8KDb3vejt9qlIdtKZdHI3OWnSFtRkOWIl5opgJFZKAPwQ4fPK7a9FchR1hhOfNO5r
         d7ndRtAW8rIYTOw/f1GnECP8cAgd8cyq5y/JGjwEKSE1KwSt6SctfvbmPsWNEWpi+87j
         EOiJPZQcF1URYooy9gsYugcFzcht+HB9NiXnkPYp0h3BGq3KFxN99B3j2s1GWqSeQc8c
         Xm0vaNIfE7HB1tSgR4UjZXBwI74/qrOAEcc9EOMcTa2xJ1qCo6c6zk6PBCDZuupVSyIP
         bxJPRb2NjmkMSRvDhq24NBKgmx9H49qCsNsPftUNEyMLFSOo+0xDfj2/EiYuAm7y/N7m
         Bn1g==
X-Gm-Message-State: AHQUAuYYaj05l3omPt25PhfCdFgiv0s/hkrit/+BJU2Pbx+WZgcB2viI
        rg3J+uC1IyV1HEzw+n+ByeY=
X-Google-Smtp-Source: AHgI3IbvIR3s1kUrnaTEtoUepWxI8E37d0KlgBbpL5b8rokM7zNpXamAuAfqaWiD8vCyQUXSYelxAA==
X-Received: by 2002:a63:80c7:: with SMTP id j190mr20782732pgd.357.1550774722644;
        Thu, 21 Feb 2019 10:45:22 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p11sm13171429pfi.10.2019.02.21.10.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 10:45:21 -0800 (PST)
Message-ID: <1550774719.31902.137.camel@acm.org>
Subject: Re: [PATCH v2 1/2] scsi: replace GFP_ATOMIC with GFP_KERNEL for
 allocations in scsi_scan.c
From:   Bart Van Assche <bvanassche@acm.org>
To:     Benjamin Block <bblock@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Steffen Maier <maier@linux.ibm.com>, linux-scsi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 21 Feb 2019 10:45:19 -0800
In-Reply-To: <c5bd5a82d1250471822cbf5891ea1866166cd9e6.1550740533.git.bblock@linux.ibm.com>
References: <20190220184847.24640-1-bblock@linux.ibm.com>
         <c5bd5a82d1250471822cbf5891ea1866166cd9e6.1550740533.git.bblock@linux.ibm.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 10:18 +-0100, Benjamin Block wrote:
+AD4 Looking at the code of scsi+AF8-alloc+AF8-sdev(), and all the calling contexts,
+AD4 there seems to be no reason to use GFP+AF8-ATMOIC here. All the different
+AD4 call-contexts use a mutex at some point, and nothing in between that
+AD4 requires no sleeping, as far as I could see. Additionally, the code that
+AD4 later allocates the block queue for the device (scsi+AF8-mq+AF8-alloc+AF8-queue())
+AD4 already uses GFP+AF8-KERNEL.
+AD4 
+AD4 
+AD4 +AFs ... +AF0
+AD4
+AD4 So replace all these, and give them a bit of a better chance to succeed,
+AD4 with more chances of reclaim.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


