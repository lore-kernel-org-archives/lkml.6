Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20827C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA950206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Ilbx5OFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA950206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeHKWnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:43:47 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:19242 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeHKWnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:43:47 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 5F3C73CD566;
        Sat, 11 Aug 2018 19:39:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1534009196;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cg8b1QaOuyXtJOtdJeBIIQze9zUNhkyvDkY2087ylA=;
        b=Ilbx5OFVkjm2xd0evev0V1Itl6cfvX6F3IE0VpWVYqflGEdQuWTuCCF7C8p0rivzPY4KZQ
        Pueq/O60mw2FtHPG0ab5fj+kIbTA2Yw1A1W0t9/vjyFAbSYb6AO5+I7xkpI95Y11XV9TB1
        4Bx5ekcffvS7B5ZdO0fQ9WK/yMENAbg=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 5F3C73CD566
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 11 Aug 2018 19:39:56 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kurz <groug@kaod.org>, qemu-discuss@nongnu.org,
        qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Slow boot in QEMU with virtio-scsi disks
In-Reply-To: <CACVXFVO1pN=CZvNY8Q4wBrAoA=3w8Ew38aGqpOSHJ1uYAM-sxw@mail.gmail.com>
References: <f40092b20856d07bd7f870abf5ea939e@natalenko.name>
 <CACVXFVO1pN=CZvNY8Q4wBrAoA=3w8Ew38aGqpOSHJ1uYAM-sxw@mail.gmail.com>
Message-ID: <98344e68266e447826f133ad14d0c83d@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1534009196;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cg8b1QaOuyXtJOtdJeBIIQze9zUNhkyvDkY2087ylA=;
        b=YPK75TKxjk2BSuDVN08oexAK/qsRzNtdTK5CuMGd88brEPFVrEDZ04az+yq4TOxgL/7o15
        juyYGW45WnENYmGDgfcj3AwELw6QPmT2LYzmgm1yEnOdD54lQ0ZMgde7muiM83gTf7IBaY
        buRDrZVvUR7zIk0heC2LQOiwCaO8pzI=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1534009196; a=rsa-sha256;
        cv=none;
        b=tWZQWlnEuqNXexarmwbYkZ4R/gy5lyJX0Z7rKb4AundN0QaBxYqGRaKxUS2o2o7+OQD9nypGHI6baqRtLmyF7nXCruvuMh/6hj4L8cFJxd2EXphp6ifNMXNspFHBynsSg7LTdnJQDfkzuBQtFZPdk49uVc+iiUiMqWPKo5QuO24=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 11.08.2018 14:23, Ming Lei wrote:
> Please test for-4.19/block:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-4.19/block
> 
> This slow boot issue should have been fixed by the following commits:
> 
> 1311326cf475 blk-mq: avoid to synchronize rcu inside 
> blk_cleanup_queue()
> 97889f9ac24f blk-mq: remove synchronize_rcu() from 
> blk_mq_del_queue_tag_set()
> 5815839b3ca1 blk-mq: introduce new lock for protecting 
> hctx->dispatch_wait
> 2278d69f030f blk-mq: don't pass **hctx to blk_mq_mark_tag_wait()
> 8ab6bb9ee8d0 blk-mq: cleanup blk_mq_get_driver_tag()

Indeed, I can confirm that these commits fix the issue.

Thanks a lot.

-- 
   Oleksandr Natalenko (post-factum)
