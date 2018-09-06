Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD7C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09B820857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AnnjBEgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09B820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeIFOTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:19:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55394 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeIFOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:19:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so10723202wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MLH6yDbasNuKCULuwVzPk3ZfZ6SyV5pWjzIbYow9R6I=;
        b=AnnjBEgp9QrixwYy8IngzAoAP0e2qU36MG1frERH0kI+Ys6LCVyzDQ55xZEkg5X+PC
         P/dr+0D4z7n/N6hRmPMssYsmolB9w1NkeZpJvFqh+Y/jx/O0NYjphdj6mhRicgJeZhnh
         tj6DaK1pL+uWq+TJuq4KLWVCcEdu++Hni1s+acddHhWr5XiW540zn09j5jvrhOXXevrV
         qzR6CFzXUZgbgSesz5QEZkugsx9+csO3UiGJaHV3497kGKpvbKsxOSF0yQj5qW0eHJsY
         G2l9E27/mNg1yQ/B4ZBnre2TwuM8Tpw7cjttOJtKNctoe15gye6YE6kciiEZDMlbeslX
         bLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MLH6yDbasNuKCULuwVzPk3ZfZ6SyV5pWjzIbYow9R6I=;
        b=ZSqimcaL6uo502gtAHHJYvWqHBy/BbjmtsMO7ZgwmQSJcibDnIuHvAvdDY0pn9rAAP
         QuS+5Ii5YnCQ6BLPBNnoPemwGUThm/3Nx5TqqQaJnrmvuQtnHZJDcnPlN9oxGhEx/26Y
         nJJEdH8eE5GIkGZk1kI+oeU8XDOzYrLlWaaRTWGhUmKbrRLWhgvu3O3Duqaurlk6jGFy
         9p29Knm3MFd23Q6gtihliV3r0Oj6Q1/XiGV6Qrlbtgkxl049+IcitADFInGd/59JmQVP
         OfetfeXf6+lsD94AIcEqXjwLHw9PHey6OzNc0v0BvrBLqsmZ3GS8vtJRbiCvwyLiifZk
         dKNg==
X-Gm-Message-State: APzg51AA1f2302mihg+hqYQiBtW/uKSjfAIKEPaPvbYiiFNp7vHeqfi8
        /RhMYnEDEvpeftduYsYj9Syp9w==
X-Google-Smtp-Source: ANB0VdYw1V80J5FA9Hn/27Shjax1uLre9HgMvFtCBdIvW/X9J9/XcSB9QJ0AIA964IWYbY0jXCg+Kg==
X-Received: by 2002:a1c:b709:: with SMTP id h9-v6mr1509852wmf.130.1536227107169;
        Thu, 06 Sep 2018 02:45:07 -0700 (PDT)
Received: from localhost (smb-adpcdg1-01.hotspot.hub-one.net. [213.174.99.129])
        by smtp.gmail.com with ESMTPSA id x16-v6sm5885250wrm.69.2018.09.06.02.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 02:45:06 -0700 (PDT)
Date:   Thu, 06 Sep 2018 02:45:06 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 20:42:05 PDT (-0700)
Subject:     Re: [PATCH 5/8] RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
In-Reply-To: <30229ef5-ce4e-e78b-32f9-7c563f63827b@wdc.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-aa617456-63d1-4275-8032-126a6b21305c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 09:11:11 PDT (-0700), atish.patra@wdc.com wrote:
> On 8/30/18 7:41 AM, Christoph Hellwig wrote:
>>>   	struct device_node *dn = NULL;
>>> -	int hart, im_okay_therefore_i_am = 0;
>>> +	int hart, found_boot_cpu = 0;
>>
>> If you rename this anyway please switch to use a bool.
>>
>
> I can address the comment on this patch and fold it in my series to
> avoid unnecessary conflict.
>
> @Palmer: You can drop this patch.

Thanks!
