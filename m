Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FB3C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873022075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUCY9hr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873022075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeJKWbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:31:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46931 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeJKWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:31:55 -0400
Received: by mail-yb1-f193.google.com with SMTP id o8-v6so3712377ybk.13;
        Thu, 11 Oct 2018 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yYG7W0+ohLVPNzgq2pzrzY/B3QtX5kSiWx3PqO6B694=;
        b=IUCY9hr1mdXVjTBFv36Lq2MmNKzhojWkUM9OGbpj7eOclk1B4SB8sMJC/4/DwNc5I6
         9ZgccbHuoM0yi0G4/RegjOUFipF+36Y/7sdtY7kPevr/achpfLZqx76SHde/pUrm2mLs
         1Yr/ay/gKBurj5Q+I6fI+EaDOWFraTqeG6quf6NF/tgyqGyk9RAeCFv1pJ2wa//bb+/g
         OjdWbVFCS/aC3d+0o49SNyhy4KoiuUMeegiVhcJg1YmewYWyVxIFOt6mA3MLkUryHWPx
         WgP3cA12Yv8ZXhcXxVm3xGsBuO6W8QpelfuK+S8nmGJyezDZodulgu0siXeMYBo+hoVV
         S/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yYG7W0+ohLVPNzgq2pzrzY/B3QtX5kSiWx3PqO6B694=;
        b=XmXXJq4yJQ+AWzZ1LPzYhpTJc5DWUqWdqcGC4lt9J2wWhf5tPDFrnbLewp2w4IOew1
         ih2M3UeoMVwVjwRBBFvGjC+Pu1M07i6M/cgH2E0f1mFrgXYNhxiwGkyaR8+IjpeVRkl9
         qWYt4xh8oisaooQTYc3VAFZOUQ4cEdGfXgUR65fWs2T2j8+RzPEZiuGOquDM/dIDQRg9
         59xfbGk1SmV2HZTOj9Bk3C0OXE+9/eD77VUSLf/YDyhirBGSvTbLERxnDANS+DIsvnwn
         O/DWS5O2oB1ondOnWE4IbyHem51qJocvjT6e2OGQ88MEAboXrjXRfLLzlol0oDKFnQbK
         Nunw==
X-Gm-Message-State: ABuFfoiiagE1W4j6M2shFZh7HM6O92fZBr84MJgp3TbbR+b5G6U1jwNq
        BlQMsOGiKnM5FSLr4qec0wE=
X-Google-Smtp-Source: ACcGV63lhp3Eo16D3HpCXVrp+IIHzi5/2gPyH/jM69cAvXjQ+Xq0FDeRZd/qisU6ZR3kavCRGFuqVA==
X-Received: by 2002:a25:51c7:: with SMTP id f190-v6mr1044333ybb.426.1539270260764;
        Thu, 11 Oct 2018 08:04:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::5:bc01])
        by smtp.gmail.com with ESMTPSA id t81-v6sm17566961ywb.90.2018.10.11.08.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 08:04:19 -0700 (PDT)
Date:   Thu, 11 Oct 2018 08:04:17 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
Subject: Re: [workqueue/driver-core PATCH v2 1/5] workqueue: Provide
 queue_work_node to queue work near a given NUMA node
Message-ID: <20181011150417.GO270328@devbig004.ftw2.facebook.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230715.10609.83647.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010230715.10609.83647.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:07:42PM -0700, Alexander Duyck wrote:
> This patch provides a new function queue_work_node which is meant to
> schedule work on a "random" CPU of the requested NUMA node. The main
> motivation for this is to help assist asynchronous init to better improve
> boot times for devices that are local to a specific node.
> 
> For now we just default to the first CPU that is in the intersection of the
> cpumask of the node and the online cpumask. The only exception is if the
> CPU is local to the node we will just use the current CPU. This should work
> for our purposes as we are currently only using this for unbound work so
> the CPU will be translated to a node anyway instead of being directly used.
> 
> As we are only using the first CPU to represent the NUMA node for now I am
> limiting the scope of the function so that it can only be used with unbound
> workqueues.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please let me know how you wanna route the patch.

Thanks.

-- 
tejun
