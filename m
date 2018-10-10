Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F3DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE162086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EMH5pxWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE162086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJJVPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:15:33 -0400
Received: from twosheds.infradead.org ([90.155.92.209]:43134 "EHLO
        twosheds.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJJVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=twosheds.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=idi8U8lyyMzRz6UyVykoEvzRjZwQ91mQQlELFZBnack=; b=EMH5pxWAbaMr86K0KaQ20gxyO
        CAkSS2GHvub39nMuRUI77fc3+6F1vbVEnqJdSA9M4/6+271ZgRWPuNr2sTxQFFpqYlpG8F0kYOScu
        swvBRFQDvV9xGzc19T2LPdDEO0boGS83x/wcjZoLoaSClKowqVILSb5b5r6xcX5bdxpM9B605+Mds
        J4tVXqboOKuKkuKIbX4phdUOlKGJ2JPzyF9iSd5qzTd5PMaJPWudK1rApJRt6IQmV4scbsiOXl5mA
        O1DZGgM5uOb0WfjwLQO7WS9WKd7EwucERfriP1IWaBuY6dgpaslJr1qa6tf74yis2ZwI/+Rw/xPTT
        Ibe645flw==;
Received: from localhost ([127.0.0.1] helo=twosheds.infradead.org)
        by twosheds.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAEvE-008X1v-Gb; Wed, 10 Oct 2018 13:53:08 +0000
Received: from 2a01:4c8:101e:24d1:223f:70d1:9683:c60c
        (SquirrelMail authenticated user dwmw2)
        by twosheds.infradead.org with HTTP;
        Wed, 10 Oct 2018 13:53:08 -0000
Message-ID: <cb5493536af5bf3064bf568fa107bcf0.squirrel@twosheds.infradead.org>
In-Reply-To: <35f0d72b-c4b9-3557-6348-25a8646c6995@suse.com>
References: <20181001071641.19282-1-jgross@suse.com>
    <20181001071641.19282-3-jgross@suse.com>
    <47686a61dfc06aa5afb05a893b9a56e6eb46763d.camel@infradead.org>
    <alpine.DEB.2.21.1810101426080.10278@nanos.tec.linutronix.de>
    <eb9250d00cf9095913a7ecc3a2c575b9ed40fd6f.camel@infradead.org>
    <alpine.DEB.2.21.1810101445530.10278@nanos.tec.linutronix.de>
    <35f0d72b-c4b9-3557-6348-25a8646c6995@suse.com>
Date:   Wed, 10 Oct 2018 13:53:08 -0000
Subject: Re: [PATCH 2/2] xen: make xen_qlock_wait() nestable
From:   "David Woodhouse" <dwmw2@infradead.org>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "David Woodhouse" <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com,
        mingo@redhat.com, bp@alien8.de, stable@vger.kernel.org,
        waiman.long@hp.com, peterz@infradead.org
User-Agent: SquirrelMail/1.4.22-21.fc27
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The Xen HV is doing it right. It is blocking the vcpu in do_poll() and
> any interrupt will unblock it.

Great. Thanks for the confirmation.

-- 
dwmw2

