Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFBC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3AD20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/ievZ/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3AD20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeILEBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:01:19 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:55463 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeILEBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:01:19 -0400
Received: by mail-it0-f43.google.com with SMTP id d10-v6so494608itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=I5ESdrhipRbibVthHVriYBdDUSjfzWMwFQGQJ70RB5Y=;
        b=E/ievZ/BGH/EEOEmveCta2cby1N413pYyxD4+O0H3n25Y2iNQlKrI00uWEqTXnKrjR
         xEy/Q4EIgDV6S14c62vgrHVXY7u7eApk8nk6dKY1Rx6+IzIbN6UH/UySvSXxMLpeJpOE
         HDWDYFARgvBJJ4V+qJuHOekVVlPtZOiWytYvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=I5ESdrhipRbibVthHVriYBdDUSjfzWMwFQGQJ70RB5Y=;
        b=enkqrmPKrl4ARREIYayIG+mvHdEYwqPODduhRPcf4ytMK8ilBY2oMbFFgg23ogop86
         TBBtEY5OoimhS0DQroLeQMrcKnw3TnZ+huoATsUrtTxbbAo5bcsmqjDJaY/gRGV8Vxjc
         GErnLAUDxzXGCGT5zUFzB9h8pFkHx67eu7zVtz421VDrlxgWEc2DdBOQCK4hPKDe+s49
         o+eOi12bnDwLVMYnkRus6WmQQzcYBlDpTuF4F/jxYqsQNkW1VtYJcXhTCUGWtX/9qvP2
         xe2JjpMZekJENZAH9Wk87FkstUk1vrWs/6bYlpWurzk981udYFmkilEZIYcXnUSGP6s6
         wMYA==
X-Gm-Message-State: APzg51B396ZmmPSKUxVKKkJLRcMQk2xa2Uwi2IIYWkO6cYNXA2+mUdgj
        0AMyYOMjoaRSLuzuvqyi+JtVj2t4l4KqAy+HzZaE7w==
X-Google-Smtp-Source: ANB0VdZLBTNeOZNAS94JakvnViBPEL93rHYntOJJRi2NWLV3TOx1OwnpH0tONqevNU7wCRNEgSCLt1DkoUra0JlsvcU=
X-Received: by 2002:a24:52cd:: with SMTP id d196-v6mr3590611itb.58.1536706788739;
 Tue, 11 Sep 2018 15:59:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 15:59:47
 -0700 (PDT)
In-Reply-To: <20180911161527.GA30689@vnote>
References: <20180911161527.GA30689@vnote>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Sep 2018 00:59:47 +0200
Message-ID: <CAKv+Gu_-tO0cCDb+iur8-EymOVQ23v9UOBZVMync_fEhQrXVRg@mail.gmail.com>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
To:     Eugene Korenevsky <ekorenevsky@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 September 2018 at 18:15, Eugene Korenevsky <ekorenevsky@gmail.com> wrote:
> Use gpt_header.sizeof_partition_entry instead of sizeof(gpt_entry)
> for GPT entry size.
> According to UEFI 2.7 spec 5.3.1 "GPT overview":, the size of a GUID Partition
> Entry element is defined in the Size Of Partition Entry field of GPT header.
> The GPT with entries sized more than sizeof(gpt_entry) is not illegal.
> OVMF firmware from EDK2 perfectly works with it, see edk2-tianocore source
> code.
>
> Changes since v1: refactoring (extract get_gpt_entry function),
>                     fix (&ptes[i] -> pte)
>
> Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
> ---
>  block/partitions/efi.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index 39f70d968754..724f7c0805a2 100644
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

As I asked you before, can we keep this sanity check but change != to < ?

>         /* Sanity check partition table size */
>         pt_size = (u64)le32_to_cpu((*gpt)->num_partition_entries) *
> @@ -670,6 +665,11 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>          return 0;
>  }
>
> +static gpt_entry *get_gpt_entry(gpt_header *gpt_hdr, gpt_entry *ptes, u32 index)
> +{
> +       return (gpt_entry *)((u8 *)ptes + gpt->sizeof_partition_entry * index);
> +}
> +
>  /**
>   * efi_partition(struct parsed_partitions *state)
>   * @state: disk parsed partitions
> @@ -704,32 +704,36 @@ int efi_partition(struct parsed_partitions *state)
>
>         pr_debug("GUID Partition Table is valid!  Yea!\n");
>
> -       for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
> +       for (i = 0;
> +            i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1;
> +            i++) {
> +               gpt_entry *pte = get_gpt_entry(gpt, ptes, i);
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
> -               if (!is_pte_valid(&ptes[i], last_lba(state->bdev)))
> +               if (!is_pte_valid(pte, last_lba(state->bdev)))
>                         continue;
>
>                 put_partition(state, i+1, start * ssz, size * ssz);
>
>                 /* If this is a RAID volume, tell md */
> -               if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
> +               if (!efi_guidcmp(
> +                   pte->partition_type_guid, PARTITION_LINUX_RAID_GUID))
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
>
