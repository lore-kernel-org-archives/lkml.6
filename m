Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC065C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34BA208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34BA208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbeKLLRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:17:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39135 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeKLLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:17:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id n11-v6so3469032pfb.6;
        Sun, 11 Nov 2018 17:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9SBhjCN4qNRKcpLdM2GHdUrP1yD8NgXJwYAwZwxEuA=;
        b=Bb4o5q3zB1pHRwnykfMQtRZGfUp0UPeZzkvOOVeav6YeQ8qp9BOv1fPDuPy3g28nLZ
         qB6pzAi9NQkWO1Vjdb4hZA/TZJ+tBHaRAO9lbeL8w31RWgVRnqJpFfshWPeH6LitpR2u
         xuL2r5OlSgT72DxzTdaI2sFeToV0AFal58loC9cDVw0Dly1JQBXU1ERfVv6XQk2EjKXp
         /rhgU0wEVaAiFQOZPiKvHyZijNOUQbv2BPBqOW5ORlT0qvaiLIO3/CwCLVtFG1kxIR7+
         EfHPozVpCUyAfFKApiu1v2X57UZimNl+HZXT3ntoTO+ORNcgBxPKbvjqOpMe+z39AJAF
         BiAQ==
X-Gm-Message-State: AGRZ1gJLnLn5bCEoUL4hRdzrI4/qQSz7np8GF03sjcZKKo+aQWyL9ltG
        AmlFumnBT/FataMoHC1qeuqil25qGr0=
X-Google-Smtp-Source: AJdET5ePdmWTbSDrBmKyKNKHdHWMxvqEYoQmLXoVemhOx1gfkArzSIahgoWZ+foTs6LJuWljtASs4g==
X-Received: by 2002:a65:4646:: with SMTP id k6mr15562817pgr.153.1541986026782;
        Sun, 11 Nov 2018 17:27:06 -0800 (PST)
Received: from asus.site ([2601:647:4601:5d98:fb3c:91c5:1423:24cd])
        by smtp.gmail.com with ESMTPSA id f193-v6sm20402300pfc.74.2018.11.11.17.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 17:27:06 -0800 (PST)
Subject: Re: [PATCH 4.19 078/361] nvmet-rdma: use a private workqueue for
 delete
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221630.901793876@linuxfoundation.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a90c8564-3b8a-0c75-4a2e-bf497072f849@acm.org>
Date:   Sun, 11 Nov 2018 17:27:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181111221630.901793876@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 2:17 PM, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sagi Grimberg <sagi@grimberg.me>
> 
> [ Upstream commit 2acf70ade79d26b97611a8df52eb22aa33814cd4 ]
> 
> Queue deletion is done asynchronous when the last reference on the queue
> is dropped.  Thus, in order to make sure we don't over allocate under a
> connect/disconnect storm, we let queue deletion complete before making
> forward progress.
> 
> However, given that we flush the system_wq from rdma_cm context which
> runs from a workqueue context, we can have a circular locking complaint
> [1]. Fix that by using a private workqueue for queue deletion.

Hi Greg,

You may want to drop this patch. A bug was discovered in this patch a 
few days ago. I think not backporting this patch is better than 
backporting it. See also the discussion at 
http://lists.infradead.org/pipermail/linux-nvme/2018-November/020766.html. 
A quote from that e-mail thread: "I think we need to revert 2acf70a 
("nvmet-rdma: use a private workqueue for delete") altogether because it 
never made any difference..".

Bart.

