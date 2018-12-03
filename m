Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90EFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2E620661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfU4f2K4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2E620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLCQ0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:26:00 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:36882 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:26:00 -0500
Received: by mail-qk1-f174.google.com with SMTP id 131so7683027qkd.4;
        Mon, 03 Dec 2018 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Bsr4wedVD9JxukZDVeRReP8kYGIjt+Mgx/noLT6+wk=;
        b=OfU4f2K4/+i0w36IQJ4ER9JlDdl0Amu+6Fi8sfliIUvurK/k311bGtZhBim0ZwLTCF
         dDY0iqwW9W1euaFaByK2cowZhCEfNAWI15ZpZSDtRj3Hg764CmFUFhvskg636alCV0AF
         SpDdPkRpqp/qVmFfJTW2ngefrjXvIPSk+ctflhGUWpQWAJe6sQluHFg3LQvHub0wiS3B
         fnSo9RV93Vbza0qST2/+mzcO9CWsCEhIs9HF4UcIs9QIjDFO1q4EA8Pvrd86kgvRjAe9
         dGg+B/ooaqL9yg0za2fx5hw5HrRp8pNsdCgdps+yKVl57zSm8UU6c8Ce3PsadBJy1CcY
         qNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Bsr4wedVD9JxukZDVeRReP8kYGIjt+Mgx/noLT6+wk=;
        b=Lyg74DR1zyh6Ngdxux4xaX0Vqf5onS4Blcj3Wwq1CBwHbgmNZ8W0+GwGZwQVxLaSRJ
         ksgq1M1lovFMLwBFwFOsBpxRyWPE2+Rby+HMbdO7jJfKKpeClqRQT39YKPTQ/mcosFmB
         X8rnZiLjOWFRfSlXwSOYd4mFLKiCMeYEpJ38ABhvLrSaV9F8snGPxXwpkCKPI/ETmu8J
         jeez3dNCpOPidYgGpLzOFZdYf0+MQolUR6iieJt+7jq5IGnPf+tC20tYxp90LhSL8zbJ
         1K9Yg8knkmZFkiHzSTg6cOWh/8u0XArMVSlYpodoZfnAXl3JfVdgTjVmKHjD8xhLpoNT
         5NIg==
X-Gm-Message-State: AA+aEWZpfdZqMrEk9NK4yIJpjHU3691tgkKxy3edQ3YIKPFTAiVdPMPh
        kz1FHaw3k0+XBhpcCYOYPXU=
X-Google-Smtp-Source: AFSGD/VptyuFX7e7g23JnNDh9LzsNwKEfWfTLvFEqOZrpj4qh5Ibc+GcYrAGuUJam163H7cDRvSrOQ==
X-Received: by 2002:a37:9604:: with SMTP id y4mr15818063qkd.279.1543854358010;
        Mon, 03 Dec 2018 08:25:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:20d7])
        by smtp.gmail.com with ESMTPSA id y32sm16093481qth.3.2018.12.03.08.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 08:25:57 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:25:55 -0800
From:   Tejun Heo <tj@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Li Zefan <lizefan@huawei.com>, mingo@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] cpuset: Remove set but not used variable 'cs'
Message-ID: <20181203162555.GM2509588@devbig004.ftw2.facebook.com>
References: <1543633976-183380-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543633976-183380-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 03:12:56AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> kernel/cgroup/cpuset.c: In function 'cpuset_cancel_attach':
> kernel/cgroup/cpuset.c:2167:17: warning:
>  variable 'cs' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit 1f7dd3e5a6e4 ("cgroup: fix handling
> of multi-destination migration from subtree_control enabling")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to cgroup/for-4.21.

Thanks.

-- 
tejun
