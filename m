Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A7DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3A2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c8OA4jpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfAWVQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:16:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43259 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfAWVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:16:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so1795570pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ipLVKE7SAdMRWkIE0Xsa1BPy7hrsn7mLMBWA0mbXzK0=;
        b=c8OA4jpZzke+0QkN6UAxs5N49Pu0DW1RciosXHY1w8YxazCuuKYeVS+daQQfzZvKnn
         5fYJcJj4HvcOmSxy7a4oqrSLrlwT2X/FxB7KZNCcAe3yteZQOC4LcYMCmY8KE7p4oX+w
         wTasCRZhSlXELLL3z2bPvBX50bFSpcW1B/hdPWST+zXhL24qDBTAZaghHdljr4Mq3HFM
         E45ONxqJzRw/FgHTTuwGXa/LbwiVMMUKquQU8JDDfWBWAyK1MNzNcM6kUSE0XrYVpRuI
         lUuZFL/AavPkymn09uTfpGBEZxi9p8OciEEL8ASIM0iOYctF9fcefYFNoMjZ+S/nCgW9
         LVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ipLVKE7SAdMRWkIE0Xsa1BPy7hrsn7mLMBWA0mbXzK0=;
        b=FbkVk2dRUTcYY16wz4u8K9em63mqBEmSmHoB4UhkUeFqZQUC5SisFyps5yo/OexScD
         ivf7AL1kZ+jB7N7JfOqq852Z0nQjYH41M62TlKQweV9hbSZhip+5y2xUYMpC/Z4ZQVHX
         Ji7UEU45H7kCs/rqQC+kp3uEd1ieEdphWEuw7gA3wsbR+/KAcA7Su0gOSjmppEW8++Mt
         410Y0gH27YmeT2teEF75eQNeFVb08NAyrQ7IK8cNOdPzPW8NtdzbrKVQWcRQRpZ2o691
         ZqPSkBs4SZHW+N2pT58ImoP+jlqzfsD2BdzzJOgphrbfShDzaEJh4f7/tSffOREss1SW
         rlOA==
X-Gm-Message-State: AJcUukdfiEpz29K9QhL3PEVDoKtiVbvBapax3Trj1AwQ879IQpbqp8G6
        VhiGaiIdyeuptnHuLuznyGTaDA==
X-Google-Smtp-Source: ALg8bN61yf9k5S/8oktt+BV0DE7vSFj3gLvYxCHaugHTWIUWnDSRRmFpap7Y6cFFFOfNoQhAjh1tlA==
X-Received: by 2002:a62:546:: with SMTP id 67mr3569072pff.99.1548278159816;
        Wed, 23 Jan 2019 13:15:59 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m3sm25349396pgl.69.2019.01.23.13.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:15:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gmPsL-0002ER-R9; Wed, 23 Jan 2019 14:15:57 -0700
Date:   Wed, 23 Jan 2019 14:15:57 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/8] IB: cleanup debugfs usage
Message-ID: <20190123211557.GA8556@ziepe.ca>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122151800.15092-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:17:52PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs code, there is no need to ever check the return
> value of the call, as no logic should ever change if a call works
> properly or not.  Fix up a bunch of infiniband-specific code to not care
> about the results of debugfs.
> 
> Greg Kroah-Hartman (8):
>   infiniband: cxgb4: no need to check return value of debugfs_create functions
>   infiniband: hfi1: drop crazy DEBUGFS_SEQ_FILE_CREATE() macro
>   infiniband: hfi1: no need to check return value of debugfs_create functions
>   infiniband: qib: no need to check return value of debugfs_create functions
>   infiniband: mlx5: no need to check return value of debugfs_create functions
>   infiniband: ocrdma: no need to check return value of debugfs_create functions
>   infiniband: usnic: no need to check return value of debugfs_create functions
>   infiniband: ipoib: no need to check return value of debugfs_create functions

Applied to rdma for-next

Thanks,
Jason
