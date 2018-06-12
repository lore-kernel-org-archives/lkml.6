Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EE4BAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6D0208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4MlTfRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6D0208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934742AbeFLAYw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:24:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33492 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934597AbeFLAYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:24:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id n10-v6so13283765plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISQzOmoVgCrBYMXYklvRZPzPHIXGQRpBlkn9pl4p0D0=;
        b=Q4MlTfRPbUP3/+FA2OZZhjXIpjAu4zkYKjFAY8n/xxCjXZ+5FRXCbDnJoIodTWSzdj
         XnbJepk25sesbvWFgHP1meTS2OCkA46aO/Pp0aP88xe1zfMREj1qcLUM6CIJhzANk+j1
         p56CEdXwLkV8GnCwyWMtLzNID5ns+5vJBhQhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISQzOmoVgCrBYMXYklvRZPzPHIXGQRpBlkn9pl4p0D0=;
        b=ngDedCS4r2TYT7XQPGkBnhMMBnV2TVy28AyYnAgfLCPK6flx9UKdfiPfLPEUy0yUSJ
         f6GUvdxlrSfdBarjaU+dhBvd5drYdB+vettJ+e4b9oumGU6SAM1JqSDP59iAxU1tBBJn
         UyEm7YpAAfaDzI4EBrBfDWkmn6aaMkDZlkKX3XVlnQq9An+wBdKt5gfyF27A/oQY+eeV
         DEmCIRpgWc3iGDum5oEK1SFkzqbpHrg9kGuW54FWaWgCvoz/aQZRTT2PBeo4IG9x71+C
         13QBn42YuRFBbA3ujY/V1yqqsONj10UWw3rnbxaEUQfCqw/+MC3ZX5zYVeZNxM3v1/Bm
         d0xw==
X-Gm-Message-State: APt69E2QncZDQt0TAHcAga6aJge7LzCl65MReHq89N9b1hjSDy5ovV8I
        i/u5qhWf6U+hhG8EZAn8upLHyA==
X-Google-Smtp-Source: ADUXVKJkGutwX4eXLac1h/7v7f04oXr2Gva3FriDJgBk4My5FPRt0XBbQnII/aK8/3/WiM7JwI9K/A==
X-Received: by 2002:a17:902:1002:: with SMTP id b2-v6mr1414166pla.344.1528763089530;
        Mon, 11 Jun 2018 17:24:49 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b74-v6sm95368888pfl.138.2018.06.11.17.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 17:24:48 -0700 (PDT)
Date:   Mon, 11 Jun 2018 17:24:46 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ramon Fried <ramon.fried@gmail.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smem: fix checkpatch warnings
Message-ID: <20180612002446.GL14924@minitux>
References: <20180611220835.11129-1-ramon.fried@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611220835.11129-1-ramon.fried@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Jun 15:08 PDT 2018, Ramon Fried wrote:

> * Fixed checkpatch.sh warnings in smem.c & smem.h:
> - WARNING: Prefer 'unsigned int' to bare use of 'unsigned'.
> - WARNING: Block comments should align the * on each line.
> - WARNING: line over 80 characters.
> - ERROR: do not use assignment in if condition.
> 
> * Fixed grammar in comment.
> 
> Signed-off-by: Ramon Fried <ramon.fried@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smem.c       | 41 +++++++++++++++++++----------------
>  include/linux/soc/qcom/smem.h |  6 ++---
>  2 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 0b94d62fad2b..e5ef6611ed73 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -22,7 +22,7 @@
>  #include <linux/soc/qcom/smem.h>
>  
>  /*
> - * The Qualcomm shared memory system is a allocate only heap structure that
> + * The Qualcomm shared memory system is an allocate only heap structure that
>   * consists of one of more memory areas that can be accessed by the processors
>   * in the SoC.
>   *
> @@ -94,11 +94,11 @@
>  #define SMEM_HOST_COUNT		10
>  
>  /**
> -  * struct smem_proc_comm - proc_comm communication struct (legacy)
> -  * @command:	current command to be executed
> -  * @status:	status of the currently requested command
> -  * @params:	parameters to the command
> -  */
> + * struct smem_proc_comm - proc_comm communication struct (legacy)
> + * @command:	current command to be executed
> + * @status:	status of the currently requested command
> + * @params:	parameters to the command
> + */
>  struct smem_proc_comm {
>  	__le32 command;
>  	__le32 status;
> @@ -276,7 +276,7 @@ struct qcom_smem {
>  	size_t cacheline[SMEM_HOST_COUNT];
>  	u32 item_count;
>  
> -	unsigned num_regions;
> +	unsigned int num_regions;
>  	struct smem_region regions[0];
>  };
>  
> @@ -350,7 +350,7 @@ static struct qcom_smem *__smem;
>  
>  static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  				   struct smem_partition_header *phdr,
> -				   unsigned item,
> +				   unsigned int item,
>  				   size_t size)
>  {
>  	struct smem_private_entry *hdr, *end;
> @@ -400,7 +400,7 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  }
>  
>  static int qcom_smem_alloc_global(struct qcom_smem *smem,
> -				  unsigned item,
> +				  unsigned int item,
>  				  size_t size)
>  {
>  	struct smem_global_entry *entry;
> @@ -441,7 +441,7 @@ static int qcom_smem_alloc_global(struct qcom_smem *smem,
>   * Allocate space for a given smem item of size @size, given that the item is
>   * not yet allocated.
>   */
> -int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
> +int qcom_smem_alloc(unsigned int host, unsigned int item, size_t size)
>  {
>  	struct smem_partition_header *phdr;
>  	unsigned long flags;
> @@ -482,14 +482,14 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
>  EXPORT_SYMBOL(qcom_smem_alloc);
>  
>  static void *qcom_smem_get_global(struct qcom_smem *smem,
> -				  unsigned item,
> +				  unsigned int item,
>  				  size_t *size)
>  {
>  	struct smem_header *header;
>  	struct smem_region *area;
>  	struct smem_global_entry *entry;
>  	u32 aux_base;
> -	unsigned i;
> +	unsigned int i;
>  
>  	header = smem->regions[0].virt_base;
>  	entry = &header->toc[item];
> @@ -514,7 +514,7 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
>  static void *qcom_smem_get_private(struct qcom_smem *smem,
>  				   struct smem_partition_header *phdr,
>  				   size_t cacheline,
> -				   unsigned item,
> +				   unsigned int item,
>  				   size_t *size)
>  {
>  	struct smem_private_entry *e, *end;
> @@ -575,7 +575,7 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
>   * Looks up smem item and returns pointer to it. Size of smem
>   * item is returned in @size.
>   */
> -void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
> +void *qcom_smem_get(unsigned int host, unsigned int item, size_t *size)
>  {
>  	struct smem_partition_header *phdr;
>  	unsigned long flags;
> @@ -621,11 +621,11 @@ EXPORT_SYMBOL(qcom_smem_get);
>   * To be used by smem clients as a quick way to determine if any new
>   * allocations has been made.
>   */
> -int qcom_smem_get_free_space(unsigned host)
> +int qcom_smem_get_free_space(unsigned int host)
>  {
>  	struct smem_partition_header *phdr;
>  	struct smem_header *header;
> -	unsigned ret;
> +	unsigned int ret;
>  
>  	if (!__smem)
>  		return -EPROBE_DEFER;
> @@ -902,9 +902,12 @@ static int qcom_smem_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (num_regions > 1 && (ret = qcom_smem_map_memory(smem, &pdev->dev,
> -					"qcom,rpm-msg-ram", 1)))
> -		return ret;
> +	if (num_regions > 1) {
> +		ret = qcom_smem_map_memory(smem, &pdev->dev,
> +					"qcom,rpm-msg-ram", 1);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	header = smem->regions[0].virt_base;
>  	if (le32_to_cpu(header->initialized) != 1 ||
> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> index c1657ed27b30..d0e8783bccff 100644
> --- a/include/linux/soc/qcom/smem.h
> +++ b/include/linux/soc/qcom/smem.h
> @@ -4,9 +4,9 @@
>  
>  #define QCOM_SMEM_HOST_ANY -1
>  
> -int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
> -void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
> +int qcom_smem_alloc(unsigned int host, unsigned int item, size_t size);
> +void *qcom_smem_get(unsigned int host, unsigned int item, size_t *size);
>  
> -int qcom_smem_get_free_space(unsigned host);
> +int qcom_smem_get_free_space(unsigned int host);
>  
>  #endif
> -- 
> 2.17.1
> 
