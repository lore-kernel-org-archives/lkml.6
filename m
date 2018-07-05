Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70605C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C98240EC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dgtS3/De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C98240EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbeGEQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:42:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35987 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753999AbeGEQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:42:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so5909928pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=A0o6Mm0VZF7FyT+vXpSakPms1bE+UqlDNXNl96kA9sc=;
        b=dgtS3/DeyTPay3Eo2jHxLPXZUfek45bREeoo6m4g5IQtty1MOUbMg36iAg0kNt5JtV
         3R5EC9kM9sTzHCw/1L+NU7PYtnCjbhnNYt2aXqrGC/ObZlzk4tnVOFuEMLTHLInbGQqo
         W2RCScrKQO7mioHzX94SXg61uswD5v7AdFclCAu3Xn7XpC+0NwoNzUk3VxaeKXF/ka2D
         L7a0fJPRn9EGsWBFi0ZvYIdjYkx4S7Y328Too+PLp35GgTVlp1b8htXeXkZr60ddKIOv
         s99++La3dkXpuf1LWzbnaIWfX3kc7Hf/rI0qZnvOxE6fU2nz9Du86vbcHM3OHyXFJX1b
         kZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=A0o6Mm0VZF7FyT+vXpSakPms1bE+UqlDNXNl96kA9sc=;
        b=pidRY/jZCeliNXMNMUnD/9zJlYotuPC6aD4j3SgsxskVxiiunpKRG9UTgd0XwZm5WG
         dMfM+dIVoggsoh/bSBYGSW83Vq3W7X4bqPDrftbRya3i9h0hfVtlWFrLDkG/cnBR2zWk
         KZRVOciGgpa1qb59UrMLLCA/i8wwhPXyTCAqvYF9PmQXITt4z3B8oreniklAw+xfg1wn
         NWvIheO+7y/t0kPARYVDyHDA1zgZmeKhyMxTyn6g+rMw9k2sCbOx3Dn55vvw6aSzbyBM
         F/IF/BM4ZG5T8UQjq4KDfV/Oi9clcPzpRnsOj9jnjVHL7AujkreG5j1ZYAvEqH0Nqrq2
         bjEQ==
X-Gm-Message-State: APt69E0bPgH11C3Lg+7x5aOVwjGeJHccFDdWAgb6oLVsYhr31C7Kaaow
        h0jbPEY8NQPf2bwJKK3jYqIt9g==
X-Google-Smtp-Source: AAOMgpdKN+vDZX0VSs+PMbmULw9LKxlle2R1kyrDxZKeLpm65YoE/SnCKgQwomEP0X26i9qRZ1iDjQ==
X-Received: by 2002:a65:62ce:: with SMTP id m14-v6mr6277382pgv.407.1530808950290;
        Thu, 05 Jul 2018 09:42:30 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 63-v6sm17486747pgi.66.2018.07.05.09.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 09:42:29 -0700 (PDT)
Date:   Thu, 05 Jul 2018 09:42:29 -0700 (PDT)
X-Google-Original-Date: Thu, 05 Jul 2018 09:42:25 PDT (-0700)
Subject:     Re: [PATCH v2 3/4] RISC-V: Add definiion of extract symbol's index and type for 32-bit
In-Reply-To: <CA+ZOyaggr-Y2-Yh_o4+XQLoT5-o6PM9m4_T3sHHUq13+CgJYEQ@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zongbox@gmail.com
Message-ID: <mhng-ace58b68-1a85-4109-b564-4e24179fa8a7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018 06:33:07 PDT (-0700), zongbox@gmail.com wrote:
> Palmer Dabbelt <palmer@sifive.com> 於 2018年7月5日 週四 上午4:58寫道：
>>
>> On Fri, 29 Jun 2018 09:53:49 PDT (-0700), zongbox@gmail.com wrote:
>> > Christoph Hellwig <hch@infradead.org> 於 2018年6月29日 週五 下午3:12寫道：
>> >>
>> >> On Mon, Jun 25, 2018 at 04:49:39PM +0800, Zong Li wrote:
>> >> > Use generic marco to get the index and type of symbol.
>> >>
>> >> Why do we even need this in a uapi header?  Shouldn't ELF_RISCV_R_SYM
>> >> and ELF_RISCV_R_TYPE move to module.c?  In that case we could just
>> >> use CONFIG_64BIT.
>> >
>> > Make sense. I even think the all definitions can be move to include/asm/elf.h.
>> > How do you think about that?
>>
>> Sorry I've been slow about reviewing this, but I think just in the interest of
>> getting a sane RV32I port up and running quickly (so we can try to get glibc in
>> shape) I'm going to take this for now.
>>
>> Do you mind submitting a cleanup patch?
>
> I will send a patch to clean up. Thanks everyone to review this patchset.

Well, thanks for doing the work :).
