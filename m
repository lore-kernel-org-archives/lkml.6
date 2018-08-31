Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D91BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5006720837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5006720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeHaETG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:19:06 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34530 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaETG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:19:06 -0400
Received: by mail-oi0-f47.google.com with SMTP id 13-v6so18762574ois.1;
        Thu, 30 Aug 2018 17:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=aLT43CS5cAaT7WbUogwK6QaYHux58E5FeaMJccSrRHUTik0idS1Fu7Y/rhpF5O4ehU
         8cy/a2ksmtPAXFQssMt+OliCi3q5sZtx3j0V4RHCSx8mNPPBaxd2C6jsUKPgJoWj3+iV
         BpRCX4mNp9x0/ywbFpTiwBr5DgQVKCttL6nN711q85+Gh7EzBrUUHMf7qngkcXNxB4P6
         EPr0GTZ5ZnJ7ybaZb+9T4S2040fXqwXDBT0uzD2b63HWr/8E9AG36Wmsov3Lwaqj/Xyx
         Zs2gYrhK781IBC6pnNANcvHQkzokIal3zZeTLkh49M/yU4OhcaWV9rDxoK4qIDHEad6M
         tF5A==
X-Gm-Message-State: APzg51CJUMre+LDnwTHhIpC/8MxvpWOdUi9v0wC6VJpns2qOcQoFgOAU
        A4fHelyFYmKVvhVjy+go1bA=
X-Google-Smtp-Source: ANB0Vdbc45jkwCKl+hCCmhdHKHUkfAVuQ2gSZ10jnMfdQTC6GRY+IsxT0nmQB1YeCSWgALFe3vdiLQ==
X-Received: by 2002:aca:a659:: with SMTP id p86-v6mr4677614oie.105.1535674463930;
        Thu, 30 Aug 2018 17:14:23 -0700 (PDT)
Received: from [192.168.16.57] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id l195-v6sm11877163oib.17.2018.08.30.17.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 17:14:23 -0700 (PDT)
Subject: Re: [PATCH v5 12/13] nvmet: Introduce helper functions to allocate
 and free request SGLs
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
 <20180830185352.3369-13-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ebfd54ca-d3b2-249e-3927-eaa150b5a7c4@grimberg.me>
Date:   Thu, 30 Aug 2018 17:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-13-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>
