Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04146C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF20020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm7eiMNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfAQXCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:02:25 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:39164 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQXCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:02:24 -0500
Received: by mail-pg1-f179.google.com with SMTP id w6so5103014pgl.6;
        Thu, 17 Jan 2019 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zSi8/pcNGQiBsDstKHYs9JTf0+6X8Xd0CNOqF3U4IWU=;
        b=Nm7eiMNG20Joj5YE9ZIt6XTVD3wL2djU1xMdEEk0mzx5r7K0X3/3KubTAKlMyibDCM
         Q9grOLEEI5DXP3p/iksA8mKCxIi5iCA0uQzSkfKYq48v4oWhC2WY3szis2ktt6Y0FCRu
         UYFEMyKxKueM28v3vKWMvPvv9zwNn0NP46m7uezpgy8hsnY828ftoTALVb960AD83fHV
         ZJYrGEegvF+zURcqXmWMCGhhXrJUKeb5vHFbCBC+QzpLiv1nA9mpjgSi5bvU9EtbZNhj
         BmCAeUPs2fB9jfbT2hKVqYBtb4NAkIoJIV/nQSGdZSNHe4IJjkNV/PcnZtVDE+UvZMKz
         gWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zSi8/pcNGQiBsDstKHYs9JTf0+6X8Xd0CNOqF3U4IWU=;
        b=j3og94twLPTFIzyOdgzoV015cuNMGPPf5ThrpBiKFZ2hQcVfkaZrs0ZAW95mTil4F/
         NAZfO65d97/ORWkFOstf68vUhoAy981tKV7JvYFMF+e+jKUUfz5J5eyxjOgY0C6ncEHL
         xqbyueYa3k/EWe2odYzsli7BjBPKe7oPtvTgE6bWYBugmf4kuWZLI2LlEp6I7qrfh1p1
         fDQf//umnBsiqhVl65I19efmu84fjPc3BNESXUSGv34fgIUI+FteT9Cpd9AmhGTLN825
         69f7sBqx+YkiqLycFI0WM98Xx9a6IrYehJ8LTLo642OMV1IXwgofUnrs03GHBCJi/DDO
         Ob3A==
X-Gm-Message-State: AJcUukdrdhIf6MsBVY1cTxvDxTbwgB/H1wnC0/bPUZ8PioRYH+F0dPBc
        4abvPB1HMTjI4mX9aM0oaQQ=
X-Google-Smtp-Source: ALg8bN6QbnMwIsyQlNb71rPWyyN88s67vjIFnSO0qF6vglUPh3LwpCMUf9/5IqM4wDPMgZhtFkw4+g==
X-Received: by 2002:a62:53c5:: with SMTP id h188mr16578137pfb.190.1547766143848;
        Thu, 17 Jan 2019 15:02:23 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f62sm3248551pgc.67.2019.01.17.15.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 15:02:23 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:02:19 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (ina3221) Implement ti,single-shot DT
 property
Message-ID: <20190117230218.GA28287@Asurada-Nvidia.nvidia.com>
References: <20190105030636.533-1-nicoleotsuka@gmail.com>
 <20190105030636.533-3-nicoleotsuka@gmail.com>
 <20190107193555.GA13547@roeck-us.net>
 <20190117223012.GH16918@Asurada-Nvidia.nvidia.com>
 <20190117225842.GA23511@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117225842.GA23511@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:58:42PM -0800, Guenter Roeck wrote:

> "Right now" was supposed to mean that you should wait for Rob's
> feedback before sending v3 with the feedback above applied.
> Did you send that version ? I don't see it in patchwork, nor
> in my inbox.

Oh, sorry. Will resend it.

Thanks for the reply.
