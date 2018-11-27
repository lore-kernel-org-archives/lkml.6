Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC46C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4942081B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKd1v9G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4942081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeK0XkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbeK0XkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:40:18 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD922081B;
        Tue, 27 Nov 2018 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322548;
        bh=YwkElLOiBE9v5V1LXEiSVsk2Eq5ZOo/FFSOPvwGDpq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKd1v9G/B6phn6lR4dPhT5KeCS5UUNbqjc0uKqcpwicxFKT7UHiTXl04mhScYSnMP
         Nqbpp2ZDVodTCbhmgtwkCSQlDrS8p4m/qWpC9iiPhjPWIKCjuPA+hydITBpGKrtlVR
         QcWnDNS+2PNbkiAJw0FrNYSEqDJOBGYRySX3Cqsk=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 4199C41114; Tue, 27 Nov 2018 09:42:26 -0300 (-03)
Date:   Tue, 27 Nov 2018 09:42:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Alter addr_filter__entire_dso() to work
 if there are no symbols
Message-ID: <20181127124226.GC15747@kernel.org>
References: <20181127084634.12469-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127084634.12469-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 27, 2018 at 10:46:34AM +0200, Adrian Hunter escreveu:
> addr_filter__entire_dso() uses the first and last symbols from a dso,
> and so does not work when there are no symbols.  Alter it to filter the
> whole file instead.

I'm splitting this patch into a first prep one that renames and exports
the static function dso__data_file_size() and a second that does what
this commig log message states.

The reason is that sometimes we find out that the main part of the patch
is wrong and we then decide to revert the patch, only to realize that
the exported function is by that time already used elsewhere.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 11 ++++-------
>  tools/perf/util/dso.c      |  6 +++---
>  tools/perf/util/dso.h      |  1 +
>  3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 72d5ba2479bf..f69961c4a4f3 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1983,17 +1983,14 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
>  
>  static int addr_filter__entire_dso(struct addr_filter *filt, struct dso *dso)
>  {
> -	struct symbol *first_sym = dso__first_symbol(dso);
> -	struct symbol *last_sym = dso__last_symbol(dso);
> -
> -	if (!first_sym || !last_sym) {
> -		pr_err("Failed to determine filter for %s\nNo symbols found.\n",
> +	if (dso__data_file_size(dso, NULL)) {
> +		pr_err("Failed to determine filter for %s\nCannot determine file size.\n",
>  		       filt->filename);
>  		return -EINVAL;
>  	}
>  
> -	filt->addr = first_sym->start;
> -	filt->size = last_sym->end - first_sym->start;
> +	filt->addr = 0;
> +	filt->size = dso->data.file_size;
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index bbed90e5d9bb..721f3d583945 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -894,7 +894,7 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
>  	return r;
>  }
>  
> -static int data_file_size(struct dso *dso, struct machine *machine)
> +int dso__data_file_size(struct dso *dso, struct machine *machine)
>  {
>  	int ret = 0;
>  	struct stat st;
> @@ -943,7 +943,7 @@ static int data_file_size(struct dso *dso, struct machine *machine)
>   */
>  off_t dso__data_size(struct dso *dso, struct machine *machine)
>  {
> -	if (data_file_size(dso, machine))
> +	if (dso__data_file_size(dso, machine))
>  		return -1;
>  
>  	/* For now just estimate dso data size is close to file size */
> @@ -953,7 +953,7 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
>  static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
>  				u64 offset, u8 *data, ssize_t size)
>  {
> -	if (data_file_size(dso, machine))
> +	if (dso__data_file_size(dso, machine))
>  		return -1;
>  
>  	/* Check the offset sanity. */
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index c5380500bed4..8c8a7abe809d 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -322,6 +322,7 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine);
>  void dso__data_put_fd(struct dso *dso);
>  void dso__data_close(struct dso *dso);
>  
> +int dso__data_file_size(struct dso *dso, struct machine *machine);
>  off_t dso__data_size(struct dso *dso, struct machine *machine);
>  ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
>  			      u64 offset, u8 *data, ssize_t size);
> -- 
> 2.17.1

-- 

- Arnaldo
