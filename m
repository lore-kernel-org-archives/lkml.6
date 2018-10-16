Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811AAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F15205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pDyM+N3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F15205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeJQBbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:31:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45314 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJQBbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:31:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id j4-v6so21708716ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CW3fizjK+uSps4gcbmeTOTp5t8eAV7kn765UhydQxMQ=;
        b=pDyM+N3gudvSeTUY6ILaaP2YWhklhl65BCNWJJRxyoTOK4n/YP/eWvK1SofFZDn84U
         ikQVO6oi+rmraSGWrAXOnf25yyY7cBgFC0A5OV2dx3pEQz3oKQC4fbNmSE50rG5VXCT0
         WHYfpxJyyBpL+UL2gCOcgLCLf7Nh6r0lGKQFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CW3fizjK+uSps4gcbmeTOTp5t8eAV7kn765UhydQxMQ=;
        b=oGqbbxNwsSKLJmXNB3+dfL87LDTVYKmLnBn/CfUFmSEK2kjIQQB4hkEz/PHvEyXBYG
         RWjcw5BRCkGV4G+oFfKy9kLHciXtWvc0AZx3XfY7DNl4Na2oj1aFWnw26mkv/4/e4FWF
         A/aPoKtretJZccr0rcOT9TdTWt/+OYJoCuk0C0z4imT1DyXY8bM7ynud/LoNND9Br1A8
         V3Q52S75kTT7BW8VIBXed1GDvd56X2tX4MfrQ2aBNZc/ah76NPMhiLNoriqs2gEZEv/W
         YuWMV/7XCrib9TipkhnOhaqFNbw0KYIOz60uMeD2V1pbxEEUQKA2kL3L/xXyI5p4qYTZ
         rYvw==
X-Gm-Message-State: ABuFfoh8AR4a2EzkWKb5rK9VgRGUnYBUN6d10WVbXwd5STNSMlFuvvsR
        Qj8fljTNaMGw9QmayX0eb3hQOvabv/Vj/KHGoxUK7Q==
X-Google-Smtp-Source: ACcGV63a3pfV/IFBTeGN+2fgxoBEdE/wbes6VMgrI58+PEY/urHB9sC678HQEZl2RTg9/1njYf+5WmyqtlsOPkX1nRU=
X-Received: by 2002:a2e:3211:: with SMTP id y17-v6mr15748787ljy.39.1539711598748;
 Tue, 16 Oct 2018 10:39:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8e91:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 10:39:57
 -0700 (PDT)
In-Reply-To: <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com> <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 16 Oct 2018 10:39:57 -0700
Message-ID: <CAEXW_YQFs9mcw5Qv04ZRv=ZAK7YeBLJKByQxXYLj34iigS-Q=Q@mail.gmail.com>
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:31 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Oct 12, 2018 at 03:54:27AM -0700, Daniel Colascione wrote:
>> The map-in-map frequently serves as a mechanism for atomic
>> snapshotting of state that a BPF program might record.  The current
>> implementation is dangerous to use in this way, however, since
>> userspace has no way of knowing when all programs that might have
>> retrieved the "old" value of the map may have completed.
>>
>> This change ensures that map update operations on map-in-map map types
>> always wait for all references to the old map to drop before returning
>> to userspace.
>>
>> Signed-off-by: Daniel Colascione <dancol@google.com>
>> ---
>>  kernel/bpf/syscall.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 8339d81cba1d..d7c16ae1e85a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -741,6 +741,18 @@ static int map_lookup_elem(union bpf_attr *attr)
>>       return err;
>>  }
>>
>> +static void maybe_wait_bpf_programs(struct bpf_map *map)
>> +{
>> +     /* Wait for any running BPF programs to complete so that
>> +      * userspace, when we return to it, knows that all programs
>> +      * that could be running use the new map value.
>> +      */
>> +     if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
>> +         map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
>> +             synchronize_rcu();
>> +     }
>
> extra {} were not necessary. I removed them while applying to bpf-next.
> Please run checkpatch.pl next time.
> Thanks

Thanks Alexei for taking it. Me and Lorenzo were discussing that not
having this causes incorrect behavior for apps using map-in-map for
this. So I CC'd stable as well.

-Joel
