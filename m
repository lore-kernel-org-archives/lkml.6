Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E92C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0789020881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548889401;
	bh=WB9YTB3IGDqXlagMfR3MgcyVEbCXaUNE9pb9x2wIap4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XbNMa5qimkstLoo99Bl5/aakHTpmD3c7o3URpPd8N1KdicWNCn81z+f+j1YCT79at
	 PYhLpdWkw/U9s3v+UctBUp52j2gTTfL0M5YtUFHLQKwKJm1zD03v9ZOrn1vOpS/aTz
	 7ai1nbKmkdY6Ia5TdkdWwWJs4+3LMb511p5dKC/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfA3XDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:03:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47085 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfA3XDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:03:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so1125429otm.13;
        Wed, 30 Jan 2019 15:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmpQdef8f038zp00bn5PgvnDguDchYKFykOeFqHWKXM=;
        b=lX40XB9wFgsmemoWl22uQ2P97qMHjOvUGKAHTGGU//Y0YLIs026x7JgfEQPqlL6K7D
         LqSM/vGrx7vXWWileHeQsBaG8+9Hz67iptGdaLfs/cySxHG1VpoTSYk97Ug9mzvDN2Mu
         zpUlxQElrNWmEVWPsEisk9N4qu8odt5sl0qmCJ05Z7umWgP90li/HKFmuP2Qwybqiob0
         9CJFRJt28f2rO5QPrFYTuXgIBxevnm3eQufQgcAUS05KHyPRxWRGARYbIYfBjwATBOKX
         4K7e8cmUts1J17+vpY8Ncz0bJ2wfdX2GCxENfQWyVIayTQGpmI9CI7MvYURrN3XHeXo9
         hbcQ==
X-Gm-Message-State: AJcUukfjgYMOYLYIgAWPdyRibYJyfvQHY4+WpYM0FNS6qGyHFOf6fvcj
        xA2I27/497naA6/BD7zJgaLplQgAnoQ+uXA2WcgWNg==
X-Google-Smtp-Source: ALg8bN5Eg+4pTx1ZoFWSyQarPLhbSk7m/4U7YqVnqrpEinCGdjDy+5CqUYATXbkUJEsetm4YmQPWN/byKebmsxeDveo=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr24671950otg.139.1548885559725;
 Wed, 30 Jan 2019 13:59:19 -0800 (PST)
MIME-Version: 1.0
References: <1548865702-3524-1-git-send-email-dsmythies@telus.net>
In-Reply-To: <1548865702-3524-1-git-send-email-dsmythies@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jan 2019 22:59:08 +0100
Message-ID: <CAJZ5v0iXNfn9Bn7V-XApb6A3D43hsmir0m7zCyG5Rky=qAbZmA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: poll_state: Fix default time limit.
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 5:29 PM Doug Smythies <doug.smythies@gmail.com> wrote:
>
> The default time is declared in units of microsecnds,
> but is used as nano seconds, resulting in significant
> accounting errors for idle state 0 time when all idle
> states deeper than 0 are disabled.
>
> Under these unusual conditions, we don't really care
> about the poll time limit anyhow.
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpuidle/poll_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index b17d153..23a1b27 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -21,7 +21,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>         local_irq_enable();
>         if (!current_set_polling_and_test()) {
>                 unsigned int loop_count = 0;
> -               u64 limit = TICK_USEC;
> +               u64 limit = TICK_NSEC;

Good catch!

>                 int i;
>
>                 for (i = 1; i < drv->state_count; i++) {
> --

Applied, thanks!
