Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CEF20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dvn8EvSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBDXW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:22:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34818 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBDXW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:22:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so653853pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8f1DiS3/vTAXBsjDnjROxBNeJKvcOnFPKys735rGYGA=;
        b=Dvn8EvSEbdcbBmznR35HHOPLvJQhL+cAvlK98U4tUhbGqDTfiwsDrB09RGrkMBPePX
         CgiqVGLlMaqDs8wFRqIsVvjHhxsyjli7uVhaOlKtfi432r0la73Fn372QfyrcrU0uNtk
         l2A2thD34om1qhu+7RxrjL3GnP+oNlu/dyq/0mpKQXiGTPGxk516halC8JdD3aYJstcx
         97lVmU4+UQuYhbvCC+b6sfxbWAvgPxOOn8HGdshKWeAYWTey/uodyVY7weyRZGXcfvSy
         BT3RH9mSvG2ntUEZQAf9ZwFb750xvx4vVYeic/U8ITrIVA+lb0YFvNP63w4nvi6AnQdj
         DZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8f1DiS3/vTAXBsjDnjROxBNeJKvcOnFPKys735rGYGA=;
        b=HvsNTF70fsMGvsxfSnQmYfITBhMSzsN/fOd4/PPrttcObK+gbtQ21JwxvXDmga4kfJ
         UUWxDn0QodshBV9ECeomxmTAh4jLvy5ufhw5hFudY3bTzp5Dg8QJtOm89KJFaeKvN8MY
         7CJVb4XeSce79qx1msBVOhI+c2/5IMb9zvYfI/FgwBScoiYvfuZ8XBbuLlaFAc7rkRuu
         98XX1gBuQI0sP3F428GPNZT/T6NsK2HXwK9+uFsuzdJlYRuzhy1dPdiln8N8OypP94Ne
         ofIFKWIIo4td63B6n622rU0KgkJfCWypf8PHZEEGUjz9FaM3Vjkkw0qeICtVDGnB+QgJ
         plog==
X-Gm-Message-State: AHQUAuZdZb843kqDqNITyT9d3P04ofogjWLHausEp+EEAD7Uv9aem63w
        Kx4kv4IbMIyjT/aOdHmR2GDsXw==
X-Google-Smtp-Source: AHgI3IayEKuRsorZe3FYuM6JAZyrrZWUsl6/xaXbnF0Td7e8CStNQY5QRSb1EMPp/1hmpdtP+jj7KA==
X-Received: by 2002:a62:5003:: with SMTP id e3mr1910028pfb.23.1549322577793;
        Mon, 04 Feb 2019 15:22:57 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t29sm1438316pfa.158.2019.02.04.15.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 15:22:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gqnZo-0000ya-EU; Mon, 04 Feb 2019 16:22:56 -0700
Date:   Mon, 4 Feb 2019 16:22:56 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH V4 rdma-next 0/3] RDMA/hns: Some fixes for hns RoCE driver
Message-ID: <20190204232256.GA3731@ziepe.ca>
References: <1549197795-23118-1-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549197795-23118-1-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 08:43:12PM +0800, Wei Hu (Xavier) wrote:
> Hi, Jason and Doug
> 
> This patch series includes three bugfixes for reset related operations
> and are maked based on wip/jgg-for-next branch.
> 
> Best Regards
> Xavier
> 
> Wei Hu (Xavier) (3):
>   RDMA/hns: Fix the Oops during rmmod or insmod ko when reset occurs
>   RDMA/hns: Fix the chip hanging caused by sending mailbox&CMQ during
>     reset
>   RDMA/hns: Fix the chip hanging caused by sending doorbell during reset

Applied to for-next

Thanks,
Jason
