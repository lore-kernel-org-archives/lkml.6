Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6883320866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGhEv/hF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6883320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbeIKA0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:26:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51489 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeIKA0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:26:39 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so31120908itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=jE6dzmo2fE/yaOhHiGue+E/leNX73Knb17dB+41JYpA=;
        b=eGhEv/hFBOThchr66aeDGMW1PVuFUUUfFFbIh15/gRRYkeBW693+VVNZsKXb975ZTK
         qJ5OOyGlYyzCbtUXHAUnpoVIlvUoizzyM9UkB38a8IrgkZF425NS7Pj9KVPxwPqoIQ/J
         RHpZB2WEz3Cp2MMycvluJycS6F2eLoMvSkMXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=jE6dzmo2fE/yaOhHiGue+E/leNX73Knb17dB+41JYpA=;
        b=dGgEIo1+K8x3eMcBG7akQWiYjB3vEE/89muAjzS37Reqnf8nwcofDpvw2g7pHLRwMG
         6tJtC6Y6LQ6y6UCbCrxNB8HGVBwSh603a/NMfcBYRSjq/YrqEc6R479m4W2cQvou6PWZ
         65zHqr6h3ZbuMemEQCu4Bt34eTLMyx3OP46cH0hOyg0xfRN7y/1bcah6xSx/PniGDY6W
         4f4qZcIkyqTDUBnA7qE75Hg9e2m5mPKpMxkB5scDfHVhjRpyLLlWEx1cAs25Y19iuM58
         IFf8tT8NuLhmjBLtsyexLuWsAkcMdkTZl1n8MmmL0P8ySFpzArviFF/uE2N53EwtMDWw
         Jr5g==
X-Gm-Message-State: APzg51CLVjFY8+yq5R+GGPJgfdS7ueLrHdU+qO2FOIliMMynS/CIqH9T
        ZndNApsHMSb2GbGOR0PvDVTINAf5ilBphY5wDZNnFg==
X-Google-Smtp-Source: ANB0VdaJSXWJflQsTEuN3cPyPsl0PoSkGWrsLstqo/R9VpMKmZRKluLVZaBEZNThCNus/XxPv8lfzZjGVi9hqRiFD7g=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr19303928ita.148.1536607862941;
 Mon, 10 Sep 2018 12:31:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 12:31:02
 -0700 (PDT)
In-Reply-To: <20180910190355.GA2166@vnote>
References: <20180910190355.GA2166@vnote>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Sep 2018 21:31:02 +0200
Message-ID: <CAKv+Gu_Di8sb6g1Hm3zoih-031Y1yORwXxd+Te68-2PeUioTiQ@mail.gmail.com>
Subject: Re: [PATCH] efi: take size of partition entry from GPT header
To:     Eugene Korenevsky <ekorenevsky@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 September 2018 at 21:03, Eugene Korenevsky <ekorenevsky@gmail.com> wrote:
> Use gpt_header.sizeof_partition_entry instead of sizeof(gpt_entry)
> for GPT entry size.
> According to UEFI spec, GPT entry size is specified in GPT header.
>

I think this patch is probably correct, but could you please provide
more information:
- why do you need this patch
- which UEFI spec section/paragraph are you quoting


> Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
> ---
>  block/partitions/efi.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index 39f70d968754..29f7ec585e1d 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -428,11 +428,6 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
>                          (unsigned long long)le64_to_cpu((*gpt)->first_usable_lba));
>                 goto fail;
>         }
> -       /* Check that sizeof_partition_entry has the correct value */
> -       if (le32_to_cpu((*gpt)->sizeof_partition_entry) != sizeof(gpt_entry)) {
> -               pr_debug("GUID Partition Entry Size check failed.\n");
> -               goto fail;
> -       }
>

Shouldn't we assert that sizeof_partition_entry >= sizeof(gpt_entry) ?

>         /* Sanity check partition table size */
>         pt_size = (u64)le32_to_cpu((*gpt)->num_partition_entries) *
> @@ -692,7 +687,7 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>  int efi_partition(struct parsed_partitions *state)
>  {
>         gpt_header *gpt = NULL;
> -       gpt_entry *ptes = NULL;
> +       gpt_entry *ptes = NULL, *pte;
>         u32 i;
>         unsigned ssz = bdev_logical_block_size(state->bdev) / 512;
>
> @@ -704,13 +699,16 @@ int efi_partition(struct parsed_partitions *state)
>
>         pr_debug("GUID Partition Table is valid!  Yea!\n");
>
> -       for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
> +       pte = ptes;
> +       for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1;
> +                       i++,
> +                       pte = (gpt_entry *)((u8*)pte + gpt->sizeof_partition_entry)) {
>                 struct partition_meta_info *info;
>                 unsigned label_count = 0;
>                 unsigned label_max;
> -               u64 start = le64_to_cpu(ptes[i].starting_lba);
> -               u64 size = le64_to_cpu(ptes[i].ending_lba) -
> -                          le64_to_cpu(ptes[i].starting_lba) + 1ULL;
> +               u64 start = le64_to_cpu(pte->starting_lba);
> +               u64 size = le64_to_cpu(pte->ending_lba) -
> +                          le64_to_cpu(pte->starting_lba) + 1ULL;
>
>                 if (!is_pte_valid(&ptes[i], last_lba(state->bdev)))
>                         continue;
> @@ -718,18 +716,18 @@ int efi_partition(struct parsed_partitions *state)
>                 put_partition(state, i+1, start * ssz, size * ssz);
>
>                 /* If this is a RAID volume, tell md */
> -               if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
> +               if (!efi_guidcmp(pte->partition_type_guid, PARTITION_LINUX_RAID_GUID))
>                         state->parts[i + 1].flags = ADDPART_FLAG_RAID;
>
>                 info = &state->parts[i + 1].info;
> -               efi_guid_to_str(&ptes[i].unique_partition_guid, info->uuid);
> +               efi_guid_to_str(&pte->unique_partition_guid, info->uuid);
>
>                 /* Naively convert UTF16-LE to 7 bits. */
>                 label_max = min(ARRAY_SIZE(info->volname) - 1,
> -                               ARRAY_SIZE(ptes[i].partition_name));
> +                               ARRAY_SIZE(pte->partition_name));
>                 info->volname[label_max] = 0;
>                 while (label_count < label_max) {
> -                       u8 c = ptes[i].partition_name[label_count] & 0xff;
> +                       u8 c = pte->partition_name[label_count] & 0xff;
>                         if (c && !isprint(c))
>                                 c = '!';
>                         info->volname[label_count] = c;
> --
> 2.18.0
