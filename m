Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F148C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56E02133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56E02133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeIMABS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:01:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbeIMABS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:01:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1ECFACD1;
        Wed, 12 Sep 2018 18:55:25 +0000 (UTC)
Date:   Wed, 12 Sep 2018 11:55:17 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Eugene Korenevsky <ekorenevsky@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] efi: take size of partition entry from GPT header
Message-ID: <20180912185517.GE3902@linux-r8p5>
References: <20180912183519.GA31506@vnote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180912183519.GA31506@vnote>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Eugene Korenevsky wrote:
> /**
>  * efi_partition(struct parsed_partitions *state)
>  * @state: disk parsed partitions
>@@ -704,32 +710,36 @@ int efi_partition(struct parsed_partitions *state)
>
> 	pr_debug("GUID Partition Table is valid!  Yea!\n");
>
>-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
>+	for (i = 0;
>+	     i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1;
>+	     i++) {

Please rearrange this like:

       for (i = 0;  < le32_to_cpu(gpt->num_partition_entries) &&
       	      	      i < state->limit-1; i++)

>+		gpt_entry *pte = get_gpt_entry(gpt, ptes, i);
> 		struct partition_meta_info *info;
> 		unsigned label_count = 0;
> 		unsigned label_max;
>-		u64 start = le64_to_cpu(ptes[i].starting_lba);
>-		u64 size = le64_to_cpu(ptes[i].ending_lba) -
>-			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
>+		u64 start = le64_to_cpu(pte->starting_lba);
>+		u64 size = le64_to_cpu(pte->ending_lba) -
>+			   le64_to_cpu(pte->starting_lba) + 1ULL;
>
>-		if (!is_pte_valid(&ptes[i], last_lba(state->bdev)))
>+		if (!is_pte_valid(pte, last_lba(state->bdev)))
> 			continue;
>
> 		put_partition(state, i+1, start * ssz, size * ssz);
>
> 		/* If this is a RAID volume, tell md */
>-		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
>+		if (!efi_guidcmp(
>+		    pte->partition_type_guid, PARTITION_LINUX_RAID_GUID))

This is ugly. If you are worried about 80-chars, please do:

     	      	 if (!efi_guidcmp(pte->partition_type_guid,
				PARTITION_LINUX_RAID_GUID))

Thanks,
Davidlohr
