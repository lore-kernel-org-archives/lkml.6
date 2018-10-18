Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C54C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E57D2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr83aeJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E57D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeJRVIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbeJRVIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:08:47 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33F22098A;
        Thu, 18 Oct 2018 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539868069;
        bh=G3gtXDx0DyheQREjb6inJKTvCtavLKIEgrO1ARTyJ9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sr83aeJAAfCBgNM4hpnBAyhES9SzkSoBryCYDrgtlOr3W9628DVAYqQNxfk+EAwFb
         SRchYgMUf2aN1fBZuUppAurL4qEbx1fSlyuJk0dCJeb1TWKh/1NOm2wEuf9q/k8HZU
         Nu5UAqg+pH8LYzL07huDCN2aEqJeSwkkTH9NEpNY=
Date:   Thu, 18 Oct 2018 22:07:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vgar.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 1/3] tracing: Fix synthetic event to accept unsigned
 modifier
Message-Id: <20181018220747.1528b2dc7515878b10f16607@kernel.org>
In-Reply-To: <153986469515.1671.2442221440653629796.stgit@devbox>
References: <153986466551.1671.11399119973192957474.stgit@devbox>
        <153986469515.1671.2442221440653629796.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 21:11:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix synthetic event to accept unsigned modifier for its field type
> correctly.
> 
> Currently, synthetic_events interface returns error for "unsigned"
> modifiers as below;
> 
>  # echo "myevent unsigned long var" >> synthetic_events
>  sh: write error: Invalid argument
> 
> This is because argv_split() breaks "unsigned long" into "unsigned"
> and "long", but parse_synth_field() doesn't expected it.
> 
> With this fix, synthetic_events can handle the "unsigned long"
> correctly like as below;
> 
>  # echo "myevent unsigned long var" >> synthetic_events
>  # cat synthetic_events
>  myevent	unsigned long var
> 
> Fixes: commit 4b147936fa50 ("tracing: Add support for 'synthetic' events")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: <stable@vgar.kernel.org>

Oops, I typo it... will resend v2 soon.

Thanks,


> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c |   30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 85f6b01431c7..6ff83941065a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -738,16 +738,30 @@ static void free_synth_field(struct synth_field *field)
>  	kfree(field);
>  }
>  
> -static struct synth_field *parse_synth_field(char *field_type,
> -					     char *field_name)
> +static struct synth_field *parse_synth_field(int argc, char **argv,
> +					     int *consumed)
>  {
>  	struct synth_field *field;
> +	const char *prefix = NULL;
> +	char *field_type = argv[0], *field_name;
>  	int len, ret = 0;
>  	char *array;
>  
>  	if (field_type[0] == ';')
>  		field_type++;
>  
> +	if (!strcmp(field_type, "unsigned")) {
> +		if (argc < 3)
> +			return ERR_PTR(-EINVAL);
> +		prefix = "unsigned ";
> +		field_type = argv[1];
> +		field_name = argv[2];
> +		*consumed = 3;
> +	} else {
> +		field_name = argv[1];
> +		*consumed = 2;
> +	}
> +
>  	len = strlen(field_name);
>  	if (field_name[len - 1] == ';')
>  		field_name[len - 1] = '\0';
> @@ -760,11 +774,15 @@ static struct synth_field *parse_synth_field(char *field_type,
>  	array = strchr(field_name, '[');
>  	if (array)
>  		len += strlen(array);
> +	if (prefix)
> +		len += strlen(prefix);
>  	field->type = kzalloc(len, GFP_KERNEL);
>  	if (!field->type) {
>  		ret = -ENOMEM;
>  		goto free;
>  	}
> +	if (prefix)
> +		strcat(field->type, prefix);
>  	strcat(field->type, field_type);
>  	if (array) {
>  		strcat(field->type, array);
> @@ -1009,7 +1027,7 @@ static int create_synth_event(int argc, char **argv)
>  	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
>  	struct synth_event *event = NULL;
>  	bool delete_event = false;
> -	int i, n_fields = 0, ret = 0;
> +	int i, consumed = 0, n_fields = 0, ret = 0;
>  	char *name;
>  
>  	mutex_lock(&synth_event_mutex);
> @@ -1061,13 +1079,13 @@ static int create_synth_event(int argc, char **argv)
>  			goto err;
>  		}
>  
> -		field = parse_synth_field(argv[i], argv[i + 1]);
> +		field = parse_synth_field(argc - i, &argv[i], &consumed);
>  		if (IS_ERR(field)) {
>  			ret = PTR_ERR(field);
>  			goto err;
>  		}
> -		fields[n_fields] = field;
> -		i++; n_fields++;
> +		fields[n_fields++] = field;
> +		i += consumed - 1;
>  	}
>  
>  	if (i < argc) {
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
