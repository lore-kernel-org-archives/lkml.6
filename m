Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB4FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F6720858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F6720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeGVIqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:46:25 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:45462 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728151AbeGVIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:46:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2F2C2182251AC;
        Sun, 22 Jul 2018 07:50:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lunch72_7851eb73bd90e
X-Filterd-Recvd-Size: 1876
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Jul 2018 07:50:26 +0000 (UTC)
Message-ID: <f512941f3dba2b5f3bf3434bb2b0b4b1602c5122.camel@perches.com>
Subject: Re: [PATCH] staging: dgnc: dgnc_tty.c: Avoid '(' at the end of line
From:   Joe Perches <joe@perches.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 22 Jul 2018 00:50:25 -0700
In-Reply-To: <20180722040912.GA18833@nishad>
References: <20180722040912.GA18833@nishad>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-22 at 09:39 +0530, Nishad Kamdar wrote:
> Bring the first argument to the previous line and
> align the other lines to match open parenthesis.
[]
> diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
[]
> @@ -883,10 +883,9 @@ static int dgnc_tty_open(struct tty_struct *tty, struct file *file)
>  	 * touched safely, the close routine will signal the
>  	 * ch_flags_wait to wake us back up.
>  	 */
> -	rc = wait_event_interruptible(
> -				ch->ch_flags_wait,
> -				(((ch->ch_tun.un_flags |
> -				ch->ch_pun.un_flags) & UN_CLOSING) == 0));
> +	rc = wait_event_interruptible(ch->ch_flags_wait,
> +				      (((ch->ch_tun.un_flags |
> +				      ch->ch_pun.un_flags) & UN_CLOSING) == 0));


This would be better without the superfluous () and perhaps use !

	rc = wait_event_interruptible(ch->ch_flags_wait,
				      !((ch->ch_tun.un_flags |
					 ch->ch_pun.un_flags) & UN_CLOSING));


