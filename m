Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5729021480
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5729021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJCUlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:41:53 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:39753 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:41:52 -0400
Received: by mail-pl1-f174.google.com with SMTP id w14-v6so3524788plp.6;
        Wed, 03 Oct 2018 06:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwWny6+eop83BvjE3Gi6awWyagNNoeC2NBqjhvX27yc=;
        b=FbTLDeKnoBWMI01r+Qe/b2QantolU16uWfgnbRhm3wYafm6lFIMBfziuxJ5z54/IXz
         UuPSc6lKOQBRvSBPIx6nBm86MUF99KTeZfWlKxKs8LdBwnIaysMtRwehRUfSMrnK6v0+
         /hKnyZWUPcs/CSfU105irS6dH9533PW7eprdBQLBdazsLotfqXCxqV9WTVLK2vUuteWg
         KCLuYtpkVKtf3w3B4EBZ+IzsnSlnGcfD48E8jezkIM58wUdyZKoDfQQlrcVa3epDvugf
         cQp06DKUI96CQy1bsatiQnOcPGwEKTPPAr6coaAcsjpRhXEZ+DFQ9r9QLNR6mNfrVKP+
         ZmcQ==
X-Gm-Message-State: ABuFfog/ByRWVAT2u8hFfsKdob4Nz+zimNQe3fpQ8yxme7vhLXTKVtyX
        3txH3VDU21PxsTQcyjM1AmWb7bl0Aa8=
X-Google-Smtp-Source: ACcGV611CqvERvInte5SgZNlkaVhIf3DCcc45MhP6zcSHzxfuT0FgFqczMMf07FpyVL+08aX4Y+mUg==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6-v6mr1753403plk.6.1538574801831;
        Wed, 03 Oct 2018 06:53:21 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id r81-v6sm3032148pfa.110.2018.10.03.06.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:53:20 -0700 (PDT)
Subject: Re: [PATCH 09/16] scsi: Replace spin_is_locked() with lockdep
To:     Lance Roy <ldr709@gmail.com>, linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-10-ldr709@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9c03e8e2-1fda-dd9e-2716-e45175111509@acm.org>
Date:   Wed, 3 Oct 2018 06:53:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003053902.6910-10-ldr709@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/18 10:38 PM, Lance Roy wrote:
> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is
> also a step towards possibly removing spin_is_locked().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
