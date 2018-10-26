Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF21ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8287820868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZGyoEaCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8287820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJ0EAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:00:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45379 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJ0EAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:00:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so923621pll.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eo0vcqONOfBYtL2br2fCs6mUR8pZypj8dvOgPv2x2lw=;
        b=ZGyoEaCK50tHHVMbJLSn8r+XFQuT3vdT+VVUOgk5XKpNRsGMp5XalOk0JRYoiJ/hPg
         jKDm2f2aTLSB7YmhF4raKMBS5pG7VakV++GFHlrD3xP10lgw8iI3dZrKA3L7eAT4LVrH
         womukEjf+Q6Inj+HMUSmLMOvwiRghFI28ARUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eo0vcqONOfBYtL2br2fCs6mUR8pZypj8dvOgPv2x2lw=;
        b=E0n9aq0Q8xQGCRN7quER/l3Q3CEacESi04aRXWpV7g8Di2PbUGhmxyk4SHzdpEGt2v
         W7CRwGP/+AL6wxj227qrwwgUVZcUW7CjHFTujfuiKJTtGYEsgEkzqLYTjB5i4sLUHk9P
         X7U4xLycX0OXoJUV3hhCBX30GrHZrsEpB0kRVu5AUQOXBzPnBi9b6xxLV5NxlaK10qsS
         pqziex4/wgUVWuR9jUZUKlKXn07eJ2olPZxt13L9TUlos+P41zC87WpvNzzV1wgIZaGO
         A5nsOh84jb+bxW53N2umY6lLIB6q9Mln3APDxKG3egrbUhcVmOpSt5dVqdNcaxhYeJK/
         Rvgg==
X-Gm-Message-State: AGRZ1gK0xqp7VF7yWdpateSEyNP7hi3dvTYq1FCz53pzLCpUwlAohG8D
        SDUEyNVJ02LOM6YFwlA+xRaaZQIar3w=
X-Google-Smtp-Source: AJdET5ftQeiLmW6HEKg9A5/tVgM19L2SM32YWwBR8iV7XCfh1oMxuzi63S5uc+rVuxgpPxj1KuKhqw==
X-Received: by 2002:a17:902:780f:: with SMTP id p15-v6mr4647143pll.197.1540581728277;
        Fri, 26 Oct 2018 12:22:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q25-v6sm24715028pfk.154.2018.10.26.12.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:22:07 -0700 (PDT)
Date:   Fri, 26 Oct 2018 12:22:06 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC 3/6] pstore: remove max argument from ramoops_get_next_prz
Message-ID: <20181026192206.GC187415@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <20181026180042.52199-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026180042.52199-3-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:00:39AM -0700, Joel Fernandes (Google) wrote:
> From the code flow, the 'max' checks are already being done on the prz
> passed to ramoops_get_next_prz. Lets remove it to simplify this function
> and reduce its arguments.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/pstore/ram.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index cbfdf4b8e89d..3055e05acab1 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -124,14 +124,14 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>  }
>  
>  static struct persistent_ram_zone *
> -ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
> +ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
>  		     u64 *id, enum pstore_type_id *typep, bool update)
>  {
>  	struct persistent_ram_zone *prz;
>  	int i = (*c)++;
>  
>  	/* Give up if we never existed or have hit the end. */
> -	if (!przs || i >= max)
> +	if (!przs)
>  		return NULL;
>  
>  	prz = przs[i];

Ah, looks like I may have introduced an issue here since 'i' isn't checked by
the caller for the single prz case, its only checked for the multiple prz
cases, so something like below could be folded in. I still feel its better
than passing the max argument.

Another thought is, even better we could have a different function when
there's only one prz and not have to pass an array, just pass the first
element? Something like...

ramoops_get_next_prz_single(struct persistent_ram_zone *prz, uint *c,
	  		    enum pstore_type_id *typep, bool update)
And for the _single  case, we also wouldn't need to pass id so that's another
argument less.

Let me know what you think, otherwise something like the below will need to
be folded in to fix this patch... thanks.

----8<---

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 5702b692bdb9..061d2af2485b 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -268,17 +268,19 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 		}
 	}
 
-	if (!prz_ok(prz))
+	if (!prz_ok(prz) && !cxt->console_read_cnt) {
 		prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
 					   record, 0);
+	}
 
-	if (!prz_ok(prz))
+	if (!prz_ok(prz) && !cxt->pmsg_read_cnt)
 		prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
 					   record, 0);
 
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
-		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
+		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU) &&
+		    !cxt->ftrace_read_cnt) {
 			prz = ramoops_get_next_prz(cxt->fprzs,
 					&cxt->ftrace_read_cnt, record, 0);
 		} else {
