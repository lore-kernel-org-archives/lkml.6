Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA788C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A72320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A72320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHaEXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:23:38 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:45295 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaEXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:23:38 -0400
Received: by mail-oi0-f51.google.com with SMTP id t68-v6so18689771oie.12;
        Thu, 30 Aug 2018 17:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rl5ouohJh4MRX9+CuvPFvtVuYod8aM4WwrtU+OmMGas=;
        b=kNy37PNuZKJYs/gixnrlldOWTLPvJQLDvZX4C5xUxfsYkPtVX0itUhEWVFBRqLY/K8
         vH8XNrxgbPTWnpik49vNBuRh5Tjyz/llb2APzLys2qzDoeoiZjbUqR0YBI4D1/WpvAbO
         zT5aRM1n8jWDkrc4Pm/Z1g//JD1pjsuo9M/2Cjy3/rRpDkPdm85J4j9pXMgzqTga5yix
         wQHwj+9XrBX7LiWx3oHH+Ggr1eBO0tHDoxq/J7tfc/w1e4ixMj1sxYqqKBO9GSkD8GOD
         i93fSNp4MU06F5Pl+4yvh2F/s9lW2jWlH7mV3VJIalZ0nTA/2OEBT1SGIW7gldW9GiD2
         Q1eA==
X-Gm-Message-State: APzg51CIHnTRDR6tnzY+/TVXhBQY6iTSDK8/nQ7XdmuJB0ulZxI18mbu
        ODSdczSP2e/Pl09BqRyVXCY=
X-Google-Smtp-Source: ANB0VdbXhhajQlSxwkKnECls490SsZmI/+qRXTZ8tNVfHklz+BD/r/5GfRS96mQi2ZL7GhVLJn7hzw==
X-Received: by 2002:aca:eac4:: with SMTP id i187-v6mr5158167oih.256.1535674734804;
        Thu, 30 Aug 2018 17:18:54 -0700 (PDT)
Received: from [192.168.16.57] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id c9-v6sm7706289oia.1.2018.08.30.17.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 17:18:53 -0700 (PDT)
Subject: Re: [PATCH v5 08/13] IB/core: Ensure we map P2P memory correctly in
 rdma_rw_ctx_[init|destroy]()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-9-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f694b476-4db5-85d9-9810-7e82cd160d00@grimberg.me>
Date:   Thu, 30 Aug 2018 17:18:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sai@grimberg.me>
